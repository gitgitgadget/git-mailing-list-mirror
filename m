Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7F24A06D
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403615; cv=none; b=qcd2/qB8bBoBkvNHFxYpZUdx69tk0VeKRg3IVQju81lAgvETKNxdImDyOYLDg6raF3Wi+ARfizaxFtY7I8oyhp6pTxLqqfby6hZpJEyPZ9YEA2sh+11XZOxK0qIdbe5WUcoLkfBNfS1/jo5wV2LFBObvL9ZvtcbBNr+M6RDec8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403615; c=relaxed/simple;
	bh=R4q8LmxzjSk6vmbLOwKxQrzH+JAw77NtHlrPiG0gLdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhN4T9SyaUuQtxgBmtNcmDWfl8vcZQJRZ++JlU30ua6j9V2xCEg8mCf/gLoIaRo/ZSRVJ2xkFKM4juDdXLTjhTtTHxBTtMkJwx4pur+g04LuTzAJNDlVA67SUZp27FZ6xZ7axV396ZyRkQgJWW3izo0pQG5k7uGTVdOj2zZMFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nKbBd9Nf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gtnrzGwP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nKbBd9Nf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gtnrzGwP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 080F57A006D;
	Mon, 14 Sep 2026 12:33:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 14 Sep 2026 12:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789403612; x=1789490012; bh=9oWH+TE9LV
	BtvKPnWOok4wH4YHeNpqBeBm8/WlQKn3E=; b=nKbBd9NfvzcRhEk8NUpVUiVuJh
	NdH2npRzQyJm/30m4d1FV9nLR0UeFXtmQrAnFFjKtEPGmYtHL+HSPbMUou9whs0g
	mpCLSosCgKpTU8CXEgPhsaDHWD3RuPFeDjHQCVsYXc8jS+Q7Nwm0tUDrDhAlQ44j
	ROrLCnT+h/TMfmsdr3VTyK/s1DTqZJ18MqSM+C4CQbg3ffl9/fGrlgUvyIXzLW1g
	HRVMGX3kPnV/I7zeZPXEQRLRc/4Bn0ChE9EcPbGsE8GKINXjPcM5XTu1hBVJ9jSJ
	aB1KYokMvSACx2RvAjpETvI9OqP0/978LV54yiWeER4p3pB1LfDObpnrVKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789403612; x=1789490012; bh=9oWH+TE9LVBtvKPnWOok4wH4YHeNpqBeBm8
	/WlQKn3E=; b=gtnrzGwP0HpBTXIC4DWb+KCcqgHSTnJNfrUGGvbD3pttQ0J/etf
	SGGMJumx3w5MI0k53UjJBNPZKz8+dNaDsavt5eqGpo/cAPHiVo7QGYaX8eLUnmYu
	QKiSnGZV75rm6BAuXO7QK+e56AF1ZpdvOg/QNFc0OmnESaYbKJw6BDr+pfQnFeZx
	EYchi5irUELPcYHZYvJ5Z4d1HuoXIF661a8jrM7EiopaZlM1606bmVoBmqcRIU4T
	lfki8AX55+nQSWAadXpE0dVmX68+kV9rt150OLGpgvWEcL+iMavqLj2xcEKRTmIk
	twSL0qtvtzrzSm1yP+8pKU3CyTYHXfgdJaQ==
X-ME-Sender: <xms:3CGoah3b6HdmQoQLo-14ezHllPUVCgm_J7Y9APnSVJB2YD8JTvp2Yw>
    <xme:3CGoavEZ7MqsEPXZf-aHBYeMozqCrw4QXOYN-A0SBUtDzEwyIlIZZmE2O16xbN7C7
    z8URMbRPgsUYBRBCr905g4JmuJ6H_9f90YM1tnK9cmU4GttSKGKMXE>
X-ME-Received: <xmr:3CGoam6f69vhny7J_QF_47CjNK2VBAL3Ae986nxE1PBK39NanYt_ZVPRZrnVHLdon_E3jHdKGRhUNAAQp8Q1L8cQxHSZu8XWeGGs>
X-ME-Proxy-Cause: dmFkZTEERRAYHCi+yOzFjVOo7sd3WDte1pvSETR3acXaMGwJQ/S5W5a4MR5xWZsnrT1eRv
    apKasgpyP+86Oog12ZvnF5UuB8Dn4ITu3GYEnYxYDyt+mYWiKvQcovglCVDihCGtc8sQCu
    hFiEoUJXONP0y46plcj0MVcGbnZgMaiejSS9u+ou3mvsBnPhQtDbnXkHMfkon1HdGTgHsu
    WWgU66S3QsJKn0uJOA/ooa3tAvXAX5FhAQ39HWnXIe9VAn4x+cRrQ9+ZbsYgETVxC2HKFD
    AuEhUvb+sNWLFCz7/nkD1YF9mSg6BdKNWGYYfsVjcdde/WcEXoNZUPhtc0XYxaS4Kdb5sl
    6gwfDjXpd4p5+pgsf5qJ2TRsuKV62CKglpaS1FJ7RJ3E8f8xrMiMTTuMnQidWZ48bG7zEo
    fFgHFSuCTEBUKdKBYGOJE/JU7ERhRTXO5SkRY/oag2WWqmznS2fM3nSnhP+kSPiZVCq7qo
    NkDmS5FKKSepIZphMwzDE29VSDakRjhn5h7Hqwua7k5ixDMEHwTs7Atsi9yYBLj6+47N3S
    dlP/B7Di98FUvM/L+usjQH0j7B6eu4eqcupUOks2TL0WOSsQf0NvnYplPVtvvTQYDp7pX4
    C2nRv/sRnjXCbdocTGk12QNL0yXbFusXHBrdit8i9cS8gcbh79DyrxBrFvhg
X-ME-Proxy: <xmx:3CGoatvDF4v9AZuiCeBn_-k5Vxb74LJ1YYomL1UQFyy8NMxCjRzh5w>
    <xmx:3CGoav5bOrj5lpJT9TTxeLtrXoOrtl809m9TaJso5rDOuGV6GGHTJA>
    <xmx:3CGoagWtPUCDsW0WuyAV9SCryg_hhrKCK0ZKxr_RxwUyvVgJOoe_SA>
    <xmx:3CGoap88PCI8QVhCb0rgcgMRg3JUVmUVmxlmW2uiBl9uAsoRADHkpw>
    <xmx:3CGoaiYbWZW4TRuHNHm0bYF8EutzTiW4Vfukk8Nrw3buGWiVv71xVx_c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 12:33:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] range-diff: add --matched-only to skip one-sided
 commits
In-Reply-To: <pull.2401.v2.git.git.1789160138305.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 11 Sep 2026
	20:55:38 +0000")
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
	<pull.2401.v2.git.git.1789160138305.gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 09:33:31 -0700
Message-ID: <xmqqo6dz6bdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	if (range_diff_opts->left_only && range_diff_opts->right_only)
> -		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
> +	die_for_incompatible_opt3(range_diff_opts->left_only, "--left-only",
> +				  range_diff_opts->right_only, "--right-only",
> +				  range_diff_opts->matched_only, "--matched-only");

Sorry for suggesting this change during the review.  After thinking
about it a bit more, I think it is a bad change.

Top-level range-diff.c should be kept reusable from different
front-ends, some of which may invent different ways to deal with
errors coming from incorrect end-user settings.  It would rob them
of an opportunity to recover if we called die() from here like this.
Calling error() and signaling an error to the caller, as the original
code did, was the right thing to do.

In other words, this adds an unnecessary layering violation, and the
original code was much better from that point of view.

We might eventually want to have error_for_incompatible_optN() so
that this hunk becomes something like:

-	if (range_diff_opts->left_only && range_diff_opts->right_only)
-		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
+	res |= incompatible_opt_error("--left-only", range_diff_opts->left_only,
+				      "--right-only", range_diff_opts->right_only,
+				      "--matched-only", range_diff_opts->matched_only,
+				      NULL);

but I think we should leave that outside this topic.

In general, whenever I need to say "something like" (as opposed to
"exactly this") in a suggestion, it is a sign that the overall idea
might be OK, but the details need to be worked out and would take a
lot of time.  I think this is one of those cases that are better
handled as a separate topic without holding this change hostage.

Thanks.
