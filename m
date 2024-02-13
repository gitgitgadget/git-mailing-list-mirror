Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C2612FC
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858125; cv=none; b=Y1qqQwWV7HSzop4p3wr5RKCQNYdGgTRXskVjzy8kxpOL11VLVdMLNET13im2G477gLkA0YFtA2w1l6Lr8YxlarNK5/aWJlxjm1xrBaAgJ8Rg49X545TVhqTaK/tns5fM1WS8d/0Up2VtWaREaIWfBNA100RgRVyhlCk6P+XKLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858125; c=relaxed/simple;
	bh=fN8Z6wYvztRqmGwtPpj+rae4Wyn/DY9O6NkiZgx1QXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YbxaaHhSD4lLBgqxev+yAD5FI1PVFvbocGqfv50jHjxlXscOf6CAJ147bZjlEDY/y8k/iMwjF3wnNfF0DqkrchKOO9qvg7a4WWD7kvjLLzksouvOZSVssEkL1jU5x8oqIfOSfPwCkY8AGXhZebgD5EjRNwoPkixxxYeWYYPEOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2qgzHmz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2qgzHmz"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60761bdbd4cso40283017b3.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707858122; x=1708462922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANzRiUL0aS+cfpXkvteXlTiGnAvONw6sPhew2QE9y8A=;
        b=a2qgzHmzUrhXHFqZYv+9tzMHDoxkTsWifWKfVazKXoTbc1R8rWgMgYipIZS9RhvhRf
         3m8iRQGivNH7p6A0ac+c6D2RA0USSFwCJ5UGWddkUF9HXbRxRnxXu0vaxRKBlHmccr2d
         L+HwEgoGL0f4byDZmDfCMktuBzrnWXPWDnzYA+3172RQF9FaX9kqUdS/OlYfCL4hdSbl
         snE3E9ch14M1CsbYBCHBMBwdOlIVDeQQnsqB+yG5uh3BkIPrBr3A95qY4xK/BpY5cSC2
         2AHWOhpHKKJwLeQicnqVcKS+Ch0Zv03uuXdkh32J5Lm1n6Aa/kwMj526B3ec3r5XKBar
         iwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858122; x=1708462922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANzRiUL0aS+cfpXkvteXlTiGnAvONw6sPhew2QE9y8A=;
        b=hvPysOGJlb8krMRdIX06ELrLKFX8vKaozT8K3fOFFpsjVGc4c9xTTcq5UDzLWBQL/2
         Q7WguIQhtHb8pg+52yBMl1kmMB0YHu0XhwPyZ9Dsy/4qQbfv6nteTIghtjvp4fEW9Vwq
         YiWQfiUXqiExYvfsMZ6BKde9vOFAd5AkaXuWdLayftSFHg8tL3joJerkNVphc05CaktQ
         +4csNr7YVaeAkVMe8u2Iadnt6fzkq1AntdudgtOwk6MET6kEn0BGcCVNv+w6hSIZJRxG
         dVrysEHyxB3J6OIT8gbX+vfkZfav7E1f9KKhPaMPJi2A3xmbnpb7SpUklF7nMG0/xe3k
         B40w==
X-Forwarded-Encrypted: i=1; AJvYcCUeuxiCNn7UAxxy9UsXnCUHeYYm9uo7d5y+zgTCC/EuCOubiW88ARPRYDNG/P7BjjQ6ERstpJOjC5XoIFsyAn8yAAnk
X-Gm-Message-State: AOJu0Yx7p1nhXqdDDyiM2PwCcXp8YF8AJd/gxsgfyDEnc98nDRW1/8er
	mVxFOYKzgSZTJanhFGbTdnUHQqpvGAWaumcJS57PKLRUvudeS8veWv21IhkPuSn35Le9IXKN6XP
	xlw==
X-Google-Smtp-Source: AGHT+IHV3uktckSUlbNGtap5TzE5GkRdpFqD1/4gLPVPT1iSU8xBoWH7Jkc9uxmJgY/Mlu+0VB14W9OPGpw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:d885:0:b0:604:45d:27e5 with SMTP id
 a127-20020a0dd885000000b00604045d27e5mr129745ywe.7.1707858122222; Tue, 13 Feb
 2024 13:02:02 -0800 (PST)
Date: Tue, 13 Feb 2024 13:02:00 -0800
In-Reply-To: <20240208135055.2705260-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com> <20240208135055.2705260-3-christian.couder@gmail.com>
Message-ID: <owlyle7o9iyf.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 2/4] oidset: refactor oidset_insert_from_set()
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

> In a following commit, we will need to add all the oids from a set into
> another set. In "list-objects-filter.c", there is already a static
> function called add_all() to do that.

Nice find.

> Let's rename this function oidset_insert_from_set() and move it into
> oidset.{c,h} to make it generally available.

At some point (I don't ask for it in this series) we should add unit
tests for this newly-exposed function. Presumably the stuff around
object/oid handling is stable enough to receive unit tests.

> While at it, let's remove a useless `!= NULL`.

Nice cleanup. It would have been fine to also put this in a separate
patch, but as it is so simple I think it's also fine to keep it mixed in
with the move as you did here.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  list-objects-filter.c | 11 +----------
>  oidset.c              | 10 ++++++++++
>  oidset.h              |  6 ++++++
>  3 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index da287cc8e0..4346f8da45 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -711,15 +711,6 @@ static void filter_combine__free(void *filter_data)
>  	free(d);
>  }
>  
> -static void add_all(struct oidset *dest, struct oidset *src) {
> -	struct oidset_iter iter;
> -	struct object_id *src_oid;
> -
> -	oidset_iter_init(src, &iter);
> -	while ((src_oid = oidset_iter_next(&iter)) != NULL)
> -		oidset_insert(dest, src_oid);
> -}
> -
>  static void filter_combine__finalize_omits(
>  	struct oidset *omits,
>  	void *filter_data)
> @@ -728,7 +719,7 @@ static void filter_combine__finalize_omits(
>  	size_t sub;
>  
>  	for (sub = 0; sub < d->nr; sub++) {
> -		add_all(omits, &d->sub[sub].omits);
> +		oidset_insert_from_set(omits, &d->sub[sub].omits);
>  		oidset_clear(&d->sub[sub].omits);
>  	}
>  }
> diff --git a/oidset.c b/oidset.c
> index d1e5376316..91d1385910 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -23,6 +23,16 @@ int oidset_insert(struct oidset *set, const struct object_id *oid)
>  	return !added;
>  }
>  
> +void oidset_insert_from_set(struct oidset *dest, struct oidset *src)
> +{
> +	struct oidset_iter iter;
> +	struct object_id *src_oid;
> +
> +	oidset_iter_init(src, &iter);
> +	while ((src_oid = oidset_iter_next(&iter)))

Are the extra parentheses necessary?

> +		oidset_insert(dest, src_oid);
> +}
> +
>  int oidset_remove(struct oidset *set, const struct object_id *oid)
>  {
>  	khiter_t pos = kh_get_oid_set(&set->set, *oid);
> diff --git a/oidset.h b/oidset.h
> index ba4a5a2cd3..262f4256d6 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -47,6 +47,12 @@ int oidset_contains(const struct oidset *set, const struct object_id *oid);
>   */
>  int oidset_insert(struct oidset *set, const struct object_id *oid);
>  
> +/**
> + * Insert all the oids that are in set 'src' into set 'dest'; a copy
> + * is made of each oid inserted into set 'dest'.
> + */

Just above in oid_insert() there is already a comment about needing to
copy each oid.

    /**
     * Insert the oid into the set; a copy is made, so "oid" does not need
     * to persist after this function is called.
     *
     * Returns 1 if the oid was already in the set, 0 otherwise. This can be used
     * to perform an efficient check-and-add.
     */

so perhaps the following wording is simpler?

    Like oid_insert(), but insert all oids found in 'src'. Calls
    oid_insert() internally.

> +void oidset_insert_from_set(struct oidset *dest, struct oidset *src);

Perhaps "oidset_insert_all" would be a simpler name? I generally prefer
to reuse any descriptors in comments to guide the names. Plus this
function used to be called "add_all()" so keeping the "all" naming style
feels right.

> +
>  /**
>   * Remove the oid from the set.
>   *
> -- 
> 2.43.0.565.g97b5fd12a3.dirty
