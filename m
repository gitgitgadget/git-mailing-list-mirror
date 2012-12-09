From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: exit code from git reset
Date: Sun, 9 Dec 2012 15:12:29 -0800
Message-ID: <CANiSa6gPGGDWxpWGsjX0dgBA_SB7-gRKPb5o7EfK0h+DOZauYw@mail.gmail.com>
References: <CANiSa6i0LXE18Pyb5norRTm7PM+TMo3JvxDjoS5JOWt_qjHLHw@mail.gmail.com>
	<7vzk1mddzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 00:12:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Thq3E-0001nJ-GG
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 00:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab2LIXMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 18:12:31 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45984 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab2LIXMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 18:12:30 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so6816903iea.36
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 15:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FoVf008U7fJDiFahFm2CP2KeZATAnEARPIsFKqPyGUs=;
        b=eDbKs0kQ2Ra6M3Heut7WYsNWmIFk2ZOH8FjDMog103WG5mcDU/sWpvTs/txhw2VvyG
         gyNLAHAmEWVan/P31c7G4YOteCWTbaLSkAKbLJNowCDhgRskRTAFpLbNQIipv7Elk5qb
         u6jdfWf4dMIFpyOWWvYlGlwr5o+MuGyczFKj8Uk3GiyyWA/3Z+9hhJVtGEZS5qUyqoRx
         0kummNSKKk4QmR/aSMT07QmA7LOVkTHrGLKYLnzEQp6USDQvdq8Rua40WeeoF7A/0UlX
         28Er8EahykyOSO/Nd7pAPCCO2JNI0rj1DejEN98L78AHH10bDiLkGdXe3Tzs+sErRJYH
         MnHw==
Received: by 10.50.7.234 with SMTP id m10mr4971895iga.43.1355094749840; Sun,
 09 Dec 2012 15:12:29 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Sun, 9 Dec 2012 15:12:29 -0800 (PST)
In-Reply-To: <7vzk1mddzo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211245>

On Sun, Dec 9, 2012 at 3:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> "git reset" currently returns 0 (if successful) while "git reset
>> $pathspec" returns 0 iff the index matches HEAD after resetting (on
>> all paths, not just those matching $pathspec).
>
> So in short, you observed that either of them reports with its exit
> code if the resulting index (not just any subpart, but always the
> entire thing) matches the HEAD, e.g. "do we have change that will be
> listed on 'will be committed' section in git status output?"
>
> Sounds like one sane and consistent semantics to me.

Heh, true, the behavior according to my description does make sense,
it's just that my description was wrong; sorry :-(.

What "git reset $pathspec" returns is not "whether HEAD differs from
index" (as I wrote), but "whether worktree differs from index". So
"git reset" and "git reset ." will return different exit codes if
there are changes in the worktree as compared to HEAD before the
invocation. I hope that's clearer.
