Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9D22759C
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807276; cv=none; b=dLWWF4IcfDIvVJsEs5Z6+mVTxgqvyofzvsUHNFjah+haM3NLNp2nQ3LcAT84VcSvPExtxC+Z2k5VKTFHtBdXDuRs/c0d4GvQuxRpQQln4UoJ33yfbZXsuF29Z1binnDwirAWBEA/OlIeswWTNzY2pD2WStB0BeVQjteFaGKx9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807276; c=relaxed/simple;
	bh=irVB/eknzATGagJ5BC7Onaqxn81+yEGReePh3Kuhw6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C3HANoU0Pbu3CoAD6lCHBbcZ4b6Ia3Us4YW/gV9cpI02AUZ7kqNHFqX5g/KlTuHdNb+lSOEkcVyH77+2Yb0WfHVg7f+p7Dy9x8AeShY1M0N1FVtnC2ChvoMvilPeHJtoN0298OQ1n5WixTJ/xZuyEBM0WzFUEQIkIc53j655MeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lHJlr4Q9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lwuCGfFS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lHJlr4Q9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwuCGfFS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 018FC7A00A4;
	Tue, 29 Jul 2025 12:41:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 29 Jul 2025 12:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753807272; x=1753893672; bh=s3UTdc1rhA
	baSxYXJLfSWZMKsuo0H0YpAcgYIHfDs+4=; b=lHJlr4Q99r7mPrZHO8D8OiXTLA
	mHPiNqNNBuO651ffKpAL0AB/43r9Wia4bH+BbdWzxFpwGV2xDpHCnQQvax7sLV4F
	AQ745i0HDM7EmUBygnfCQGMO1k0FSzmMLlx+4ej8w0VPqJwkwTQ42NisEmGz+YDn
	UHJTG5q/hIAojZV3J4Av7h4ZfJszIs6pB9pWypCPJpcwz+K3+RhpCFtbs5yBmqPP
	vAvTCudTlTPa36GtuDCibinSCXjYvHUYwTpZuQQ6Q5ydFB32dAgvtIk9/DpuJte3
	YidNUHPyC0CDBi3lPxU2QZuaJ6dFjkyA8LcVIQO9bJ5Asp/kUccCLzxo3yOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753807272; x=1753893672; bh=s3UTdc1rhAbaSxYXJLfSWZMKsuo0H0YpAcg
	YIHfDs+4=; b=lwuCGfFSBg0oy5qi1ND9J/gDwdXy4mrDR249R3v1fmIZlRcpE9a
	D7FVPZXHE6khDy6LwuZAlff96t2FVZnJPukiKXKMYciQFhjzisj77KW6XBYPdWei
	mnVuAAFrcAkLWDZvrP2n0HAnQ+o4x5q7cOKfQdxkZ72CaU5SEurn9K8OvDUZr/ek
	4VYegDxF2GtlNWumucapxCv/eIXWPZMBlJc5HnJnh7zh/LtlUOgfJlnMKe/yy8X2
	ijjd5UuYkDBTRjgniS2+avTmpX73jKUAEAWZSBe309KPsaZk/6O8aNS9ghMAHVsl
	+6Nh3Asv2+c42BcjdYMwfMTSta3TmHq6bZw==
X-ME-Sender: <xms:qPmIaPfvfSPgtQsgY8QZ8uFaOQfSExoa9ej4qnRaBUuuyIGCT6-rmQ>
    <xme:qPmIaAup_U6TJo8Gdr1QVhJ5n0-Lwes-HKlck2uukpZcyyGu26UVyFxUn-ccVh3t9
    AzqByM-0j-YiIbIPQ>
X-ME-Received: <xmr:qPmIaO8Fpm3pHHcV3Phyt6eXw51_kgOcbkrlwYJAwXI5ptuPOgVV94lAOZEFm_b9K670w9aWg7Gkt94KS_znMi_LaKnyKeEVn0hGzh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qPmIaL39bshTACA2n_m1pyx-WaXBtvvcLWdk92nR56l5TuaSdY7TAA>
    <xmx:qPmIaDAxcuMql_NztPIRg1da2whW1K6J5YAIH-GwII624Jwy2NolqQ>
    <xmx:qPmIaHdZSb4wTTnfz3tTIKLZ1pjQt-vwkMEmJ-7lYUWml8nDtI7twg>
    <xmx:qPmIaA5DwY6HLqrthvuF67E1iLS-kNwZZ7GrRzJTFLjAo5MwGhSQFw>
    <xmx:qPmIaHPtXwsKt-E86SvLYYL573ou-Za7y2ab4zTspxyQ4j9OWxRD2wvG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 12:41:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH 2/2] builtin/fmt-merge-msg: stop depending on
 'the_repository'
In-Reply-To: <04d6f682a6b2257e14682e809a2fd01ccfcf0d08.1753804956.git.ayu.chandekar@gmail.com>
	(Ayush Chandekar's message of "Tue, 29 Jul 2025 21:49:35 +0530")
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
	<04d6f682a6b2257e14682e809a2fd01ccfcf0d08.1753804956.git.ayu.chandekar@gmail.com>
Date: Tue, 29 Jul 2025 09:41:10 -0700
Message-ID: <xmqqjz3rospl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> Refactor builtin/fmt-merge-msg.c to remove the dependancy on the global
> 'the_repository'. Replace all the occurrences of 'the_repository' with
> 'repo', where 'repo' is a pointer to 'struct repository' passed to the
> function 'cmd_fmt_merge_msg()' and thus remove the definition '#define
> USE_THE_REPOSITORY_VARIABLE'. Also, add a test to make sure that "git
> fmt-merge-msg -h" can be called outside a repository.

This also moves the call to git_config()/repo_config() after
parse_options().

It generally is a bad idea to read command line options first and
then read the configuration (it is a bug if such a flow causes
values from configuration to overwrite values from command line).
THe current set of options and configuration variables may not
overlap, in which case such a questionable arrangement happen to be
without bug right now, but it would prevent future developers from
adding new options and configuration variables and make them
interact with each other in the most natural way.

In any case, the reason for this change of the order between config
and parse-options is not explained at all in the proposed log
message.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
>  builtin/fmt-merge-msg.c | 7 +++----
>  t/t1517-outside-repo.sh | 7 +++++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index fed8163825..848498b8e6 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "config.h"
>  #include "fmt-merge-msg.h"
> @@ -13,7 +12,7 @@ static const char * const fmt_merge_msg_usage[] = {
>  int cmd_fmt_merge_msg(int argc,
>  		      const char **argv,
>  		      const char *prefix,
> -		      struct repository *repo UNUSED)
> +		      struct repository *repo)
>  {
>  	char *inpath = NULL;
>  	const char *message = NULL;
> @@ -53,13 +52,13 @@ int cmd_fmt_merge_msg(int argc,
>  	int ret;
>  	struct fmt_merge_msg_opts opts;
>  
> -	git_config(fmt_merge_msg_config, NULL);
>  	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
>  			     0);
>  	if (argc > 0)
>  		usage_with_options(fmt_merge_msg_usage, options);
> +	repo_config(repo, fmt_merge_msg_config, NULL);
>  
> -	adjust_shortlog_len(the_repository, &shortlog_len);
> +	adjust_shortlog_len(repo, &shortlog_len);
>  
>  	if (inpath && strcmp(inpath, "-")) {
>  		in = fopen(inpath, "r");
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 8f59b867f2..4b4e645860 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -121,4 +121,11 @@ test_expect_success 'prune does not crash with -h' '
>  	test_grep "[Uu]sage: git prune " usage
>  '
>  
> +test_expect_success 'fmt-merge-msg does not crash with -h' '
> +	test_expect_code 129 git fmt-merge-msg -h >usage &&
> +	test_grep "[Uu]sage: git fmt-merge-msg " usage &&
> +	test_expect_code 129 nongit git fmt-merge-msg -h >usage &&
> +	test_grep "[Uu]sage: git fmt-merge-msg " usage
> +'
> +
>  test_done
