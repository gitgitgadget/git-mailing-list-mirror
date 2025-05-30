Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672421898F8
	for <git@vger.kernel.org>; Fri, 30 May 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590915; cv=none; b=HtKfAmT9qzZz4oVu7pzyc9cElDW3PvjqFko18SIjUrBtvBFiUdRQcp9tTjYFy39ATaJv19Qg8R7oAx6YYe+rJVVSjGpg+Wxh0F53Ku5dwOwFSFTpJmdLU2S4lFWzAAb4kbitLfa2RA2i2dD7iMSQTiRGKBT/L+GoES3tByv5eLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590915; c=relaxed/simple;
	bh=gHgOMfVkqXw0Dql5MSDci+763r/mxjc3QcyDfDDUhAM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RvhynIjrS6FPqu5UZ5KxAuUvqI0ExXTJqiJCr2Cq+H+8DU+fjiOLiIO+Q5yoqDiM4H9CmZO+PaMIAxsuB0QpMIZaBkzBdmNQCVRDjRNbeS6aRzeoXW1ikd3XwUrzDSga5lSSdmeqNNejd1reho/a4wXw8etG4xExJWi1Kgou7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=H4ybUpYJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fu8CPO5G; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="H4ybUpYJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fu8CPO5G"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3735A1140188;
	Fri, 30 May 2025 03:41:51 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 30 May 2025 03:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748590911;
	 x=1748677311; bh=gHgOMfVkqXw0Dql5MSDci+763r/mxjc3QcyDfDDUhAM=; b=
	H4ybUpYJ1w1HqfQUOepmrws26LmU7AtV/1lxWoRjcuxQafWMC6E0ZpED/zhjs/EJ
	Hn2LBSnSuAUGX3t1rRACSI2yzY6JkW2GlBFUoi1MvoobgkXs7SHZUd7+xz/EKmEA
	EPz5aQnTqY45BinYcby8vVue22hVrl0WiPLYsKJ0nQvBKsVwaNBpOioPdy5Fe9t6
	wOSgeYspEur6e23R5N27U9/cpqTFG9Q1CSrMlAxvSHv1hNRsOvh5LtsCAXZOjMTk
	fJ7skBvCh+pVQzeHAGkkvs7+ZZZ2WebN728dkbrWYAURrwXvQd8xrl41MzjkXZWQ
	qd0b+tW3fn8Ua/f7xoZdrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748590911; x=
	1748677311; bh=gHgOMfVkqXw0Dql5MSDci+763r/mxjc3QcyDfDDUhAM=; b=f
	u8CPO5GWH5jHT7b0HtgwyCLC1W4nswOCHB59zKuDzNr95TnkrkeC23A0iZanFuMv
	U+tfKr4kHK41eR3OiseAaaY9GxPqgYhpgwHW21gXu0+Hhqymx16EdIjmDrEE/aTV
	AzY/KA8NWsyb2WfYeqZ1qzKqtz48E9xpKYVZheDaCnK6aqaPKxHVjWOdg4M9+eT7
	PHowHzV2pDTUUp+paJVJHGoWPbfamc29+S8b4X+d8veiIAYGHho1wINlceXmtSty
	fLECUaUeOHsqkBA+aIt2x2wFapicBLjEPjQEt+2gJivmXo3mBO5rFUopj1cxkPPg
	1mLNj3QOEY0rk/RoEMLKQ==
X-ME-Sender: <xms:PmE5aApvE7Xr_MMdeGow7VCPBlPHLT2fTQb9ii6Nx0KucuCejbGrsCg>
    <xme:PmE5aGpfN-CP_Wqumu6uNVJuC7-8S7uQRFyfyFYrT0iX83_mZEszn5POW-Gkvy1gL
    Iu5HLIutKn6f7KIzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvge
    etkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhimhiffidtfedtieesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PmE5aFM0ZRBjA2b6TADcaq7btPGbTfhGt_Sy0FQSCiXNg2CS2bN4eQ>
    <xmx:PmE5aH5FgWPSq_dVPcnrT7AsTHMGtEcBXetobxUX9eg6K78WgPppjw>
    <xmx:PmE5aP6O5RISE3YtX8ef1Ot7xjdR_hT7p_L0T17HBE29hhRA9pGBAA>
    <xmx:PmE5aHiyROH5wGVKQ4B_wnjng69h5SAH-icHW2ViKLFBUh9ezzE04g>
    <xmx:P2E5aCh_navx_d5lTkQI2RZFx42Kqgzl0xIGD1RwhrYNuPXKj6VPOgzz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0B851EA0060; Fri, 30 May 2025 03:41:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Te8fe004a2e7934a5
Date: Fri, 30 May 2025 09:41:19 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: oneee <kimww0306@gmail.com>, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <956069c2-d818-472d-9d84-0190432512a2@app.fastmail.com>
In-Reply-To: <pull.1948.v2.git.git.1748589756289.gitgitgadget@gmail.com>
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
 <pull.1948.v2.git.git.1748589756289.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] doc: sparse-checkout: use consistent inline list style
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 30, 2025, at 09:22, oneee via GitGitGadget wrote:
> From: Wonuk Kim <kimww0306@gmail.com>
>
> Fix this inline list to use a single style, namely numeric, instead of
> `(1)` followed by `(b)`.
>
> Signed-off-by: Wonuk Kim <kimww0306@gmail.com>
> [snip]

Looks great. Thanks.
