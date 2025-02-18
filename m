Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764E26FA57
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898839; cv=none; b=dY8glKtqLmnSNqjed1N++Es9X8CegQnV0atZhVEyybiGUjCMsTivY+oPNfgEOQXLIuBo5shZ6JW+sFhfpxsFssOFdQs90xVsWjys14nhM8OAOMUZWnTp0NoK6U+XaUyO29CDQErZSj0zFMuUfGEC6TvfI78FajvMEfrXabhxWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898839; c=relaxed/simple;
	bh=a4rEI3HgYqTlI5xAjCb6uz6fiLwppQcWwl8fboKrQPw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnR8EbVU1XcZzy9EAnv9xbB4Ku36CZudbkLiUOEYu6PrFYH/uerbfeCloHv9NYeTFy78s+Bu80XE8hutZ5wGHsb3NXEfjL9TfJ419YKpkJScBXhgF9iBcWmICWoDxIy/zMUYdht1GTWAPyBRS4oJ1tqMev0+Gv1KUO0RFFJsCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I32tRD/V; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I32tRD/V"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5209437e773so1124860e0c.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898836; x=1740503636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLoZI9Wi9jRxqtrZAu5PPqKVUzE9r+3qRgKZ6u1M5cA=;
        b=I32tRD/V2bIC1/R/9dTfvP8z1MHpbp8ebXgmwScKWLdYWWN5Ut8ds8inDoMzGcr3Dv
         L+Q+gmJzYyJ/Utt4O8vJUqpE1sN8Fp6yC2oR+kSkZhDp1EZGGcrrt9t+ihztUTNgPnYQ
         PzLcdjZZdlN3w2I35SUKMNnh4upNX2uNwHuVc/13jxE8yIVU3RmPypgxX2CBhTAmP4kp
         IjedXaRtCRqYfM81LAnPltMbmrWtdHVDWmkgfWEmujPAg48f40xWnFOTBOYxTd7gtnvr
         1uyTyAi1OyWUZ5vuaps/yifCnM+XnuVAegxgZlH0C3CgHaJhXZ5ZZlhh44jEXhDLyJs/
         HHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898836; x=1740503636;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLoZI9Wi9jRxqtrZAu5PPqKVUzE9r+3qRgKZ6u1M5cA=;
        b=LDtJTWDNGJtlshZ9mK2EKXGw5yYfTAtckUhhEw1hy7RSPoLRMpfd8fepIq0SzAlTaY
         yW/+4/1UGemd8QUdfQAZjC1s3jtrAooIcrhGGFKijci0QFZV1eN85GkLdiMqsR2Ai3b+
         bDaQskosNgKEXN+3e72mZisI0AKYILiAqtV3Ye95S2WWTihsWzfLDTITS674VZtZ3tID
         SPOqHteNVCT9h1cIOO8WvvxavukdAfFWaloH/4Hd2xTK5/KKzTtI+wTVWCcxwZ/ksHNB
         gJYJbtG4lYwv5Ld7G7LuC8xU7v5lPM3qeTW8nrsCo95+qmBUKqwFN8Zl+V6S2BGK3Mfe
         7pxA==
X-Forwarded-Encrypted: i=1; AJvYcCUOoGxz8B3pVzkZihG8v+t4px/IbeLkWHsiIk/n906yyrxwOP0bs5WfML/01MpH53bcYE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZ3iuRvRzg30ssxftC9rtwt9IkyFRXNuhUmzAfZJVP2+yyQhK
	23UaXAFc3PfunApnqV+dSDdou3oZFJJuDpXPDYU8HzBYE+qxU1CzBVXvzks6XXPU9DB9TGRLgIO
	Zyq8zbIWRDiegX7S5cCN9ozUGlQ4=
X-Gm-Gg: ASbGncut5WHQbeLbG7r74QgQyd7f/HXZrFAnSFRmzSADri0gqMzMJGUUKVbn8qV9eXF
	f+qGqMRUn+37o79WbIl0OZWNJoxIQbQHmp8yKWMTMhWB2Q6A5GVS/0MMN/dGQhcslf6uOBLxOZy
	5fHfb6l1gKyQ/BEVjgDNrDwxOfEwJpivo=
X-Google-Smtp-Source: AGHT+IEWRKsXcGxncFg9hth5BmHc0V8RR9D1H13BqW8NeRoxeo/40CcTxf3ORh2ekDNgzDn16Ed0Hyb4JWL3Xw1EJNI=
X-Received: by 2002:a05:6122:a19:b0:520:4c93:d9a7 with SMTP id
 71dfb90a1353d-521c466809emr111848e0c.9.1739898836267; Tue, 18 Feb 2025
 09:13:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Feb 2025 09:13:55 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im> <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 09:13:55 -0800
X-Gm-Features: AWEUYZlrYH6VR985V_CDMr0DsbdweOASaHRdVT91HByK0Msd7YWoax7aJfaTmzU
Message-ID: <CAOLa=ZQzEwWci350dhhTFiG3WZB67JUB4O9L3coiXeexYGTNZw@mail.gmail.com>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000014e231062e6dc4d7"

--00000000000014e231062e6dc4d7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The ref and reflog iterators have their lifecycle attached to iteration:
> once the iterator reaches its end, it is automatically released and the
> caller doesn't have to care about that anymore. When the iterator should
> be released before it has been exhausted, callers must explicitly abort
> the iterator via `ref_iterator_abort()`.
>
> This lifecycle is somewhat unusual in the Git codebase and creates two
> problems:
>
>   - Callsites need to be very careful about when exactly they call
>     `ref_iterator_abort()`, as calling the function is only valid when
>     the iterator itself still is. This leads to somewhat awkward calling
>     patterns in some situations.
>
>   - It is impossible to reuse iterators and re-seek them to a different
>     prefix. This feature isn't supported by any iterator implementation
>     except for the reftable iterators anyway, but if it was implemented
>     it would allow us to optimize cases where we need to search for
>     specific references repeatedly by reusing internal state.
>
> Detangle the lifecycle from iteration so that we don't deallocate the
> iterator anymore once it is exhausted. Instead, callers are now expected
> to always call a newly introduce `ref_iterator_free()` function that
> deallocates the iterator and its internal state.
>
> While at it, drop the return value of `ref_iterator_abort()`, which
> wasn't really required by any of the iterator implementations anyway.
> Furthermore, stop calling `base_ref_iterator_free()` in any of the
> backends, but instead call it in `ref_iterator_free()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c              |  2 +
>  dir-iterator.c               | 24 +++++------
>  dir-iterator.h               | 13 ++----
>  refs.c                       |  7 +++-
>  refs/debug.c                 |  9 ++---
>  refs/files-backend.c         | 36 +++++------------
>  refs/iterator.c              | 95 ++++++++++++++------------------------------
>  refs/packed-backend.c        | 27 ++++++-------
>  refs/ref-cache.c             |  9 ++---
>  refs/refs-internal.h         | 31 +++++----------
>  refs/reftable-backend.c      | 34 ++++------------
>  t/helper/test-dir-iterator.c |  1 +
>  12 files changed, 99 insertions(+), 189 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index fd001d800c6..ac3e84b2b18 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -426,6 +426,8 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  		strbuf_setlen(src, src_len);
>  		die(_("failed to iterate over '%s'"), src->buf);
>  	}
> +
> +	dir_iterator_free(iter);
>  }
>

A bit puzzled to see `dir_iterator_*` change here, I'm assuming it's
linked to the 'files-backend' and perhaps similar to the changes
mentioned about `ref_iterator_*` in the commit message. Would be nice to
call out in the commit message too.

[snip]

> @@ -223,7 +223,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  		} else {
>  			if (level->entries_idx >= level->entries.nr) {
>  				if (pop_level(iter) == 0)
> -					return dir_iterator_abort(dir_iterator);
> +					return ITER_DONE;
>  				continue;
>  			}
>
> @@ -232,22 +232,21 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>
>  		if (prepare_next_entry_data(iter, name)) {
>  			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
> -				goto error_out;
> +				return ITER_ERROR;
>  			continue;
>  		}
>
>  		return ITER_OK;
>  	}
> -
> -error_out:
> -	dir_iterator_abort(dir_iterator);
> -	return ITER_ERROR;
>  }

Okay yeah, we're getting rid of `dir_iterator_abort` so potentially add
`dir_iterator_free` below

>
> -int dir_iterator_abort(struct dir_iterator *dir_iterator)
> +void dir_iterator_free(struct dir_iterator *dir_iterator)
>  {
>  	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
>
> +	if (!iter)
> +		return;
> +
>  	for (; iter->levels_nr; iter->levels_nr--) {
>  		struct dir_iterator_level *level =
>  			&iter->levels[iter->levels_nr - 1];
> @@ -266,7 +265,6 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  	free(iter->levels);
>  	strbuf_release(&iter->base.path);
>  	free(iter);
> -	return ITER_DONE;
>  }
>
>  struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)

Okay this makes sense!

[snip]

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 29f08dced40..9511b6f3448 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -919,10 +919,6 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		return ITER_OK;
>  	}
>
> -	iter->iter0 = NULL;
> -	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
> -		ok = ITER_ERROR;
> -
>

Since we're explicitly going to call `ref_iterator_free`, this makes sense.

>  	return ok;
>  }
>
> @@ -935,23 +931,17 @@ static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  	return ref_iterator_peel(iter->iter0, peeled);
>  }
>
> -static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
> +static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
>  {
>  	struct files_ref_iterator *iter =
>  		(struct files_ref_iterator *)ref_iterator;
> -	int ok = ITER_DONE;
> -
> -	if (iter->iter0)
> -		ok = ref_iterator_abort(iter->iter0);
> -
> -	base_ref_iterator_free(ref_iterator);
> -	return ok;
> +	ref_iterator_free(iter->iter0);
>  }
>

I like how much more cleaner it looks now.

[snip]

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a7b6f74b6e3..38a1956d1a8 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -954,9 +954,6 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		return ITER_OK;
>  	}
>
> -	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
> -		ok = ITER_ERROR;
> -
>  	return ok;
>  }
>

The merged_iterator is used to combine the files and packed backend
iterators to provide a uniform view over them. Likewise the changes here
seem similar too.

> @@ -976,23 +973,19 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  	}
>  }
>
> -static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
> +static void packed_ref_iterator_release(struct ref_iterator *ref_iterator)
>  {
>  	struct packed_ref_iterator *iter =
>  		(struct packed_ref_iterator *)ref_iterator;
> -	int ok = ITER_DONE;
> -
>  	strbuf_release(&iter->refname_buf);
>  	free(iter->jump);
>  	release_snapshot(iter->snapshot);
> -	base_ref_iterator_free(ref_iterator);
> -	return ok;
>  }
>
>  static struct ref_iterator_vtable packed_ref_iterator_vtable = {
>  	.advance = packed_ref_iterator_advance,
>  	.peel = packed_ref_iterator_peel,
> -	.abort = packed_ref_iterator_abort
> +	.release = packed_ref_iterator_release,
>  };
>
>  static int jump_list_entry_cmp(const void *va, const void *vb)
> @@ -1362,8 +1355,10 @@ static int write_with_updates(struct packed_ref_store *refs,
>  	 */
>  	iter = packed_ref_iterator_begin(&refs->base, "", NULL,
>  					 DO_FOR_EACH_INCLUDE_BROKEN);
> -	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
> +	if ((ok = ref_iterator_advance(iter)) != ITER_OK) {
> +		ref_iterator_free(iter);

Nit: Since we don't return early here, wouldn't the `ref_iterator_free`
at the end of the function be sufficient? I think the only early return
when `iter == NULL` is towards the end of the function, where it might
be better to add a `goto error`.

[snip]

--00000000000014e231062e6dc4d7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dd79a0bc6b7a2f5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lMHY5RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUlqREFDalVpY1Vqc3RLREVlaXpOU2xMVGJUMzNPRQpBTmtVUmhneXJR
TXRWU0VwaGU5bzR0RHJVQkRhREhQTm9UZUFwdE1LMlBtblkzYzFsOW1WaU1GbG1IM2trVTJ2CkVs
clp5YTRWQ3VOMFBjNkZTU1JwLzk2SmJhNDBpSFk3SVVJd2NERnQrNEV5djZ4Z2RGMERpZUQzdXpW
Q1FnTU4KdGFyRHV1TlErbHFNLzd6MHhySlhIVlhxamp3VW1iRm5CYTdrMHhQU2IrdVpvNngzWVFW
bkdrSCs2TWRQanlXQQp0L1JZeWZkdTBjS1loWFNjMzlvNWVsMTVtOGdBLzk0TzRXSVRYd3JGdUoz
c2dXTnRHQnRhVmJDVnVVWFZQNEp2CmZZYnp3UDFncnpPTW1YWEdkZ1F4R3dkUGtOaW1tbWpZd20y
UExQQTF3QVVFR2V0RzZBS0FWOHhlQkk0bVJjb2MKSVhkanFoRnpGOTRYL1h4VFZIa2ZpMi92WXcw
bzR4eUtZYm1OWlROZnZaUWI1VFdzcngyRWcraDVOVzB4NnEzNwpUWDVBcFhZMDIvU2IrSnBYaXc3
TVNyZTlCbXp2SUo2dTRaMisxZjdtbUdPc3F4dmxNM3pBMkNzQ0JFS212WjB0Cmh0NUNra0l0cE1l
STlSRlN6MkRjVnkvaTNhaFdrekF5VkJlNUpkbz0KPWNrSlYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000014e231062e6dc4d7--
