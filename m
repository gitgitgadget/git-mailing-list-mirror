Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D079DA
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163896; cv=none; b=tC/9B+qhCI3jCGxkaeLWjoQGD/gTJ6i1ZghtjE22yVCA+sGMN30liAn3ryRWnfw0IhoxMLOGbGgAZbEONsr+hcMMVme7oK+F3j0IHQcjVN/d6tAp+JU57xYXDdV07sPKVUMaGa+acypZ+cti/p5QPD6CQMNG6MxGql93UgwS4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163896; c=relaxed/simple;
	bh=y3nwVB372ziVtjIF3viJmPFujGhHSt9g7l89TRFB8v8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ViEOCzkBUEbr0eVsrho0WQP61hFY6Mdf21k72C7qcPHo7t9lI92IX+RKKpPfatQchgW43CY0juWUw+ThjkRXtj+yJxL+uKiOVQMWp3rvU7G5HQklj9wz2lVFbmYjgB4yUKtFgGWpLc40mjWHvkxONcRl8kmYd5TcFW+EYDah3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNJA+Dgq; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNJA+Dgq"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so1863016241.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764163893; x=1764768693; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gy9LdVWjOfhcPCMt9UNYssGgy48ZBCMnmicDI/9mqc8=;
        b=BNJA+DgqXRXQQYzySzF0PjoECM9zv63NLlbC1JSAhpoj81By902QhLdDFYfqe7uPnU
         rFQhWIJ/yuil5wzpHJ5V3rOeT5C/oBiqxIR2YioI043XgWdWhhmsLzp7cbMII4uXqIEJ
         x41GoxNTtTDq4nIFfLph8rnfKvjJ4XpUEPJoZVxtuox6vc/41ug7bwfpHdi0dUOZwAr+
         tE0pjhTCQvoFvHi/WFehfBGzWT6lNAFcmzsUkDn3DNYeOGjI2kb6pRE2yVLmydp6adpH
         8bdkn/sxZnSabxeHqs72KRsanHGzg7A/QgJTMl+D4oLK7pj+AjahGp5JY/YXFhF18x/J
         BhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764163893; x=1764768693;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gy9LdVWjOfhcPCMt9UNYssGgy48ZBCMnmicDI/9mqc8=;
        b=vSXZm5oDL0JtZ1dVXVfPy1LOwqkQRlnNYHbTdiqsB5LdHdpi865Wg9Wnyb1QsFZ7d0
         Xod6shENPhVifvUGlr8KlvEzE6NpyR5OAwxieWB0WvM9fYkC1Htla4Ok3BchDnm7E1EW
         LD+WPymC9FV9ArIH+pSgHIzi2ldfe/L0D3g0H0QJJpDbCpM6fFoU7wGeFR0lbcnmdxc6
         7dd9oyzkml4MPyb0Kot0IdZJyB+OCqZvANRXPgvPnchL3u+6MimC8vjpVTlI352XIH4l
         nnIgiItwn4kH7lv/EdV6WboPsUSCk2XQlUA3ppPxRFfKOKYqKHQp+b4O+ihqOHxsL3+E
         VBrA==
X-Forwarded-Encrypted: i=1; AJvYcCUFoWc19/Zfm+bVG1FkmRdCZcffjinV8GvVJq9Lu7HVCnuQ1tFE+3ThU3WvCkgxTsK52Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHRCTTZxdiO8I3zjaGf0tJZDRnPF6aquC8d9E8mLYsaUNgDyzr
	nGgRhahjrSj8zTWNwQHfOFuqBedpVwlo2lcmybEiXeQ0/CiEtxBXOl3Q0ayAKgiMeEF2A04IzlZ
	9D9nkB3uDKQ01Q72doCeGqicLnpbSsbxpHw==
X-Gm-Gg: ASbGncsOmYdreaTj3+i1T3t6vw/zXBOpU+908Ik/dAqjzAjPbGv0cjHqvGbeLghOWaX
	uFUvVmYgFJTumCvPUDGP0z7GATtPQw0eZo1tuBvT+aEq8WzaqeMLpue51iGKxOOqWT2kPG6KU7I
	Azhk3vuf6sQD0EWoAuI3O6Cs/lXuU9+8XEgrvfXwPRkgwrYjtZwG4qRzDNbt3nEobdz6M+0pbKp
	Eh2kkbdlnhwu7QUMcPomS56G4h1EqsVkO4dwmuN2f2UCe/xlbUyZUY805te41930NIboTo53mPN
	bYxu1iaMqJIU9LrebyToo0uMAMNwaw==
X-Google-Smtp-Source: AGHT+IEuLhLk/EyuTfW5u1XpuQ0JhVLF2i1AOVEoV4RA1JbNHsL8Mcto6uNcl+i8eumnTb07PAr407K955Z7AVFjaAw=
X-Received: by 2002:a05:6102:c4f:b0:5db:cfb2:e619 with SMTP id
 ada2fe7eead31-5e1de3c0ee6mr7127666137.20.1764163893522; Wed, 26 Nov 2025
 05:31:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Nov 2025 05:31:32 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Nov 2025 05:31:32 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-2-608350df0caa@iotcl.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com> <20251126-toon-last-modified-zzzz-v1-2-608350df0caa@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Nov 2025 05:31:32 -0800
X-Gm-Features: AWmQ_bkwcYdX03-2hlYlW4K53yf1_4-E3ISfjMPGsU2_Ej6cXvta940yJqakz6U
Message-ID: <CAOLa=ZSbV6SeJ9orOz0T+oh3PVhYhTsaxrsYVkr+5q7i_tsVCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] last-modified: document option --max-depth
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000331d8306447f6aab"

--000000000000331d8306447f6aab
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Option --max-depth is supported by git-last-modified(1), because it was
> added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
> max-depth parameter, 2025-08-07).
>

At this point, does it make more sense to link the respective sections
within 'Documentation/diff-options.adoc' as done by many other commands?
This would ensure that we don't have to repeat the documentation.

> This option is useful for everyday use of the git-last-modified(1)
> command, so document it's existence in the man page and `-h` output.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-last-modified.adoc |  9 ++++++++-
>  builtin/last-modified.c              | 12 +++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
> index cd4a5040b0..8409daebe9 100644
> --- a/Documentation/git-last-modified.adoc
> +++ b/Documentation/git-last-modified.adoc
> @@ -9,7 +9,8 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
>  SYNOPSIS
>  --------
>  [synopsis]
> -git last-modified [--recursive] [--show-trees] [-z] [<revision-range>] [[--] <path>...]
> +git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]
> +	[<revision-range>] [[--] <path>...]
>
>  DESCRIPTION
>  -----------
> @@ -32,6 +33,12 @@ OPTIONS
>  	Show tree entries even when recursing into them. It has no effect
>  	without `--recursive`.
>
> +`--max-depth=<depth>`::
> +	For each pathspec given on the command line, descend at most `<depth>`
> +	levels of directories. A negative value means no limit.
> +	Setting a positive value implies `--recursive`.
> +	Cannot be combined with wildcards in the pathspec.
> +
>  `-z`::
>  	Terminate each line with a _NUL_ rather than a newline.
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 9206bbdc1d..ccb7ff66d4 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -25,6 +25,7 @@
>
>  #define LAST_MODIFIED_INIT { \
>  	.line_termination = '\n', \
> +	.max_depth = -1, \
>  }
>
>  struct last_modified_entry {
> @@ -60,6 +61,7 @@ struct last_modified {
>  	bool recursive;
>  	bool show_trees;
>  	int line_termination;
> +	int max_depth;
>

Should this be signed?

>  	const char **all_paths;
>  	size_t all_paths_nr;
> @@ -487,6 +489,12 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>  	lm->rev.diffopt.flags.recursive = lm->recursive;
>  	lm->rev.diffopt.flags.tree_in_recursive = lm->show_trees;
>
> +	if (lm->max_depth >= 0) {
> +		lm->rev.diffopt.flags.recursive = 1;
> +		lm->rev.diffopt.max_depth = lm->max_depth;
> +		lm->rev.diffopt.max_depth_valid = 1;
> +	}
> +

Or if our goal is to actually handle them within the
'git-last-modified(1)' command, shouldn't we ensure we don't allow any
additional flags from being parsed as diffopt?

Currently other diffopts flags such as '--no-prefix', '--cc' and so on,
are parsed even if they don't affect the output of
'git-last-modified(1)'. Shouldn't we disallow such behavior?

>  	argc = setup_revisions(argc, argv, &lm->rev, NULL);
>  	if (argc > 1) {
>  		error(_("unknown last-modified argument: %s"), argv[1]);
> @@ -515,7 +523,7 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>  	struct last_modified lm = LAST_MODIFIED_INIT;
>
>  	const char * const last_modified_usage[] = {
> -		N_("git last-modified [--recursive] [--show-trees] [-z] "
> +		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z] "
>  		   "[<revision-range>] [[--] <path>...]"),
>  		NULL
>  	};
> @@ -525,6 +533,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>  			 N_("recurse into subtrees")),
>  		OPT_BOOL('t', "show-trees", &lm.show_trees,
>  			 N_("show tree entries when recursing into subtrees")),
> +		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
> +			N_("maximum tree depth to recurse"), PARSE_OPT_NONEG),
>  		OPT_SET_INT('z', NULL, &lm.line_termination,
>  			N_("lines are separated with NUL character"), '\0'),
>  		OPT_END()
>
> --
> 2.51.2

--000000000000331d8306447f6aab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f95b556ee9901362_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rbkFTZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mektvQy85WjFNdjU0VGY4dUZFYVhGVlpjVHZrMVhzcwo1dFAwdkZoSDdU
ZkZQOHpPQm12T1QyNTN6WC9JbjFEd1JFOXhnRjhDaGd4K2dWejNTcWFFRzhXb2V5K1FqTEp3CkZy
c1pBa2pjWjZkTGNiS0Z0QjhLeUsrdml6dWkxbEhQOG5rdURta0pvd21RR1h2WXhyQWFQRkRNT1pN
aXRJUWoKYnBvdW9uMGtDS2tpdXQraDdGc2RyaFFDaGlxQWtMY2h0eXZHSldrejFQN1padkwzWGwy
UGdFdzVsM25tZEcrUwo5VVFWemJ3amxWWkFTcUtlQWtwZkhsUG1teUcvRndFamJ1V2VNVXFCbHZk
MytVYWZxWVN5TmJsajRRWEZWNFc4CklacXZTL1JQbzBHTDdKTTJCejR5ek9TTnB2ck9CL1Bka2J3
SnJtQ2tkcFlwSjNYcFFHbjJvNC8xTFJzWXkzZ0cKSFRqY3hDd2RNUGdIWWlULzFXTzFZQnVvaWxV
ZTZlSitKN1BtcFRWRVRJeUZFcUpHSXU1RzVsWUhGdTFRUFd6WQpYT0d3emM5SnZaL0hHN3N5NUNN
RlFzQUtIVDZGQTBBRG1wZlRycFVnL094QlpLbHRUZ3NpbENnamtzbHkveXJhCmJXaENWMmhEMzVi
dUpuR054Z1lpVk1ER25rMUkxQXU5RXBiMzFrND0KPVpPVlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000331d8306447f6aab--
