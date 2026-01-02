Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDED125A0
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767343709; cv=none; b=Rd2A1rnmKktxwpZK+RvTQS9YbF0W5ZFp35+Vtx1oRygnVu+qwKnnRVi5qqo5WezjJ335vB9aENoBs4a2uSC7eU8d/yWzME981BdglRWKEGOpluH1Xx9KxZEc0EMZ9NfdY1ItWPngOiRuwaQi1TvyozeMFMBIos82u0MQ0EzU7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767343709; c=relaxed/simple;
	bh=HOouiGXkoBLutUQIBQVMkdep3AwgLQhWTAQ5UNcSZPA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sj8i5W7GyqXzTTnaYwoRNb+P2aztp57EfXCNp3jsI3NaOb2gWLWljfSqdkMY0IXFgYwoEOs3NurFjEil33KqUOtW3X0f9LUjrpty4ZO9ll22O1wwp7L7uzDBm2w8GdLCsMXLbBMLzgs+wER4FDoqri4lZGi3Qnz7HsR+dhWgEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSUQp8t/; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSUQp8t/"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dfd380cd9eso8867744137.2
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 00:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767343707; x=1767948507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAk/o9xikVByxOk2/ObilNlkuT70lTxqMY/LIUnlidA=;
        b=GSUQp8t/So9XZgS/a31TRmjA7KJcPaHXuXF/rPRc00TzpePmgOvakE0IZZDiFW3onc
         3AQUIs5WJ9rg+M09qVBFs/vU26+tvuulWcMiixP23WfbPA8WhBCEWBfRQr0fBRjVxouU
         OkdajS/UyFG5E1bZzD6ftJGzeMf1PmgGIBarYebcmruRWOnjP3RjGJ2KtjNQZr69ebkg
         kILuHOVRkzs/YsB8F5CZeDUX2VcpWHfDlfPFolxaIJvDNGMdWW6Mk3mg1TCXxsXRWQSt
         eGBxDmTFG4UPmC/z2MRbjklpJl67JkiNR/zP5EVQjwDuRxjReI9mI2EZi/aqSEi6YVDz
         ar9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767343707; x=1767948507;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAk/o9xikVByxOk2/ObilNlkuT70lTxqMY/LIUnlidA=;
        b=GNUE7dPoLbVx6SO1x53Hh265Vb7J9LdBggvs7FeTGJJVfSNadpq6W1v8/dudv8Z+N5
         Xxro3O/CMqvfzhkSIJxaNKfIZCxhLJiLtL2lIicjBLwOgkHm/vQDOXxKQum63774pjk9
         F1rH8cBBTIsrRCm6eQTwhNwfDo4cR77PqeTh+8OKRnt09X33pvVb1kAtrYWQqFR4o9YF
         L1peyFGr02xljWz7Dy9iGo+shbwIQlLRJzIekMh1FcZxS5vgS1l3KVRIqjuMdCqwVJmM
         6/wh/y8nyuCqJOyVV62d1804fqOy+DUOo4NACEnVrLx/lKsFeebGVyU8CgsOH5NchgaA
         WI0w==
X-Forwarded-Encrypted: i=1; AJvYcCWB+JfyyOwTpmuAk7kbq7W3OivYaUKM01hmfhd4nkWdL72TCqLmqgufEHqsKMqVwM9YKYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyW2lbZORSKFVTbSJ3Him6rmKQy2h5Fieux2QN1Ld7ujJVnVzm
	KEXkJ2AxuAgy42F8zCltaHmfw22j/08WJS1WfYQPRY3HMNWlQTy7mdyEw/ZRI/Pyi0P9LYBQqij
	WBsW/f+wHjKLqYPmqxk+bEJbK//y7DiE=
X-Gm-Gg: AY/fxX7xmiWxfMa9rxiuzRYh1QWHcibP01TXvbrSHqvK3+KJNRrB9CUKiKKceqAa763
	9wbp86i49c4k1GPXS/4BfsBaP7Dz8Vn+j2V4jvYZpS6uqhW8NXSWE4TVUvNklspZr/6OZ+/ZfwX
	xZ/xrHXxRigiOMXnqAXIjOKenSQBshcsfJushGy2Kn26nZ8nEv8kqGItMLH+J1fEc59/kYEObGX
	KNrcbvJ5XQFDXaZEAWqMwSabCB0jTrZQg2/ayliYkZrG+/JjLds+Su5mAPXu0Y+vSvoewYfYaoK
	WSbuD7HIRtniXOKswlHsoI6Tf/5oZVV1aMHSuRTi
X-Google-Smtp-Source: AGHT+IEdA+qzS5ZIg+UEnEG89iEsCd6bNgMC61CtQBLrsrQRwXMgRxlGRzSFwlFjXq1lR9Tz9NCKAvCwhgHRTxyjQNs=
X-Received: by 2002:a05:6102:424b:b0:5df:af0f:308c with SMTP id
 ada2fe7eead31-5eb1a849bddmr15261120137.38.1767343706899; Fri, 02 Jan 2026
 00:48:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 03:48:25 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 03:48:25 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aUO7jQQAERTe5xYc@ubuntu>
References: <aUO7jQQAERTe5xYc@ubuntu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 2 Jan 2026 03:48:25 -0500
X-Gm-Features: AQt7F2rzxcF0vuqkmyNzpmm9uQ1Qy5i8V3a-jTHNmOWkfMcwazySR8E5YRDCIZw
Message-ID: <CAOLa=ZRDFdZJWsq5JOckRgfF2V0Whv-jCxbpgeRi80NOs0oTDQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH] environment: move "core.attributesFile" into repo-setting
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000d89d8f064763c5d0"

--000000000000d89d8f064763c5d0
Content-Type: text/plain; charset="UTF-8"

Olamide Caleb Bello <belkid98@gmail.com> writes:

> When handling multiple repositories within the same process, relying on
> global state for accessing the "core.attributesFile" configuration can
> lead to incorrect values being used. It also makes it harder to isolate
> repositories and hinders the libification of git.
> The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
> retrieve "core.attributesFile" via `git_attr_global_file()`
> which reads from global state `git_attributes_file`.
>
> Move the "core.attributesFile" configuration into the
> `struct repo_settings` instead of relying on the global state.
> A new function `repo_settings_get_attributesfile_path()` is added
> and used to retrieve this setting in a repository-scoped manner.
> The functions to retrieve "core.attributesFile" are replaced with
> the new accessor function `repo_settings_get_attributesfile_path()`
> This improves multi-repository behaviour and aligns with the goal of
> libifying of Git.
>
> Note that in `bootstrap_attr_stack()`, the `index_state` is used only
> if it exists, else we default to `the_repository`.
>
> Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
> The link to the GitHub CI is provided below
> https://github.com/cloobTech/git/actions/runs/20284228144
>
>  attr.c          | 20 +++++++++-----------
>  attr.h          |  3 ---
>  builtin/var.c   |  2 +-
>  environment.c   |  6 ------
>  environment.h   |  1 -
>  repo-settings.c | 10 ++++++++++
>  repo-settings.h |  8 ++++++++
>  7 files changed, 28 insertions(+), 22 deletions(-)

The change is very welcome. Apart from some small comments below, the
patch looks good.

[snip]

> diff --git a/repo-settings.h b/repo-settings.h
> index d477885561..362f355267 100644
> --- a/repo-settings.h
> +++ b/repo-settings.h
> @@ -68,6 +68,7 @@ struct repo_settings {
>  	unsigned long big_file_threshold;
>
>  	char *hooks_path;
> +	char *git_attributes_file;
>  };
>  #define REPO_SETTINGS_INIT { \
>  	.shared_repository = -1, \

It would make more sense to rename this variable to
`attributes_file_path`, that would better denote what is actually stored
here and syncs better with `repo_settings_get_attributesfile_path`.

> @@ -99,4 +100,11 @@ int repo_settings_get_shared_repository(struct repository *repo);
>  void repo_settings_set_shared_repository(struct repository *repo, int value);
>  void repo_settings_reset_shared_repository(struct repository *repo);
>
> +/*
> + * Read the value for "core.attributesfile".
> + * Defaults to xdg_config_home("attributes") if the core.attributesfile
> + * isn't available.

While it is obvious, it would be nice to point out that
`core.attributesfile` is set via config.

> + */
> +const char *repo_settings_get_attributesfile_path(struct repository *repo);
> +
>  #endif /* REPO_SETTINGS_H */
> --
> 2.34.1

--000000000000d89d8f064763c5d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 52504c1cc556bc0c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sWGhsZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnY1REFDWEdyaTZ2NCt0a3d6Wm81Qzltc2RSTER1Lwp6S29wOExtRmtm
U2czZ29GZ0x6Y2dzMXMyUVpFSjl2bXptb1pKRlZONDg2N09hb1hXUHVXTWpROElrb2dkWFVLCnFw
UnJqeTRjNXI3UXpVZEhpNTM5WWMxYWN2V0FlQnFCUW5oNGFiNWZyVURIbVJJU3luclhib3UvK29n
eWdwYXIKL0dSSyt3L3BmQitxcisraVBaNDJ4YnpieEJNdTN3Sm9URjE1VHZDU3BMQzhEaFhtbVpL
cTBYVEYvYm5sbXgvNwpIZU40S2ZNeG9qa3NBRS9HL3NSTk8wZWIwaDJnUStRZVR1OS80dWJNc2RL
OWtqd0NoaHBxQlZ4TjhFWFBwam9GCnpsOWZyUUUwMzZacEdmVXBGd3dnNlJxVTc5THUrV0c5WVV4
VmYwUEdzdVN5WmthWlBHTkxUaDdMMDZCdmJHOUcKN3lxbytXbDBkNGZKTTVGUHVHQ1pOdm4waC9D
M1pOMlk1MmJWS29MZGhURjlySmlJOCtENjNSa1A5LzNBb09seQplN3k4Nm90cE0zOXpHZTZrZmF2
QS9HM2R6bnpvdm4zUWpSL1BIUWppVWVKbHpMZjlQTm4xZnZQVFZKZEljV3cvCk1xU1JtRVd0MmRP
cXF2SEV4Vk1WSklMTnpXVW5LSUk1R1VKNk90UT0KPXdMYXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d89d8f064763c5d0--
