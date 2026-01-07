Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CF19309C
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775848; cv=none; b=AM8rXRc9Tda6dFeZx1O5YCBFc/eo4CUJi6XNCbkzOWGLWEMKiAci5UsQBF7a1m+TtCP6Ff7mLhBWMOhY2l3xyzjpghZKf11aGIgJQayW6SdVbqUunWWWRJkKCcDWq9ltqUJFLv+hEThZRMvnS971OXg3IrmCkanVk005y4oTM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775848; c=relaxed/simple;
	bh=MrnxkVji1m6T6frTyN/zAb+ZiqKfZFyLV4D5O9Whs7Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWppEIXqhxxZudmCX5psmm1bx65nXoMpQHjO1tKvc8ruNw7yw90sh71EHP4ktUyujorM4V7AH4Oh/tmmiXxFZ/FRjlLHv34GYSavfNikpaWME3n8MS0MjwgPDvvjv9oQNYphQI+Ie8Yl5T6tIIgv7loQiTuWbogcKrF6UAAgBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOTZVoPA; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOTZVoPA"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5eae7bb8018so660742137.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 00:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767775846; x=1768380646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNmQbZfW1KjW00mEDLTMjZJ3eObSulIUd1Qoq2KC5ts=;
        b=iOTZVoPAG99NWg4CKZ1CHTfsAFVwJ1Yd7jNS6K3riQqPXH/+IaHjs1MpJu1S6vNddI
         /9r5a4HqhBb3SEUMtH/834hNm9/0fRw6GepS0nSLbc74dSDH9GyyCZD8T1tbR2ZVXDgo
         b9wxW0PQmUoiZZcUXuCW3Atv1q+Xht3QzA9DMRBCIjJhXfoMHX+GDDZAdH9kVAuExksO
         8AJ/La+Ir7k07skigHmdhyNmEXPVDAWGk2scDLA5GzpHwhkVLrwLTnV/NIgnZ2Ogrkmf
         ruHA37oXs9p2/cvOd1hPX1hBhSJ9647iQak+RQmQ1ewvNyRjSGTs333lKKlr0oJp765+
         qOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767775846; x=1768380646;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNmQbZfW1KjW00mEDLTMjZJ3eObSulIUd1Qoq2KC5ts=;
        b=jIB1mXbnLD7BfRr6dUkKgdj4oO510ESEiQ5ETbdBtPaaFUEgpch/gesvGaaINqpz2S
         Ig8ASNbdIT2m3Ti5OSZ98gSfaMrPC/ZQzmBAXOIvRAqMczhvU2O82gDeRoiETeiUg17c
         tEu/KsqbVlUmdW0YneqQsQNGkswil7Qwpnl7M/KxOAREQapJsc9vaAt2o957PZ9UmiiF
         KPmo2Wa7kvsi6sGnQ7tw2hI9hJVfWVjr5YHPFYIEQN+cDQXZqW5QmY5nkGpFwfEqj3dj
         YqR/gxYtjV22nZrIYsj2dsonyHd9VrUqR8CrbpCmrX7DKisydiGFC1dqtH3Ino33wxLT
         PDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0GZJ1nf2NpYxmQqOYfqivnqCqVMGR0O0vgn74N3R0bWGkw7QudGYaDHssB95fyXtVjHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojAkD2+eT4WCalAe3c2qKXnqk/e7dRReb4sCcNMC7M6SXDYAJ
	g97khqVNaDQ/tqy13uhqyH4mp+0kDvy2IOZVtJqmweAQsdA/tWVEvgV6oXaATOtnPU7sJiZMmwp
	5ZVBFMnygqJ75/QwhXjdA2ElB9eg+28Q=
X-Gm-Gg: AY/fxX5VHrVTTLhJ0/+YBdeajeGAUTRpmHYV0exKk2RoV4O8jpYuOeZYLNm90eF3Qcj
	S0gwg6bBltkdv7w5jlIPHdc4Av23x3SpyFazhx566zhSC6XcDVWbY0Y+yYmvfl3Cx8zYhj7k4Ix
	kkBp9MI4rEBxvcBq/MVLwjGnD60GbL0+nnzUZHGkkxo+tIQfYT8h/RXHmeQY15aImiyiqcImlyf
	igl6z2WD1cI990K4va7HSKfkkLHZFa2zqcWZlaP9W5jODtZyqU4KnnYMB8ZoWX1fCoe4IVrWuc7
	AmTOca9WcSElIwRyLTcwmF4sG7bmfg==
X-Google-Smtp-Source: AGHT+IG+5j2wF4bPT7cYreGZaJYiRLMBfNOl6e4HLmdY3npLMWQZ/2CMN+fKW7PMDTUrWgkduXcNYnGfVAgceQBxHvY=
X-Received: by 2002:a05:6102:560b:b0:5db:3b75:a2aa with SMTP id
 ada2fe7eead31-5ecb688e212mr600808137.18.1767775846267; Wed, 07 Jan 2026
 00:50:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Jan 2026 00:50:45 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Jan 2026 00:50:45 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-1-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
 <20260106-b4-pks-odb-read-object-info-improvements-v3-1-b5e02fae1fb0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Jan 2026 00:50:45 -0800
X-Gm-Features: AQt7F2oRis9Bz7h3hiUA3k8-Tc1ClsZ8qV7fmN0Z3ntY8KHqJ1rLsV_zfTAIfxM
Message-ID: <CAOLa=ZSNmi_Lzb=3EdWks=mMOPvfijT2659y4YtxWnUKVUOXaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] object-file: always set OI_LOOSE when reading
 object info
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Aaron Plattner <aplattner@nvidia.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="0000000000005c1cc90647c86301"

--0000000000005c1cc90647c86301
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> There are some early returns in ``odb_source_loose_read_object_info()`

Nit: s/``/`

> in cases where we don't have to open the loose object. These return
> paths do not set `struct object_info::whence` to `OI_LOOSE` though, so
> it becomes impossible for the caller to tell the format of such an
> object.
>
> Nobody seems to care about this right now, but it's a bug waiting to
> happen. Fix this by always setting `whence` on success.
>

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 6280e42f34..d566df427a 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -439,12 +439,23 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  	 */
>  	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
>  		struct stat st;
> -		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
> -			return quick_has_loose(source->loose, oid) ? 0 : -1;
> +
> +		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK)) {
> +			status = quick_has_loose(source->loose, oid) ? 0 : -1;
> +			if (!status && oi)
> +				oi->whence = OI_LOOSE;
> +			return status;
> +		}
> +
>  		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
>  			return -1;
> -		if (oi && oi->disk_sizep)
> -			*oi->disk_sizep = st.st_size;
> +
> +		if (oi) {
> +			if (oi->disk_sizep)
> +				*oi->disk_sizep = st.st_size;
> +			oi->whence = OI_LOOSE;
> +		}
> +
>  		return 0;
>  	}
>

The change looks good. I'm wary of early returns independently doing the
cleanup, wonder if it'd be better to do `status = ...; goto cleanup`
instead.

--0000000000005c1cc90647c86301
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6a9ec6b39a909f9f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sZUhtTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVc4Qy85eGxLU3NwcU5jZnZaeHNZM2dwUTB4K3o4bwo2OUhqbGFNd1px
MGF6ZU5IMGhheTcrUzVyd2Y4RUI2VytBVnljZXZCdVNRUndtbkdQazZkVzdhVjIyU2pLcmtmCm5V
RnFQZHFXeUd2d1MzQmU2V0FrbXA3SmpWTXhvVU9iQ2ZCRnY3VTdDQThmaDZKZTlWc3RGS0hFYk10
SHpkeS8KblNVWXBHenA2NnpSZkxJMTExMnVtcHVqdUc1bFAvYUhrdndmcVdQU2NQRGg4Rk1UY3ps
Tk01MjFrTUlaaGg5LwpGN1NQK2VubkFtdDlvdzIxZ3hUQ1FXa1FvRWVwRi9yUnhKSlRXUW1IaDcr
TjNBZTl0Uzh4OWJwRjV3Qi9QYUQ1CmZiSCtqR3JNK1VRUElkUUVib2dkRUFlU3RrWHE5dFZZTFNo
eElFOThCdlpDMFVXTWh6cHlUODhFYWhOdkZmNlkKUHhVSGlKVVhHamI2enlDVlVJdXNkMnhCMnVP
ZFVGVTJFSzJ0YnFVaXMrRVhBVVlrZ2VnbGlhYVM0VGMyenQxTwpqYVJPTU1RRWJGWnhISE5uUlJP
ajhaQndTeUgxYVJqbTV5ekV4Q2I1Y1lvUXFqRWVPRnhlZzFBUWs4eXV4RmhRCnprUU1tM3BxM2M1
YnhRWWp5ckxJS2QvU01VUHZKdEVJUndMYndRTT0KPTlMcVYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005c1cc90647c86301--
