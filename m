Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AA13AD39
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545869; cv=none; b=Y2U5v9uuT5pIfp1a/vd4II2UPUnp4QEsRQm2iKs+AAA53gILx+03nB7O2qBfF4Yvl9nAoHiH9pwpDKo7B392NPo71+9UMq5M5bD8eZ0rGw9JDIeFwfcp+hIsUMR25pmROkvH8A5uayqjeDr19ZWV28+C1JqeuEFkdfyJ9KmMHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545869; c=relaxed/simple;
	bh=3V/FdoGwV3ZfVXKZOVhkxgN0o5Vnckx2okUJ6q14khA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjoXi23xCj6Eu7KS9TmFL/rlufoicagXqglntvGKZ9fkPSpizFxWzwKJGvymKoGIFkUJPbvREKUKzm3J3gbrFUpzRt0TrO7OXEEla45258mUyTvwcuX9U4PnK5o4FgYdCr/4fEeJqzdGTbkk9Itp5juWFpCG6YmBRuOEZjzSq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgA9fGs1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgA9fGs1"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c3d3710018so1610741b6e.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711545866; x=1712150666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVfVALANXFK8fnKGza0TDs9ff1FWuvZQe9MLetnWvHI=;
        b=cgA9fGs1hJbq+CIBoXFeak1PpADTFdZdFq39svgbOdgG5S+fsgJoCwcQT6i8ZSnrBF
         JgZ4yPEDnWq/g5MhQY/IrmV8O3QH+XccU9iwfYggM/QSlh3ONOQsNIBL6uJYoASBWI5V
         JmFXxBdDBj54FY/DXx1qCPciR0kxl9Ty/s6UvmOSLdfXuB1QJuUhpi7Mr131daH+l/34
         8bTq7oDN1o6Pz5FGLYxpw0oM/TTkeBqHFv8v7m5YcEc0xcTNkfKx59JczdR/jP/IZ3id
         FuLpiVaAH8r7+D0gObjFM0YMQpvmEHIp9MkISYie9d1HtGxPcAWH7Cdnh7XST49afHnY
         V7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545866; x=1712150666;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVfVALANXFK8fnKGza0TDs9ff1FWuvZQe9MLetnWvHI=;
        b=DDgFQe5RdiRags8mkCt4oddDaEmirpnAnp+7rKSCacueZct5RXzTodnd9dWO+dvuJL
         ZNNL21CiGAXleostjgeIsMDAAXmNUamarxHGvCUOXO2RI0KUmdWaUzzEHggfiQnkQHPn
         lZIuCfgoRYWc5stJ2Rz2llmMuOVHVpdFFQ9Po/23eS9jRtNSyklEv4L44RqXjGg1v5Bx
         TqPI84t7JyBqWKmTZYHm1+1oQIrKVE0MR0WosaCxGbulG4afK4HvJtB3DAmmF/LH6AgK
         LI5Eve3+wUgLxsmbSpBsZ+2VwC6ZDMcUIVVpIDsAMS0n/g8ENzxR0hsVKARCQCdsNk3D
         KcWw==
X-Forwarded-Encrypted: i=1; AJvYcCWQRb49j2HgSz5q8mcHjHYvO7hPTokCKGtVpnvSB7hqOPmOcMLYcBX2WmZNJqz+dVpW87fruzHTnpm9QhAJ0OwAmG9w
X-Gm-Message-State: AOJu0YxJOGAQxh7r78z42zmZ+p0/32Dg3kEVk9ET2Z2KrW0IZX1jl+I2
	sx/rn0tjGo8GAk75Hiy5tCV1AFfYaveUW1VnnyUbtL3vRgQuDDeu5YU7ghpdsquaxi472Nsk8wU
	fu/TO/yBYEkJMRKsfoSvz5FzNJAkcal4Y270=
X-Google-Smtp-Source: AGHT+IFMDn5LRyf6VPOBv1nYHrvESG+iLEpiIhSNyHuoMHETGfcLMtfYcXAQNuQ1dE3wHzc0wo63vTzLXqGvWV29nak=
X-Received: by 2002:a05:6870:160d:b0:22a:6ad4:5cb with SMTP id
 b13-20020a056870160d00b0022a6ad405cbmr4410375oae.7.1711545865109; Wed, 27 Mar
 2024 06:24:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Mar 2024 06:24:23 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <def7008452303f71c1fa469609bc199c629a19ec.1711060820.git.gitgitgadget@gmail.com>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com> <def7008452303f71c1fa469609bc199c629a19ec.1711060820.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Mar 2024 06:24:23 -0700
Message-ID: <CAOLa=ZQFiBKWs1qT=MyJhBKgn8MJBL-5G6X7EjeXkKwNOaCC4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] reftable/stack: use geometric table compaction
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004e98300614a453f4"

--0000000000004e98300614a453f4
Content-Type: text/plain; charset="UTF-8"

"Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Justin Tobler <jltobler@gmail.com>
>
> To reduce the number of on-disk reftables, compaction is performed.
> Contiguous tables with the same binary log value of size are grouped
> into segments. The segment that has both the lowest binary log value and
> contains more than one table is set as the starting point when
> identifying the compaction segment.
>
> Since segments containing a single table are not initially considered
> for compaction, if the table appended to the list does not match the
> previous table log value, no compaction occurs for the new table. It is
> therefore possible for unbounded growth of the table list. This can be
> demonstrated by repeating the following sequence:
>

Nit: A numerical example would really help make this simpler to understand.

> +	/*
> +	 * Find the ending table of the compaction segment needed to restore the
> +	 * geometric sequence.
> +	 *
> +	 * To do so, we iterate backwards starting from the most recent table
> +	 * until a valid segment end is found. If the preceding table is smaller
> +	 * than the current table multiplied by the geometric factor (2), the
> +	 * current table is set as the compaction segment end.
> +	 *
> +	 * Tables after the ending point are not added to the byte count because
> +	 * they are already valid members of the geometric sequence. Due to the
> +	 * properties of a geometric sequence, it is not possible for the sum of
> +	 * these tables to exceed the value of the ending point table.
> +	 */
> +	for (i = n - 1; i > 0; i--) {
> +		if (sizes[i - 1] < sizes[i] * 2) {
> +			seg.end = i + 1;
> +			bytes = sizes[i];
>  			break;
> +		}
> +	}
> +
> +	/*
> +	 * Find the starting table of the compaction segment by iterating
> +	 * through the remaining tables and keeping track of the accumulated
> +	 * size of all tables seen from the segment end table.
> +	 *

Nit: we need the accumulated sum because the tables from the end of the
segment will be recursively merged backwards. This might be worthwhile
to add here.


>  static void test_suggest_compaction_segment(void)
>  {
> -	uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
> +	uint64_t sizes[] = { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
>  	/* .................0    1    2  3   4  5  6 */

Nit: since we're here, maybe worthwhile cleaning up this comment. Not
sure what it actually is for.

--0000000000004e98300614a453f4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5f0513d033a99833_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZRUhnWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFRKQy80Z2szSm5IM3RvWFVpNjI4ZCtldXFLZEVzUwpHaTVwUG11NU9l
L0FzVS9KOHJRMW1pOWIya1EydFdoUU9RN0lLYVR3SjFxWWFZaU9BZHhXZ3RKb29wbjEyOG8xCmxH
Q1JQaDBCbXdIWTd1VVlYSEtJMWZrbTVrWXRaWWpMYjVxZWN0eVh0NDI0Y0dtZ2x0bFBIa1pBUXZ3
blI2MjMKamRXckk2Q3llUTVHOWdJNlE1WVhRamN5aGxyMVFNRCtySkhIMmlweThNemRPdnlKV0x0
OXFST090bGY0Rm9OeApsZ1QySnJuNDQ0R1MxS3F2djdFL1J3eWx6YkJqc0VwU1VyZHB3dnhmRy96
bHdqUEhMWCthcktVNnlqaVZYTzAvCnRQV01qUUZNWGRpeURvb0o3NG8zWlkvUU8wUERrYWpnci93
emZ2WXFhc0c3bnpCcnJXK2c5RlAxWDZvS1ZYTnoKaW9nRng0RkJERG45cXRTL3h3S2xlTXJyZUhH
M2RncXFOUkxjc0x2cWNGWmZMRm1ZbUY2bjR2NkpPSENSZC9jUAo0WDBmUGJzVytBSG9ickZ5ZFcy
NHNtRnhHTnBjdXlUNEc1cmR3VDFJNEFlNmV3eGh6b2VnMWh6WlBXcXNEcWkzCkhyQ0RpSmwzYWt6
Y2J2WWlXWUx4T0R2Yk1oaDltS2FXbnJ4SDlFWT0KPTFwUEYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004e98300614a453f4--
