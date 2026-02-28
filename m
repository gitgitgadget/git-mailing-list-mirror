Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D17430B8E
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772310179; cv=none; b=K2Llucu7u+50npnClxMyTgdilSuGtLJpQxvch/9GfdQE2nEAHOM2AXn39KrtCsuG0i9DvS3QUfsRxX15JskJIWd2lS1Ue1r9BRrXO/OumS0/8VR37V6O/euG8T2QTIXxwMvIqtBw9KwsjPVcNW9daFxTXD8521C6WCe3Z2M8bwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772310179; c=relaxed/simple;
	bh=lOTXtFwHhNzkwHjclpMDPAi/+U9kaeQKBp4Uqx/MDCQ=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=opnGaMoGfkztfHoHBkFzPyGJB23k5UmcbHZ76xgN+VWu3mbloObZlU3MStB0HobiPs3KTee4b65V1wCY+wbY5xl9AyOe8a11I/lDVbDkvRyd27M+FMtQvIIEhSkwcVhFItUgPzw9FSPk1VUMdVk2F7yEFfKLfbA4S7IGXh5MNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mastensg.net; spf=pass smtp.mailfrom=mastensg.net; dkim=pass (2048-bit key) header.d=mastensg.net header.i=@mastensg.net header.b=FXgI+6sW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fq5o44v0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mastensg.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mastensg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mastensg.net header.i=@mastensg.net header.b="FXgI+6sW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fq5o44v0"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F22FEC0295
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 15:22:57 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 28 Feb 2026 15:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mastensg.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1772310177; x=1772396577; bh=lOTXtFwHhN
	zkwHjclpMDPAi/+U9kaeQKBp4Uqx/MDCQ=; b=FXgI+6sWcFuQ4d48kvIVTCVtPd
	9ToHPS9KmtpvStNlVScWXMeUWuc+Dc1G0QbUiaN4exYerxlBesYFUSVgkEFj8QxF
	ErtiemIZy5XfWaIvB4+HfCnBPnHfySlG6D3w30wNp7P/TH082w67mH3H0rovFLFn
	0+xOr9kq6ubIrcAWBwhJ5bt/H+t87DCwlTSMv+9jTIRTHir6lLOUN0f7Cis2/Vxd
	9weTZ1aA9J/AlFFtb9ydwRuUhpi+2iFPXZYMJJaXFg3irIwpOIMLCHnJsOAGP1EP
	9LEvLADNwbkWK2oPUTvfxX2ttbOP1CcrM4fIgh8CJDneIdFHzX+I4fGBhUrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772310177; x=1772396577; bh=lOTXtFwHhNzkwHjclpMDPAi/+U9kaeQKBp4
	Uqx/MDCQ=; b=Fq5o44v0saCt33F/KUEuXCTILU1Vk0A8DzJbdnp3rQcm+u9TJpt
	MVm3IpHcDs3mJLAXfukSKhfURRu6ZV4TJf6MGcf/RurZ8afDdAvhfqqPQEnwSpiH
	V4xTY0q1f+TD1N9ymaH604U+sND0nK9zpAbuWpxVz2byik4GjQIgDWZqTHkNDNQg
	Hi09Sy1JXreGvXzoGWAbvYVAmzk8uISMEoT3T7tpQxo2WdLLHUZS3IZofWvD1mqW
	op0LKUJwpb3kVqh+h0sSmbmWuyhDrJXPmtr+hrzPKmzfffAZUFH7XVBXcDOM2bD4
	S8YsEIBZ7zK2GV48jxRIFDfMLLzhgyHra6A==
X-ME-Sender: <xms:oE6jaSJxaL1s7qchjoMel87T_UQUqjmeERfs-LJwGyKauEV2azYpfw>
    <xme:oE6jaU-LAx7vFxlYacodGW4ByHp6j-6qr6udq7MiSkNmLcFEmukGkJURnZuFN3qgC
    s5WHTShYKAAI0xVs1lUKpmbBpMnBP2DrbBJWxu6S-hMq_q0KugUpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgfgsehtqhertdertd
    ejnecuhfhrohhmpeforghrthhinhcuufhtvghnshhgnohrugcuoehmrghsthgvnhhsghes
    mhgrshhtvghnshhgrdhnvghtqeenucggtffrrghtthgvrhhnpedvtdegtdduueeuheelff
    evudffjeetffefhfdvhfegfffhhfdugfehgeehtefggeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghsthgvnhhsghesmhgrshhtvghnsh
    hgrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oE6jaQaIFSdH04lcgiRTnRcidJuymgIpRV-C7beXuEFzZEQI7Ru13g>
    <xmx:oE6jabXPXf4pUPkC_uIXmuW_5NTmBP1UKZezF54ff4sSLwI4WNX5AA>
    <xmx:oE6jaX0Dj6gaX3E4cQIe_YmxIt_zAKey8YO6bVKqBMw74NSjNq8ltQ>
    <xmx:oE6jaSa37aCslvQenSj8qdRq64VJkqlgo2qG9ICoPEP3Yt_qsWfb9A>
    <xmx:oU6jaasXzfhSFXo0OqKGHTTdzWitIpi1aSHbIi4AquNuA-U3MdZoEC1c>
Feedback-ID: i1fb04291:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D9943780070; Sat, 28 Feb 2026 15:22:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 28 Feb 2026 21:22:36 +0100
From: =?UTF-8?Q?Martin_Stensg=C3=A5rd?= <mastensg@mastensg.net>
To: git@vger.kernel.org
Message-Id: <de1a96a4-c38e-4200-90a6-2b87139cdb47@app.fastmail.com>
Subject: whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

git version 2.51.0 told me to let you know that I still use the whatchan=
ged command.

Please keep it. Thanks :)

--=20
Martin Stensg=C3=A5rd
