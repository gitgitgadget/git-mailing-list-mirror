Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AF25FA2C
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239331; cv=none; b=qBQb/xtDIzmC+4eTH6DuHHiwx8j3ljpkPGImXfr9opBZuK5y/hUcKERqV59FzWLRWp0oWek79BhPnltXmet9frNTZ5BVVVM1L5VjVEqTm5KdVHeTXMyM+SmcREUc3YyDEsXE8xc+V86Qe4jvV5WKwLOiraiVQsIz7s7sdCcI0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239331; c=relaxed/simple;
	bh=ffn/QSZrdLSUyWxdV/hs7oFzw2d7tuHc0FRleYAR1ZU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LNcuUxbqYWk3lZzklJqEYm0WKN5Ns0igoqzVgHS0RMaoGNY9xAHzCCNz+BTJRGtJY0Jopv/IUwYEwpgGxfW3F9VIP4TSqjRCe91ZYOLtxPhEGjycdX2CKhkPBMzUi4tbZt4MzhrfOfCIM9wWXsb4Wr2aUYC64RC7wggWibMxdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AhELonJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5Kokkdj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AhELonJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5Kokkdj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C692AEC01E7;
	Tue, 30 Sep 2025 09:35:28 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 09:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759239328;
	 x=1759325728; bh=ffn/QSZrdLSUyWxdV/hs7oFzw2d7tuHc0FRleYAR1ZU=; b=
	AhELonJki7Pa+wkiRXRVc/LmST+NDBVv6V9B11NLBWMucjQGLqgxePecF1DCBiwO
	eeoeCSL636BGaimP+LEc540xjeQbpIQy14BvxzFU8LZoD/z04ggyhfatBhGpQB8r
	CPE/4wd9zZ9MGC5v3ipB3eR6ogx10yYz53/jSy0la7CQW9Mk9JuG/WcrmnjF1wv6
	3rfQZq8+2dmzH+rpVJ1tG4TUmoVRy3a1SXWSEg1y2/LHE1pqpk8qhyzA27t5O7WT
	Zvx2B69lW7zCSB/ODWQ4U/ZPRkDbJQ1F5grRoi7XeZ6xCG1sIKvBjnmu02Z6x2g2
	0J4Tvz8yXkoLdVmt6wUZhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759239328; x=
	1759325728; bh=ffn/QSZrdLSUyWxdV/hs7oFzw2d7tuHc0FRleYAR1ZU=; b=k
	5KokkdjX9T/7kPYEkHaScKet6JzEcdKd8hP8UDXW/qURORTsCq/FgZsjVKPT0r/r
	Kq3Zmt9FGDPxu3dq7UeseJIehJ0labF3R6BVDnyO1uaX6HHAxdyU65uiSErX5lIP
	3SfmMkb3fDlkk4CSnfTXirVstt1B4trqNBF5cCTkDIqg+GkphgBnoskdvwPC9Q7f
	9I6u0ohGr8yrsT1ChL9CY4fs4lzcY3ZDTiLSoT0FOSoiikTsSs+zYrpJlOLOSa2U
	qpBDQEhsuQn5E+lWiMsXxdY360hhcSMDgX+5+2PnBCdCfGxoVnUbcvPkEjRsXYnz
	0vgNlhKijS4tcCCAf9tkg==
X-ME-Sender: <xms:oNzbaG3fBJs-XXVk92VqRUeB1X-cEFYKkj4eTf4nmC19u7oUJ11ew-M>
    <xme:oNzbaD7j2bunb_GS-wWgn7m5BDOBrKq3VXLdcMc4YtbtHtjZuqBqN_10i8ovJY6Ul
    1tZMXRv7-N0UT-1Ik7eenQYyhMRUeeF2pJ7fqT1lECTHIuU5GktXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurg
    hmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:oNzbaFgHNVFzLlz8-q7Fp8LiJ3AFcy8N_HKRIP_RTmn_FmBj3Z0xsg>
    <xmx:oNzbaIS2xa9dZZL9jIcecgqSNqj5REZFXJcIR3eOATDndYrGg111uQ>
    <xmx:oNzbaOaRJyqIoX1BgaNx5TllRn4jW7Z8k3zhzyXsu6HhAqW5HqcsfQ>
    <xmx:oNzbaNSV2mpPCEz0OOGGyghxzS2RMxea77Es_xaO6Q0gCINpEYk6Ag>
    <xmx:oNzbaF74mb7U_hESbTHiQkF8cDlGmKllxNIXixa9sPf36z6AiqT4C_Kp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3ECE11EA0068; Tue, 30 Sep 2025 09:35:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArZ3LpZit0AR
Date: Tue, 30 Sep 2025 15:35:06 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
 "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "Aaron Schrab" <aaron@schrab.com>, "Jonathan Nieder" <jrnieder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Josh Steadmon" <steadmon@google.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <9c313e46-805e-4b10-b8f9-6e2d5bf0ccf1@app.fastmail.com>
In-Reply-To: <20250908140117.262205-9-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-9-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 08/10] submodule: remove validate_submodule_git_dir()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 8, 2025, at 16:01, Adrian Ratiu wrote:
> The validate_submodule_git_dir test is not very useful anymore, after
> submodule names are encoded to resolve gitdir path conflicts.
>
> In other words, the purpouse of gitdir path encoding is precisely to

s/purpouse/purpose/

> avoid such conflicts as this function tries to also prevent.
>
>[snip]
