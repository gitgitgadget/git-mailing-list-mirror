From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Unexpected "clean -Xd" behavior
Date: Wed, 18 Jan 2012 18:29:04 -0600
Message-ID: <20120119002904.GA14107@burratino>
References: <4F1384AE.1050209@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 01:29:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnft3-0004JJ-EB
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 01:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab2ASA3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 19:29:17 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:41352 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754402Ab2ASA3Q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 19:29:16 -0500
Received: by obcva7 with SMTP id va7so7980266obc.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 16:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IJF1xySd8CEOV2kJ9+ooi6oXANjggFKQe2BJPmf5URE=;
        b=DrY6cAYK6/DkYGaUwiQmKagEBNuGUokqruqWDaooDW0U8ddI59m/hZun8PTq8YRA/2
         j05SEy6sltrv/OIOlkYS1qB/P9abQvQqAGC59Vv3EF0IH3xk5wBA+JMbCSTQQZQQfB2+
         OT1Bdq4y41Xagz95ccRrrYRt51Aunoq1ubKAE=
Received: by 10.50.193.229 with SMTP id hr5mr24885816igc.15.1326932956191;
        Wed, 18 Jan 2012 16:29:16 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x18sm94599328ibi.2.2012.01.18.16.29.14
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 16:29:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F1384AE.1050209@pcharlan.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188782>

(+cc: Duy, Shawn)
Hi,

Pete Harlan wrote:

> When a directory contains nothing but an ignored subdirectory, that
> subdirectory does not get removed by "git clean -Xdf".
>
> For example, in a new directory:
>
> # git init
> Initialized empty Git repository in /tmp/foo/.git/
> # echo a/ >.gitignore
> # git add .gitignore
> # git commit -m "Initial commit"
> [master (root-commit) c3af24c] Initial commit
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 .gitignore
> # mkdir -p foo/a
> # touch foo/a/junk.o
> # git status
> # On branch master
> nothing to commit (working directory clean)
> # git clean -Xdn  # <--- DOES NOT MENTION foo/a
> # touch foo/x.c
> # git clean -Xdn  # <--- DITTO WITH UNTRACKED IN foo
> # git add foo/x.c
> # git clean -Xdn  # <--- WITH TRACKED IN foo, WILL REMOVE a/
> Would remove foo/a/
> #
>
> Is this intentional?  It's interfering with my using "git clean" to
> remove built objects, which happen to be in a dedicated temporary
> subdirectory.

Sounds like a bug.  Duy, Shawn, any hints?

Thanks,
Jonathan
