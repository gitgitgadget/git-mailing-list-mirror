From: Yichao Yu <yyc1992@gmail.com>
Subject: Fwd: Remote hung up during `git fetch`
Date: Thu, 22 Nov 2012 13:39:09 -0500
Message-ID: <CAMvDr+QuMpfdTdkOMOiYyEnHvQjia2cDCt3sx2rQwwLcJiCVmw@mail.gmail.com>
References: <CAMvDr+R__wWRwm2xNC3-v0T1RVu_rKdjKUJhb8cHwEXvuX9OMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 19:41:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbbiK-0007Oi-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 19:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab2KVSjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 13:39:32 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36908 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab2KVSja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:39:30 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2367995iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=KQE/gL4x3109FdPl19XzP0E4csW8ir0KqZAW2Rh8GNU=;
        b=EiFw+lFGMM5HpVaGV9bjaOsHyUovNkMz4DDE73pXrAN/IY/VsZhj/ZwJSiQ5Hx+L0r
         7fCU87Xl3f4661zUy9mum6Rd8xL3DNsav5bj3kQWs2NBZGMQStYGDtowVMQeQ844Iavq
         QUjkZYutOmUzbuBfZsCgM85NfEVN8imBGPDi5M/z+b0WzOnYBMcOOTNWOKczvyJ8o4iE
         HTpe+mjPEVj6P8flnLIBpE7Gl8LYujIFiQQJgSoKplsjK0YKn21pcBnOH/jzHTwCB2wo
         4dJEuJn6UN83duQ2XRITBgVpMh67sbmf+euQUyqMNLCG7jBPXXAUJbLE/QCyUAito+jX
         8UcA==
Received: by 10.50.12.165 with SMTP id z5mr4067634igb.17.1353609570048; Thu,
 22 Nov 2012 10:39:30 -0800 (PST)
Received: by 10.64.15.165 with HTTP; Thu, 22 Nov 2012 10:39:09 -0800 (PST)
In-Reply-To: <CAMvDr+R__wWRwm2xNC3-v0T1RVu_rKdjKUJhb8cHwEXvuX9OMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210184>

Hi everyone,

I sent this email yesterday to the git mailing list but I cannot find
it in any archive so I decide to send it again.
Does anyone know what has happened to the mailing list? I haven't
receive any email from several kernel related busy mailing lists for
several hours....

Yichao Yu

---------- Forwarded message ----------
From: Yichao Yu <yyc1992@gmail.com>
Date: Wed, Nov 21, 2012 at 11:18 PM
Subject: Remote hung up during `git fetch`
To: git@vger.kernel.org


Hi everyone,

I want to build packages for snap shoot of different branches from
different remote git repositories in the same local directory (so that
I don't need to recompile everything everytime.) and I am using a
combination of `git clone/checkout/reset/fetch` to do that. However,
during git-fetch, the remote sometimes stop responding or simply reset
the connection. This happens occasionally at least for both ssh and
git protocol (not sure about http/https) on github, bitbucket and also
kernel.org so I think it is probably not due to a weird behavior of a
certain host. Does anyone know the reason or is there anything I have
done wrong? And is there a better way to set the local tree to a
certain branch at a certain url? THX

My git version is ArchLinux package 1.8.0-1. (timezone
America/New_York in case the time stamp somehow matters)

Here is a script that always triggers the issue (at least now) and
it's output. (No I am not trying to merge git and the kernel... These
are just random public repos on kernel.org that can trigger the issue.
Although I am pulling from two repos from different project here, the
same thing can also happen on other hosts when the two repos are
actually the same project)

Yichao Yu

------------------------------------------------------------------

#!/bin/bash

repo_name=git
# remote1='git://github.com/torvalds/linux.git'
remote1='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'
branch1='master'
# remote2='git://github.com/git/git.git'
remote2='git://git.kernel.org/pub/scm/git/git.git'
branch2='next'

git clone --depth 1 --single-branch --branch "$branch1" "$remote1" "$repo_name"
cd "$repo_name"
git fetch -vvv "$remote2" # "$branch2:$branch2"

-----------------------------------------------

Cloning into 'git'...
remote: Counting objects: 43215, done.
remote: Compressing objects: 100% (41422/41422), done.
remote: Total 43215 (delta 3079), reused 22032 (delta 1247)
Receiving objects: 100% (43215/43215), 119.06 MiB | 1.60 MiB/s, done.
Resolving deltas: 100% (3079/3079), done.
Checking out files: 100% (40905/40905), done.
fatal: destination path 'git' already exists and is not an empty directory.
Server supports multi_ack_detailed
Server supports side-band-64k
Server supports ofs-delta
want 2d242fb3fc19fc9ba046accdd9210be8b9913f64 (HEAD)
have ef6c5be658f6a70c1256fbd18e18ee0dc24c3386
have db9d8c60266a5010e905829e10cd722519e14777
done
fatal: The remote end hung up unexpectedly
