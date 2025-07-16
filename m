Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F725C822
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676834; cv=none; b=C7+LAobUwbhfii68eOGHcKEiVWM2adrUoOEVGnpHz+IK1b+eAYMHppmFmsT7JSR103okeauOzm/AcbcTiMjPKifPJ7wk2EeoXGffXW83+9n87rvKJ3VJBnFsRPcXkTUyIoKhkqzvKJ9On1mec2Llg5zTI3l9NxFzi4WWYKtlrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676834; c=relaxed/simple;
	bh=J11IZ/kk6lIdO9Ny/jNZL2I7hbePj4cjE31ES5eqoI0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW8vF+rxBcG09X+cIHhH6uyWUhti93jWHqprRpuMthqwmTsZX6DX/erYq+owQ8es+RihTusOcm1A4jYa/m/+gBQymlyJLbXOruLmQ0wm/Q3LO9hTfWggxgoYcp/YVZ1YZh85DFwNKhqfA/FTGw0tTI9vALHYaPyWIsWMAdgXElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOVXZuZp; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOVXZuZp"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5347686c12cso2439882e0c.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676831; x=1753281631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhDNOZoPzIBfEFUmsGIBkm4rkYosWfNh8UdLmYUZh/U=;
        b=kOVXZuZp9EXADChEcR4/dn59a83ClOqctyqAo5hjrs6wYHlkmBgItHZrNunPnjVnGE
         bT3ZJSqP4PZVXu+OclNIbpO29z/o39JHjgycFuWMfLOIU0qjHiPqolo/dHDj1fA4/itS
         dvBsfGWgqNPdYH5iJ+Grfx8HbsFZzDf2hJpgN6V4mBMV8IAn3+nXVwskn9+N5VZkyv3A
         ltxfH032S0DgXUGH9YX4IzOG7hImiBYQvDKXxTLetL33rcaycg1YfTcVYuLix3f3UT7N
         PumPD3H8fwWq79ZDpg4ZLEtGW6jJB7A41kSHie0Kk8tgVachH8/fHJIRGHoyvtjzNJje
         N65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676831; x=1753281631;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhDNOZoPzIBfEFUmsGIBkm4rkYosWfNh8UdLmYUZh/U=;
        b=HzdKvn03bkRvsa/jh/wcmrSPVSxcyIH3PtHybxpXoosXrCpe0RhbJP9Q523Cp97z/X
         gha4nlQUdTbN3iX/V/c8zO4W/KD7cUFEPBjhTpKFdjshATSeJimy0p/HTRUxhfYl+eog
         dG4cS6zwRGXC2ZmQiT/I7cp3p3AfrezEWPol8d34kdPQEox9T4JtyIIWT6VWOXlw2nrq
         mOuarruqvACcuNGGbpFcDgSYaI2+jEIjvRCjbUn0X2ZdGKJMtW043Q2apxmwI8cJ7oDQ
         REzIfSHFyZfE1YkZo8m6lUPIt98tNLPbXK3+TXARGbqnuavjf6jCp4a+mN0IzpC4Ao2o
         0Wcw==
X-Forwarded-Encrypted: i=1; AJvYcCXdHvH75IG8o2WYkCDTg8ZgvaB24lvVT/v7KnYbUO8g3YUupM1VzWCOWUQRRC+RjB7EvQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjWZqVSnLbo2sH/xAeXH3izP2WcNh/NIB8QNyvO0SlZ98IqhRC
	UBZ99wxa/2HRyFL2s1+N/zQMI0cKM2AFL+taZ5a14FHQ1iXm70JAPrJUMC91xGUDxkf/J0OoxH+
	vq3Ala2qAS7TdzFkA46wwiFmX/vHdhaDWtYnM
X-Gm-Gg: ASbGncsNe2wopxSo6nKq5evOUNX4X9bVB3+jJstXG14iES3C8q17ZS2MhSiahUSZdEe
	xIqRxF+AHT5FZfXgfD4LYgAvtcwRWiqWnh/obo14B4++ul8Eux2xFaRmZCkxDPP/DWp+hHE02jg
	mGAcCIWtrcB9Akk6XqmdhCXPSqZEUeEg1wSnxglyTI/CqyUf/T/uJBgBZ8na4sRrEt30gEi65Ie
	QjJ9+A=
X-Google-Smtp-Source: AGHT+IEbu61TU5Emp8I+gOTZiXM95C6bEdv3GqGCXeY2r4UuGhQmortzxXnUiXkQd/eYlSGKJIWgKFlzGOpkiUhR6q0=
X-Received: by 2002:a05:6102:3f10:b0:4e7:cdaa:ed60 with SMTP id
 ada2fe7eead31-4f89016897emr1678624137.6.1752676831034; Wed, 16 Jul 2025
 07:40:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 07:40:30 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 07:40:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqms95if8e.fsf@gitster.g>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
 <20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
 <aG9hMP9gEFLhVgJL@pks.im> <xmqq8qkqvjnu.fsf@gitster.g> <CAOLa=ZS6ASf1+nbUnCTeeH1Di=kgmhQUEQ5UXPZu051rfqx9Pw@mail.gmail.com>
 <xmqqms95if8e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Jul 2025 07:40:30 -0700
X-Gm-Features: Ac12FXzSsKZuNp9jg-UQXTahUieGwuJqLJdFkZlzW6rDxNappZ9jNqYZQfInrLA
Message-ID: <CAOLa=ZTc2_g3+8MM8whW+eZAj-+36HNsnUFDoLgnN42ytFLwAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000eb9f85063a0cdf6a"

--000000000000eb9f85063a0cdf6a
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> so after (true) seeking that does not have the SET_PREFIX flag on,
>>> wouldn't our iterator-advance run through the end since it no longer
>>> is aware of where to stop?
>>>
>>
>> That's also right and that is indeed the intention. We're trying to make
>> the actions more intentional.
>>
>> So if a user sets a 'prefix' for the iterator, all previous state of the
>> iterator is reset. So, the same function for seeking an iterator should
>> also have the same side-effect of resetting the previous state.
>
> Perhaps we have different definition of "previous state" in mind?
> So let's imagine an iterator is walking over all branches (i.e. the
> prefix is set to refs/heads/, to allow it to stop once it steps
> outside refs/heads/ and moves over to refs/imerge).  It starts
> iterating and I see branches whose name sorts early in alphabetical
> order.  I tell it to seek to refs/heads/master and keep iterating.
>

I get what you're saying and indeed that would be natural. Let me draw
another example to draw the contrast.

Let's say a user is iterating with a prefix set to 'refs/heads/', this
would iterate over all the refs with that prefix. But mid-way the user
realizes that they only care about 'refs/heads/feature/' prefix and they
ask the iterator to set that as the prefix.

In such a situation, the iterator seeks to 'refs/heads/feature/' and
will only yield references with that prefix. In short, the previous
prefix state was reset.

So to avoid the two scenarios:

1. Only seek the iterator but maintain prefix
2. Seek and set new prefix, loosing old prefix

Where one resets the prefix while the other doesn't. We make it explicit
and say, whenever 'ref_iterator_seek' is called, any set prefix is
reset. I do see the other way around too, where prefix isn't treated as
previous state.

What I was trying to argue for, was that, there could be a situation
like what you mentioned, where a user might want to retain a prefix,
this should be an explicit requirement which not implemented in this
series. So as of this series, you cannot set a prefix and then seek and
expect to retain the prefix.

> Wouldn't it be a lot more natural if it still stops iterating after
> it finishes showing the last branch, iow, a ref in refs/heads/
> hierarchy?  In other words, I am not sure why ...
>
>> There could be a usecase where we add support for keeping the prefix,
>> while also seeking the iterator. That would be an explicit change
>
> ... that is the optional and unimplemented feature, not the other
> way around.  Is it just the ease of implementation?

This series did start out that way around, so ease of implementation
isn't it. It was more of a side-effect of not clearing state. But I
would be more comfortable if this wasn't a side-effect but rather a
conscious choice with tests and adequate documentation.

--000000000000eb9f85063a0cdf6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a6962f0b8d3be719_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oM3Vkd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1JQQy9vRGRPNHl3blRPcmY4MGNDMytVblFrNDkwTwp0eitxdEdmKytm
MVRJZVNBSHJOdW01Sit6L1d5RzZFNzVrTFppMklFa251enBUOXdpRFdHam8xUFpnYnh3OWRRCmJF
V0E5dUZOMzBxZWRDa0RBV2piRG9FWVg0eGtRc1B3SG9LL1VQWFNsbE1nbXoxS05uYTExTCszcTBU
UG9mZ2EKbXlEUGw4L01BczhRckU1S1YvMDFqYThVeGlqeTlTdjZCTnpPbXR2cnZQbm56UzhMNFhk
REhHbnJhc3ZkMDJDYQptazc3QVQ1YW5peCtqRExoSnV5a29Kd2ZyRzhWMitQR3k5czVzRzJmM0g5
TEtkR2oxTWpHdlZBT0ZnVDdSK1pBCnNHakVBWmsvejdPZEhuZmN2RDdJMHNndDAra0kxeTg5ODVu
b1B6UWMrcDNnNERDUTc0K1pkMloxdW1GNlFmTFUKbCtqZXhhNk1DSXNhbzA3bytYUTFXMG5COTd3
T0daUXU3UUw1c1pmTWF1Y1NwWjU0NTEzd3Y4eDNhUm1NTmNEbgpYeXVrcUxIVGpOa1p3NFl5d21t
UFBoSlhKbUQrYlpITTFST2tyQ1B0dFhIUnVHQ1FJaVlZZmdjcXViWUhOYm1VCm00S3dGYmg0TXla
MXowckN1V09WU2pUeVZIZW1RMkxvSGhHZnFrST0KPTZMci8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eb9f85063a0cdf6a--
