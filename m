Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20E202984
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259244; cv=none; b=Tat1n1HFRhwCH3LtWDcZ9/L5UzjRr/xmPsscyOWbWsttteqPPmlNvP1tLtUnN6KVWFIc4Im3WJP5zmn5w/4V8mgIJZ4+YClpfLSz3Znwwr2seTo/miTtepVRjUQyR0q589+VGXbKWg39EVQBynxkYhs681QdeyV+RXDxaoYe/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259244; c=relaxed/simple;
	bh=IrfOXh1//bERmdeL9IxhTUGR8ynYWz1hvZRaMRjV5t8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=NyttptymnDg0NS5RjIr9diTM/DiUbJG0pTr2kakF6tWotl55BJJ5VmT8vBZDxF7kwrIFf5Ep5q3eEpKHnY1TX1Rn5++pahlqQrmR3ohA9R9N4kexTW/nVBOXmR3EEh2MR1SmHk/MiV0A/0QD+10tz7Kd5ypCU/u/TOekXd1WIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyektjO6; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyektjO6"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51eb18130f9so248923e0c.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 03:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741259241; x=1741864041; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5rX9VTH6S4x+njy7g7kMe6vzXwqCn8kbrmu9MMjgss=;
        b=lyektjO6FEbEry+ISTzOdWwtOjRb5bKyBG/Icyk1Ivcp6SqLJYkax7lhyTN9XLKCd9
         B+ObPhLH0dwYUpSm39i9FqrOt550uPaeeF7yN3OkXjQvSVhfvNKk8ONfCnRJD+ZuGxmv
         Ppi9mVWEbcevY9Ui2CUj1WhmVoQc9NAXyJUh5wgVuhPC3PR7zaEOaozPuvHf6h9WX82B
         XLS8++pu40cjkyyNZLe0JeJd9ujYogczp6H+kUaDacMzkr0odM7ozORG/5H9ygKrxbgd
         RgTK20IDnI3k5QyPOPETvPen0jxUlS1eVrJmtg8KwXMaYaj4NAXMj/vKlzeMYvQp+XzN
         qHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259241; x=1741864041;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5rX9VTH6S4x+njy7g7kMe6vzXwqCn8kbrmu9MMjgss=;
        b=NAU+td+IcOUhlAV2G/yrMJPtkidMgR70/pIuxCM/irs4DHtBwSoie5JBRBFEhf2O3G
         lIRyG8gfIedAKhrRpd7U6vxZIIOLOTFnzZIUZ8pAJ/O4VDEw5if9oMDKXY7ix1OKGMN7
         /WDxWc7CIqMmPHJijrk8CSzwP3AsuXTnQkUGMOFjUmIOwdCtdRjBX4YQARcXV7ynqgia
         7sxt9HpACv326wuKyERHugePx79/sskkX2V1bff9FQfPwPTtPD+ss+li+H4FmeRx96bB
         cGRR7CfO1744ikf7D0tAXsimla5edmSxbVjChsO90Zgznsq6SEvPju7SM2EVo83T9A2c
         Vx3w==
X-Forwarded-Encrypted: i=1; AJvYcCV6aLSQ7UKREh/F+aOOgHBBzZf70gMs5twW6FNWGyeMH1sS5/kTYXcOdGXrKbzOXgxoTJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7f/2EQf2sObRwam53co7OcbNQz7EEat4yvb52MGbF92W+GIkl
	18gYbqKqnifpT8ZfVvXYiD1+Df2DLFpgbxEvlxFh7FkWKJa+Oy4fnlo0MOr9L+AaZoDe99i3Rnm
	lmikcR8F5K+ZJqopFVylIMx728kU=
X-Gm-Gg: ASbGncvV5TvSLjN4zIyuSP1V3mQ9BzZYNxl7FmM/0WM0vN9Z2g/RGPn+ZU89N6+mQ+l
	9MfeoA1HrqDMxHUlOVEW/dl7USosYcsgc1wjt2tJwMevMtoEobqjCYb+8nxxP2C4W/s03fscSSz
	FKYQ84vuvOZuib3NgPdb0gI6yN
X-Google-Smtp-Source: AGHT+IFZPsePgfhn1/LgTNVPrVXHC1fDDvY41pn9pf4VAr6tEQeH/3YxIPy4lO4xnG/gG3rpXLmZ3DvWdSdJh4lbrEc=
X-Received: by 2002:a05:6122:3d15:b0:520:42d3:91c1 with SMTP id
 71dfb90a1353d-523c62dc296mr3734938e0c.10.1741259241432; Thu, 06 Mar 2025
 03:07:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 03:07:20 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-2-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-2-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 03:07:20 -0800
X-Gm-Features: AQ5f1Jo0FdCTcZk_R7If6Tyo4EV-lBewKItzij_TeHxvHN3Sd266mhTeYqmNscg
Message-ID: <CAOLa=ZQOoif7zFY30dF+SewKZw1Y8wTOq=npMpUzsJxtr_0mww@mail.gmail.com>
Subject: Re: [PATCH 02/12] object: stop depending on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008c731d062faa82de"

--0000000000008c731d062faa82de
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> There are a couple of functions exposed by "object.c" that implicitly
> depend on `the_repository`. Remove this dependency by injecting the
> repository via a parameter. Adapt callers accordingly by simply using
> `the_repository`, except in cases where the subsystem is already free of
> the repository. In that case, we instead pass the repository provided by
> the caller's context.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c         |  4 ++--
>  builtin/grep.c         |  2 +-
>  builtin/index-pack.c   |  4 ++--
>  builtin/log.c          |  2 +-
>  builtin/name-rev.c     |  4 ++--
>  builtin/pack-objects.c |  2 +-
>  builtin/prune.c        |  2 +-
>  midx-write.c           |  4 ++--
>  object.c               | 21 +++++++++++----------
>  object.h               | 10 ++++++----
>  pack-bitmap.c          |  6 +++---
>  reachable.c            |  6 +++---
>  revision.c             |  3 ++-
>  shallow.c              | 10 +++++-----
>  upload-pack.c          | 12 ++++++------
>  15 files changed, 48 insertions(+), 44 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index eea1d43647f..a441eda7ff9 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -399,12 +399,12 @@ static void check_connectivity(void)
>  	}
>
>  	/* Look up all the requirements, warn about missing objects.. */
> -	max = get_max_object_index();
> +	max = repo_get_max_object_index(the_repository);

Nit: I understand the rename here, but would be nice to callout the same
in the commit message.

[snip]

> diff --git a/object.h b/object.h
> index 17f32f1103e..0a5293e9911 100644
> --- a/object.h
> +++ b/object.h
> @@ -169,12 +169,13 @@ int type_from_string_gently(const char *str, ssize_t, int gentle);
>  /*
>   * Return the current number of buckets in the object hashmap.
>   */
> -unsigned int get_max_object_index(void);
> +unsigned int repo_get_max_object_index(const struct repository *repo);
>
>  /*
>   * Return the object from the specified bucket in the object hashmap.
>   */
> -struct object *get_indexed_object(unsigned int);
> +struct object *repo_get_indexed_object(const struct repository *repo,
> +				       unsigned int);
>
>  /*
>   * This can be used to see if we have heard of the object before, but
> @@ -231,7 +232,8 @@ struct object *parse_object_with_flags(struct repository *r,
>   * "name" parameter is not NULL, it is included in the error message
>   * (otherwise, the hex object ID is given).
>   */
> -struct object *parse_object_or_die(const struct object_id *oid, const char *name);
> +struct object *parse_object_or_die(struct repository *repo, const struct object_id *oid,
> +				   const char *name);
>
>  /* Given the result of read_sha1_file(), returns the object after
>   * parsing it.  eaten_p indicates if the object has a borrowed copy
> @@ -336,7 +338,7 @@ void object_array_remove_duplicates(struct object_array *array);
>   */
>  void object_array_clear(struct object_array *array);
>
> -void clear_object_flags(unsigned flags);
> +void clear_object_flags(struct repository *repo, unsigned flags);
>

Could you explain the reasoning behind only renaming the first two
functions with 'repo_'?

>  /*
>   * Clear the specified object flags from all in-core commit objects from

[snip]

--0000000000008c731d062faa82de
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d5fe2a1f81ead6cc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSmdlY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHNEQy93SjYxRjVOczBVcHp5UUFGYzJMc3M0aVBjRQp4QjB6bHRJaDVj
NmcyN2hLVVRNS0VKT1hLcFh3czNHbXdwMjQwQnk4L1dtTG9wK3NYakdpSmxqNzd4MlhaU1VKCk9x
aUttRitCZGQzK3lvZjV3WVJ4OGljSWpnVHZrNVlvY0xRTUk0R01aOCttMWl4N2V4SVZnK3dGa2xX
UTBCSTcKaHlTT1g4VGtYMjBOSzZYalRnWndtWW8rZHB6NVZOWjl4cHpGcVdpKy82Q3daNkUrTHpV
ZjRkbm52SzdGQzJacwpBeTJ5ZFhOYWdpVHZubUNqK3YzU0ZUbGhqMEVPb0V2QkYyY3ZsSENUZUxB
TVlscmtGNHJ3TExsR002emMxSmVsClUyVnFkdzYwTUEzcm5yMlBuRkEySTB0bms2UUsxd2ZiYzFo
L09zNzN1YzBJTDd1S1RMK01PbEswck5SeDc0VXAKUzJkdHdhL1ZxOFNGenM5RW11UCttMzY3cHY2
R1RaUG5rRTQ4TXk5UFVXS2RkSFhQTS9KU1lxUTRhbTY3VzB4ZQpZcWtDZmllK1ZFWnB0T1ZPZ0s4
ZmNMWVpTSGhIcWIxR2tlMkVuTURtK24wdm5ZRWpjOXR0My9WRzc2QUtJZjBWCjdTVHhBTThhTzRh
SWkzODJyOG8yaHJ0NGwwdk10SXNrUlcyQTk5WT0KPXdXbDcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008c731d062faa82de--
