Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB8340DB2
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584523; cv=none; b=qWD1n2MbQ1Gq5pn/kkJywquVuKO+bqCjyEne0ofuQ7AZRdkdkB/mtnIJ/otWF6ym+L0Du5M42GQrLB3O0SKncKMOyA3hwfGvdiCttak7MWEcoDg5FEh14QyP1LJlMdWRLWedbf2FtVkSqNZkslegVSCqrxoUoPBIgUdLnCqCgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584523; c=relaxed/simple;
	bh=3RVUotJUzfCROHWpi4UpyiTB2B5xXF0oVMN1BKaiJ/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bOg6wbHhxiJivQ5WkZdz5Ej9jVzfZQuHmDE9V05ZamfD11Brl+LNPDGLnWnsNvJDw6ND+FUKK5I0ifXTseG4baWdQHqfsRQpeECvnAQb2SmLQBVA9c0NjR5Kbiu4a00yqKuHv8ycNRdfpzVF0PnduKSBI3dovKJPgnGgkBk9WXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YuLu9ZR/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EcnAWYW7; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YuLu9ZR/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EcnAWYW7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23CF27A0049;
	Fri, 16 Jan 2026 12:28:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 12:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768584516;
	 x=1768670916; bh=MicJUAnhRhmCwoqmt0yRAx4A5j4BOQyU5D6i++bcQrc=; b=
	YuLu9ZR/5mPp1gz/JQEvmRTCiynPSRqrNoqpFLNvooP4Zr4BXTIi/me5ooqm93uj
	KKZzdQjDiz/4x8KGLfpLLnA5PxbeF+VXu9t/nZOFGj+F6eZz8fZtEXSoIRBaQ+Xy
	/BpXrTFl3au1YneIYwokGjWuQvSOcUKweIj0motLrifU8oA0tkh8iW9lepZikJ/s
	wwMfKYZ1/KXgYLu7+o9ClwIDTeg8XZnuky1chYdoULEh3AGWa4pLCSI2iXfLHlrv
	2wdzfjUlTUr9FOEDN0AugzPSx+ePl22gSv3pgp8dwA9B5YwJTZ6AkXdzcOR52iC4
	TUOtym7CV4q5pZ+ghzKTGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768584516; x=
	1768670916; bh=MicJUAnhRhmCwoqmt0yRAx4A5j4BOQyU5D6i++bcQrc=; b=E
	cnAWYW7K4adzbzZ8oE+kpoAwwqGew9Q64mIotoJu9pIHv3kYY5IhHX1E23UUUF07
	iI4jua9YFnkx818kmjLFZD5gKYz4lr72SH6r0VD+xuee8j5Y5F7cTfR/W61oIKlV
	nOdODysz4o+v6kkY0TJQhaupBIRRENSyx1ZDxsoBusCrY6VUcdaHQ9oL5w86Z+EC
	dFVvtVOXH1YE35RE4bhEB2nagoS2a5lqAgkrspLxNtOmv9hKlLHYqr7icWmz6tG3
	iJ2jdHa13RLZntA3KDVEgbEkHlAkLaQKFJSzxVzBD0BFGKZYHIqF68N5NN932uQ+
	KJ6Dqw87IujyeQxZPRDNg==
X-ME-Sender: <xms:RHVqabdsSE6T90wAO4TuJM8VtkkETDEq6nRo40gPcTKZM-VTyz20SA>
    <xme:RHVqaYN0ZbT-IHkl88BIWFTORIu-8NQ0Z0sUI7AoiEK4g6_qkFXxFWn6NTrgC8K2I
    0RZIIxQ5vzGztwaQSpC2Bcnl04O8Yb3z6JJTV_KDT5MF270eV_wtw>
X-ME-Received: <xmr:RHVqaZhbjmaL2U8Ict4Q6xiy9TxmuHG-4U5kkWrpCjOOiVXZLVcxtLo1SSfllU7Ctzp8DgwSET2_L6pXb3qOWojESlFIR7Dq_JePvqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheplhdrsh
    drrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RHVqab2dJ6pqIH1kyvNvKQGlbwt-WsCh85RytyrkXsgITVZGY_k18g>
    <xmx:RHVqaTgtEwj1m5ojygbwVQcTgFwfVzYSiM6vjvd_olnLnqQvx_FYpw>
    <xmx:RHVqabfeADlHtaxtsvPielHvDLRA-cxHHNhKHnE9MmG6QVn5tiGe4Q>
    <xmx:RHVqaWlRFpiGK15kcmK0zKa3hCSS0DjsNBS9jx98Xz42i2P2uEpApQ>
    <xmx:RHVqaWcepWG2Sa1KWOA0-fZrGmjeW8crIVvPnZ8fXP1PFdkG5cQA_3TX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 12:28:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [PATCH 11/10] cocci: remove obsolete the_repository rules
In-Reply-To: <aWoMqfTmrOU8UMhm@pks.im> (Patrick Steinhardt's message of "Fri,
	16 Jan 2026 11:02:17 +0100")
References: <20260109213021.2546-1-l.s.r@web.de>
	<cd6e8f5a-baaa-4c4d-9d2d-576d4b6a9a5e@web.de>
	<aWoMqfTmrOU8UMhm@pks.im>
Date: Fri, 16 Jan 2026 09:28:35 -0800
Message-ID: <xmqqtswl8o1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jan 15, 2026 at 11:01:25PM +0100, René Scharfe wrote:
>> 035c7de9e9e (cocci: apply the "revision.h" part of
>> "the_repository.pending", 2023-03-28) removed the last of the repo-less
>> functions and macros mentioned in the_repository.cocci at the time.  No
>> stragglers appeared since then.  Remove the applied rules now that they
>> have outlived their usefulness.
>> 
>> Also add a reminder to eventually remove the just added rules for
>> tree.h.
>
> All of the removals look good to me, and I verified that we indeed don't
> have these functions anymore. Thanks!
>
> Patrick

Thanks, both.  These look good to me, too.
