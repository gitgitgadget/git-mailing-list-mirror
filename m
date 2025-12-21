Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA93A1E8B
	for <git@vger.kernel.org>; Sun, 21 Dec 2025 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766284759; cv=none; b=nXi6cppowsXyUzcmlLWu+w9yttRbQO/zj9RQUBHzwnNIbQIIS6pXqkYWoLFm7UUvOO0/vzyPnCE0gXGzQqn86lGCVfgwtYpbbXcNDjo+HN5jRYG4KlSXL90S4kAkQKR2tG78thJKYpW7AwYlcGQdFrB01VZ1SRxhdGBunNKBEBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766284759; c=relaxed/simple;
	bh=PzE6GOIjYBSbEnq+JOJprPB3kD9JY1zaBAuOAaDD8Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYCzkfO9WvRGx81TDbfSiKv8+R+oWl5DyyRg3bKeAKxHsMaz10739iBDz2YDSIDTVNucJSSJlrpUNmvbq0rxFajd0luppbYSIQCmBQX9QGyFF97/mL7edjJ2TF5HsbX/ZnPucA9EiZNTQ1RWSByt0coRg+JGKMU5W+4dRS/U4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LbwvN5t6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBc2YMjd; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LbwvN5t6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBc2YMjd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 39705EC009A;
	Sat, 20 Dec 2025 21:39:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 20 Dec 2025 21:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766284756; x=1766371156; bh=U8CAZy5g+k
	tsQTVcBWWV1cj/1egZAOIzwaoNrpOz9MY=; b=LbwvN5t6Opr/jk2O/AoEk+SHP9
	lfAYjDGaE37Gq+SNuAR3jumxaGlQhQlKY3wW3i1BHwkFi8qS5pnVYaATcCeKM9ed
	DQLLrrpewJ6IHiI1I/lAJSTs4wICbEUx3HBKD08k3pgMVX2g+PJrHikCSeH9hUZY
	RyB4dvAEqcKXY7+0P71T1CqWN+mPME04Ljq1xvE3MDRoSROXtMs5r4EGLh1pLc24
	3FY1J6oCLJtVOoYxwjdkrK7TQaPpD5uKpBTijEcbwsnwb/F/h6Xvy6AjD89cZWtj
	NIjjac4PjpbvWpvS8YeXifg+Fbwj4OorLaxv0R7zu0UYSfRkjANx16Eg/IRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766284756; x=1766371156; bh=U8CAZy5g+ktsQTVcBWWV1cj/1egZAOIzwao
	NrpOz9MY=; b=aBc2YMjdMbzBNunzIF9OFcFkub/YvrZus8ka/A0DBsHue3/mUXT
	SvNRa8CeRgfOWtCT5Uz6eFueua/VrGJibCmazM2Vj/UzUoACmdyLRXrtztiOoO17
	OoCaKUzIPCfkJWBJahrsh7EciMZgNRp4++yN5mWVvUz02ToZwCcMwf1c7yk/HVcR
	io/7usBudLwzm0Nej8JnJSuHx1IGPw0OBHDGN3qnWRcRSh2I3YfX2q3CC3+XsSW2
	WzUFruLo9EtPsuv7GF/H3u+LVehcnMLeaMub1DVuiYUoku7Qrmc8zn6p7Au7Pbhi
	qY52TL0PyiM3V8maWZi7sileDHqqdskQntA==
X-ME-Sender: <xms:011HabGu3sgUdW2CvKGdvSMAmZbj48wDWJaq7tZ6IWWBWGF12w0H1w>
    <xme:011HaULSIN6PeQCnNwmYXevBIvpU4PcdLvl8Wk8Xc71Wp_gDNYJ4G7FPzqyHdIvrm
    wh02ZnBRimVfqP8X-9SIe6K6dq30aBJdfLQLJVaMSI0heNIS236VA>
X-ME-Received: <xmr:011HaYgLCurJaGWoDTd6qCL8NP1-wqQMnJLIe14SaliDtXgZY70aN_rehkuzUR5QQkbnPsS-0yqEyhBcZttMg-iyrfL3rfZlzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehvdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpth
    htohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:011HaSlWsXCQhNHPQ2l_DekiA1UrSBJcclAQx_Ml_w-w5D3mV7ONIg>
    <xmx:011HafUbQZEL4Pu37CrLvyfkD2hwWfofB_vLCBa8uHs41wgrsE0eqw>
    <xmx:011HafvWsb46HIPoTbcIMJmB-1GgnYTe6K8NhZOsEwFVbzLTxX8xkg>
    <xmx:011Haa4Y25ta8kasuSNXzs-Tj1D4FKbHQVIoi-KLiqY3mnYojCOnFw>
    <xmx:1F1HaXiM_hCqFS6PoGK76WVC_w9G1y-6sG0X83qjV3kyblo_U-NACVr8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 21:39:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 00/11] Add submodulePathConfig extension and gitdir
 encoding
In-Reply-To: <20251220101528.1227487-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Sat, 20 Dec 2025 12:15:17 +0200")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251220101528.1227487-1-adrian.ratiu@collabora.com>
Date: Sun, 21 Dec 2025 11:39:14 +0900
Message-ID: <xmqqbjjstv71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> As always, this is based on the latest master branch, I've checkd
> for conflicts with next/seen, pushed to Github [1] and succesfully
> ran the CI [2].

OK.  I've queued it on a bit older tip of master (namely, where all
the previous iterations have bene queued on top---this will make it
much easier to compare the iterative changes) and they seem to apply
cleanly.

Will replace and queue, but due to family reasons, I may not
immediately have time to look at this or any other topics much of
this week.

Thanks, and happy holidays.
