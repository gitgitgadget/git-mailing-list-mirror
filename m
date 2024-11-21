Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDA1CD202
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184448; cv=none; b=WcGYQZjoIeU9dCP1SLvwZcLd9A5ge9n8JgBH+uoTSknX4+MnMrRmv3aeEdpQLmiMZfq8nDVBP0d56Sfo3EE69WE+9hyt0LG5HQV7AcxbjS64b9/nhpWo2/DB5fHjA0WKz479UM8fVtY5Z5/RRLm6euB2CtNoYDfKzV5+tN7cBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184448; c=relaxed/simple;
	bh=G5gdnVwP9TkdNtR6K8hgySBjZ+TiENdje1va0fTBJeA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSY/3wGjvEwlAB18qO2r1DKt/TSIaXtyFlfaOyJEtQwTMER/QKt3mxow2fBTDa6xUk1phhBfYv4eZ+Fqyi877zV6+oayLRA55sgHYFZSYn7E/4g+33wcA3AsLOIW7mQDOf7+/SRvXAW3w3m0hmMepXo6sOSlPHTzNN0eHcsN4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3sVjd1Z; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3sVjd1Z"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50de14e7d8cso351427e0c.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 02:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732184446; x=1732789246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+u0DgMejqQ4TIZ4ufsqLErXhWK0y4DIFU6W/NGopfQ=;
        b=N3sVjd1Z0mnZ4RV6hQhbr8pvluGbPPJwr4Vf8STStP24cpZp3vnqdQGVyzIg0Dl/y6
         FvM6WmpS6wSKVszgh8QbZPsNUsexIltzlN8iNkeUISshgMh3F2Jwl9q1f7HCoPr2I7O9
         Sb7HM376EkQAy5dVYT9z0WhS/VZwdQXU2HGlnTFFZuV2lx5+pBzZhR5fJ9qpwj7IqvD+
         DR+XGHxAVS3BhjcvgP+EpFeGKj0trhjoNejsqCTbdLwT9o0ajxhfmumvwEU62mdso64q
         zaSjg43yYL9AfIWoeZhaj7e4dyH+NMtLKs1HkVwNIl0Q4X8so1SHAMetSPRji7lu/qpp
         4xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184446; x=1732789246;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+u0DgMejqQ4TIZ4ufsqLErXhWK0y4DIFU6W/NGopfQ=;
        b=APmnQjbY+H4OD4AU4eIX6vJtAB4b7wdq67o07M0Kk7blwswA0g3Rl/5IJC1tT0VsdP
         zx3oOR3WyrEfIbZFrEvkhS1uVlIwE/1f9G5xoGVkaXahS3f5khgJrMbrbK435zHscdi3
         7chkr2BN+ZE8ViaeZFHB4Ny4DygQF0FwYn3Pi3PXdXjyKIX5AWRixew8PA25ZxLTpos8
         Z2b07LlC+oaBeSWM1SzGiVunDewaVkGexiU3oWf5ao0ZPyC1pI+Sp83L/5np8tMVtOD/
         NQNbgotfbTsA6nhqJ2Ti9lj2a/unbHJqU4PLHpOdukpNSiIH6UX4YLnLMa/kh02pLmA7
         7WaA==
X-Gm-Message-State: AOJu0YxXbsqhD9dPUcMk69glLNjpZc0hZqrTzFzoor6bkSwsBwaMJD0h
	xQrOvhxNi4QcrXexHKxl7ipgJ/Jd5p0d3a1BHVMFFO/BMFDYEkwuE+0TT1IzOZgBA9FG/Ul+nwQ
	TDT4if+c85c/tIU34rDJ/LcSssTYLp1RR
X-Google-Smtp-Source: AGHT+IEezGIIiRuslll6Dx/f1jCaVRpx9WAj1tf/Gq/iN6aOzf8j2KH4i6K904A01JH5PrNNnHEz9HZSI9oJSeTBUQ8=
X-Received: by 2002:a05:6122:510d:20b0:514:e7c3:b886 with SMTP id
 71dfb90a1353d-514e7c3c478mr791866e0c.3.1732184444687; Thu, 21 Nov 2024
 02:20:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 05:20:43 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zz5jC3gn7obrXGr2@nand.local>
References: <cover.1731323350.git.karthik.188@gmail.com> <6c00e25c86b495c75182ee5dfc9e82ca659f5aaf.1731323350.git.karthik.188@gmail.com>
 <87ttcbi9w1.fsf@iotcl.com> <Zz5jC3gn7obrXGr2@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 05:20:43 -0500
Message-ID: <CAOLa=ZREU46zJzfyp=g_XagPu__5vun6iyw7ZiMEZvFpvUxLbw@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] packfile: add repository to struct `packed_git`
To: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000082fe4f0627699e29"

--00000000000082fe4f0627699e29
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Nov 13, 2024 at 01:41:18PM +0100, Toon Claes wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > [snip]
>> >
>> > diff --git a/object-store-ll.h b/object-store-ll.h
>> > index 53b8e693b1..538f2c60cb 100644
>> > --- a/object-store-ll.h
>> > +++ b/object-store-ll.h
>> > @@ -10,6 +10,7 @@
>> >  struct oidmap;
>> >  struct oidtree;
>> >  struct strbuf;
>> > +struct repository;
>> >
>> >  struct object_directory {
>> >  	struct object_directory *next;
>> > @@ -135,6 +136,10 @@ struct packed_git {
>> >  	 */
>> >  	const uint32_t *mtimes_map;
>> >  	size_t mtimes_size;
>> > +
>> > +	/* repo dentoes the repository this packed file belongs to */
>>
>> Small typo here, I think you mean "denotes".
>
> Likewise for "packed file", which should be "packfile".

Indeed, will fix both in the next version.

--00000000000082fe4f0627699e29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b624b7de26f1fa31_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL0NYa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWtKQy85SEczanhxSWxLMlRvaTFmYnFLZGxuSVozTgp4bHp1RU9DeXRF
YVE4amN1U0F0VTdCQWsyd3JKMnBTRlZ1TGxTaE81QWNCSlZwOXV2c3F0djEzTHRRWTYyVEZICnlS
MlYxSjZ3T3dzUHpFZ3F2aVR4Snh5YXNqR0E5WTVaY1k4ZzRwaTVrZkhjbFZQWktBZFY5dmFVdDNW
ZEZUczYKWHhwaDlVTm40RVMzZ2ZGQ2NUY0lDbS9QS29tdkRQS0Y2cUFnYnVNZktGK0p4RzZOQy9Y
VUZTY2MzektJR0p1NwpPaGNzWFgzMGJxRDRibUF0bXE0L1o4RndVK3ZwQ0tPVkFzMVV4VlQyWG5w
TGYxS2ZvNm44SjlibmRzV3VmcDJZCkZMV2RzZFRLNldhNXo2TE1XSVJmYWh1MDBlcjNoWFd4N1pF
VWVjdWYwdVRndVh2b0RYUlErbWhia3VBYXFoZDQKOWpNem5CdFpnOGxqdTlxMzF5VDI4cjl4Nk1t
SDdxdEd5cUtqdXlsa0M4WkJkdDN6WEk1clpIM3JFY3BVRG9CNAozUnlaNHN2TVB0VW1COGRYcWtO
dXd4VmdxUmZnZWhLR1VmZ0Q3bklHT3NXbmRZVlByMU5ULzgyYitGMmNQUXc2ClNja1NGYnpiSStr
WGxHbHIwSHR5amF3T1Q4RE5FaE5GZFpLYiszTT0KPS83TDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000082fe4f0627699e29--
