Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979129BDBC
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438981; cv=none; b=uDf99TfLW7/n0iNzJZaiUNjZzjuhlD++LsUKKG53UmFi/ac5LIjs6nVQ1ndM8u0bHIJxuQxI4hE0XVfKc9QUPXuq5ZyCpF/9KX3hIEXto47UzH4CtJEG2/yJrhlkcENQb1K58TQkWMNgQ9iIjI1aaJiaWitnbfVTe6It5xWM46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438981; c=relaxed/simple;
	bh=i2/mBwCIBkxcygb9vyedMioMPoz0ybH2SEveW3/VIEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qgUc2fZu+4JKXnxr5uoo9GiQgOv75LuMUSaQ3LuEZOeM6/8EI7J75CsO/5xIkEZdkNluCVuojBOnsvNx0FfAmnkvHj61L0UgmiM7++ikVCTbXmsjbgtC6xvuEKIhFP4NWBJA0VpV3NUecHwqdHrvZoJGhG/CA5TVjH820oze+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qf/6Uwh5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oV6FzPWl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qf/6Uwh5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oV6FzPWl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45CF47A0086;
	Thu,  2 Oct 2025 17:02:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 02 Oct 2025 17:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759438976; x=1759525376; bh=kbhS00QtPH
	OQ2sGC8RvZMn3prqwSUCIF73N/s1bMTiA=; b=Qf/6Uwh5oPnewlVc6n/wI3HytV
	XyLfO6sAdTEs+k3IAEUccHdtkOeoz5cUzYkrNUscGi9IJqtvC7Vr0S/6AyP0SRG9
	s+Pf9qzD8d1d5Qy7A2nZRKlDvkGg7Wa1OGTVi4lmkb2tJrGtDHDhVAfgGJLVXIio
	MBvgk4Lhbt4uWsTXzzl+kJwEeAGp/Si+zJ3uIPy3QPRTvztqYci5tJdDNGgMPEKW
	v6omYxoRJpyE8V4Fm6cyMMdjIg4ikFA2GLynl/XaeRy/GHNwCLzfNxfLdy2BrKT4
	eZ3XE0+OTN95EDLkQz7TFfh889HtLJzAWNRmXkl8gFSVSPc3B01Q9tq5PYJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759438976; x=1759525376; bh=kbhS00QtPHOQ2sGC8RvZMn3prqwSUCIF73N
	/s1bMTiA=; b=oV6FzPWle31aWAQp89AjnmjEh1ghLCxtNEcP+JsyRtkKMyr2jKs
	axCAtLUY7+m38l+nHYyf+kOU0LPBhJVlXOhP5kOWF+L7S0faJYiCLhCbNiNUxJ2B
	NSsDWsQDvc/Tn6sr+BKnIEXFe+T/W/6Hoq2BpXfFmnGNU4sJIV3gA7kKcRTZMnDq
	IaM9FD/GGdzXipI/uDkBmJL9ETzUTIPNt+72ouv3l0QCkbm14l4t45LVcMCplgNm
	PeiVOi5nKm1PTnTRvOEp4S2tyebmV2aMLuAXwXGx719qzclubYgRLZyYGmilg4vU
	KnOGKYdzafrHGpCdHbDIC+JovWc1XqrQZsw==
X-ME-Sender: <xms:f-jeaKrPD-LN3c_YDef6vXCjDoh2yFnEMYwrSB40rdcN8NtKLXsoNg>
    <xme:f-jeaPrnNLVholQIJFd04vSfMTnZhWhvGOXjwjhlrgOpLUFYYuGFvLGvIuEf7pNrH
    GIiPtZ1eDe832Epo6WUE1-sjI8LCO42Jb-Mrd9h0Spr7cENnvDO>
X-ME-Received: <xmr:f-jeaENvU8SEhIq3vZfKvCLnd4JrFD4xGzYWnkKFrwfAU_UjFhXlRtx4t7wc45p7v_DNmiIWSPJF3japcB1RyGzObgN_F7hQC-gn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekjedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:f-jeaIyfYBLV2qq9SxrmWR5t5-t4V1d7SmgIAzJ3AjnGTCRAwxknEQ>
    <xmx:f-jeaFvszMwweGwsP9wFM60_q4IqVnzEbR5kkqB3eRRSmwng4f2zAQ>
    <xmx:f-jeaJ6yFGziJXyiEGGSUwu-siy83lKxIySz5Pa8PbXne9eHGh-Pzg>
    <xmx:f-jeaMQU3dKdH4wwygGYhTKc0IYuwiFm7H9fVVn7O-8QKrS3mVeWeg>
    <xmx:gOjeaDsnvuBsparGWd83VkqfceNd2EPTbwJXzeOF-yRy1lWikxU2nDhO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 17:02:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/3] Makefile update libgit.a: Include xdiff and
 reftable in libgit.a
In-Reply-To: <xmqqecrmyz9j.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	01 Oct 2025 16:32:08 -0700")
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
	<xmqqecrmyz9j.fsf@gitster.g>
Date: Thu, 02 Oct 2025 14:02:54 -0700
Message-ID: <xmqqtt0huidd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> This topic, however, especially its first step, had caused rather
> unpleasant textual conflicts when merged to 'seen' (I didn't check
> which other topic was the most heavily conflicting, though).  I may
> attempt to get a clean merge again tomorrow, but due to time
> pressure, tonight's 'seen' was done without these patches merged.

I think I have sorted it out.  I'll push out 'seen' with this topic
at the tip, so could you please check the resulting Makefile for any
funny mismerges?

Thanks.
