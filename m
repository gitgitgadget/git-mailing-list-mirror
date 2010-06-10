From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-am: Ignore whitespace before patches
Date: Thu, 10 Jun 2010 17:03:57 +0000
Message-ID: <AANLkTikgWsumvqwicvOW8keGgvrgak8D6HXCGQ3wqHG6@mail.gmail.com>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
	<7vd3vyn84j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 19:04:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMlAp-0001L8-B1
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 19:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759382Ab0FJREB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 13:04:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47871 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab0FJREA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 13:04:00 -0400
Received: by iwn37 with SMTP id 37so138859iwn.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sjkHjmKpBe4FcKi4HRcj/rQP7e9oIOBVEYOz8fDVFiw=;
        b=IlrA6LGnJ9RYHF6J0tNPW303eSjGiXTSpbw10NulRqZ0a848bJj6xWlrdmM5MpEuJ1
         pkoT/QeSz9URsBTKm0pBEtWeL+WcSTSvBCh9oY8Jhu+mZNGWE9RgI9BVISZVqBs3C2XJ
         hEkCmn9suCcmwOHE4jy4XjbnSilmjs48OlPs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PY1202JOP/oFRY7JIt0kJ8CegBKxh/XoZArJuH5Z9IKhLZNLrB+5az1C5uRWX+X45g
         IrgxELdRF7pjWQzQQxL0FEGQSn8VUMR0wGTCG6qrXyfQ9ScF3SQk7Or6bKgcO2OT8kvT
         Ms5KNqzQAYcJs14PI39Jw6GYyJxJYTEHYQbcc=
Received: by 10.231.196.221 with SMTP id eh29mr395512ibb.180.1276189437775; 
	Thu, 10 Jun 2010 10:03:57 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 10 Jun 2010 10:03:57 -0700 (PDT)
In-Reply-To: <7vd3vyn84j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148892>

On Thu, Jun 10, 2010 at 16:51, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Change git-am to ignore whitespace (as defined by sh's read) at the
>> beginning of patches.
>>
>> Empty lines are wont to creep in at the beginning of patches, here's
>> an example from a raw Gmail attachment:
>>
>> =C2=A0 =C2=A0 20 20 20 20 20 20 20 20 =C2=A020 20 20 20 20 20 20 20 =
=C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
>> =C2=A0 =C2=A0 20 20 20 20 20 20 20 20 =C2=A020 20 20 20 20 20 20 0a =
=C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .|
>> =C2=A0 =C2=A0 52 65 74 75 72 6e 2d 50 =C2=A061 74 68 3a 20 3c 61 76 =
=C2=A0|Return-Path: <av|
>>
>> Whitespace is also likely to appear if the user copy/pastes the patc=
h
>> around, e.g. via a pastebin, or any any number of other cases. This
>> harms nothing and makes git-am's detection more fault tolerant.
>
> Actually cut-and-paste is often a major source of whitespace breakage
> (including tabs silently being expanded), and I personally think a pa=
tch
> like this to encourage the practice is going in a wrong direction.

It doesn't encourage that copy/paste. It's just tangentally mentioned
in the commit message since it's a plausable use case.

What it does is enable the GMail -> download -> git-am workflow. GMail
(and doubtless countless other) E-Mail providers introduce whitespace
at the beginning of raw E-Mail messages, while otherwise leaving them
intact.
