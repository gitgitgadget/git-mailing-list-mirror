From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 01:17:42 -0500
Message-ID: <CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908044329.GA15087@sigill.intra.peff.net>
	<CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
	<20130908052107.GA15610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 08:17:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIYJf-0007j0-OO
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 08:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab3IHGRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 02:17:44 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:63339 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab3IHGRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 02:17:43 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so4011590lbi.39
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 23:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YVpsmh6hHQ46oWkNguq7uuhi8GIat61M9hPo46ug7j0=;
        b=KqV9BNzBYCShXPNloQS1mIgkI2VFKrB6OO702rBFOF/92bJaC5AuK0jOaP3CeQnMRV
         JiAr1n3k0sAg4TCT98lYgmXjT8twKSqR1EDPIQVcWZ5K+xO7EtpCba+3XuqdTkqhzcx3
         TSTHowUuzOxpQQ96bJUSLYiDRyYOR4jlnWEz7sSjHcxB1BL2TA0raAfnz2ya8yhB+w78
         CL06Cq/qKKA8U1LbwsDk9lQrGKvoaN0mPWs2Ta6vmgvC+vU/mLxuMNLhy69EIC/gLdjk
         Y6VklbfAAo5jTsKOgXH1NxrYd9ZYlqlGVA930x03+hktQVBOfwNvP1bysa8QHCQrP5qv
         QGXQ==
X-Received: by 10.112.149.197 with SMTP id uc5mr10342277lbb.19.1378621062255;
 Sat, 07 Sep 2013 23:17:42 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 23:17:42 -0700 (PDT)
In-Reply-To: <20130908052107.GA15610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234189>

On Sun, Sep 8, 2013 at 12:21 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 08, 2013 at 12:09:34AM -0500, Felipe Contreras wrote:
>
>> > It's not if you understand the difference between merge-then-commit and
>> > commit-then-merge. But for a clueless user who has been told "replace
>> > svn commit" with "git commit && git push" and replace "svn update" with
>> > "git pull", it is quite similar.
>>
>> Well, yeah, but if they are so clueless they have to be told what to
>> do, they can be told to do 'git pull --merge' instead, no?
>
> I think it's fine to tell them to do "git pull --merge". What I'd worry
> more about is somebody who is suddenly presented with the choice between
> "--rebase" and "--merge" and doesn't know which to choose. We've created a
> cognitive load on the user, and even more load if they choose --rebase
> and don't quite understand what it means.

If that happens they will go back to the guy that told them to run
those commands.

Fortunately there probably are very few of these users.

> The current warning message in jc/pull-training-wheel is quite neutral
> between the two options. Perhaps we should lean more towards merging?

I don't like that message. I would like this for the deprecation period:

"The pull was not fast-forward, in the future you would have to choose
a merge or a rebase, merging automatically for now. Read 'man git
pull' for more help."

Then when obsolete:

The pull was not fast-forward, please either merge or rebase.

"Any more babysitting with essay long messages is counter-productive
to the vast majority of Git users."

> I guess that works against John's case, though, which is clueless people
> working on a project that _does_ care about the shape of history. At
> least they would have to stop and think for a moment, though, which
> might help (and maybe convince them to ask more clueful project
> members). I don't know.

Or google 'git pull' 'git merge' 'git rebase' or 'git non-fast-forward'.

-- 
Felipe Contreras
