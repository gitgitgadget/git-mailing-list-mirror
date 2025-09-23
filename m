Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72B1A23B9
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641952; cv=none; b=WVDeYbhFeeu/1XqPZ8iiMESzSgSNMjg3j00pdhnSmKUvHN+r+avr28gjZqF+7ZTj2T1xpb0+yK0osUgAtdMRvNvQAGDyXVWsTo1kaws5AWxrD1H1D88kKXhBS8A/Z+UMtY0Z2wSRe1N1cJZM8m1O1D91JSBFrD1fANRNoUOJduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641952; c=relaxed/simple;
	bh=Q5wP19M1/v9XsUDYGJC7WFiFXGlMF+g7jo3Uu5HOq8U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ldnCBpJZQb9wxWRaIokQsr4oafSpiq4ECrWQgvUBjrvmXScRMQ6Um3RzSgc2wGLDy+wUC9URkAi4yXd0UIEWw+ZrqFnwO/sKLHRkAJAwj4cKQSFBdTkvXrhRPpK1LvOdvenntdKWBS2+MQzuPHo5EpM+U7Ek8IWC1xIuiLVmcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSbC8TdL; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSbC8TdL"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-51d14932f27so1989168137.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758641950; x=1759246750; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4dfSLQClYB9zqOqNzEhKujpH66ibKWQFqgMh9/oJmS4=;
        b=jSbC8TdLSL6PaQSAUQBVxORd3Ebqg8vLS9Vb/bzt/IHLrmersgc/3N/ZD5Z47Om341
         HKgJHO14OhdHufaHXs0w62V7H4bhELzWbd4YEjVpwjAbjEB8fuwF/ofvgBVKtE6xFO22
         hJLsymoR3ffW/ZCNEeFr7doIp4U0Fw08mJmlImbRBEQZz9VJiK+8ZI+LXZaAHQP06gSy
         fGId1VmDJVjsQggvSPgXvfnNymQBa6S2BDfxdyqI/PkRxbarJLb7ciH0fdHzz1bmPGiT
         GIvTDKbTjQdhgAAKgFtxxbScKGOLGt1jpA8blqPFRq11Bgz5uZrL1C5ZAnfr/jZJdi3G
         cqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641950; x=1759246750;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dfSLQClYB9zqOqNzEhKujpH66ibKWQFqgMh9/oJmS4=;
        b=CWo1Z0FwuRzVjfDUDj74MOkdG6PJ0d9zeLU1PrcnjLpTplLPDDUKgbBtyf0BiBFz61
         vzndpWx7hYJvgXQ++tJYvFVuGEsEGW2vQa25IIS7i116XP7zCHUFtEg4bw+Xm2K9Ecjc
         wuPMti3hgZcAowmVFhVX8j1APhQram9iLYUhpm+VxEyAvg0ma3KydYgIXg//YxzA0B1k
         mTjGfIbkzulSI130oV6kYAzIssZEtRVUumWDHkC0wxUTvRv1ACt/X4krFFmNscaFmUNs
         mDCuRN1C06iFPTQViDBJV3utCPgFxglnIo2D5RkCiOjZjphpQPl9MHClLnmgZEazws1j
         mnyg==
X-Forwarded-Encrypted: i=1; AJvYcCV0zJiD5qvO473cNw+tJnC7uFLjg9hvqLTkTht1SBZcE7Y/ek/8R8Jw77uUco2CJLZz8Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygB44fl+o6Ih3PDIQ2cV8UQi2yTWPekyLzTb5y75iQUoc9FQ3a
	lxoD3wHgZl8I29R9fydACVTHAlVPCQDmFgDnSkPkHYt9XUKwda3xqkGk1cVRpt/exulphGnHTd1
	t1rFbA0kRW6btiWCKFdVIaV52NvLCgts=
X-Gm-Gg: ASbGncu56JCDPIKQYmRHh+wxKopkkmmrDCyRCXCoYWJKAqVwDn+HNXmVUHiQRZWnsRK
	keriibtckQCv0tlQcW+HgPD9OYCIjFV5YRi0Ph6qVGtyXPiVNUrrkXq0F5dsFwNSqYTK5qgmaYp
	CyZrDFCT2bf1LUGrq+jgqQ8u3JiBL38aVQmco43Y8ub/MXfezjbrwp9i23ZNyq2hpeuGoukL04G
	XUY1bU=
X-Google-Smtp-Source: AGHT+IEoP/WZQ5J77WHHikb+vhCbVGxfomKPmEBkrjf1mTIHNfjlrb8wbH/Qns+9Xhkts3bWjTD7mA9u/y6Lovr6ssI=
X-Received: by 2002:a05:6102:5111:b0:593:6029:39ea with SMTP id
 ada2fe7eead31-5a579b1ba30mr1073058137.31.1758641949532; Tue, 23 Sep 2025
 08:39:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 11:39:08 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 11:39:08 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250923025700.3046260-4-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com> <20250923025700.3046260-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 11:39:08 -0400
X-Gm-Features: AS18NWCSYmCmxhnSW3XzGtMFgIfRDF1MTiAUmRCyVto_M-LL7SJ3LQ_W_1-J6w0
Message-ID: <CAOLa=ZT0y-WOOFz8FdLm40AqwEATzNsg2fzvnJKPzx2mkPiz-g@mail.gmail.com>
Subject: Re: [PATCH 3/4] builtin/repo: add keyvalue format for stats
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b07eac063f79bcc9"

--000000000000b07eac063f79bcc9
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 2a67abfca8..7d0341e4f1 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
> -git repo stats
> +git repo stats [--format=(table|keyvalue)]
>
>  DESCRIPTION
>  -----------
> @@ -44,12 +44,22 @@ supported:
>  +
>  `-z` is an alias for `--format=nul`.
>
> -stats::
> +`stats [--format=(table|keyvalue)]`::
>  	Retrieve stats about the current repository. All references and
>  	reachable objects in the repository are categorized and counted
>  	accordingly.
>  +
> -The table output format may change and is not intended for machine parsing.
> +The output format can be chosen through the flag `--format`. Two formats are
> +supported:
> ++
> +`table`:::
> +	Outputs repository stats in a human-friendly table and is used by
> +	default. This format may change and is not intended for machine
> +	parsing.
> +
> +`keyvalue`:::
> +	Each line of output contains a key-value pair of a repostiory stat. The

s/repostiory/repository

> +	'=' character is used to delimit between the key and the value.
>

Does each value end with a newline or with a NUL? We should mention
that here.

[snip]

> +static void stats_print(struct stats *stats)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "\n",
> +		    (uintmax_t)stats->refs.branches);
> +	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "\n",
> +		    (uintmax_t)stats->refs.tags);
> +	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "\n",
> +		    (uintmax_t)stats->refs.remotes);
> +	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "\n",
> +		    (uintmax_t)stats->refs.others);
> +
> +	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "\n",
> +		    (uintmax_t)stats->objects.commits);
> +	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "\n",
> +		    (uintmax_t)stats->objects.trees);
> +	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "\n",
> +		    (uintmax_t)stats->objects.blobs);
> +	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "\n",
> +		    (uintmax_t)stats->objects.tags);
> +
> +	fwrite(buf.buf, sizeof(char), buf.len, stdout);
> +	strbuf_release(&buf);
> +}
> +

Okay so newline delimeted, similar to 'git repo info'.

>  static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
>  {
>  	for (int i = 0; i < refs->nr; i++) {
> @@ -359,9 +390,16 @@ static void stats_count_objects(struct object_stats *stats,
>  	path_walk_info_clear(&info);
>  }
>
> -static int repo_stats(int argc UNUSED, const char **argv UNUSED,
> -		      const char *prefix, struct repository *repo)
> +static int repo_stats(int argc, const char **argv, const char *prefix,
> +		      struct repository *repo)
>  {
> +	enum output_format format = FORMAT_TABLE;
> +	struct option options[] = {
> +		OPT_CALLBACK_F(0, "format", &format, N_("format"),
> +			       N_("output format"),
> +			       PARSE_OPT_NONEG, parse_format_cb),
> +		OPT_END()
> +	};
>  	struct ref_filter filter = REF_FILTER_INIT;
>  	struct strvec ref_patterns = STRVEC_INIT;
>  	struct stats_table table = { 0 };
> @@ -369,6 +407,10 @@ static int repo_stats(int argc UNUSED, const char **argv UNUSED,
>  	struct stats stats = { 0 };
>  	struct rev_info revs;
>
> +	parse_options(argc, argv, prefix, options, repo_usage, 0);
> +	if (format == FORMAT_NUL_TERMINATED)
> +		die(_("nul format not yet supported"));
> +

Okay I forsee the next patch adding this support.

The patch looks good!

[snip]

--000000000000b07eac063f79bcc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7caf2b05508fe32e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU3Z4a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdy9RQy80Z3JzQ1c4WUxXZjJjWUNjWDV5NTdKUEVFLwoyTzloMDJoWlZw
Wmt1VmFLSUduRUh6cjNxS29CYkVXUlgrVHh0U0VMUmxoM1FIMFByZXAvcVJtbzRtZ0FxN1RkCkUx
ciszUDRMYW1meWtaeEg4OXlTbmx5QVFFczVWZDFkdVRiWlFtT3VyMFJKRCs5bzE4VkhDaWhGUzBv
Qk8zVFMKM3NYcE1yNWY2WlFoRWY4Q2pnWUhrY2t4NVJwMUEwbzkybUFwcGVtM09EV1gweTZWVXdO
YmkvbjFJS29LcVVldwpPZ1hna0hJOFRlQzhMcXE4NVlMeEM5UjlXTUpTWU5KczM2dVhiM2xIVUtC
dktrUENLNjE4NFFYVDVPeVhZdEU3ClYrRzdWaHREZ2dTTEdFNGFKL2F1UlJzSlJqYnpyYW1mRVYr
VytVVnlxVEQ2RVV6TnhLS0phRk1DRTlPZ1RTZmQKa1RpSzN3L2gyUGJCUm9HS2owdVMvU2pDYWlJ
Qk5UQXBBTHlSMFl3c0U1OEhNTGpKRjZzdG5yWCtSRVc0WVlFcwpOMEF2bUtXWlZIRDRta2I2bVhG
ZVR5Ny9JaVBxbzI4RWYwajB4NDBZbWtTRUZFQjk5Rlk3WEpjc2VXcUc1VjJGCjNsWVhEVCt4WnJG
OEZkNHRLSVlUNm1yR3BvZVcvcXZEVFNzVDExdz0KPUh6OVoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b07eac063f79bcc9--
