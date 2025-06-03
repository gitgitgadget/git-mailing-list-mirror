Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B544AD23
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748930929; cv=none; b=uxLgBK4m8hgluouupt8lK68O65TbQLHtrY2gWxh28TiosVkI+dMMoO+owY8uiob+58pf8w9LAuCG3NrDy3KGRkf5njxGDWoXs3QBPfWRhSIF/O1L3rrBa+XcDAzxqNurM56bNru9gl3WnBPL26nXEt6uAsQkfaeEK+nr7qR6gRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748930929; c=relaxed/simple;
	bh=MmV7tnnR3yuOJgJjhaEAHnOp0NG9wYfHttyMhjELDyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smIEue5feq45SvwTobfkXl+cn8z2kuY9LEkxSnigyIwpXZkiBVq/EMnXkAw/+D7t/2+L+ey8QuOxVM6xdGf/yi5tvQ2WusqNJi1JhkSKnultVNW/Y63f3wa1nWErIIjOHnXfZ61K4UTOnxQm4w5V5b4QcB/qqs7YdelOEShh0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JJBow4SB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dYQZ7qR9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JJBow4SB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dYQZ7qR9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B9812540194;
	Tue,  3 Jun 2025 02:08:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 02:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748930925; x=1749017325; bh=1f6Zr/4+TY
	mKCPg07ZowUMk+8rBa9tHpdASDfBJiWDA=; b=JJBow4SBnnNi4AujCNvLn2mBet
	fS6BMhdJ9tU+c2wNQSwCr2YW9hg+//C539rS9dlwp+3aig82FNKi/u43tbDVtQJ3
	EkWpz5hsJyVFnx+bcS26xafFqL4J94p/5ZBYJAt1iznnl7gDmkVywEk+bSNEmKJh
	ctx+ESaE8T/zrbYVOr83RCIJ/rKx7Tu5c6/IBfssh0VrRT5GKj1PCOMt2orrxC5w
	6/V5MRsQvcwNK9KcbB8Q81/a9jCPpuD6NXQZfQdaE3eROgA/X9rUaoZOtFJySMNb
	LUH/44RkIzW5PiR3qHO9EtnO29UYFZchzw3rBHkZF8aUhi8IHjrRc+mIIaZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748930925; x=1749017325; bh=1f6Zr/4+TYmKCPg07ZowUMk+8rBa9tHpdAS
	DfBJiWDA=; b=dYQZ7qR9AEZY8EoJRiLS/PHfoBMexRRR94p+KvdWFV2KfJXzS1U
	MPYfP1NWZ1MPGssjTl42dSy+r1QPtVnClu3myfre4mE2xl/YEUhu9j7sr+P7+FwS
	QbrSQ7kuDUJNjqYhojuvETkImOxdyNUJCozglERC7bp1fCvW6fV8HhEEaOiNCJcP
	t+L5HRtwlEZzdHV101A7NjfcefV//4hzIUNdt+0bgwdYSiAhlJIFgqucIP9wkjV0
	1hKf3kNcRI0vV25ncxWBn/t+s7EMKOQVBD+JhZIEWnkwisXq7bUXHJ2rlwEt1Yv8
	A4bFs1LejVaofoQCeTjE7nKigxS/xXQxNSg==
X-ME-Sender: <xms:bJE-aGR-Gd78O9a9IsJv27DYLv55W4yHqAKhbLeJURWEM0WnpV1PTw>
    <xme:bJE-aLzEjvyU78eB4evNdTCPJfd-y82_2MuaHUmMzJJo7UpHX1llckAr1pk5bc12I
    -XrtQUNcCU_atPctA>
X-ME-Received: <xmr:bJE-aD0EOyrn1WqiGUbPD5DDzTr-AXXzxOLo7fvB2Fm7mDLD1iCHZXgEaZsNwYaHER7Ux-LOU83IBt-VIawhByUMB1u5hitGCh4TlBxB2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleektdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:bJE-aCAIDxTEqozocNLBVCwbVvA5Gm0MCB9fkj8GfHC4-OKXeyzWcw>
    <xmx:bJE-aPj5doWhsN4WnaVt4twqP1N4sjrv_-dq4ETSGkG-L2GUT9F3Qg>
    <xmx:bJE-aOraw7k9mHb26N224b3vb_2QlF-PLtyY4QpxARRj-kNYHsldyA>
    <xmx:bJE-aCgDaD0XpZydI2_TKak2RPR_qG2B5VcweS6QZE702TJD_e359w>
    <xmx:bZE-aHpOwd4MF_J4ijKnFv1JINnHWDJzx0dgrC_Mbmv0MHVlwpGGpq1u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 02:08:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cff252ab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 06:08:41 +0000 (UTC)
Date: Tue, 3 Jun 2025 08:08:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [GSoC PATCH v2 0/2] MyFirstObjectWalk: update with struct
 repository and meson
Message-ID: <aD6RY99Me3bPoB--@pks.im>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
 <20250602205021.4223-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602205021.4223-1-lucasseikioshiro@gmail.com>

On Mon, Jun 02, 2025 at 05:50:19PM -0300, Lucas Seiki Oshiro wrote:
> Hi!
> 
> This v2:
> 
> - Applies the suggestions from Karthik to the commit messages and the
>   documentation content;
> 
> - Makes it more clear where to place the new Meson, as pointed by Patrick.
> 
> Thanks!

It would be great if you could include the range-diff for future patch
series. You can either generate it via git-format-patch(1), or use a
tool like b4 that automates a lot of this for you. This would help
reviewers to see what exactly has changed.

In any case, this version looks good to me. Thanks!

Patrick
