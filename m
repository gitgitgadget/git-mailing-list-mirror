Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084A1D6182
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678636; cv=none; b=Oez8XCr4m4Iz4wJXhXtG//gnfejFaYehAtLpPF/Zlt3FWcew8AB8DM47XO5scJKcy5t2q2ICShNQ6sSGNgYhs0L2XCCr1g6sG0M/UG10s4Z1PpG5D/KrBxHnoi3UBho6Y6f+d3JDU19gXE8YG3/jEvaxNhT2hp4ORrf94sEFgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678636; c=relaxed/simple;
	bh=711LRxAfeZlXfJsF+rmCBRJsLNGHb7Xif+L454T17d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g49AvU7LbabCwx2jQoXeFI91T5uglbELHSogGAHdn1rFfwAyCMHr77wFQNf2CdsmGsxM1PM9z8aH8s2kA65rAHLziiLgNRU/AW04i6IC6gMyJRjvHHlLPqTKaCyvWlREsIltLRL+T5w4qDHavh7Wd9Oj9CsLyEyWkglxxnHWV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=feU2CIH/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yGjCp9x2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="feU2CIH/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yGjCp9x2"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44667114109C;
	Thu, 27 Feb 2025 12:50:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 12:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740678633; x=1740765033; bh=711LRxAfeZ
	lXfJsF+rmCBRJsLNGHb7Xif+L454T17d0=; b=feU2CIH/Jh7dw/iKzJniPUScvK
	Jj9y3oTQMS4SCBRxZSL9zC/WZoF46gH+Y3qoZzEfur1ANm+30rq4+lr50aqObNih
	mzrxuz7VS9SRjl1IKdFn9idyWb+QZw04Ir/O2dmv32wB8gqCDWFr6ewlbBukIbKO
	or+DnllMxetLZHAtC3CpFcZ2NlLU4Xh+KNv0udtQxSi8Czm0MgUS53zcvS8Yw+Gi
	0g5sLLg04yMGCEbwCTPeQXIhejFT/cxGjQ/iUtJ4l/t/OSkEm661yXUmHRgFQH1N
	tOuc4PGb/05Fpup5Yn8Ok/0VFfGj8ZEpUDzELbfxEFkfKQSOnIF8EWBzQmVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740678633; x=1740765033; bh=711LRxAfeZlXfJsF+rmCBRJsLNGHb7Xif+L
	454T17d0=; b=yGjCp9x2Amw3MANICEC9OT8v8O2zY2wPyYXv8P8PNGWmFRx7HOR
	wL/UlJ9IWFWi02tIUb4cljhrH5NvbtL6twDbLlYVaM35XVYHMQo35WZJtbsqdZ8+
	aSyGw4vQLl3LSKdmvLLBV32KO7sut0KERgh4Tao6UPLnyDUXUSSyNexiAzh0/3xn
	sC8KJi5KO7jsR0iFTI1SveEnKrYKXsidq/5hSJbaIlzNenmlUfKpLIdVvWEdK+OA
	HLXOzZHhCdJyq16iiYjlut8gxHeH/viLEw+bd6p+ObDgSiuDw3g1xfcwTtL9tnwE
	lbiwejz3dQQI8QrUz+pmTm2P06IaSUyTMEQ==
X-ME-Sender: <xms:6aXAZ2J6SxAiZ6AhOSCEbtAKPlBQ7dYhnXqkHZ0O2H__keo8iziA4g>
    <xme:6aXAZ-JDZdZwe-sKqTVq-OSK_3tSuJG7zBqnn8zBRhdhpDILD5E-UFxFLcqH2AWX4
    FVfe8uyK7nUF0LYOA>
X-ME-Received: <xmr:6aXAZ2tL08s1xEFTtRtxqIsNTgGRZRL38isMe52loGKgYYHLvu24A2G03prFQnTA8At9y-YUWKP1ZnN-wh-hhtdxV16mr95lPtJp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6aXAZ7aqQDQvmyEU7Ni6hrVEm3F8r8H45KSWgndRJrHC5zZMsD57eQ>
    <xmx:6aXAZ9b388iB10bwMhzmkyX5kzRTdsLu_uwHJjw4pXnazvqwqfhdiA>
    <xmx:6aXAZ3BmuU5BsYjl_pRftGRAINhQyF38tYy58wZyTT3tPB3hrMcJpQ>
    <xmx:6aXAZzbP1hiP_KB8nEKlz9LAjolcUEbhV1vH41T6SGaKHK1z63IEYQ>
    <xmx:6aXAZ8XOInAiZ9IyjG8GSDsGaC2eYvk_MJs6uNsKakBx0_ozxVkhQznt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 12:50:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4] merge-strategies.adoc: detail submodule merge
In-Reply-To: <CABPp-BGA530spgVtsU2UO7GyVXL2x=R_80n02pMiPCVA+1SgBg@mail.gmail.com>
	(Elijah Newren's message of "Wed, 26 Feb 2025 19:26:39 -0800")
References: <20250227014406.20527-1-lucasseikioshiro@gmail.com>
	<CABPp-BGA530spgVtsU2UO7GyVXL2x=R_80n02pMiPCVA+1SgBg@mail.gmail.com>
Date: Thu, 27 Feb 2025 09:50:31 -0800
Message-ID: <xmqqh64f8efs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Looks good to me; thanks!

Thanks, both of you.

