From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [BUG] git-gui regression in 2.0rcX within submodule
Date: Tue, 13 May 2014 20:30:56 +1200
Message-ID: <5371D840.2020208@gmail.com>
References: <20140512234518.GB5529@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Yann Dirson <ydirson@free.fr>, GIT list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue May 13 10:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wk87B-0001tM-CB
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 10:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759080AbaEMIbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 04:31:03 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:65504 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759058AbaEMIbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 04:31:00 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so11553pbb.7
        for <git@vger.kernel.org>; Tue, 13 May 2014 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=9pn8YtN6pzwZgmYATudZXafbOZntUmYmRvuRRuDYwqI=;
        b=RM0iDT4abHufhR1XIZuMcEc7Ppkk7vjGBK9RV2x7tsqzTeagweMcU9OYT9qlx1KIdF
         UIJXlY8mwUjLWwC+JwZyOoHGPwG4dVU/i0tvLrEuiSr0UF2qqaGbie6cNSLGDPYloPCN
         H4Tv4FJWZhrZ+fJAEzcrcTgbGnjZRQ/1K7mhSJNOb5hwYvjO357yQ52H4mHRVZU7cnXg
         nIMpfrXqi8yZm8TYLTeGXJLI7Ps39RK/eYUj9h3nWxxUBmrbaioGtMq2of0SkicM7Pig
         +VJdUgBKfa5yjLZd+YSow+zA6juYuEw9SIeltuuMFNhCZxq7at46nu8E8amDznlLDSCe
         FCCA==
X-Received: by 10.66.66.202 with SMTP id h10mr60409605pat.70.1399969860432;
        Tue, 13 May 2014 01:31:00 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id vg1sm26906825pbc.44.2014.05.13.01.30.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 01:30:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140512234518.GB5529@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248756>

Hi,

On 13/05/14 11:45, Yann Dirson wrote:
> In 2.0rc2, git-gui is unable to work inside submodules, where 1.9.2
> did not show such a problem:
> 
> 
> yann@home:~$ cd /tmp/
> yann@home:tmp$ mkdir foo
> yann@home:tmp$ cd foo/
> yann@home:foo$ git init
> Initialized empty Git repository in /tmp/foo/.git/
> yann@home:foo (master)$ git submodule add git://git.debian.org/git/collab-maint/tulip.git debian
> Cloning into 'debian'...
> remote: Counting objects: 317, done.
> remote: Compressing objects: 100% (199/199), done.
> remote: Total 317 (delta 184), reused 166 (delta 95)
> Receiving objects: 100% (317/317), 73.81 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (184/184), done.
> Checking connectivity... done.
> yann@home:foo (master)$ git status 
> On branch master
> 
> Initial commit
> 
> Changes to be committed:
>   (use "git rm --cached <file>..." to unstage)
> 
>         new file:   .gitmodules
>         new file:   debian
> 
> yann@home:foo (master)$ (cd debian/ && git gui)
> [errors out after showing the following error dialog]
> 
> | No working directory ../../../debian:
> | 
> | couldn't change working directory
> | to "../../../debian": no such file or
> | directory
> 

I've already reported the same issue[1] and have posted a possible
solution[2] although I haven't seen any feedback from Pat or anyone else.

> 
> strace shows the failing chdir call is from git-gui itself, after
> getcwd() told him that it is in the dir that is indeed the workdir
> already.
> 

--

[1] - http://article.gmane.org/gmane.comp.version-control.git/247511
[2] - http://article.gmane.org/gmane.comp.version-control.git/247564
