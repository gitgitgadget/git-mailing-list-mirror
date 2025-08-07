Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D172221704
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566491; cv=none; b=e56OFAF3QSWJuI+9hA0FNhfyzeW9oyBNv/MPy4E3tcCsBeUtuFXMKK5U3huF8RMoxIaMQ3XWO4mxsgjdr6uWn9Aj646bfwSQNqS+bEc7l2s6LkjrCsr4GDN90sxcGVB8/JumCmo6FF1W2vQmLxcgs0z+lgeWkwoaqWdeVZSr2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566491; c=relaxed/simple;
	bh=/UILy9BZCmc9f9JDH9a/TEE4X/geA7NtbYvvvVbvLvY=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=E2GpGoDy1cy0/6Q8tUpdgjNzseATWohd7p2rvZG155C4rOphY0hAcrmv4Z8YefW3zXdsUnt7615o8MxMc+578xSUJd/kni6Xvk8vLNHmMSGLYhTtN5DaA5dhv+rpvfdAIDjKmolzMyPlhvCv2L4IfEf2yNJUlevFGZCciS+zQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imap.cc; spf=pass smtp.mailfrom=imap.cc; dkim=pass (2048-bit key) header.d=imap.cc header.i=@imap.cc header.b=Jg6w6yLZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sq6RG4M5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imap.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imap.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imap.cc header.i=@imap.cc header.b="Jg6w6yLZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sq6RG4M5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B8B59EC020B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 07:34:47 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-10.internal (MEProxy); Thu, 07 Aug 2025 07:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1754566487; x=1754652887; bh=SsBi0tn929
	n0e+nG3zHkRIoyrZ+gzUIPUr/dwUmOjtA=; b=Jg6w6yLZYmEBoQ8YqyPBkY9h/A
	AA4iW6jxptjJYdUH0U5RdsKjmxsyEHSy768b9Q0q7USZvkraC9BjENZ5f0YkL+b5
	JPqtdPPr4//dk7qt7xEXezDNo8hB0OnKZem/ZUMUbQfQjlnYjkfDghx0tcPRnHpQ
	bTWXbYHhVpw/QUV/vUA5Y/8SqK/tLmwyvFlazHOmqX/BAsuIURplE1VBSduZW+9o
	5oWKA3BxCWEReI8pCSml31gY1+4rdzMQeVF818xCFOKUjSuMO+BCVnp4YR101Wm7
	xoP4I480uSHPPT5LStQyT6kUxGrsE07sjveumPUxDGmAf7VpYzbRxaJdjvYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754566487; x=1754652887; bh=SsBi0tn929n0e+nG3zHkRIoyrZ+gzUIPUr/
	dwUmOjtA=; b=Sq6RG4M52njPSQVK7nV23KPlFUb3aUozneMAjp5Gm0e9BfHZxdO
	MR7UUONsKeVK51go0yaUa5BdXVf/KazHgFQ8ZjaGIitlwsElgLIASSsJpivXLOxW
	0W11K3j7WMvX0EGyNUQipLJogFEiR2h/EEgxwiKJ+aKeTCM/VlT+pdhEGmNgRE1C
	+CdEzHsi6z+rbpo+NnaOGM8AxOPRtd26W1RWCjWWTBlx82KTaCQXQ9L+barbHieo
	uA1Ng3dunmK2XSZxdPXvL6c2BSiFxo2VOwm3JAnqm8UOzN2JBrHQZ3pduImsrVBv
	/Z8YHqVtE3xV5xGkGMWtesinsngZDK01u0Q==
X-ME-Sender: <xms:V4-UaMZ7yFufQjV5M4x94ao5SwAv_w-2Cly4s9Gkle34RDIIK-X7MA>
    <xme:V4-UaHazDkrG0VRs4arulp4ft3IA0gPBzWwSNp6P_Xfb_Lh7wa2q4D16fPvmcaIXv
    ckU314BRVc-1nSksA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludehmdenucfjughrpefoggffhf
    fvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfrfgvthgrrhcugghuthhovhdfuceo
    phhvuhhtohhvsehimhgrphdrtggtqeenucggtffrrghtthgvrhhnpedvteevtdeftdehte
    fgfeduveekkedvheefueevvdejtdfgteetjeduvedugfekveenucffohhmrghinhepghhi
    thdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpvhhuthhovhesihhmrghprdgttgdpnhgspghrtghpthhtohepuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:V4-UaGSBd-WoXR3DcZUAACpFftH-mjmo59uWAfUyba_QRV8TXkQozA>
    <xmx:V4-UaADldrObPy5uNW4Uge1NiV3SPZSx_1ZIt14Don4FxA6nPADR0w>
    <xmx:V4-UaO1tCBnReTwWIBmdiZo1FNVRv3aQ-nUjjIIHM2zZ0glAnKD0MQ>
    <xmx:V4-UaGXF1CZO6jNevDFLHj5SZ_PSvVMID9QXCwdpFsjyt5OUrgwd1w>
    <xmx:V4-UaNbxnrWoWCXVBpdvNeOEmeqD1-5SLuoVNVvvixMGkuvu4nA4fEO5>
Feedback-ID: iccdf4031:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E04E1820073; Thu,  7 Aug 2025 07:34:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 Aug 2025 13:34:26 +0200
From: "Petar Vutov" <pvutov@imap.cc>
To: git@vger.kernel.org
Message-Id: <b3dfaa93-fdd7-4be4-8b5b-f453146d6c14@app.fastmail.com>
Subject: Partial-cloning or filtering a submodule
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When adding a submodule, I usually only need part of the submodule repository.

As far as I know there is currently no support for partial-cloning submodules. Before I try my hand at this, I want to ask if it makes sense as a feature.

I imagine it like this: 
* new `submodule.<name>.filter` field in .gitmodules
* on `submodule update`, the plumbing described at https://git-scm.com/docs/partial-clone is used to filter the specified paths
* if we do `submodule update --recursive`, submodules excluded by the filter-spec are not filled in, maybe they also don't show up in `git submodule status --recursive` etc

Thoughts?
