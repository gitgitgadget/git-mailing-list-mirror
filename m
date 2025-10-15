Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017D29E0E7
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520579; cv=none; b=sMRtHbqo4HCko0wrqn5zYDdTUHrOjMjZ8nmfWzzrURLerzCyjT8gtCBcF+ufP0hRomi5sxsLvTWuaWaKDolvL5l8VEtTw2QVp9zJhu4DOGqxdhUCff4N9sz7+rOcEnO49p7qtv9bolG9P6Qc6NhBJ9eDL+Zwxm0cjzBwTxFDZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520579; c=relaxed/simple;
	bh=yxs005/s5Jj6duovvFOGdyd8ZyZRO1vJ31Yo2mL7zvI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2g5GYXSeaW7ZHHoP+FF3wfs7K+MhNKpgd/DKUCR9FMK7W3XEyeI00NoKuZvKD5eU8IBVYX/xtnqDhx3BNiL0v49ncUTAtAkpr+FLplDPkEYmOJCgzfBgLgTmenY3cD7y4BBA5lqaIR2T6qJ15XunE/FikPslIlHaKPYG2NAbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2L6KqiJ; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2L6KqiJ"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5997f407c85so2232217137.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760520577; x=1761125377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ta9WNQ46GtC6UNTZobf5cs4nJ36JCgxNBOOwOXuEPU=;
        b=R2L6KqiJX4Hv6u/N9f/9tvlSiiC48tyHYd9Z70/PoIylt/lmUdrO6ooQrlywFJYr15
         BprnjkwcEB7MdPOLeYCMZVU3ttOAsTonTb5XJw7VqGLMyyVV+BlwifBO1IR0XUHkvztQ
         qsiG1xStRg54jRbjZG3DUFOTeU4BtuUy1ol45dhKfRhqkMSJiP2OEJpiwiHu8zVYRV2S
         qMibSf5YTjVbhNTWJi8qwavwk7EeZ4Y4/N2xASPPk/KZ6lnacPVofc+LMCOZim65GbnN
         pDYRl5hcoZOq5zvLqiVbOHhpJRz8LkbPHA5gyRC/kXYyfz67h9+Ey+UyA7blzOVwmFzB
         VRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520577; x=1761125377;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ta9WNQ46GtC6UNTZobf5cs4nJ36JCgxNBOOwOXuEPU=;
        b=hn6EM754M8VD79GOWtIDba24fs8aec1Z11tupAyjMW1iYgPrLZ0Q2Qi/Y1Pin7NOVD
         DVIXJO+bezTB9RZlp1Ul+RrJeGKmFeDKcVe5mGL2/kNUFQ3Wxu9Ri3Bc/HcBQS9CqznQ
         jtmoBk2ZmSK2tnZkMOmOkogR8iS1zOLH5vOuD7IU5rCpIVWRecOlu3uV8eXN6Zcwf1Yi
         nNTIcuP87EYTZ5OV0GzdlK+Ds1Zfy7w5MEkKuVWgcaeX3jd2u0gsfLZWvqyumIPmSLSm
         OQZL7l5z246eRK+8fhzI6MAugjBCU8KD5qfMkkjU1/m8LK2+JQlGOf0msqbr4kBYncms
         9F7g==
X-Forwarded-Encrypted: i=1; AJvYcCWtbh+NieCchaKYvevYBQm4tncdhXUXXnws2r66Dwn+SctwfJv5/+UbzLxxZATeFh1TBLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMh/P7EM65Rjnl6lXDNREILAHAuIqN4ps5IQvAn+21/B7F6Fng
	jy2WQlRkfNSG/HQ0byQ/9GtQC0vGYFHmXNMT4avAMb12kaCEg6YGtB8+nvrh/XpEnt6X75MZRzx
	NMvab0Ye4tasM0DBGdT3vQ+3m5V53BZU=
X-Gm-Gg: ASbGnctiza/GtEB+xPigzN7m2u0H+5RqWMZZmFrTzDva+E9VqZHzuBW2+7nGXLXzSY6
	QT+njxcTnIVFPlBQi896E+mm7kJwKCzFj370l/sGG22EgV8gdidpBJ3CQ4tvakGYdsdHTgvpTN3
	Zb3CeAO6B/IWDX5M33nEOGL0+MDG91qqlfh+7nHOZyMaUKLzZ54mq5XbBSUaxbwit+YSgZpWb8U
	dd3pMMVUUQe9hP9f253KUeFehOPEt2L0XjO6g==
X-Google-Smtp-Source: AGHT+IEe9zPzPoBTdTYUsdnadfmqGku024Wt4MosYcGJaWlaMc+WVh+GwuoIQW9tdpG4G9fljOn6zuolxiRSClRhglE=
X-Received: by 2002:a05:6102:5f07:b0:5d5:f6ae:38d7 with SMTP id
 ada2fe7eead31-5d5f6ae3b70mr7335411137.44.1760520576716; Wed, 15 Oct 2025
 02:29:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Oct 2025 02:29:35 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Oct 2025 02:29:35 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQj20e_p99dzWjmrQ2i-RnLjsnEN9ihuDirV4iPN0QqPg@mail.gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
 <aOjsjpE1vuFUXXbh@pks.im> <xmqqwm4y538p.fsf@gitster.g> <xmqqh5w250lw.fsf@gitster.g>
 <CAOLa=ZTRG=x5PofmSSfHhJ3Lig2NjhU8buVWAXU=aKom2PDsDg@mail.gmail.com>
 <xmqqldldxtoc.fsf@gitster.g> <CAOLa=ZQj20e_p99dzWjmrQ2i-RnLjsnEN9ihuDirV4iPN0QqPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Oct 2025 02:29:35 -0700
X-Gm-Features: AS18NWBzDkZEkyodVlz5WcodOL9fofktcfBl5ozxgZvbZ6lIaRhMjjC89Xzmp7A
Message-ID: <CAOLa=ZRdxm787nE4FSr2VUHDB+hW06Ggc6yUcKmeTKAb6B7YOA@mail.gmail.com>
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000098736206412f23ba"

--00000000000098736206412f23ba
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>
>>>>> Perhaps "--check-" followed by a word specific to what we are trying
>>>>> to achieve (e.g., if we are trying to see if auto-compaction is
>>>>> necessary, "--check-for-auto" "check for auto compaction")?  I
>>>>> dunno.
>>>>
>>>> After reading what you did in the previou step, I am reasonably sure
>>>> "required" is a wrong word to use, with or without other words like
>>>> "check".  Semantically it is similar to the should_pack_refs() check
>>>> that we use for pack-refs even before "optimize" came.  We expect it
>>>> to answer this question cheaply: are we better off if we repacked,
>>>> or can we go on without repacking for now?  It is not about "are we
>>>> performing so poorly that we MUST optimize now?"
>>>
>>> I agree '--required' isn't the best name, and like we discussed
>>> '--dry-run' wouldn't be either since that would imply that the work is
>>> being done but not persisted.
>>>
>>> I was leaning towards '--check', which is simple. But It might be nicer
>>> to be verbose here and simply add something like '--is-worthwhile'.
>>>
>>> Being verbose here is okay, since it will only be used sparingly and
>>> specifically by those who require such a use case.
>>
>> Nah, "worthwhile" is relative and it would be less meaningful
>> without expressing for what goal we are judging how it is worthwhile
>> to do.
>>
>
> I see what you mean.
>
>> Choosing a phrase around "check" is better, I would think.
>
> How about simply `--check`. Since the flag can be used with other
> existing flags, it would make more sense to do
>
>   git refs optimize --all --auto --check
>   git refs optimize --check
>   git refs optimize --all --check
>
> I will send in a new version around this and we can discuss further on
> top of that!

After speaking to Patrick today about this and his work on 'git
maintenance', we realized we can actually broaden the scope. We could
implement something like 'git maintenance needed'. This would check on a
whole if repository maintenance is needed for refs and objects.

I do think there is some merit in some of the patches of this series, so
I'll spawn out couple of new series and send it to the list.

Junio, from your latest 'What's cooking', I notice that this wasn't
picked up, which is good. I hope its not too much churn in that sense :)

Thanks

--00000000000098736206412f23ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: db2dd96a59b8ad20_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdmFYNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0E4Qy85QWJsc1RXWjFNVXB6OTBHUGVEUEVQQzUwbApObEJ2TjFJaHgr
ZjBuRnhMYXN0N2l6QnFQNmVSc0VwRVhXN3B1Umx6Q1NWVkprNzlpTWJ5YmxQd2E2TnBFWmhmCjhw
eHZxeWd2aExIRUJCci9IU20zUjVpT0NURkJjM2lSOGV1ZDQ0Q2RFM05kcDBPRDBvcDVyQzdGamRO
YzR3TU4KTmQ2bFhNYVJDS3pxeUFhMWllWkViQi96VW5GT0VMdnlHcG1rZXFsejAybkMzOWN2QXJH
SVFhTnB0UnFjM1pFSQpUai9DS1paTnNmdjkrbDU3TFVmVU9Oc0lZNmdJUGo3Sk9sczNGTy9IMk1h
NVQxMTRCaHJrN2ZFSGxBeU9wSGR6Cmt2aTVyOWUxMUFQc0J5blZtYVBzRWdDWWFudHk1L1Yrckoy
VHRYVGNEa1duNC84OWFLNC9Zd1RRbUphSjhBTGIKNFh6WE52WGE5RWNKQVFFRTVvVDA3bUUrUDVI
STlCR1pONG50RXBzWm1wRnFGcGd3eHVOak5OeDhtemRadTBxawpHbFN6dzdTenhNUDM1a0g2bnV3
ZWdQTDJnQlMvQ1phRGxvS0FHcERZbGFPL1lZNVkwSVQ5Ylk0UnBVcWE3TU1CCmZCbkJXRDhUSVNL
OFBZQzNZRjdReWVQdW5EcVBCako0VUxYRXRnWT0KPVFYaWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000098736206412f23ba--
