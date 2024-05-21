Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10799BA53
	for <git@vger.kernel.org>; Tue, 21 May 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298491; cv=none; b=XIh+IL7o8kqGI+aS9a8YA0mH6O5+plqm0HGtnb3KKAB0hkDKR4PXI9vLXhh4/iPvnRiAp7hX1GI3VGK1UKxItl70h0jihsq69Ie2M5Ea4cT9F/nZzYL4E/2Zo/PArPElpprd7MXLxNaoMNjnOw3C83xbYor4bfvHkBNgqPT8AGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298491; c=relaxed/simple;
	bh=4RF63pHqcxAMuJbnebYNGux8pwIr7wIEZ4YpRUiQKHc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZ8Emdwnh6jinWJjIHEmaoW+rM/+cs7ffyqXBbZUm6bQP12dq2u563Prw44bH12vHRHIMboSvOTYpyO1tIRq4VJ9h6cyWRQnxcaNTeHgEr2FD0jw2PaRCDvmzEumK6K31P2TAhy8PXu/2E9CY6jIuOYvQw3Rhzfedo3wBEN07tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot4MepB4; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot4MepB4"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f1016f41e2so1760235a34.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716298489; x=1716903289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBtzZAqWg+51xR5ghzCZtGKCuZrfWpVflQvB3HtrsNw=;
        b=Ot4MepB4P2pGy5sU9H6bLK7uKwnyMWZKX2mpvn3PcFS6OhMN7ix/c5ijqrza33lUua
         2KLv+OOWj9EQG48mTO8mTxgtNnS0h3zr9MgV1hgmKYQs7M19arCv2AVNn69P9HReA8bL
         q1lsXyhWGM4J0NnN9sV7ts6FsrgECLzRqb5KUgc3WSDiIfgmoIkArMVg+cH1I22i5QCK
         TzguDwleUj98XzFoZBHCPiBwGdcQXK2P8eriU91mgEUK1ZQfsZTNDvE0HmgXDMh+s1Ee
         u6bYHqDz3P8Lrf0res/K5Q2Ym7FtNNtjyNFFlq7D7+h12OKHyC5P3T1Q/8UhMnAYwy2V
         61Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716298489; x=1716903289;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBtzZAqWg+51xR5ghzCZtGKCuZrfWpVflQvB3HtrsNw=;
        b=s8KJnZ3oB+8tJ+3cknikntiQtNmtvNkWs/RHUrNaadlPZVytQWbi0Fb6tK4bNmvo7U
         s/3GRz5TUamWPMVnnlbgtTo45rzN0ZH8hOU369Xhp2g6LGnzDQ9mafeBgK5pNS0iBO5r
         byiXrGUGHhusTVvEHGHUJvmnDKGSTUPcRtZBy9N+0taRRaeCq+sfGi+RDrsOTc7XSQSi
         F3yj7AOSl6XAS4b0AiREIYUJl8DMNHAo5j/WyA2kO+aB9y3/3S7rXSbXr/Nbm1ZtgOV0
         +wnQMCQxOsnCtSrTkEaGvPeRg8lWl7zj8XI2iSpv931lS7M+Q01drVLihhnMDUjU6cj+
         qJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWk6z9uWTHRZhjj/LWtcw+S+Z/AGMXB3gbnHjGy6ddPOA1j4i7tObFQzWHW6PJX4uU1pFJvyDL79H7zo0SzHB2AOwz
X-Gm-Message-State: AOJu0Ywx92ZVRbRbYjTIr96z76u9XROOrRuKxlhwoSjjGnJWmk+HF6ZI
	Jpe0BqqBew+rpxYcpRDzuEGY2AE7F996nruyHmuqcZ3juC94Rs0J+W0/leUSA18HFc06nr60Gg6
	ZoDV6qRFCs3QyiHmFwmoC9zloQjg=
X-Google-Smtp-Source: AGHT+IH960uG2tZqizwT0BIGodJAC8CskTqEUVt6YHWB5FlJoge5C1R20Iose15lwALteVIrAtIS0njE2/B/GuG84qs=
X-Received: by 2002:a05:6870:e307:b0:24c:5aff:c37a with SMTP id
 586e51a60fabf-24c5affc5demr874384fac.36.1716298489106; Tue, 21 May 2024
 06:34:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 May 2024 13:34:48 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ca86a8b58dd074287dd2dd352610ffe46e1605b9.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im> <cover.1715589670.git.ps@pks.im> <ca86a8b58dd074287dd2dd352610ffe46e1605b9.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 May 2024 13:34:48 +0000
Message-ID: <CAOLa=ZQb3if7vcvRcOm8qHSMGo=dSv0nsjCk0R_hhRWU_d7wfw@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] reftable/block: use `size_t` to track restart
 point index
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c5b54b0618f6e19c"

--000000000000c5b54b0618f6e19c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `block_reader_restart_offset()` gets the offset of the
> `i`th restart point. `i` is a signed integer though, which is certainly
> not the correct type to track indices like this. Furthermore, both
> callers end up passing a `size_t`.
>
> Refactor the code to use a `size_t` instead.

More of a question for my understanding: Why use `size_t` vs `uint16_t`
here? I'm asking since the restart count is defined as `uint16_t
restart_count` in `struct block_reader`.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index 5942cb4053..00030eee06 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -326,9 +326,9 @@ int block_reader_first_key(const struct block_reader *br, struct strbuf *key)
>  	return 0;
>  }
>
> -static uint32_t block_reader_restart_offset(const struct block_reader *br, int i)
> +static uint32_t block_reader_restart_offset(const struct block_reader *br, size_t idx)
>  {
> -	return get_be24(br->restart_bytes + 3 * i);
> +	return get_be24(br->restart_bytes + 3 * idx);
>  }
>
>  void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
> --
> 2.45.GIT

--000000000000c5b54b0618f6e19c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 60f48924f22030df_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aTW92WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTdmQy80bGpKYlBESDkyMkpxeXMwb3J1QUlPY1hjZwppdm1MeTJxRDBG
OE1uYitJMjd2dExzVjdiQlNGN0o1VTU3VTEwK0Jwd3lLMyt6cTA4WlE0KzhWKzdYWTRRdXMyCmdU
amdTZElQTHZsZUNZOHJ0RVlkelE4Y2c0QWZJZDI0ZFJrbE5HZFJBYmNYTVAyTG9hR2VRWjFUZ3hr
Y2pyd1AKSU9wSDRNS3lYMHpDSmY3VW00NklGaVpHUnhzMmVNb0loQlpTcjF6UklFekNEMUNqc00w
OWdlV3NNSnZvNXpvYQpkc3pNTjlXZUhjK2M5N1BnK040bTY0NUxGUExUbjl5VUNBSnV5NURsZ0gy
OC9FcGNqTVB2V0FRZUpiek1kNkZICjhyZ2xtNWxUQVBkcGlmdjZtWjF4Tmh0cVNVa3pneUY0THM2
Mm1abXhIeWNJTEZ2VW05TEtEaktZQWh3UVJEdWkKZXd6enptd2cxanYrQkFCMjEwRDNmVDhIbEhn
SXo4YmVRZnNDZGNsNWdCaWd4MHhXaThvL2N6ZHBycm56V1JaYgphN0ZOQStSNG9DYUtZcm9uZXo5
QWVmWE9LMHdpeHFtUlVpK0lRV3ViS1IxTHBWSGkxOG1mN0hnMm51aVBzWkNyCm04cVpaeng3TmRD
ZHRlbCtkN3E1TE53ZGozYUxuWHB5bkgwTjlydz0KPVZMS1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c5b54b0618f6e19c--
