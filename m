Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6D4430
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402871; cv=none; b=d07EIAOxSPscBclw6TJ0hQISMYFCisNlLCe+YP/VCz0aiiaa1qYs9+nsJ3P2r8pTVqRdlZhVNfJiMZBpYNJ6cb6rT/jzTYqXxziY0+fceUCPT4BlNKuYPPWdsijGLbGHTbDfKEy7iXp3C9RqvX09euEZkKtS64waRSlVK6iBGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402871; c=relaxed/simple;
	bh=gb9atKQLXJBVqZxu0KnhTxZH6crsqn9dUc4W4/hqIxI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=GFxDWU+BLkRRy1m/O1fEuF82I1JIYckSSDsVgBBf6H2otekJ49Az2Ah/ng3ZMngACN4IRx72TyDiH8cO1wrJ/SDJLiAzb3kYLK3oFbnt9iTeAVJJt2bhIdEGyUdjv6LfkjzzSzF/pbnQ0dVUtQIUIBYvQPAOx+84DVcfPnrRQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2/LtrCO; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2/LtrCO"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso2306856241.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402868; x=1746007668; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcKrQGEUvbc6sEQChwLCfFtOJFRMEmWzTeu1kZoPbVc=;
        b=A2/LtrCO1fsNSk5uGKBw2z4v1V9mOkb/I1iVAcSBd2P8jpt4LVa1R0yhvAYQ4wCUxy
         63kK53KVAwozNxmdzRelqLbDX168I8TYvzH/8Oh7IYaDQ3lJvqL7mlN0Mq713obDruP8
         j9qg/jnjt9fWEJ2B4VrKS1fOaq54Cc2d6TBPMZB0A4LBX5FEwP+mqGybo/BTH+2lWPfs
         zYelus/jcJpeBy20w34gPqfZqDTioQrs4Xzm2BQ7072eJe6f0pSmWit0lCgsHiZUl8bP
         0SbvyCSD3BStWgNB174sJasfNaldCwrM2ijvwN4rldPYgftudCGDurmY02twAXdyfftG
         t82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402868; x=1746007668;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcKrQGEUvbc6sEQChwLCfFtOJFRMEmWzTeu1kZoPbVc=;
        b=kqhynvQKFwdmR7MeHl8dpWWDRwEggMfWiRDgHWRbUo1MUmo5wHe/l7zq0Q2n04/6T3
         fk1BJCRtECgVYs/d2f7uz3TPYBy1qX5Ecfs25oENeSQqlQtRXKO6G+ms8QV3P2zIkUlu
         Zk6QZYqIvcKmVAIBqjiOmrMSucM+Sx+jFfb512G1xhFxck7TPmv6MD1xbKup05pA5Ifa
         yjJZSWCuQZRDOzZkchPe6MXRlbKjNLMSySwCPjEC2EbvUyb0mhyPr703XvDADIZnKt22
         hBAInGdhkXMqIRu9zpOgtNkHwUBQ7k3RvDnrNqZ7/sJj54oo6iSxMae2/j/8twiUI1av
         AHnw==
X-Forwarded-Encrypted: i=1; AJvYcCVK8Ade9Xgjf1o9MFZ/SehTlXkjrgSEYSbPpYAkYbONLxYKCJS/0/qy54MQqtfaBQGSOzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUFxRR4lZ7IooomR3R61PeDMnvbtDFBhfq26ZROZueXHtkR9m
	bSwVBSgUTnvjYf17R0mWql8FRnp7ofwBn2Ib90AD9ATJwGQG5cbNZz4SWBUayfjJh547owR/XZf
	3eL9tyjSqqDLSpfi6/q4wh90TL/k=
X-Gm-Gg: ASbGncv8DerNXeXBbcT4bw6Iu9rD/KXaStT9e8if3I3z3/EoSUBaOZpWtW74eg+bub+
	TasA5msbi5xxMNbj+/VV92nsgkdf/qmwWgLXn8bkrcufZI+EZ7tO/kkbiS293eMbv3hApY++5ea
	NA/Yv9f+liKa5OyXcnj16mK2klaeOVQiX68agd2ObA09PTyhj7Aqz51SDH
X-Google-Smtp-Source: AGHT+IGLGfP4kmijPWA4hFqlsXuIQby7vOkFBqz+waw3NKoQ+kWC8a5hGEf5bnhR7iU4tXnsJbX2Z5FotovIcuLnuOY=
X-Received: by 2002:a05:6122:179a:b0:520:42d3:91c1 with SMTP id
 71dfb90a1353d-529254db5ddmr13789682e0c.10.1745402868345; Wed, 23 Apr 2025
 03:07:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 06:07:46 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 06:07:46 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-5-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im> <20250423-pks-object-store-cleanups-v1-5-81f8411a5d08@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 06:07:46 -0400
X-Gm-Features: ATxdqUF-6uwJnH5aVaQN8OPZ2nYUwbn8O4MO0MvGtMbeT3L7EnCKDU6IzPQBO6c
Message-ID: <CAOLa=ZRv5WXHQYRg_19ED94+9QVSzi_EP_DAOXNPE4+4sB4P-A@mail.gmail.com>
Subject: Re: [PATCH 05/13] object-store: allow fetching objects via `has_object()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f54bb506336f45c1"

--000000000000f54bb506336f45c1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We're about to fully remove `repo_has_object_file()` in favor of
> `has_object()` given that the latter has better defaults: it neither
> reloads packfiles by default nor does it fetch any promised objects in
> case they are missing.
>
> The latter usecase keeps us from converting a couple of callsites that
> currently do fetch objects though. It is not really clear whether _all_
> of those callsites should be fetching objects, but for a subset of them
> it is the desired behaviour indeed.
>
> Introduce a new flag `HAS_OBJECT_FETCH_PROMISOR` that causes the
> function to optionally fetch missing objects which are part of a
> promisor pack.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-store.c |  9 ++++++---
>  object-store.h | 10 +++++++---
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/object-store.c b/object-store.c
> index 0cbad5a19a0..0d873868a6d 100644
> --- a/object-store.c
> +++ b/object-store.c
> @@ -937,12 +937,15 @@ void *read_object_with_reference(struct repository *r,
>  int has_object(struct repository *r, const struct object_id *oid,
>  	       unsigned flags)
>  {
> -	int quick = !(flags & HAS_OBJECT_RECHECK_PACKED);
> -	unsigned object_info_flags = OBJECT_INFO_SKIP_FETCH_OBJECT |
> -		(quick ? OBJECT_INFO_QUICK : 0);
> +	unsigned object_info_flags = 0;
>
>  	if (!startup_info->have_repository)
>  		return 0;
> +	if (!(flags & HAS_OBJECT_RECHECK_PACKED))
> +		object_info_flags |= OBJECT_INFO_QUICK;
> +	if (!(flags & HAS_OBJECT_FETCH_PROMISOR))
> +		object_info_flags |= OBJECT_INFO_SKIP_FETCH_OBJECT;
> +

This already is much easier to read.

>  	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
>  }
>
> diff --git a/object-store.h b/object-store.h
> index 5bbdaba92d1..c6055376f49 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -266,12 +266,16 @@ int oid_object_info_extended(struct repository *r,
>  			     const struct object_id *,
>  			     struct object_info *, unsigned flags);
>
> -/* Retry packed storage after checking packed and loose storage */
> -#define HAS_OBJECT_RECHECK_PACKED 1
> +enum {
> +	/* Retry packed storage after checking packed and loose storage */
> +	HAS_OBJECT_RECHECK_PACKED = (1 << 0),
> +	/* Allow fetching the object in case the repository has a promisor remote. */
> +	HAS_OBJECT_FETCH_PROMISOR = (1 << 1),
> +};
>
>  /*
>   * Returns 1 if the object exists. This function will not lazily fetch objects
> - * in a partial clone.
> + * in a partial clone by default.
>   */
>  int has_object(struct repository *r, const struct object_id *oid,
>  	       unsigned flags);
>
> --
> 2.49.0.901.g37484f566f.dirty

Okay so we add the functionality here, and possibly use it in the future
patches. Good.

--000000000000f54bb506336f45c1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1cfa96b6f03dccd6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSXUvRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1dWQy85YzJ2UmhJT2NrcFhseHV0VytyNGl6Q09XUgpieDZ1ZmdoWWxi
VkxPNVEza2RxTWJ5a2hXSklWWFRwVEs5ckJTMEJ4bjBVZzE3eE1vMEszU1VyaEtNTzZOSzhMCnQv
a25MSTRJTjRvRVUzaW16RDRBZnJTdE9mRmVHcWdrNWhCakdUREI4Wk8rOUJGRng2cUQySEhNd0sx
SFpxVi8KNGxsQ3UwSDNGSWZCRC91VUd6SGdIQUoxWkVHOWZYak5Dem1ScjRRdC9KZVI1Vks1eTk5
cUhvWEpLTVRlTndVYwpseHZHWmI3c0Q5VE1oRG1NVllyaUFjQ2tRd2xwVkxxOFpPazFKdFR2R2JD
UDNiUnRvblo2SDRoMVpuaFR6Wi9oCmRCUWR0M1pWYnVIWmxwTTAwb29aeWRva3pmQ1FSNTArK0xQ
UEI1Vkp6TWRTT2VNazFjUk5QQ000ZnZhVnRXaDgKUjJuV0FzY3REWUdwam4xWlRNamExcXZwZTlo
ZTkvaHkxUkFNOHY2OTF4UncxeEN6dVl5UGxXaHJLQmZ6NE84aQowNEZocS9WTFJlcENkdHR4bnBw
Z0hrL2M3QWQrNG9QU1dvekNPZjV2LzdPNWRqQ2N1L2k3UWQyQUhhbDJLTEFICjJQTDV2NzNINTRr
eUsrWWxTVTVUZUpNUEtQbCtLNnllSzkrakZ5az0KPXFhR1QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f54bb506336f45c1--
