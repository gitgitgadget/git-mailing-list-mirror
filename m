Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C41C06
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294700; cv=none; b=J+aO79CCmc4vG8cW30T5Q0xZdj7u2XLuq/gHnScudFETDWlOR/EBUUAX/45mPqtamodG9mZhKk/XeCYydkLvu4Sy4D9rhxSyhO+g7UmJ4sU2GSrh3fnmt80aJcBXb+2JH8dE7EiigdE+TQ8s4ObG7K2s5f7pNUEE6EoHTOGs+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294700; c=relaxed/simple;
	bh=003yZ1OEBjbhU0lOlkTWrSrfmdmEKzTo6qw15/NdHxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD88YOYTlbDyWE/T6D82J3asYnSaPB3Jb6XUkCDJdS4hYF6KrY6cLlvDrMc5kj69Z0M2mXXNNDhEx2vv76K0gyPFJfWyh0tm7XCkvKWHuq5dwLsbFuOOL8RpEEdtmEpr+zsLpMAeBIPWHedYMU4EhDP+aEs2YPOak5j4pB5sMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=hEpxb6f8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfxCEwke; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="hEpxb6f8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfxCEwke"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 855A211400AB;
	Tue, 16 Apr 2024 15:11:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 16 Apr 2024 15:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713294696;
	 x=1713381096; bh=uDcwapWae8s34IXB6KTyWxIxZLdsJTq8vovaKsyOaqE=; b=
	hEpxb6f812j4Pq3vLqOzUqSCpnwX8wmDq/a9AeT8bYG0pS5gcuary4ireTzWD5Ev
	bVeNfYSnZk70z2EfynZTLUCaLTK1dsXb7OIIbWEb0L5+wPDeIWXQKSRvHQF6D4K2
	/uHeNgJHaztzawJ73hhXzcVGYt4d9g0Te/4NiEF5BobzeJTp1u6ZnRZ7bDlxamxy
	lRh/qMwl/2yV1P/a+cOEDCTCHdqaXpV6/UvkqpLjAkAsJaaaH6za2HZE/XGoE2i+
	/QV2WIEcmkwnHA25GTjYNRRQqdPq9JR+7WbBusAJYSnF34GpJngzhTZ6gpjEqykq
	1gdzYjZ0J9vQsf47xwneuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713294696; x=1713381096; bh=uDcwapWae8s34IXB6KTyWxIxZLds
	JTq8vovaKsyOaqE=; b=NfxCEwkehlUEDCslasrjJzIsR87Lfe5fn1BitwJxiFbg
	OdRvIeNxgjgLBMkitkaadu4bhenyLXcKUq3LPoc6WWliLYlSn/GCNF9YdC4i3ERM
	xhdVbViBJfbCVsLX9eyfkVfeD1RRRMAnXpbKPpZqU/W2dRYR1kIL50inF1EsPuU+
	GUZL/rzGt4t/fCepQZyi8i1dV1axlEmgran7VSz85OA9MesR1Uwzj++QvqpXW+D5
	zUoeh8tn5l6YCVwoVgOoEA+5NBVyO7waf14QjSGfa8UXH2XwZRFyh10xdmc8h+YI
	73q9H9ieu2X2NamctZsmiSG9np4Oj3n1hbNBu78v2A==
X-ME-Sender: <xms:aM0eZvb544hpHQmUrOprFrKdxPaqsaoG2QZkS_yHMEpF3qKOlIG0Tw>
    <xme:aM0eZuaNYiZitf6Ge7lW7Z-GMsVbS5XUQGFnVRJUDe65SXtOexGBhiTHTTrd8Z52i
    -u9BzjQWboPjTxRNY8>
X-ME-Received: <xmr:aM0eZh9n2x7-4b9sMdZNXNuGRTmM8GkPXJ8ezhHRAXhLcoD1wHXRbiw6gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeflohhshhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhs
    hhhtrhhiphhlvghtthdrohhrgheqnecuggftrfgrthhtvghrnhepudeigeehieejuedvte
    dufeevtdejfeegueefgffhkefgleefteetledvtdfftefgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvg
    htthdrohhrgh
X-ME-Proxy: <xmx:aM0eZlouiHng03w6n62VKeUH7r9m4PruDzdxOpKi5zNZEn3NyBR7eQ>
    <xmx:aM0eZqpc3BuXuGCcQsIzQ9VcM9oF78c0Akr2awkRqEwJ4nPSQ6neWg>
    <xmx:aM0eZrTMsjHpptvzvmVxI2D8v8o-OicmmTiXcI0q1rleINnNj5-wOg>
    <xmx:aM0eZipymA0WgZ9U3HeAoMyZ8ul4RiHfVtaPOhmJrF9eYHSagkG-GA>
    <xmx:aM0eZh2VUiyRpv84WFKnJm-Z-NaAaHU9b7pvruSP7A9flOWfU1wXQvfB>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 15:11:35 -0400 (EDT)
Date: Tue, 16 Apr 2024 20:11:34 +0100
From: Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] advice: Add advice.scissors to suppress "do not modify
 or remove this line"
Message-ID: <Zh7NZhB1n2o1k7jI@localhost>
References: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>

On Sun, Feb 25, 2024 at 08:21:54PM -0800, Josh Triplett wrote:
> The scissors line before the diff in a verbose commit, or above all the
> comments when using --cleanup=scissors, has the following two lines of
> explanation after it:
> 
> Do not modify or remove the line above.
> Everything below it will be ignored.
> 
> This is useful advice for new users, but potentially redundant for
> experienced users, who might instead appreciate seeing two more lines of
> information in their editor.
> 
> Add advice.scissors to suppress that explanation.

Following up on this patch. Happy to rework if needed.
