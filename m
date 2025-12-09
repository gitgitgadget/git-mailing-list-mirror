Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625D2FE04E
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244941; cv=none; b=jbWc0xX7dh7zJmikvpObNkEe3aFrf66mUZfqIaDlKTaSDeCWEVXQo+9+ZpsLdM/Md/m25ci2FeQYk5o9R8LQc4OVu/mE7TyLLQniaffdJVrBDbKSkrNXizxLo8LRkjLeZlOlH/P821GBm655WON6c6UCJZFnDmm8xnVEhK9VRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244941; c=relaxed/simple;
	bh=ITaBYLCVFGoQSKVwJdBCMxvaTayUQt5eRCSbrKSHyZM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kH38BNDHaLTcNAtjApopj1BfhIhQkIpPmRTuwN5LWTmADrxWFX8oQcv1uoKzqmvhcZGwFZbaGxpob6z0KaVF3FxM/QpcGglemZeJdVaep8b10+KcKLhI6uXTRJB2wtGeUU3DuSG4b3RK96N/04FUa0q5vRmouVr6l9Zxcm5ZFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akkartik.com; spf=pass smtp.mailfrom=akkartik.com; dkim=pass (2048-bit key) header.d=akkartik.com header.i=@akkartik.com header.b=GKzQbif/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8oqJVSt; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akkartik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akkartik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akkartik.com header.i=@akkartik.com header.b="GKzQbif/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8oqJVSt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32E697A006E;
	Mon,  8 Dec 2025 20:48:58 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Mon, 08 Dec 2025 20:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkartik.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1765244938;
	 x=1765331338; bh=ITaBYLCVFGoQSKVwJdBCMxvaTayUQt5eRCSbrKSHyZM=; b=
	GKzQbif/5Y0LPZYd5nkZiX/fLKdrfb428rQIthaz1Fr2z3Qk4VofjQlbI7VkFyOq
	gafOieTw0tpckf5bxk/C8i/5Ke4UBuDqYu3fjVlBOTD9JzXh1U3N5vIBKhRTM9na
	CtjiHvu5zjyWXP1exSEX1PsBT5HCPfB7xF31ldaBCmEluJPD+9J4xYRXnKCaWPXp
	QlpJ1R10wHsZDxbgLaK11ShYZvE2JslCgXAXAe4KQyxsEUzJFWbx55mfQQPLvOxw
	K6nAIzGyJ014H1wUAHjH3StQ7AcMkW+7ZMDwewcjjn89F+UMdcaFLi3GMAoQN6tA
	qRJ2ABNry9FTVSVZyPUGUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765244938; x=
	1765331338; bh=ITaBYLCVFGoQSKVwJdBCMxvaTayUQt5eRCSbrKSHyZM=; b=L
	8oqJVSte8qFTJbkL4koiLg5jFmFURH5NE2oJbLXxpcXUXGe86UDYYSF5iuilT5QA
	I4ukCKKfC4Xp4RRfrUSHfyR5kFf7U225hjY3x7+3A445z739BOuehYaCXFEJNz/6
	U4ZOwJEJ7tBzctrasWsMPuT48kl9rnp1I+Ao9M6zCBrwvVv0rHHFP8zFXyIdF9aJ
	6tgDrGUoCKz30I3FGcsMpiORrA/c07t+4/oV5jVpRaxuA3L2RN3xE6Uuq4XFv3cE
	p7AwtjaPMd2tQzTdX3gRExRX+WWTKG34OwEEXvm66s204vz0l8cwNTR/uv8e4d8c
	PbExzwpEBzvtJjVVA1KJQ==
X-ME-Sender: <xms:CYA3afwHlnin3oKMO9oBYq49_PNlb1EFkNukknEya2s-QHMsruMxrw>
    <xme:CYA3aSGi7OIhEct902_Q6Kto-sfj4NF1tZ9NMdMEJAYAsRbJEgdePNk-PRNlo_C9_
    bocN5mzqSsFRvnqwEQbTxf7cig1znJx5CXW_4qOMiqjO-TOzfS_HJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrghrthhi
    khcutehgrghrrghmfdcuoegrkhesrghkkhgrrhhtihhkrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhuddtveekvdfhveehheekgfehfeejudfhheethfdvtdefheehledtfeeluefg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrkh
    esrghkkhgrrhhtihhkrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CYA3aXPULUi-kK0naZerWeANYICaar3qEM3xGuCTsk0YieGDgddQyQ>
    <xmx:CYA3aZtKMWVhd8WU0rcUJg00N1GbbQr7qb5jYr74oRkXRoDYbeoLaw>
    <xmx:CYA3aZWBSfr_gNJ8RR_22saH6cUdwkEHaPNyXk0yDcLOGNguDZo0gw>
    <xmx:CYA3aZuLpVGf1gW2PEfzcPoCLhi3DR_dr4huEcD6WyNgzEQ5datdeA>
    <xmx:CoA3afrUSnzmy-pPGhUYN4uZgGUB0xvfCavUSnAe4ZBBX_TaCPg0gx5I>
Feedback-ID: id12946ff:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DAF812CE0072; Mon,  8 Dec 2025 20:48:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApOoA5dE3evk
Date: Mon, 08 Dec 2025 17:48:38 -0800
From: "Kartik Agaram" <ak@akkartik.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <67bcbcce-96cd-4bf9-826b-e52b3e09a5d5@app.fastmail.com>
In-Reply-To: <xmqqa4zsliim.fsf@gitster.g>
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
 <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com> <xmqqa4zsliim.fsf@gitster.g>
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Should `git push` perhaps only update refs/remotes/origin/master if push to all pushurls succeeds (with the same result)? It seems like that would fix this issue. Does it not work in other scenarios?
