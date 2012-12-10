From: "Matthew Ciancio" <matthew.ciancio16@gmail.com>
Subject: RE: Feature Request - Hide ignored files before checkout
Date: Mon, 10 Dec 2012 13:01:05 +1100
Message-ID: <000001cdd67a$39be9d40$ad3bd7c0$@gmail.com>
References: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com> <CAH5451m-JcgLtvVER1UgvsFzemb=otG3XttR4j2s=eFnPrPyEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Andrew Ardill'" <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 03:01:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThsgW-0004vP-UH
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 03:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826Ab2LJCBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 21:01:16 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37583 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab2LJCBP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Dec 2012 21:01:15 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so1527009pbc.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 18:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-type:content-transfer-encoding:x-mailer
         :thread-index:content-language;
        bh=cyoeZo+yMVfJs5/pivXJC1k/OgMIU9igmtm5JtMfZ+U=;
        b=FHFfn2uK53pjt7n1iRHtQmqGmMR6itPZj24js2JJ2ueVQ7P2ViO1/Yoblv7Hiq6Jta
         7Rleg+Ty4Vuw3T15vFUv4C3+S0/80rkwpAnWtRFMkTtE4+AN4u5xlUGqymg3PbqehU0a
         tmnpDT3FRaFXFEW44Y0RRv+yd9OdJkJ7YtCrX6QQ96zrB67qSvMOLKxHJ1MAkv8HKeXh
         JzIvCVuaL0dwGC4S2Hybxp93nHUwIWMBekdFNnY73PtJkrw65CQrBlQrGTmIjEUD8Uow
         i/HVkRYoj2Cf6gXhRsVGN2ndFxrb3qazncQOhr/P4yBIgDOi7Bz/oP5y/R1bo3yF43Qo
         0eTw==
Received: by 10.68.132.232 with SMTP id ox8mr35144451pbb.46.1355104873142;
        Sun, 09 Dec 2012 18:01:13 -0800 (PST)
Received: from MattPC (CPE-60-225-40-254.nsw.bigpond.net.au. [60.225.40.254])
        by mx.google.com with ESMTPS id kl3sm3594446pbc.15.2012.12.09.18.01.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2012 18:01:12 -0800 (PST)
In-Reply-To: <CAH5451m-JcgLtvVER1UgvsFzemb=otG3XttR4j2s=eFnPrPyEQ@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHMNWi7KxtTHnq09qgMXBkE3T5YpgDzDzKdmAzvXIA=
Content-Language: en-au
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211247>

Thanks for explaining that Andrew. I guess that was my intention: to have an "ignored file snapshot", but I can see now that it goes against Git's definitions and is not really needed.

I have overcome the problem by re-organising my repository and "... using more 'traditional' git workflows.".

-----Original Message-----
From: Andrew Ardill [mailto:andrew.ardill@gmail.com] 
Sent: Monday, 10 December 2012 12:46 PM
To: Matthew Ciancio
Cc: git@vger.kernel.org
Subject: Re: Feature Request - Hide ignored files before checkout

Hi Matt,

On 8 December 2012 11:50, Matthew Ciancio <matthew.ciancio16@gmail.com> wrote:
> Problem: ignore.txt does not "disappear" like foo.txt does and is now 
> just sitting in branchA (and now any other branch I checkout into).
>
> When I first started using Git, I genuinely thought this was a bug, 
> because it seems so logical to me that ignore files should 
> hide/reappear just like tracked files do, when switching branches.

Let me address this by asking a few questions; *why* do files hide/reappear, what is the mechanism behind that and does it really make sense to apply it to ignored files.

For each commit, git stores a snapshot of your files. When we switch branches we are telling git to restore the previously saved snapshot so we can work with those files. This means resetting the working directory so that it looks like what we had committed; git will delete files that were part of the current checked out snapshot but not the new one, and create files that need to be created. As a convenience to users, files that are not tracked are left 'as-is' when switching branches.

So we see that in order to hide/reappear a file it has to be tracked in a snapshot, and so has to be committed *somewhere*. An ignored file is by definition not included in commits, and furthermore you hope to keep these files out of your commit history.

> I have been told ways of circumventing this (using commits and 
> un-commits OR using stash), but my reason for avoiding commits is: say 
> you have binary/OS specific files which really do not belong in the 
> commit logs (even locally) and hence should be ignored. What if you 
> want those files in only one branch and not all?
> Stashing doesn't seem appropriate either, because it would get messy.

I am not sure how viable a suggestion this is, but perhaps you can have two separate repositories, one tracking your standard branches, and another tracking the ignored files. These repositories could be kept in sync through submodules or some similar mechanism. This could also allow you to, for example, publish the histories of these independently, for example releasing the non-ignored repository publicly.
I haven't heard of anyone doing this, but if you need to keep the history clean it might be a way of achieving it.
I also don't know what the implications of checking out two repositories into the same tree might be, or even if git would allow it in general (maybe if you ignored everything belonging to the other
repository?) In any case, this solution could quickly become messy, but if carefully controlled might solve your problem. Then again, maybe you can achieve what you want using more 'traditional' git workflows.

Regards,

Andrew Ardill
