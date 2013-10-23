From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Finding the repository
Date: Wed, 23 Oct 2013 15:49:06 +0700
Message-ID: <CACsJy8DgxpjasroZv4iqTn9JhQ_3r2DD9uEf-xL-uyyPOtWh+A@mail.gmail.com>
References: <5267804b.JaxQnlQ5Cx+By4RS%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Perry Hutchison <perryh@pluto.rain.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 10:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYu8N-0005xF-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 10:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab3JWIti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 04:49:38 -0400
Received: from mail-qe0-f54.google.com ([209.85.128.54]:63722 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab3JWIth (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 04:49:37 -0400
Received: by mail-qe0-f54.google.com with SMTP id 1so277992qec.27
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=X4CIsiraw5Q2j5Ef16i5bAT4Xl5edXsZPa0yUHhCWsY=;
        b=HiNqNhvBIJQTSdgaD9HwO6Axv6QA89lF7B74J11NH2en3qhhSZBx8rouhqyHqW97bj
         Qqbth0tKt4N26Q6I1kDBR90+TQXAEMWRgCYnVOwiYEMGz11YQwqg2XF/HI8p2JQPGNkX
         RMxIc4kKae4Op4z8cPP7PVRd6xpEVIQK2yKHZiIDxW7Yu0Xom2OyHQtrfgShF+TdhlQy
         zr+EnFfa52I0/tPyUTnCM+XKU18g+l71c7EBomWP/IP0PDxAkq8MdTCpmeApVSmXFyv4
         5iP+bgHKDSsMSu9t/FJi8BDhBmi83K3J2zpqCimcvw7PHvn9KYcPEX+4S326igSUjeIX
         ERyQ==
X-Received: by 10.224.79.12 with SMTP id n12mr450679qak.109.1382518176864;
 Wed, 23 Oct 2013 01:49:36 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 23 Oct 2013 01:49:06 -0700 (PDT)
In-Reply-To: <5267804b.JaxQnlQ5Cx+By4RS%perryh@pluto.rain.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236504>

On Wed, Oct 23, 2013 at 2:52 PM, Perry Hutchison <perryh@pluto.rain.com> wrote:
> At least in version 1.7.0.4, it seems git does not like being run
> from outside the repository, even if the file(s) being operated
> on are inside the repository, unless it is given a pointer to the
> repository via the --git-dir= option or the GIT_DIR enironment
> variable.
>
> For example, suppose /foo/bar is a local repository and baz.c is a
> file in the outermost directory that I want to remove.  This works:
>
>   $ cd /foo/bar
>   $ git rm baz.c
>
> but this, which intuitively should mean exactly the same thing,
> fails:
>
>   $ cd /foo
>   $ git rm bar/baz.c
>   fatal: Not a git repository (or any of the parent directories): .git

I share your pain. In my case I hate to go inside a directory just to
grep something. In my opinion git should be flexible and work at least
in unambiguous cases. But it's not easy to determine ambiguity here,
especially when the repo finding code does not know anything about
"bar/barz.c" (is it a pathname or an argument to an option?). There
are more cases to consider, like what if you do "git rm bar/baz.c and
rab/zab.c" where bar and rab are two different repositories.. And the
setup code is not exactly easy to add these stuff in..
-- 
Duy
