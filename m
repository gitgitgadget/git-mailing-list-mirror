Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D2469857
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760059; cv=none; b=MtknApCZ0EJ70LR+gUFlZ6cAnqOpCEFSiKvgCzbqk3Edst0negF7AP9QhzeA5paocID04+ffsDNkQkNn1f2uiXsrV+hpujmIabDEMTwFHScwQm/liK9Ao+5LaKYpVn3piFKVJbiPITH3XuaA9FLJTUvs95ojbxtmq6AH84MprVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760059; c=relaxed/simple;
	bh=ah25epnTH5b4ig7Wvd0c5DGN3hSwfH1Ev4yyN3S0blQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gKXo+NF3g+2OMZjpABdTC+sQqAZ2vVmOEUBcBjydaLqRQF6elNSc+Lr6BRt5yAuHPVds9M7hCPk55xVsTUUo7B6SqdKBImF2OnI+Az+HaPQQ7VKiJQeZtrMGBRR3WG7EobmCRGIjIry54JuJB3pZsW416QqyxvdBLvG72WQFxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eNnqRojR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y4itXrLM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eNnqRojR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y4itXrLM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 359A61400079
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:07:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 11 Oct 2026 19:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791760056; x=1791846456; bh=Uw7M+k0kLv
	NlpmJpXffihmg2oJ6uvNt8al2mSyN4+NA=; b=eNnqRojROQ6Xpzo5dXFT0VrAWw
	Bph9m4nlPcnLs3dDYTlkWqsJhVorBUmJiZVMnC7yFTYT7tCJ2yI6xQTX96TlwQzG
	D/sAuM9XaZvWU1nt05Iw2CBz5Tcrrqy2g6N+lRLRXJ8NUHqZ2PB8iXSsbaH0UHgn
	Qd8Lfjx1xq9hi0A3i8kXLFvXlcrNrisVBIjGooE4b79EP13Kc3HV6iu1qUsT507H
	UDzlDaLR4jtoju/T+zWeXU43BE1DOn34F5Wh5TVjh4RkkdUFSos37yy+5sa7sOuN
	1wOr9J449SDJ+Hfaub/F88QcBiniGwpiXdf4cwSXc7JotNoLb+r+oZBX1LgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791760056; x=1791846456; bh=Uw7M+k0kLvNlpmJpXffihmg2oJ6uvNt8al2
	mSyN4+NA=; b=y4itXrLMNDqrz6pRZh3nm1FOlIRdKkfZRPF+Y2VQnBSqRQKq/qR
	JeRk4nRntn22e3PvzavsgAXXDR3CL6aOhw8Es05wwo8CxQwCREEmw3cJaTy48JH5
	+2ADfX2tq8sSAcTqY7SJiuygx5Re/DVBJdCk6vMMAlOa38GJLOz3A8BvoLmmy0wa
	Z3h3lENERo+ya70CS0LTFVKSk2DKTnxXUVp72bNJJsuY0qMzbh+jIJqjKFD/70yR
	N8bv6uNCI9VkK0PljzBisGMdLcd9eWA3MFKpCBe9Q7IktYNiZ8+qaPM832dA8kQt
	2egmkcRbvs6NuJeK0laizMMbqLTOfVcNZJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791760056; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:WKOAm7ZE0BNN7IwKywBZcDGE6C6svaVyhfegJLePs/xTZ44
	9OAehjBMjooc8WzQZKCTWZREpI8lkIaJWwf1io8GKaaVsE/LDGmeaWCKEomb+Zh0
	lX2tqevd9apRgnvhVRhiAdnTDjcZJvT//0+b2+YLxdTdPUph5zvtjL+JAP/E41ul
	mKOKJ2mC960dIFKJLnVvRSVGZZJbzXv2e1wb3lL7ev4CtYjPs/COvrtkJIpz1DUA
	zPwRzZ9iKrU+195BcHGPUIqEd2ESsuc7IAjtITHAOJE1iTZbFiA7VLdoXX4OEhrx
	nB3FZjMF1yBMV/dY7u5XdxIaoOvaUpG3SM6A2NQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zX4OtrGoTk7/4p2J9Vg38Tw7ZxIZR6n2wC1AODJQaW8=:ah25epnTH5b4ig7Wvd0c5DGN3hSwfH1Ev4yyN3S0blQ=;
X-ME-Sender: <xms:txbMamGkiTQlVxrNnJDwFOX1uG_mzOT8He8QSSoqBCp8JHpHfQOIbw>
    <xme:txbMahVBnyRYW3NzcHkUXWzg8-rz51hF_7jIF0ZNb2IvLCz3fuv1bdq76iCbPMAIK
    QL68sLOZHiSaDarp6w6SEhdnxElpyfjODx3g8tROlBwSXGl5Angdbs>
X-ME-Received: <xmr:txbMamwi4glaCgvE6xj0wf25Qhfbvo_Sxu69zlMGGaVdQ87q4LQ3Gi2vcrJ-fajpOc5BonCOssv8EsHZ5Gs0bYC-oOzdCMgfFwp->
X-ME-Proxy-Cause: dmFkZTGZ6Im/xDtKBTnXbS19MYyKpEGXcVvRw24+GU1+fq92DwR8P5wW7jk0wZ7lBvmu8J
    rKHr2hTpWsVn9KoJnkT9GGR9MME6rRct/l97odWeOHtH7m5i6XGe9N47pPpmud5GtXEbCX
    faDgWwvFDclTwMHzaWrY0Yc+RF6jjnJiNXv5PRwmXT89jtbaUt12kaAgj0bGQJPj3pjtyF
    cD3Aitx/JLu3N53vwxDSMzC9O8N5f4So5Zc1BTL3b+Cb6cTvnVsLI1hlRGOEICDFt/CLhc
    /0FCXuMbkgTkfrxHwg7p9NVpBguurWrlX3uJt9wabXF25aLp2ptDJR+QQwBypPlTT2nMfl
    bIadSJVrq6s+hAs/h7/blg2x9fSkUOCYFWKDIEUFqnVO4DJttvRZrAnqo+LIt9wl/7G/Ir
    ObZjpdRnTVQCR1xHybzZJGg99EKRZBHwaYKrzm1iyVf7c/o4XYeturcUGYmz1uP8wpfmYv
    jDq4Vs305QEn0s6H8wvalpWaZGXS5uq57rkH+oTJQISzi7nSDu+LPgn5FpQrMfmUlli/0w
    4Tv8olBKVZW1aBsdWc5V5521ksxC5vVNPEVHr/SYjzzS26MwDjjPtEAwQy3SOQdmSny0I/
    6v2G2GXyhim6fxcdlqrR9zcXWQ4zBZwjbE00VUvTN8oyhl0qwEYeHE9LkBZw
X-ME-Proxy: <xmx:txbMauStfaRVIcoz8W4k5CQdPMC6Srf-iFj2pbZjqdg4BNBfTWqk1Q>
    <xmx:txbMaqgysXyCxrypD0W0uA0aUMgWalS7sEYG8bJmh6on5jtDIB4zYg>
    <xmx:txbMatlhieCfFAZWajJ-Dd9LddlfcC3rYplIQE9g8xplCionapDZEg>
    <xmx:txbMalt0kfEp8XCUp_lTn9mblrqtwY13LqZBMXv-aJg0zxuy2cHifA>
    <xmx:uBbMaqCCVzIS0yBpl5Aoeolq20-nLKF8KXWfC0u6QazjildURDW7LNwO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 19:07:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ravi Mistry <rmistry@google.com>
Cc: git@vger.kernel.org,  Ravi Mistry via GitGitGadget
 <gitgitgadget@gmail.com>,  Abhijeetsingh Meena <abhijeet040403@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
In-Reply-To: <20261011222929.2957901-1-rmistry@google.com> (Ravi Mistry's
	message of "Sun, 11 Oct 2026 22:29:29 +0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
	<35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
	<xmqqtsmsdpxz.fsf@gitster.g>
	<20261011222929.2957901-1-rmistry@google.com>
Date: Sun, 11 Oct 2026 16:07:34 -0700
Message-ID: <xmqq8q43eszt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ravi Mistry <rmistry@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Since the scoreboard is passed around throughout the subsystem and
>> has a pointer to the repository it is working with, a new function
>> like this one does not have to add new references to the_repository.
>
> Since there is an ongoing effort to reduce uses of the_repository in
> the codebase, I went ahead and switched parse_default_ignore_revs_blob()
> to use sb->repo in v3.
>
> Thanks!

Sounds good, and v3 looks good.  Let me mark the topic ready for
'next' unless we hear objections in a few days.

Thanks.
