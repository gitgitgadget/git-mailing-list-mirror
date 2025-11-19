Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498F1369B4
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547272; cv=none; b=JsuAWskJeZ28JHwJgYPLzizlcThV25G21dRMyMbAjKEEV+hfqr5pBt6w8KuSsY0uEizzlp8s0OFtzU54t0pv/VRS8E5DxRsbv5DkGlQT5c1zx5WpycKrHFJY6K7Hjo9InQJJ+zv7HV84NdV068Ifok8UHCr1I8WKrytpRFSxPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547272; c=relaxed/simple;
	bh=5OBcv+mRtNn19FU//3ZoU47M7PjC7x3jmPoGUgNWBzI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Yvmh9tiM/k6N40+h9vmdPFUsK1qvRhAI+msE6Cs7HRHU+UQkaCTm4k96f/nqOJ0VY3BbxX06oA8P5qMgpFqUx02/zzDvT836ypwcdiYLEHwgNWNqkJTw8PwvMShyBMqpAG68oGgJ17Vtim7J7KZGrll7Q9oS547LNcTcdScMzP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCCTuVtw; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCCTuVtw"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbd2b7a7e3so5329893137.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763547270; x=1764152070; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jy3aAmxSWGecIYZcb+5MbI8oZL7jMB9aNdzL+E72dkY=;
        b=LCCTuVtwpOt8qGO/U8S+Cgg432Ckht4o/OsrTT2D2KeK12ob983At6GPPj9g6LgJnC
         32coJ37AcqltbH74xI5pL6Q8JUBktjeTzqIBLqMTgK532Npt/e15EE9lsEQHex+qeTob
         kue/VqcTiZP8fllxz4Qagh6Bt6Q6sNiwM7dq8XQyKP5eGHXZrY5Ucw52nL2+yNEkbYVQ
         8welqkyqsKWpW+njtCw7s+KAyq6XGuonAQ8VR7IIF0UMxPDLTtjkvtCa3bUZbBc9ovah
         B15PJN34Vvym7DtEmgTUSvkfeFzuRahoYc4Q2S/GN/168BDX6J7+VWFpCm7cyRNDhp5o
         V/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763547270; x=1764152070;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jy3aAmxSWGecIYZcb+5MbI8oZL7jMB9aNdzL+E72dkY=;
        b=VsOYFp7/lHSvIC+dEjDDxN9PyGYWRYzKTLRtm10+vI5MYLh5W8B/Pil4hGLfRJ4qeW
         TY/9mUh9AwIBQhaArz4tj2ZM0o6RSvzsW1Neex+uc7iZSy1o5MXdX+GQQQsQhVuDfY0x
         000ZBTJXW/6FFizOH6XxpyZtIeWIceHIdJxWauA/nBO7+bHFU3lGeM3kiYgYJYEG9hP2
         M1ElAXK5jsxkCyzmDRjmJUG3CvSgBwKOAxngYx+b6hIMmgMh09p3YrwHaI7T6ezJSER5
         /XewbvZyfFgErEYGYpQhPuTOaytik0dtXaPXPon6osaSjoQBcrsOzb7Me3KX7hM13jM6
         AwSA==
X-Forwarded-Encrypted: i=1; AJvYcCWYZHd9f9pW3+G2iLJlaEHRGDWQlukYTdn/ZybM8HU3CTQYMzRbSeCCUJVD09nXvZUkgrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPWNRyEo7LjbZKZEjD+Of21ocaRTk8pHdPxM0dXD7sI27jRBD
	5ztKX6LY82LJqy7YZluqjcsFvV400jSXENbOuJKG1R0xwgUylkXMkiWCU4MIuC7x4e4EH+cJSYq
	iGjjFII/vG13ckL5XP1Eg5qYo89C6cJTp1w==
X-Gm-Gg: ASbGnctHLH+BMpdMJPnOPMVbd0+3P4ToCIGGIxJY8ibTPhVXIrrlL9Uo9tb0UXL5p7r
	VIcI20ZvN6DnqE67KGrbrQl8pP2pwzsoeHrCyn6Uws+YJ/z5yVobOPz3RkE7nfDjcCTzR90Zb3h
	wjOXXkJhgsCwvFLGh8cPH/bmU7sOneOGSS+wK7DrifY4mpgIjV7H8bKlUyyOcPeEiD6UVc0sDop
	Y1Q1zDkrAgjCW7UfbyJNEmGMZOrm+roDfdfeceb9nNb8VA2lG3o4zhu0nH+csHNuVDThS3S2VWW
	fPXIE+YCymDCEiAYDOsLPhY471PNbxucL0gnhg==
X-Google-Smtp-Source: AGHT+IHAwEJfrY+qXJKLKEjsMVm4o/NWzJWaYLhYng6Ij1jc3GNFfUsPm/uOv+aDDIGKSgD0svo7Rx8ybeYpsQ67Cqs=
X-Received: by 2002:a05:6102:50a4:b0:5df:aa69:beab with SMTP id
 ada2fe7eead31-5dfc5b70429mr7455707137.29.1763547270393; Wed, 19 Nov 2025
 02:14:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 10:14:28 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 10:14:28 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-6-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im> <20251119-b4-pks-odb-read-stream-v1-6-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 10:14:28 +0000
X-Gm-Features: AWmQ_bkK1p7QEaijXyEyPKXmZkpv29xCsr-QzmNM9JvGZPbz8lJ1QyXpifsIkBc
Message-ID: <CAOLa=ZRwk2DPCG-kWs-g7qtjBbXc9QuZgumxA3y54JsJjGpM=g@mail.gmail.com>
Subject: Re: [PATCH 06/18] streaming: create structure for in-core object streams
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000098dbaf0643efd880"

--00000000000098dbaf0643efd880
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:


> @@ -426,22 +429,24 @@ static int open_istream_incore(struct odb_read_stream **out,
>  			       const struct object_id *oid)
>  {
>  	struct object_info oi = OBJECT_INFO_INIT;
> -	struct odb_read_stream stream = {
> -		.close = close_istream_incore,
> -		.read = read_istream_incore,
> -	};
> +	struct odb_incore_read_stream stream = {
> +		.base.close = close_istream_incore,
> +		.base.read = read_istream_incore,
> +	}, *st;

Nit: Almost missed this `*st`. I wonder if its more readable as a
separate line:

  struct odb_incore_read_stream *st;

All good otherwise.

>  	int ret;
>
> -	oi.typep = &stream.type;
> -	oi.sizep = &stream.size;
> -	oi.contentp = (void **)&stream.u.incore.buf;
> +	oi.typep = &stream.base.type;
> +	oi.sizep = &stream.base.size;
> +	oi.contentp = (void **)&stream.buf;
>  	ret = odb_read_object_info_extended(r->objects, oid, &oi,
>  					    OBJECT_INFO_DIE_IF_CORRUPT);
>  	if (ret)
>  		return ret;
>
> -	CALLOC_ARRAY(*out, 1);
> -	**out = stream;
> +	CALLOC_ARRAY(st, 1);
> +	*st = stream;
> +	*out = &st->base;
> +
>  	return 0;
>  }
>
>
> --
> 2.52.0.rc2.482.gaa765fefd0.dirty

--00000000000098dbaf0643efd880
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 61b4c5dfada36761_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZG1JSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMERzQy9zRVlBY1pJZWJCMlg4VWFsSURHUi95b0xuNgpPS1JxZzJMMUVa
Q3QxWTk5M1plT2lNVHFEamswRWd2M3RtQ09NcDA0Mmt1a3BjRDhJOSsvR25lUXBHeTQvV21UClZv
NEVFdTFtU1g4UHEraG5Sbk9IL1dCZFFRWStUenNxWGdrWVFSOWlCb2pWald2ZGV3T1R3L2RSVFJu
M2J2RDkKZmJCK2ROM01rMTRBRHhwQXJXN2RyRHZrZVN3aFlrU2FZcDBFKy9rN0VkcmwraG1NSFhM
QlhJWFNQa2NmemFsUApUZXM1YjZkeFR5VjZyVzdUTUNNOHJNYlIxc045ZUNsQWNOWWxsVzBzbWNO
M3dVaUU5b0hTS01jZXkxZHZKaUU0Cm9DTVNqb3grN1l1cUhFRWk2WDFEYXFUYVR3WktHL0RJeGJ3
ZHN0bGlTMEFPSTFkbHREamhqZjZsK29NVThRMTUKRVJYWEl5N2JjdlJQdHIwSWJqS1VacFJJVExP
ZFQrdkpMcXpwZGxjeGd6cXFNUUhobEFmS0JSalBRVmVIb2VmWgpQS1I0cHRpL1lubFdHdXQxdnBl
b3Baa0YzbGdKUjd0MWVkdWpNbXNneE9jMU9LNUFKdGNZS05MZ0FuRU9IekhpClV1R2lMMHpPNUVG
ckJ1MDNQWWFxV1Z4a282QXdvUzhnZlNKTE4zVT0KPU9hNmsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000098dbaf0643efd880--
