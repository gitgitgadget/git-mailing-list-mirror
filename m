Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8124503F
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554361; cv=none; b=HVGHhltU8FvRAJVJIiwNpl28V6IIj/piYatEAwRk2BEnUk/cpfdDcSsDu9cEg/HTGQ3XIQA072OIqj+ft4aJye0WbJcYKgBYcDhPxntaHloS0ATZeHIe3YLtu6xcrr7T+hIoZnIDLEuBmQMWbJu5sKo5K5ZXvuHKFkGVtLg3mTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554361; c=relaxed/simple;
	bh=pAa8wvrwgAquHrI3GtE5shRbldkxntw9T2eSxjKRqmg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI7Y0mZw9rqgk40VohBvTMJz373PA2ARsaVm60BzlBJvmajjAaSs8pcEjHhxnGcDrYuOv0ZXvfSixITgZ2SFQQ0rx9wp0Wyz1B7RDYebz+0S892SyX0MhUJne5mnsHDk60Z+o59EVaL4YsXpoaA6gYYWSp0d2oPt39ejQJC/egw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0r43q7v; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0r43q7v"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-88db7a27cdcso202926241.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754554359; x=1755159159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMxhB2qbJVvDYJzU/hlW3rx0AHe+yI+4KZs1V5dIE9c=;
        b=O0r43q7v5iiBQOEwjjmsIHBdBkCuFaQATFgXkRdezJ5YLK+R/4TF6Km654CHsNc5uP
         8HkdYHjA2jdwHzemuzLmsjU4Cv9Fx7sBN4SxUAfE1UG46fxEUO3nIYkJKiiAgZIP0xbQ
         6bIIWOwViXJkg+pR52538/G62e/Ss3WQSpFA3gpBFOYG6dpw0nGYZlQUn0KOc5XfAFs7
         +XLhCO4d7GP/imn4diUnI5FG3cwRt4tCLeHuFZokCujzYVU85qU2kFc/a4TD8lgpCJnI
         o4NyPUlgAjC5BpETo8pGWSen1tLf855Dzgx5jLEOp3RqrMIYLfa2tFYa2Ml8kjjUtGgR
         UwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554359; x=1755159159;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMxhB2qbJVvDYJzU/hlW3rx0AHe+yI+4KZs1V5dIE9c=;
        b=LSb51OeUlKQmH+WHfQf56HVMVBqXmBzE+jxIyKuSSZokLL6/fdDFLs8TcBLHNnyA/w
         3esHoTF1EeW+wYLOiHUEtYTQaLmejBclryznfG8lGRr7QDAP6cIYNVz5GgmO6NtNT889
         bvZnThkPYbzUQaZ0fkg+bUAFMl1Mz12KTp9R7i2oAxmRP3hb5mzY0G/lKCopNhAumJwe
         STyJzPR54e80vpWmDPKjVoWefKnml+Ao3lWfEuJ2HgAQ+8A39TqxGH95sOWl1sXF+kBf
         91zg7ID+V6wInhTgtmSNQCERk+zn4FIFOIqHz3lwd7eBLcKPeZXfMaJFVu9U/54BSEp/
         BIkw==
X-Forwarded-Encrypted: i=1; AJvYcCWWkkH1IToZlFzmZ8yEf0uVbvb64QsPPUz5gwAZPcyCdOkSZrJC34+MqjR7/q+lGxjHXLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MDb0YV4iJ+pZjksdvbyCcIKL0qM3xsT9QcESSf8YEs5QZtul
	pJ944pNN3GDzrJvA58MBDl/XF5XoYLPXvxPMPrfhQYKV0bvumxE0SVA5jHD5ruvSitP2OxyXdvp
	Bj0snt3k5v6o03KVJfzqHsW0mKVy/+KP27JMa
X-Gm-Gg: ASbGncv8+2x8WWWjQjWowVVBO5suQCkf2Nzu3ZHUhEZWsCjkmzN27S75Ca59bFA+EvE
	tjVyAmsW0W9tTRYZvWftveXQw5Tb15LPgCLViLrnfzxuBHVbhssw1FrGxXdg9xWEe4SqWGvfMay
	/tdfrsZATwGLPUDw6qSIUBEO+gZyFg3FIR94i+25tfJRor3R/28kM2TFKiQuz1nXwTOx/5N/glO
	E2lLA==
X-Google-Smtp-Source: AGHT+IGcML3H0rd1cnE/Gi6XOOLOGteo1afsbLWBMhDhi/c5v9nH690NM7Td9Ajne5AyHHWFCZb2lJhimtgdwB58iuE=
X-Received: by 2002:a05:6102:508a:b0:4fc:e593:b20e with SMTP id
 ada2fe7eead31-5037b5d4161mr3008816137.26.1754554358556; Thu, 07 Aug 2025
 01:12:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:12:37 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:12:37 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-1-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-1-748db2eda3b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Aug 2025 04:12:37 -0400
X-Gm-Features: Ac12FXwoJU0P1MfjzFuMVVFkNGlWo-1g8x1x63T-Ogjkeqnq5YwU5wZRwledIso
Message-ID: <CAOLa=ZTr6pkYHu05xBKJwY+6RL215o06c=qgZ1b=4MTMxyV6cg@mail.gmail.com>
Subject: Re: [PATCH 1/8] odb: store locality in object database sources
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000480e43063bc20559"

--000000000000480e43063bc20559
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Object database sources are classified either as:
>
>   - Local, which means that the source is the repository's primary
>     source. This is typically ".git/objects".
>
>   - Non-local, which is everything else. Most importantly this includes
>     alternates and quarantine directories.
>
> This locality is often computed ad-hoc by checking whether a given
> object source is the first one. This works, but it is quite roundabout.
>
> Refactor the code so that we store locality when creating the sources in
> the first place. This makes it both more accessible and robust.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c       | 5 +++--
>  midx.h       | 2 +-
>  odb.c        | 1 +
>  odb.h        | 8 ++++++++
>  packfile.c   | 9 ++++-----
>  repository.c | 1 +
>  6 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 7d407682e6..b9ca0915a6 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -723,7 +723,7 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
>  	return 0;
>  }
>
> -int prepare_multi_pack_index_one(struct odb_source *source, int local)
> +int prepare_multi_pack_index_one(struct odb_source *source)
>  {
>  	struct repository *r = source->odb->repo;
>
> @@ -734,7 +734,8 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
>  	if (source->midx)
>  		return 1;
>
> -	source->midx = load_multi_pack_index(r, source->path, local);
> +	source->midx = load_multi_pack_index(r, source->path,
> +					     source->local);
>
>  	return !!source->midx;
>  }
> diff --git a/midx.h b/midx.h
> index 076382de8a..28c426a823 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -122,7 +122,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
>  int midx_contains_pack(struct multi_pack_index *m,
>  		       const char *idx_or_pack_name);
>  int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
> -int prepare_multi_pack_index_one(struct odb_source *source, int local);
> +int prepare_multi_pack_index_one(struct odb_source *source);
>
>  /*
>   * Variant of write_midx_file which writes a MIDX containing only the packs
> diff --git a/odb.c b/odb.c
> index 1f48a0448e..1761a50840 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -176,6 +176,7 @@ static int link_alt_odb_entry(struct object_database *odb,
>
>  	CALLOC_ARRAY(alternate, 1);
>  	alternate->odb = odb;
> +	alternate->local = false;
>  	/* pathbuf.buf is already in r->objects->source_by_path */
>  	alternate->path = strbuf_detach(&pathbuf, NULL);
>
> diff --git a/odb.h b/odb.h
> index 09177bf430..d9f4dcf79f 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -63,6 +63,14 @@ struct odb_source {
>  	 */
>  	struct multi_pack_index *midx;
>
> +	/*
> +	 * Figure out whether this is the local alternate of the owning
> +	 * repository, which would typically be its ".git/objects" directory.
> +	 * This local object directory is usually where objects would be
> +	 * written to.
> +	 */
> +	bool local;
> +

So now, each 'obd_source' has a 'local' field, which would be false by
default. But when the local 'odb_source' is setup, we set it to true.

>  	/*
>  	 * This is a temporary object store created by the tmp_objdir
>  	 * facility. Disable ref updates since the objects in the store
> diff --git a/packfile.c b/packfile.c
> index 5d73932f50..a38544b87b 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -935,14 +935,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
>  		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
>  }
>
> -static void prepare_packed_git_one(struct odb_source *source, int local)
> +static void prepare_packed_git_one(struct odb_source *source)
>  {
>  	struct string_list garbage = STRING_LIST_INIT_DUP;
>  	struct prepare_pack_data data = {
>  		.m = source->midx,
>  		.r = source->odb->repo,
>  		.garbage = &garbage,
> -		.local = local,
> +		.local = source->local,
>

The 'prepare_pack_data' already has a 'local' field, so we can now
simply set it using the 'odb_source's field of the same name. Nice.

>  	};
>
>  	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
> @@ -1037,9 +1037,8 @@ static void prepare_packed_git(struct repository *r)
>
>  	odb_prepare_alternates(r->objects);
>  	for (source = r->objects->sources; source; source = source->next) {
> -		int local = (source == r->objects->sources);
> -		prepare_multi_pack_index_one(source, local);
> -		prepare_packed_git_one(source, local);
> +		prepare_multi_pack_index_one(source);
> +		prepare_packed_git_one(source);
>  	}
>  	rearrange_packed_git(r);
>
> diff --git a/repository.c b/repository.c
> index ecd691181f..97f0578381 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -168,6 +168,7 @@ void repo_set_gitdir(struct repository *repo,
>  	if (!repo->objects->sources) {
>  		CALLOC_ARRAY(repo->objects->sources, 1);
>  		repo->objects->sources->odb = repo->objects;
> +		repo->objects->sources->local = true;
>  		repo->objects->sources_tail = &repo->objects->sources->next;
>  	}
>  	expand_base_dir(&repo->objects->sources->path, o->object_dir,
>

So this sets up the local 'odb_source' and as such sets 'local' to true.

Looks good.

> --
> 2.50.1.619.g074bbf1d35.dirty

--000000000000480e43063bc20559
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 243ac47ad4051f50_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVVgvUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEhOREFDYlNVVFkzbHloaWtJZ0pXNDcwNURMMTM3TQpuQ0R5VXlPNzBv
MTI3UXdDQW5CWnZPVDk1UG9seGg1eUhQYXF5RnZnbDk0VWlMbzQ4c2Rjd0VkVHZqSGZ0MW5aCkt1
SU1JM1FqdGJiUmtPbUlNMlFtK09CNEZkUG11MFM1T3poM3l1SGVmbWE0RzB6QlZTaS9TTkQvNGxj
djRKNjkKQXRYSGJ6dDRCbk1BZ0lmbGVWNVk0NkE4VzFPUkk4KzFzYzlYY0dGd00wRmw5TGlSTjdV
c1RqQXhSMGx0TzNIYgozbXhqVW45aFVLK1NiQWlpYk9nWFVIeUZQMHAxd2NXdkVUTzlNODJqZDEx
a1krbFIraHFQWXZkbWdTWmZ5c2tvCmQ3Uk5JOWhoUDg3QmIyd3NSYkxPVEk5cmxEelpVY0Ercm5J
NVlxR0pyKzNURGxCcTVxSzF4Zm5XSCtubVRxdk0Kd0pnR0lnUkprQ3VKc0NEcm5rejdVUHpSSllI
QmNsWGpSNUdmWTRDZTFoVEp0VFByOHlsT1h0L0xodkswVkg3MApvbHZzeDhVdmpiQWptclRPWis5
TUg0YmFpQks5OXVMZUhGazlZZkdHazg2MXZKL1VjWVJ2Y0lUQklNMmc5TkRYCnFVamhwK2hQbk1E
QTBoSHhmMVVyREh0VkxKTUl0dHEyZnpRZEdaRT0KPVNCMGcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000480e43063bc20559--
