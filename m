Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6778F6F
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011137; cv=none; b=WitizlQzhZiyJUKglOPw8G88LYMozkjUpnFYlxEL/cwTgSadvTyHNG67DdDUPxGC9eGHAqoqCK3ShgSGXPi3SAjb8BUQBov2MxexW2l3o39VQ1wHxsFl6WOXnVu3nu419KZLNnVRzLitYYJfc5JW4IgRawj+DNkkw4HHE3MmwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011137; c=relaxed/simple;
	bh=QXdzAeKguYU0SWcN7mktqfao/5on0Y+5D098Alnec1U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaU0uNdg5L9YnM3G8SpUJOTc9Rts6LZnYlKlVVw4QK3/rHKX7z03+T5vnfzfQ2Dsr4E9aSNKkPvbWDFWw+u+B4VbWRtcTfmvasVHA4PFXD+49/Pzs+LEPhaqYdv2NnA70duCOSRJ/WZL2a2GsAFmnMTnO0itBaXIDXiYjEu4ARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhjXrUbd; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhjXrUbd"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2220a389390so2038177fac.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712011135; x=1712615935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hd2gGATk0agFxdYN63SVt8IPRHc3ep+njksetxinQfU=;
        b=nhjXrUbdf7AkXDp5z7FCuqx8mSXMsvNMCv1/U9nsejF5tR/45beouQhedTb7oAnmBW
         7x1WLW4gZFK3R+e/mouK9u+5DmaD1nVwYCdTnZeMHrpwoAxjak3Y3/ob3zkpMdWROYH3
         jfLAuXQ3xgZHk1h1o8N8Ds4rNe3O/vsk9N6vl+9s8CTRlxmdnFbvq4iu917bEEEE7BlA
         UJxN6Syy3s0nqhooV+nxzzPt/YczTNfl9c1F6VAV7v75uHoJy5xVkkbhxVk4dhLPxwaK
         39htbzrHNNhXtXvTtBU7VzZ+5VbeCdUmaFm1BEdQuwMnv+70RtQxJrZmf5ZO9zukABGU
         Rr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712011135; x=1712615935;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd2gGATk0agFxdYN63SVt8IPRHc3ep+njksetxinQfU=;
        b=wRe0wYXRL5hoGG04orvkLM1qkLYBPM23qqRj/sKEKIUSRGlSY9kwuBWK8XjZyRlgLS
         yJwoC/xyAWbVsUsLmbbNBnkE9xkjXhsPthycbhwo+3V6IKciY7IisPpK8LU/cF35paoi
         9Trd72nPGCMFnPhfCHlWSdSFb3vHWUNXFmd/FzMBx1hPcRiYzqEqhPBvGkSURAFk9kMQ
         vgKlhW4+XAqYi7AAOXBqdM1XslF5939EpeiR9VODzivckM7pEj+D3k+NzRm4Cul/Ms3/
         NUwvknujatjFBjD/8dYI/0lex8hqrvBIJ6lbo1mLWq6l5RTh/EukD8TQAI8gtQ0hjzs4
         CY5w==
X-Gm-Message-State: AOJu0YwuhTZU51zLuQ8ky77vSVTz+knzWS4CqlFDnpaWY8al2MUrulac
	yWhQOERQ38OOs4MVVMg83MvKjsj8RzQ6LH93nVsj9NCpRUAxhK/1ROxSZaaoTky5602Prm2RgVl
	7qJyavc6Ptzk4X0aF3cTT3sStJxl3P6Ul
X-Google-Smtp-Source: AGHT+IHG8SjpSfaiR6d2rM9kP1UihXbSL4M00ATB3tCd83Iv7+aIe4bq3duXxKd+vzZ8CYk8cH9fDZV6D4yVAbNz+/o=
X-Received: by 2002:a05:6871:808b:b0:22e:102e:ba26 with SMTP id
 sl11-20020a056871808b00b0022e102eba26mr3194515oab.6.1712011133391; Mon, 01
 Apr 2024 15:38:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Apr 2024 15:38:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo7as957h.fsf@gitster.g>
References: <20240401144542.88027-1-knayak@gitlab.com> <20240401144542.88027-2-knayak@gitlab.com>
 <xmqqo7as957h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Apr 2024 15:38:52 -0700
Message-ID: <CAOLa=ZQRw1Cu9rcKYoxzsL8V3LWjyMKuOkcutzqRJb+cpyBNTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] update-ref: use {old,new}-oid instead of {old,new}value
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chris.torek@gmail.com
Content-Type: multipart/mixed; boundary="000000000000753097061510a710"

--000000000000753097061510a710
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The `git-update-ref` command is used to modify references. The usage of
>> {old,new}value in the documentation refers to the OIDs. This is fine
>> since the command only works with regular references which hold OIDs.
>> But if the command is updated to support symrefs, we'd also be dealing
>> with {old,new}-refs.
>>
>> To improve clarity around what exactly {old,new}value mean, let's rename
>> it to {old,new}-oid.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-update-ref.txt | 58 ++++++++++++++++----------------
>>  builtin/update-ref.c             | 26 +++++++-------
>>  2 files changed, 42 insertions(+), 42 deletions(-)
>
> Did you run t1400 after this update?  There may be other tests that
> the message update is breaking but that was the first one I noticed.

I definitely didn't. It totally slipped my mind, I was thinking that I
only modified the *.txt files. I will send in a new version after
ensuring all tests are fixed.

--000000000000753097061510a710
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2ad6fd55d58fda42_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZTE4zc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEd0REFDUmRvdGp6RC9HVFpMQS9lSE0ydFlCUktseApKSGtKcG1UUzFW
b0YrNk1pZTBZL2Z1RFlxSDRNKzQ4RjhXY2lZWVM5alREWUtwdkpTSitYWmxTdVB2M3IwWkpqCm1C
NGN3bzZnOThFSVUxaTVSWHBOVWxOdTZrSHdlNnY3bVZ1K1EzWHNaNmxPSnNmK0tjUmZUbWQvTVNE
b2l4Zk4KaHRkdlY0RlZzMnVYMVFoSTFQNGUzejZBWGJReEhWQXB6d0ZlaXdxcWppckUrOUsxSEhZ
QUI1MHhzMnVwdlI1aApUdnpQMXp3YW5PVEpxRmp2WVIzNXNldjZiL3NvcVM5K0VWbFE0dG50SHRK
a0Z5bmJHYjRTdk9sSHRIUm54aVdvCk94dDJNMS9rN25rREV0VWdLeFlQMW5yZGNONzlWeGlGTHQy
bkxVUXZDV2pzZEZiempndlhWZGhDZHM1QVNkMXIKZlZpQjAzUy9rQlhLdG1PVVl4aG5hV0JhRk1B
NUJsRGNWWWd4WHlpTXovQnJBaUNha1BDVm04dkxLeGhNeW5qcApMSTQ2LzE1NmxyZ09BOXM1UjFy
WU9PU0d4YzN3UzcyYVpBV2NXVk5UTTE0bTZoald0WHFwbS8xY1JUYVYzZW9TCnRyaHRCdFROUnIy
YUlTVTVXVE9FWTB2d2syTnljR1doMklPMC9DWT0KPVpnSi8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000753097061510a710--
