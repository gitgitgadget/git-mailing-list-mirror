Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504992E7647
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853936; cv=none; b=YJYLIm1ItW0ImOfbB+SrJliio1xYgIosMnk3eZwh9kTXekVoHs0+2DV30LVNOpPZIOHu5kf8gtdoWxIpcILFiqaGj2wuGvp0FNMc7/Rasl1XhG7L/NueS/2EzEvPxw/lqfvh8s3ML9kxhED/ykYKdTk2+V9Byk+2tfcsqJOlpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853936; c=relaxed/simple;
	bh=RbjAomyNqzHnQBD+kuOKcwLHQhPW5YcTVI8tr6wRYRQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=KJUxiOG413ousR/6mp3TPb0nmydtbt8ykLYDWY/u/8pI1UAzjI6UBxgEzbAcqeD4/HEtCtJ/QLA5BGpIW+ZaQ1u90rMUPR9PkWF/GWUg6RguPosky/lItq2vPnPCt83F/Rhpp8uSiTgvrY5QS/CaopPUCT7MtOIgn3Mw9WJVVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEEq2d+O; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEEq2d+O"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8c0e2d1efd5so2227311241.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759853934; x=1760458734; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXA0d58D5b+mEULe1PnK5/W7sekEHwrB9VarsKiR4Ag=;
        b=KEEq2d+O97rRss5O57/0NHzGqz6wrfzLiIwDno7+dcP8KZnRdB4BagwaYLUP2Dm5Lp
         CAbNRQgS9bbnnR2aSwuo8S1GqhEt/C1Eusu0C5Sohk8otMRyHXkTHqudWBnssHDeloR0
         fXov+vfUKNaJmPaB49J7tQEU2PEZbkExyD/UegQqgwvpcQgGYxMnovZZdu+3t6wx3VrE
         Q5pAps0GYqPMiCTFYIcU+3ZrdL15zj2+XZAxC3+hYsysWij+mw+cXi7mPLP3kHP1OUj4
         RAu3K4qnUUqnK2hNJBQ+GCSQS0F5UEdQCRA+tztpnH5OK8pqWT8G9FJ0KdaXvKTwUQ2C
         iL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853934; x=1760458734;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXA0d58D5b+mEULe1PnK5/W7sekEHwrB9VarsKiR4Ag=;
        b=XQgibCuECUNaVMrgT+pY/bnmCLWk2fjxMsW7DkLbNd89An19FuF4UpX6QEayH5oGf4
         Wnw2H3k+eY53elcHYoEjufoM7yPGfBtqdLU1JEceQ7LzLVkFHPVqICl/eFk53H6OevQi
         sttmlrIBPMofhkzPM13rZxE/bqnJOvHTK73zW4z1AKOTByEmUZFVdPFZm5zG+1GN3Ydy
         3OrkxCodwv8rybeIirr6fJsJSZGbd/0GsNJXaQpXu8jdrRd0w/V0e5ld5W7ZjtdoI1FR
         f9k8bYlThsDsQv0kBm3S/qyky+V3q2XwVW8n56mAAYijnPflzKvZKzT9tcfDpmjqFHsM
         33sg==
X-Forwarded-Encrypted: i=1; AJvYcCWl92oVHUsadQpPVbkaaf6gTwm7s9E+G5amFwatLF/Uz+J3VJuW7sFRkF8MuZfKiys4ElY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynhdxNs3vI5yYVyVwNmgbs/le6NjZMiaADai9E6BLTQfs/b/4Q
	YiMVB/igec0jm7CHp7EFi62KwA9txyriydY13Rr1uNAy6mTjiFCW8l0Y8U8IsQdsBi/6VWdonmJ
	Nj5qh3IrEZZDySDpjnvKtk5u97RQUYz4etIcT
X-Gm-Gg: ASbGnctNDWtytUWFilfWQ4Op/1nR9PEFoIkExUXn9MuCc4MLsBK4wkXauax5NWAqbxX
	JnVw1GkCYhUNAO0L9uUDWYMp26MBHpJgTEJe1E1JbLaM9DMzKXpvGNWNMKdUQdizgLOjPkLt3cv
	uLRceL9VzcpzsnzhjRyT//j3xcL2N9sdc/ByR3fzaQdC6GAs8xXl2hp85ur6YqPjTmCIhyYo8bu
	oxNtzUaiy3j9kEtR/7NDj+Ko5L9YHQ1JLTmYLv8rMEmTvUJglelKfq4qKmJ41RWEg==
X-Google-Smtp-Source: AGHT+IGYiT2DCkIEEyBuu4etyNpEQld4h5BWb5sa7NZzzp0lGaN5U79RmwRmldZHhO4qPt8eZIA0rbjKxo3IAKAsxxk=
X-Received: by 2002:a05:6122:1795:b0:545:eb6c:c6bb with SMTP id
 71dfb90a1353d-554b8cef2a2mr22353e0c.12.1759853933972; Tue, 07 Oct 2025
 09:18:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 09:18:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 09:18:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-5-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-5-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Oct 2025 09:18:52 -0700
X-Gm-Features: AS18NWDS7EHCuUi3YXq-08oH0NqaWKmA2eBZ6wZl3_UaeS0C16hk0kMtKlIg8Q8
Message-ID: <CAOLa=ZRdcXUQLXK1s1JLgZAcEYx=kT-eS6CMzCocJ9Oenia_Jw@mail.gmail.com>
Subject: Re: [PATCH 05/13] upload-pack: convert to use `reference_get_peeled_oid()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000976fba064093ec27"

--000000000000976fba064093ec27
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `write_v0_ref()` callback is invoked from two callsites:
>

Okay so this function does multiple things based on whether the
capabilities are already advertised or not.

- If not, we propagate the capabilities and set the static variable
  `capabilities` to NULL and also set `data->sent_capabilities = 1;`.
  - We receive `ref->oid` as a zero oid for the hash algorithm being
    used, we convert it to the hex format with `oid_to_hex()`.
- If already advertised, we simply propagate the reference and if it can
  be peeled, also propagate the peeled reference.

Not for your series: but this feels like the capabilities should be an
independent function.

>   - Once via `send_ref()` which is a callback passed to
>     `for_each_namespaced_ref_1()`.
>

and passed to `refs_head_ref_namespaced()`

>   - Once manually to announce capabilities.
>
> When sending references to the client we also send the peeled value of
> tags. As we don't have a `struct reference` available in the second
> case, we cannot easily peel by calling `reference_get_peeled_oid()`, but
> we instead have to depend on on global state via `peel_iterated_oid()`.
>
> We do have a reference available though in the first case, it's only the
> second case that keeps us from using `reference_get_peeled_oid()`. But
> that second case only announces capabilities anyway, so we're not really
> handling a reference at all here.
>

Yup, this was my inference above as well.

> Adapt that case to construct a reference manually and pass that to
> `write_v0_ref()`. Start to use `reference_get_peeled_oid()` now that we
> always have a `struct reference` available.
>

This is a fair solution for now. I think this also shows that these two
operation modes should definitely be separated out.

[snip]

--000000000000976fba064093ec27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 91fd7a25904a9737_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qbFBXc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEtIREFDUC8rSGFHTmF3MlRvbFozdlNCaThXYjR2ZwozdDVldFM3dnp2
SWg0UTVmU2pkcFBZMGRsVm5xOVU5dU5zVmNmTXpocGxlZFVZMUVleVlQaEtHVEpxZnd3U1gxCnZJ
b1N1aDBUOVo5M0ZNdnlUVzVpRkN6SE9NUnVYVVd4aWJkTlhTVEFSOHJZci9LYWphMDBLRGk3UlJm
eSsxVXYKMUR1dkVtYW9CV3FDZTl5b2EzRjR1T2Z0NW9wTitGQWlMQmF6U0FzRmltS0RYOTNpeC8v
bVgrZG1laTF4QUVDbApyRmpoK0ExdGI4ZERpUkd4cFdpVDBxcEJVWk5FUzVzYmMxQWxXSjlmdnNG
cGZHMGtTTmMxa3dRU3RBNUVaUkdECjRLS1VNUVdiQ3MvYVUxUFpvNlRJYzlJOEs2UDZscU16YjF5
NFBDWE9hMGxMaHF4cTRIVWVUSG9rUXl4TElUSmgKOTExL2tZbnV6UkFqUUlXRTdqd0hxMG1hYmhP
UWx4Z1pHZEhkQXplTFYzVGxJY1BWWlBTaytRb3FLdWxZWXg1KwpnYU5rMllIMU10WmxEUkl5ZnRs
U3VZWnR0YXZkSGJFY0kyU00yak15dk9lYnhXQWJVVHBNQ3hVWFVmTW5weWRBCmMxem1SeXhzRTNY
WElmNkxLN0d0R1BOcjVIY3licVYvTmJtNkRtWT0KPUw5S3gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000976fba064093ec27--
