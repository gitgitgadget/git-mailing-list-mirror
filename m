Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF12CCC5
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582220; cv=none; b=d27GON+Tbzj7b1VE4VDDfrNAaKnjw9jbXhHj6QM/p0y0iXFQIflco8QP+dBIMqO9221Pnak4yf/iqEaSROyQfFBMtEgXYHqUl884SrffDB40dU5IiP/DIt2y/sCLBvoMC9/31SEoTsrAkkT4hIZ63dEKhLNxXDjDEu0o0RvBzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582220; c=relaxed/simple;
	bh=rPx5cfHwG9Odn4nE7lRQm1D9BhLi7GjnDmt+O9UqunE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shQtf6ubM6yhGsdBfPG93TDB7kIDFkmHY599zc4KQeVrXAlihaIJwmAUkx5XBSzPgn6pwZqu2BW/BSduniOvRs71LGuqrwAh7IAUsLx+qZRmQ1mxiv14yf3DHVtqeKlJhhtx7svAhWvUghSCqePMz4YGkLGnesdjUlQzbmXHxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGLxQ2U9; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGLxQ2U9"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-88173565536so6136059241.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752582218; x=1753187018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x5Z7FGhNSl26EGC2RXeJM4Ie/KKJ54bWvygvSLgKpkY=;
        b=XGLxQ2U9JjN6L1+2ah0NVX6woC/+N0a4XNqkapb7qJj5LVbYSuZpmLrpBtsg9JFY/8
         Mvse9VL4hbupAkl+XzmD8ED6lhzmrm16HuIIK3/Ij1xvj8SuWDApmCiPbpqrdxXWzxIj
         tSp19r+cuhlbdxy21cCB4aDGNsVTpLVxgYSpal+mHK8gArYKTuvma2MnJkqaJMOy9oFP
         PpZ7g9NKRRE7JzreiTQcvxBMuviEFqzkh9RKVixy2CgOmcMRy6qD6SqKSxZ2GTH9lRL/
         aH7YLLecujNtedWZXU+wvw6kVFu1mCt3FOdRQvd78Rh0KSRy/xsuTWkNH0j/OPWVlH3g
         aesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752582218; x=1753187018;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5Z7FGhNSl26EGC2RXeJM4Ie/KKJ54bWvygvSLgKpkY=;
        b=Z+r214xa+qM1AYY8bY1vXvBHIrn7bbNmdmzfDBt6F/VhtS6trs/b+0Dqi+sTOPKUdW
         RA+wDGGr9MoF6jYzA8V4zM/8R/Ite21PIGQ/Altt8B3gvjrFb+HDQP70XK9xb//O85HQ
         ubYkLJUSO181LMs453Y/MxipTicAlUTobd8Sl5SqxukMJMzNtjldCtmBzAwRiy6ekfPQ
         QJC12wHbJF2FgZ95PkJJDmsa+zhpjC/DVCbtQ/GddTFi2zPoR1Th6ZO2IaARwDSq5hzD
         1QkTL/2ZyvmIzyL/gkM+B70mVcXiDZRg4KBVAbMwWaPIq/uHDLEkFlHfudO6wB8TBqcq
         dlUg==
X-Forwarded-Encrypted: i=1; AJvYcCXf1mMif5PqQEvGU0eSyzkHF2ulw+sUjkLdztehc0rb2I8LIxrStBGmBCXGKjwtULHgEbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4mWdB+T/BrooOsKRSe/cLYs5xnB7piD0h2il7ik0XZmIWi0F
	/EakfO7aGsJDCHMPP+bIgJQYklxynY8AB4fDFhUuMle7GNCzmeFF0t60S3TocOPmCSMoiVfgIRm
	q6oSjie7TbgDpeDXYpqsmFeR4W3vAbeM=
X-Gm-Gg: ASbGncskAnuz7pfoHOrU40acV2gfXvztU/5q00/bPkmQK60j+65MumZH80er9kujNrO
	TsnY1WmWcudJqev2JXjSJWE08KJ2zGkRdvuL/Z1CYgX466iVnYMWXAznLHJ2ep2ChsWIZ7fdKNK
	T4b2YDklChM/qE0MOa9LfJ3FOBBJ7hio20k7QTT3cQpxnL+AmCaKPEpcJrCQwyWCd6IB6Duh8sy
	dC9g7nAXh1qj8g0Mnl3zxKEVuGoKywvwLmg+wNGTdc5sCPrh6w=
X-Google-Smtp-Source: AGHT+IEFQNBffkOppCY9bAeUfoiZhCCHC8zsC/72vqCUaGl8zCqXMEFFJSL8y9BoaqxPIasEKa3Hu+sn2JuWq4Hwy2c=
X-Received: by 2002:a05:6102:4494:b0:4e5:8d09:7b12 with SMTP id
 ada2fe7eead31-4f7ecbfb0d2mr1636299137.7.1752582217412; Tue, 15 Jul 2025
 05:23:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 08:23:36 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 08:23:36 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250714235231.10137-3-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com> <20250714235231.10137-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jul 2025 08:23:36 -0400
X-Gm-Features: Ac12FXwA4OQqIm9ITwAeLZ9mlRXWrbeSsWBtJsY_9KItA8FCq_Q4KaA_DXjgfs8
Message-ID: <CAOLa=ZTTuxq5Xs4M+okK+3t5Rr_MimseQf8TCTrCL4yvq4EN6w@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000008256620639f6d84d"

--0000000000008256620639f6d84d
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> This commit is part of the series that introduce the new subcommand
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

Nit: s/Then, add/Add

>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc |  4 ++
>  builtin/repo.c              | 92 +++++++++++++++++++++++++++++++++++--
>  t/meson.build               |  1 +
>  t/t1900-repo.sh             | 47 +++++++++++++++++++
>  4 files changed, 140 insertions(+), 4 deletions(-)
>  create mode 100755 t/t1900-repo.sh
>
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 6f8fe3f6ea..b7af6f45a4 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -45,6 +45,10 @@ INFO KEYS
>  The set of data that `git repo` can return is grouped into the following
>  categories:
>
> +`references`::
> +Reference-related data:
> +* `format`: the reference storage format, either `files` or `reftable`.
> +

Nit: I would omit the '`files` or `reftable`' here, because while this
is currently true. This might not hold up in the future. So better to
not go into the details of the supported systems.

>  SEE ALSO
>  --------
>  linkgit:git-rev-parse[1]
> diff --git a/builtin/repo.c b/builtin/repo.c
> index a1787a3cc5..dcda0d6d61 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,11 +1,95 @@
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "strbuf.h"
> +#include "refs.h"
>
> -static int repo_info(int argc UNUSED,
> -		     const char **argv UNUSED,
> +typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
> +
> +struct field {
> +	const char *key;
> +	add_field_fn *add_field_callback;
> +};
> +
> +static void add_string(struct strbuf *buf,
> +		       const char *key, const char *value)
> +{
> +	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
> +}
> +

I like the table design used here, makes things much simpler. I do think
that each field shouldn't worry about the formatting, in fact, I would
say that we can move all of this logic to `print_fields`.

So each field would only be incharge of providing the output data. Then
`print_fields` would take the key, the output data and format it as
needed. This would also make it much easier to use a new format if
needed in the future.

> +static void add_references_format(struct strbuf *buf,
> +				  struct repository *repo)
> +{
> +	add_string(buf, "references.format",
> +		   ref_storage_format_to_name(repo->ref_storage_format));
> +}
> +
> +// repo_info_fields keys should be in lexicographical order
> +static const struct field repo_info_fields[] = {
> +	{"references.format", add_references_format},
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
> +static add_field_fn *get_append_callback(const char *key) {
> +	const struct field search_key = {key, NULL};
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
> +static void print_fields(int argc, const char **argv, struct repository *repo) {
> +	const char *last = "";
> +	struct strbuf buf;
> +	strbuf_init(&buf, 256);
> +
> +	QSORT(argv, argc, qsort_strcmp);
> +
> +	for (int i = 0; i < argc; i++) {
> +		add_field_fn *callback;
> +		const char *key = argv[i];
> +
> +		if (!strcmp(key, last))
> +			continue;
> +
> +		callback = get_append_callback(key);
> +
> +		if (!callback) {
> +			error("key %s not found", key);
> +			strbuf_release(&buf);
> +			exit(1);
> +		}
> +
> +		callback(&buf, repo);
> +		last = key;
> +	}
> +
> +	fwrite(buf.buf, 1, buf.len, stdout);
> +	strbuf_release(&buf);
> +}
> +
> +static int repo_info(int argc,
> +		     const char **argv,
>  		     const char *prefix UNUSED,
> -		     struct repository *repo UNUSED)
> +		     struct repository *repo)
>  {
> +
> +	print_fields(argc - 1 , argv + 1, repo);
>  	return 0;
>  }
>
> @@ -16,7 +100,7 @@ int cmd_repo(int argc,
>  {
>  	parse_opt_subcommand_fn *fn = NULL;
>  	const char *const repo_usage[] = {
> -		"git repo info",
> +		"git repo info [<key>...]",

Shouldn't this be part of the previous commit?

>  		NULL
>  	};
>  	struct option options[] = {
> diff --git a/t/meson.build b/t/meson.build
> index 1af289425d..8693e6abc4 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -245,6 +245,7 @@ integration_tests = [
>    't1700-split-index.sh',
>    't1701-racy-split-index.sh',
>    't1800-hook.sh',
> +  't1900-repo.sh',
>    't2000-conflict-when-checking-files-out.sh',
>    't2002-checkout-cache-u.sh',
>    't2003-checkout-cache-mkdir.sh',
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> new file mode 100755
> index 0000000000..b80fc6b78b
> --- /dev/null
> +++ b/t/t1900-repo.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +test_description='test git repo-info'
> +
> +. ./test-lib.sh
> +
> +# Test if a field is correctly returned in the null-terminated format
> +#
> +# Usage: test_repo_info <label> <init command> <key> <expected value>
> +#
> +# Arguments:
> +#   label: the label of the test
> +#   init command: a command that creates a repository called 'repo', configured
> +#      accordingly to what is being tested
> +#   key: the key of the field that is being tested
> +#   expected value: the value that the field should contain
> +test_repo_info () {
> +	label=$1
> +	init_command=$2
> +	key=$3
> +	expected_value=$4
> +
> +	test_expect_success "$label" '
> +		test_when_finished "rm -rf repo" &&
> +		eval "$init_command" &&
> +		echo "$expected_value" | lf_to_nul >expected &&
> +		git -C repo repo info "$key" >output &&
> +		tail -n 1 output >actual &&
> +		test_cmp expected actual
> +	'
> +}
> +
> +test_repo_info 'ref format files is retrieved correctly' '
> +	git init --ref-format=files repo' 'references.format' 'files'
> +
> +test_repo_info 'ref format reftable is retrieved correctly' '
> +	git init --ref-format=reftable repo' 'references.format' 'reftable'
> +
> +test_expect_success "only one value is returned if the same key is requested twice" '
> +	echo "references.format" > expected &&
> +	git rev-parse --show-ref-format > ref-format &&
> +	lf_to_nul <ref-format >>expected &&
> +	git repo info references.format references.format > actual &&
> +	test_cmp expected actual
> +'
> +
> +test_done
> --
> 2.39.5 (Apple Git-154)

--0000000000008256620639f6d84d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9375056b759160e3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oMlNFY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDNKQy85TG5DMEtvWW5DQWwydWVrSWh0Z2J2UzJLaApYVjNOeFdlWWww
SHMvWE9DSThEb2Qyd2w1Z3k0T25yaXN5MW9EZmFGdXVBREVEOHQzazVJRW9XYVovS2Z2Vmw4CjBr
Z2lKUXJKZ0ZLM1VmcklyRXk4bUQ5MlV5NGtNdFVyN0VSbUdQY21zZmlnamp4L0FWaHJHZXdjT2pK
WkRlYi8KQWwrNEpwNEQrV04xRFVkc1hUVi80NHVwbzRCeHRBNmJrY0t3VXp1Z0ZJQ1R1aFhYYlNY
NVVMU0F2UFpqQnJlVwpWL1J6bEQySFM0MGpSZm45eEtXWWY1YzZRSzZZM3RqbW1ZRjFZVkp5ZDZw
Y1J0WTYvTkJZSFk3akFpUWdsb1ZSCnhJNy96SjAzMVZUdHVuQVo2MHZkQ2xUci9WVTR3WDZWVFow
S3prMEJPWDA0UWVubW9pY3VvaVdiS1dNZDJmVzAKaHI3U2x5cUZKbHZEVmVqemNHbjd5QTFXWnRH
TklScE5lS1FSWTlVcDY0V2t3K1BxZUducm5RdDFLYVJOMURmQwpTVlUwbTQxZ040S0luQm5MaThH
ZnlDcDJrb2MwbCtscVVxYUFtU0JCbkVaWW54eFRoS2lGUE1mbWtyWklxV2RFCk9PSW9RTzBuZkJM
Z21vZy85SWJvRzc1dVd6YnROVTA3YkwwQnNHMD0KPVdlWEoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008256620639f6d84d--
