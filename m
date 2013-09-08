From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 00:09:34 -0500
Message-ID: <CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908044329.GA15087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 07:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIXFx-0000Xm-4d
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 07:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab3IHFJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 01:09:37 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:47625 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab3IHFJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 01:09:36 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so3939052lbd.26
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 22:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sXl/njR0758gD7khS4gNJonDzA/KEXev89m159Jygzc=;
        b=TWnzbV1tD5+6eJFvPOvYicRqqWndK60kFBxuNvO3ip/9HdLVv7cweUljUsi23oVJhZ
         nVjWmcAr0V7vE2/DRtEgRPYYL1TWRiQb+lldfevILVN8aHYtvPMeqTN+TGT/B9uzKfRy
         VUA5tkXE8/L2JaPK6yYQmvpRq5G7pu8rvdjG2wPE0ddZg+v1VrtQHoJ57ZPtgqg1zTX9
         VaPlc+lLEXERU1Bi+LSq/6yXpiVLYIeKhRfqyvskbItieY7L73gxwbmvwCDros7FhZ1Z
         cHfYHRPWomUzSMKceNqCR7zT/QI5c5Kxk+dbx86dLqvFdMDF/QZxrkS6iC4AHfgTCKOA
         vHEQ==
X-Received: by 10.152.8.115 with SMTP id q19mr10269698laa.16.1378616974976;
 Sat, 07 Sep 2013 22:09:34 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 22:09:34 -0700 (PDT)
In-Reply-To: <20130908044329.GA15087@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234184>

On Sat, Sep 7, 2013 at 11:43 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 07, 2013 at 11:37:13PM -0500, Felipe Contreras wrote:
>
>> > By "svn-like", I mean the people whose workflow is:
>> >
>> >   $ hack hack hack
>> >   $ git commit
>> >   $ git push ;# oops, somebody else pushed in the meantime
>> >   $ git pull
>> >   $ git push
>>
>> But that's not svn-like at all.
>
> It's not if you understand the difference between merge-then-commit and
> commit-then-merge. But for a clueless user who has been told "replace
> svn commit" with "git commit && git push" and replace "svn update" with
> "git pull", it is quite similar.

Well, yeah, but if they are so clueless they have to be told what to
do, they can be told to do 'git pull --merge' instead, no?

>> > Those people would now have to learn enough to choose between merge and
>> > rebase when running the "git pull".
>>
>> But that's only if they don't care about the shape of history. In my
>> experience the people that cling more to centralized VCS do not like
>> merges, so they rebase everything to make it a straight line. That is
>> much more "svn-like".
>>
>> So chances are they are already doing 'git pull --rebase' (or
>> similar), so their workflow wouldn't be affected.
>
> I think we are talking about two classes of users. People who truly
> don't care about the shape of history will also not care about using
> "git pull --rebase", because the only reason to use it is to impact the
> shape of history.
>
> I agree there is also a set of people coming from the centralized vcs
> world who want to keep a linear history.

Yeah, and based on the evidence, one set of people is much much larger
than the other; the people that care what the history look like.

Either way, we can start by making it a warning, and then an error,
and if more people complain that they have to do 'git pull --merge'
now (I bet there won't be any), then you would be right, and we
revert. No problem.

-- 
Felipe Contreras
