Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09D171652
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374583; cv=none; b=lRt1vU3eJpw11oDAsJkVfI0RQ08bxdlop+4sMWIvcvZESY+McMB+K40pNB9agvFbxhWVp423eyNaazR42S5bQpBoQ5ldBYDI9yxpsgwCcMym/mDmi522NIcRitcxHT+Bcry/ldaACvlhEKDhfY7iQBEJu/dp7k6iIuwtnc3xozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374583; c=relaxed/simple;
	bh=8MGWwwyZr2grrSnpt+qg6kZV2h7X/yufHnNgVGRX4+s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=VE0MGuUh63MOwiKPxC7TBEXzp1Xi1YTClKFHB+/1Tqdw826c8+HsLJ27SFrvXXJB6LcghPR03yzWNWZQ3qw74Rquzn71Hkb93cnI0t0EOI5J3X7yIqgZdQWIIwyc8GQBm+GS0Gymw9VSXtFciNl/hRcFOzzK80FcNjz/dP+oJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnHZIHmX; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnHZIHmX"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22e6b61d652so21578fac.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713374581; x=1713979381; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bvxnWMwh7SEHRlJ6E7oeR5tuNFYr8DU0I1tPGSDGS4=;
        b=BnHZIHmXYo8x5ij/k688XW+As8+gc4Tj/S+pvPid/RvKNvXqepj59sczDcakdFcrSd
         HWMuMRNAiIaWWYyzFvtSQY6lUMeZfBSd/fVvW9bRERQTc+L4lxhNw21EP2fs+SpJPHI/
         /QyZ1pX3n4Kw2tfoCgolGQJa0nx3DbjP0tSgB8j+KePm5zCG7YuP2U6/+gfoozGHVbf6
         46vOGo1iGHk4wdYwxsaMVQJvD2YrY6tDTg9oHsju7XaF1viDGo9QsNh8X6U4gIygZjuM
         7/74Ipf74LYFPlF9bJ85VUklYL9cb2mDz1nuUvFEdDdxicEJo4iQXh7p0gjAoNpqv736
         4zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374581; x=1713979381;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bvxnWMwh7SEHRlJ6E7oeR5tuNFYr8DU0I1tPGSDGS4=;
        b=LTHDglF6piPCcFo1vSmkOOLzpQYyvnsqZ4iehebzVYOgs7Dn5WkUNQSIwLAYH/TLjV
         MwoZO8KM1wXckOikKBgcpg/4CebacCbmJQbzyrhdHPmdEuug9yr4ivIgujw5bVsgYH7f
         UAh+aeaYSuPdPLejR85lp0aOIsYQFfxGYJ814L2dq0WZHwqz9YkHSvhSAZaMzaNJGjaF
         8ZtgurkF85CBldODm7NDRPSA3NydAmZsSdx7Qy4ah3G1OV9H2FLEVL1gkR8RSTatDbkX
         CE4/A9YIacht5oo/lf9MwUGITVxclPCtxZrtuChBg74qeqEpDyzGKL25OeaHEZKKVRMz
         wb8A==
X-Forwarded-Encrypted: i=1; AJvYcCUthWumboTVvyU+de1L6RfSEoFOjLp1aXVJn0BLVLggK5BOE2eFybMQ06pUgD5X/v2ZfRt1WFQZYIx4HI1JRZxi53SF
X-Gm-Message-State: AOJu0YwN3t8sP91JdQLoVZ4vkZIGE51G6f12ghT9GRL/VBddA5WMm0Ml
	zfQxoIjauwBMIjBZ4O63EBLaxOIHJG+ezncuEn781y4ggtyqOrHNB1lO+JZo3C2oYmzRJb1HHnO
	/sTl+jgfJHUQEB5UDK/cHghFtVmoErA==
X-Google-Smtp-Source: AGHT+IGLQxCGjKlhzfWKVUlsLXRlGxlf0WpxOZ90QXg/HlD/oqDOlfC9m2NpT7dYHAZ+KGxKEgSgfQzSwoR1OCVykoU=
X-Received: by 2002:a05:6870:e8c5:b0:232:fa71:1690 with SMTP id
 r5-20020a056870e8c500b00232fa711690mr230335oan.30.1713374581415; Wed, 17 Apr
 2024 10:23:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Apr 2024 17:23:00 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7b5ec04efc89af6874461d967bf5f61939e054dd.1713180749.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im> <7b5ec04efc89af6874461d967bf5f61939e054dd.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Apr 2024 17:23:00 +0000
Message-ID: <CAOLa=ZQMcxHqXwEZGTAaa4Em6wx_Bx5OWR4qqy79woh2n-bwHw@mail.gmail.com>
Subject: Re: [PATCH 1/5] t/helper: stop using `the_index`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004afccc06164e1b1b"

--0000000000004afccc06164e1b1b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Convert test-helper tools to use `the_repository->index` instead of
> `the_index`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/helper/test-cache-tree.c           | 17 ++++++------
>  t/helper/test-dump-cache-tree.c      |  5 ++--
>  t/helper/test-dump-split-index.c     | 11 ++++----
>  t/helper/test-dump-untracked-cache.c |  3 +--
>  t/helper/test-lazy-init-name-hash.c  | 39 ++++++++++++++--------------
>  t/helper/test-read-cache.c           |  9 +++----
>  t/helper/test-scrap-cache-tree.c     |  7 +++--
>  t/helper/test-write-cache.c          |  3 +--
>  8 files changed, 43 insertions(+), 51 deletions(-)
>
> diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
> index e7236392c8..dc89ecfd71 100644
> --- a/t/helper/test-cache-tree.c
> +++ b/t/helper/test-cache-tree.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_INDEX_VARIABLE
>

Nit: It would've been nice to mention what this macro is used for.
Perhaps maybe in the cover letter since its removed from all the commits.

--0000000000004afccc06164e1b1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 58071caeebe2b6a5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZZ0JYTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnBlREFDZUhSem9ycWF6aGh3SVdFUytDdEplcU1XOApQTUNXN0VXenYv
Q09LZmJXUHI1L0xkN1BDeTJVYUVqYXl3K09YR21CcUpud3FHdTE4WkljOFFIWUQ3Nkg5d2JlCnQ1
VUh4OU1RYzhyTjdyemxrbHZQdUpQMEszd29mVjQ5azBoM2ZpTmYxbkt1eDRwVXB0L1J5S0pmVUUr
RkZlRG4KWVRyVGdBZ2JMb0I4YmJNbjNRWnZqL29jRWYwS3F3aW9nckgzakJ5U0swRW50Z3FuSm1G
M2ExekxvRXlsNUV6cQphd1J4VFZ0eHBKRko4eUVOVXB6dVhSSnc1VTY2R3BZU3ByRFhGd1ZXMFph
Z3BzU2lWeFpLZnIrMXExN3MrYXhZCjVsNHMvaEdXR2ZMMFdOUVBCbHFHS3pRRFROSFF6N21FZEw1
RDZqMlhPL1BmTDl3RS9XVGRjNzJ6Z0VvMU9ZZ2cKU0k2TUVSVFNob294cEdGWlN4YWRCaXZQUWNi
VGxHQzUwamtRQXBRTVppelhVKzMvWlptd2ZtZ09PanNxSnJlNQpSOElmaFJJR3NUV2FTQ0oxTDB0
eTU5dnkybGt3TkJsZk8rQW1GSUNWMkhtV0x3OG9kTHFaeDJhMGJrRGxwUE1PCk5BRGhNNFZRc0tF
a3h1WkxsRHoyNDNwY1RxZHNYQkRBK2t5K200RT0KPS9sUlkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004afccc06164e1b1b--
