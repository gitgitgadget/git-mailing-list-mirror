Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0932394474
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777112469; cv=none; b=TnDHTobOAgKc1iTn3OdDTQxw5bE/Mox1zkFuOw4sYFV0cy8niRXwSBaC/IvVLqF5+3K0/82TbKfg+7b0Dkt4ORQ3HUrU2l55X4Z4fNCpm/wgULja+OzlnwxVZqThMoV8BGsbegHjR3H/+XubbM9QlhHmd244nJ+fJnzxm8vnKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777112469; c=relaxed/simple;
	bh=xxgBTWDne+lJWcrH3oRoCyf96aPQtR8Ycr6aDAXAvwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MeMt4PVdqJPUNPrjgA72j+S7qX4hsBR0ephKUgruv3wlSs6kxpPeUNVd9aFTgmgIHRQ/qAVc6oFPf8VxgyJA71NI4AAtO+vmMyGEKvaDYntzxV4P4Qyhhi+9zGENHQQ/6N5Ij1ixde6xcVYkbunQEI9nR21floC5mKE2vbT4otY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CUScjwSq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGJbFING; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CUScjwSq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGJbFING"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E261DEC05D5;
	Sat, 25 Apr 2026 06:21:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 25 Apr 2026 06:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777112466; x=1777198866; bh=k24CBfoya+
	46GCDrr0Qz6gbo1IbwrLvxbgxf1tfvixM=; b=CUScjwSqB7LrxIi8vSGYJk1pVG
	NxBL3/Z2sMrXUet5lGBkolFXnHRbbaUM5YKYIwLyyVoH8Lc5E69RvwWBVYdZfZV+
	bWqxLi5bWHf2YHvAHWW4sWMJEnV4KdGQF5qO0meTAXeH5KWgbUGyVYsv0twm3/3t
	QNN89dLLf51oI73Br6Go2mkFnQWPmZDxmH+grvz53wwNx0zcn0fR98VbMNxgLbOj
	di8afIdQ7jMYn/0SyP9VhVdCAuxptdNsIlnRLZy/3EmV/GE7hQzG58eTSj6UARyx
	PaNgf14/MKafQBBhGFp30biWPjcGQJNPTKdME3khtFBssYUD1LBIehQlCrqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777112466; x=1777198866; bh=k24CBfoya+46GCDrr0Qz6gbo1IbwrLvxbgx
	f1tfvixM=; b=GGJbFINGSKPj/K+IkaMs++8ajGzABQt3GwFCOKDhiFudOJuN3bA
	bdBsnTnPZU8P4tnedJuo5KfefVEgS68R+5AmS57JnwmZWW+0+CBI38qh9jTIuju2
	BgDqDaTzfart87rgGWThBboHdyE4hXM0U+lRR+jGeFS7Gs52QIRa2hTuMRj1Xr/S
	6iELPVwUwfmfpIIjnoC4VEoiLjim3aDErQXD6yvH+RsNx/OX1CCJYa43IhISgeCM
	57hMB3ZQy03yZe/MirvZeYmA5JcoFeSkUCFfP6rWQhuevQRzD0Mtx8MrKU+U/CtU
	7umuHJEMKj1GkykG98rumPxQoo2+pX6L/Lg==
X-ME-Sender: <xms:kpXsaWZ_oZ8wmqz_f1wgOgCox7RHG8d0nShqKMJqvU9Hm4TMIKH91g>
    <xme:kpXsaXPwYM8Is8scYEIFDtt_iV_6zrxftXIf-VXD7BcFVKjDDjsyqK-Siz_bL6P36
    7hVcH3CMl9caJH2icr7DAsu6hanx8SAThl59fk5A4zZKPOPFtT6ZQ>
X-ME-Received: <xmr:kpXsabboknUmbBGT2WxGkQj-6Mw2R-BBGDy7EyP7LD24AEIQ0QW11KXyVrO_fTybkbP4FM34G0BTmyURIMRsfh4cYK5fxef4Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejvdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shgsrghuvghrshhfvghlugesghdruhgtlhgrrdgvughupdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kpXsaV3n_rb_fsRS_kumvoKqtLTvnJtxo--TTF7u7jsw56xsbG2i8A>
    <xmx:kpXsaRckDWY9pL5Z24f46CrXTJP6_1zhBefnBkgAhT86ftbnue75tw>
    <xmx:kpXsaWHuZZTlm3z2m8XWYaeXuWjbYGGmBTh1YPoTds8uN2yzbve0Cg>
    <xmx:kpXsaS04EEbVn5J32w5-Q3Tbh5bwwH8YCPVIJ9eTeBN7_wRTetz0Eg>
    <xmx:kpXsaY5ZWQXKlbwlfB58gOWFrVOJq43i9o7aAA8QZkQ9ocj4-AQK3yTW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Apr 2026 06:21:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Scott Bauersfeld <sbauersfeld@g.ucla.edu>
Subject: Re: [PATCH] index-pack, unpack-objects: increase input buffer from
 4 KiB to 128 KiB
In-Reply-To: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com> (Scott
	Bauersfeld via GitGitGadget's message of "Fri, 24 Apr 2026 19:14:58
	+0000")
References: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 19:21:05 +0900
Message-ID: <xmqqldeb9w8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
>
> Both index-pack and unpack-objects read pack data from stdin through
> a 4 KiB static buffer (input_buffer[4096]). On each fill(), consumed
> bytes are flushed to the output pack file via write_or_die(), so
> every write(2) moves at most 4 KiB.

Micronit.  Output of unpack-objects obviously does not get flushed
to "the output pack file".

> On FUSE-backed filesystems every write(2) is a synchronous round
> trip through the FUSE protocol (userspace -> kernel -> userspace ->
> back), so the 4 KiB buffer turns a clone into many unnecessary tiny
> writes with noticeable latency overhead.
>
> Increase the buffer from 4 KiB to 128 KiB, matching the default
> already used by the hashfile layer in csum-file.c.

Quite sensible reasoning presented very nicely.

It may probably be a #leftoverbit but these three instances of (128
* 1024) may want to have a common symbolic constant, like

    #define DEFAULT_IOBUFFER_SIZE_IN_BYTES (128 * 1024)

in a bit more central header file.  Especially for the one in
csum-file.c where there is no symbolic constant used for that
purpose.

> Testing with strace on HTTPS clones of git/git (~296 MB pack, 5 runs
> per variant, isolated builds from the same v2.54.0 source) shows:
>
>   index-pack pack file writes: 72,465 -> 24,943 avg (66% reduction)
>   total write() syscalls:     310,192 -> 259,530 avg (17% reduction)
>   writes of exactly 4096 bytes: ~40,077 -> 0 (eliminated)

Hmph, I would have expected more like (1 - 4/128) ~ 97% reduction.
The difference between that and 66% is coming from where?  There are
inherently short writes that do not utilize the new larger buffer
beyond 4kB?  If so, another number of interest might be the number
of writes smaller than 4096 bytes, perhaps?
