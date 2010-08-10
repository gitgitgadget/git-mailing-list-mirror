From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-notes: Run partial expensive test everywhere
Date: Tue, 10 Aug 2010 21:00:11 +0000
Message-ID: <AANLkTikO6_cBBywSdvSdpWNO8OgSzmp9EB-xQ7Y_s4qf@mail.gmail.com>
References: <1281470164-27008-1-git-send-email-avarab@gmail.com>
	<AANLkTim2tozO31HKLwxi6kWyZKYMd9egDhS5U_gb5OvZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 23:00:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oivvn-0005hZ-9j
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 23:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979Ab0HJVAO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 17:00:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34522 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757718Ab0HJVAN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 17:00:13 -0400
Received: by fxm13 with SMTP id 13so986709fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YW50Ac4U21Kq8ZEmZOw6KpWS6NSAfvKR/yrWUyvBJlk=;
        b=EjtJHcrQU1uu77BZbVp9jiMLsV/ehMnLyIIeUxtMl7Gu1r0NBbbbC6r5ijTkMPL49Q
         XPajesdUm/IVbQi+zlUhJsOZ6XZpPezsbJyX2TeRx5TcTBM91Wk/0Hs5/UpoW3UbxJGu
         koO5u8qdr1gwgGapf0yX9p5brPHmgJ9c6jVgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aDtWxsAKgUfRNEWYqaxrQSV/xll4EyA7zbFLevbUW9L0rE5hqy35qDG4JYCR68fbxf
         uMqN0tg2TOVSrKoqhXmDvOiv1D8bba/uA3ksRUyS0kWjvz8GKJ+QSSXddAS4QhB44/r4
         UkmQjuIWlanqFpVzIRB/ESsDEeYFM2OZWlPy0=
Received: by 10.223.122.146 with SMTP id l18mr18812405far.82.1281474011962; 
	Tue, 10 Aug 2010 14:00:11 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 10 Aug 2010 14:00:11 -0700 (PDT)
In-Reply-To: <AANLkTim2tozO31HKLwxi6kWyZKYMd9egDhS5U_gb5OvZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153159>

On Tue, Aug 10, 2010 at 20:29, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> Heya,
>
> On Tue, Aug 10, 2010 at 14:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> The git-notes expensive timing test is only expensive because it
>> either did 1k iterations or nothing. Change it to do 10 by default,
>> with an option to run the expensive version with the old
>> GIT_NOTES_TIMING_TESTS=3DZomgYesPlease variable.
>
> Nice, why 10 though? Any motivation for that particular value?

The old version had "for count in 10 100 1000 10000; do". Mine has 10
as non-expensive, and "for count in 100 1000 10000; do" as expensive.

I.e. I'm running the first test batch from the old tests.

I have no idea whether it actually needs to run 10..10k times, I
didn't try to grok the actual test code.

>> The old version would also mysteriously fail on systems without
>> /usr/bin/time, there's now a check for that using the test
>> prerequisite facility.
>
> Should this patch be split up?

It all touched the same bits, it'd be nastier to split it up IMO.
