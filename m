Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46B2BE7AD
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766125481; cv=none; b=Y85lpr7YuFJ24eW8ai9xVpQyqs1/4uMq9mGBfzTTkQ3ZtDsbyT7noAoQ3JnjZPOoHoZpzLcNJS68R4wkbHlI88XZT0cPMI9tvPbZKJ9KXhXXgxStK7OeXWJigSMS5uQi9FWWTwiz9lfztoMOfJiSXmQGHNaGgdlm1+WlkWpPR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766125481; c=relaxed/simple;
	bh=Zf87Uv94KyLq4Gc40h8AjSePIcwXTuO3neJzilyE/7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3S/H8BeTS5qLYL2ougZfHKojNdACw1xw/0j5hSjbut208t033BtmAVa+Qmt1xpWX0L6H2u8CJHVJKGttlfw9XC3H5U0I8reFC4xUtaalTGeVMimllgooxme+1F4tAFxffmbp5TRENMZMY1kv4F7volgB8BiyM4AUUQJAJFB0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=INYbVcdz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LM7c5m7p; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="INYbVcdz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LM7c5m7p"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E0D1C1D00162;
	Fri, 19 Dec 2025 01:24:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 19 Dec 2025 01:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766125476; x=1766211876; bh=GOyRJNZXc1
	pCE/UNVRhBrk9hJ6e1qEvSfADLoPo/bfs=; b=INYbVcdzvy1xgvr/tOBJHnF38q
	rB2/TSxU6ZXMT4MFueM0r5UKL9hPHOkp6wDga41rBNo96U6c9tMNVUA2dBzMi0d+
	rBQaV4x/LZE1f0T8+FRpaWYfpLODYoF5itRYP0fQW4Yw02F886Ee0dwbnncDO7EV
	WmNx2jzwgChan5CXivdmU1qR4yKs2h1lxqupcVsJ/2vbEAoJzo0T56w9ZgXiZ8JX
	RK1fOkXhUh107ROCI+6GmYAoQdr3YbSBJHnRbiWNlgjGY5xIIvWLcshzKfeKRCZl
	UHbmYTIs0t8JDz7cE87QyRimoGgJqHhiJPAmmin0w/FNmRcjo0aDojRyg/4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766125476; x=1766211876; bh=GOyRJNZXc1pCE/UNVRhBrk9hJ6e1qEvSfAD
	LoPo/bfs=; b=LM7c5m7plyx4s6Ho0yKba+vDsSTzuQmn3z+H0DP4BXQUqyuDZBq
	LKQeSyT6pqa2GPcXlq8O+j9qO6GaDyQEi99fln1wknDl7koQFBKnFQFry6tbU4YP
	I1u+R2nzG9j3kDVSfkNG174lkAsPox5Gc2lYH/Ubsa2mmXlLwrnKnX/QTa4jdzWn
	ygXkaw2yGMfg2/cpFasbpX2htIBw05WpsadkqsSykPHR/qXP95zaMhgApp2tYj1q
	lfWzfn1Oj5oL+rLNn7YwCrsEeLNu5Y5j/dNCe+dGa4rjFtU5cSAGHtYRpgjl+E0K
	yP6L26lL/oviFgF/IBc7yBeeUPRU2qs3T4A==
X-ME-Sender: <xms:pO9EaaUe3rGcmoBsJwa7fXr_qfcAKzGXtMeecZGlngEBK4711vDY6A>
    <xme:pO9EadkKZgSEYpB3dKemcI4zLY252ltgMD5l9auYsecuiCNnDqQRX-4KX2zTvLJks
    kNUWFP8AT0yVMsiWTa8yRnLnSNTEx3gxceb7aYvg8h5_j-obzEUBaI>
X-ME-Received: <xmr:pO9EaTaiJykwMFQ9z9N-m1qeM5xzq_M3qF8co6Dg4Z3PjGoQhpj9VeaSMgtFU3rC3-AP1UjNrfyv3oeW1I9mHr0c5PiBI5mv1SiryHAPnjaNIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgv
    tghordgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:pO9EaQOjhFh8P5sABwn1B9kRIbNalsTVAk6EmdSJmaAg2aDw4r-RPA>
    <xmx:pO9EaQZQ82j7UaD1JQaSA73p69blWqlG7rxfFV6138OVCmPiPWyFHw>
    <xmx:pO9EaW3EnJG81KK1hknamXXmfxdWxZRMIKb0f8XUy5c5Zrb010VKUA>
    <xmx:pO9EaeejoPqrrzcwgSJeLpHn-1cV8hAE6yncClpteeUCYISRJda6rA>
    <xmx:pO9EaZYa9heQ7QTJ01_zV4HrVmWUP0VoZuebGVYaOfIipLeyYwCimTYk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 01:24:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e481cccf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 06:24:33 +0000 (UTC)
Date: Fri, 19 Dec 2025 07:24:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rust: build correctly without GNU sed
Message-ID: <aUTvneg9W-6ba4Ev@pks.im>
References: <a33f4e5118938300bcd5b2991feeee855a1c8f86.1766100330.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33f4e5118938300bcd5b2991feeee855a1c8f86.1766100330.git.ben.knoble+github@gmail.com>

On Thu, Dec 18, 2025 at 06:25:44PM -0500, D. Ben Knoble wrote:
> From e509b5b8be (rust: support for Windows, 2025-10-15), we check
> cargo's information to decide which library to build. However, that
> check mistakenly used "sed -s" ("consider files as separate rather than
> as a single, continuous long stream"), which is a GNU extension. The
> build thus fails on macOS with "meson -Drust=enabled", which comes with
> BSD-derived sed.
> 
> Instead, use the intended "sed -n" and print the matching section of the
> output. This failure mode likely went unnoticed on systems with GNU sed
> (common for developer machines and CI) because, in those instances, the
> output being matched by case is the full cargo output (which either
> contains the string "-windows-" or doesn't).

Yeah, I guess that's what happened indeed. I seem to have confused "-s"
for "--silent" with "-n" when I wrote this.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>

I'd say that it was you two folks who figured this out, I didn't really
help much :) But I won't complain.

> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>  src/cargo-meson.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
> index 3998db0435..38728a3711 100755
> --- a/src/cargo-meson.sh
> +++ b/src/cargo-meson.sh
> @@ -26,7 +26,7 @@
>  	exit $RET
>  fi
>  
> -case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
> +case "$(cargo -vV | sed -n 's/^host: \(.*\)$/\1/p')" in
>  	*-windows-*)
>  		LIBNAME=gitcore.lib;;
>  	*)

Yup, this looks exactly like discussed. Thanks, the fix looks good to
me!

Patrick
