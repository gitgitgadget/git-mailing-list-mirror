Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264B2E229A
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397201; cv=none; b=tU5IQfRDZalBCh0DYRQhDgI5QrfE3YuUnairpNmSitsK3B6bGXTYquGcmpX+LGLZ3i1xhr24JCI9gv7QNTi53HctkLUwJOeCI+y+o5bQ0HXZw/FnY6yeZxHbtdqpiONys7VnhT44H1udklkclL8PJ4bFW+xnQX+0kV9xWlOJZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397201; c=relaxed/simple;
	bh=Uyq4IG4IA7D06EfQKNWvSxL89UCZgJxPDL0qyNLyOZA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rOVnpmBBxF6WfgTMqD+7SotGBoXXwaOvbpvQZhzykoDCWdZl2ey/6wrRA7fX1JcoU+APf7TG22dszbAp3ypWHT1ku4hLY43N9OkVjhi/VgpOweXQ94wKNCF2OfXKIj+wk/yIhkz3R+Wt+nwD9t3T4olR5UcueuGWJZiEW0EufO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VjowT1+n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kPlUIFPQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VjowT1+n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kPlUIFPQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C0D97A0127;
	Thu,  2 Oct 2025 05:26:38 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 05:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759397198;
	 x=1759483598; bh=Uyq4IG4IA7D06EfQKNWvSxL89UCZgJxPDL0qyNLyOZA=; b=
	VjowT1+n9/sz/lZH+d43MDZO2de1r1cV45OfnNYDTWp1DujtirW/q15oFKv8Utty
	hhJ0eS/Qv8XSo/PNkDK5ymxJzlgaZ21k2sG/OXmmK8o2i8Qe3ApI235hHpEU76xX
	T7a6StN1kqbTs/5yoj95rylOQO5SM3+mg2fkCULgVBeIDv3lcKybQXVzBGkEj5nl
	1eW/hcyvG60HMsy+JlimLwrzt5l7YMlNquMq2h0A/+oF9IQCFwog8uk0VI++Q9F9
	T3153VfiFine6XD0lbmOnsEQ62g1Ik/PpvB631BJGuet/6PhykII+gxBlYtvDjmX
	T24oK5iWcHFRAB9qTX6yyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759397198; x=
	1759483598; bh=Uyq4IG4IA7D06EfQKNWvSxL89UCZgJxPDL0qyNLyOZA=; b=k
	PlUIFPQhKvPadPTbwwLMeiaazHJYakY96AzwpwZFnRb0HqE/kCTXz9m9mZrW1kgd
	oXyMCIKdv0Hj1AbgA+6QBsEntS1yVMDWx5sQv+eorNSob1Sn9F3zfoaeLyF9qy6D
	g1IKeyrA/1ipGryXsg4NaSzktPB3WtE72bjXgYe5YlkXol4S3dJYdmYeroxp5QwT
	wxmLj2AfbLhOyvlW3PAkro50KLAytsK78MszFtR9Lwz96Ao7ib+RP0Y8qf0gsCJ4
	GaoUlAknx4+C67TeW4wgRvsw6KVZa/40oLRaiVAJGzh6EZxq5aHRkDzWxI1Q++V4
	7CfnPwj+donhWgxxCUqrQ==
X-ME-Sender: <xms:TUXeaA9_VUe40LnPMpmIZVh93exZQDf_bozv92O-8QC1FG8bNUOr2uc>
    <xme:TUXeaDhn8S7O93kbK711EgXZBh1ZZQet6xCx-wQdCDDExjXrGjx7mUk0wDe1dBMM0
    _XMsL-OkzUybd48OKBsJaAWK07F1tK-wL_qE4pYtI7Qu7JFxOZe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TUXeaGR80wO40RdLCex46h-NyQoYtJTidom28A5Gi1O5uVOEh_pvUQ>
    <xmx:TUXeaFzs5nvLbSAlAO3GlfS2yI9oHlSpZ0Q2qdZ0JIGbWD3TGodXbg>
    <xmx:TUXeaKfZuw7sZ8fI4kUy0B2eGJG4-WGCYJOhMDiNIrX-fUl22KFfxg>
    <xmx:TUXeaAO0M2RG9xopoOGYmSRF0rYGQ2GcvDEBNb5FfCvCyWdTsCK5xg>
    <xmx:TkXeaB-XF_wWMyaXGIuhh8cxa6d6z-aMDi9Q1riCxScFjG-PMDS66c1i>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 638D81EA0068; Thu,  2 Oct 2025 05:26:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah__Euhwd8KZ
Date: Thu, 02 Oct 2025 11:25:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Sergey Organov" <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <e816989d-bb45-4696-bd2e-b1ac6c3fa312@app.fastmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-8-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-8-8e61ddb86317@pks.im>
Subject: Re: [PATCH v4 08/12] add-patch: split out `struct interactive_options`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025, at 17:57, Patrick Steinhardt wrote:
> The `struct add_p_opt` is reused both by our the infra for "git add -p"

=E2=80=9Cboth by our the infra=E2=80=9D

I think an edit to this sentence got mixed up/jumbled with
the old version.

> and "git add -i". Users of `run_add_i()` for example are expected to
> pass `struct add_p_opt`. This is somewhat confusing and raises the
> question which options apply to what part of the stack.

s/question which/question of which/ ?

Or: s/question which options apply to what/question of what options appl=
y to what/

>
>[snip]
