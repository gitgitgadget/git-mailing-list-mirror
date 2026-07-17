Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A53793A5
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278333; cv=none; b=BKRt49PnkK1CkCD5Xx6crl51nMqISQtzfb0A0CWrVltcm7E2gJjZ/g+vKQO/F8EErvDr2+SEteBas0LVOmfmRcU2l0pXdc2OkDvcOiaf1xDec78L+qtc5+414DIg0mfulUvFd+alSHwrXKJioJsrUpzbMUz3iK1rHZ6xwFGe3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278333; c=relaxed/simple;
	bh=HU2THjUh697Tlx45NKIWhw+4GGpGBqU6HCVZ5yBaiZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoNTsJ0AEKsHGFx1nMX9RredkTVY09qKWhI6Vc9cvXQuO4t/8rYt3NGpcXaaq7paz5mkl09EyoYi2FfH4kO+mvPJPKfrCVuz+N71y6Cc5TsiBm4HFzNGBr+N2s0ayOj346sStDC+4aRBCg784lzfHp1FaRUW7yQG4Sp68wmWHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JVMd88iE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4y27VWY; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JVMd88iE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4y27VWY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AFFCA7A00B7;
	Fri, 17 Jul 2026 04:52:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 04:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784278330; x=1784364730; bh=HU2THjUh69
	7Tlx45NKIWhw+4GGpGBqU6HCVZ5yBaiZA=; b=JVMd88iEofXa3WyokJEpZOT+qw
	SDEts1jXerUNCFKbrtk0YsSez+CgT+uq5SRDZt0+xthqMLS+llmAa7c/D4bRsvxP
	gnWB3QazBQqS+OceL6237ozhaGl5c75Z6/EPokRkyr1PfaMdwcl3Bq6TZXtjxV1J
	AElk1FAq8x/tH2fUB65OKK95td0sJPjTsEB8BYRmfEc0ix8bTRLD167w9eZ/ZTuP
	9NqbtQkFH/1zCa7EEPjMahxbqMHR6by69ooSa5PyUGFbBe0IkTkD3za/q9xD9+kw
	J27Q1+/Dk5KU78xAs2qDxXaUkCpieN15niPfI9FnDhfZWTkkUNfeCs05jdow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784278330; x=1784364730; bh=HU2THjUh697Tlx45NKIWhw+4GGpGBqU6HCV
	Z5yBaiZA=; b=i4y27VWYkn+hxUr5IFk5g0Jm03Gr8ToHCf3MKWsJCmAXvhOv4D2
	nymmlq5m54NfKSKNBHfwz4psp/bmjRhowKjbMSn6CG509MliBqo7FS30Xkp3ujKo
	4zX3S/v8dUm8fLFcoO/3Lqw3xmJEKYmK3NgjG6SUAbzFOaONV4EB07uPH+3XT6f8
	NxTTXeCH+69FxCLUXUogg5G7mz/wsN4jI51P9ml+Dr++EPdJbLWLni50enkhABUY
	d1GrHfuYfH1BaZ9OBIKCXG1bI3dC/8/6exf3mrPoV6Nf10JCA2lUUaPCn/AU6di4
	729d8wqD5EFxLooggXNelG2Liddiy/Jo1cg==
X-ME-Sender: <xms:Ou1ZatnoU6zYAXdMm8fLjxD-hJ_ztvTiTEoPi-KWzFn5ktTRDmO8oA>
    <xme:Ou1ZagQSy0r9Q7KV4VUmWvWcMSadpCJRy2EJhee0v8uzx8oq156yDKZXxihw0fvBy
    XOIDcf034Kj_3nvjEwtu9Fgeuh73cKc2ZCO3desBTPuNd1mrC8KrO0>
X-ME-Received: <xmr:Ou1ZahBM1JIgkrRKnL1NOFFX78Zg3AGPVM-jC3opqFIsiqzcxYSorbY-cMWpRY8_W5xZWhy2tVkBQfF2_wefS0GzMkAA8r-TvjCRNl_LjnE>
X-ME-Proxy-Cause: dmFkZTFuFJnQqHxf2umRrE5cciPYuToQ341WjrLTeAmR4BUlZHGFP6+k4e+SLJQTc2LEtT
    1O+ZCgVrQ+7FvEmonHdOxOzaxq51ujVjHMvtffq56jckPhvTv6XjESeLsyz/Z4wO0s4yOp
    wF//CRRBgRigQb3EFYeNhTvTBoFQkhYiqAvM/HLNO760I+I22bt+01WaulG/UPmWVPkEcz
    e2kgo+T4t/3990PLGz9IOjxeFLDOUDKE9Fpqfd7O6FH4+h2Jyl367MWtd5IdpljFfrygw1
    z+DcOCVU2GS+uYgXk/65hPeZ+C39ZdHRGxTNUM6I07zqCrP2+myWART1i4CIUOj2yvjSIc
    bJWb8Nej3+zIi7g2ZOfVckGBWM+vJOf6Ls42baWulAA0QJnSqWi3R+MJGChfh/vY4pWDrF
    e1dhvxCjG0dEh/S3+ZmxqQ1JOBqF7xUI2kGnKT91wQlD1noXUCBfDpx6zAngIMqrXwr6oc
    PzRMLtr6yBkxuaZNxG1w+YDxvjS/x5/83fa4/nTG6ljNfWZ1xRzzyy6paiOIFdkkq/Xszk
    w/Gtlu7R0Ut6pPU2LfDN5dAzFzhA9P0zd+zUzzn7igXyuudvpmOvrqHO6PhTzH1hoTAQvc
    2YAfMaNd+CNx/UWSnV+d9nR0a6IoOJKM2yUIgRDJ75M5XB1xQuRddTdbXaIQ
X-ME-Proxy: <xmx:Ou1ZanRGRSi7gDaSD6eJMVNXmLSwmhAZ_5DTUELOWqGtHXeRgr5N4Q>
    <xmx:Ou1ZavqyHFi1jJBm42PKh_n0Pmpdvf1VCh7RZgvJlSnyWUGBHRvibg>
    <xmx:Ou1ZapxRDiLTKhM8AWZ5QzxO5J5gLIvpCy3ChZvfVMVO4S5k-XpK8w>
    <xmx:Ou1ZakLxDU9NV6SKkApEyb4gBpmYxIwFaxZyHS6Nc96q_8cw0xrFUg>
    <xmx:Ou1ZakTpPYZVeXVcuX7r8U5uqxNZ8v1xA-EV8T3TtFd1eIwqidXmPt_N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:52:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b3ef10b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 08:52:06 +0000 (UTC)
Date: Fri, 17 Jul 2026 10:51:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v5] show-branch: convert per-branch flags to commit-slab
Message-ID: <alntL6SFroH1hOic@pks.im>
References: <xmqqwluwpvme.fsf@gitster.g>
 <20260715120156.53025-1-gatlavishweshwarreddy26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715120156.53025-1-gatlavishweshwarreddy26@gmail.com>

On Wed, Jul 15, 2026 at 05:31:56PM +0530, Gatla Vishweshwar Reddy wrote:
> Apologies to Patrick for not replying inline to the review before
> sending v4. For previous review threads I did reply inline; for that
> round I mistakenly folded the response into the annotation only.

Apologies but I'll ignore that advice anyway...?

Patrick
