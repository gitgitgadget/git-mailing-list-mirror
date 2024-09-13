Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719617BB3A
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227339; cv=none; b=fMAupXyioXleW+bWDd9TXoZB/MMId848uSs8h5iuLYdVIysuPayMCodPgK12Y8U69wgJuzXECswI5qq0obEWXiSq+VU/8YS3D562Lp7fR0cLgj7aWx46W1qZVUzgx8eXXvowezZZ89bVEtteknyfBQORsDwUyuP0G1PCQQWtZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227339; c=relaxed/simple;
	bh=Juo7n/XflSCAWqIZ/38QgczcKnjC0i87wfjyux2Tf58=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpVHHkOkGWoF1fjlATUxZdJj0elK1lLqjNfusTymCdKm83qQSiE3Gpp698+Ngjlh7cXaR+L+8jAD6+GorcY0OPvJ1xB/UdpqDvrlwO+T36Y5Gb1OHMZ4a0N24+xpGvU+gBARkxKOgOVnoBwz2lKfqicvNtIpE8K/ykCT1FxfUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpEaHQjh; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpEaHQjh"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-49be2ef28aaso576876137.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726227337; x=1726832137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fre+r8WvWeYwl/cxaa5qLhMXtly/E4IKE68hS0QTW68=;
        b=kpEaHQjhlbLnAgdtMdt9r0YzWUdIx9lHp8e2KWywyvHHGsLAAiHuHJ9uxFRgaIvOWq
         UWWhVPTSJ2mWiuRTeEf3NR16NRnlqbtYVAlF0ciEms9Qg6FagcKWJU5Kwdm3NMM3LzJj
         qrjwIuK3d8DGlAPQ9jkXfJikp58h5D2pSHIiZWhIc/0z47Sty/paVtPCFAQJYgYspNMl
         le0T3DwtFpY3FbM5v6OngNPILCjjPhdHXMae2orQT6TU8+x2TwTdDhZh8v1nZoSNGdd3
         pKTrJ+86hfXszMJd08BuOyplkmY6/0o6aRdm9Nr6++i89LrjAa92uWnXL4HRdtDPvFQb
         lBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726227337; x=1726832137;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fre+r8WvWeYwl/cxaa5qLhMXtly/E4IKE68hS0QTW68=;
        b=AUIlQmqMmv5P74GdF4SbjcYj7oM23lKRJfnI5Gov70IJJzJxmOyEDUkPuimGivv1fT
         7PZdp3WOLCUVqz13Ax464QE/g6nrBdfiDk8KIJVHSVdmTB9qNpwLjMoYfQQKqYiCCySn
         r6i2Fs8SGTg0YEi6xlA9KdHZNMWgemYlGUuW/WeEJ6WJRtkHLWkWGzd7AGybm8dmkU2G
         vCPRK/JEbQGaOFdopO0nDf3Ltn6Is24cz2sUdYoxfJeA2kizx/x5LaulqyY2Pb25jMW3
         8JHHQnOs5vk6kywnAVrigdY8pbpiSwX4MpYYkQRbYyZC2xec4va+zot9/RKu4t2HOm9+
         H3nw==
X-Forwarded-Encrypted: i=1; AJvYcCWgQ8xhy/y0fR3MJ/Azy/N5GxjL8nuMebDz8oQYgF2mlVy8RQ08Px+RpV54NkiJz2iYv6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0N9j5aBoj1hBlZO5szm9j8X6vTnv7OLC9oSRA/K/1eobeexy
	thc1CaHdIiiC3Nq2N2rippL4ES3R+yKGz3P9QySwN7gEWJknVVQ2ObplfR7s7tMZDDS5esuyY2z
	+BzuLytJKCD0DdmX+axz6SJnIBdP0aMAp
X-Google-Smtp-Source: AGHT+IHRsB7SjKeP6ap8elniYXpuRJabN9xmIqg14eOCap8biS8zDa7QSyLZOg0uR/WWGt4p2IuN/U9jxXgAHBaoY4M=
X-Received: by 2002:a05:6102:511e:b0:49b:be3b:8812 with SMTP id
 ada2fe7eead31-49d4157c4eemr4715205137.24.1726227336451; Fri, 13 Sep 2024
 04:35:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Sep 2024 04:35:35 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <8d347bc5599e2a679d50fed073e0f09ffdad85c4.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im> <8d347bc5599e2a679d50fed073e0f09ffdad85c4.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Sep 2024 04:35:35 -0700
Message-ID: <CAOLa=ZTM9N0i+8jDp24pp1DdU1mmwU02L4vOP6GOpGW-=SJUoQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] refs: properly apply exclude patterns to namespaced refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000003103010621fe9f84"

--0000000000003103010621fe9f84
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Reference namespaces allow commands like git-upload-pack(1) to serve
> different sets of references to the client depending on which namespace
> is enabled, which is for example useful in fork networks. Namespaced
> refs are stored with a `refs/namespaces/$namespace` prefix, but all the
> user will ultimately see is a stripped version where that prefix is
> removed.
>
> The way that this interacts with "transfer.hideRefs" is not immediately
> obvious: the hidden refs can either apply to the stripped references, or
> to the non-stripped ones that still have the namespace prefix. In fact,
> the "transfer.hideRefs" machinery does the former and applies to the
> stripped reference by default, but rules can have "^" prefixed to switch
> this behaviour to iinstead match against the rull reference name.

s/iinstead/instead
s/rull/full

> Namespaces are exclusively handled at the generic "refs" layer, the
> respective backends have no clue that such a thing even exists. This
> also has the consequence that they cannot handle hiding references as
> soon as reference namespaces come into play because they neither know
> whether a namespace is active, nor do they know how to strip references
> if they are active.
>
> Handling such exclude patterns in `refs_for_each_namespaced_ref()` and
> `refs_for_each_fullref_in_prefixes()` is broken though, as both support
> that the user passes both namespaces and exclude patterns. In the case
> where both are set we will exclude references with unstripped names,
> even though we really wanted to exclude references based on their
> stripped names.
>
> This only surfaces when:
>
>   - A repository uses reference namespaces.
>
>   - "transfer.hideRefs" is active.
>
>   - The namespaced references are packed into the "packed-refs" file.
>

So this is because we don't even apply exclude patterns to the loose
refs right?

To understand correctly, the transport layer passes on
'transfer.hideRefs' as `exclude_refs` to the generic refs layer. This is
mostly to optimize the reference backend to skip such refs. This is used
by the packed-refs currently but not used for loose refs.

The transfer layer also uses this list in `mark_our_ref()` to skip refs
as needed.

So all in all `exclude_refs` here is mostly for optimization.

> None of our tests exercise this scenario, and thus we haven't ever hit
> it. While t5509 exercises both (1) and (2), it does not happen to hit
> (3). It is trivial to demonstrate the bug though by explicitly packing
> refs in the tests, and then we indeed surface the breakage.

Nit: I know you're referring to the three points stated above, it would
be nice if they were numbered.

> Fix this bug by prefixing exclude patterns with the namespace in the
> generic layer.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c                           | 35 ++++++++++++++++++++++++++++----
>  refs.h                           |  9 ++++++++
>  t/t5509-fetch-push-namespaces.sh |  1 +
>  3 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ceb72d4bd74..b3a367ea12c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1517,6 +1517,19 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
>  	return hide_refs->v;
>  }
>
> +const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
> +					     const char *namespace,
> +					     struct strvec *out)
> +{
> +	if (!namespace || !*namespace || !exclude_patterns || !*exclude_patterns)

What scenario would `!*namespace` be possible?

> +		return exclude_patterns;
> +
> +	for (size_t i = 0; exclude_patterns[i]; i++)
> +		strvec_pushf(out, "%s%s", namespace, exclude_patterns[i]);
> +
> +	return out->v;
> +}
> +
>  const char *find_descendant_ref(const char *dirname,
>  				const struct string_list *extras,
>  				const struct string_list *skip)
> @@ -1634,11 +1647,19 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
>  				 const char **exclude_patterns,
>  				 each_ref_fn fn, void *cb_data)
>  {
> -	struct strbuf buf = STRBUF_INIT;
> +	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
> +	struct strbuf prefix = STRBUF_INIT;
>  	int ret;
> -	strbuf_addf(&buf, "%srefs/", get_git_namespace());
> -	ret = do_for_each_ref(refs, buf.buf, exclude_patterns, fn, 0, 0, cb_data);
> -	strbuf_release(&buf);
> +
> +	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
> +							   get_git_namespace(),
> +							   &namespaced_exclude_patterns);
> +
> +	strbuf_addf(&prefix, "%srefs/", get_git_namespace());
> +	ret = do_for_each_ref(refs, prefix.buf, exclude_patterns, fn, 0, 0, cb_data);
> +
> +	strvec_clear(&namespaced_exclude_patterns);
> +	strbuf_release(&prefix);
>  	return ret;
>  }
>
> @@ -1719,6 +1740,7 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
>  				      const char **exclude_patterns,
>  				      each_ref_fn fn, void *cb_data)
>  {
> +	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
>  	struct string_list prefixes = STRING_LIST_INIT_DUP;
>  	struct string_list_item *prefix;
>  	struct strbuf buf = STRBUF_INIT;
> @@ -1730,6 +1752,10 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
>  		strbuf_addstr(&buf, namespace);
>  	namespace_len = buf.len;
>
> +	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
> +							   namespace,
> +							   &namespaced_exclude_patterns);
> +
>  	for_each_string_list_item(prefix, &prefixes) {
>  		strbuf_addstr(&buf, prefix->string);
>  		ret = refs_for_each_fullref_in(ref_store, buf.buf,
> @@ -1739,6 +1765,7 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
>  		strbuf_setlen(&buf, namespace_len);
>  	}
>
> +	strvec_clear(&namespaced_exclude_patterns);
>  	string_list_clear(&prefixes, 0);
>  	strbuf_release(&buf);
>  	return ret;
> diff --git a/refs.h b/refs.h
> index f8b919a1388..3f774e96d18 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -859,6 +859,15 @@ int ref_is_hidden(const char *, const char *, const struct strvec *);
>   */
>  const char **hidden_refs_to_excludes(const struct strvec *hide_refs);
>
> +/*
> + * Prefix all exclude patterns with the namespace, if any. This is required
> + * because exclude patterns apply to the stripped reference name, not the full
> + * reference name with the namespace.
> + */
> +const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
> +					     const char *namespace,
> +					     struct strvec *out);
> +

Do we need to expose this? Can't it be made static?

--0000000000003103010621fe9f84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d99ca9145fb2be74_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ia0k0TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2EyQy80dXpZdnpHZFkzN1NIQk1BNjltWDNGTUk5RQpvcGI1WWdZcTI5
QlFtR00xTUVXaTFUS2w1TnJUVmhvdTNWRFBFS0JQV1dlbzcxdlVqVUNiNHZGTy9nUzF4YVZ5CnFU
czBXdTROakI2OVdvS3ZwQWZqejhDdHNwaTJqbHA0YWJrT1M1K0lhZTBQbkRlM2h4ZTFHMjc2TVU1
ZVRHQTAKL3NrdUNjTnNaczF5ZUdLOFVwUGpSRUtDYUFlRFN4dnc2Z2lQQmVSTnJ6VnVmb2tSN2ZB
N3NHV1k1MzJ3UTgxeQpPOG1uaDJCUXRKdisvcjErdHJaMG9tMG1Tc0VoNzVycFdWcDNJbnN1MFZk
Mk5NVGp5WitvRjBESUU0cVdKZDh3CksyWHNqZUhJYXR1K0xTT2U3N050Nk53QlFnQmY1TUMyclRj
aGJLMFVSSWdSYUVBM3VwK2FaWGxZTkozKzVTSWMKQ2pNQjBBZjNCbGcyRmJiWFltdVFYbGNNRWdF
SGYyelp5bmZqNHlCWkJMaDNFV0d2TWxYUmRmblZiSnllcjRmMAozSzkvdXYxOW1xcnlLa2k0MHBF
ckUwSXpTYXZOaXZ1eS9PamRVTFJVTHZYZzkyQUFBbDNybmhnK3JJcVdwNlU3CnIwNmwyMDNBWUFV
MGQxU0Q2K0VuQ3p5dVlmS1IwSVJCVXVVR1lWYz0KPTJ6Y1kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003103010621fe9f84--
