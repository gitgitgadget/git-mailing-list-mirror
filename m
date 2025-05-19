Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579C12857C4
	for <git@vger.kernel.org>; Mon, 19 May 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747679176; cv=none; b=ouLSeX3wl1hEs0b87ggslKr8whJjGmzTN9/LAz/qTGiic5gOCeSWbBPPdXlXjgsEXjzoxNcRbVIMIyteN7Ea25khKAYGBlVK6pJoXVkORFBt6pBRZbDlzgktUnyiFjRj8MopBnMM6fWRrj91xBPEn8hDdc+OHymgiy2NJ7FHD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747679176; c=relaxed/simple;
	bh=fN15M4HRCnNZ3jq4DEqpSMOM7aA2/hw/p+yGUsq2MKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pV0jGZqQcuOQTAyYkOHp2GTuUY+Gn6ZrNxhczZaVAwskpXwqispvk827wKSF/zH48UH8yUzph6oYvZMPV9veOzpj6SmWkGXsXiCyGyNKm+5aA8gL5hQNpD8o9DUXaBoLfjKzH+w9xWcDeRILZWDVarQQp5T3B5248ZifirxmGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pjmN51+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXYR41m9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pjmN51+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXYR41m9"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3261F13801FC;
	Mon, 19 May 2025 14:26:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 19 May 2025 14:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747679173; x=1747765573; bh=Y3vCwFY/lr
	lxOe5nPolPfkee34A0cFcYSks2Rky08I0=; b=pjmN51+cKtdazoIazAXYjz0Bbz
	VAAZpjuZq5lPwmQ2Ti3PvH6ydf4GLB/OdjtM4qqEDh90YtVc6mFsvD2CSc3LfP01
	mmv0Y5IXO8VuyOz73Pz+uTWIws8b/ZUplkraKWDfXgxFbpV9CJoVB7YqDtq2p9rZ
	PBkXCQjPAK6uEf7egZnBSBSHjtlcr9Y/DvyMK3U3Lv0ZTPhtiAtUymOmO0nKOfuJ
	FKiFvSS+5zU7u/dpidJGwjsc3OAAEoQhbyZ6Mdb5Y80FRXipnybcyiRIfwdGmCbp
	s6ElUoa3U5xySP5CN5YKIBN/5hI+huWRREjZC2UWBrpSuNMU4g6GK4HayLmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747679173; x=1747765573; bh=Y3vCwFY/lrlxOe5nPolPfkee34A0cFcYSks
	2Rky08I0=; b=MXYR41m9c8QZpS1pXfVIDBSRloQIwYovnGba3aMPMawBzDLc9Q1
	UInhw+u5WYjBNZuHOaynNxsbHVicF4hPaewszBBzmsCB1cUC/wuZ/Yl3cdJQxuf6
	cjpS0OsBim3IJhu0np1YEPVcg3g6wzA27fDeXY3X5KVwhNBGQ5llHfM/r0R1QsUP
	qZZUqq2muXTEvwdm1/OI5EMa7GUpX7uqlPH6+uTMpfjdnIALMV5MOKVgRvJoSvf5
	pYglGgv24YShxL36QoJxwIcgDZ0ZBLjgl7kz6Ap1VLVpuR8eBt51vvpjSd7TvECV
	e/wbmDsatFR2Ne3iVpiWRSr0fpOhmaxAuFQ==
X-ME-Sender: <xms:xHcraOEIQjzDma9aImY5zZZJJ6U1W0iUVOAwTT9udjtsAQMegXMc1g>
    <xme:xHcraPUJepEAoS2PQzhM8_ZvWdbLxF2pGd1rxlfBvoDpuv_sAV5JFQt0JuRMUL5R1
    3uDk9cFjoEoQU7Rww>
X-ME-Received: <xmr:xHcraIKzJDE_0QNE1TNU3ZnEF-KGK3wb8FaSj-7i0ZQFfyb4V_tbSKMQBfv-t20bYX7LGydUiZ0Nyz_MVrqh68r4xMRmaG0lDim1Ue4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorh
    hgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epfihirghgnhdvfeefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xHcraIGmomICDszRCYfgCe6ykrDa_WZcJe1pN-6OH-1dm8jI9J5T4A>
    <xmx:xHcraEWPCLqOM_AXsO6lTprQqdamsW4XHauB3feNLOQVRDEy0pgzgw>
    <xmx:xHcraLOa31DXfUSUoKlseOMMTUxEUz9QEthSYuBst3aMLwgQnfG4SA>
    <xmx:xHcraL1B051_-j7NzhRt7CTDoeEbCW5nV7MMDU5yrfnPT_ZBkCzHww>
    <xmx:xXcraC7rmaTqYj9FbgSjlVLR_Ao8LOQQr790cPYsNtwHcklrZHI4ENDv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 14:26:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 0/3] docs: update email credential helpers and
 improve formatting
In-Reply-To: <A84F634C-3423-48E2-B648-068A75423037@live.com> (Aditya Garg's
	message of "Mon, 19 May 2025 12:51:19 +0000")
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<A84F634C-3423-48E2-B648-068A75423037@live.com>
Date: Mon, 19 May 2025 11:26:10 -0700
Message-ID: <xmqqsel0mp8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> 2. The second patch improves the formatting of the `git-send-email`
>    documentation, making it more readable and consistent.

What does this series build on?  The patch apparently does not seem
to apply to any recent tips of 'master'.

When you are not building on 'master', please leave a note to say
things like:

 - Because this breakage was introduced between Git 2.43 and Git
   2.44, and the area of the code hasn't changed since then, these
   patches are made against Git 2.44.0; the result applying this
   series there merges cleanly to 'master', too.

 - This change depends on the topic, xy/frotz, which hasn't been
   merged to 'master'.  The patches are made on top of the result of
   merging that topic to 'master'.

I am guessing that this is meant to apply on top of a merge of
ag/doc-send-email ba998f61 (docs: add credential helper for outlook
and gmail in OAuth list of helpers, 2025-05-08) into 'master', so
I'll tentatively queue them there.

Thanks.


