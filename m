Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506DE3A8F7
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360367; cv=none; b=hHhZYhNIISfuTRNK4/nc5way4cgIu6Z8VjnEjJfefN1TNJ42dRiuF1Nl1i9C4UnAHPEK3iiEwM8igyxdPr74PdYsTHs2eIXDsASmGZViPupp2Ff4jE645dJtR0ho4C31nNMxpv5J2G/n10QPrXd6xJ8GTIsh5aSj0uE8ffxlBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360367; c=relaxed/simple;
	bh=MBMqyQn/9v3OUdhVqntE6HaM2RFpukI7b72ZYoWtP9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF4+eUQn74jB2wmgKsomEsjyoE8M/ryL9cuDvWIfPt46hj5Wp+MtQrSjy4hZlX237uPZ1B655yWmbkixNjikhNjjiD09P84uTlsnLNCeWzYQdre0JPF0N1bNcBuPh9pmHZvU0a6o+Vl8VmYXCXlrm8jGW21kY/2XBQNAxH8YTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nOaJrghy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A32hg69q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nOaJrghy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A32hg69q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C5F613802AA;
	Thu, 26 Sep 2024 10:19:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Sep 2024 10:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727360365; x=1727446765; bh=rR7fS5G08d
	/L0AE4wHd4xHTQs9Jcb2RYxEgFC1HfFoc=; b=nOaJrghyn/BpQ4Xb2UMXOjnuvy
	e9KmPTyUCpojGlpUu9RIHc2Z3+24O84E2WfM7PJP/JaNkm2plLdD/XVx/018r2Zt
	DCCGshya2ZTwdALG4T/TvMXd3y7PabNoW172w03PKxufXb2mBoQV57wva2c9YWeX
	b70OkQejkQ1BGFTcBLES6k2ctLgRO7PrtCljBRj9QlSmrZ41E3RjlLtr2VILk+P3
	gjRM79YB07x4xIqgZ2sgqWXVLEtnP51Doh9tlAbujm0ZuvI7z9fHnvA9rDINRl7j
	nBK5KQtmzd2jBtecSkMBQAcmd+SyPcf2YAjOb9JtzKl31Z9u3ndw4kT9ocGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727360365; x=1727446765; bh=rR7fS5G08d/L0AE4wHd4xHTQs9Jc
	b2RYxEgFC1HfFoc=; b=A32hg69qT3+fa+LYPKRJXS3/cK2yrBKlziiKgSlc5rVA
	ULN9l1nrm0NhgUZwwbDNfmGem0AK+9e7KUUMoNn7Sh1sawc5TosK+HAQymAF5E04
	Vs37uxWpkVtM5OSjGBEGH9LBHPyTTxXERgHrZsIU0C6MD43WEX/dh+VEEgQRHO25
	dzAeEx7TdBI8b0zWBzEYv4nQuEBMcrZkJSWIcl2tcXjMltdNkURz4vun58Zqjlo2
	S+8ILkBZx69Zd7aXKjHLsz2DFBsFrgNAwZvgaOGAmyceMYttQcsmfXBDASgmbWEe
	kQcic8Sy6MwCo3UdOy/39BkmdaNz+E3/421ZQlnuSQ==
X-ME-Sender: <xms:bW31ZmO7cuJNotHTldU6NuP6ayl_C2Gs5vj_EUcES0X48rEcEoFn4A>
    <xme:bW31Zk_XbmCdv0U48SK2XqZesZyo0Ohu7IDzqXGiUEVUzapF3iQRoE5umK2cz-9H8
    kaxwOGOumlisbvddw>
X-ME-Received: <xmr:bW31ZtT-1poiMzCQa4kRYE42KMbox5POuKARNAHsHWYwgZNFTNOh_3BXDSapkEP1k7yZYdXwXk_v41vGMDXVgW_HXtBBpEXgX-WEJDglG869Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:bW31Zmtk0B6ruEq-DP3iXZbYfzqs0nfVtN9fmMGWO5j5SI90HSiyuA>
    <xmx:bW31Zuen2vE22TbcB_bxpIEicO97ZrPE3qKndwZO0nuaoAK68wzMXA>
    <xmx:bW31Zq2jzQjMSrEnoV-1aMkOuAVcxOH9Wtar4SHaIfmUBbTZCfVvGg>
    <xmx:bW31Zi-wtdx-z08Wb7uaUazLiElYE8_kgUYTqC0JDEw_joPW8ptvoQ>
    <xmx:bW31ZvoqpnW0sPiALRGc6aDMsbvvRNFjUB3g_p1VgnH9_1vBdopKODZr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 10:19:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2db24ba3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 14:18:46 +0000 (UTC)
Date: Thu, 26 Sep 2024 16:19:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] test-lib: show leak-sanitizer logs on --immediate
 failure
Message-ID: <ZvVtafQfwnh6NLmQ@pks.im>
References: <20240924213404.GA1142219@coredump.intra.peff.net>
 <20240924213636.GB1142403@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924213636.GB1142403@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:36:36PM -0400, Jeff King wrote:
> When we've compiled with SANITIZE=leak, at the end of the test script
> we'll dump any collected logs to stdout. These logs have two uses:
> 
>   1. Leaks don't always cause a test snippet to fail (e.g., if they
>      happen in a sub-process that we expect to return non-zero).
>      Checking the logs catches these cases that we'd otherwise miss
>      entirely.
> 
>   2. LSan will dump the leak info to stderr, but that is sometimes
>      hidden (e.g., because it's redirected by the test, or because it's
>      in a sub-process whose stderr goes elsewhere). Dumping the logs is
>      the easiest way for the developer to see them.
> 
> One downside is that the set of logs for an entire script may be very
> long, especially when you're trying to fix existing test scripts. You
> can run with --immediate to stop at the first failing test, which means
> we'll have accrued fewer logs. But we don't show the logs in that case!
> 
> Let's start doing so. This can only help case (2), of course (since it
> depends on test failure). And it's somewhat weakened by the fact that
> any cases of (1) will pollute the logs. But we can improve things
> further in the next patch.

Yes, please!

Patrick
