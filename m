Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67117993
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738539671; cv=none; b=UPB2cMErU78gHwrZxNX9DlMRuVcmRZ/u0TLYR4yXE7E9ORxIJh7/SQWIQ6QymofirFR7ER3isr7WEyTwyXQ4NU0eYkWyxT2gHtHrvtDg7Q9RR6Ypxlzr9uGYlZ6B9AoqKNdWe4pTV0NavgaZSvyOvu5Ow+rIPK3vLI+rgtWDuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738539671; c=relaxed/simple;
	bh=XxUnEN9UBjyf/5I9gNlN8WU9Rni2oToMS9cSN7/CKK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ReAwuQO8K+gOLXKwT5N4CnKzXpklQLMlPSd6ATgL0GmZNYc65D3M1RrckKOMqhfPPHGZsQE1HQwgA4nGvs3qRwo4hYaGjopKw89/p7E7DVt08fJ9//ZHMJasjV9r9yoPadA0ZAKlLzz9z9sZa9/L5mXyhfI9jxdsnQY7AVpYyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gwjiS7M/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SvSdZxbV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gwjiS7M/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SvSdZxbV"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 524A81140114;
	Sun,  2 Feb 2025 18:41:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 02 Feb 2025 18:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738539667; x=1738626067; bh=iNQfqlT67h
	QTjde4KdWhEKmmCq5flG0Q9FLxu8+sQWs=; b=gwjiS7M/2FwC06wuBLfsWCewSJ
	VzGu6ZRZiyPQ1UUAUHSyLhzJcThCa6VjaFLLcsSHfktdgfwxdvHb45PR/dt6DG+w
	KZSjstldtFBYjMDsAgMzhzCssTIvMnwKBxti2gOPge+uqV407BtvOOKKpYx0D0Y7
	frsLWrP5gKdCn4D+hOv4raALz43p24tdSP9hW6l1+NOy9dfUkxzltd77oIqW9uUu
	+sLJSzoaC/A+Y/rMhheVghXy6ZJlE+wXEm473pVCncgdeSY6Gzs3Rb7Ht/hGHxT/
	NRRQHz1XFZfi08YHOGKwQFMCgBToUP65IEuHhwSJPwk80YmMnqi0orc+3T1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738539667; x=1738626067; bh=iNQfqlT67hQTjde4KdWhEKmmCq5flG0Q9FL
	xu8+sQWs=; b=SvSdZxbV5E8VgK9VLKA7V57aux8wfx9IJFdMOHdoGo4HYrvn9uG
	298qtv+1Ta3tSrGteK/iFZ6yUIR2xCxgGDjRdCytzywB2ODVCKv6IaDlq0y6tUav
	0MY6R6ijzcGxeEyFsml3JOYyhpc2AyTidAE3JrBGym4EAMGg3fBylYD9xRnH7Xc6
	vwY/NjBYmwe/9asxlcRwkLf7/uIc1A7s+sW0xZLgV2VhiAIAlzNyjx9ar0nHgvJX
	ezecJTjXq2lFGHp85Mqy1Ri6m90DcaBI+YeWf5PZYhv/bhA0efBr9rfniQ2x+y0A
	PYq7AtLrJYlY6r+zzYWN9r86q9+yDg4dF9Q==
X-ME-Sender: <xms:kgKgZ9yv8XXyI-ay_Iw9KSjA5wJW6Y-NOHzWrs7Ixi8tTxb245Zoig>
    <xme:kgKgZ9SkrYod7ugDd7MopkNIF7PTGfKwyqyvV-kT9EwjF06rKw-BDisCwV5_CAM5b
    9v7rQUB9-2or272DQ>
X-ME-Received: <xmr:kgKgZ3X-1dCk5VpP6vxRLocOKpPnmsRs9PGaIexje9wompPVXqD-kgo0XCchF_mBiWOT_YMkZL5xNVGXu45GpiZ32EXEyvwFEpGW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehrshgsvggtkhgvrhesnhgv
    gigsrhhiughgvgdrtghomhdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kgKgZ_jheXz8RRqltRBCcfwff4MdEo4w3Ye2u7ZkplnudcDtw_SQOg>
    <xmx:kgKgZ_DKzR3VLLp4Lq5PbW6PELioVIEGjgLju4cTl8dyYNVXQGt9mg>
    <xmx:kgKgZ4KkGUtnZ4YtUQ9WYu7Re5YpijLbjRFa5g2kv54fyQ9OS_tlfw>
    <xmx:kgKgZ-BoLdr-qCDdHCMbS4MUu8XF0dwbPwDD4wm-P-w6rJF3N9NzNw>
    <xmx:kwKgZ7twKxCIsxS4-HCY4OqLN4S8v507bngyQcg7zVjS_WbVX-SXrSHu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 18:41:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  sandals@crustytoothpaste.net,  stolee@gmail.com,
  Johannes.Schindelin@gmx.de,  rsbecker@nexbridge.com,  M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential: warn about git-credential-store [RFC]
In-Reply-To: <20250201025413.GB4088801@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 Jan 2025 21:54:13 -0500")
References: <pull.1856.git.1738352886190.gitgitgadget@gmail.com>
	<20250201025413.GB4088801@coredump.intra.peff.net>
Date: Sun, 02 Feb 2025 15:41:05 -0800
Message-ID: <xmqqo6zj3ofi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Jan 31, 2025 at 07:48:06PM +0000, M Hickford via GitGitGadget wrote:
>
>> From: M Hickford <mirth.hickford@gmail.com>
>> 
>> git-credential-store saves secrets unencrypted on disk.
>> 
>> Warn the user before they type their password, suggesting alternative
>> credential helpers.
>> 
>> An alternative could be to warn in "credential-store store". A
>> disadvantage is that the user wouldn't see the warning until after they
>> typed their password, which is less helpful. The warning would appear
>> again every time the user authenticated, which feels too frequently.
>
> I certainly don't disagree that "store" is relatively insecure,
> but...who are we trying to help here? We do not turn on "store" by
> default, so anybody who is running it would had to have explicitly
> configured it as a helper. And there's a big warning already at the top
> of the manpage.

I buy this argument.  I think an earlier comment by brian was on a
similar wavelength.

Thanks.

