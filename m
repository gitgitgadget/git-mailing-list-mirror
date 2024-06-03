Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DF74297
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450252; cv=none; b=DPzroF/hkcIb9il8kyYRUQ7F7rBVcSyFsblzg8ZbJ+ajN11UbkGd85hl3KNHdMSQtYA70YpQhpc+1QrkDZnJqy1OVV1DGlQ44Na6hE+Jln5isYwNK38mgQ9qzz/cz/aGh02em94aQk+8UuFlU5JNa/L7L7f78xuLhDVDU0ZU7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450252; c=relaxed/simple;
	bh=DlzK4Z3oc26+OplownM4UvS75GU3Huax2cAgiYIFBds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lf1vZxeHgI1aUuosk7WPrPib16EiBs+DISTNI3bRpC8vC5j3oQGQhFen3SCh30WwAQEcamLeu+G2Uh2/N55YGx2+04InZCVfPbX/KDG7BFxDcH09v3HAcxMcQlHetxPoNXO3wdb8ZHdN1KK0TJ2oNRmUPcV9Ir3iRAao1ixWgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIFtYjHd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIFtYjHd"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-421140314d5so43724955e9.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717450249; x=1718055049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvdM3wpE6VABf8mPa5CofOb8O4dx8kwXYKS5FNdC02E=;
        b=OIFtYjHdp83a2JlnP7HA+Np9T9TXTIniiJS3h/+AuZklAiyrNz7recDO3kYzfoELpv
         7YaN7yruQqLEU3jrou3yyNHo4r6LAJikdqcjrylsl2EHgQoz/loYpwgceYoKUHtryp9c
         BnZUpufV0MJVzTZH+zAyKS1kJkhlY3ihhzEjHgma5tNPT7rb953oc720xhFIDZM1zfp3
         1oiVvwJouvA3setZu+oVeMzGxWzVH6sjJ3DpwBv8Cm72UbYI4Uyo/oDhZXLZyPiqxRGX
         cq2szcKOobUjxo2zjuERZ8Ncngq4ZkinequoHbIg8ZDR4cQjN0aHKdIfS27/45U3TJqL
         nIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450249; x=1718055049;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvdM3wpE6VABf8mPa5CofOb8O4dx8kwXYKS5FNdC02E=;
        b=YNqBmfMq3P+DNlvSqS2UvJLM3Vg7rx4YVDcizew9B3vZV933mqZfMEv7WDzyPxvngS
         X9Rchf8ZSyH3tYeJ814esInJpmaAMteaVgxcZ8Eo+obc1mMU0YDwkLvAfR7UVj7oLjX3
         G5S5jYBoCHuOvAbDV4JsfQ2mvI6CPoFb3UgKcA1AqqBFo2A4IMTL8XUQUkHHrQbEvgz4
         tHpt4AfdtpTs0M1jHbBTm9M2n5VLYCnBPpaIhTnfRorNrV1FpC6ravPaSVcR6w0HOHCG
         rm+Vm1qGvjRr0QTwzZU7LdunR8as6WpTIfpStRtqABHWmBwKXE4wn8ljoPJp01PUeLIM
         M0kg==
X-Forwarded-Encrypted: i=1; AJvYcCVM+Qu39ClqWt9GuYATtP28yrn1AdoWGgqiZQlEbTDcjzIzpDiDN8d7EkBH3y1JijNYwMsdc8/MHskNIbhV4x524ZyM
X-Gm-Message-State: AOJu0Yx4PTS6Y2lKG+1QlCnMHNE11nnFIohcL2PVUdjWhGJXyhqqz8YJ
	iVc+sVbdJpjSKbGe/wWSB1jOisshME3n9LGCOp0MYvsAhAPYQMhc
X-Google-Smtp-Source: AGHT+IHrt0U7m0PH2cp/i/+hRtEtRc4RZaSO8Aavh11wBD1zhDn2nUTuMaZ6UFRkH0tAEewH9K3p4g==
X-Received: by 2002:a7b:c011:0:b0:421:1d5:c0a3 with SMTP id 5b1f17b1804b1-4212e0a52cemr91972095e9.28.1717450249168;
        Mon, 03 Jun 2024 14:30:49 -0700 (PDT)
Received: from gmail.com (32.red-88-14-52.dynamicip.rima-tde.net. [88.14.52.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212f0f9660sm122097615e9.39.2024.06.03.14.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:30:48 -0700 (PDT)
Message-ID: <aa9ff9a4-d504-45c7-8b4e-9744bf0b93aa@gmail.com>
Date: Mon, 3 Jun 2024 23:30:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ls-remote: introduce --branches and deprecate --heads
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8qzl3mhg.fsf@gitster.g>
 <20240603200539.1473345-1-gitster@pobox.com>
 <20240603200539.1473345-3-gitster@pobox.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240603200539.1473345-3-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jun 03, 2024 at 01:05:38PM -0700, Junio C Hamano wrote:
> We call the tips of branches "heads", but this command calls the
> option to show only branches "--heads", which confuses the branches
> themselves and the tips of branches.
> 
> Straighten the terminology by introducing "--branches" option that
> limits the output to branches, and deprecate "--heads" option used
> that way.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-ls-remote.txt | 12 +++++++-----
>  builtin/ls-remote.c             | 21 ++++++++++++++++++++-
>  t/t5512-ls-remote.sh            | 30 +++++++++++++++++++++++++-----
>  3 files changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 1c4f696ab5..76c86c3ce4 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -9,7 +9,7 @@ git-ls-remote - List references in a remote repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
> +'git ls-remote' [--branches] [--tags] [--refs] [--upload-pack=<exec>]
>  	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
>  	      [--symref] [<repository> [<patterns>...]]
>  
> @@ -21,14 +21,16 @@ commit IDs.
>  
>  OPTIONS
>  -------
> --h::
> ---heads::
> +-b::

Perhaps we can avoid this 'single-letter' option, due to we're no giving
the same abbreviation for '--branches' in other places.

> +--branches::
>  -t::
>  --tags::
> -	Limit to only refs/heads and refs/tags, respectively.
> +	Limit to only local branches and local tags, respectively.
>  	These options are _not_ mutually exclusive; when given
>  	both, references stored in refs/heads and refs/tags are
> -	displayed.  Note that `git ls-remote -h` used without
> +	displayed.  Note that `--heads` and `-h` are deprecated
> +	synonyms for `--branches` and `-b` and may be removed in
> +	the future.  Also note that `git ls-remote -h` used without
>  	anything else on the command line gives help, consistent
>  	with other git subcommands.
>  
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 9838de69c0..95fbb8b7b5 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -38,6 +38,20 @@ static int tail_match(const char **pattern, const char *path)
>  	return 0;
>  }
>  
> +static int heads_callback(const struct option *opt, const char *arg, int unset)
> +{
> +	unsigned *flags = opt->value;
> +
> +	if (unset) {
> +		warning(_("'--no-heads' is deprecated; use '--no-branches' instead"));

I wonder if this would be better: 

	warning(_("'%s' is deprecated; use '%s' instead"), '--no-heads', '--no-branches');

> +		*flags &= ~REF_BRANCHES;
> +	} else {
> +		warning(_("'--heads' is deprecated; use '--branches' instead"));
> +		*flags |= REF_BRANCHES;
> +	}
> +	return 0;
> +}
> +
>  int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  {
>  	const char *dest = NULL;
> @@ -68,7 +82,12 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			   N_("path of git-upload-pack on the remote host"),
>  			   PARSE_OPT_HIDDEN },
>  		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
> -		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_BRANCHES),
> +		OPT_BIT('b', "branches", &flags, N_("limit to branches"), REF_BRANCHES),
> +		OPT_CALLBACK_F('h', "heads", &flags,
> +			       NULL,
> +			       N_("deprecated synonym for --branches"),
> +			       PARSE_OPT_NOARG|PARSE_OPT_HIDDEN,
> +			       &heads_callback),
>  		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
>  		OPT_BOOL(0, "get-url", &get_url,
>  			 N_("take url.<base>.insteadOf into account")),
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 5dbe107ce8..b9950ca361 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -47,6 +47,7 @@ test_expect_success setup '
>  	git show-ref -d	>refs &&
>  	sed -e "s/ /	/" refs >>expected.all &&
>  
> +	grep refs/heads/ expected.all >expected.branches &&
>  	git remote add self "$(pwd)/.git" &&
>  	git remote add self2 "."
>  '
> @@ -71,6 +72,25 @@ test_expect_success 'ls-remote self' '
>  	test_cmp expected.all actual
>  '
>  
> +test_expect_success 'ls-remote --branches self' '
> +	git ls-remote --branches self >actual &&
> +	test_cmp expected.branches actual &&
> +	git ls-remote -b self >actual &&
> +	test_cmp expected.branches actual
> +'
> +
> +test_expect_success 'ls-remote -h is deprecated' '
> +	git ls-remote -h self >actual 2>warning &&
> +	test_cmp expected.branches actual &&
> +	test_grep deprecated warning
> +'
> +
> +test_expect_success 'ls-remote --heads is deprecated' '
> +	git ls-remote --heads self >actual 2>warning &&
> +	test_cmp expected.branches actual &&
> +	test_grep deprecated warning
> +'
> +
>  test_expect_success 'ls-remote --sort="version:refname" --tags self' '
>  	generate_references \
>  		refs/tags/mark \
> @@ -275,7 +295,7 @@ test_expect_success 'ls-remote with filtered symref (refname)' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'ls-remote with filtered symref (--heads)' '
> +test_expect_success 'ls-remote with filtered symref (--branches)' '
>  	git symbolic-ref refs/heads/foo refs/tags/mark &&
>  	cat >expect.v2 <<-EOF &&
>  	ref: refs/tags/mark	refs/heads/foo
> @@ -283,9 +303,9 @@ test_expect_success 'ls-remote with filtered symref (--heads)' '
>  	$rev	refs/heads/main
>  	EOF
>  	grep -v "^ref: refs/tags/" <expect.v2 >expect.v0 &&
> -	git -c protocol.version=0 ls-remote --symref --heads . >actual.v0 &&
> +	git -c protocol.version=0 ls-remote --symref --branches . >actual.v0 &&
>  	test_cmp expect.v0 actual.v0 &&
> -	git -c protocol.version=2 ls-remote --symref --heads . >actual.v2 &&
> +	git -c protocol.version=2 ls-remote --symref --branches . >actual.v2 &&
>  	test_cmp expect.v2 actual.v2
>  '
>  
> @@ -335,9 +355,9 @@ test_expect_success 'ls-remote patterns work with all protocol versions' '
>  test_expect_success 'ls-remote prefixes work with all protocol versions' '
>  	git for-each-ref --format="%(objectname)	%(refname)" \
>  		refs/heads/ refs/tags/ >expect &&
> -	git -c protocol.version=0 ls-remote --heads --tags . >actual.v0 &&
> +	git -c protocol.version=0 ls-remote --branches --tags . >actual.v0 &&
>  	test_cmp expect actual.v0 &&
> -	git -c protocol.version=2 ls-remote --heads --tags . >actual.v2 &&
> +	git -c protocol.version=2 ls-remote --branches --tags . >actual.v2 &&
>  	test_cmp expect actual.v2
>  '
>  
> -- 
> 2.45.2-404-g9eaef5822c
> 
