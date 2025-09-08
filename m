Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921122EB5BF
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323637; cv=none; b=t5xhvZOIDnIFcITsDJ8y7bpcDVpxUDlb0SZxBQjGYH9VdaBL1/2xGamW3IvXLLQQ7FE6WyLUaynxtnWmBBuDu2S+sOV1mnjgrMar+C3Jc68QSTJPSIPpAVjPOcYWuy8KMpRTLYHPZhEpQ8YaDyRluPgfrdWxUO40VhSWB1Z1vrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323637; c=relaxed/simple;
	bh=+xX9oUvOGPdUyyMaf4Rzp3WofYjNHeFgjMzPgwZTc7g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvWp68c4zwVieZB8/bnJ+urgrWLcK3mXK+NjNjaqZRYLN7AIRlaklQ15YMMNvG7yq//J2XdmAdDWMwerb3kAJ3xRpk96JYI2DiOnD2anOgrhHIVb4po3Yp2UvCKhGDbBb7HY19l2cJnjEKnVZWSY+/ZBxjH07wYqB3HKSsIsrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYD0dH80; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYD0dH80"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-52a8b815a8aso2212630137.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757323634; x=1757928434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtkiCXL7ZBCy60ufehXrwYJl7SWfypMuQWaXg1IApm0=;
        b=eYD0dH80+ZytewT75Y08NpQWU0JfqFBa7n0k/u6c91/pljCbu/xGJFjyISHLUdw++c
         HUA1gkcZeiatAh4N1nwd/iq8gmrNYMG3AUtNDBt7h7vIWQMSU0z+lM+LQ28EhYSKmEaj
         GZbXcIB3xJBOzJWp5laRdRo4dmJVVFr0JcN9EeneUa8n62Qtj/uANVXvLnLpd94MNJFu
         gEPYKU5uCFPXvNiiHHl22UxfShsMvSJKfBMWQS944nXNpkw2o/h+FsSZ2R+piGA8wFD3
         kehPXr/2prB0It8BFPU7YLKqsMT4EKDeJIdiF9Mvx1QJNl38AXchOoeWQ4RTl/XMRtzy
         Yekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323634; x=1757928434;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtkiCXL7ZBCy60ufehXrwYJl7SWfypMuQWaXg1IApm0=;
        b=EQmCG/glBaRFtavxS5INlO/r2cymOeifiO/FlYNpbEyeaCa1wMFUZsTmTsGxGxVCPq
         Eb3pGNsyUI1AdJNrYB70mzpDzqFGo6wUc4mqdvym5Ab1SxuYW1iKER/fiH9AdlirI7uU
         qC5PLCmXQS7EOMQUdMo6XTnEAQAu9t0IFrtkI4w3BVv0sxGLPf3Yi86sbDk7KqxYEXSG
         ScyWQ/3EIEtpup3woCVTYLroR4TS5wgewhDC6UukllcMY6RdMSFWDLlAxNoVGva1EIwX
         TUQAQ3YU5w3A+QYm7OvhT2wblJrFmfbIn8CkmCNc7HC47r/GsCrB4GgriefdVrZ2AZ1c
         lfpA==
X-Gm-Message-State: AOJu0YzxhIEnDPaPqBAVcnsXfEHs4Zd0nK5+WceCa+0GMfGiydel9GgW
	vLMxadH7lWupDIMleTmPcBFcWPBfPK2e6EbDEBdm1ZjvnsGFCXm56rmEguhDkGpZLiFiDX9/a26
	WQvQ0Zzwnx5PMbQ6yA6yYZYaF6b0B1mc=
X-Gm-Gg: ASbGnctyXw2M6s+4VfgHgwAw2swG5GtoWzJyrgodhqQ4Pp8rIrqOUADvW5Ddcy1DNg2
	jlJfnqIAdQfwjxFhVp8kvte4MsnTB4TaeGEwg+GKmqwRbey3ur6AQWYT4iFrGCI7Lje0BZCGCGf
	MeiyDdBbHw2PjvJll3OfXyM/lDAYCd7ZBKvHFId0ihAVk/JX8fFzb44QMR+9ssUE4X3wIq1LIQt
	Te5j+voyUIxfbZPisP2/LviB4zF6ZNJ5s3wbBFAMwlcqZqvRxqff6UK6tUMZ/c=
X-Google-Smtp-Source: AGHT+IE4NYP17magCCp/3SuITEXf4D2dO4N1gxnv2c0RbOnofxldMRPPi2IE4A2p31sCHJAUSj9XUB9KmrJe2AB2QCE=
X-Received: by 2002:a05:6102:5984:b0:52a:9223:1164 with SMTP id
 ada2fe7eead31-53d0ce6c32fmr1874524137.9.1757323634297; Mon, 08 Sep 2025
 02:27:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Sep 2025 04:27:13 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Sep 2025 04:27:13 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqms7bfll4.fsf@gitster.g>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>
 <xmqqms7bfll4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Sep 2025 04:27:13 -0500
X-Gm-Features: AS18NWAPemsKa7r-Oe8oErXAUYWQQbIQ2QAOzgGmNXZr-vrdThMZ0J1gfcAycQs
Message-ID: <CAOLa=ZT7vUdkB_6YaK7P1P72VwvHjVxix36q+G3CEqfze8Km5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs/files: handle F/D conflicts in case-insensitive FS
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000fa6f89063e46cae0"

--000000000000fa6f89063e46cae0
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Similar to the previous commit, when using the files-backend on
>> case-insensitive filesystems, there is possibility of hitting F/D
>> conflicts when creating references within a single transaction, such as:
>>
>>   - 'refs/heads/foo'
>>   - 'refs/heads/Foo/bar'
>>
>> Ideally such conflicts are caught in `refs_verify_refnames_available()`
>> which is responsible for checking F/D conflicts within a given
>> transaction. This utility function is shared across the reference
>> backends. As such, it doesn't consider the issues of using a
>> case-insensitive, which only affects the files-backend.
>
> Sounds like a sensible way to separate the issues and
> responsibilities between higher and lower layers.
>

I totally agree, it shouldn't know/care about specific reference backends.

>> While one solution would be to make the function aware of such issues.
>> This feels like...
>
> The first line alone is only half a sentence.  "such issues. This"
> -> "such issues, this".
>

Totally fair. Fixed.

>> ... leaking implementation details of file-backend specific
>> issues into the utility function.
>
> Very true.
>
>> So opt for the more simpler option, of
>> lowercasing all references sent to this function when on a
>> case-insensitive filesystem and operating on the files-backend.
>
> So when you are trying to lock "Foo", you lock "foo", for example?
> How would that let the generic code liks verify_refname_available
> notice that an existing ref "Foo/bar" would crash with the name you
> are trying to take, which is now downcased to be "foo"?  I am not
> sure if the above explanation is sufficiently clear to convince
> readers why it is sufficient..
>

Thanks for pointing it out and also providing a test. That indeed is a
problem, but that is an issue caught much earlier, creating 'foo', when
'Foo/bar' exists, fails at the locking step, since the locking step also
checks for D/F conflicts. I've added another commit around this, fixing
the check that you mentioned.

>> Reported-by: Junio C Hamano <gitster@pobox.com>
>
> Hmph, I do not recall reporting anything, but perhaps it was a long
> time ago...
>

[snip]

--000000000000fa6f89063e46cae0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ef2e8af99a8bd66_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pK29YQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1ZjQy8wWUJEYzR4SzhsNkh3a0tMczZsS2lPRmo3WQpNMTh0VkR1K1V5
R0JzNEJQVzZnVS9tUVpoLzdnN0ttVkx6WHdVc09uTVBoWlkvMnlDNmdqc01ZWURCVWRkbkZJCjhD
UDduQlhmUkNVdVp2blBIVUFxRUo2ZmVaayttWlBZeHE1NGhFZU1TR3NwRmtlOThvUlFpa2Q5eDQv
cHJwcGQKNzY3NndFdEFYZnJqVEUzd1lqbmV5WG9uY3I2ODZ5Nis2VEdxMW9ybEJ0alZiUVNXVklM
aDlLYUF4dWdTRWkyTQpWaEtSelJpUE9aTWhpb3JaU3JUYnlNL29GMXc3RWxCWnFIS3drYS9POTBa
TDJrd2FZeDV3U1pqUDdsMmVMSWJoCldUZTYwN1padHNiL1pUYTdDa3JsYjNiZzB3Uy9EVGxER3V5
UXgwS0NWd0gxc3ZmcGN5QmNFUkdPbk8wL2twRmUKMnQ3ck5hbUlFY1hoMzZabnUxL3JXUlk1R0E2
U2tRd0c1RFd6czRGYjVuc1pxT0h0RmdPZ1NIT3FXMHcwS01xbwpJZThkd09IZE5nZk05TWpJK1E4
eWQxRHh1eE1Mb1ZuNDhuRndac0RXNGdRcGFJcHVpdUp4elJYT3g3RlEvR2c3CmlTd2pZMHR1ZU84
VVBhandkaGVnQS9pY0VZcTc2SGdxQjM0RjIxST0KPXJNd0cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa6f89063e46cae0--
