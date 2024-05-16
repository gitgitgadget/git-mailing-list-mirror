Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8634A2C
	for <git@vger.kernel.org>; Thu, 16 May 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877579; cv=none; b=hwTkbgjS+GPrI98tRqPSR1cGy6F+MrV7wN6plSQLerlXgynW4wvzBxnYFtj9UqfEsch7QNRUsiB193lyNlx+X8eW4i6mtjcnIDFae21mcWxg6jjmZsz0bNAAlTnQDqfMUy7caNE7fLx52sJG3vNnM8F84YHkkgavjfwnvLRchTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877579; c=relaxed/simple;
	bh=uY2QsQciLh9oRgfT59zqcVicjgjsviNi+0Agmb3iagk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=XeoCql1muw94BRUewflujhaGox+7xDfz/05jbQUAA/vqOfxvitsqhkTYPQxLyaU2m72G/Dq376g7q3qTJ/nHr2TlfnXs4NPTMfWDDWvAt406d9EBO5gektQOLrzs0/0TrV4lOiUuw2T8x779KokVwhTh064kv3fuuvX2jylQf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNwSursk; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNwSursk"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-245435c02e1so426984fac.0
        for <git@vger.kernel.org>; Thu, 16 May 2024 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715877577; x=1716482377; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skxHZoot+tMcJmcjATjxKrexmSb56tbxbPZ9FTWifg8=;
        b=YNwSursk7+T0iOZt1LAuMdoRbk+M/UhoEhO1YmY6kfO/8jMtF0t2z091niXIyqLdW4
         qN6L2zhnqfAM6La3dxESDIXmYaq/fxgu36wRM0OH2fPiN5LwWVyFryR7Yi6GJ3vRmz4A
         dotySGCslnXOqTI82x24nT1YVZFiPDS7X98n3S1PNs8gSHz+Fe7P2ygwy1tqQKGoiTNO
         KkDPcDBK2AZc6+jgyJbNy2G+dxBmWVh1UToM/pibYIq7qcQOtydjYJ0AbFv3Vmfp9oY5
         AhaWdVw0GCZZI0mQMJ0u4gRvm0PaLDkCOldqK9Kasfjhs3zanZ60cgGM6+FtnPjqWMl8
         QvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715877577; x=1716482377;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skxHZoot+tMcJmcjATjxKrexmSb56tbxbPZ9FTWifg8=;
        b=Pgt/p1jCjDLERaHHub9Z08nCizVSVylezt/KRguznzJrpWi3hlVdvS4x5sU8R8wHtI
         ASu6gTvU6WXymcQ4/0S2cM54RHlaoCIz1C/wHoi1zHlVU8UKzcZKoTpsPTBNC8A2n/wP
         RNb7vs5tzUlyQ8ed6DqE//DHuUQUxY7RKEw7IKmy55ZfnDT7JvhfbgweuDv+ccQtMeOk
         oLQRBGtYpvnFNqGBubmm6Wg20H0irOGD5uG6HB5jFR4MX9TkfVnuFeF6tb1nuX4zwAXg
         +K/HPbDOFiXwhI2HiMBDhF6bBrJCF2Ufkso8WaEvnY1m0NU0/4wAnfIlHvddGkLynqWc
         4jEw==
X-Forwarded-Encrypted: i=1; AJvYcCX2qMZ8gRq65/rDJpf8+alHwenMl0gIjC4V0mBoNI1Mo7QL0UafnknawLWzCp/hW3+gM5TKD5gMsNj7F9hT0UsWAQ/c
X-Gm-Message-State: AOJu0YxxRDxMDnfq6jmG5KL57MnumzWmhJKq/WqymvyKoSFTcoO6NpT6
	fPwOXDNX11agzb5ry29Vu4Ldraq1MDvsc/poqOmCO0j9lOrRs+mLkcE8qZoyJNY36ee7+U4ck0C
	30BP83ZKnF74oQS7bekHVZdBTYzE=
X-Google-Smtp-Source: AGHT+IGo99VEwvQrM6eBQhiR53PmJBvCQiWVczpjuXre8GbYXW0vYWw8XOdyHpwU5o4ZH4a59r+U+N0fmNSj/esAuP8=
X-Received: by 2002:a05:6871:215:b0:229:929a:b127 with SMTP id
 586e51a60fabf-24172bdf8bamr24409437fac.37.1715877577015; Thu, 16 May 2024
 09:39:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 May 2024 11:39:36 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <282fbe35a7c9db715a8a805f93f9b465d42885a5.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im> <282fbe35a7c9db715a8a805f93f9b465d42885a5.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 May 2024 11:39:36 -0500
Message-ID: <CAOLa=ZT3VqhrHXt9x-4DN7norTb3RuscBx+VHipn=QxJvwwThQ@mail.gmail.com>
Subject: Re: [PATCH 03/16] refs: implement releasing ref storages
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000074dce8061894e124"

--00000000000074dce8061894e124
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/refs/debug.c b/refs/debug.c
> index 58fb4557ed..27aae42134 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -33,6 +33,12 @@ struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
>  	return (struct ref_store *)res;
>  }
>
> +static void debug_release(struct ref_store *refs)
> +{
> +	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;

We should probably add a trace here, using `trace_printf_key()`

> +	drefs->refs->be->release(drefs->refs);
> +}
> +
>  static int debug_create(struct ref_store *refs, int flags, struct strbuf *err)
>  {
>  	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
> @@ -427,6 +433,7 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
>  struct ref_storage_be refs_be_debug = {
>  	.name = "debug",
>  	.init = NULL,
> +	.release = debug_release,
>  	.create = debug_create,
>
>  	/*
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f766d18d5a..368df075c1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -149,6 +149,14 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
>  	return refs;
>  }
>
> +static void files_ref_store_release(struct ref_store *ref_store)
> +{
> +	struct files_ref_store *refs = files_downcast(ref_store, 0, "release");
> +	free_ref_cache(refs->loose);
> +	free(refs->gitcommondir);
> +	ref_store_release(refs->packed_ref_store);
> +}
> +
>  static void files_reflog_path(struct files_ref_store *refs,
>  			      struct strbuf *sb,
>  			      const char *refname)
> @@ -3284,6 +3292,7 @@ static int files_ref_store_create(struct ref_store *ref_store,
>  struct ref_storage_be refs_be_files = {
>  	.name = "files",
>  	.init = files_ref_store_init,
> +	.release = files_ref_store_release,
>  	.create = files_ref_store_create,
>  	.transaction_prepare = files_transaction_prepare,
>  	.transaction_finish = files_transaction_finish,
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 716513efed..bebceb4aa7 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -252,6 +252,15 @@ static void clear_snapshot(struct packed_ref_store *refs)
>  	}
>  }
>
> +static void packed_ref_store_release(struct ref_store *ref_store)
> +{
> +	struct packed_ref_store *refs = packed_downcast(ref_store, 0, "release");
> +	clear_snapshot(refs);
> +	rollback_lock_file(&refs->lock);
> +	delete_tempfile(&refs->tempfile);
> +	free(refs->path);
> +}

Verified that all the params inside `packed_ref_store` are cleaned up
here, nice!

>  static NORETURN void die_unterminated_line(const char *path,
>  					   const char *p, size_t len)
>  {
> @@ -1707,6 +1716,7 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  struct ref_storage_be refs_be_packed = {
>  	.name = "packed",
>  	.init = packed_ref_store_init,
> +	.release = packed_ref_store_release,
>  	.create = packed_ref_store_create,
>  	.transaction_prepare = packed_transaction_prepare,
>  	.transaction_finish = packed_transaction_finish,
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index eb42212764..cc1fe6e633 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -530,6 +530,11 @@ typedef struct ref_store *ref_store_init_fn(struct repository *repo,
>  					    const char *gitdir,
>  					    unsigned int flags);
>
> +/*
> + * Release all memory and resources associated with the ref store.
> + */
> +typedef void ref_store_release_fn(struct ref_store *refs);
> +
>  typedef int ref_store_create_fn(struct ref_store *refs,
>  				int flags,
>  				struct strbuf *err);
> @@ -668,6 +673,7 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refnam
>  struct ref_storage_be {
>  	const char *name;
>  	ref_store_init_fn *init;
> +	ref_store_release_fn *release;
>  	ref_store_create_fn *create;
>
>  	ref_transaction_prepare_fn *transaction_prepare;
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index a4bb71cd76..6c262c2193 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -293,6 +293,27 @@ static struct ref_store *reftable_be_init(struct repository *repo,
>  	return &refs->base;
>  }
>
> +static void reftable_be_release(struct ref_store *ref_store)
> +{
> +	struct reftable_ref_store *refs = reftable_be_downcast(ref_store, 0, "release");
> +	struct strmap_entry *entry;
> +	struct hashmap_iter iter;
> +
> +	if (refs->main_stack) {
> +		reftable_stack_destroy(refs->main_stack);
> +		refs->main_stack = NULL;
> +	}
> +
> +	if (refs->worktree_stack) {
> +		reftable_stack_destroy(refs->worktree_stack);
> +		refs->main_stack = NULL;

This should be `refs->worktree_stack`, right?

> +	}
> +
> +	strmap_for_each_entry(&refs->worktree_stacks, &iter, entry)
> +		reftable_stack_destroy(entry->value);
> +	strmap_clear(&refs->worktree_stacks, 0);
> +}
> +
>  static int reftable_be_create(struct ref_store *ref_store,
>  			      int flags UNUSED,
>  			      struct strbuf *err UNUSED)
> @@ -2248,6 +2269,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  struct ref_storage_be refs_be_reftable = {
>  	.name = "reftable",
>  	.init = reftable_be_init,
> +	.release = reftable_be_release,
>  	.create = reftable_be_create,
>  	.transaction_prepare = reftable_be_transaction_prepare,
>  	.transaction_finish = reftable_be_transaction_finish,
> --
> 2.45.1.190.g19fe900cfc.dirty

--00000000000074dce8061894e124
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c9d52ddb61cf98fb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aR05zWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUxZQy93SXRWUk5pWXZsRDdYdzRnKzVRZlhVR2RkaApzTWhnZ3VoWWVL
SWtBa20wVTVOWE15b251UzBhVDZDUmxrd0hnRlhablp5SXpzSFhJSk1UYmdLOXhhR0JGMGs5CnZW
bnZNSk81V0ZZaGhxcUV3bkU4SHlyaEJGcGIyRUNHUmpKcFpnU1JPTGRPQ210MDB3eEVlbDdQaHpr
aW1jY1kKVTNYWE9rVFBIV3BwcFgxZEJxWW1WQkNQVHloR3krMEx3ckhEcWhtQnpOMjh1VFl6TU1n
TVJKQlhjZ214OVROegpEczFBYk1BcFdncHV0b01mY0ZDYjhxVndxNWdkUHljNTRuTlZvVUYwQVE5
dHNMNDZSQVlyRGtwVzdGOEZIMDIrCkhtK0Jtc1VGT1owQ1RZUWI4SXhkNE1LaTVsRisreVN1YnVi
dDg4TnZiTDNUKzl6MDU1UmViRjMxWmVCYVFxRWsKdk1LZGpTVFF0N0pmU0RVeFY4bzhmQ0R3U3M4
YzNLYXVNU251bk1vamVjSit5Tjlwa1NUaFFSZEJLQWlMYW1yZwpRY3BRKy93TGo5Ri9YNFdYUHls
VVdKVHNSU213SVJLL1RvNFFmSU1OOTFjbHVSTnFxaG81UnZtc1hRTWRacnYyClRpZ2MrSG11cHQx
cTNvREZWNGhkR3VNUGV5ZWhkWUl1UTNyTUpWZz0KPUFnSmUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000074dce8061894e124--
