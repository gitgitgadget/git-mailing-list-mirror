Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17FF3C063C
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621586; cv=none; b=WrzGXppXRXlXNV7ePe7ag3e28/M+5ARLfUcbTEcdfA2svO8VrN4og0WieKqgUlbROrIph6iMfi0pj1offdeoXrX08RRCG5htDgx6rhbjI/OjVHpCMcNMeY6pBMasqFBIAjEVK4mO1TpCwiXXUfCs6yJaTFwDZk4QfCjeIRPV648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621586; c=relaxed/simple;
	bh=KWP+ByY/dtK1B2MGK0lrwAWESq2H5kF/F7v0qFcPePQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WLKmeuC7g7wdbpeevTTFYnrpDyMJpASJE/yhCxl9ZhUUUKhzOa8MXgAcJ2ItfOY9NuVMozrL7YsfvIFXwK4KP6M0KenCQdbfoFcPQ5aM3paxFdzaw0s34HxG5ljdIW0vI+0An6iYlc8rRdVmgG5whbM1rH1be+4j50rUx3zYIaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FXMDTg81; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3FiKXLQ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FXMDTg81";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3FiKXLQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1DA281D00041;
	Tue, 16 Jun 2026 10:53:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 16 Jun 2026 10:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781621583; x=1781707983; bh=xLtV3Zsbw6
	30UHu4iOu+YBhEZdo4JqgmNc2bRtk/PdE=; b=FXMDTg81viaYLw8BAdm5Z0ceE3
	hIcoJX7U3Tc1TEp02Ps5A+m7o66/rGALs5mRDWgAUbepdbVtk9ObfU9L/xJxgHvs
	sAJJfQ4aLrX4Pim0ic8QHjMrGEuLDLcE3e10pFltIAgEicQzU0UHdzZC+z48WMaX
	6RJj7WbImsGzzCmmOrdkJZFEHe/O0zdoEwe+FxFAlMLbc5Yh2JFFq6vudKAoKh6e
	YimlWOgOExCL84rIdQLJqOoppYG5wrctWZtjwMurP2cpg2ruzbtDwDuWVoc/1MOd
	fs5WUAVQsj3G74DHe/EzH4S2nzNVuJn3ybWD3HZxAz8vIGlMVuTcSxFv17Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781621583; x=1781707983; bh=xLtV3Zsbw630UHu4iOu+YBhEZdo4JqgmNc2
	bRtk/PdE=; b=k3FiKXLQKgt1Fu/s0T751vWZA7eoWwdOYGaQLYrGDP1KTKMG8ZU
	tAaFc6ehIjsk55g+79Y6G4NX9gbW02IpifgVljycEUegkMkREjs1iFZQbQ6WnqxJ
	TCxNUBG30B83kBE6x+OTsBJv8vsVSnwyKWmTRNKl7A2Gy4y09hVCdUCCHjt7yvgj
	JCGXQryCyuVvuZMvErzS8SXOpyhYkWEmFS1Jh7kk0Aqty4VyZjSrxQPjK0YE6e2b
	wrU4JaO72JidDjs3ieVLy1KgFDmt2o/8RMIDtvGHsGS48BH/C33Vnm8c06L9g38q
	caS97dYBWLxOwA4wj0X/br8JskXxbstCLiA==
X-ME-Sender: <xms:T2Mxauni1rA5zdOV7Q1QNW__wJmxKc3yXYP_roHKydgH2ytx2Ea9iQ>
    <xme:T2MxatTq-UkWvc9Y8LTiXDbKLBZJLNlcUETWBtLHyqU0-Z6gqwQX4qQ1MDEGgnP71
    ZWSZZPHW_7rfhIKRC1DfnLFjCz8B4V4MLWDciMjPhD61GPvVA4yoj8>
X-ME-Received: <xmr:T2MxaqB8UZAihn15q5iybmE3iMwUuKxbEYYA7ZWeKZ62low-uzW-RrQQEE-r9bixpLz02GuqlDIs7C7PNZvlsAuwC65NU4RddHTr>
X-ME-Proxy-Cause: dmFkZTFQynjETECiL76JVTG60UdYlilX05/y6ECUmlr5EmGy8LmIkHmW0mYcCEiBrZjdT1
    lO6rcfzrGoxziBZ9jlCe1kznHpDZWw1lNIu1n7E8sLJ2tbAdLeTxoICdMkBiktVD5lnI+t
    ME9pb8JgmI0DpHJ8pTpg+1oj+zy28VKtaU2i3UzrNo2eAyfcOca8QY19lEX8wVYUuN8FHt
    pxSCTLKBfrfpMWn4DD1ehXy+Dt5rXwdZ0vYwwWrhfdiDi/J+rJp7iU/M+peWqD9b9tonvd
    id4hmpiWX57JJaBXxEGY8Xd3yqnzvSXsNUYoeQDajDd/s4Es+yNP9Jz5p6GNnWZtCh58rZ
    b/O5RxvGhanRvW+IQjd0Z6k4oLRvsl8PbPB9K7DKMyGDx0SBdkQT/Oo1VrrARH0hxeT0yy
    MGgC3VWmkqH6g0abHi6YQYiEJ6QjbdD1AmJW4Uyi00CxUbofYJPolT1Nx6oNzoAKWclhID
    SXmRW1YvYr0Jff8wLaRsNPMvBvv2q7aoMqDGhId/muQDblUVyyJclF/lYmnKCaI367aQtY
    GkVVVIWLIu3CtAfTb+Nrun9dCuzvI0nahXegtEt7muCZ33sSxZvh5W/38d16tLzaAE2bW8
    4Uj6cQeaVYw7cDnK/Xf82aveiJZHhkXOXfzojmEczdZmkMTsrLt5tPP3NrXQ
X-ME-Proxy: <xmx:T2MxasRT9DTkePwlzYTt6N7DEZzDftuIkqtRocvE3C--Gq13uXVYgA>
    <xmx:T2Mxago-W6r1A6ikvd7j22HjN1h89LAkXroVl9m9a1M3EDKmk3SH3w>
    <xmx:T2MxamznX2pke07mnwvF9GMzoQ6eLwlF_kkqiGFDd-hsOa6adH6EZQ>
    <xmx:T2MxatKaI-JidMzN-5soEc4ZCg849Jiu4jZJx_uM0uej1qodwE9cHw>
    <xmx:T2MxatZSxx-7-YGZYHbLgkZ0aX3vgTiFHwBDLN-3xPY45EjIo93gZZwA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 10:53:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] builtin/refs: add "rename" subcommand
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-4-9f5219b6109d@pks.im>
	(Patrick Steinhardt's message of "Tue, 16 Jun 2026 10:44:09 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260616-pks-refs-writing-subcommands-v1-4-9f5219b6109d@pks.im>
Date: Tue, 16 Jun 2026 07:53:02 -0700
Message-ID: <xmqqo6ha4jw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +static int cmd_refs_rename(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo)
> +{
> +	static char const * const refs_rename_usage[] = {
> +		REFS_RENAME_USAGE,
> +		NULL
> +	};
> +	const char *message = NULL;
> +	struct option opts[] = {
> +		OPT_STRING(0, "message", &message, N_("reason"),
> +			   N_("reason of the update")),
> +		OPT_END(),
> +	};
> +	const char *oldref, *newref;
> +
> +	argc = parse_options(argc, argv, prefix, opts, refs_rename_usage, 0);
> +	if (argc != 2)
> +		usage(_("rename requires old and new reference name"));
> +	if (message && !*message)
> +		die(_("refusing to perform update with empty message"));
> +
> +	oldref = argv[0];
> +	newref = argv[1];
> +
> +	if (check_refname_format(oldref, 0))
> +		die(_("invalid ref format: %s"), oldref);
> +	if (check_refname_format(newref, 0))
> +		die(_("invalid ref format: %s"), newref);

Do we want to quote the value?  What other subcommands do in "git refs"?

> +	if (!refs_ref_exists(get_main_ref_store(repo), oldref))
> +		die(_("reference does not exist: '%s'"), oldref);
> +	if (refs_ref_exists(get_main_ref_store(repo), newref))
> +		die(_("reference already exists: '%s'"), newref);
> +
> +	return refs_rename_ref(get_main_ref_store(repo), oldref, newref, message);
> +}

I suspect that my version shared the same issue, but doesn't
refs_rename_ref() return -1 for failure, which we may want to turn
to positive 1 before returning?

This is a tangent but git.c:handle_builtin() that calls
git.c:run_builtin() may want to do the "negative return? flip the
polarity" conversion to make this worry go away.  I dunno what such
a change would break, though.

If we rename a ref that does not have a reflog, would it leave the
ref under the new name without reflog, or would we get a reflog with
a single entry that marks the fact the old ref was renamed into the
new ref?  Should that be controlled via --create-reflog option?
