Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFD4D8CE
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239488; cv=none; b=QTI1p57jqucTAJ/EQuQzNELKCGFHPPQ1mAX2VyJMHw2Ndg8VxY3FoA/seJV8WS2Pnra3tG2eZfedCFS5fkg/Y/0K6mH0d/jVDIN/qJ2P+3zIkc3pXDBqgMNfbG8iKICY+Zs8wicHn/BX5dHvK7lzSV+dSa+duCJvCGBoPpIXbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239488; c=relaxed/simple;
	bh=LQrkIHUKs7czxHhPjhLlpgROMUz2uGP0heDddNxI5So=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Lith2NFrbDwD7i/5w1R2jOF8IoEFdod6sEWB47kgIsY1ZkN20hkEXNJn7E4jo4KKlF9yDCnRWl2f58XmgJxOEl3m54h0VI6RVMgnEn84j1Tbvi05c5ZM50EReAiicWkwmG075n+bv5MQvrdH/F6ejfGKyxErgQmmmT9TpXYLXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DbEN7jCK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2lF577o; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DbEN7jCK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2lF577o"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D045CEC0011;
	Tue, 30 Sep 2025 09:38:03 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 09:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759239483;
	 x=1759325883; bh=KeKER9tiPxGxMhXsMBBhqTYnOS+LN1jGGimIj5l1+io=; b=
	DbEN7jCKrRFtfochUBcAl737JKXzR2yg8ZXp1YqxX76hXcKpUtlALJHf3ouDnHsY
	CjErPAL+CDiePbA17QNNpc58soGgNJKYgHuqDPO3O8BTPtkXeaQg8zPoik02ba1z
	aSIjI7JEdwIekozwCRGDnS29r0u7n2Fi9lWTeOqg2WECU9Lok85n16na6gwXod6x
	zy7xDumBhEWXRP6meaxs6hdVOeF+DFLlER6NCUhksC4rBTs+xNLXriByUCkTmEby
	EGLJCV2ESHA6NVIlUTgGHPBAFXRcJ1/LbVQRPGDEfp1jCK6udWMD6Z5kabx/f5sn
	TCCpocMHMPxp5sF9tSiQ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759239483; x=
	1759325883; bh=KeKER9tiPxGxMhXsMBBhqTYnOS+LN1jGGimIj5l1+io=; b=E
	2lF577oTLEp8leSnjTTu/EKml0f3MnOkSNPX5sPGs9dEKfPihyUx0+LqneZea7Cb
	DEYfsL3VPU4MAWTIb+Hm/emL3Yvnq86SjwYuG2E9a2P9FciI5hvt3eSMK11ob+E1
	hZ4v0j8JW0WeCeA3EyV/VLz6xgp6o3oMR5BdI5iordPIl1u5+fdIZJ0qK/Pv53QD
	zMS89e2wjUoL3V5v/5Ipy+uKu9vcGtQA3ipnTNFxaVrRQODJcL9QMnVcTjcZPNJI
	kUq88BjS9FBPuTQaNfHpL9GmRCHpNESDcUhCKnggf+lweOk8WuG7IMxYJoR5p3KH
	xAKHnywlBPWJZ/dY9yCPw==
X-ME-Sender: <xms:O93baGG0-GwbmWRIYDoHNSXn8X5eYSU4C118-ak3c8Ru7mXiRZXH578>
    <xme:O93baCLH7hqG-fQvvzruY0rcwWvWRQifFie0isJH_U2DfAF9dT12MaHeTj0JNrEoE
    qr-noPsLtuqKbwNFfcKJnX6OTfB7ublkTiWAgUri1PyKT3dIDpJPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurg
    hmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:O93baKzI7Sx-jo4A5nQbg3WZU45ULNqWbdliO7ExY0Ch-edk-Nd0cw>
    <xmx:O93baEh_kUz2AvVBQ11SFK4AGSc2EYU4D6SCj3nAHnmbHAslt-fzsA>
    <xmx:O93baFol_A93PqSuN47LA9KmcR9sp-_ru1Brw3FOyDTpBHg5NQAQbQ>
    <xmx:O93baDiWx8lAWbBPDHXOvFMMYHnJ2MFrDT1fSd6bx3s10mVOYOdiyA>
    <xmx:O93baBKi1S1QjtL2UFRo3CnT8LeC5n7AFmSqn9U9MOZVc0_uCS-L1KuO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 47DCC1EA0068; Tue, 30 Sep 2025 09:38:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJxEN4ILlduk
Date: Tue, 30 Sep 2025 15:37:42 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
 "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "Aaron Schrab" <aaron@schrab.com>, "Jonathan Nieder" <jrnieder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Josh Steadmon" <steadmon@google.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <6a7bb99b-68f7-4120-9ee7-d4efbea99243@app.fastmail.com>
In-Reply-To: <20250908140117.262205-2-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-2-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 01/10] submodule--helper: use submodule_name_to_gitdir in
 add_submodule
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 8, 2025, at 16:01, Adrian Ratiu wrote:
> While testing submodule gitdir path encoding, I noticed submodule--helper
> is still using a hardcoded name-based path leading to test failures, so
> convert it to the common helper function introduced by commit ce125d431a
> (submodule: extract path to submodule gitdir func, 2021-09-15)  and used
> in other locations accross the source tree.

s/accross/across/

>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
