From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Specifying revisions in the future
Date: Sat, 04 Feb 2012 18:44:46 -0800 (PST)
Message-ID: <m3ipjmknhc.fsf@localhost.localdomain>
References: <jgjkk0$qrg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Paugh <jpaugh@gmx.us>
X-From: git-owner@vger.kernel.org Sun Feb 05 03:45:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rts6a-0008RZ-1r
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 03:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab2BECot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 21:44:49 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53011 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab2BECos (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 21:44:48 -0500
Received: by eekc14 with SMTP id c14so1707915eek.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 18:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZQN4zd44Zw+ipUQNWkfaFDu3IdS16TOX+6W9reQcIuM=;
        b=F155cm//YeA8Xa28hw8BzAqSt//PD9LNC0xHagG6edmxSBiwE3niXSb+6veVvsVBIv
         Al3fms5ORwhn44nzlEUU7W2ZJkcCrB2MojV1QF1q7B23Mof/Igzv0cATg4E0ddPezJAh
         P0acoBOa4rG+av2gm6X8/NajLSPDb9hnf/zh4=
Received: by 10.14.199.3 with SMTP id w3mr4046767een.61.1328409886958;
        Sat, 04 Feb 2012 18:44:46 -0800 (PST)
Received: from localhost.localdomain (abwp204.neoplus.adsl.tpnet.pl. [83.8.239.204])
        by mx.google.com with ESMTPS id a58sm42355780eeb.8.2012.02.04.18.44.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 18:44:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q152imhJ008295;
	Sun, 5 Feb 2012 03:44:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q152ilwn008292;
	Sun, 5 Feb 2012 03:44:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <jgjkk0$qrg$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189926>

jpaugh@gmx.us writes:

> Hello.

> I want to do a certain arbitrary operation for each revision between
> where I am now and the tip of the branch.
> 
>           v1.0-a     master
>             \          \
> o---o---o---o---o---o---o
>             |
>            I am here

That is the problem X.
 
> Is it possible to specify revisions in the future? The gitrevisions man
> page implies otherwise. Alternatively, is there a way to find out the
> number of commits between two revs---assuming one is an ancestor of the
> other?

That is your idea of a solution, Y.

You have XY problem.  You need to do X, and you think you can use Y to
do X, so you ask about how to do Y.

If you want to list all revsions between v1.0-a and master, use

  git rev-list v1.0a..master

or

  git rev-list --ancestry-path v1.0a..master

depending on definition of _between_ (see "History simplification" in
git-log(1) manpage for description of `--ancestry-path` option).

> 
> I've been using the following to do what I want:
> 
> ref=master; \
> for i in {5..1}; do \
>   echo; \
>   git log --stat $ref~$i^\!; \
>   read -p 'Full diff? '; \
>   echo; \
>   if [[ $REPLY == 'y' ]]; then \
>     git diff $ref~$i^\!; \
>   fi; \
> done;
> 
> which lists the log and diffstat for last 5 commits between master and
> where I am (e.g. an older tag/branch) with an optional full diff. I know
> implementing revision specifiers to the future is nontrivial. (I
> realized that when I considered non-linear histories.) In this case,
> I've distilled it to the point that all I need is the number of commits
> between two revs. Can this be had without manually inspecting git log?
> Or, is there a better way to get detailed diffs like this?

-- 
Jakub Narebski
