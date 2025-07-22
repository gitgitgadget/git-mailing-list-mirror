Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D182D3EF6
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175824; cv=none; b=eb2pWXzN9mmBLDxQPHVOWDnx1ynDEwKaZk9IPj/Mb3bIJGNcayDPdvbTPj32xRhMzY7WCuiR4X8+63jKGHQ0lilEO+jdgGWatezffkNcCyGVUt5/TfDIqsjNpcpm7wTB+5V1+cMj+obEUZXA1Mg6fsaijtqFIdTjWFrx2NORRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175824; c=relaxed/simple;
	bh=pZObfft8xvH3UhqdKt9doPSpiuSOpOWM1DUKkE4io3Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tB4ZDxw40qpd9MNQuc88jysCU0A+pPLiZ5d+ymCqpcPthKeXchyh6sm1sKmsbPvSYho/6t61NzoA75Anf4hmx1N0SJ4iI+j4aMYfAPrEpTF3YROe/IjX9IzIRqyT9CuFIZbyZIppTj8bfTGU+czMYj97jsBhkXuBM0r27jGAWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORHrHhOI; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORHrHhOI"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e8135adfccso424348137.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753175821; x=1753780621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6xduS3DdBI+I47sA/cLOIofiGoJE6VgK+kjyQdNlM4=;
        b=ORHrHhOIJsnL7c0MIXu6kr0WhVriWL53sSzJdKv/ZNYHLbZywYV6y8d1XRtz8pQgry
         FCbTG87jNO8BHv+Kzw0evfIbJCfiJMv6EaRgNfg2x3mKmMBNtgbcu9B34eSlUe+EA1qF
         a41+RoLv44XCDptOa0rj5KdC4ztUpG5O6VmqXJ+pdkgyPWThh4PWj/vk61cn3iPZ4248
         oHAHgPZ6xGNWOoOwFV6Eee5wR1kNUHoCTbHMEk9H/lVmk1EfmF4pRpFOifgX4d83eLAQ
         ZSvj8pCYadzNlS5/uOLTo872/E3ZDU+5T66GVYE0tT+7n/jIHBMDKXOGcbMRw/ewCjs8
         ZV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175821; x=1753780621;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6xduS3DdBI+I47sA/cLOIofiGoJE6VgK+kjyQdNlM4=;
        b=bY0cvnk551Jd6igpvyTaqfn0kenuUEuV1daf/LTlYeX2i1R+s0vNftMMLD3tXLOdZa
         KzaESHZt44w0ajHLT9qCgF8JxsJ/I/Cr+dJxiqLv4ZcHybszXFn2yd2epsHqFDRCdE9t
         P65uML8Hw+yg75gWK0sBVPcPspxpTududPRdnoIOZ6ppNy6ujiBqbgEVQoDuGkBkAGxB
         hBsAIxuBosOZoxAM27BbPMK0TqdvB9KEtOhfJsceCX3RveEEyFQFj1KgyqC25rrqwJkY
         8j7rc8RPfbO8Q8EAG12Qt+0JC9Kqq4IChhrcvQuShpqJklXxd+QlVrKiRESbILgwOL3O
         jxQA==
X-Forwarded-Encrypted: i=1; AJvYcCX9qNyJb/aTNwOLZg/8oU6EEWS/EqroJ0GqjmSw+qnKNUNwTL8PAXcrdOiDPj7lQVD/zBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBlbRGe3lIpz1bY8ILMddOekeY1dPfw6zS3vv9aCBh4+7ZuQQ
	SSb4t0VH08AUxJw5wKOQRqTV9bVGw+CLHc5pG8McwEJmaYR/U0fJ8mDFd2PT6oe49/4C+Wo7OkF
	tUFVNzZD9eINLmPMw1IHjN1uK7lIGBa0=
X-Gm-Gg: ASbGnctwDCJGrFX5aWe1LjBmiMLQudTgO11HL05B+oG8nwQYc4JuZZ2Fe5M76r+/Zgu
	01nIW62DksE8zQagewY0RNh2SEjmJ7lcKQk3LuzPtvnpFnS222KQJc8EpDjrF75ymiMjF9bg3TC
	csNI1OOhp8xjbrUntvt6KH/K0PVi9XuhZg3CzmWTMiAbz77ktiqAx0VXvVhj9GOCn8HK6DAPy9Y
	NLMOQ==
X-Google-Smtp-Source: AGHT+IF0Q47zZlubJYUHbYRd4EGfD2zHCzogUiOgjPU0TdWofkQGTqWkryif6fBJzM1uB4IP2O4oRYD4/sg0f+QWDtQ=
X-Received: by 2002:a05:6102:6497:20b0:4f9:a927:d9f8 with SMTP id
 ada2fe7eead31-4f9a927e926mr5106875137.8.1753175820961; Tue, 22 Jul 2025
 02:17:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 09:16:59 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 09:16:59 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250722002835.33428-3-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com> <20250722002835.33428-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Jul 2025 09:16:59 +0000
X-Gm-Features: Ac12FXzvneURMu0Zfa9olcMnjy0eSRUqqdaxrzt2NqYbITZimy_-CT0F6a8vNR4
Message-ID: <CAOLa=ZT12oLjXc_UPVgD6Vut7tgvQS5=8qzxaxG09UTw_w8sJA@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, ben.knoble@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="00000000000009a5cb063a810ef9"

--00000000000009a5cb063a810ef9
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> This commit is part of the series that introduces the new subcommand
> git-repo-info.
>
> The flag `--show-ref-format` from git-rev-parse is used for retrieving
> the reference format (i.e. `files` or `reftable`). This way, it is
> used for querying repository metadata, fitting in the purpose of
> git-repo-info.
>
> Then, add a new field `references.format` to the repo-info subcommand
> containing that information.
>

Nit: I don't think we need the 'Then, ' here, perhaps 'Add ...'.

> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc |  4 ++
>  builtin/repo.c              | 75 ++++++++++++++++++++++++++++++++++++-
>  t/meson.build               |  1 +
>  t/t1900-repo.sh             | 50 +++++++++++++++++++++++++
>  4 files changed, 128 insertions(+), 2 deletions(-)
>  create mode 100755 t/t1900-repo.sh
>
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index caee7d8aef..cf8483ec49 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -29,6 +29,10 @@ INFO KEYS
>  The set of data that `git repo` can return is grouped into the following
>  categories:
>
> +`references`::
> +Reference-related data:
> +* `format`: the reference storage format
> +
>  SEE ALSO
>  --------
>  linkgit:git-rev-parse[1]
> diff --git a/builtin/repo.c b/builtin/repo.c
> index d4f01e35e2..5beae0f781 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,12 +1,83 @@
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "refs.h"
>
> -static int repo_info(int argc UNUSED, const char **argv UNUSED,
> -		     const char *prefix UNUSED, struct repository *repo UNUSED)
> +typedef const char *get_value_fn(struct repository *repo);
> +
> +struct field {
> +	const char *key;
> +	get_value_fn *add_field_callback;
> +};
> +

Shouldn't 'add_field_callback' be renamed, now that we don't add a field
but rather return a value?

> +static const char *get_references_format(struct repository *repo)
> +{
> +	return ref_storage_format_to_name(repo->ref_storage_format);
> +}
> +
> +/* repo_info_fields keys should be in lexicographical order */
> +static const struct field repo_info_fields[] = {
> +	{ "references.format", get_references_format },
> +};
> +
> +static int repo_info_fields_cmp(const void *va, const void *vb)
> +{
> +	const struct field *a = va;
> +	const struct field *b = vb;
> +
> +	return strcmp(a->key, b->key);
> +}
> +
> +static get_value_fn *get_value_callback(const char *key)
>  {

Nit: A callback generally is a function provided by when a 'fn A' calls
'fn B', providing a 'fn C' which 'fn A' provides.

Here perhaps we can simply rename this to 'get_value_fn_for_key' or
something?

> +	const struct field search_key = { key, NULL };
> +	const struct field *found = bsearch(&search_key, repo_info_fields,
> +					    ARRAY_SIZE(repo_info_fields),
> +					    sizeof(struct field),
> +					    repo_info_fields_cmp);
> +	return found ? found->add_field_callback : NULL;
> +}
> +
> +static int qsort_strcmp(const void *va, const void *vb)
> +{
> +	const char *a = *(const char **)va;
> +	const char *b = *(const char **)vb;
> +
> +	return strcmp(a, b);
> +}
> +
> +static int print_fields(int argc, const char **argv, struct repository *repo)
> +{
> +	const char *last = "";
> +
> +	QSORT(argv, argc, qsort_strcmp);
> +
> +	for (int i = 0; i < argc; i++) {
> +		get_value_fn *callback;
> +		const char *key = argv[i];
> +		const char *value;
> +
> +		if (!strcmp(key, last))
> +			continue;
> +
> +		callback = get_value_callback(key);
> +
> +		if (!callback)
> +			return error("key %s not found", key);
> +
> +		value = callback(repo);
> +		printf("%s=%s\n", key, value);

I like this a lot, since we can simply modify this in the future for
different formats. Nice!

[snip]

--00000000000009a5cb063a810ef9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f3e88452fb558d94_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oL1Z3Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMExkQy8wUzZqYU9zVVdWWlJjcG9KQmtZUXoxMUp6OQpkaVFIVDRTQUxX
elZKYW82MTRQUGQrUUlTSTRiNzQ4b1U3Nk5OZnA0RjlmRHNjc3JFUGVHUlRXcHhXTlpZMUpyCm9i
N0JVM3V3WUoya1VncDI4aER6NE94RDhxNDhKZ3IxVWRoQWZnbWdtM0txV081VUR5czFDSm9DS3kx
SDNvWEEKOTZIM2xEdDZ5cnNic292UnVIQ0VNTzBmUitqd0FTYWZHUUVaa2Y3blZacGhxVVpZcDhO
Mkt0d0R0YjIyVHVKcApyN1lzSS9PQ3dqQVpkaUppN0xiZTF0aVlwNHdaajA4Y3NxVVdPRFBXNVNi
N2JQRnYyWGVweXZkRkxmQy9LTC9MClB1R1dBcld0dlpuTzlsOXZYK2M2K0pvMEZaTjVIUGczSnZX
bmY2UDExdWx6NFM2K3BLUGZIN3FvRm52em12YjQKZWRUWDRBRGl3QmFwenQyWnFLVFUreEkyQ3hQ
VDdIOHJNdmtTSDJFSnlDaVhkamdvdklBakUrWnllY0IydXdBSgpLeWN4OTNvN2xIaWVESzkxLzUw
RGIxT2xNdmFpU3VXbEZ1KzFZZ1NhcFlKbkN5OHBFcjM1eHRPb2E5VUF1eFdkCm1CTnRsSVJSY09s
bUVQWHBJbUtQMjlPSXZZS1hIYmxNRDJ4d1Q2OD0KPWR0OHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000009a5cb063a810ef9--
