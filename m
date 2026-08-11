Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5082331EBB
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475796; cv=none; b=qwJThxC1RQ4n3PydB2nrnizTT1gFRTmk8/xg0bOpLl30BKQWa1TcMGRGC2K8hkQv/hDtbS+4mraTiOUA2PyZcPVFem+x70tLCtZ3g4M2YB8X8BpVEiAPPMJ3UxwSWhpDJVoeonK9EboBqwZbTN8ismTqKR2WBRLa0lqz3EtLpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475796; c=relaxed/simple;
	bh=muOVEVw8DFEYI+6T+miW2RYrqcuc5KRRZUzK/Q2bn4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=boZyuU13StQeEeJnyzVI4nAzsHgi9YVkK8cPLfsg+3TcyvKgyUZqcMH4yWODQAJpj0m2QQ3vS0jMfZyyMa53IvQ0AFNV0iqfJjnOPrXvYl5pgvXoeA+HHYylSmxm5qL3MHzOcK9U4847X1BNcfJNErmIbtTp7Yr7/XQz6f3MA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IT8OqWuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NUQM4G2z; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IT8OqWuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUQM4G2z"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EFC7EEC0088;
	Tue, 11 Aug 2026 15:16:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 15:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786475793; x=1786562193; bh=mFgkI1id1K
	zyI64FPIDKiJ8un/7n15wQXPfakdgvFjI=; b=IT8OqWuB6bnJyf6mrCU2FyqF3G
	cInmQTMtHvyMJVY8I2mfwJmBDau8rIvSK9Z8/Oq0+Loe08lawfSxiyiH3+fMuCMV
	RSyVrQOOjK/DljV1FY+xRmKhQgYbo2GvBdcq4VbP2JnDRtltZ1+ojx6Lgj9fY7tg
	m/Z9UI+ZyaLaMPSUUF3qqpcWCnSayVs2YuK45F7wPTWTz5GZLz4Ywz7erVie6jJ+
	MmNP8NfWIxZMDdq06/UeNs9PR8X42ZInzjBTBsUWtTVdpWjakhpDT8dwmCVrik3Q
	QZj4/12d0WybT5YFMhDjmVgkJcL2hAjs3f7sVvDAL9ns0OZ8GPUQEydngorQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786475793; x=1786562193; bh=mFgkI1id1KzyI64FPIDKiJ8un/7n15wQXPf
	akdgvFjI=; b=NUQM4G2zmVmgljheVvmI4X5j3aXNBbIJofpVfkXUwmMuNLRWjFf
	LnUfO15TdQlFjiJh/4prJFS1e2ln2Ao03baKvjnSFQhdciXC/cWqG3Wk8tpBU9ua
	T/FkFjBpnaNcVuI1UvYrVYlwENKMiWolvGg5E+G65PjCqb1kHDqFbtvdnYg6aPB8
	3P5N2XGBtsvQjC1MNqBbCqYQ4qoMV6BL55QqBQaGb4d/LyxX6ENv2QhXG8MiSPR0
	DEHrJw26m4frEwQV0CGY2kASTj6hXwzS0w7uGo1kqpEePKbeBfoiqPBVd8l6I5J1
	u+8vrl7Ey4rctmu5l1y/2Y8pb+kODtGdvDA==
X-ME-Sender: <xms:EXV7ag0uAcXH2NZcvfIWqSEo2_258EI9pseAajh6gFibeFBYDU4jWA>
    <xme:EXV7atopkN3pyOXBfsgLRyL2PU8f5sIpyYVHBOqwJ_oHbD7V2tmAJFJIOYKteNQEF
    0nTPxIyoir31PK2IEmEaMW6QEsWKmpzJ3gUBBY17igXf38piCslLQ>
X-ME-Received: <xmr:EXV7asiCEQTwePVYw4o98OyqcQJnWSWRp6wstXDHghH2dammrGxsslpnvsYARFH5zeMa8e_kW6YxckH2mTrKSqFSs-szvekE-Q>
X-ME-Proxy-Cause: dmFkZTEa/C6UHI6cc6sxF11OD3HDUTIwtKnS4EcID4ForIlN1xBpP6zcBcStbRcvGlQWF/
    XBC9FvdPLTtUkTGVUjxXpergjA7xTE5G9l0yVfTvQy2TArErF5iTo9rDqLHxUTDZLwWyyA
    KmrmByDihzT0EHYhKM62r1SCGlEV+YyGa5UeN6pOCTbQH0l7fb14QPXQnoVymauQVk02iV
    IfqBEdlMDUUWpNkvtOaIrwl75LvzpuJ3XJgFzA/dv1A5Nqg1BU51cr/y6QojpJK51Fnhcl
    Pinhy1znwk3AaIoI4jMGL7QSJYvRb6OG1V48uJuzJ19lNRAwbxfpPriFNLlZh82qSa4cP2
    xpIwvFmqb10ST+EKLAzcscgixNXDvAty7ED2rlMg84J+VJofP+9t06BNttdsK4FDszl5Lr
    LZvdYz+dSWKeqY3QWNBHF22JxxZz59O78azVScElIFXyhPZ65C5gk4E2fVSMRfHqttfdye
    0Y/AMvRxGPYf4eq3r05vIGFUDlbLWIMDTuWD+E3nbk0DK5BeuU/8v9NGwqAznUC5DNC9xM
    vD0/GjBYrDGBEPuLH84f+hpq3OqF4q3SDgByu0TfnPLPfGAjKr1ZF/OxfaF+Rsc26+cUMD
    Fw3TCiDBRoVOtM4gaUdG0Z11+SH3x/U4cZSQRcI1/rHv7atSTCLBJtKqkBPg
X-ME-Proxy: <xmx:EXV7ap8U4YTsWalB2U5FA1LhN_AjcR5hP9M3oe82088IVWbhZaK7jA>
    <xmx:EXV7aoXRcDLNA5j3GpghsFNCxh7MYslfwv_4cHLebMTd_GoYRAZqmw>
    <xmx:EXV7atBphGTPE22IqJUGWC-vG28wRP0v7p8eeOH-DuHR0-BMN7cqgA>
    <xmx:EXV7atHpOHiZMDH7Gn8uiVC2-GOI6rKwI4ZDP3C-dfwqaZ6KGGMoeQ>
    <xmx:EXV7ato0QC07Fvoj9jyIMFT736kXv2LS69BwTQ79Trpxm9Lxr-5vzfBZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:16:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] git: avoid segfault on "git --shallow-file" without a
 value
In-Reply-To: <20260811121446.2080190-1-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 11 Aug 2026 14:14:46 +0200")
References: <20260811121446.2080190-1-christian.couder@gmail.com>
Date: Tue, 11 Aug 2026 12:16:31 -0700
Message-ID: <xmqqcxvo1n8w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

A great subject line ;-)  It is the simplest reproducer of any bug.

> In "git.c", the other `handle_options()` options that take their value
> as a separate argument, like `--git-dir`, `--namespace` or `-C`, check
> that such an argument actually exists before using it, and error out
> with a message and the usage string otherwise.
>
> The `--shallow-file` option doesn't perform that check. It blindly
> advances past the option and then dereferences the next element of
> `argv`, which is the NULL terminator when no value was given. So
> `git --shallow-file` segfaults:
>
>   $ git --shallow-file
>   Segmentation fault (core dumped)
> ...
> diff --git a/git.c b/git.c
> index e5f1811b6b..96df15b5cd 100644
> --- a/git.c
> +++ b/git.c
> @@ -304,11 +304,15 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			if (envchanged)
>  				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--shallow-file")) {
> -			(*argv)++;
> -			(*argc)--;
> -			setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[0], 1);
> +			if (*argc < 2) {
> +				fprintf(stderr, _("no file given for '%s' option\n" ), "--shallow-file");
> +				usage(git_usage_string);
> +			}
> +			setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[1], 1);
>  			if (envchanged)
>  				*envchanged = 1;
> +			(*argv)++;
> +			(*argc)--;

It is curious that the fix needs to be so big, when the only change
necessary, as far as I can tell from your problem description, is to
insert 4 line "if (... not enough args ...) { ... barf and die ...}"
block and without anything else.  I think the culprit is this "while
at it" ...

> While at it, let's also set the environment variable before advancing
> past the option, instead of advancing first and using `(*argv)[0]`, so
> that this option looks like the other ones.

... that made the patch more confusing to read than otherwise.

But without reading the preimage of the patch, the result is just as
understandable ;-)  Let's take the patch as-is.

> +test_expect_success 'git --shallow-file without a value' '
> +	test_must_fail git --shallow-file >actual 2>actual.err &&
> +	test_line_count = 0 actual &&
> +	test_grep "no file given for " actual.err &&
> +	test_grep "usage" actual.err
> +'

Do we have similar "oops, you were supposed to give me a value" test
for other things like "--config-env=", "-C", etc.?  Just being
curious, because (1) if there are, this addition belongs there, not
here, and (2) if there aren't, this addition may not be needed, and
(3) if there aren't or if the existing coverage is incomplete,
perhaps we should give a more complete coverage while at it.

With (3), I mean something along the lines of ...

	for opt in -C -c --git-dir --work-tree --namespace --config-env
	do
		test_expect_success "git $opt without a value" '
			test_must_fail git $opt >actual 2>error &&
			test_line_count 0 actual &&
			test_grep usage error
		'
	done

I do not mean to say that (3) is my favorite among these three,
though.
