Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF956B81
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915805; cv=none; b=qrityrlUclYdI1PCWTA4HWx75GIyTo3vSnpVa2FULSJpnHuRXUcS1Y33O3pHtSNbiYBO7gRQq2cJT1DtuTAYZbs53IjSKkSe+9R5nt6WKx5DAg2LbVs9gzbvGzCAUjyRpsV/5mz0KpCs37T8nhoQC4GXKsSK/kGjHCWVd22wIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915805; c=relaxed/simple;
	bh=6bNsLfIyoo1OY0jL7KsxwJaWkmWmIeql88Cxyw0pehk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmpMG+S/Xne26uWVAW3oSLYJJLKBN0l7bnluy0rbXrrtnJBUqO1qSuiJmTo9UxGd/n8Gnwax06r6CghETCA+2lFUsR6q6NEfleAyjgbXxcnU67EMLa64La6KZbxDxT0mXmt6+maYXPztzCjzNar/wdhpwkVPzk06ewmjjkuu2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L/KU+V7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zj2Z7I8R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/KU+V7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zj2Z7I8R"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6881E11400BE;
	Sat, 14 Jun 2025 11:43:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 14 Jun 2025 11:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749915802; x=1750002202; bh=6bNsLfIyoo
	1OY0jL7KsxwJaWkmWmIeql88Cxyw0pehk=; b=L/KU+V7AowCp5GRi8C66eMhdvP
	Zel5v357qpJK7Fvh3R5M8tYEquq4hLNPWdFASEUcLSXVNZDa9XsvdEeqpinH1xCB
	GUx31NdJZmbbp4pzeSK5jVXiCrkTwO50tEirVKeocpfG8eLP08YRrIRoSHMNkx1U
	5TARUbt0MY2hkPRsEAOX8kCobMeJe0thhvEwhz6M+GNFAkgDMqULVbpk/IWKhDSd
	SUDS+siQTAJumCUBBWRmbSWszS+YOc4XXU0iZ3ZIK9V4h3bHuRz1taGB6/aBEtsz
	JvTvLdK96KcEt05adcR1xtlCqjP5nUm9QFkRLxm/nO8skvfIi65hjg+khCNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749915802; x=1750002202; bh=6bNsLfIyoo1OY0jL7KsxwJaWkmWmIeql88C
	xyw0pehk=; b=Zj2Z7I8RaQ+yOqQ9iPImLsqJ7IDinRRV9l37sVirLVTL1yxQWfS
	jwX9grOB8m3HXxzBs8zff21y2DP27wy/yQkmlxAQf0YJHpoOAmttPFXFAMK73gIp
	bYOJHz6YDb6YHbJoFxHKPNdsVLAmtLzfldqfrZZtnvuWp5KyiFRmKpbYU3aO8Bfj
	s5I3pRqqsPkRE5yjbkuSsOidy5E9qwJ/yyp5sqfHVZ+clm10Julp02rKYqF/7uYH
	wchxT/2vpWbADO5momDwtu7STj8hQbd/KOxOFMBUoYaJ9qKnseq4dZMFHN1o1m58
	ciKV5ciY4e2riz0g0dTp6vj4/ZkwSpyNUPA==
X-ME-Sender: <xms:mphNaP6RokjV-VEEJuDtp_IVkoNwGjUairRUxxacs3w5sRqA1qMBKA>
    <xme:mphNaE55gB6m0yJxwMcZFi6TBQhsVpB8WVB30BjmL6-zzBgOd7V3XbTPs3tCpIMJT
    L3ZWHncS0mv5WbFPQ>
X-ME-Received: <xmr:mphNaGcS-NgFcx9ZNAUZdwIyjYMa4ZMeDunHzpCskfeMgYJ7pnSOGpiN2K2yKh3dgXhJjy6kmGawb0J8qoOLx37iZp3MTu5YwtUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mphNaALM_8_ZcUeJUlBnf-gllR-2zT_SF9g5rDkw3UFR-R-6qs9p_g>
    <xmx:mphNaDJtT2u2WlVSZ1Zu9BEejGX2oh08VikV6fF9lDHHAatU4Vfcxg>
    <xmx:mphNaJwG65Pvke6muGsPxWbMrH2CZAuIOKURfZBeQQC9-wqesVpJgQ>
    <xmx:mphNaPKJb_UFXA-pVeSOs-VBlB-f1VmNmffzmn0w-IcEnJKUn1MMbA>
    <xmx:mphNaIlSFW4ZrZQ_fGq1pdwMhTSRV2w3BB_fpnY-o5_NPgVUK6yYxUZ9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 11:43:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Question: regarding understanding code base
In-Reply-To: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Sat, 14 Jun 2025 18:13:39 +0530")
References: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
Date: Sat, 14 Jun 2025 08:43:20 -0700
Message-ID: <xmqq8qlu72hz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> The main question is
> What are the best and smallest set of git commands to do this as
> I can set this up as an alias and use this trick for many other projects too.

Sorry, but I have no idea what you are trying to refer to as "this"
in "commands to do this" and also "this" in "use this trick", so I
cannot help you here.


