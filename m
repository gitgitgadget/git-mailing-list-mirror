From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 03:09:34 -0500
Message-ID: <CAMP44s3s_Tg=FX8emOC1Gs_LqPU-i-mWNswoOT82MkNBUUsjUA@mail.gmail.com>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
	<5194921F.4080103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 16 10:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctFu-0002gZ-Kt
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab3EPIJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:09:39 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:37625 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab3EPIJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:09:36 -0400
Received: by mail-lb0-f172.google.com with SMTP id y6so2818563lbh.3
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=FVOOWrdF6ogHOtke3EUjTe1dKCCntQpvJ0hPdsuETjA=;
        b=vBC7AbkplfdmTkwQK/IaDRWOaL0cQAPwwx7ASBvFjl7ujlYBfhcrDd9hvPY5BWJfd5
         vXiqcBMfWs8F3IjCqQHvZTbpeOpIVY+EEevd65XS+aDRreXhfo8WSHOEXWvXYtV9j5sP
         +tea1JFceDNEKBqsZ7AoeaFbMp0K0SZ8Jh0yQW3pWY0/xAMivHvc9ZRhEGO4FeIL93su
         K15CAMF/q9AGDy5jhOLYgV98vJ3489PpXFGFz9xr28TsXS6u5gp/FQqX/zwklbZ2Ch9u
         UHJK6ef/dHaCp8N6N++nS7Lran4CAh+/h5ADzQVMZDSBuEQ2bLh3UUcq7AXv/ZTd2T8X
         ISgw==
X-Received: by 10.152.19.98 with SMTP id d2mr6214520lae.19.1368691774979; Thu,
 16 May 2013 01:09:34 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 01:09:34 -0700 (PDT)
In-Reply-To: <5194921F.4080103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224494>

On Thu, May 16, 2013 at 3:00 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 16.05.2013 09:48:
>> Showing the tracking information for all the branches takes significant
>> amount of time. The user might not want that. The --no-show-tracking
>> option allows that.
>
> I really like the idea of allowing that - not just because I've
> suggested so myself in the past ;)
>
> I feel, though, that we're really exploding our option and config realm.
> For "git branch" in list mode, we are already able to stack "-v", i.e.
> "-v" and "-vv" do different things. How about maybe adding "-vvv" and
> arranging things so that the verbosity and the run time increases with
> the number of v's?
>
> -v list with sha1 + subject of last commit
> -vv add upstream branch name
> -vvv add ahead/behind info (the only costly mode)
> -vvvv same with "--cherry" (ahead/behind/same)

Yeah, I thought about that too.

> Or maybe combine the middle two cases into "-vv", which means it would
> be the same as "-vv", with only "-v" changing what it does now.

Please no, I would like to see 'upstream', but not ahead/behind info.
In fact, that's my whole motivation behind this patch.

> Yes, this changes current behavior (at least fpr -v), which sucks
> anyways because of the costly lookup. And those scripting around "branch
> -v" should get what they deserve. (I may sound annoyed by our
> compatibility brakes, but here's a case where breaking it should be OK.)

I also agree that it would be OK to break this.

Alternatively, I've been thinking that we should have a v2.0 mode, or
a v2.0 branch, where all the compatibility breakage things go. We have
been so careful at not breaking things, that we have been too good at
stacking hacks and configurations all over the place, and in my
experience it's not unusual that right after an incompatibility
release, someone realizes that we forgot some compat breakage things,
and oh, well, maybe for v3.0.

The ones I have in mind are:

color.ui=true
merge.defaulttoupstream=true
format.coverletter=auto
branch.autosetupmerge=always
mergetool.prompt=false

Cheers.

-- 
Felipe Contreras
