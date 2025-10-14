Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225A2FB0BA
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460464; cv=none; b=mcTVs8ugYFP+0TTjToNKPyprFEjZ/x9hD43JS+w/FzmfFwYsiw7zw4GWvTEkpgSrc29U9J1LHaRHcQMbQnS15zFQp3/Rg/zQOyDu21HTW45oUWdArMabbnTIZNUX1iwsiuJPg1HSufyxxA8mCi+pyfYpD4AfcWglMEij9G9hSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460464; c=relaxed/simple;
	bh=Kg5zxaGer1l0PXq+GsZFpQcZJCf68bawFUetxuRDoZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXwdtWS699Y6FMBkfzK2luxhtCjhk/f0qWo6EOutwu/sksRqndp15Cf5KUvJQRVAc9GCu4N19qXAgA75D1vPvxelRUgWXBkKJdHyovYhjauGIVhg8N2WzzfFIfoLhB9L7LyMKXiuLoO2T41qK+rhJEId5xxF33JidV3/73nUQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PAew5Gl6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSZTvSMS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PAew5Gl6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSZTvSMS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E5E3D1D000DC;
	Tue, 14 Oct 2025 12:47:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 14 Oct 2025 12:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760460460; x=1760546860; bh=2qXNk8WUtE
	Ezs1qyj6jA7xgD4vYHe/ahnBDKPL2AfcY=; b=PAew5Gl6IU/PH1BIamV3vcp+Oa
	QW0fCQdyuHIR/ipIBEvz+IXoq0ehaXzl64ByMWa6jjmcqrtRmUkPbO5RGNPOZVaa
	j2NQCFj81WOcgn6JLCKT29nYWkmeh1OtKslQMpKiLqtIbG2asSdbbNAoPpH/va1i
	5hUyh7gd/4pjb/bKEaPx1jpT0hdL04mz6vcct8rzXOK1NjF2Fx/OxuxtXU/ZpNRw
	DSaRfJDlgJLC3pfYfLDaOmcDzC3fc4riPA5SultIE60mLXM8ClY61JACQjiDYEO0
	FmWPw40QrmQfdIqw6yZix8t3Ek6y8LzMPLGnS9ULODV5Rhj2hmSJWD1wDd6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760460460; x=1760546860; bh=2qXNk8WUtEEzs1qyj6jA7xgD4vYHe/ahnBD
	KPL2AfcY=; b=CSZTvSMSO3spUD//8oVRgiDMZwexdz+EanTmQ1t3gMNTlGUyUI5
	nTJYbf+eutQIfg6L3wfeNip/IcVKY/ckYkcmEb6etpvZafr+i1c0bggcZ5NLqekf
	ocYQk7DRWx6bPpmDRqoUgIfzRGPgLorWaYVsHMGO4I8sRblA+xnC9huTYeA8RMNK
	LQDnROuj3VLfjWLYtXVB3flJxgUAMWS6mbVJmj4n43YIpOV8Mv9008nVr55kMs/A
	WzX2keXavo/RvooNwEduFNcz1JlgH65RSrjoO2RmNqTwbCIiaT+MkO4RFv0lMDcd
	Fs+YL8aBbGIpiaDuBkesGJv6dRQeDJOKWBA==
X-ME-Sender: <xms:rH7uaLuxAB1h9osEjZEC3qt5_A35KHL9yEIFP5gueFrn_tKic6kqSQ>
    <xme:rH7uaPCOES6qKpLdHjiPVax0C7Xi10mQgB_ZKeORWQ9pWPxOlfYQ8FikdfEn4Xi1D
    -ixi7tmWbi6AFpVhQRws8SHLg_svrkyJFMGwy6p9Gm211qE32Dw>
X-ME-Received: <xmr:rH7uaCZRQ9Bn2z_c92_nlm5LJUpZ5NFSuSjZA9O_Sat0uwzFxf9XiH5IpLsJt-t3_cOeViTV7KynZlWPmHjAPJd871kZklFR5ptY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrges
    fhhrvggvrdhfrhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rH7uaKVmJvgT8kKVxoU18fgYiPFnkHu_d12Kn0jCFFLLAykAuz_QVQ>
    <xmx:rH7uaBMiLmAM8KuEg8UXiYzoaSbT6MSPbZI7OeyFqLp6SoD4YxsVzQ>
    <xmx:rH7uaEZKZ1u7UseNBiqcPGkuQGKsgKF_ymrNY33-TPeM4dJUTKia_A>
    <xmx:rH7uaA-ARK2ZFJXxOOB3KLhsbeOm6uhtRRi2NAH5PGqsgk_UMsO5Qg>
    <xmx:rH7uaP6TQ3MMfGbzhtgJXB9dV6Ig2kb4F-Wu3hhbBM2i_ty4C9YZYdBZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 12:47:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 00/12] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
	(Patrick Steinhardt's message of "Wed, 01 Oct 2025 17:57:26 +0200")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
Date: Tue, 14 Oct 2025 09:47:38 -0700
Message-ID: <xmqq347lzaz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.
> ...
> Changes in v4:
>   - I've rebuilt the patch series. It is now based on 821f583da6 (The
>     thirteenth batcn, 2025-09-29) with sa/replay-atomic-ref-updates
>     at 665c66a743 (replay: make atomic ref updates the default behavior,
>     2025-09-27) merged into it. This should fix all conflicts with seen.
>   - I've reworked this patch series to use the same infra as
>     git-replay(1), as discussed during the Contributor's Summit.
>   - I've slimmed down the patch series to only tackle those commands
>     that cannot result in a conflict to keep it simple. I also learned
>     that Elijah has been working on a "git replay edit" command, so I
>     dropped that command so that we can instead use his version.
>   - During the Contributor's Summit we have agreed that for now, we
>     won't care about hook execution just yet. This may be backfilled at
>     a later point in time.
>   - I dropped "commit.verbose" handling for now, as my understanding of
>     it was wrong at first. This is something we should backfill.
>   - Link to v3: https://lore.kernel.org/r/20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im

What is queued near the tip of 'seen' is v4 but rebased on the
updated version of sa/replay-atomic-ref-updates that came from
<20251013183311.33329-1-siddharthasthana31@gmail.com>.  The rebase
only had a slight conflict at [PATCH v4 02/12].

The result based on the same 821f583da6 (The thirteenth batcn,
2025-09-29) with sa/replay-atomic-ref-updates at a07d37b3 (replay:
add replay.defaultAction config option, 2025-10-14).

