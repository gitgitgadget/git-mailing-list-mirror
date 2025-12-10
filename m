Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7DE573
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358407; cv=none; b=JKtxlOq1achXgovTumWZrhvZfL7nPjSHrVRNTplLbF6ELdMbFytjbA9Vykg8BHq4bisDjkS+pS5HvGUMQ3Uj03CkW/5/yCP/n4EVQWeMQdgBldrUj61jNycJQ/HiDBdrvT+46nbDqxStSqBV+aXEKjS89vdn5OBHtZi9g6d5E+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358407; c=relaxed/simple;
	bh=KpZzzSqA28Z6C86sIs+/Wjo8epSvH3zGr2ckWCOU20E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ES9kY1bDS/++JVhYm8qq25Bsg22XKCw8mjjNkgzKXxOBKO3dTrD5OkIWEF1zhpBZ8sCvJOfqFJ8heFjAZA49EpECmkzAswMLOj12PnrxDe0DkKT+jFYGd2TMsBSjt1hmXtt5cA4Uk18Deg396cnE6OP+yp/Ibc9MxcCHVrwZTD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=egW8D4vz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ox7Y/MTT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="egW8D4vz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ox7Y/MTT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54B3C1400025;
	Wed, 10 Dec 2025 04:20:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 04:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765358404;
	 x=1765444804; bh=8dd1DH5iFky9YM6FM3QIcEX2SWNAUA9iokCJ5+CluMM=; b=
	egW8D4vzsjQdu4HvByE0ic6vzbuaGl/AE2kFAhR3j/LQM3LJWebWMiBZENbqoSVo
	FzYOPwspVczy1zHiPo6s662SgG/Kxf56UHbiE1CIF36B44o+GdA9pPKRksQiRctv
	YpSY5T258Y1UQb2Z21Dndzaq7eUtqWzzPAW8A/6375c5NnpdA5iB91Qbc3MoAx0I
	Xv0ocuTI6pQhQFFn9e/qYSC0LWGEXInNntB8NjAd/nxoP9BKOn2hko+uIYe0T5MI
	TGXUNcAv2PGVgSmUNDLSAgTMndfdJrNADXwVfXbPHLu6cvziMaRE4RTTfJK74i+z
	FVN/6dS1WJrCqv6xlTtjBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765358404; x=
	1765444804; bh=8dd1DH5iFky9YM6FM3QIcEX2SWNAUA9iokCJ5+CluMM=; b=o
	x7Y/MTTgSeXgoG7vOHMYaVx/3bpJiCDlojRR2pcQEkDuE/1rCHJLYE2ZQ8c+II33
	3aqNIY5x+BeDGslfScdvLZaU9qr7smh7aa3JXiA0Ebg0wo28vUd67QrsCSAI7z7H
	GHXzEW7k+FQ11vLVz9gTUktPPAqWk37rFoAiAgBsDRTtyydtdELVjPxjn5UGFrjH
	VQjjsV0qVtJueS0LNAQWnsQYl8MOGk8n5cyxDxX6lGpnbo6EjgogjyB9LMD/uI8P
	Phu+EIMYEoWoH6KfD6FQH/uUSXvf7HDsTU0eBcMwdTnN8/aYFXo8OPKci2N9ELJv
	SbfmQHlp9uwBGcSIaubow==
X-ME-Sender: <xms:Qzs5aZOspuNlLG89sdD7gYLns6hopU9adbSlsyZr1ppDI2Xuc_p1og>
    <xme:Qzs5aZyapxcyI2IV7VLHs4elwArM5KU6OqGZxUPfEJ1_71kV_lHTb4peOMduw90C2
    yVDBk4bupFFMhrTpglDElQ21lk6H2jPm4zoxCUGfijMHhvd3HMcGw>
X-ME-Received: <xmr:Qzs5aSsyViSFuRInGFXikqlt6eWuC05k_RsuyRx8tfokQUjGCnqsq4_inMlwXjilSzbhENEgiLax2dNqXirkHIk8YiHjT_FA8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:Qzs5aS5MAMIUDTiN6X8T4vkasHHMZ0l2koImssoqomf5QRg7ZJ0ilw>
    <xmx:Qzs5aRTX5ISOWr_BD2BCAs8zWuXBKbEPq1gTd8jcD9sG5eCWRZbzLQ>
    <xmx:Qzs5aRpySOhbNh3P6jE8j14s8u3FptCY-ALXmH9nqOyobEPCcqJUcA>
    <xmx:Qzs5afKDZlyxrJ60b1sCmZ0gYzPSh9vOToin7_r5XsNk20VO47Bddw>
    <xmx:RDs5aTW3-A6pUebh1X9ymE7xwJvakaX4jfq6TjXhzqIkxMmDXduYJbu7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 04:20:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: What's cooking in git.git (Dec 2025, #02)
In-Reply-To: <39b57721-ab9e-489d-a382-16d9fe94c300@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 10 Dec 2025 08:55:16 +0100")
References: <xmqqfr9jjrci.fsf@gitster.g>
	<39b57721-ab9e-489d-a382-16d9fe94c300@app.fastmail.com>
Date: Wed, 10 Dec 2025 18:20:00 +0900
Message-ID: <xmqqfr9iithb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Dec 9, 2025, at 22:08, Junio C Hamano wrote:
>> * kh/doc-replay-updates (2025-12-07) 3 commits
>>  - doc: replay: link section using markup
>>  - doc: replay: document --contained
>>  - doc: replay: mention no output on conflicts
>>
>>  "git replay" documentation updates.
>>
>>  Will merge to 'next'.
>>  source: <CV_replay_conflict.101@msgid.xyz>
>
> This needs a new version to at the least incorporate the “Requires
> --onto” on `--contained` suggestion from Phillip.

Ah, very true.  Thanks for correcting me.
