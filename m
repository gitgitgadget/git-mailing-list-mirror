Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9971F428F
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239354; cv=none; b=BoNHz+99CKENmoDCDpN6X9DWr335IHoY27WsO0mCoSeSc51LP2tnq0pi1vA3I3s2ZmYaOc3n9jdpZ8w1zwKohUoYQhHNc0nMvKGx0Afo2pELlfSA5qoPT35rBgsWCHADZhmHGu5gPsBsA9T2rLsJ1JeeivWnxzz/2u/Hk0yNA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239354; c=relaxed/simple;
	bh=Z/QhYXwy/iS8S7CbxVvmfxl5Ra7KUGPAfplqCzd1DM0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vDPf1iClIYq/jF/JGvDsepWn6ZT+o7P/dWcMPUN9nWp7SLbEUjvZk858RmDEEk1ioA4A24AmUQXdc8qdrqOA6UmanLTOyswgdGl20Ej6nPBAuCbUN34pgYO7j95foJaGWHpUg1z7WoM46veFgiUbKQ039f2LqZq9u538hoxBNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=s4M6hLNZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGTns5Dk; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="s4M6hLNZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGTns5Dk"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7E2F1400043;
	Tue, 30 Sep 2025 09:35:51 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 09:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759239351;
	 x=1759325751; bh=Z/QhYXwy/iS8S7CbxVvmfxl5Ra7KUGPAfplqCzd1DM0=; b=
	s4M6hLNZLinS1I6bjnpdS5CeQoEvTjxaHcTBGxzulVEtLG9jRHzSvKXD1ky5qMrq
	YJRVMj/ro+W+IdSwBwonbRmDC77u3Uhvvr1ExmCBdNh0FawMkqSLMcvv7JdjeytS
	FALwcXxE8vHmwf/mKUfdDUm//2fyyoQksHL4KmBJ1k+7vOmNlVL535ji1slVY6/d
	mn0/AGYBMFSasQ5Pi10ABacpeZetMLc8QqGadXPdt6XVL9kXSNGeFybUWts88pZp
	X8ugCq1OWLmCmigNr63xz6c2/DAYUBkE47Nm8sgn6pp+3UJF7DpfG9ODjvseKD22
	rofPLSd2EsLL5TXeulJ4tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759239351; x=
	1759325751; bh=Z/QhYXwy/iS8S7CbxVvmfxl5Ra7KUGPAfplqCzd1DM0=; b=j
	GTns5DkZ7bJTQqFmY6DEBeSZIXuTHCrUYbVRB7E3TUQQKWwDRXd+fwkNjDjC9+6+
	eru9V2l65TeGSk2KcRDJi0ZAaNh0O6uRA8N1y6AX1lyPstdBJOPKPIUmiblZ7OzH
	5gtgFpDL9FY2IrmnhRyOErMmCbtHE5JpsssTeiET9v60DkH78UKnSqg1+QCArw0C
	GPJK7LFiXMp/5yFS5R+LpeLPIhxFIMkYPB/JjPzYI6GSepS8HTJfZ5Ydu9Af/aDf
	Oj5Y0MH94StxNdV6YKymWrdFCYN5xJq3DiNVtXS+hBmkjyC9XdtfMkXxMMoAK5lf
	r1buc8VwxDsoUzJGwY17A==
X-ME-Sender: <xms:t9zbaM8_-w_MCBPlkRLyoTYmG773FjPruLZW3er6ReZOTA-Eu22qsTU>
    <xme:t9zbaPj4sLks-k96iV2tnKMp4Z5p2ydDWDJdpZXRBemCfFYKnyRf6hVzU_nX7U5mC
    mQa7eLC9yCKIaD3WT1nfJeOql1XeU7C7XrpqtgmgSLXhYjZTNT9hL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurg
    hmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:t9zbaKpWHcJNeZVAbf6lW3HRTZJRFpn97e7lXyStl6TjWk5L66_Qbg>
    <xmx:t9zbaG4oi7W9_4bF54TLUvkG0chId_LBhbr61X3ANvsYva0K-UG9Tw>
    <xmx:t9zbaIhOSfN7WlEMycr098i6bkGOzTR4G2fhttsBi6zr9qV3lVo_sA>
    <xmx:t9zbaM5yCb_Fd6x-osjFq-WhZaIsHM24TPmyZUp6_aATAwDB_uH14g>
    <xmx:t9zbaKAsE7kfuUGFGnd1_Q1lgIVRubwRO4PwkJqY73Y1sHeeMf7OFhMj>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 829161EA006B; Tue, 30 Sep 2025 09:35:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADRNujeHYqDZ
Date: Tue, 30 Sep 2025 15:35:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
 "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "Aaron Schrab" <aaron@schrab.com>, "Jonathan Nieder" <jrnieder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Josh Steadmon" <steadmon@google.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <b723d8b7-5c17-48fc-90da-ad2173d9ce79@app.fastmail.com>
In-Reply-To: <20250908140117.262205-8-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-8-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 07/10] submodule: error out if gitdir name is too long
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 8, 2025, at 16:01, Adrian Ratiu wrote:
> Encoding submodule names increases their name size, so there is an
> increased risk to hit the max filename length in the gitdir path.
> (the likelihood is still rather small, so it's an acceptable risk)
>
> This gitdir file-name-too-long corner case can be be addressed in
> multiple ways, including sharding or trimming, however for now, just
> add the portable logic (suggested by Peff) to detect the corner case
> then error out to avoid comitting to a specific policy (or policies).
>
> In the future, instead of throwing an error (which we do now anyway
> without submodule encoding), we could maybe let the user specify via
> configs how to address this case, eg pick trimming or sharding.

s/eg/e.g./

>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
