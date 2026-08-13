Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69236728B
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607063; cv=none; b=EwtfFfTIoyB1l32aMWtdfQ4+OajUlbhqu4P/wxYqrWNARKBQrarYFi3HoO4psD2ijjZt76FpY2ahd599GpnUcXPW4yX/DxLDFNkW/4QLNj5uPDg/m/Nc4TLBjGE8bF+Ni96tZx6XCNuIF8sTLl8mzuSNejimStFVAAu2elLRWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607063; c=relaxed/simple;
	bh=UTtgIMyau8GENpJ9hta7hucRwZGKxwgWz3gUmJgwQ2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxLf4JQeZdqnxPhlGe4veShNMUnhisqa7ymtL85duQOj8eNPHnFP1N5yRRxrxd/sY8ncmJrEmELrR6nAPi2gH2ZrboH6hUIfivbL2gayTZBrsOvjtG7/dnu0P7hhlbRy23bAEmw4F3U/EBPnSqMkLAdD7lFtf7v4t5zJeY12cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fohqV/ki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CI9JcA2a; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fohqV/ki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CI9JcA2a"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D28A47A0121;
	Thu, 13 Aug 2026 03:44:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 13 Aug 2026 03:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786607060; x=1786693460; bh=3Y1StNWp5L
	T4i2P+LRjpYVZQFc1x0ZjEEf+wYXX3h78=; b=fohqV/kif1or3z9ICfc2NgfCEz
	r8DceXQzlI5PPRKhsmXh8ilez+185adHsCSMH/tgK0p7nhxdCdf/sS4edLgXDHCF
	+MdtAtQz5ODcRcPvUtmBwN/KHDJup65jDFkcxo128uB9ybXRWJWiYNfqatUxHBRm
	SE+iE1BqDLBpLTs5lPFRPcUrd8O62B4rMYW3cZrisSQeC5nDrI+42joovuEeYUyP
	W+7n4KD8vEJPxx0RvIC5+QNAJ+hf/USF/P0XT2xNh2FjEuwYwZjhbM52+B8A5eK7
	M7xTmaeSR1AyyI1Zp7tim084hlzri6n2QN1Ox974vqncbQ2brxiWXFuc2ZGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786607060; x=1786693460; bh=3Y1StNWp5LT4i2P+LRjpYVZQFc1x0ZjEEf+
	wYXX3h78=; b=CI9JcA2aSiG2QeLSKmy/OchwVRX8ETHc5mm3M0q6PjlxSLxFiHq
	OqU1dyYrY3PdR2JiKM8ZX9nCZ0Nl/YDSxbkHi4UqK8xXuixmvSfTjZO6l0i0iZFQ
	QpRXs6HMh8OJTKs/H4Qrj4I4B/1/X0IpFHZRni2uIp6iC5e5OWzbZCO4kglFWkLK
	fjpE2duYp/IENGrxC0/MRw7g6mK6qSKjONRXI+E86BFZHf1VGTzS9HAA7dmopl2U
	lq1sH0nOU8rOVyVmhQmu6QADwYrpdC4FBetmesIbtO9Qu/gzUIUM6IF764NH4yYW
	x4bWr51ia+IpTP/pV4vaFsoNNCMh1kCLDhg==
X-ME-Sender: <xms:1HV9aoqNZ2ObF6W-8sbwqS7OKqY6FHUFlFhBQZB8m4iaDrls0MIweQ>
    <xme:1HV9amE3SzXAEWafATll_-sbKbMVQGrmhnZl1lo3A-lmivpfImBLgjbyduNXvYa1w
    h9JiNAu5zIif1cbXus0BzlHu_dZx44EhREzka3f42YqWeHJ2bb7RtU>
X-ME-Received: <xmr:1HV9aqnCsaSW90IR9YI9OSgTJ_qAzM2GUq3LOGcShFG2k9E0Vx13VV4SzMBxjDHUz5jJU7FB31QGEEaPuGfPUs2xD2b7ST8GYerbYMPBwDIQ>
X-ME-Proxy-Cause: dmFkZTGpQpWtIoxnHJvgQJ4VvHh5m+jGu84aPK7YwVFcdCW1Kt2nPMXtvAfc8cuWQjElCV
    YhoAIoX32hWXtnHcoyDMST7p8d86qxArv3VMHdprORAlq3VDAHeBoaCPX2WihS2UFsJXey
    0sUL4P1f2w57bBSKB54fOQO5jEeukFf0Y5REH8PBwF9db7dXiMX9UwPapD7Ji2GyVr7aPl
    c+Yu0UoluuGoVqd0/a8p9T8tMEK7tWMH2xRgA9ZP4nq16mLjVoOi3aQLyfvi/YE9H3M249
    Qxff7YDE7qdRMygBQBxes+ZFERrH14rHUEf2zexW+UiOgXnR8X5kkuzAumExrmSreXnBg4
    z4M/zefCV2QTN1Wi+5hiJ9blsu7D0VDwoOL0nPajzyphJF9U2681zYlJ7YYS64xnHfQCPd
    RGM/m4Mj/wGkBVoextIMtyussv6KeQr/wOetBh6g+OSn3Jdeftc3aOD37S7jOFq4JizmQR
    SmihTsI49w0XaShQyNFsbiZpai8fQooAMB7wgHWFkwi6sOm+6pUarcx+L+9GtVQA+/h1je
    eO7TsPQJMTlOV3sqE+x6zOjr8xpWvxiFace5IcA0daQLkAGChQREUOna6SD2XAgjEFWjuz
    VgUkjgI0TkD6l3vkPOaZAmnA3OF2shLNGfo17Vv9K9Lf6jCKAS/fH8i/bjLA
X-ME-Proxy: <xmx:1HV9apk7Kr_WqnniDTe0Y6buoZ2SGl-QPmEs2xhPHU4jXTwpDAFTVw>
    <xmx:1HV9artR9F8nEQA68IIdGFB6iTi9KmRLPlwPAmt4hHnArq8ANCbZ6A>
    <xmx:1HV9aslPaunbt8HU9lPzFvHZVbajwSHmkBpHwV02blwaSdSbYZVjdw>
    <xmx:1HV9amuYES_Uzi_AZUDBY56LaK_Ygi9OIOLr9ZjGcEf8VzeA3U1uqw>
    <xmx:1HV9arjdn_dXhxKUNQa8rVt_9tbkjaglpyfjn9WKJvOKbFMxPgSbZWn7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 03:44:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c9d72ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 07:44:17 +0000 (UTC)
Date: Thu, 13 Aug 2026 09:44:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: remove unnecessary variable setting
Message-ID: <an11zsTm-fanH8yt@pks.im>
References: <pull.1922.git.1786516959130.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1922.git.1786516959130.gitgitgadget@gmail.com>

On Wed, Aug 12, 2026 at 06:42:38AM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 83c3849205..a0abcc69ce 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6277,7 +6277,6 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,
>  	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
>  	revs.topo_order = 1;
>  
> -	revs.pretty_given = 1;
>  	repo_config_get_string(the_repository, "rebase.instructionFormat", &format);
>  	if (!format || !*format) {
>  		free(format);

Makes sense. The only reference to this field is indeed in
"builtin/log.c", and as we don't use the sequencer there shouldn't be
any kind of interaction between those two subsystems here.

Thanks!

Patrick
