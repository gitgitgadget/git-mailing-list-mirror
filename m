Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03423FFAAA
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460427; cv=none; b=hDSkTjlJqnHAr1oLFG9QUerrKGyrMCp8Q6ny8IGyL087HdKDpO797DxfLuuYCwN7gx1N3xlHqu5KzYjpOSdsu3Hp8GErI192TnOfMpySWbJ70x/dp2cVamD3WwRf7yiWZPBIXbAvTZh3AbQKun8T5S6ZLIYRkQ21zrZj3yXunME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460427; c=relaxed/simple;
	bh=sBrdXWG/AvicX1d9sD9W2mAXNNR0/1bHqELqWw7RxPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmcZXgr3L7tCYKPQSwCTAcmDRSrM2nGc6jBcXbY71a+nkvbT/oQfYkoCSUti+Q3ZYGchoHhfJE/DHa81ipkHs5diFrYM3Onb45we7jhb/AQxmVvMscO/KSKjnwLcCXzXW+f05Ax2JsPp+O/F7XDEW4QcvKFG3c7AjunqUUiHZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rv2lM5di; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bKtbxkq+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rv2lM5di";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKtbxkq+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 20340EC0189;
	Wed, 25 Mar 2026 13:40:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 13:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774460425; x=1774546825; bh=7gW6nM9wSw
	7tN7vCIwnuxfsWFO3U5m4rYjVtwBRkmM4=; b=Rv2lM5didZUxNU4lMY0lG6j9nv
	N8NiXihhWk2iw5+NAb6Qu3s5LQTh5BcqpiUfFovFH1NFz8Q3horvK3ffh7hCggmr
	DiM/R7OPcmhTl1LyTkSr9fZz04SraqTb7T9QHviMLGeHLkBbW/GNouxSoeCJmTF2
	0VMibt0jdPQsfmsbId7dA8D8vSWlddcsszbE3x8U+yjeeyIGPFQbIVybTsLUrlb0
	bUCP0BeiXiNx4i2jxr8S4yKY4LkDn5fvOru3wxuc8/wibOvqsoD4VcnxB+a0kjlK
	MRxTcH7eueon9DrgyCEwteQnJf1RhYFzGFsm+ogLTX/Nko0YOQJgOwgvUOCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774460425; x=1774546825; bh=7gW6nM9wSw7tN7vCIwnuxfsWFO3U5m4rYjV
	twBRkmM4=; b=bKtbxkq+u48aIfmlJB50KrHrRj/2G/DOeVnQg6p0fE+k78DL8Ru
	5YIF1QFt4QTXBWkEyyWMN8z1DvRs7xEzNqNd9YVYvyFy7sBD3PruogJv7X9ZKHiP
	zSQtA81hzyxRiB/JoVNuFChF2EKDebnE6rBUtf9aMLv0CMfhqiqhhH54TuXY5pzK
	euknEDQxl7PWeydAjv1Ag79Ck4Bd8TS+ZPp30gEk+8Dy+zACfPUyi+YqS/xeLuUF
	4indWKaNoaX4taUH9BwYdCB3h2KlKi+xtJvQRZJTVGAy0J/CYhLHCKKd1AOaYi+1
	eY0u6ltgPN+fmD14nwxDJmI6LCztp/ePQHw==
X-ME-Sender: <xms:CB7EaajEHIheXu2h-csLvyHEwYvT8ZwOCZNbLoTwOo7k_hL4DTvKag>
    <xme:CB7EaevsP7_TPb6h8J7yekYL6ovhZSlPezx6oiZ3hgUXYC8Df5yrJfOMWYrMY7_UL
    N_zTjkId9KMJuc8PqcSBwd3Da5OTv3MLnTKHI-YgPpul-b4FmFROw>
X-ME-Received: <xmr:CB7Eab5celgtwt-SFf6uA-ZO_efQbmwgxGaQzmx8RwEzVD8t4uxSIkgcExA88l1NmltrFVqs_veh5lYayEamlZiaeFyFBHVnmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrhhhlvghtrdhtrghkrghsshgrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CB7EaaOggcJ4-QRKM3MAoxbX8wSr0hrhYrVKvdQlkVYyHz0faTP00w>
    <xmx:CB7EaZumPR6fofOF_d9-Or1skOkvaWvtfvskn7s_EWhMM2y9ae9rTg>
    <xmx:CB7EadZQA9RqyN-HBvUxJs6cSrPIBvE2cRibOYlXPiI_qsXrEkRscQ>
    <xmx:CB7EabwlWmcT0fVl22dBTaoVvxGCpo9BQl8uiHbUPxqsVJ3LkFM9mQ>
    <xmx:CR7EaRuSU3FwCr1wAFtURpvH4AWvZHDF0qERrHOtzB7CZeMntkAtD357>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 13:40:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mahi Kassa <mahlet.takassa@gmail.com>
Cc: git@vger.kernel.org,  lucasseikioshiro@gmail.com,  jltobler@gmail.com,
  stolee@gmail.com
Subject: Re: [PATCH v4 2/2] repo: show subcommand-specific help text
In-Reply-To: <20260325115148.101867-2-mahlet.takassa@gmail.com> (Mahi Kassa's
	message of "Wed, 25 Mar 2026 12:51:48 +0100")
References: <20260325115148.101867-1-mahlet.takassa@gmail.com>
	<20260325115148.101867-2-mahlet.takassa@gmail.com>
Date: Wed, 25 Mar 2026 10:40:22 -0700
Message-ID: <xmqqldffvmd5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mahi Kassa <mahlet.takassa@gmail.com> writes:

> Use subcommand-specific usage arrays for "git repo info" and
> "git repo structure" so that each command shows only its own
> synopsis in help output.
>
> Add tests to cover the subcommand help behavior.
>
> Signed-off-by: Mahi Kassa <mahlet.takassa@gmail.com>
>
> ---
> v4:
> - split the subcommand-specific help change into a second patch
> - keep the behavior change and tests together
>  builtin/repo.c            | 14 ++++++++++++--
>  t/t1900-repo-info.sh      |  6 ++++++
>  t/t1901-repo-structure.sh |  6 ++++++
>  3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repo.c b/builtin/repo.c
> index b5146499d0..71a5c1c29c 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -33,6 +33,16 @@ static const char *const repo_usage[] = {
>  	NULL,
>  };
>  
> +static const char *const repo_info_usage[] = {
> +	REPO_INFO_USAGE,
> +	NULL,
> +};
> +
> +static const char *const repo_structure_usage[] = {
> +	REPO_STRUCTURE_USAGE,
> +	NULL,
> +};
> +
>  typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
>  
>  enum output_format {
> @@ -220,7 +230,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
>  		OPT_END()
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
>  
>  	if (show_keys && (all_keys || argc))
>  		die(_("--keys cannot be used with a <key> or --all"));
> @@ -885,7 +895,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
>  		OPT_END()
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
>  	if (argc)
>  		usage(_("too many arguments"));

OK.  It makes sense.  Is repo_usage() still used?

    ... goes and looks ...

Yes, "git repo -h" uses it to tell us that info/structure are the
available subcommands.

> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index a9eb07abe8..39bb77dda0 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -149,4 +149,10 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git repo info -h shows only repo info usage' '
> +	test_must_fail git repo info -h >actual &&

There was a topic about the exit code and the output destination of
"-h", which is the mode of any command that gives exactly what the
end-user asked, which should go to the standard error, and does so
successfully, which hints that we may want to exit with 0.  So this
may later have to change to expect success, but let's leave it as is
for now.  Existing tests on "-h" will also have to be updatd if/when
such a change happens.

> +	test_grep "git repo info" actual &&
> +	test_grep ! "git repo structure" actual
> +'
>  test_done
> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 98921ce1cb..10050abd70 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -224,4 +224,10 @@ test_expect_success 'progress meter option' '
>  	)
>  '
>  
> +test_expect_success 'git repo structure -h shows only repo structure usage' '
> +	test_must_fail git repo structure -h >actual &&
> +	test_grep "git repo structure" actual &&
> +	test_grep ! "git repo info" actual
> +'
> +
>  test_done

Looking good.

Will queue.  Thanks.
