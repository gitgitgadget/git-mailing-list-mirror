Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA233F8AC
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545149; cv=none; b=W8XNw2sliIpPJ7gpq/BMh2TSNGngD4cL9omLzpBlhuIvLSx3ERdQNycXxFyYnYaS11Mhv8T9298dV0LP50Bh2zHz08EeFqrLxDYPbdMI0gE+oUiE7x5NJMTJg6aPiqRlXPeFP70YeVODkH0G33JN2d9O6LbrzEN+vP9jSGHk+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545149; c=relaxed/simple;
	bh=xTmglBrPT/nkKKtLBZ+RzjMLAatgCUlp3uI2MEnFH1c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=EN28ZHVQlexvmTGsvsoOHqoaBbQLZwGfVGaSdTYTUMoPyQ6eLdZb54IGFPdKslSnTjBrSA1oVeXjbBShYT6UHiP+1Wjy8KT0Gu7rR/NA8SvF3SDTXSJT4gm/kEjlcYYolljNAzb17/LpVpRWOGwo7N6XlNZ2jOa2/FeiOM3gxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0wVxqUt; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0wVxqUt"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5599688d574so1716272e0c.2
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 01:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763545147; x=1764149947; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rvyR1y3nDKSvUesoSDwWO/I1VZ4pZeLhhUPviNCqfY=;
        b=B0wVxqUt4DsE6RAFNTw6Daphje05vrJJeIA5/0IUK/JmdksWCGAMMhTDU9WG8EmHp1
         2DmDto/uyQYSfoFxtSFP4OJv9L8HOYfhTtX48p/D79BTu1XN5lCfLlKMgw1+yhA461oN
         GirCHVnPUZkInp0xyoL9/YbOaLjW06jbswKK8EY9QdEqhdIyKVHmkS9gvRxxqNxqYhVA
         3InbHDbMBQ2MtD2Y4MT4tX/E4FK1WZoFgQG/SgnB/Vp6K28u03KLg0Sy1S6JcdOT0vUl
         h4bhvY7tMB6srY2o9ZCWC1eZytxNHKSQS6KW6nD6A08qdJHCuDOEPeHIp6+Erkatw+kP
         ZuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763545147; x=1764149947;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rvyR1y3nDKSvUesoSDwWO/I1VZ4pZeLhhUPviNCqfY=;
        b=JMs1qG0zc19xAAnMKA2a4Tl9kGHoregBQVxL3V5dl27CHLLhIr9sz2+AI1Ly+jKYDM
         /zETwLhbsZM8G321hsFHQsspqi69u9Y57C0+/N7tZTqSZl4uJUjGlKGhUiahY/wRaoZo
         H/DvF4/PtaRUDuKD1bHZaiDFbEc3VHkbSWwyPTFCch+UcX3hFvVkXPFn8oqqjamCvK4O
         /i/qxMfAdZbb8TU3xcGlrJHcjzFzWd+KOc0paY3LhRn6NoCZPBRH9TqhxkjPFgNORPpo
         +dWZvAX82foXEzJ8P4AXQngztMGIznU10+XszgBRlftifA8R+7TX8W9rA4m7n+NVPNRf
         +IGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7HKChkXpohIAXBOrZkTOcVTBc3NyjdNyCzq6oZat8nGXNIf7nMvTgkBD1uJvlO1iOBNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTShVmP2ZtgPxOa02byVaUvzx56OpYOC6Bs+5htfj/vQ3guo/
	YoIcTpG4zJUpRQxL0T+FTuk+7/3s1LaiewXLkiTg/gidtEmZudMZFhvYGsjciWOEsN7uDfsf1pa
	KfrbS5MogHWCyV3wKv8ohYAZ9w9jL0o0Ziw==
X-Gm-Gg: ASbGncuj+6QBHvKLvaTMQTUGBQdItLK7BYOZMrQxKuUHvv749XcjTIaAB42RGRzO4dm
	bILqERQt74ctB6/FuJXKhj4N9Na+i9sDRltfM3X5B0lVCinSCfMiyLRq89wAxohdGxKkWv9agjv
	tZxpVrj7d+CZ91ODGTa3U4T1WejBjS12iPyB/Wotg+Wf/z0H2Vp3XICagID5c7r2LHz/a15tr+8
	PvJZBV7A6Kz7H0tKKbeTzwvLcwMD/n/mN3oIHMNQqXhySJiSIJDc3SA8U8U7jaLNMUTcKa1ik/S
	9Ak97barccgLqd5nbN1iEilZTw2/RDUcy+3EVA==
X-Google-Smtp-Source: AGHT+IHas485Q2RMmnxh8CpMysV9IpBS4ymF84i3W7zdQkVzdL4uXnyhj36Ci9ZTFoD+8EHU3i17HZ73WWslZwUhOHU=
X-Received: by 2002:a05:6122:30a9:b0:559:3b8a:70ce with SMTP id
 71dfb90a1353d-55b1be164b8mr6453906e0c.7.1763545146755; Wed, 19 Nov 2025
 01:39:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 09:39:05 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 09:39:05 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-2-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im> <20251119-b4-pks-odb-read-stream-v1-2-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 09:39:05 +0000
X-Gm-Features: AWmQ_bm2I0xVNhtTvdPBsbQ6spWzTDQTgwDJPY6BYWtPd92kKsZ3A5cbjfq8gTQ
Message-ID: <CAOLa=ZRX+_NO-KqiDDtDeLWTKgwMTFDqfcgZjvOechScy+Rv3w@mail.gmail.com>
Subject: Re: [PATCH 02/18] streaming: drop the `open()` callback function
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000004aa870643ef5ab4"

--00000000000004aa870643ef5ab4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:


> diff --git a/streaming.c b/streaming.c
> index 1fb4b7c1c0..5ce6350123 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -14,10 +14,6 @@
>  #include "replace-object.h"
>  #include "packfile.h"
>
> -typedef int (*open_istream_fn)(struct odb_read_stream *,
> -			       struct repository *,
> -			       const struct object_id *,
> -			       enum object_type *);
>  typedef int (*close_istream_fn)(struct odb_read_stream *);
>  typedef ssize_t (*read_istream_fn)(struct odb_read_stream *, char *, size_t);
>
> @@ -34,7 +30,6 @@ struct filtered_istream {
>  };
>
>  struct odb_read_stream {
> -	open_istream_fn open;
>  	close_istream_fn close;
>  	read_istream_fn read;
>
> @@ -437,21 +432,25 @@ static int istream_source(struct odb_read_stream *st,
>
>  	switch (oi.whence) {
>  	case OI_LOOSE:
> -		st->open = open_istream_loose;
> +		if (open_istream_loose(st, r, oid, type) < 0)
> +			break;

Earlier we were checking for `if (st->open(st, r, real, type))` so there
is a slight change in behavior here.

But both `open_istream_loose()` and `open_istream_pack_non_delta()`
return either -1 or 0. So this is okay.

>  		return 0;
>  	case OI_PACKED:
> -		if (!oi.u.packed.is_delta &&
> -		    repo_settings_get_big_file_threshold(the_repository) < size) {
> -			st->u.in_pack.pack = oi.u.packed.pack;
> -			st->u.in_pack.pos = oi.u.packed.offset;
> -			st->open = open_istream_pack_non_delta;
> -			return 0;
> -		}
> -		/* fallthru */
> -	default:
> -		st->open = open_istream_incore;
> +		if (oi.u.packed.is_delta ||
> +		    repo_settings_get_big_file_threshold(the_repository) >= size)
> +			break;
> +

So we switch the branch flow to break the switch early. Makes sense. The
patch looks good.

[snip]

--00000000000004aa870643ef5ab4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ca5549145612d86_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZGtESVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFdIREFDZkpWUGRoYVlVa3NDdDE3NE1VK2tCeVU0LwpJYjJseG5IV1RY
MTJGbHB4KzBNczMraEorTWNxVnJZQ011VlRETm1KaWhzc2Y4SWUyWW9CNlNPSlFrc0pPY1g5CnpZ
VUdoUll0K0VHVTY2QU9Zdy9mbGQwY3A1ZVgwQTJndFBPUHdkMWJyVlZUM2tBMzBZaS9oYVE0c25u
M2UwR3AKbHpDWTV5T01mT0hFWUZnN3NqWEREWDhWS0NPcmp2V3ovcjlZTTRLdnlLcW5mMy90bC9E
OVZCU1FabXBwdDlVZQp4TXJkU3lpTDBnU3F0UWVteTJ4NXJnUFBORW90R0x4YnF6c0tKcURiWTZS
MVdaSDRwc252QnVXTTdNVDlJVnpoCnk4V1NicTBiQUZpeXRtODY5enhwTlBNUDY4YU11cVAwRTdY
YS91ejNVeVNSaFc5K2R4c20zeXFpa0RtbFV0VUsKdWZkblVmQ0d4RC9rOGJFenpUL1ppNlJSRHZR
THJXMS9RWDQ1bHNVdUQxSEVhSkwrQVF2NG1tRUJ2NE5ueEQyOApvMXV1OWc2NndCTmhyV3FkUDRY
RWNDdWRBV2lSOXBmTEc4UlMyTmNXT2FZOTBpdC9LbXpsd1RpUnVabDc4OUhzCkJVcXZ3OStNd1Rs
RjNVaEsxWUxnWU45ODNnNHRKcXNhdDlZRnExaz0KPUt1blgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000004aa870643ef5ab4--
