Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740EE1459F6
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999176; cv=none; b=F5/PQq5w6Y3phrifOXxMYJ0SE6UVsfPrs4R31EpcVofVRimh2bo0abS+IvYb544UEujD9LVmBe1YqBJ5Xiq2X4k5LbbVvMoQimJ1M9V3RJtdJcrQ7kF15EAh3BDOl1MTYwvpI/mK2pQK2Paqo3e1gC5hrvdaSFUsnIUhEJvJKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999176; c=relaxed/simple;
	bh=zfmU/Q06aJFpAmqWd72EAS2DSpvt3VtQe6kwSKwMREQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n9bqKROwfDqt/I4m5Gx04/1bl62zC51M7NcbnRktLVZtKEI1Cp7cNxLD25leLlKBfroN9SLdtvlPfCLyW8h2USP9FI0r6dROxzl8VEQ8eL1bZ1pmZLxtJYrDpkxWbXVEtZRNk/oAcLgy6KflVC21xuT2oZWNwa+IRLfP1Ul2CvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oWM4xjkX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ysbcjezk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oWM4xjkX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ysbcjezk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 823A6140006C;
	Mon, 24 Nov 2025 10:46:10 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 24 Nov 2025 10:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763999170;
	 x=1764085570; bh=u9v00RNGs9F2Pe8Ij2+YDtMYW8iIaua9jSFzLt7AIAY=; b=
	oWM4xjkX9qou/1sPzArP8Y2W6+isQuq/lQGv1uYRPX0c2Qx5fVCWG0d63WFHCI62
	feISlMjeCViarlkW09YB9R362jU/gd8JtOwvoaKvAIB1YUxDzrS0K3I5oxAuKeEE
	nRuwhIvS0XWxEfg1zml2917mg3c3M8BQ2DL9rZ1LKkNAUMvWWZzkwhZY28it6Xs3
	PDMH7rdqUN9tdnDUW7vgPTniX3vvL17KVWGmA87oYn6gVfLPKl4NjcwfgoeUfNI7
	q5SwG4tYhfxkjxPcgSYGeed/D5ecmXFJ0JBp2cRmtexigCBm91g3iupgCJs9qLdF
	etTfVZ/aQo8+yI9wEsvonQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763999170; x=1764085570; bh=u
	9v00RNGs9F2Pe8Ij2+YDtMYW8iIaua9jSFzLt7AIAY=; b=ysbcjezkDWSWGxTX5
	EtGXz8GSIfeT5eXHqavl0zDhJhmeyL8lXqYKFeVM4cn3uxPwHP/NxLV5RZaK7tlw
	bBUqsK1TPkP4ELd5BLcyZ76h0VDZoOfEcbHHVzoXjxaYe58/lFG9zug3voJHXaI7
	WfxG/CvfeBjbQkhM8/Vk+IF7P8u8tGLZE+dLfIeBVp0mLGYi+tt4LvnL81xPw0mo
	D6xwFSxvuOoacLQ+liUyiV2uPPRcROp0nusxPQrMoNwuKI1piF/xsqYyRmkiDb9a
	mBqPO3YIPzgN7ielBO1ycvOISs/yvS2oo/H+OWug69/3MREc1YBe5JRaB+2QPOQk
	jhTsQ==
X-ME-Sender: <xms:wX0kaY94D7LbASKMz6AmyTgfzXfiTLDTzDoff8nBXi9cMPe4ciatL_g>
    <xme:wX0kabiiSbit3KaFw55WuhJ9pn-6SgB66E0A1sET9BNv5anl2_NSC0-9EpRkHEFZL
    deolvrOwiHAvFYbAmrMl7GrC5mjVr3mPFnxj9r8-T13Kj4U2UYbTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hmvgeslhhinhhugidrsggvrghuthihpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wX0kaVE2GAc1r7mqyok0Srt8-kQKcGWSrHECmqgtcHQnkwfuWwUjAg>
    <xmx:wX0kaVw0XmXDWd9SUf06CsDC1w2U5i-OHe_QsXE7Nuqdpn-sJdBSAA>
    <xmx:wX0kaaoG4mDEicTuLjjrY2oRJBziF8bijWfLzfJ9ddejhWcJQLnX-Q>
    <xmx:wX0kafh4Hv4reC9FUMfVbwaPfHc8Tg2KosPZcGkbVUTmUEBxtWxO1A>
    <xmx:wn0kaVfpuvOYhcx5oKyT3DI-BdBkFGFElre41Tw_TCltDCfY6IOaiYbC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CC93E1EA0066; Mon, 24 Nov 2025 10:46:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3A6gSAalujs
Date: Mon, 24 Nov 2025 16:45:49 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Li Chen" <me@linux.beauty>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <cb5a792f-c763-4fbf-bfcc-52f66c895c9e@app.fastmail.com>
In-Reply-To: <20251105142944.73061-5-me@linux.beauty>
References: <20251105142944.73061-1-me@linux.beauty>
 <20251105142944.73061-5-me@linux.beauty>
Subject: Re: [PATCH v6 4/4] rebase: support --trailer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025, at 15:29, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
>
> Implement a new `--trailer <text>` option for `git rebase`
> (support merge backend only now), which appends arbitrary
> trailer lines to each rebased commit message.
>
> Reject it if the user passes an option that requires the
> apply backend (git am) since it lacks message=E2=80=91filter/trailer
> hook. otherwise we can just use the merge backend.
>
> Automatically set REBASE_FORCE when any trailer is supplied.
>
> And reject invalid input before user edits the interactive file.
>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
>[snip]
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.=
adoc
> index 005caf6164..4d2fe4be6e 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -487,9 +487,16 @@ See also INCOMPATIBLE OPTIONS below.
>  	Add a `Signed-off-by` trailer to all the rebased commits. Note
>  	that if `--interactive` is given then only commits marked to be
>  	picked, edited or reworded will have the trailer added.
> -+
> +
>  See also INCOMPATIBLE OPTIONS below.
>

Same problem as I commented on in https://lore.kernel.org/git/cbe93380-e=
145-4ebd-a213-928b8c3ba085@app.fastmail.com/

The `See also INCOMPATIBLE OPTIONS below.` is not indented to the same
level as `--signoff`, where it belongs.

> +--trailer=3D<trailer>::
> +       Append the given trailer line(s) to every rebased commit
> +       message, processed via linkgit:git-interpret-trailers[1].
> +       When this option is present *rebase automatically implies*
> +       `--force-rebase` so that fast=E2=80=91forwarded commits are al=
so
> +       rewritten.
> +
>[snip]
