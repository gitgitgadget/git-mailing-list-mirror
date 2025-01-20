Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80401AB6D8
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366471; cv=none; b=eDjVt8na/wvdFa0zcD1tcBLjBLOS7SVW9aG/QvydYO7JHaNHx1TNSTv/aErot80Oxr59zfxl7+t4gvC53fs6ZdBq5t8YI1zmoYVFWYk+GDOfj8QK/Sd4N04YC3hvqSJ1eh/pi06DEIYqZGd9MdLYeSTE1ihUPTPUmDYqUgJp4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366471; c=relaxed/simple;
	bh=fdi+7M2NCxepi38mSttYvXTlwQweMSVAnqndH+Wy9Bw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=jbQUZrGhZ6lbwUFhqyOESho1Qp0pTqugucqBT+IX+IDCbCZoaGXHE2szf2jxSNJQXeAkR9Q2ijNd6ParADtVQ1QiC7ObJPF0GWDy5Wy77svr6rKPKq8xzzvTuU4/LyMUtl7yGqJ3k90m1akre42JNjlRjCrvarp4zQf/x5OJCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY38+7xH; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY38+7xH"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85c662ebbc3so660718241.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 01:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737366469; x=1737971269; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cEdw/Chclf7gflj1yt383+ihdYXsdgv+tUsGHOD1eo=;
        b=cY38+7xHyOHTI1p74H5RZnMVxZGdXxKa2JoOwMROn6dHCDg7ODDU8zgGLGWgu1tiTh
         OQWWr39nVzI4O6UcLitEnHD5N7O8lJmotltpaCawxLp5wBf1EQJAhU84fz1rcLUQsltl
         DxLFgb0KVHe24acRQlKp19hJ+162MRXw5ez3/X6r0ub/Eb6bpRn12I/cHHxMU0EG5uRa
         Tz/2zOAyj4D0B6DDZuEUwKLbpJbOadQpWnWry6ERD/XJlz5gpOPheE8gARk5wyWg2td4
         qlR/nyaHevtxBEqtPhT7bpIvZV0bmBn8Jd09l2VYaFqVCa5cnfUejnDJqTmwYz/jTstP
         1snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737366469; x=1737971269;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cEdw/Chclf7gflj1yt383+ihdYXsdgv+tUsGHOD1eo=;
        b=po4iwTYvxDwSz5L8OXoCNXX97eCFlZlpdjp/LlcbapNNsSE+yOWVNXpr2+YkWEdhXg
         l1eTW36kgnfmwknfa4yILZYnEPXpcbHzk/7AdNEQvuV1ml4o2TKyBPf+URxEft8GR1aW
         aXcaQkcSAJ3J+AuRoASAnDfveU5kZezBuA8SWpzSu7dezAgEkhQiWleS8FZWtLuuoncZ
         Wm4OCXD3+FpT877uVk9GnaUAay2fZi0JA0S9y2inAHIVrIK9iA6dmohctzRkhXl4zJCn
         /DNk3rEWMHgP1laO+SJNM/fj+tR3ZmlWS/X8D9/LC03Tx8p4Z2Rf+tnYeO9RrqxQs6e0
         /vFA==
X-Forwarded-Encrypted: i=1; AJvYcCVVn+yP7oVz7i2fb0V2AeVjs9zApqAJiTaSkgORdHRzCzuq82PI2Jzg6Am4X+r1cGeXiPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk57lGtD5/p1lN7FY4OAb5zTq1OIKFWOYLmd/onr2LEI636CC6
	768dBFbk0AMsvBWS3HTJyIq0HFxdT2BZqbHEMPqItlXPmU1uD+Rr1Q0eS5PGfyltKtCofbGg7Ty
	3+yCc4cLzCmfjHJV12b0/jdrQSUrtYKQq
X-Gm-Gg: ASbGncsL5yxklK1AJv5zTIICgMPXg0aK8wfQhcaMjdP6ma6/YYr05mxwgfXTk0lGOh1
	B9Pf9m3LvwaE1PiI3m6/hZtW19DNsvMToq3S+/zLDnrhTCIGm3vyI
X-Google-Smtp-Source: AGHT+IGOnuhHkAzrAIi2zWb2OtW1nOQXLjayI6WuX0JPTalfha2oANnz4hfhTax3YX+lQdlp5Dsm9dREKy5IjJi/a1g=
X-Received: by 2002:a05:6102:3591:b0:4b2:bceb:1ac6 with SMTP id
 ada2fe7eead31-4b690cddffamr8369082137.17.1737366468652; Mon, 20 Jan 2025
 01:47:48 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 04:47:47 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-3-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im> <20250116-b4-pks-reftable-sign-compare-v1-3-bd30e2ee96e7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 04:47:47 -0500
X-Gm-Features: AbW1kvajgbSZYEajVc03vX733zTTsFKsKRc9EoRAnIzaQTkAqLKSPdAxpD5LYQs
Message-ID: <CAOLa=ZQxp=tmmBwAV2OR9ODLGf_VHLxG_50-YwN7-s7+c6pmNQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] reftable/record: handle overflows when decoding varints
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000358f24062c202797"

--000000000000358f24062c202797
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/reftable/record.c b/reftable/record.c
> index 04429d23fe..4e6541c307 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -21,47 +21,40 @@ static void *reftable_record_data(struct reftable_record *rec);
>
>  int get_var_int(uint64_t *dest, struct string_view *in)
>  {
> -	int ptr = 0;
> +	const unsigned char *buf = in->buf;
> +	unsigned char c;
>  	uint64_t val;
>
> -	if (in->len == 0)
> +	if (!in->len)
>  		return -1;
> -	val = in->buf[ptr] & 0x7f;
> -
> -	while (in->buf[ptr] & 0x80) {
> -		ptr++;
> -		if (ptr > in->len) {
> +	c = *buf++;
> +	val = c & 0x7f;
> +
> +	while (c & 0x80) {
> +		val += 1;

I was at first confused, I understand that we add 1 to check if there is
an overflow before adding the next section. But this actually modifies
the value itself, but looking below at `put_var_int()`, we did value--
before storing each continuation byte. So during decoding.

Nit: it would be nice to explain that part a bit here with comments.

> +		if (!val || (val & (uint64_t)(~0ULL << (64 - 7))))
> +			return -1; /* overflow */
> +		if (buf >= in->buf + in->len)
>  			return -1;
> -		}
> -		val = (val + 1) << 7 | (uint64_t)(in->buf[ptr] & 0x7f);
> +		c = *buf++;
> +		val = (val << 7) | (c & 0x7f);
>  	}
>
>  	*dest = val;
> -	return ptr + 1;
> +	return buf - in->buf;
>  }
>
> -int put_var_int(struct string_view *dest, uint64_t val)
> +int put_var_int(struct string_view *dest, uint64_t value)
>  {
> -	uint8_t buf[10] = { 0 };
> -	int i = 9;
> -	int n = 0;
> -	buf[i] = (uint8_t)(val & 0x7f);
> -	i--;
> -	while (1) {
> -		val >>= 7;
> -		if (!val) {
> -			break;
> -		}
> -		val--;
> -		buf[i] = 0x80 | (uint8_t)(val & 0x7f);
> -		i--;
> -	}
> -
> -	n = sizeof(buf) - i - 1;
> -	if (dest->len < n)
> +	unsigned char varint[10];
> +	unsigned pos = sizeof(varint) - 1;
> +	varint[pos] = value & 127;

Nit: While the `get_var_int()` uses hexes, here we use ints. Would be
nicer to use `0x7f` and so on and be consistent.

> +	while (value >>= 7)
> +		varint[--pos] = 128 | (--value & 127);
> +	if (dest->len < sizeof(varint) - pos)
>  		return -1;
> -	memcpy(dest->buf, &buf[i + 1], n);
> -	return n;
> +	memcpy(dest->buf, varint + pos, sizeof(varint) - pos);
> +	return sizeof(varint) - pos;
>  }
>
>  int reftable_is_block_type(uint8_t typ)
> diff --git a/reftable/record.h b/reftable/record.h
> index a24cb23bd4..721d6c949a 100644
> --- a/reftable/record.h
> +++ b/reftable/record.h
> @@ -34,6 +34,10 @@ static inline void string_view_consume(struct string_view *s, int n)
>
>  /* utilities for de/encoding varints */
>

We should remove this, no?

> +/*
> + * Decode and encode a varint. Returns the number of bytes read/written, or a
> + * negative value in case encoding/decoding the varint has failed.
> + */
>  int get_var_int(uint64_t *dest, struct string_view *in);
>  int put_var_int(struct string_view *dest, uint64_t val);
>
> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> index 42bc64cec8..6d912b9c8f 100644
> --- a/t/unit-tests/t-reftable-record.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -58,6 +58,22 @@ static void t_varint_roundtrip(void)
>  	}
>  }

[snip]

--000000000000358f24062c202797
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a2227ead6d90c4d5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lT0c4SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnBMREFDRFFINXhUckNidVAvTkpjSEdtNUtnelNpWQpNWUQ5SFFEQnJu
Ky9TbTQzYVgydVk2TDhZMS9zTC9LM0hTdCszRGp1dE0rVGdvZlluY3lLNmg4U1h3bDJReHRSClB2
SXkrc0VEV1E2K2NjK2VVL2FXZEt0aW1XVDNuRXFsc1hZR09DZUVMdUZQbFp5SmZ2SFJrZXA4dFZm
V2VwbEoKN3U5YWRkdFRDZ1hxMjFiSGFJcU9QNGZCZzdZWlI5cTRNUzJZT25TSld4cDVaaWZSOXF4
WUJZM084SFJiYVVNQgpDWklhNWdNR1JxV2xQT1Y1T0dETUtvUjV6TzNnQjRDWGE5aDhxUUV4SFEx
aFFlbFBsV3hTTnFtbG1LcjczcFZYCjZNNHBPMVVKQTR5RDF4akxQWUhOL1l2enNiM243MWlsblo5
RUdSMkxFYjAwL0JNd3NpN1lLazFzM2NPeHFDalcKTGJuTGluVGYwT2J6REl3bEZXZWQ2Z05leUoz
MUh3OHlpcXdXZ3NaT2RHamVHWk9CSUpXZGxMUlZzMjY0RmtHdQp2SmFjaGdlYnV6WE5mQUhLbkhu
YUJyZnRLb0Q1eGhHWnJJSXdmTUNPajgxVU1lZEpkcXRHdFdZWVZ1UHk5a3JVCkxmdE1ldXJWRDVC
bUtYRVluY0g5S2lkZE8vNUtKSTA3ZWJrY3FnVT0KPWIwaUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000358f24062c202797--
