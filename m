Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654524BC006
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008117; cv=none; b=jHBsFQD40zFuz/fiFt/MqWRC/mIKjNqZ9s1hGwe4xJ9wC1XxRkMLO4eQivkttMS6+k5ahZa4UHsK71/fnsySWTyclz5wW3Rbsyf2ejBNhBtpo6HMSdqN27EqpISk9xvnfNKUGdcd/wVUO1P4VAL1Ag9c1s8d/Gu3oFv+isEKMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008117; c=relaxed/simple;
	bh=U7K0IYaz7fH8zEILh/l99KgbfE7keXoy06EH2Eqxmd8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bwiRKHbu79HsLacx4CbPQS4ssaX5eLD7OqD5Kg+CAVWsdYEyqTBlHpT7cp9N6opHjkoJxcANA1fK8dO+a9LdxpCMYeazHOKVgvshmoKR4pNljj7ITdyGZpiGL0ExdEfftvrSohk8CPWrjhE7SQJBBfc/U1gM0C0XJKs2voOn+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ELj00vp6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFS60/L3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ELj00vp6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFS60/L3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 73FAAEC0148;
	Tue,  5 May 2026 15:08:34 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Tue, 05 May 2026 15:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778008114;
	 x=1778094514; bh=U7K0IYaz7fH8zEILh/l99KgbfE7keXoy06EH2Eqxmd8=; b=
	ELj00vp621VAve5aMFccCxnSdIUOgscVjJ6+pXnyN5T7PNImbdddRbHrRS8AmZNX
	ZrVogvpqbG7ioYVdt9p1y/V7WxOodWRqjU2mgNTsIbmy3LaaBa0t5rgY/IzLL0qG
	4cN/Ibgdc8dCzlY34NjxGtcho+uwjc4fUOg8CubInhHjPw1jCt4LoHxso4wSG23q
	zg4eC42q4y5f0owARFPcbmV4KF8H74k+Tbq41k6gRr26yU+tK9K3gMkvAlCve1hV
	gxMfQQQjoRENtKRQHvBSCmPBgZ2I22X+iWsIuZZOn8Te+DWpDrtGG2s2YTb1z/56
	KYDB5flNAoyKaDEfD9eB7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778008114; x=
	1778094514; bh=U7K0IYaz7fH8zEILh/l99KgbfE7keXoy06EH2Eqxmd8=; b=O
	FS60/L3MeIzudgauirbPvmgwE5HXUBHc/Q7jy0FZHgUytFFiyHfKs+ma0XvDlqza
	04GBSTW0S8DnZNGSQGuHUbkw6kTDXNYP2iejVGiG9swSfVqWIo33dmHypzyjIDzk
	cwhZoz+DNdHiNBIiGqc25ZEq474WKmtDlLeB5BsA5Ul3k2rrtGp8pHKMMYE5bzRm
	6ScB/lI6En+lVi8F0bbL9sjO7oSaV71CCyt3cW6GqYaQHr6tBysQvq+TeF6oCkaZ
	RG1ZS91dll4efb/p1F6S0f1tu1SVwixbylvrEdsa+hvKNFcVnKHXglnBTT8Hqfwl
	LfUP2sxIhVZatFbArScbA==
X-ME-Sender: <xms:MkD6aZEInjoeqE74NG6kVObRuJ7uJbH7w5-tjW01lJzLPFcQasI-i-o>
    <xme:MkD6aZK_NnCLpiEeJuCWljZ-9-SC88d-oGgTAKHvid55iAKCu5Xt6I3pC31biBFcs
    cRplt_N65sPod7F0GQuA_dCcnBJcfPkjVFWq6blsCYE1kkaSPT75g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeel
    uefgleetffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnrghtuhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:MkD6aaBtcUYAjv4rnx04FFopY-_xp7asJlAN7Jdz6ekpYJ96KYJgAA>
    <xmx:MkD6acTwE584LIyFtxSxDj6yb39lBwSGJhMneVFKfRUpRq6PJTtzYA>
    <xmx:MkD6aQoX3_x0d75-j8QI1wodRu15XIyZiaXKsEpmtbi-pfYh0ru3wQ>
    <xmx:MkD6aWxMeQ15JAUcGRNOGDprcBzxDHf7oeClnDy51kULb00NoSmswA>
    <xmx:MkD6ae0WrIPm-tWfGOjdvhxqpRVwo3_wf1giBsidz-3IoDqJScyJCcrt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4C8ECC4006E; Tue,  5 May 2026 15:08:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-WvsbRyvEH-
Date: Tue, 05 May 2026 21:08:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, gitgitgadget@gmail.com
Cc: Shnatu <snatu@google.com>
Message-Id: <a9e71e67-a853-4cfb-beb8-69b98ead720e@app.fastmail.com>
In-Reply-To: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
References: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
Subject: Re: [PATCH] Makefile: link osxkeychain helper against Rust
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 5, 2026, at 19:26, Shardul Natu via GitGitGadget wrote:
> From: Shnatu <snatu@google.com>
>
> When Rust is enabled, ensure that the git-credential-osxkeychain
> helper is linked with the necessary Rust libraries.
>
> Introduce the RUST_LIBS variable inside ifndef NO_RUST block
> to hold the Rust library dependency, and use it in the helper's
> build target. This cleanly handles cases where Rust is disabled,
> making it a no-op and avoiding any build failures on systems
> without Cargo.
>
> This addresses reviewer feedback from internal CL 910223487
> by simplifying the variables and avoiding confusing "LINK"
> terminology.

This pararagraph is meaningless to those outside internal.

>
> Signed-off-by: Shnatu <snatu@google.com>
> ---
>[snip]
