Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091E2773C3
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493652; cv=none; b=etovBamENbaRoYy+4k1c3YJk+lbjv1plEp3mmEabne7CdpMp3uyUzyU/2bQqqvEEiIXM2t/TaAy5g2BqHxbpt/nNVV/8d+9p37U3aeemZmoQxGYKf6TjFW9mfa2Onj38xn4v4eFk8QArzB4XP9T65NXcw3ppQWWM87vxZL0IHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493652; c=relaxed/simple;
	bh=K8B6bGtTVbc4Lqihjpt5gwxXpWvGUS6Y1ZJr+EmP5SM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0RZu1QUShpxBJzpsYXg/zKk2Jpq+w1PkX45wM5q0A0sLSu6N+0wU7vGcleG5sEXR2B2QS0ykkfz1KNPRniI5XwRdSKsHQ6dAA08C89tQyhH2oUB9mPuqdXAvsE3CbgipYnD3pQnE/eLXeJl9OeZMR6D2I59eIusVEgHFHgCFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B7ogPRmY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bd9hh3pR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B7ogPRmY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bd9hh3pR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AFDA61D00083;
	Sat,  3 Jan 2026 21:27:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 03 Jan 2026 21:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767493649; x=1767580049; bh=K8B6bGtTVb
	c4Lqihjpt5gwxXpWvGUS6Y1ZJr+EmP5SM=; b=B7ogPRmYbL6OL5iqdqPC6PB2fo
	qrg8v4HTBKAFVgO4DO7aqz7ZwKhejpvRsb+Oo/addhExntK8CkDWKGHSkzBN4k2W
	rFXvlr4ximMLLq9Lk/8c5TdEOk/8tDOevIuzO9Zf7qKSqwuznZ4xPBjF0yOlzwQP
	YdH0ctVN/7AqZiIa6os57HONY2One966C2TEL18g5//byCvlSvqalOMQ7nBBS1yE
	8q9kFgdNm7oJxD0tdlDxgTF0+oTdEA3cMKOn7quRsx6axAXAz5NNup66r9D1bOC/
	hAcT4YwsQCafTO6Rr8GJkFCSQYTXwk/0QQ+l8eLNyo5wxYgm/75kHenyAD5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767493649; x=1767580049; bh=K8B6bGtTVbc4Lqihjpt5gwxXpWvGUS6Y1ZJ
	r+EmP5SM=; b=Bd9hh3pRG8w7SrtvFiLTCKSgitgt+mHO5Svnpn6J9SPJjMbO0DB
	Ar89BmDDSMQ60gdQynCSFRIy2pVDvEIVqY+9CHCUekvVpHe4tloDy+P54z/LiZ/p
	3Lb28zirO1kb0LkVPfRY8NodUDiCsLFqoMyaMnNG2AOp8TioAHFJIw5HXKu/niuF
	nmDjxIbPxczoPXx/wsrsqqfuBv3n70ulkYnWVlAK46LqjcGw82euA11YGimTXtsW
	amuZS0ZlSMq5dgRpbKQ+mrefwKmSvqrua2df4M7lbVVoG8fSivlBxXbI/hTCyRzk
	VS7eG4dpwCX3moCyRXMOuzTJvxWJO8JpTXg==
X-ME-Sender: <xms:EdBZaXZ_dHDz4O-JiLDPMnlmaEsjM57xtPaT2I0kxqeOrHdPJNAMNA>
    <xme:EdBZaXG3le_ZL6X0h14UOUPR4mlFp692JcPdTc1vexV3saE69AI_hTGCfybYCRxA9
    4pVyS674RUUBD6muIDKa6IJ8tOb8IoLp1pzjN2i5obJvYEqZD0ygQ>
X-ME-Received: <xmr:EdBZaYJ1b-fekIpd5nT8wk1W2gqnh6iUgf-lbgNzH1uD8UQRKurMt3WAzxRozA-nSjWpu6nzSFha1H-QM84wFBttANjd8xL2jjMUvcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgruhhl
    sehprghulhhtrghrjhgrnhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    esughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EdBZaSM0LRBmYQ7uBJTs3Z-udbQNTyleLG2Kf_Envp_ViAKnEpT0_g>
    <xmx:EdBZaYkANV7HTtgdPLszE16AtX930NXBTEEB-qPKsJIfilvAQBY19g>
    <xmx:EdBZaW5LwZXr0IEXRk8JufNvAO-S-yNnBUj-Xsu3t5zmn8v1OqK8LA>
    <xmx:EdBZac2vBu5pjaQ0HLVmaA8l35Jdo0D0TomF4nGxkKv1p0_JUUC_Hw>
    <xmx:EdBZaU7O7LkPDXOHR3a8ytiTpbEk4tNNDZI1xwUpZJQ9uWCWj6SJji8H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:27:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Paul Tarjan <paul@paultarjan.com>,  phillip.wood@dunelm.org.uk,  Paul
 Tarjan via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v2] t7800: fix racy "difftool --dir-diff syncs worktree"
 test
In-Reply-To: <1e39f5d3-6b4a-f832-8328-f82ece12deff@gmx.de> (Johannes
	Schindelin's message of "Sat, 3 Jan 2026 21:29:45 +0100 (CET)")
References: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com>
	<pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
	<02749b7d-e9a4-4894-a50c-91a7c1a22d84@gmail.com>
	<CALvWuB79v3i3zU_g1swqQVS-fH1f-U8Ptr9Z9ObAUgeFJHx++A@mail.gmail.com>
	<1e39f5d3-6b4a-f832-8328-f82ece12deff@gmx.de>
Date: Sun, 04 Jan 2026 11:27:27 +0900
Message-ID: <xmqqtsx2p0xc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Paul,
>
> On Sat, 3 Jan 2026, Paul Tarjan wrote:
>
>> I've updated the commit and PR summary for your comments. Should I
>> re-run /submit to send a no-op patch or leave it as is until code
>> changes are needed?
>
> I believe that the change you intended for v2 (adding the "Reviewed-by"
> trailer) accidentally made it to the cover letter only, not to the commit
> message where it wants to live.
>
> Also, I would like to suggest to replace the non-URL
> "git-for-windows/git#5132" with the actual URL:
> https://github.com/git-for-windows/git/issues/5132. Remember: Commit
> messages are not usually read on GitHub (and some very vocal Git
> contributors actually refuse to use GitHub for their contributions).

Both good suggestions.
