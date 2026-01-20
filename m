Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8623793C2
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900171; cv=pass; b=gPE2WaRs5ltNVQWOdwX6SPhxt4G8q32Tf0FXiVZ9vaFL64KBHd6q6JDS0pskNfONmoPcahRRjBJRVyzttwSAemsGl6urcwkAV18NjZVglEBhyXuNeJl66YfRuaiMWli97Qb5yuWrB61IAzO4NGc8e84m3F2JPscGh1YNO056sLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900171; c=relaxed/simple;
	bh=oLsZVSIMXo3sL0KUkjOvaJPzp6FU6w/ESNSvKOHbn0c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=i3/JZshldUjLlr3gC0nS1QMBWw1sYRTTl6prSmsE3IPRDn95mQphc3Z4kOjhkzSwmAv/Xpv+f1O75E2nk0lU3+/oVQB7Lqlyxf4UfxMn0oooH5x8WubC/qv+0u2kSupZoKfyGFsTFl1AsU9PssSGwZdMEpityesAbxVIeCmMUoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9Va/e57; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9Va/e57"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5eea31b5cb7so1755537137.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:09:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768900168; cv=none;
        d=google.com; s=arc-20240605;
        b=NiyVxnul1PIKhsjKRAolpLTg0hUSkBlfbKA166hrhV63eIR5UuJqeqt5B/bbHvGtV/
         SMCB4euMKbKHYG82/1Xfh6kdkhIKclg1Pk12OA2OJj61sk+oZ6GP2kZslpvH7E1CmcZT
         9CQmhZKmzIetEKn4BIq98O6FGhtUYI3FZ9fKUCqJ100YW2XrtYTwwKDRYsfMRI2S5h7u
         0zz6eG0Cc9ln6IFnXAMABNN47LvBBTvPIfikuX/2ael9Svt5l0jcQOafadbeToCA2ru+
         3GGobokc9ZypiYTxprnGn32Jg6VEoKAF6REd67QSghAGPVL8VCmVfJW7PTexg0j4DDI1
         p8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=tzBeJEbbvSfetm7y6wuq9Z0vcKkcf/dWYBNfAW+qeBo=;
        fh=UjBdD/Uhht1d9/gPYn+E87kYfUxa68pL7t43fHEwYbQ=;
        b=FhQbYYTdbyEnH2AgTP6PrSZrqjMAlQVwByDYDVVYogcAUF/AuqwD8+uL5twYl54uic
         sCIeks/z30mzV0Y89luU1JuVOfKY4EyCAlRwEVrpoxrOoFiuGC3QgrFJPJKc/3zcalum
         0/P91cEUojt1WLIb1+KSXTxHIikDY3yCHUEpFfvp9YeFa0345dH8ty3DdlhNB8k3wwah
         NjnNp7eDSXLFXEUyquP5CLmrzs4Oo65K7PnNMJlobSZxcVgq2pfUX3zQQCPojs6mV3ON
         i0udKhb7BXeM6BBY7r9nqSvWg6hv7HBYWRZOajBwd9b8NL8EIQ9smmX0STROl8IbYp5S
         +NCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900168; x=1769504968; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzBeJEbbvSfetm7y6wuq9Z0vcKkcf/dWYBNfAW+qeBo=;
        b=U9Va/e57D4vOZR66BT0TbvaHxkwdKvTKOVpatGBljTYvSbbGV+9Q3cNrgLlCuzbl4x
         PzM7c6Hucu9E8bQhu9SofHkNytYbnxC1bdMIAKGVTN1YBqohqaV4AL2xCsWcN2bTtsDg
         ayj21/rOw6hyF+JSVkuqfre41hXLr+Haw7X8q1qJDdPSbT84E8TJdDmiDZJiitIBb4xL
         FlaZSkXCGPSl6TnitDSTqsiZdVk4CBkMF4L9Mffq+9y/cLJDlULnaeimwpGdHVPX7cgu
         b3zilP/qL5pL2ui/4nLjMX5DoaKYMsEYR1//VI492eB9EV83ekSTpb0dFKMg+zR45nPn
         NIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900168; x=1769504968;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzBeJEbbvSfetm7y6wuq9Z0vcKkcf/dWYBNfAW+qeBo=;
        b=FXSejZyl1eaphLihogYRbYX7Z+lGbx202AX0bOAZSQEJLRIoa7J7S2LnpeJKn4A6CM
         Lqmw33qxzJn78O/vccTPG6uoVp1YOWtI0eAU5Jxv98UAza5gO6z7DNRTvkRDkdjFny67
         rYhfRYnO+z/RqFmMCHuFysGNEGzv/XrlwnoZp3VhwgRP+d2Bm5nmWa1Yfzlruq+Hus68
         1bvE55YhLfiipBm6HLoqueqycSJkIxh28qdsKn4lTV8yOdhbPVA7e3x0fKrELJiMpV4g
         sLdhczEvQZr7Lje1xVvbBdox05LBOoavUfrMcn+/h+kAwNy9Nom2eHBinAsYaZrOIyB5
         /LQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXk1TfeGgztsj0E03q5mA9YZklvYCEfMXNlaGGgro+8GAECnd39QVE2J8BjeAVnwNIscc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2idOwMkMSeIR2Vytkanh4wfBD8gJVdl1766PZ7xmPInDDlFjT
	kaGzRVM9MyaaJ3RisYZXGSY95G4c1Etmm3A46qOJn7zeBOVJOx0/OyWQB0bR4r5fItClGFJhMHx
	tjdJmbgBjMRq5kEy8q7B0W3XYKseVssWZwQ==
X-Gm-Gg: AZuq6aLHnWjP9wFgp0IvMbZXxzsSW2dDL8FqB5SdVyuJ38/DtTU8eZoeY8ktOY6l09c
	N25xEKF5xOEH1qNqbua8B1dLKL5az9kbQa86F9rXY2VYj+AXhoiTrcXFgi4/U42yr3ovAonKjtT
	vIcgjMDrX6+euDroUJaVZQPdOM4LKGWnE9xz5FfHWVCPdv8hSWNhaQY0s5QNj7d0uRLnPTAFQWQ
	c9z1IIo0/F49z/Q/W9cjJHNeb9uqDRwThObQzerJrBNh5EtJxSpdkQ+bDtCEXEYB+Kj7aN9wfBj
	tr0+qq6j/J+qVdKU5Nljwg30YCSOJduj0ehibdii
X-Received: by 2002:a05:6102:6cf:b0:5ee:a2a8:2e73 with SMTP id
 ada2fe7eead31-5f1a551ef9amr4000723137.26.1768900167624; Tue, 20 Jan 2026
 01:09:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Jan 2026 09:09:26 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Jan 2026 09:09:26 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-3-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im> <20260115-pks-odb-for-each-object-v1-3-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Jan 2026 09:09:26 +0000
X-Gm-Features: AZwV_QhKrAmgVJo7UNb2YKuTEJMdeff6q9v5nAXdqL9dKSq86qSC8cQdcdLWDhc
Message-ID: <CAOLa=ZSt68cb+5hOwP9R8yKOXVDybSSdmmn32TyM4bq0ircygg@mail.gmail.com>
Subject: Re: [PATCH 03/14] object-file: extract function to read object info
 from path
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000022859e0648ce2a59"

--00000000000022859e0648ce2a59
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Extract a new function that allows us to read object info for a specific
> loose object via a user-supplied path. This function will be used in a
> subsequent commit.
>
> Note that this also allows us to drop `stat_loose_object()`, which is
> a simple wrapper around `odb_loose_path()` plus lstat(3p).
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 8fa461dd59..a651129426 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -165,30 +165,13 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
>  }
>
>  /*
> - * Find "oid" as a loose object in given source.
> - * Returns 0 on success, negative on failure.
> + * Find "oid" as a loose object in given source, open the object and return its
> + * file descriptor. Returns the file descriptor on success, negative on failure.
>   *
>   * The "path" out-parameter will give the path of the object we found (if any).
>   * Note that it may point to static storage and is only valid until another
>   * call to stat_loose_object().
>   */
> -static int stat_loose_object(struct odb_source_loose *loose,
> -			     const struct object_id *oid,
> -			     struct stat *st, const char **path)
> -{
> -	static struct strbuf buf = STRBUF_INIT;
> -
> -	*path = odb_loose_path(loose->source, &buf, oid);
> -	if (!lstat(*path, st))
> -		return 0;
> -
> -	return -1;
> -}
> -
> -/*
> - * Like stat_loose_object(), but actually open the object and return the
> - * descriptor. See the caveats on the "path" parameter above.
> - */
>  static int open_loose_object(struct odb_source_loose *loose,
>  			     const struct object_id *oid, const char **path)
>  {
> @@ -412,7 +395,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
>  	return 0;
>  }
>
> -int odb_source_loose_read_object_info(struct odb_source *source,
> +static int read_object_info_from_path(struct odb_source *source,
> +				      const char *path,
>  				      const struct object_id *oid,
>  				      struct object_info *oi,
>  				      unsigned flags)
> @@ -420,7 +404,6 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  	int ret;
>  	int fd;
>  	unsigned long mapsize;
> -	const char *path;
>  	void *map = NULL;
>  	git_zstream stream, *stream_to_end = NULL;
>  	char hdr[MAX_HEADER_LEN];
> @@ -443,7 +426,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  			goto out;
>  		}
>
> -		if (stat_loose_object(source->loose, oid, &st, &path) < 0) {
> +		if (lstat(path, &st) < 0) {
>  			ret = -1;
>  			goto out;
>  		}
> @@ -455,7 +438,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  		goto out;
>  	}
>
> -	fd = open_loose_object(source->loose, oid, &path);

Okay, so with this change, there's only one user of
`open_loose_object()` left. I don't see any cleanups needed there.

> +	fd = git_open(path);
>  	if (fd < 0) {
>  		if (errno != ENOENT)
>  			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
> @@ -534,6 +517,16 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  	return ret;
>  }
>
> +int odb_source_loose_read_object_info(struct odb_source *source,
> +				      const struct object_id *oid,
> +				      struct object_info *oi,
> +				      unsigned flags)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +	odb_loose_path(source, &buf, oid);
> +	return read_object_info_from_path(source, buf.buf, oid, oi, flags);
> +}
> +

I was a bit confused why we extracted out obd_loose_path() out, but that
should be explained in the next commit.

Looks good.

>  static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
>  			     const void *buf, unsigned long len,
>  			     struct object_id *oid,
>
> --
> 2.52.0.660.gd05f3a8ea5.dirty

--00000000000022859e0648ce2a59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 60ead0efd8d76c3e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sdlJrSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejRJQy85Z0diZ0o2WFE3bDNQMEN6YzNmWFlEd1pxbQpvdEdaNnFSTWtH
ZmtSTG96TjhBY293ZzQ0cGhoYUdSUFc3YUh0ZGZ6US9nVlFhZzhEV1IxNURtNFE0czY0ZWRpCjh1
ekd0bitIamZhaXpJTkVSNzhBUXI5Rlg2YW82SlBsSHJNNXJwTEFHMlVDby9za3R4aWdNOEsybkhl
azdUeDYKUmVEWjZVME56OUpkd0ZkdXI5eXpFU2lkYXBOdTg0dkVhS0pCOUNBRk4yOXN3Zys2ZXNF
dGVkaGJzKy8xNDNnUApGTUJPR0UzNTYzRlhKNTBMUjFaSFpOQThnQ0kwQ3ZyWmJ3NTZJSDQyZnlX
V0w4NkRGMjFQb1Z4bElVdTBTcndkCm9HRkhKNjM5RjUzcmI0QldvZlFSb2czMkoxT3NNMFFIaldh
ODlvREdiNjEvVWhNQ0pXQ0dsclJLejRVUU1MWlAKRk41WC83YjZaUStWeWpnWFFvamdWVi9xUjdD
aWNkUzYrcFZvbTd3WHJpNkpKeExyNWZDdll1T3owcnlKZGNIcwpFcTBkQzZmZFJTclhZa05HcjRr
dW1MVzRMN3NIdmJyRHp3MFExN2FTZTdWQzFYMGxZYzFjUWt6WUh4QVZKdk9OCjVMNzBxOEdFL1Zj
ZjJncE1YLzRlVjBMOWg5a1JGZEMzOWlQRytxOD0KPXVPLzgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000022859e0648ce2a59--
