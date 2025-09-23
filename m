Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321A3203AF
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620687; cv=none; b=a0pt6+ECviF6/v7Oer7xdJsvh54dLcC50k6j5SdMvd2HQxipSuR3ECHR1/AnfeW7pmoBO4znuX3jA6FkYoyhhTcI9yr17j5h27snDWaocwBu2okuXf+BEC0Jh4KkGQEdC9SKL/3y+Yrs1IXDg83OLy7/AexaAJ6HD9O2+55oSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620687; c=relaxed/simple;
	bh=oAY9Uc0Q2k70y3UYr7mFYsx1KXNob/ihNUgi/4wghnA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IICPxG6koizezHqLBVQp+e+8rkN3R1bUrbKQqL99ilneCWfh1xtUUY8nF+E+tHKzcMjPTjl0RJvPT3+sYesvyBPTWzBc1LE6iNQBoQicM5iALtiL5wExOLo01Lb79m2MiKCRaBPijbh6BTXDO/DsBtnlfiSXXXFMLxuEst23axY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/ViDvMz; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/ViDvMz"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018e9f902so2896701241.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758620684; x=1759225484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEW49Yk8XCWoTCju1f6ARADCosmdD/BNHD/eLKlT9gM=;
        b=i/ViDvMz95vShiQ9GeuB/ikb4qCuxGykxh5gCN3uxx5Xs32ewPh3I0zUlvJqWnMKUP
         lbbxVyShKZQqq1HqujL2uKZXX4cnbER6sW5IdaNEl6Oe4udrXnUtPT2pAmJU+N7YqXyM
         orsXpxvxCn6KHPciNbRn0X/a1FUMizUxixVH+p39L8z2pEjAlUGAMvBmb6H2RR3qUGmh
         EyMftzQi66852ilJNejUz0KSBg7VZ0/2ELb0Z3fzuNMsukK0Igwk0q1AdgoBMJ+wTwa9
         Uw83JEzZ3XYv/CQKykF707Gv5C1dFn8I3mvEJq03Xv8I7rbOt8S5xEGdqsWu8AGb/GF8
         NvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620684; x=1759225484;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEW49Yk8XCWoTCju1f6ARADCosmdD/BNHD/eLKlT9gM=;
        b=RsqK4bWodDl+BOnE8JCnFlm7oQpuYfAhl+QodkGf1oQRi3HEn9/Ee3qQ8/6djmG7r8
         Z4Ue9KQjK8P6J95+gs/kUzY4roR2PP9pVfyOxZ9wyw3/9y5+4hgNiYvu5oXsamLZM+pO
         Bhldq1QCIWfa6Lw0fJ8YcjA145tqHe8qEInqrguW4kBx9QlIot9ivp46xYJ5Wnlv/Q4T
         UwtKNmzIW80Q6jwgabg032OaFdea9i+S2YiR448V9iLBCSTRUszD97dje4CIl9i7+XQ/
         7Np5qBCJ5mYohpbsrhYyizivd5VPid7KD8Opf0zbwE34+T73NQjTc3IQrS2hoW8FaEjy
         epMg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Epr9pkPk4ys6FwnJJPiqvDn0WMv8BPSOMJqdivwOj1O4K5gNKWdS1YCkUUVtbVUzyCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYLYTKfY6jV6M5tSIIpMbCyLk1UmDgdzC3KLibBE4Z62p8x8F
	FSXc8sEIOsdqcx/OYIwFePYZxWVX1pKVoIpxtRV5P9Go4AB9imdOGr0Y2clX/VQhBoE7ZJ7acqD
	Yc/B3ms+F4qg4F5B+eG1OB+IXE6r2QN8=
X-Gm-Gg: ASbGncsj5ErnO0b+VBCOsYKPZOUrJYTXcS+o4x3zYu/W72k/OVhzS/R1pLPqbiPNAN0
	xl451YijKrmSq+sx7EIlI6Lkl2JDmmaKzZdfNZYO3s22GSQ/blqD75T16YNy9EcjSlcWPqF/bs3
	e0UrER3dn/jfWNU0HRaIe+wvdaJGUHJYwA69+hNrByoP4b0ohzQ0IKjkh64AYqaWbXpeQYLaElS
	BnXxho9nD9MIkceVten4I8thmWwb13HWiGhPMdaeA==
X-Google-Smtp-Source: AGHT+IHEBXWNQoiEL7w/Ae3Tve+Juw3HMPztuC302D0i12fbiYeM447aqEvI8Asx9s3fTGPS12pDA+HdBui54hpCe80=
X-Received: by 2002:a05:6102:4492:b0:522:db47:90ac with SMTP id
 ada2fe7eead31-5a57d8d8447mr605983137.6.1758620684247; Tue, 23 Sep 2025
 02:44:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 05:44:42 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 05:44:42 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aMp9Qs2AHBax62LL@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aMp9Qs2AHBax62LL@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 05:44:42 -0400
X-Gm-Features: AS18NWBBAbQGucDfhvFD9D-43CyfiLDXuxKGJlVrOzKFrH47x1hUk2DG-uphnN4
Message-ID: <CAOLa=ZSGb_vvcneJ-b7ahL8J46a-FFKzupXaO0eKcyNehwTF+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] string-list: change "string_list_find_insert_index"
 return type to "size_t"
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000002e19ed063f74c93a"

--0000000000002e19ed063f74c93a
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> As "string_list_find_insert_index" is a simple wrapper of
> "get_entry_index" and the return type of "get_entry_index" is already
> "size_t", we could simply change its return type to "size_t".
>
> Update all callers to use size_t variables for storing the return value.
> The tricky fix is the loop condition in "mailmap.c" to properly handle
> "size_t" underflow by changing from `0 <= --i` to `i--`.
>
> Remove "DISABLE_SIGN_COMPARE_WARNINGS" from "mailmap.c" as it's no
> longer needed with the proper unsigned types.
>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  add-interactive.c | 2 +-
>  mailmap.c         | 5 ++---
>  refs.c            | 4 +---
>  string-list.c     | 4 ++--
>  string-list.h     | 4 ++--
>  5 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 7c0fd3d218..19def3168a 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -222,7 +222,7 @@ static void find_unique_prefixes(struct prefix_item_list *list)
>  static ssize_t find_unique(const char *string, struct prefix_item_list *list)
>  {
>  	bool exact_match;
> -	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
> +	size_t index = string_list_find_insert_index(&list->sorted, string, &exact_match);
>  	struct string_list_item *item;
>
>  	if (list->items.nr != list->sorted.nr)
> diff --git a/mailmap.c b/mailmap.c
> index 58a4484963..37fd158a51 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -1,5 +1,4 @@
>  #define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
>
>  #include "git-compat-util.h"
>  #include "environment.h"
> @@ -244,7 +243,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
>  					      const char *string, size_t len)
>  {
>  	bool exact_match;
> -	int i = string_list_find_insert_index(map, string, &exact_match);
> +	size_t i = string_list_find_insert_index(map, string, &exact_match);
>  	if (exact_match) {
>  		if (!string[len])
>  			return &map->items[i];
> @@ -266,7 +265,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
>  	 * overlong key would be inserted, which must come after the
>  	 * real location of the key if one exists.
>  	 */
> -	while (0 <= --i && i < map->nr) {
> +	while (i-- && i < map->nr) {
>  		int cmp = strncasecmp(map->items[i].string, string, len);
>  		if (cmp < 0)

So earlier, if `i = 0`, we'd have a negative number and then the loop
would exit. But with `size_t`, i can never be negative. So by using
`i--`, we exit if `i = 0`. Okay

>  			/*
> diff --git a/refs.c b/refs.c
> index f1ff5bf846..a8f06b9a0a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1688,8 +1688,6 @@ const char *find_descendant_ref(const char *dirname,
>  				const struct string_list *extras,
>  				const struct string_list *skip)
>  {
> -	int pos;
> -
>  	if (!extras)
>  		return NULL;
>
> @@ -1699,7 +1697,7 @@ const char *find_descendant_ref(const char *dirname,
>  	 * with dirname (remember, dirname includes the trailing
>  	 * slash) and is not in skip, then we have a conflict.
>  	 */
> -	for (pos = string_list_find_insert_index(extras, dirname, NULL);
> +	for (size_t pos = string_list_find_insert_index(extras, dirname, NULL);
>  	     pos < extras->nr; pos++) {
>  		const char *extra_refname = extras->items[pos].string;
>
> diff --git a/string-list.c b/string-list.c
> index c589ab5a2c..08dc00984c 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -91,8 +91,8 @@ bool string_list_has_string(const struct string_list *list, const char *string)
>  	return exact_match;
>  }
>
> -int string_list_find_insert_index(const struct string_list *list, const char *string,
> -				  bool *exact_match)
> +size_t string_list_find_insert_index(const struct string_list *list, const char *string,
> +				     bool *exact_match)
>  {
>  	return get_entry_index(list, string, exact_match);
>  }
> diff --git a/string-list.h b/string-list.h
> index 8830ce671d..6b0a2f4752 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -173,8 +173,8 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
>
>  /** Determine if the string_list has a given string or not. */
>  bool string_list_has_string(const struct string_list *list, const char *string);
> -int string_list_find_insert_index(const struct string_list *list, const char *string,
> -				  bool *exact_match);
> +size_t string_list_find_insert_index(const struct string_list *list, const char *string,
> +				     bool *exact_match);
>

Super nit: can we also add documentation to this function while we're here.

>  /**
>   * Insert a new element to the string_list. The returned pointer can
> --
> 2.51.0

The patch looks good to me.

--0000000000002e19ed063f74c93a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b32b74120c93a32c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU2JBa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNms3REFDU1NEOEs4TlFQWDlkZTVkaHd6d0xQSW1uNwp4V0FrNHNUNDZz
cENmazdsNUljdjN5cHI1UjIxL3QwWFJiVjNTOWY1cURUcGMrcy94QjNaRmxXV0x4TUZBNHNHCm1H
UXZBakhlT0Q5TWZBci9WTldwV25RWEFBK2o3NG5qR2FiZlJKeGNJbmdrL3RIWHRNSjl4WXNzZEU4
Z1VZQnQKYUJFOTFCRjc5TkRTbHk0aUVzQzV2THJqZUFwRUR6K29sZjhyNGFEaHpXdENIK0FGMjJo
cmJrb3ZQYTdKMlg3WgprMUdGNk16ZEZrYmhPNkxKRGk4ZFJlQ1hTMVRJakZ5U1ZuSUxoYmxQRkhm
R2pKS3pJSkRhankwTVc1TVZSL1QxCnNtREdDRk5heVBWUFFJbUIyeG93SksvYXVxdGhyRVBaLzE4
SGhJMUhqZERkaG96QjVOeHAyNmdSYnYrZ2hrV2YKUTFJUEgyLys2UGV2KzZhOXU3eG8yL3QvMlRt
TVMrYk9CdERJc0hjbURXTWgyOEtSUlR2VE9xQzloc2lUc3ZiRQpkU0I3WDh2WkJSL3lubG5HdWRQ
dnQvWFNXZVhJYWpqNisxd2dHdk96QUo0YlNUczhERGRKYWJoR05qajFTWmQyCkg1V1hmTmExeUhz
a2NEdW1zd0hzajhWTHZUeTU2OXpsaVJhNkc4UT0KPUlhRDAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002e19ed063f74c93a--
