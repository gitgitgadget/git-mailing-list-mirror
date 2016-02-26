From: Stefan Beller <sbeller@google.com>
Subject: Re: Rebase performance
Date: Fri, 26 Feb 2016 09:15:05 -0800
Message-ID: <CAGZ79ka5qTGuLOz3mMr0s=8yOF7LR0iRDhf9jy38GBppOhzD6Q@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
	<CACBZZX7rVAdzfCm=0FdrCXSx8a2=a8n7pjq1ZSW-V3fzmaSGWw@mail.gmail.com>
	<vpq37sg4s0l.fsf@anie.imag.fr>
	<alpine.DEB.2.20.1602261644570.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:15:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLz1-0006KQ-EF
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 18:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbcBZRPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2016 12:15:08 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34589 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671AbcBZRPH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 12:15:07 -0500
Received: by mail-ig0-f179.google.com with SMTP id g6so42989089igt.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 09:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=AaNR/ECWDOT0XSfxSN3sGvaXBvV2jRR9qMHYES6SASU=;
        b=h/Az2ltOrYhOa91B8Io0D0jkAhEmbJ7x6E75iramVj9BFtjpRMwD4nFnUqkAz683s8
         +urdyyRABNtAxJQ5lN5BiMFMUPSdByaSMMisNvDxRRRnOj0tVqiENYonQyAKmZolGrYm
         hCvyfeDTQ6YgKqQBYLUx5i5rmo0sMMrrJW3T+34Vy3Co3rWCjxEk232alnDbCh3HHh5q
         +MFVhqu/kvoGvcZKIfkdUNrzdE6m5C63bjY97IdVvU7w+aw75BSDBma8J+bS3kIOALlH
         kHP1R/0JP5hR0DJwLBdHkiexuwsTcmPWS6h3/LLlfC3NAM1I081hbHFLTg0S1eXUuUDd
         sm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=AaNR/ECWDOT0XSfxSN3sGvaXBvV2jRR9qMHYES6SASU=;
        b=ifZb8xPczbWe3QmZNeLyJ4ZkKqtXvUxnmZcbrmlbQ6a9tk6xI5AVqVwCPg9BupwZkr
         VqOSsAsPmgQQWy5DURHFqadmnKWJdiS+5QOUyoX558yIAgh2n58ROTS+s0adhWdL4TqH
         d3PP6QB0tdsC07WspACMEEIzFgD6UuMFU6aKO4L7UbGsDaCOVkrudxj1Q8vZr07DyQSi
         /pU6Xp/B042yY74F1NZCa4rgdQwp/YIjQMXZDcDc1XAoBVeiwxT8TfV8BIV6mHQVW9iT
         m/7xUnSF3DjcIn+9AfIw0gtbudTJmet2bIsZB63q2hglVNKrRnl8jMeY/8bbQFRtSvOc
         cMvg==
X-Gm-Message-State: AD7BkJLM81jXqWayI5mJL/fQLVw1UjTyMHQCQ7TEyJvdo/2o8/pF4HhOYYyW47vQKwLYbwFGff6nYZiwe2FjI3At
X-Received: by 10.50.176.226 with SMTP id cl2mr3913135igc.85.1456506905845;
 Fri, 26 Feb 2016 09:15:05 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Fri, 26 Feb 2016 09:15:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602261644570.3152@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287595>

On Fri, Feb 26, 2016 at 7:45 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Matthieu,
>
> On Thu, 25 Feb 2016, Matthieu Moy wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > At the risk of derailing this thread, a thing that would make reba=
se
>> > even faster I think would be to change it so that instead of apply=
ing
>> > a patch at a time to the working tree the whole operation takes pl=
ace
>> > on temporary trees & commits and then we'll eventually move the br=
anch
>> > pointer to that once it's finished.
>> >
>> > I.e. there's no reason for why a sequence of 1000 patches where a
>> > FOO.txt is changed from "hi1", "hi2", "hi3", ... would be noticeab=
ly
>> > slower than applying the same changes with git-fast-import.
>>
>> Also, not touching the worktree during rebase would have the advanta=
ge
>> that if the final result doesn't change a file, we wouldn't need to
>> touch this file at all, hence the next "make" (or whatever
>> timestamp-using build system the user runs) would consider this file
>> unchanged.
>
> We still have to write all blobs. So I would still expect this to be =
I/O
> bound.

But if there is an IO bound process, the only way to make it faster
is to reduce its IO, which was the proposal here? I agree that it proba=
bly
is not enough to shift it from being IO bound to say CPU bounded.

Thanks,
Stefan

>
> Ciao,
> Dscho
