Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87AA226D19
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876665; cv=none; b=KxnJRRccIrdjrgZJCaiYoklpC3oaIztYqD8uPuRiXjV9JZMvHRJn9vRfG6XI7DyzIIAnIvpEr8KHwR9YwZpSXydvwZe/O1r59hEVX2zORAPWV8GHVq2Q5UeUaUZLSspvctWCpuEvStUodMMeErAwpgIU/rUftHM9hCtK5KZ7F+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876665; c=relaxed/simple;
	bh=dWHt2W3qj+ACEUFJ9t12ObCOBOa03IOL3nZvH/y6wlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=juSQXedWziJtt+5jkuegJde7xJ3EX+LYw0+7vvAWRCQuPU4FWbWk+tzDoVF+XqjD7Tt9ECAH5yo2xXr5/WAbaKT1Atj7hkhdu1iMpKvwneKwsMPaYBG2uaLAt6cHoRWCDV4YUPhwFwi9CIC9fH7lPbrKiYORWlqHbKc8PJQgV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BRuARABr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEVLglEG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BRuARABr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JEVLglEG"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CE2FB138032D;
	Mon,  2 Jun 2025 11:04:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 02 Jun 2025 11:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748876661; x=1748963061; bh=21TjMnjvf1
	AE5qa0Lfw/JVtTZlm247cM9Do3KzBhXDQ=; b=BRuARABr+sp9I5mSxIqF59J+c8
	inUlIABV4eFSzbPz+JCotkMhzHgXJqFeC3NUXRwZ5AwYp742F2S5s/0CA1coSx6g
	bQW38M+VOAPqVetVzRek/FRTxnNwyM7mnG90nelUBK2Mhl+d6HTet65NcQ0t730i
	3e1bkSnWJoBFxeA5AlX9fXEjYlFrI/CyOJyOSZT9nN0UlEBgze47aSWkafaejh0T
	SnYphsk8R+nZqbSPHosOYfrlfsbKPFeTOFWiRneWJn+7eTxU/zrITHrNlGjdQrI8
	YGXNQIb2kdRX2TjUFhTV/eDJWnv8te2mD4kB6bHszxMOpVKp1NCJRdV8UMjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748876661; x=1748963061; bh=21TjMnjvf1AE5qa0Lfw/JVtTZlm247cM9Do
	3KzBhXDQ=; b=JEVLglEGw2d6AoZ+3XfmVtBSxGARRLF1k0wrBjBsKuOpLjaWFlo
	EMqm0rtPqCua/s9tsiJ+AtsGObasxwMi3RQ7g7EAkq2ToQtlhXDTTJQtfQhq8X3d
	DIBUbtjA+p7QT4CAgPrUcMIZ9SX1MAJJy3m8G5thRU9Efxgc/kDBhTzd4CHDYoFu
	C9ueVXOI/Gda9hh5E2BeoViNBjj7lGqHCaoEnZqcEboPo6STo1q941sQMV+zw/jj
	VsEj98vSWgbJnGCUZyA8MZr0VORkP6mujGBFy1sC2vQPqcgXEGFj+mMTWcdCfdm8
	cibUqdyae9v/PWW7X6OyirOPgyUbuCKW0bA==
X-ME-Sender: <xms:db09aM1T8WyWDKbWHSf7koHiSJxCzxYa0Zb4dvzpdWGKapFUUtR5-A>
    <xme:db09aHH4_IIbrVHNZE8FNHkbTnGFIMilEMbhmOjPjqLsqKhink5u8k_32vRBoixXL
    mhWwe0haRMWdy9QPA>
X-ME-Received: <xmr:db09aE6mdwqOaJd3ftQvEswpF2LRFLXUUdmPRu2NGh5eBMgGIK2m_H0338DXBRY9LFwsFpEy-7hnT1Qu79mIWa5ysQg0pbYDwZcB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeelkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:db09aF1PJy07_m2cuNkLFjs_8lyCySs4FgCetWPbiHo7BAduMQlJ6Q>
    <xmx:db09aPEcCpcZB7LBdpH6X3lN2cLtP9rGRUE2BLKL-TWkbNOFi4oaWQ>
    <xmx:db09aO90YZJz1ye2x1EjRthFqcNN6m5OQ5lemlc2S4dZOsQ1qP3GNA>
    <xmx:db09aEkVf2P3ONErRxqwNEUxX63WVQaSKljBu6-s2xB6q1opla5pGQ>
    <xmx:db09aN6Gn-8KQnaVfAY2JPtE9LNITlESMjQMqfUtpviqljN2ligwC5r_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 11:04:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] contrib/buildsystems: drop support for building
 .vcproj/.vcxproj files
In-Reply-To: <c3273a46-aab4-8dda-1634-9de233290f55@gmx.de> (Johannes
	Schindelin's message of "Mon, 2 Jun 2025 10:38:27 +0200 (CEST)")
References: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
	<1ec2a4bb1d58ea8cfa6abb2a0e625ef3e0db2a1f.1746430790.git.gitgitgadget@gmail.com>
	<c3273a46-aab4-8dda-1634-9de233290f55@gmx.de>
Date: Mon, 02 Jun 2025 08:04:19 -0700
Message-ID: <xmqqh60yuqvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I just noticed that you applied this patch as dc5e178f608f
> (contrib/buildsystems: drop support for building . vcproj/.vcxproj files,
> 2025-05-05). Notice the incorrect space between "." and "vcproj". Any idea
> where that came from?

It was almost a month ago.  

I have no idea and I only have one reflog entry on that topic branch
(meaning it is unlikely that it came from a manual editing).
