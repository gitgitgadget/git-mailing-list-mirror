Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865B20C48A
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694896; cv=none; b=l3j7Np42Ro2/NaoYColgeqLPw6JZXnLAl8kdyumYRI7kG+/WgcdIhsxagGtbi1+aZzlazMr3ZvSJWmZjhafKLkXeGcA18GA0eu+x9de599lDuUZaUXvllITfcyq8LY/vxLTk02D/9br7hO8toInzR6wcPohS5stH/EO2hU8RbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694896; c=relaxed/simple;
	bh=nhST0kGygDL1gjwy0VR4siFxcR7Hqvpi8iISYBY4B68=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j5Zzbvt7jeksaJTGpr4FFv7JnKpxoVQwfAUS+FYjp8Sj7HLYnwTYwrUUjK9qNm37hvUcRqEMg5Te3fLYAitjK2TIHrVpwaZMnLpbNL4mSW5Y1CoYLZ7o/LOqYkyo+ns0ugO+gKWe+yM5VslcsiHRel+DDMWv+PADMKiIkBwJmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PNG5Zirg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJyybrCm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PNG5Zirg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJyybrCm"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 460E41D000AC;
	Fri, 17 Oct 2025 05:54:53 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 17 Oct 2025 05:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760694893;
	 x=1760781293; bh=9bOmd9G0zkK+MWtbsJP3kqHgPqw/qH/SyleNLVFaaIQ=; b=
	PNG5Zirg8MBZJE5OFB4Ypmb+rzs91yTD4daboz1vxQHWWXZTsj0ErS5SPtTCCXmL
	v/uBwE8J92Bp4/mJA/v0kvnDnRjXBydOcyBI8MHvZvbCpNvfG0TPcUfxVoClnbjf
	mPJ02VE51Hk32jtqWfCxGvf5AeVVShRYF0DaCFBy6AkRiuf7sN78dqXZYmgunctt
	ueYgxrx7xoZW6AjQMcQKTZXXSZ9bFT5DHXmgF9/lteKE4XtyXb5ChxyO9RfBAjil
	BD0ipzvnI3AXgQr9oG/y6Qw+MuNFT53wHKikDmJNLDJfCPPNTHEXtzHxotEx4goo
	xSHXWjVS0icIKr2ZH/0xew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760694893; x=1760781293; bh=9
	bOmd9G0zkK+MWtbsJP3kqHgPqw/qH/SyleNLVFaaIQ=; b=ZJyybrCmhKL9RS7fA
	jvG2XQRriGJ2RHov0MOXOhvBhX/6GLYf+/1la7We2kyKfMeID4sgRwTxUNBbtHid
	my/kgpuSuHSnyN+89wtnfsniqq+SRXmTe3dWWumkP888OxONjJUldT3XeFNywQn+
	91ic+RzVvg1BX4mfcWe50YtSoLk6d2+vgdClsRhwjO6TdOl1KiagBZunBgx4xhuH
	ktr6Jf02e9OeldwjRSxFY6CBb6wEDWAsHMtWxYwNwsVFSsvKnCFeTmoCwFENQp1U
	1ad+Qrbkxx2grnbb6mapCGxrh5+zM4Lzky8COyrOWVcEsvKx5DSPny4kobZXGXNc
	dRRYA==
X-ME-Sender: <xms:bBLyaOGGSZtAwgYkd2kbIZ-PBtyK89sn45JqazWhaUApFVWjdP4R4rQ>
    <xme:bBLyaKJnd36mjZ-1wCsDd83b_eqrvHrcHN-5mrTOTglHzrY0n21SgHC-XItn7luEW
    1jlH40Y18lbl8yGJqj4SCg8NWeOTmmTUobE1SUaPzb8DcBMIhLHrMY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudek
    veelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    grhhhnqdhoshhssegrvhhmrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:bBLyaExo93mDFF30kJVbSgHN1Yw0s4qDm4sIPqdx37F3H6vLuB-qNQ>
    <xmx:bBLyaGP59WvVhiMD2OTdltGog65AIxndM5p16F6UcTTpPwnQe64cbQ>
    <xmx:bBLyaN6e1KDfNUfNHjJ6U80YxeUeyl4A4fpjC1hzi-9tnoNJh2Q7Ew>
    <xmx:bBLyaPMDgxfY0y59l7MCa4tDNDCm9xCeS1ypflnsog-sH5FfFNK4fw>
    <xmx:bRLyaPveWXXdxmuWfiyQe2WWF5Kt7Dxxj3D75aCuCVHbL68n_coXH6zi>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C12C41EA0062; Fri, 17 Oct 2025 05:54:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAnEz76YUTMs
Date: Fri, 17 Oct 2025 11:54:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Philipp Hahn" <phahn-oss@avm.de>, git@vger.kernel.org
Message-Id: <68e5557c-3981-4378-bc76-2a986567a699@app.fastmail.com>
In-Reply-To: <20251017094717.626300-1-phahn-oss@avm.de>
References: <20251017094717.626300-1-phahn-oss@avm.de>
Subject: Re: BUG: commit-graph + objects/alternate -> SIGSEGV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 17, 2025, at 11:47, Philipp Hahn wrote:
>[snip]
> What happened instead? (Actual behavior)
>
> 	`git fetch` crashes with a SIGSEGV respective complains about "missing
> commit-graphs":
> 	> Warnung: konnte nicht alle Commit-Graph-Dateien finden

The English translation for that on Git 2.43.0 is

    unable to find all commit-graph files
