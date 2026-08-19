Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A513C4546
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787162996; cv=none; b=AI7+uIjQ3lyWiSyR594z15Th/BwuowdO638eGpTijle+PdObZVXwdJGt5+DT4tAjTyQVtnEeE0HtmqIOj0OrnV++c66rNzGPl6miRH6LV5p29dQAwkOJUXVNDCZ24wPdFPjODy3yWIv+JSyAErXtLFndMpC1Hw9SJEdRyf2Frd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787162996; c=relaxed/simple;
	bh=nWuTF245YS6QDc0zl61WPbi6phkvMK/ObnZIZCXN/cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qczFVE+6HqlMByegKlspyKBGNYU/PdIRnPWbfyTtcv+K0NRQy4yuFjPFMSAANUonVL6GxVgWPvE2NOvZHe64CZFUXTqRtwD5bS+3etp0bnbEQhv0aIhr5vMhHdqzaphCZUj1XqsiuYfrm9j9ToixZA+eHQmNwhA8HxPLwYHl3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OdS70jTI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1uvws9C; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OdS70jTI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1uvws9C"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B87017A013E;
	Wed, 19 Aug 2026 14:09:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 19 Aug 2026 14:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787162993; x=1787249393; bh=CYeUNoSQ8S
	EqrIgmli6YMaTJa2z2z7Sk3XTo5/cznWE=; b=OdS70jTIyYzdWJ7guR2Q1fEB2j
	NhupBjkAIv4mLuro3Qlx9tgDnHF5FplEN898ERG8DCkLDNybzDpfHZ5ozXH4FDPZ
	eSl0WFgrQ04G/jCc8TqSGUAkdL4uuHBgF5yxv0kTnt9dPUjx+9oGWiyd4i3rcFOY
	6GGLzNAeG+qsruQooVXmzatMl/1hgjU4aaOXYsy/8YOt5mY8djOnizTC2UoTPcrI
	pj+QaFT70OwTx2BnH5SyLFa5KaeJ6dFlIf3IalLmTxkSzdu858uOm5s6ZIfuFZOu
	qs2CTCm8Mk4uNlPv/Jjx/T/AXggo+Q1TBW9Wfluh6dxYy7rye051yMImAoeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787162993; x=1787249393; bh=CYeUNoSQ8SEqrIgmli6YMaTJa2z2z7Sk3XT
	o5/cznWE=; b=a1uvws9CYdQvmhFlfnYA6CmFRpD5D7Kda20lHWUIH1mMccXnohl
	mS0ivCIlzAn0K5z8A2SppDSxLWyyLHBd4Xn4oZ+ncD/2ETinO2M2ii8vvIFReEE8
	8dFitsCZ5UxFZmD0JnypS14T/NgU/bOMt71dKuFo783iQeid7TJAnwJPzIdkvIsF
	nv53BRADGTvMmiRDeHs30bmwIOJ+Txr8suGCCTwt95W2Mp15jieRwGxjtk8UVz2M
	at+7999FsQfhJp3l8mIFq6NdGPjCM+BLkRyTk5OsxJNz8v3k/2ndxtnzlJpdwcNz
	orqRWF9PvkM04jdyMSa8jkRRHsEO7zd9n0g==
X-ME-Sender: <xms:cfGFatLGr1-8efXIVu4gbbCzG6TfWL6PAP2EcYfaW5KcwHRE2PgtWA>
    <xme:cfGFagIUP3PhEx1o5Icb9MSXLplB_YJJTon1X5SMDyl7dXgc05h7lIi_Y-njKAjH6
    C1lmtqhr62k8MDN_5FmYl8PL2nCA31L6zNn4hSpupBXB56qbCVejSU>
X-ME-Received: <xmr:cfGFaqtel1m8-Vl-tNrcZLRs3zUUt8klN5NRA_6jVkVBR3rNQu2VCRJurSyH8j4tAItFWWn6enA9YPNVaAbdqEa-NDalkA-qAg>
X-ME-Proxy-Cause: dmFkZTGYT/pDp8sRzLBn/IyvqWm8omZPq7wAHc0XwfVplF6z3s3LgTUfrJ64HQPaYsGmUg
    bV+RGw4xbt45+nocKCbJTHQuqOPcx6QmcSzmJC+WS0NkHIAhfSAoqwxMb+cZkOj54aBsb0
    UwyuAkHL7pJ9JlwzyTTybZIoFzVkj0kO3hAY7FVckrLOr3zpUUW4GGOuIF/5YWk+SwIKbs
    BLK9bHGsnjN2MaXkHrLp3kI92+P3t1QL3FCuAbxGoMPmMMWSGRFX1adP+KrfuggYIOljLk
    t4AiIrKc/0wXYAHSdaMIhrAk1dcN9Cw+sGlT9Z75/6FGdlfii3sjLPuEj7hLwCwaNuKQBI
    NPD8/s8bzJH8BzM6lg797wIUJeUhy/cBnDkIUUAyT+9lLGFyBJW6IgXHYNopEmBVl0XiZc
    /OAr3h7vB+zkdzj+JJ76uXOBaFQfoF0EXd87UVs907LnksrFI9vKaHdLsyZ7grbMaZWfIz
    wcy1vExW5jRrXyRlQ9penUzcBbzgkeNOawI/IgGFWWuqL8dxqlmo/JZBT6CkIrTzHigpYu
    PfpdcqMb/pvt6RP+MEkNRbABs/0yKJgQNUYKE6NaTzV1UJvXl2Wlxxd27sROJ2RRpWguqr
    /NhhsqxQLQrJ9zNfYe7tM/taf9j+x8pCbmlzBmRa6UA3VbHCY6q4JE9IrZzg
X-ME-Proxy: <xmx:cfGFatT-RI2lfzW0QWdpnXyEDQu953vKJdZoFBG93pAlCMOOHBeN0A>
    <xmx:cfGFagMuBJTX97PVPRLfLrY_0cNo41JvKULIEwCUgVtyl3lLi1XCPQ>
    <xmx:cfGFaiaXeBrDhpCPYkOXGYbl2f7aRP4YgXaug6IVyBl37Nb9qeX9SA>
    <xmx:cfGFaqySF3A6R1HZHXLergBwab3qRVlGkyJnZjywp5LT3cmaEwXwXw>
    <xmx:cfGFaqNoGNjkcTlmcwiD94tqbSL2fX-j1KC6LQtMl3x0OTNA58GdMQiF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 14:09:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] replay: fail gracefully when a merge input is
 unreadable
In-Reply-To: <321af575e0a9e0c22c70c1809f6fbf0265b05d4c.1787092446.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Tue, 18 Aug 2026
	22:34:05 +0000")
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<321af575e0a9e0c22c70c1809f6fbf0265b05d4c.1787092446.git.gitgitgadget@gmail.com>
Date: Wed, 19 Aug 2026 11:09:51 -0700
Message-ID: <xmqqfr0augls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> When objects involved in the merge cannot be read, the merge machinery
> will return early with result.clean = -1, and result.tree left as NULL.
> pick_regular_commit() tested only "if (!result->clean)", ignoring the
> case where "clean < 0".  That causes the code to try to use
> result->tree, resulting in a SIGSEGV.
>
> Handle clean < 0 explicitly; the merge machinery will already have printed
> messages such as "Could not read <object>" and "collecting merge info
> failed for trees...", so we don't need to add much detail beyond the
> fact that the merge failed.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  replay.c                 |  7 +++++++
>  t/t3650-replay-basics.sh | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/replay.c b/replay.c
> index 463c900d6c..33e21b2032 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -327,6 +327,13 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  	merge_opt->ancestor = NULL;
>  	merge_opt->branch2 = NULL;
>  
> +	if (result->clean < 0) {
> +		error(_("merge of %s onto %s failed"),
> +		      oid_to_hex(&pickme->object.oid),
> +		      oid_to_hex(&replayed_base->object.oid));
> +		return NULL;
> +	}
> +
>  	if (!result->clean)
>  		return NULL;

Hmph, so anything but "0 < result->clean" is a failure, but we by
mistake took any non-zero value as OK?  That is an obvious mistake.
Well spotted and fixed.

> +		# Ensure replay gracefully handles the missing object
> +		test_must_fail git replay --onto onto base..side 2>err &&
> +		test_grep ! "[Ss]egmentation" err &&
> +		test_grep "Could not read\|collecting merge info failed" err

"test_must_fail" means "the tested command must fail voluntarily and
in a controlled way", so a segfaulting git-replay invocation would
not pass test_must_fail.  Hence, there is no need to separately
test "test_grep ! '[sS]egmentation'".

Besides, the spelling used by strsignal() is implementation-defined,
so you cannot reliably grep for it anyway.

> +	)
> +'
> +
>  test_done

Thanks.
