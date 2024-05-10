Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A44AEFA
	for <git@vger.kernel.org>; Fri, 10 May 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334914; cv=none; b=XLP7+b2Uy5BAAxvuuJbVN4kP8iYZibfO4OnpReCF3++htO9KBg68kvxzw3TJ5Ski0T1fIDLdagDvnhUWpZOrWyKjkN6+8rSk24dlofh7n+xLzmt3O2U1+CwWCZnqkaYyuquao8FRrndCA+1H02+xEFLM/T9KFJfeOK32s3OoJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334914; c=relaxed/simple;
	bh=FagifwMvfgEZ6h5vd6EWD0cGiHHZZvR8j733HfNR4NI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=jkrNDQVlZr6+LrX9uGnp/p/NzZdR81LZzMvz0/HA9jPs7Z+n896Owq7gpE00OyxMRUdPw4TtZ2gmxClDaMTnRin2aVx2vhyQHnj7fykW2ZAKO8DeOsFP72yIYFke/hIKLYYR0ibYAoJft85mnPV+FdyF4GRETMYOinBUG6BetkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A59v4+UV; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A59v4+UV"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23f0d54c5ffso1088344fac.1
        for <git@vger.kernel.org>; Fri, 10 May 2024 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715334912; x=1715939712; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQAxOipOYlKlpvworfVEVSElNmn6R6lXBxfrJYue710=;
        b=A59v4+UVVbKOvc5oUGD5N+H9tA1fdTf1J1ATMl8vqf7idTb1f6e1qFf2bpTp07ASzl
         zSjZzXNdkrfbYp4Yrfe7nZVgPjFCTxevTm4FTYtAgxr2TKs/oxygQSAJbFGqj5/OgyFj
         Lh5y4EUIdG8eO8YIu4DToiiejqbfkuFSYUe7x3OTWFPhp6IBK1Qf3IP0xVJViIt/nHYr
         IHIo1qPTpF/zU6efBEVrKsNJgYT/DFDplVvnP9adUSAuhD7L8i8xvA6jcWaq7xpQ7LMj
         ZVFjRf+SftubJkLwWzuys9TTLroZcPRV9G9m4BQeCKji3fCpgZUjjM1AiMXChev1lg4O
         DC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715334912; x=1715939712;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQAxOipOYlKlpvworfVEVSElNmn6R6lXBxfrJYue710=;
        b=JXvy4JCtHsIOD/omQcPg1BYa78T5b6Zlya1fPvFxffMq2x6Pnn4ZUmrE/W05D7fXX/
         1aTtNUUyT1XlqZeOjiHDL6DrgKXoZbucsoqtFZ+4ERiqAAZZoRyQB/NeqEQVOpBHJ0Xm
         x4Op8tXmCE/GajU3KnPErLqn73tyLBBA+mEpeVIswlb3C4ncTjhRRfMjlaHk4OXgo78W
         /2cYh+L9X1xc5JGK3uiifuPhqGu+jX8paNOSKsXURsNRJ6oL+bwGpnQd9Ec+cl4El0i0
         /wNU+acUrjpaA57hBpPcC+k2iUR6OIkaVZocu0jYTkOt9lohX9Ay40N6WfoJ+ZqDwg0d
         p5DA==
X-Forwarded-Encrypted: i=1; AJvYcCUVpmbfjVXgvKpuPY+CIGtWGvchiqN39qnP7/Dv9g/pH9DbTMeLwkM7DFj365IpLBcdfH99YqCTJydR5UhDLKFSddnK
X-Gm-Message-State: AOJu0Yx3rZqmlEgkEYNhAv6FyprB1coZtx8c8trKRxcezYn5j4UQdGVt
	+pZxYM0tjXrdHk/2yOSJQp395WL75EYhVdkeRHmZ1kQXR5Y3pnAKkM0GfOxY6Cx4//UJrm/jgAi
	hib3ZQAyInXpILkHDefjymTCGliVeJA==
X-Google-Smtp-Source: AGHT+IEG494o4ey+kTTxg7Jbrbpq2Oa65x2Sr5YlF8hfOXcN65HaJDYQGdefmqj13NK4OXOuxjBHCQQffGHr98iM8jY=
X-Received: by 2002:a05:6870:4191:b0:229:e689:7c1b with SMTP id
 586e51a60fabf-24172a3f4a6mr2466296fac.7.1715334911869; Fri, 10 May 2024
 02:55:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 04:55:10 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <30e2e33479a6b6b07a4652e84eebd78f71fb363a.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im> <30e2e33479a6b6b07a4652e84eebd78f71fb363a.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 04:55:10 -0500
Message-ID: <CAOLa=ZQMoYM6L_2jwE9pOVUOV1tLep93m7VGLA00nrpHKdy0Vg@mail.gmail.com>
Subject: Re: [PATCH 10/11] reftable: make the compaction factor configurable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000017e4470618168830"

--00000000000017e4470618168830
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When auto-compacting, the reftable library packs references such that
> the sizes of the tables form a geometric sequence. The factor for this
> geometric sequence is hardcoded to 2 right now. We're about to expose
> this as a config option though, so let's expose the factor via write
> options.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reftable-writer.h |  6 ++++++
>  reftable/stack.c           | 13 +++++++++----
>  reftable/stack.h           |  3 ++-
>  reftable/stack_test.c      |  4 ++--
>  4 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
> index 4cd8ebe6c7..155457b042 100644
> --- a/reftable/reftable-writer.h
> +++ b/reftable/reftable-writer.h
> @@ -49,6 +49,12 @@ struct reftable_write_options {
>
>  	/* boolean: Prevent auto-compaction of tables. */
>  	unsigned disable_auto_compact : 1;
> +
> +	/*
> +	 * Geometric sequence factor used by auto-compaction to decide which
> +	 * tables to compact. Defaults to 2 if unset.
> +	 */
> +	uint8_t auto_compaction_factor;
>  };
>
>  /* reftable_block_stats holds statistics for a single block type */
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 7b4fff7c9e..6b0f8e13e7 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1215,12 +1215,16 @@ static int segment_size(struct segment *s)
>  	return s->end - s->start;
>  }
>
> -struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
> +struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
> +					  uint8_t factor)
>  {
>  	struct segment seg = { 0 };
>  	uint64_t bytes;
>  	size_t i;
>
> +	if (!factor)
> +		factor = 2;
> +

This should probably go in reftable/constants.h

[snip]

--00000000000017e4470618168830
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: edd3673acefbe26a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZOTd2d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUh5Qy85aDREclhEcXpkNHMzbmlMekpYbHVmd1BoUApvY2RPS1ZyYkpL
a1R5akFtT3NRMFB3dnFHUFEzcTJKenlLMXoxK21mMlpjY0RwTmNSYzBjbHJpZFduZVFFOU1nCi94
Y2huWjBZb1JUKy9tRjRFL3N1YytsT1J2NVlRSDdIWEE2aGtYMU5yYTdJM3YrYmdXVU5URGdJZlhE
SHZyZnIKaGdmalVTclVrZkcvQ1VnYlFEbFNheS9vY0lKb091NkZHK3ZFWTNTSktCZ3Iyb0Jhdjg1
V3oxakVRdHFkWTNNNQpRZXZiRC9XT0l1Y3VFYXBPMlllMEtkeDh2Q3g3aFFUaElBWTNFZDQwMTVZ
dnYzb3V3R1NRYXVsdlAzSUFZWklPCkRkZDdvcGFmZVo4YlJGQlJVSUxhcXplTWxjekt2RlhBV291
dGU2Rmd3YlIzNHNGTjArSG5KRnR4cVFWTjhuMm4KQjVhbnlmOHlRQmJ0K3Z0ZHM2TGcrVTZaTk5K
Qit0Z0ZxRXdPcGpUaHJ1TDBoZWNoc1h3NjMyb1lCR2RtZDAzVwpCN1pnL2J1NFJuOTF1YXdPRE1i
dmJqa1dmWFMvY24xMk55SlN3QkZlM0NIUDFXRTBRMVJRNHJMYmtNWVRxUkxOCmQrTG9QYTFCSGUv
SHpWV004aDFuZjI0QmdJek43eXFVTVdmUUJZND0KPUhIODgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000017e4470618168830--
