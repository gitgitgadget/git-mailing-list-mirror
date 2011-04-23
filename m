From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Sat, 23 Apr 2011 05:15:00 -0500
Message-ID: <20110423101500.GB1500@elie>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
 <20110421220327.GA3396@elie>
 <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 12:15:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDZs4-0004tx-E7
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 12:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1DWKPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 06:15:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38163 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1DWKPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 06:15:05 -0400
Received: by iwn34 with SMTP id 34so913202iwn.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=46EyFymYGAvFXLD6TtJJC4VFDwe8qOGySKrN/9SnIJE=;
        b=WCTNh1e+c3/PjcTMgoZUfyvBGXz0/y3NMUXYLkto+3n5dmK1pdLp6wi5QOgNmg6jqm
         fn8beDJQfBnMAkcQ92X/1sliqZqSbd9C/PweTjbYMll4B2tSToz+iXoVQtXsx0UME8Mu
         j5Vrwr+R8M2Ux+ZKWSOUfbWeWhfKUwjx3gJOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SrOjj1KsK/Up8GvXt7h77qy3/qthV6csFPGuXFWwq2TLTE9E1q+1Hwz5iE/9vrSQAs
         6I+aF8MMzmzZXKRkK3oTf7Sy1bGlir8bbU1PiDURwhqrOFLnJ6fIkbJuNFY5FEIvijPY
         n3JL8x+b77dekQZewRcdIJjED+sdu7J9YEGHU=
Received: by 10.42.157.67 with SMTP id c3mr2131760icx.95.1303553704950;
        Sat, 23 Apr 2011 03:15:04 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id f28sm1438844ibh.67.2011.04.23.03.15.02
        (version=SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 03:15:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171979>

Hi again,

Richard Hartmann wrote[1]:

> 1) git merge does not seem to understand either of those parameters.

I assume you mean --work-tree and --git-dir.  But if true, that would
be a bug.

Based on the script, it looks like you are not passing a branch name
to "git merge".  Maybe that is the problem.  In any case, it would be
nice to see what command you used, what result was expected, and what
result actually occured.

Side note: git commands respect the GIT_DIR and GIT_WORK_TREE
environment variables in addition to the corresponding command-line
parameters, which can save some typing.

[...]
> 2) running `git pull` as suggested results in:
>
> fatal: /usr/lib/git-core/git-pull cannot be used without a working tree.
>
> which can be worked around by using --work-tree and --git-dir . Not
> ideal, but workeable if I accept the race condition.

Weird.  Maybe chdir-ing into the work tree will help?  (Traditionally,
git commands tend to be run from within the work tree, so I wouldn't
be too surprised if some commands do not like being run from outside.)

[1] http://thread.gmane.org/gmane.comp.version-control.git/171920/focus=171934
