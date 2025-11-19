Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294873559EF
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569654; cv=none; b=NXJolEhbOFF13ElLZY/kqYPWnlGKCykBGnL5LPHhKwpU7+WFl0VTVNc+40m6LaZ6eQ0PqTnBcmjNHP3seCXUqUiYt0+ciQaoqGK6hbd/F7IfomUFfdQm3u1bIxDxeDGUcTfziC8fa3+RPnL86IgHucSC7KGpZrZ65u4NkrFuvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569654; c=relaxed/simple;
	bh=iRBD13DZiGxwt0pNbzQa7bPZL8qy+LOCgyZd4NUo89s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=WvA37aukXb1eWjBvblyaPKDrOzNr/31HjFyZc88XDwj/kUGJKkvK1CyUe9tStSYqzcg7sf16mCpgMtK4w0z9bYjz5YaHi7XgSS7DGxNB+yeMkrx7h0USBeJBXRFg8Wp3bMC2rTOsh5NrYy/DwkvzwMPvbTmFyO1GJMUU8GFEJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXrkYPTy; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXrkYPTy"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-935134ef989so4133750241.3
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763569651; x=1764174451; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLeckTvGLIZdqkVCstLzksmT3j0fs8ua/fnOhFU4dC8=;
        b=nXrkYPTypG2/EHT8Hi6A2+hE2rIEv1fdVMkmJJwuJhJMvUqxM6lTWmbGgH3pfzqZ2W
         oyYcLLZgYYz8GcPe6LJCqcxMid3WdBXc3b/gl8b59zldnTo1J3ek+BHu6KjtFc050tCZ
         S/nxao8mPSAo+odhEPJXw343dIOIro7CLnorxZfqx1lYZXEXFqErn1yJXfo/kwEb4cD9
         GyHqEPdPgQFc3YGEPa/0vIVQe9t7Wv/Fn2BPaK7UdNBlRyCY9umrtCuzpHQWUQuaICl0
         o0XsRoTpcfEgD5jT4gn0GjT6w4AKw48fzrfS9T+Dde1MgDabUwh0XICletodYVuCPGKk
         FpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569651; x=1764174451;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLeckTvGLIZdqkVCstLzksmT3j0fs8ua/fnOhFU4dC8=;
        b=nwJlenlCMW4oEL4kABk3FaUY5X4lrka29kZrNiPnUqhAEYnVUPucAbMN9KJSdO0dGm
         qAmraU87H0qaU4EZ7p6vS2/4jnuyq2hscPksfT+9tI1274cqlmQw/i974+G65CfN/ogT
         8iPMa8c3AjX9zDaxcDprXf1rXJGAkTwewToAVtyR6p7bV/cp59ti8hhD9rnrFdWwERqo
         oP60IK8RmSHHkhx//c26FQOHXIEQV8+xYET8b8Qs+ZEHPJqICqu7IaL18mi3XU8jiO03
         wmbpMYd7vnNWKhSxI9y3bo4yFHkgx53GuYLl4qlJyhBERF0v4gwTyI/GzoZzrNxzTo5f
         G5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUnMNXmrUe/1h83Ka1tvMg6JXiOyWDRakYFt2dKqDzyOHJvRfZzy18QnJ3fr0H7/Q3z8Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCyo+a2rAySZoh6QAWmx3EvDBZZirvVeafJJBbUsW25jolUJ7
	onqr9doEVXaUu2pcd1NeM9cjqlevxoRsAMO787QCP9tPoncONCutG/PcAEe1ufa9MImei/a9Kl7
	r1BNCv8eYYVd3Avw04yTDWIdhrQlteAs=
X-Gm-Gg: ASbGncs4C/nA6XZ8AD9HulDUEkvxvPbQZUU27FUFw5lR/i2Wyk5NJFh+BH6yd1tdELC
	nPYHcq3Y8nyPajw4ywHChafsEKmhQuVZuUN/SA4Eb+t1fjm5sJjNGeGyDt0TwjTPwqRXBvEFoEB
	rXwkIH1I0/kagyinLVA7311ah78UJJJ0+dcd2/Lc4y2CeZXFaKkF3c1pNF/J5qpNV9XBZcYCZ2j
	fhx18ha+ltxVgzrfqbTlvpa8y0wkNVlPtuo1MKUyuPrT+ahSuSwyIkGjvQTMifW7AU3ouNSjmxf
	hTUAXaoEdPTnI6M=
X-Google-Smtp-Source: AGHT+IH3w3jqKxYQUGPHfHcIXezMLk22+akgK7Ww7yznSFJVdgfUyPxdJwRpLG+DaJWuKkekoTAQl6bzBTcSOzu/muo=
X-Received: by 2002:a05:6102:3f0c:b0:5df:ae62:fc25 with SMTP id
 ada2fe7eead31-5e1bbb75363mr49955137.8.1763569651003; Wed, 19 Nov 2025
 08:27:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 11:27:29 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 11:27:29 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-14-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im> <20251119-b4-pks-odb-read-stream-v1-14-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 11:27:29 -0500
X-Gm-Features: AWmQ_bnAxNsmDjTmvSJjDLZCoSnVWC1KE05uY78KZqEYEK24147pNXbIY0ZvBaU
Message-ID: <CAOLa=ZT_VFfbfLVdvHUqK5C6k4zROLQs0Pt5rOWL_hE_BSfGeg@mail.gmail.com>
Subject: Re: [PATCH 14/18] streaming: make the `odb_read_stream` definition public
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000095d2b90643f50e93"

--00000000000095d2b90643f50e93
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Subsequent commits will move the backend-specific logic of setting up an
> object read stream into the specific subsystems. As the backends are now
> the ones that are responsible for allocating the stream they'll need to
> have the stream definition available to them.
>

This was a question I had in mind in one of the previous patches, looks
like we're going in that direction. Makes sense to me.

> Make the stream definition public to prepare for this.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  streaming.c | 11 -----------
>  streaming.h | 15 ++++++++++++++-
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/streaming.c b/streaming.c
> index 9e20e9a882..3f94bd2a03 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -12,19 +12,8 @@
>  #include "replace-object.h"
>  #include "packfile.h"
>
> -typedef int (*close_istream_fn)(struct odb_read_stream *);
> -typedef ssize_t (*read_istream_fn)(struct odb_read_stream *, char *, size_t);
> -
>  #define FILTER_BUFFER (1024*16)
>
> -struct odb_read_stream {
> -	close_istream_fn close;
> -	read_istream_fn read;
> -
> -	enum object_type type;
> -	unsigned long size; /* inflated size of full object */
> -};
> -
>  /*****************************************************************
>   *
>   * Filtered stream
> diff --git a/streaming.h b/streaming.h
> index 95c2a434fa..3a850e3efc 100644
> --- a/streaming.h
> +++ b/streaming.h
> @@ -6,11 +6,24 @@
>
>  #include "object.h"
>
> -/* opaque */
>  struct object_database;
>  struct odb_read_stream;
>  struct stream_filter;
>
> +typedef int (*odb_read_stream_close_fn)(struct odb_read_stream *);
> +typedef ssize_t (*odb_read_stream_read_fn)(struct odb_read_stream *, char *, size_t);
> +
> +/*
> + * A stream that can be used to read an object from the object database without
> + * loading all of it into memory.
> + */
> +struct odb_read_stream {
> +	odb_read_stream_close_fn close;
> +	odb_read_stream_read_fn read;
> +	enum object_type type;
> +	unsigned long size; /* inflated size of full object */
> +};
> +
>  struct odb_read_stream *open_istream(struct repository *, const struct object_id *,
>  				       enum object_type *, unsigned long *,
>  				       struct stream_filter *);
>

If we're returning an `struct odb_read_stream` anyways, why take in
pointers for object size and object type? They'll be the same as
`odb_read_stream.type` and `odb_read_stream.size` no?

--00000000000095d2b90643f50e93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7e10e2517d042714_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZDcvQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTdTQy80cUZpSGtoVXJUQW5lUEFFVXJrcjJTaVQwSQpVV1plbk00Y2hr
aGlkL2crMy9OL3lkbTFFalMyU0hmZ09GcytZVnhjU1grQWRGdk1LU1NMODRoZlJ1MmRNRjJnCjNW
SHk4Um9RMkpXN2xHQXRJUnhzTW14VmRwb0V4a2VxcXAwdS9na1NrbTdKRUFMUUpqUXdWaVhLYjdz
UVVWREMKK3hnYk4wQ0lRL1JQemk0QzVpMkhiUEJQOUdOcXFFK2xMY09rMUN2bTBVcThTYk41ODhL
aW50MUVwMGlyRC94WQozMkgvaENEcDkyZmpLVlBnamsvdUlMVWZkZmJmQU0zSjVGeFYxbHFHTHJy
aytyWm51enFqU1ZKYmxTYUtzUDlqCmdQRjFraHloUzdzTWROZCtvSE1ZTVJwaCtOek1jRVFlR0Vh
YktaRU1wcEpMOWtvdVlvMTVSUmRyK2g3SHY3a1AKaGhvYjgzallxSmtTVENTN2tkRW9aVFAxOTBS
V1BFc1ZIckNJcU80RlRLRGM4VGEvaEFxbEtyayt5UHlONzFtNwpHbnVpM2JiK2ZQOVd5WTlva3Ez
UHI3S1czQTlJc2xveHVZYUgvayttSGFIYVk2bmdtNmVzcEFSRG9WZjdyeHMyCnRQbDVrVGdJV29m
OU1VTU5xSkdRaFFtamVSZm1HaUxHZDRKQ0RIND0KPW1pVnkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000095d2b90643f50e93--
