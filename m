Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183F3C8700
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790513415; cv=none; b=OArRCM/jUfvItqRLaXbizQ6UFxE9NA6wFaLDl+Sy7GgX/3KYOS39IcfYW/IhGLXGhiN0yL2wMRGIqnVuVk0tHFb5jTZu9Op4lh7tEagEj7CY0KscLBtlrFITdWD77E5LqdcH9fh7TpEGt6U5vAtHQ+vp+pcppD8E+U+MhGV7ZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790513415; c=relaxed/simple;
	bh=7ta4BcKhZgkIcET6EKEMxOkJzC5u0CY0mPMcu5Mhh/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewNQCVkdjm6eqAu1NJgnR7dMCUu7oVnTL5qTAVqWA/qtoYsqeTuK/xG7whZ/Js3Ik+OdRP6yZvkcqgnnYK7HcFQ5Id/AbZadc1Lyq58h/b6OZyQW9myzY91Ur69PYyympSxg4+TydqBFLcQd9QComDHpKcp5l+jRZe/NC92qstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FupGh0Yv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FXw9YVqH; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FupGh0Yv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FXw9YVqH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A8BB77A00E1;
	Sun, 27 Sep 2026 08:50:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 27 Sep 2026 08:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790513412; x=1790599812; bh=b8WpUSnikJ
	NFcSl/ntnIoyj1phUWf8hPAexxSVuXu1c=; b=FupGh0YveeQ6CILFvlezRI0Xz/
	xsXnW237+mRAYpOjArQNeUq3G2P0Q0rp+/MEbZduSp4oCMuhQCXH0R+RjdaWWUiI
	uQDUSTCXKjBz53lC5IIyplBvxfrsjNqyMgOLgLdAxRBj2CuVDs/C3Dtjov0Xq/2w
	Lmyep8ZP/0YxsuUMQHKzePpwSKewByxoOIaJbkdhQePJjn9wpxZVuLRb8i3V/xz0
	OG3AwJA0K0ddaDTo7aHP+n2bPA3mtdu9QC04uqpMED7FNIyjwftnOZccvo7V5rqS
	SgJUXs16MlCui6VgyukDpU+GUHajrSA32GKfDbLYF9NooeZkkODzp40dzxuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790513412; x=1790599812; bh=b8WpUSnikJNFcSl/ntnIoyj1phUWf8hPAex
	xSVuXu1c=; b=FXw9YVqHd8+sYE2djFAYL96w6sudxbXZLwfREnwLGkxi8nyVbWL
	3z0mF92dpEDRpBAkYD0NQSc7KlSgcsjU9ydb4ZAupf3tMr5CnLb0PmaLHQnFw7zs
	ylvguNuV4hVOUd9mz2058+zGfeLIVXb8N1wZLFMUbYz1gGQQyPUDj2Y1HqcYj2T3
	nKPh1OxgV7KKpLZV69W5NGxybAdGZSBSb1wFRSFxdbSHdo7N4CweA8CX060uyGu7
	YyuzwqLxja8IVTtsvMPkOLkJKET9L4DESqkLASMOKgkTwV9+2IciZIOkFBALFGZF
	wlyNFaT9j1KisRl0hsRx0YwYb3zh2aWHtGg==
X-ME-Sender: <xms:BBG5aideVUTLyrI6rpLe84qydxoJSdxa0rIumZ5h4aUY3hvgSSBlvA>
    <xme:BBG5ajEHEYSbN-NDQmbVAWoWRN0CnHzdlD4cvr4vp_T5F8YFg5Au_CDPniMcy7IO1
    LUKSsWV8ol5SwrgWUYoVEOJEqxztBPffr00SDXMRTBTNrgccrqANi0>
X-ME-Received: <xmr:BBG5ar2o9Ek0en3mv-kelN59Q7XAU1qUVU6TxOYVcaYhw1VAMu7KOIBG7wInUSxYNb42hxJXxJlMB1Ae4X4lgAGo6GmBax27Ovru>
X-ME-Proxy-Cause: dmFkZTEGUIF/e7MQVWLWFyYMopyq0DkK67BUOlQEf/nHP3LK6E3qSjGhFDAE549L4hJDjU
    LsEjYgKbkuAejCSnz/R7NoLluAASKq2JXjd7Qoq7LDMC/jnie53etNK7UgeoZ504eMZLLf
    MfxS12KYMb8DfUHDrpxtqulmOqo78FnbyBHvFu65iy8MHhMOWLGoMtctzlYf6qNM4XGLN5
    IdY6h27MwfhBNBwmA4WYisAc3WnjZJ390X4niM24yFqh9gu/lsuoxqVyf2lu8UDqyzFKsl
    my5upQJ8oh2DD22Gvknl4EFALNzkY+mJeaLEpOAwIX5gN909AJlrzCUMdqt+9Z9l3yw7oU
    +KljJmS+vrxBCEJrh2xzFJK3S1Y/iyzYrGpRFqKWzMcZgsYABKLOTNsCn7XE87Pj72/HmC
    aoIH6NacV3AezAzPO3WpGWdHeAtr3nwomFgThFAH2xkwd3CR0Xx64ZPoU4ih0r1wm3cMJS
    4YrcNqWWxwb2jH7H0yqVDeBMTID4WS6ubiY1l9Zshhc3wnjFhDuRUuTiplxONFkWkYr19R
    QzZl8890DRK3xZFlumpxD3uqphyu6GLsnJ3p4cRvEdoScRKMM0yCKbhtKwUZ8EJ2cw445U
    YyWwHZqehw0T1mzRszNkkpiAkLt2XIx5gQziRO3WvsyIldh/DpvHlK8Rl2iQ
X-ME-Proxy: <xmx:BBG5arnQokastP-jyHWJ6aK0WbjEc_gBDldNk231SD9ufCyB5gzBlg>
    <xmx:BBG5ar_RemgaddzOIvVWBSAu6228moheBcjXcIXUFgPOut0n-56LZw>
    <xmx:BBG5agpCzdZxYIqxe5oCnVAJMaEPX7G3f8BGlBgWBJYdCk8KEO9zMg>
    <xmx:BBG5akliK8JBxYDVqbYZaEekORqnJ0auK74RKX8AiVjT0kDUsdYugw>
    <xmx:BBG5ai30zoTyl4_sahq73qUE0q_yXaTEC22i_XobJvM2H5vuWjHZRFkd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 08:50:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  "D .
 Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 2/2] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <V2_format-patch_learn_--range-diff-notes.cdd@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sat, 26 Sep 2026
	20:27:46 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
	<V2_format-patch_learn_--range-diff-notes.cdd@msgid.xyz>
Date: Sun, 27 Sep 2026 05:50:10 -0700
Message-ID: <xmqq33uusvst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index ef92704de39..640c5dec52e 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> ...
> +# The '--range-diff-notes' has no effect but is allowed
> +test_expect_success 'format-patch --range-diff-notes=not-a-note (no --range-diff)' '
> +	test_when_finished "rm -f 000?-*" &&
> +	git format-patch --range-diff-notes=not-a-note --cover-letter \
> +		main..unmodified &&
> +	test_when_finished "rm -f 000?-*" &&
> +	test_file_not_empty 0000-cover-letter* &&
> +	test_grep ! "^Range-diff:" 0000-cover-letter* &&
> +	test_grep ! "## Notes " 0000-cover-letter*
> +'

The second test_when_finished is redundant, I suspect.

Other than this minor nit, I didn't see anything questionable in
this step.

Thanks.
