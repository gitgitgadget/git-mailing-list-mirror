Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0042C80
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utO9dLc6"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbed375def6so11740592276.0
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705357874; x=1705962674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BU389mNkDzEVvRO05vUEfufgPBuqhgG3jri0xoOSr4=;
        b=utO9dLc6OERIqA7evi7RWI+xpUPVP+FWHzG/m29C8r+y2uUNqnGAg6iCIkpa9G6h2P
         1jEnDfeeouEIsdAqha9WzBf9dumSZPFTxSBFKAonDQbEPa42c2m/Av1P+fFuWAR05bfw
         FvbKqUkBSlWEDFJUyZFfmhAKuXNSUewVAniWbQGb4KTWxdRe3oO8/kfCJEJkAtESk/3T
         qMxHg9UQlZORb1MJ9wGBh7hc3J4ieFpmk9xAv6nYfETmrOvgnc/Gy4fIGrPwVL42/ZAL
         zM1q4NwQzqeS5u0I8IwhT81hNc0mFApZ31RVZvCNwhxFMn5wZi6h+nzuFgPsdrzjQ519
         1xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705357874; x=1705962674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BU389mNkDzEVvRO05vUEfufgPBuqhgG3jri0xoOSr4=;
        b=kt5MklJG2N2uYkkf1l7Z7RGi9sTKJjpaPzKMp8wo63sKE4ZooMA48MYqDKD3kRCXcJ
         QYWM2TW7SfF4NGCtcRap8ku73lz1BIkACSYlQIruYJVLKBS9CeWSVmOklPx/Qmh97Qwf
         ofohkjih/EtxZW2EToukO98uyrZ7R554Y9faS4K2Jhoe3wBF1vfsCZdHUBtWzz6CaNC2
         1ECjyPUcjBmaekrlDmL4aXuu3bv+YEaBCkX9EZAzFfOxir1jnRJ1+ZOzmW/QCo7xAdnZ
         SAreiamQylXNY2zkKGkide6uCo+cHhCf1oL1aeeeXra0wXxE9GlH7WTvQod0gQTvyUbJ
         n+aQ==
X-Gm-Message-State: AOJu0YwgfGeszmpEcpZYsYcqw6Cc8FjffI3XNTJKPxGLarcaZunFAjq3
	VQm6+9TPDDEWbjXCx0kgiVut7+wFZbTQRGCP+w==
X-Google-Smtp-Source: AGHT+IGagoARpMjvNWCzOMxyxTHbrSPx7vaTcJgrGQsZyppHUE+yT4iRp73B5Qglif1l+pppeinNiesOG58=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:cd49:0:b0:dbf:4359:326a with SMTP id
 d70-20020a25cd49000000b00dbf4359326amr2476875ybf.1.1705357874082; Mon, 15 Jan
 2024 14:31:14 -0800 (PST)
Date: Mon, 15 Jan 2024 14:31:12 -0800
In-Reply-To: <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com> <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
Message-ID: <owly8r4qi5zj.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
From: Linus Arver <linusa@google.com>
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"


Taylor Blau <me@ttaylorr.com> writes:

> +static int pair_chunk_expect_fn(const unsigned char *chunk_start,
> +				size_t chunk_size,
> +				void *data)
> +{
> +	struct pair_chunk_data *pcd = data;
> +	if (chunk_size / pcd->record_size != pcd->record_nr)
> +		return -1;
> +	*pcd->p = chunk_start;
> +	return 0;
> +}
> +

I don't think this function should assume anything about the inputs
(chunk_size, record_size, nor record_nr). If we are asking the helper to
be the common tool for multiple locations, it should assume even less
about what these inputs could look like.

For example, if record_size is 0 this will lead to a
divide-by-zero. Likewise, if record_nr is zero it doesn't make
sense to check if chunk_size fits into record_size * record_nr.

And even if there are no (unexpected) zero-values involved, shouldn't we
also check for nonsensical comparisons, such as if chunk_size is smaller
than record_size?

I think there are several possibilities:

CHUNK_MISSING   (chunk_size == 0)
CHUNK_TOO_SMALL (chunk_size < record_size)
CHUNK_OK        (chunk_size == record_nr * record_size)
CHUNK_TOO_BIG   (chunk_size > record_size, record_nr * record_size < chunk_size)

And for the CHUNK_TOO_BIG case there are two possibilities --- the
leftover parts of chunk_size that are not accounted by "record_nr *
record_size" are (or are not) "aligned" such that increasing the
record_size by some positive increment could exactly match the
chunk_size. For example, chunk_size = 128, record_size = 8, record_nr =
8. In this case the records account for 64 bytes so we have 128 - 64 =
64 bytes left over, and simply increasing record_nr to 16 could account
for every bytes in chunk_size. If chunk_size in this example was 120 or
130, there would be bytes left over that cannot be accounted for by
adjusting record_size. This divisibility-of-leftover-bytes check could
be done with '%' as mentioned already by others.

So in summary there appear to be the following possibilities:

CHUNK_MISSING
CHUNK_TOO_SMALL
CHUNK_OK
CHUNK_TOO_BIG_ALIGNED
CHUNK_TOO_BIG_MISALIGNED

(on top of the cases where record_* inputs are zero).

And it seems prudent to treat each of the not-OK cases differently
(including how we report error messages) once we know which category we
fall into.
