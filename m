Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C92270EC3
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763333915; cv=none; b=VJEG6a3W7ftEV6rkWA/MALdLKtSqRtMTW4KTIjVKYYTtz6feEDIGeT9+49sW7f9tYE0nlXQOaQftuiwqkrGq7ssmFceaJCozy2P+pFDF0M5Xh/tMQ7iKHgPfYC9knkhYE3Z3eYdJXKqje5O9SrYNY0bo6wDmAc9qSiu6Pg8sUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763333915; c=relaxed/simple;
	bh=cWEQZhT0Qsa4xmVWM4MxJ6cIUkpVNsI0Rh1ExoQ9/Eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZI0fpRxRJ4qioKTgxPedv55FiPoDmpeTwWXCkaKdf/gk7cWk26n0mswN5/cjtpUROqoU/vb4o5lz5w7zQqkJpt1stduFtX6RTK4lciCSqStSth8BPeooxEYoc4kZbSQ3UpcC08hOhmoAyhsbENiNTakcMCSexxzPs/dTiLBSizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=icosUgeN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oeFCU+sQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="icosUgeN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oeFCU+sQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B5DE14000CE;
	Sun, 16 Nov 2025 17:58:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 16 Nov 2025 17:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763333911; x=1763420311; bh=eMG3SBkqdU
	Zubd96MCfjGUB7GQycPR7fkY2TseLiQN4=; b=icosUgeN+F4Gt8/B8TuptNSj5H
	E4Q17F1QijQCFZTcQ+M3ZuGslSn/lVuQn+PgK89hGP106JJTHr2ylVZZVNOK18QT
	wT1m5qRvVpmBlMNITV7b0PrHXq9hui1xrdXZiD6guN8HzdMFmnpLIHQ/rW/3X80g
	VdSVAtaigjn48zic1mQJCdu8lLexpOK2Y7Bv0/37YOgWEjd7sTVAi+W+NXD6ycbV
	lSyk1muZaVPdw2/9cw1/z/vnfB0D+8E65auorvePoRv1TJ+7rlRiEA/SdQkCVPX0
	8pJSNIp44x59GNvWL438qbIZpYY/7m+I1kNv920p8kWP5rlnsYj7D5YV4Yug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763333911; x=1763420311; bh=eMG3SBkqdUZubd96MCfjGUB7GQycPR7fkY2
	TseLiQN4=; b=oeFCU+sQOA8JAP6DN8Mst69EPnopcGJhRFRoBrZER4vl4OSR8zI
	KhNkKszzwfqyG6A1SgBEnbZQhDr38t4HACX1zTs5Jd/2bRtmoLVVqCPW2vu8UwUv
	gHX1sPrtkr6ZWpoGU4MlxQzTU01Xyu6KQx9u5ZH3iF3dR/jDWzTKSjxpCBKL4Rob
	XwxfnPMRZR7nwPEufS6LIXDs66wownHpd3PS8hICCQjKThYsFDxCbac7ZU62W2Zs
	R9c3PiOwkCvyJa5GZUZOYWYRDn41qK3S8Sfod3m7U9doOX52abhH9ex339JSKhkm
	LTXxOEJKnXoJ+H5v4ZgeDhH16rtgAxqf8uA==
X-ME-Sender: <xms:FVcaaYp-SwMZY_1ybh166FoMs355OxYDPFxyMYSbNFsCdm0CbYjGow>
    <xme:FVcaaWOsnuQX_4zEjckh_bmFZhcZ41riH2CCKaG9H5eu3QE35nURS1lp5ePuoGrUB
    GLL6HUtIWHkhQZBhgaPVfsqYS70OY-E-YE9zRB7o0SLJN7InpXyHQ>
X-ME-Received: <xmr:FVcaac1iX8YF6EHwQFpaAuNeQfRm7IUgSt4Pmxc0CbJ2__i0XyOsmQqNTx8RHQuXDz3Pv4bwF0M9aGLlpXXpVgqg5--ooVDAp1mu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeikeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtqdhluddtnhesghhoohhglhgvghhrohhuphhsrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrshhhsehkrghmsggrnhgrrhhirgdrohhrghdprhgtphhtthhopehmihhkvghlrdhf
    ohhrtggruggrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrlhhfrdhthhhivghloh
    ifsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
    pdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epughjmhdttdhnsehmrghilhdrrhhu
X-ME-Proxy: <xmx:FVcaacqeELg3CKEsC9UAWPAMcDCTpA9FgFBabDZXJtribusgo49xmg>
    <xmx:FVcaaeefRvCAiMmfdgk79_0yGv-dU-OaXeGXFW9vY9hpCroobNAnKw>
    <xmx:FVcaaWvdNVxwqm3app7Lee4w2hbHDGyclX3OsL7dgGzXkV6YfHMR9A>
    <xmx:FVcaaWWEfQa91aSSeeuIhlf2krK1Q9DMrmR2KtmGAoWgDoGXAvhubg>
    <xmx:F1caaW1QzN1sDDunvw8BhtcJIKOnjjvcJ3JF7kb9dc5fQkWIfq0Dolxs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 17:58:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git l10n discussion group <git-l10n@googlegroups.com>,  Git List
 <git@vger.kernel.org>,  Alexander Shopov <ash@kambanaria.org>,  Mikel
 Forcada <mikel.forcada@gmail.com>,  Ralf Thielow <ralf.thielow@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Bagas Sanjaya
 <bagasdotme@gmail.com>,  Dimitriy Ryazantcev <DJm00n@mail.ru>,  Peter
 Krefting <peter@softwolves.pp.se>,  Emir SARI <bitigchi@me.com>,  Arkadii
 Yakovets <ark@cho.red>,  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>,  Teng
 Long <dyroneteng@gmail.com>,  Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.52.0
In-Reply-To: <20251116100210.844040-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Sun, 16 Nov 2025 05:02:06 -0500")
References: <20251116100210.844040-1-worldhello.net@gmail.com>
Date: Sun, 16 Nov 2025 14:58:28 -0800
Message-ID: <xmqqcy5hd1pn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following l10n updates for Git 2.52.0.
>
> The following changes since commit fd372d9b1a69a01a676398882bbe3840bf51fe72:
>
>   RelNotes: fix typo in release notes for 2.52.0 (2025-11-13 09:34:53 -0800)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.52.0-v1
>
> for you to fetch changes up to ad892a61d6dd73211aafbc72e177ffa31e4cbec3:
>
>   l10n: zh_CN: updated translation for 2.52 (2025-11-16 17:27:10 +0800)

Thanks; pulled.
