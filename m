Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB332E146
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780728; cv=none; b=R5mFx7O3ciUznihtAlSbjSKGNAmfpzFvDImU77xXbzBfNieYaW3mEana/KR7b1YqCz6QFMcRO1g1d86nnod2BP3uo0jHOYHpNCOVB0evfyKbh8/DJ4VdYzqP+FDc4pKH6fQ0gnwED1CCyccT0co/8GqkGnTpDpkpL6iTY2JO5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780728; c=relaxed/simple;
	bh=ZDS84CLCFCCyhHF7fEkJzxtRb+c8Ny3LXuc5+Phx3Wo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9MTe6x/iH6W+/5QOTPpaxbGcQ/EIe7cjl5NHzEigsLfex07E6WmNDKIyOBdGplofZjrEDnYcs1MCCTJMS8LmIRL6aOYELASmdnwwDBw3HEruNBSEOK7AOKptAKAYRwhx4hlKawCZEIN1ieBS12KyepOKcar0ooeaOL1u/tjMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGu2ZHV7; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGu2ZHV7"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dbd150efe8so679128137.0
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 02:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767780725; x=1768385525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPzWIKEvoScSvrXjllhVOi2DBcRKG8kjmQSO1X2G9Z8=;
        b=DGu2ZHV7OVwv+vhGYhSfp6m81NZ+4++oJBlQi1B/mcBShinf6gcTFb9qyTAZrLU0Gj
         Ei529y+eoKm/UHuJYkkejq1weEGTLxF7ugfU3a+9YhNb2NE+IVv+FGZb8rU9xTEB5/XL
         mGvpaFywgHIwdrbxDqdyFt9z5kIZDu7C3vuECiGlq5VgFTVH+K8x0ICwvpXF2i3UdRdb
         cN1WfqwMtxyFOqHdFY44DOO7kH1MB/OWyshTbbFfVTdIhyNhe29IzvxwnAVvnhbEloDm
         bZoMy3zxyLIYUEUoMu3f54Y2+l67RL2rhOx+bBAlm7MDQBGUcmJgQTLO2Iv8skRDrGYg
         KMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767780725; x=1768385525;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPzWIKEvoScSvrXjllhVOi2DBcRKG8kjmQSO1X2G9Z8=;
        b=CQDL2utLfzMdZ1+zeaGmqbLioCAF3L7Or/sMPTUxPuGRHZMblW5SC75cKLfh6Lx0YG
         x7RiDOZKCFMo0bwQCLShxv6kvi6SZwiIq2YiqtjSgeXvCr4sUOsKjL0R7dxaYlLGJs2L
         rlccHpA2je3ojNKDbq9cf/ctihU7Rvjk4Ti3Pwxy+EcFxh3P+HrALd+6/mWLcterTzCo
         KMPzypSBWtXkBBIjebpZTWriyUofyGwny0bk0bhReOAEb4BLsTd1d+/4dmZ92oa+VIiC
         51fuvS38wkvH/Ku4rirbdjW6F1A+ex7kdorhQFAFMSzZHXFyrO3knIifsRi2LnumZF4w
         mhyA==
X-Forwarded-Encrypted: i=1; AJvYcCUA94WzmxzHP8tIKv5QU3GayYaBHnJB0UPXdhq/GqYVG/2ZP6EFvtyn03tSLiBgJK5TnbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgX5aUL4LavMT4K32pFA9choSKzznyXFkhXgQXxgXFkGOXhsS
	xUlqmC5F+WDeJy+N0XkMX8WBZp+KTKnwJSEl+Bw3PDpKzc4wOpJQEc9dR7eC6A9FJ3j7khUX5Fm
	GlIQ5XtSOB0VZNxiuvm541Yb6/DLATMM=
X-Gm-Gg: AY/fxX7dSjN6U9xdjj/87AQ/BVAYtUNND87haPJPyRRdYxUhx+T47x5M4qRyLsN1wAO
	AjSdJ8CmJ/QFV+PL6o7z3bJfK4tY/5aQtEmGsTtlWh+L3xKg/LMykT6nABJ5UUn7oxFipQgv4kC
	CM/P4SWzp2Z7D+gkdgu9WqVAS7h3m31FYSCwlp+BE1soQi03AUMfgZQ7XTqd2tUku5KqLYi8KZh
	482cHnh6KKRgy3waYPYqq8pnnaapyF9mfSQw6Oam5K2wwatsRjwAppdkVZmH9UDL3I+RfSMInts
	wFaaiy+mm6lvXd4yC5qNDB6XzRPVUZv5MseDwqTz
X-Google-Smtp-Source: AGHT+IHA9VLsOV50jYnYr0hL2tQKNwd3ixj/ZtVHPCo49YWOLNWfp9crdz13KRqp7T/pnN4hQLx54OSyC/rG9Jp7lKw=
X-Received: by 2002:a05:6102:c4f:b0:5e5:63e3:ebb9 with SMTP id
 ada2fe7eead31-5ecb9b2ec62mr523987137.40.1767780725407; Wed, 07 Jan 2026
 02:12:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Jan 2026 02:12:04 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Jan 2026 02:12:04 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-3-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
 <20260106-b4-pks-odb-read-object-info-improvements-v3-3-b5e02fae1fb0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Jan 2026 02:12:04 -0800
X-Gm-Features: AQt7F2rt3J5yjodG1I4YePtf0XiINzmxpqoFBVtcZNg559TghgIVWzY3GEpQUUA
Message-ID: <CAOLa=ZQ0wYjDiYYgsiR=p4rM0SCgjwhcub_j0vz5kVWhzqzMWA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] packfile: extend `is_delta` field to allow for
 "unknown" state
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Aaron Plattner <aplattner@nvidia.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="0000000000002ddffb0647c986ca"

--0000000000002ddffb0647c986ca
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `struct object_info::u::packed::is_delta` field determines whether
> or not a specific object is stored as a delta. It only stores whether or
> not the object is stored as delta, so it is treated as a boolean value.
>
> This boolean is insufficient though: when reading a packed object via
> `packfile_store_read_object_info()` we know to skip parsing the actual
> object when the user didn't request any object-specific data. In that
> case we won't read the object itself, but will only look up its position
> in the packfile. Consequently, we do not know whether it is a delta or
> not.
>
> This isn't really an issue right now, as the check for an empty request
> is broken. But a subsequent commit will fix it, and once we do we will
> have the need to also represent an "unknown" delta state.
>
> Prepare for this change by introducing a new enum that encodes the
> object type. We don't use the "unknown" state just yet, but will start
> to do so in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.h      |  7 ++++++-
>  packfile.c | 17 ++++++++++++++---
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/odb.h b/odb.h
> index 73b0b87ad5..afae5e5c01 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -343,7 +343,12 @@ struct object_info {
>  		struct {
>  			struct packed_git *pack;
>  			off_t offset;
> -			unsigned int is_delta;
> +			enum packed_object_type {
> +				PACKED_OBJECT_TYPE_UNKNOWN,
> +				PACKED_OBJECT_TYPE_FULL,
> +				PACKED_OBJECT_TYPE_OFS_DELTA,
> +				PACKED_OBJECT_TYPE_REF_DELTA,
> +			} type;
>  		} packed;
>  	} u;
>  };
> diff --git a/packfile.c b/packfile.c
> index b0c6665c87..cc797b2b6a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2159,8 +2159,18 @@ int packfile_store_read_object_info(struct packfile_store *store,
>  	if (oi->whence == OI_PACKED) {
>  		oi->u.packed.offset = e.offset;
>  		oi->u.packed.pack = e.p;
> -		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
> -					 rtype == OBJ_OFS_DELTA);
> +
> +		switch (rtype) {
> +		case OBJ_REF_DELTA:
> +			oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
> +			break;
> +		case OBJ_OFS_DELTA:
> +			oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
> +			break;
> +		default:
> +			oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
> +			break;
> +		}
>  	}
>

So we get `rtype` from `packed_object_info()` which can return OBJ_BAD,
but return early in such a scenario. So overall this makes sense. I like
that we are now storing more and clearer information.

[snip]

--0000000000002ddffb0647c986ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9dcba296e12e9be9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sZU1YTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFJ4Qy80MjZQU3Y1UVBJdmlvSnJLenBwaktvWW5INQpZampUMlRJRjhE
ZE12QzNyYTdKeTk2bHhKb21ZOW9aSDhmUWF5SldWL3loM1IvOXkwZENKZGxJdmc3L1lxTTdjCnly
WWs5WXRKUzJTL0VvSmdTOEk3ckxhUm1PSlVzQlhUdmNPTDhKa3QwZXhTWlZzZTJ0NG9ZZFIybjhm
MkQ2dlYKaHNjU0JBSTcybjhEUXFhY0luajB2YnVBMDMwekUvNzRKbzRVOCs3TmV2UFBZZEJzTmFD
MXNPSU91NmpIbmZxagppamlIU01EMFpESjdOdzdXS1VnWE5WdzNRc0N2eWhNdy9BbFhiSy9HZmd4
cWw2Rnl0WlFKYk1nK29GRExjZGhECm9uRDVsaStGbkJ3bjhiaWtZbWI3TllFNFZ2NndLcTRlVi9I
b09McWdjZzF2VjdBZlN2anppanl6dVErMGFXeUgKNUhPSlFXa1c4U3l2ZjB1cWZ2L0hXVkQ2SlNT
S2ZsZU4zNVNIRXdqQlNsaXhJM1laWnRZbjMvRDZyL1N6dXlIagpVb1NMTUFtNGE5NmxvcFlBWm9T
K25jT2Y3NUppUEV5c1VGTEthWGhuRjRiaDNaL3lKN3RLSWxLYXpjenE0dWxTClhBQ2w4Z0NhL21P
Q2I3QVE0T2FLYnhlcHlaOHowQ2pqZnlNNnBRWT0KPVBvQmwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002ddffb0647c986ca--
