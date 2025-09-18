Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75392F25E1
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183088; cv=none; b=i5yw0LJHicavXzuKZ0iSrFON5D0cbcVS4DtUnk8Ns4st17MtyMGvTyMw/VaELapwLMYmXMOXnLNIeEBWpReEGJaHRHQpbyl/aqe26vivWdECILRqxxU2b9GdFKmZ//YeCQa2M4RSD3bmivplRLdK21+HsdOYQFjLNsC5fAAlRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183088; c=relaxed/simple;
	bh=ayTAL0KDYmR7F+TaXHCNoYS4vZ5E0APexdXKLEHSQhw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4Cx9PMBS67aCUzkWWXF7jb8kI1NUEKv5BLikibNE/xbK8zH3LhhtzW6VN9mBj9SMSioTUmF1v2qEE9HZ/H+ito68BJw1u1HbK+49bYa99pbhDiO/vLOiVq2K7b4wtgA72wkJYsByCMsmG6/Uu0FwBCVBzUQXFRyo/GOw6mLl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP6cZ9ZC; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP6cZ9ZC"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54a664ffe83so254952e0c.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183085; x=1758787885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Hk5tebSzSF6XUd1/RmqvDeGODhdkoUqyiFxPLcYMHg=;
        b=OP6cZ9ZChRqEVyWW1+K0GknSnE62hLoYM231BUbVODrHhBXtxLywhac3QgGHOWcCoP
         2jpB/7/deyTIjV1+sAaDzRvFVwONLpDNQ8X+qtCH/VGUwfpkrR5FUuOxXDdSGNQxVIK9
         I4dQ1WO4jhS6n3TsLTO8/JLzu/1izPElCHeEjYq31tfYAMv4WpTweRQbBVhjze4cTODs
         afj0Ii5TZnYW1p9p0CH7+gE0QRukxqTy+s5SEjXiNNYMSXrx6r522ue3IftGiwfLrR0U
         tUjYRO5x1zApbL+wntxnmn1KDl0lXtPjncH0BW6bK79n5ViVDczzVEuo1BXVvDw/YBOj
         xxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183085; x=1758787885;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Hk5tebSzSF6XUd1/RmqvDeGODhdkoUqyiFxPLcYMHg=;
        b=AWwm7VoMCHpj0/5G+64xUsJKWgV3Z81348LvxwUEwDV6o4zk+/H+1rK0X2GWL7w1L/
         2Qp3Q28cviIlJGNY/deXdZ+ln6MxVataqX0G1DvLAZKDXHQFQOa580RYmqkkJlFcPsvj
         dYDPpuzp2hK4voZxE2gbtA6NFofqnoBOdMLRoyygAxztl0aim8Gb1RGSxG0b2+lmM2D3
         eYM/z9NI9sicxJKT9b4wqSFCmIIlYHwNB2Pxu6s7EwJIsxzoQVAJ97XQetjBOD0l/whH
         5tdCQBd50dCjjnLP8Me0T8Qo3f7/O/8dDXMUH/I0IAc93Q7mVDbz3Dm9+KD0IJt2chpH
         6Z8w==
X-Gm-Message-State: AOJu0Yxi8YsDFVTXs98GnIuVhjDJRhvAUlshCpfbBNHTHW++WGOx8eta
	GSK/kDxaHZyLw5uGzOl56ivFzGgR0sCUAmpWE0yEnxOyceHbpAnPjkzf8SRIxepZU54UFbWH/0X
	ijGgrfU4619Lm+eQjyQh2XTSaSWUhZNE=
X-Gm-Gg: ASbGncvhJNRwUPvzLLuUJ+aVeYsBx0MsGRSugBLd2rlvnJtCuYsDZoKaGp872n81wBm
	nfb/lvG32/XQsaNZO2gXb7dgitdkrJxsGoBWtKXozdKe4e8MEDqvpQY3SzjhkJ8E5P7kvfIkiXu
	wptkEwFKztkt+rz4eV+/apkdK8AtRVvWcRZIEAFIqY8liwWE4ezRhCvqZ7aiTm8nH5i0Ds996QD
	3/kL9UN1Q0x64vZ701XhyHBq9kU7yRdEAbplnZqMH59IZai+AGQbF4GoBn9
X-Google-Smtp-Source: AGHT+IHWrsqbdVvOfO6sMbGIW1HlzJvDrtVtoltfqav3K8PZdJnjPaXEI6+zsBPqkyc24NeOkU0y9kZbj38oaifoANE=
X-Received: by 2002:a05:6122:181e:b0:544:b862:1055 with SMTP id
 71dfb90a1353d-54a60a024d0mr1505204e0c.6.1758183085508; Thu, 18 Sep 2025
 01:11:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Sep 2025 01:11:24 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Sep 2025 01:11:24 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6rsh3xw.fsf@gitster.g>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-5-4f96b3834779@gmail.com>
 <xmqqo6rsh3xw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Sep 2025 01:11:24 -0700
X-Gm-Features: AS18NWC17zXOqzdsKjtwJvmA9uxnRuC4UwTkvktpYAQb_Tz25bLk3erhoTZa2cA
Message-ID: <CAOLa=ZTR0X+Za-8O04+6GzSUK83GUwaHTaWij3MA0vty2WUJUg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] refs/reftable: add fsck check for incorrect update index
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="00000000000043402a063f0ee6f6"

--00000000000043402a063f0ee6f6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Introduce a fsck check for the reftable backend, which checks if the
>> tables in 'tables.list' contain sequential update index. The tables in
>> the reftable backend should contain sequential update index. This fsck
>> check ensures that.
>>
>> We must note that the reftable backend itself doesn't check to ensure
>> this and it also doesn't check to ensure that the index in the table
>> name matches the index in the header or the table. The latter is not
>> implemented in this fsck check either and will be added in a future
>> patch where we add fsck checks for internals of a table.
>
> Similar to the previous step, I am not sure why this should not be
> checked at runtime and is flagged as an error.
>
> In general, we do try to avoid retroactively tightening rules, but
> the reftable is so new and not even the default.  If we noticed that
> the runtime has been overly loose, the time to tighten it is now,
> not after even more installations use it.

I think your point is fair and I agree. I did consider it, but didn't
want to 'retroactively tightening rules'. But I think it is justified,
more so since we're not introducing any changes on the format, but just
more validation around it.

I should've replied here sooner, but I didn't ever get to it. I found
some time to finally fix the comments from this series and will send in
a new version. I will be more diligent about it here on.

- Karthik

--00000000000043402a063f0ee6f6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c93828be5f098f09_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qTHZxc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTMvQy85N1RNYmNuTEI5SlQ0RTdCc0VwOUx3a0FNNApvYlMxK0haV1cw
bWp4Y1QzVW8xWUdWaGJFSGh2VVA5cEpqeXg1NTBRSWVTZUNKN1FGaDVJbTY0UmFjQUlUemJkCmFo
V3hmQWs3WHh2ZndzZ1ZHQjhrYWppYUtHZVZVczV5ZmRUYXhYMFgra2FsV3NnL25ZM3duMERHalZO
S1Q4QzkKQ1RrMHB2enMzeUhyK1BNVldMSUVwdk1OMEhqWWw3VSsyMHQ1aDVQZTNqVlZ3d2M5N01z
L2FmRXg1YW5VZmljegpuQVcvbnRPZCt4Ti9xaXlxbnU1b2puY3NHWkNRZFRIOVZrZmJNRi9lRm9R
anhUTWpycDY4cTUwTTMvRmdVektsCk1wUHkyWjFmVFRlVitKcXVjSmJTcUVMbERBREJYMEI5cDRh
V0N5cXdvNU4yRVNONkt0Zm9KbzVCWmR1K0krMVoKMWRsOXpYZzhGK1VIQlAvMlBxblJuVmxSYlNp
WVB2a2ZSeDNiZ2pmZ01MN0VUMy9lN2J2SHRJTnZDVi94RlhzagpDcVBoNEp1TXBqSVdRSW51b3Mz
c2xjZFVFUkYxQStGQ2UxSVN5MVJQWVNoVDZFNFhhbVh4NmxhUkdpWnhmVTcwCi8wdHFnZUZYb245
S0t0NGk5Vi9RQzMwS0lVNnk2S2dWcWt5b2U0ND0KPUZyUEYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000043402a063f0ee6f6--
