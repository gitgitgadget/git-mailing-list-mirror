Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E36413D9A
	for <git@vger.kernel.org>; Mon, 18 May 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107991; cv=none; b=Pbr4WFgKARKDCuNumda+M2cdN/YQzfQuCfmvs95MUm/4t6XCxII6fVs9fliCt6RZbjQ8l61IdF/Y6wRrehoz4My7q5xvlsqLvxJmMxLwVRCJqMNTmSswNGZL9ekCWNU67pxK5xOIbQAojS9dJLNHS1u6SlTkL0Jd8wFYnt94kaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107991; c=relaxed/simple;
	bh=MQgAS4nG3LthyIiGqcg9bnk6uMHSflprm9hwdtmYASo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPYNfRGXjrwpFODPa7qF81GEAwJI2uIjfGvPdodhIhfrhGFqdYq4IRcfUqiBDzdmS4KVhqsr17oStUzWIJj8En7BGFzmry7JVx5rwr06zLM/ihQEkUqKT9lhrXq3egomHJA3SnL59EeP7OlA892NzQUlmnCFf6hHYKR70e/clOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZqZJINWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTEDRmVB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZqZJINWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTEDRmVB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id F18B41D00026;
	Mon, 18 May 2026 08:39:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 18 May 2026 08:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779107986; x=1779194386; bh=U04n2P+oZs
	53MC4Mmsb0TmQ5673gdKP2oEEaQtkt9QM=; b=ZqZJINWzOnHxf0urLvMWmbEjrp
	u4Iu+Vf+ZUez0/wEUqJFxpo4MhWmogIejB17nRmELihcuEJYIFlfOOsviOrJ+7Pp
	se7aXVlzmNm3enN1zB8LtMZqu9zNCWsS5BLigaf372+0DSxfwjwLWEtAVHFlIIgE
	T3Xcp8oh7sjVb/kHMZ7B1rb3lSL1Cy7styee90as7puN8OLuDDkSRK5bsxmsjyUD
	R/Axzg+/ORs8oXOLZSxW1nNVAnf9zEOuQUUnX7yDERcEx9CXuPmqXZPLt5JCjOTh
	l4HQvgdlMN1A6j09ly8AfumeCk/uElzBfWkti1ddJi5A6uauFRtYUcE4oRng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779107986; x=1779194386; bh=U04n2P+oZs53MC4Mmsb0TmQ5673gdKP2oEE
	aQtkt9QM=; b=BTEDRmVBfd66M9/7IknPLMFUY8B8FFEWcfQ6hTz6wqZqXrayM1f
	/apTYWGXzM2caLEMvAuyFAhlSsgn5EDcDK/HJE9dHPhDItsC3FqicW6meFipmSbr
	8vOSET7827EmOL4mma2LSzg8RaeZBAEf5BvtOAFGGjzMWBSZ3CZfR626wq3bkV48
	7D8f0m678wE0SSKU2Wz+cNlHHmFq0uDX3UCQry5PPxbeGLC9LiPA8B/Aa1aEmRwo
	snXZCVwe7vdh9Qnna45R8tN/n9yl6QiAEk3PSIYESTX8hn5ODMOAFXbdLN2f1SJH
	ks0txr7KTulke0tUCsxIZb8GSM+qRDy4DfA==
X-ME-Sender: <xms:kggLaqPzmRk9E_QnjB-QzdBd2O0G0jTwVje5SUuGQ12FtJ3SCY9NPQ>
    <xme:kggLav_u445jIHVUu3Mub_-TkmCDcdXWZT-AmFCjExQz5O3tp8ykkrA-kr6uHQtUK
    sfOF_vM5Y0OPo3ci4wFv27itGhQ0XXMjJezgQx_cqhyMLaFodX3lg>
X-ME-Received: <xmr:kggLamTqw4KxHD4yVAkcX5DWZ3_F38H7C3hBX5yyqI4XccIdbzknQAXZc3nbA2k3y24haVa93SeC6GBZAtOFG0nd8GC6MQCW9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvrhhikhes
    tggvrhhvihhnvggurdhinhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghhrghrvhhitdejjeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kggLapmyUFcsKohexsBXGpGWd4sfWkfao41Kt676pUrbwkofQ2VReQ>
    <xmx:kggLauS2Hq6Pv4ho0b7UMzIUDA9SNAyLynu6IrmX5CUw0vdWrZj2AA>
    <xmx:kggLavMEK1wpzFtouOxDyL3CU2ffPeYtKxqFzqFC_OpNRhFIvbxPOA>
    <xmx:kggLavWAsrbTODYvIip8UJB_SaMrXi8FgC8KJwuVAV9MIRTHwpu9EA>
    <xmx:kggLai1mhyYpaV1A77D0IIvz7iG__57RzZbLHZ0ByAJHXiZEJjZPoH3x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:39:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: erik@cervined.in
Cc: git@vger.kernel.org,  charvi077@gmail.com
Subject: Re: [PATCH 1/1] commit: allow -m/-F with --fixup=amend: or reword:
In-Reply-To: <20260518112225.73172-4-erik@cervined.in> (erik@cervined.in's
	message of "Mon, 18 May 2026 13:22:26 +0200")
References: <20260518112225.73172-2-erik@cervined.in>
	<20260518112225.73172-4-erik@cervined.in>
Date: Mon, 18 May 2026 21:39:44 +0900
Message-ID: <xmqqik8kc2nj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

erik@cervined.in writes:

> From: Erik Cervin-Edin <erik@cervined.in>

The name on this overriding in-body From: line, and the name on
Signed-off-by: line below, must match.  Please pick a name with or
without hyphen and stick to it.

> --fixup=amend: and --fixup=reword: require an editor to supply the
> replacement commit message. The -m and -F flags are rejected: -m is
> caught by a die() in prepare_to_commit(), and -F is caught by
> die_for_incompatible_opt4() which groups -F with --fixup as mutually
> exclusive. This makes these modes unusable in non-interactive
> workflows -- notably AI coding agents.

"Unusable" may be stronger than reality, as you can make creatie use
of GIT_EDITOR to achieve what you want.  "awkward" or "poorly suited"
would be more fitting.

> Plain --fixup (without amend: or reword:) continues to reject -F but
> still accepts -m (even though it's practically a no-op).

Is it "practically a no-op"?  Wouldn't

   $ git commit --fixup <commit> -m "message body"

be useful to leave a message in the resulting commit, which is later
to be squashed into the named <commit>?  Actually squashing with "fixup!"
may lose the message supplied here, but wouldn't people use this
facility to more easily identify what each of the fixups are about?

For the same reason, "-F" would be just as useful as "-m" in this context,
and it feels a bit inconsistent to allow one while rejecting the other.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 28f6174503..269c2d782b 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -837,21 +837,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		hook_arg1 = "message";
>  
>  		/*
> -		 * Only `-m` commit message option is checked here, as
> -		 * it supports `--fixup` to append the commit message.
> -		 *
> -		 * The other commit message options `-c`/`-C`/`-F` are
> -		 * incompatible with all the forms of `--fixup` and
> -		 * have already errored out while parsing the `git commit`
> -		 * options.
> +		 * `-m` (and `-F`, converted to `-m` earlier for
> +		 * amend/reword) appends the message body here.
> +		 * `-c`/`-C` are still incompatible with all forms
> +		 * of `--fixup`.
>  		 */
>  		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
>  			strbuf_addbuf(&sb, &message);
>  
>  		if (!strcmp(fixup_prefix, "amend")) {
>  			if (have_option_m)
> -				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);

Good that you got rid of this overly long die() message line.

> -			prepare_amend_commit(commit, &sb, &ctx);
> +				strbuf_addbuf(&sb, &message);
> +			else
> +				prepare_amend_commit(commit, &sb, &ctx);
>  		}
>  	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
>  		size_t merge_msg_start;
> @@ -1338,10 +1336,12 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	}
>  	if (fixup_message && squash_message)
>  		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> -	die_for_incompatible_opt4(!!use_message, "-C",
> +	die_for_incompatible_opt3(!!use_message, "-C",
>  				  !!edit_message, "-c",
> -				  !!logfile, "-F",
>  				  !!fixup_message, "--fixup");
> +	die_for_incompatible_opt3(!!use_message, "-C",
> +				  !!edit_message, "-c",
> +				  !!logfile, "-F");
>  	die_for_incompatible_opt4(have_option_m, "-m",
>  				  !!edit_message, "-c",
>  				  !!use_message, "-C",
> @@ -1410,6 +1410,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		}
>  	}
>  
> +	if (logfile && fixup_message && !strcmp(fixup_prefix, "fixup"))
> +		die(_("options '%s' and '%s' cannot be used together"), "-F", "--fixup");
> +
>  	if (0 <= edit_flag)
>  		use_editor = edit_flag;
>  
> @@ -1821,6 +1824,22 @@ int cmd_commit(int argc,
>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>  					  builtin_commit_usage,
>  					  prefix, current_head, &s);
> +
> +	if (logfile && fixup_message && !strcmp(fixup_prefix, "amend")) {
> +		if (!strcmp(logfile, "-")) {
> +			if (isatty(0))
> +				fprintf(stderr, _("(reading log message from standard input)\n"));
> +			if (strbuf_read(&message, 0, 0) < 0)
> +				die_errno(_("could not read log from standard input"));
> +		} else {
> +			if (strbuf_read_file(&message, logfile, 0) < 0)
> +				die_errno(_("could not read log file '%s'"), logfile);
> +		}
> +		strbuf_complete_line(&message);
> +		have_option_m = 1;
> +		FREE_AND_NULL(logfile);
> +	}
> +

It is curious that for this new feature alone, but not the other
existing code paths, "-m" and "-F" options reads from file in the
new code here, instead of letting the existing code for "-F" to read
(which happens inside prepare_to_commit(), I presume?).

A potential problem of the above code is if we find something wrong
in message and complain later in the control flow, we have long lost
where the message came from, as the point of the above code is
exactly to pretend that "--fixup:amend/reword -F" message did *not*
come from a file with the "-F" option, but from the command line via
the "-m" option.

> +test_expect_success '--fixup=amend: with -m option' '
>  	commit_for_rebase_autosquash_setup &&
> -	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
> -	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
> -	test_cmp expect actual
> +	cat >expected <<-EOF &&

This comment is not about the added logic, but I notice that among
86 hits with string "expect" in this file in today's "master", only
14 hits are with string "expected", i.e., the prevalent name for the
"golden copy result" that is compared with the actula result (called
"actual") is "expect", not "expected".  Please do not make the
situation worse.

> -	test_cmp expect actual
> +	cat >expected <<-EOF &&

Ditto.
