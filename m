Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39B1C5D77
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282558; cv=none; b=BmerXM5dXp5UxEb9fvMr4K+zl2s/lsf3RccXqlUIVqWIpp0tC+EsE+o/SE3jutADQSitfqdCW/uGfrn7EB7Kzo7SQCZpsb5/Ck3ikl/QRXVHLbASSI4qqTSYxHa3t6x+AU3nlw8QlKU7h9VIWHDcQOL1HyinQ87Kv+EOayy4qSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282558; c=relaxed/simple;
	bh=sfQQZmuaH3QN1bFHTtmRQ8zJ8PQv/UQBX74FT3ntk70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ghHhpwt/M5TJ3TjSVUKh/TIivsqr8Pme6mAoSYX1oBEkVqzMjfeMfKwRDPgho3JuU9F/yp1b6tQNlbqWd0NEiv9fy5y0QFFwo8LKxMMYFYMNFWNMlHo027uC5+BhmppiG4rK3jc0s9IAv7DjqhGwspxUeIWLv62NwqDA2mFkbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XC8smZm+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQXOSYTN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XC8smZm+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQXOSYTN"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 47515138044A;
	Wed, 18 Jun 2025 17:35:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 18 Jun 2025 17:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750282553;
	 x=1750368953; bh=sfQQZmuaH3QN1bFHTtmRQ8zJ8PQv/UQBX74FT3ntk70=; b=
	XC8smZm+0RAxL5Z3XE+ceUfeHpn65Vh7ZLeX3ghmmobV8NI8mKlrR2A6+3MWGTZE
	D8ya4krMaeIj915XZNKT51y2I/BBW6Pdfv1B3LxP4ax5G1jFL4i60GpqkqI7FaLH
	PjT+LN+VBERNI1vFS01X8Kq5PH+wJasUAufLlmnA9iU0wyn0OtZaaJGPj/Czrp4G
	VuzDlTP1HHEjw4zAB8CEmOzgVgT8zK47nuWySC5hIe+PTzedV7qg4xtx2zDNHzZa
	hwmn0HPTHlWazhUvCsMwf/eH3YEvJGRQqhTw0K4qExdIQyfkaJvys/bXWl6No+3d
	XjFDtpjX27MvecqVQG3fNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750282553; x=
	1750368953; bh=sfQQZmuaH3QN1bFHTtmRQ8zJ8PQv/UQBX74FT3ntk70=; b=M
	QXOSYTN2XFzcnnwPn7vN4SLCz5BNSF2z2uxFoPOiNocXExpNyaVxgCkaC4sOLJrP
	jmdM3whBKvD0/lwJO0acjzRzZFJsb0oB2rPVwfoPXFaa3dTLHboehrANQQbmtcdi
	nmKYBptOcquK4ECDYd+9hQvXAAl6ylvStR6jlxphfx86ELaC0oLbAwYMlMPZJ9nq
	GTzpYxYhdq2uIt8VWZULs2jrZOYJNnifFRT8VQZPmPA4WXCgERKlbr1rqR52faXu
	cC3d4VFpq1XkxviqT5XHdhXWUvaAb0DUVY9VB5LM5/CMIjKp7DnSSKT5C+OUN67p
	8f20ijmM18r5u0BWIPz8A==
X-ME-Sender: <xms:OTFTaKNLbsRVvNSaI62CnxrGdpIBi0NcsXutpjW6LhRfSK8yubyqeA>
    <xme:OTFTaI_CJBehWWH1hQY_Ef1VKYOJxKGrY0d29_lMvs0ZXF4zDuipM1a6JYy8rLyD0
    FdcNamlUtD1wPS4GA>
X-ME-Received: <xmr:OTFTaBSppzawzk5nFleTEDrGd4uO7yPIRJHdqH92Xla4ybK6Zqf52r-WtP_1JFwioOLtIeTp8QPAjqNpeW5cUetdET9sOcztgmp9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OTFTaKthnmKxzfy3o35HHgggvvdWvNX7vguKWiZeDlO1HVzc7xSnHg>
    <xmx:OTFTaCf8Ftn6qZhN5mjImFxTg7hgqHZ0sR7GRiMJ6e4SLbSMPhKf2Q>
    <xmx:OTFTaO0CL9wgd4Aj6967a1hiVPeK8PS5t5g5mOj3yKEA2CBx_vM9uQ>
    <xmx:OTFTaG--vqemnFISQHF0BsNc07gxjekHcOrGwokK1BA2LlCiCn2EUw>
    <xmx:OTFTaKBuZz_pvGKKUShIiSkxkE_ReByLMzOI1FPxtsg_Gugt8q8FBfMB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 17:35:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 0/9] Doc git log
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Sun, 08 Jun 2025 09:09:37
	+0000")
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
Date: Wed, 18 Jun 2025 14:35:51 -0700
Message-ID: <xmqq4iwcenrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series converts the man page of git log to the synopsis format style.
> Git log is the second largest manpage after git config, which makes the
> changes quite large.

;-)

Other than the "add % to literal" in [5/9], which I couldn't figure
out if it truly belongs to "doc: git-log: convert rev list options
to new doc format", everything looked pretty reasonable.


