Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD830E85D
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578950; cv=none; b=GpWZije0tD4DDaBulFApARTNQX8jCWdKCqmJARI+BpWRgGSW0wls7Yn/pRM0fpDMK6ky4rv2woF9o8J79sY2ApEyXfpb7MvfVabVbPszZuULIeTZjXqDm7llL4ZR6yfzrLd38U6mgEWpcwUdZ1LuNy9RVkON51CWim9YRDafvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578950; c=relaxed/simple;
	bh=u0iWVPzyu2p07EmT1k9vwI8M3AvI6f+XvrrSz6e8414=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd2WF2ZH+CmFkj97mFFsE/mbLXPyOCdUKCaDiiZFNRQxDIrIHInRGhG+tOcMC+OoAhS6I1mg0hnPz59c8tE4jX/Peul5GmgCSRNSZ4OmDqfQHyeMffHrc/HNSY+ZQfjZy+T27mRfmmNnaMjVO/UD2L9Ocv9uwA+oeG33j5qmIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O+/N3XNJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6HpdM6A; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O+/N3XNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6HpdM6A"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5EF51400078;
	Mon, 28 Sep 2026 03:02:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 03:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790578948; x=1790665348; bh=xNzRPLzkgJ
	OCmV7g/T6+spRtZ/4K1rglTXeW+opXlWI=; b=O+/N3XNJuyZdKPBHaaMKVSEtzX
	fLjqTPJZyrxBtAFlDs4EddoGHqEgNzOSA5YVF8edvrKYkaF1OjvDewaff6PNxtMp
	BFw8knf6S4/sJd2ivXtQq9ehGKKpGMWQIFkIZxgTKn51yBcoVZVkmCMKOcL25FvW
	qumHuHurBCIyC+xltJTlKm/tw1rspQDQ3/1GI7D6HS30WrTOz1UEazzS+tGCtxWj
	3ba455uQ01Ip53pkZdq3p7bBg7UxuPT/icVy8HXA1i0b0FlxitPhez7Svz3hO3Qq
	xleBLOnd5KgFkZrHjZKlX1Qy4n9q8S9UQa6axK+PYKwhVgZJw9dMolO6pTKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790578948; x=1790665348; bh=xNzRPLzkgJOCmV7g/T6+spRtZ/4K1rglTXe
	W+opXlWI=; b=p6HpdM6AY6eRimKbAjRWiHN8GAv4eo/WhgNnk7LSBiIybxZsQfe
	GP+8yHdH3fn5z9pWaVcLQpwiDb/9UhKFw9VxTuwGgQz9+sAAtyjzlypRf6tYhULJ
	PbFYBDeDg2FOhohPctlGlf6Ojv5gOUYpB0S5mQoXkI0xoUppl8Eiodj2+P4Y1HZ4
	KRXTsiSQExxrl3G271J2EwothwzZwl2GFA0DBiHYl4OpN3ANcs719sw5mTt/59WH
	bLTM98d/wIHkxD8sCrfaKwzKnr4vglNSrDpr47ifXB2qz43K4YWqj7+zvdoh+C7m
	nFnX4j1r50W+BYyBeu0GkaCGSJkVlmj451A==
X-ME-Sender: <xms:BBG6alAlQnYl8WESPj7uamxziNh_UNJY4l8ZIewq67KcF0E5GGg_Mw>
    <xme:BBG6aqiDnvDuvXAGo4bSHFBn6ET4RkSDSAne9whSdhPAfhhrQxu7Jbls77QKz_nsw
    iYPg4QgISiwFFF7N_D3bn13wM5V5sTRDpd71JN9RobXdD8DrFRsyvHy>
X-ME-Received: <xmr:BBG6alkMkVo9lrM8ORRe_FATX5utp899Eh2xyu-vt2bT8yMDFQSzlg>
X-ME-Proxy-Cause: dmFkZTFy3vtfF3H7T/gz7633gyobn863E+ffKT8fUjcvWYdG/tDvv8Foc9Kpq+I9lGisAE
    Xvd/LSVz59UIA7tgaGi6XLW52plcW/y52Dv0716EYLajiph9kr/EG/QOrRl+I0gk4nYJ/L
    79kAuIt05vC2yP5gatqwg9NUwcKTQGDuOalL2EEl0aVqnQZGvR4r7GSTBu7bTvnIQoi3OF
    fuDLF2CWSTQnIbaGhvxWGjj3XahfPwD4k40JLmlDX97Po5AKh32KrArJPSxicXpG+R3D5N
    WQL2LRk4zmE0gKaHXhH4PcgfuXFuDic+qs9P7mfufTGUMmWROpTxw4UbkL7lPtOEUErtQN
    DVF6a5MPSEXFfu98MKT5Q6+CoYuREgWpn/I99NU5S7TCgS0sYrLDH4SrHNGYcYQG70BIM2
    9hiUu0zgpBFTjGEMv0dqjkiCupyzguGtbric/CH32WGt40mYHpxAZQOifF5GmMtzknJT2v
    5kvRdQNSC2QN5bhrYQ29iJUApm8kJ/Z/H/kWeP5kgVDwa1x4Kblj0RKn/9j7saAJyr1R+f
    z+UVlocVUdMGEv7+wIiJhUg/f3VwumEg6YHLxKyEpA9tcPSoZ7K9/gI/wcpQOtZS/Ohrtp
    R6OK3jvIznU6DJSmMi9GtqlwuE7/5Jlg2JDgsO91OXKVAA+H6QzjCfeTGuOw
X-ME-Proxy: <xmx:BBG6aupFBkqfanwNWr8e11mUs-HetYsai2ZGxsrk4YApaSubJ-8NjQ>
    <xmx:BBG6amE2dTTm08Y0XK9HXgf6VfyryIVO1yCwP-G57V78v2wkOWR1Lg>
    <xmx:BBG6aiybxTKVQJ6P3nBTKTrR-4Tp053dd0chRGzS6aXCPVTGKF_jww>
    <xmx:BBG6ajqtB-SYKvMk81_AFjkMIyp8uNiqzoZX1zqLb8Ld7KskAYkLjg>
    <xmx:BBG6avh2NvElr7OCfZQKYszApWvo5iZxpj7rP06TUw-Z5oVWtGvzwtrz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:02:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ab52f08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:02:26 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:02:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, r.norouzi@proton.me
Subject: Re: [PATCH v3] reflog: fix default expiry periods
Message-ID: <aroQ_zZvUXKKK7--@pks.im>
References: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
 <20260924175843.8383-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924175843.8383-2-pushkarkumarsingh1970@gmail.com>

On Thu, Sep 24, 2026 at 05:58:44PM +0000, Pushkar Singh wrote:
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 8f78cf4b01..93b5b49e1d 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -153,6 +153,72 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
>  	test_grep ! "error: [Oo]bject .* not a commit" err
>  '
>  
> +test_expect_success 'reflog expire keeps reachable entries for 90 days' '
> +	test_when_finished "rm -rf reachable-keep" &&
> +	git init reachable-keep &&
> +	(
> +		cd reachable-keep &&
> +		timestamp=$(test-tool date timestamp "60.days.ago") &&

Nit: I would've preferred to make this 89 days...

> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old &&
> +		git reflog expire --all &&
> +		test_stdout_line_count = 1 git reflog refs/heads/main
> +	)
> +'
> +
> +test_expect_success 'reflog expire removes reachable entries after 90 days' '
> +	test_when_finished "rm -rf reachable-expire" &&
> +	git init reachable-expire &&
> +	(
> +		cd reachable-expire &&
> +		timestamp=$(test-tool date timestamp "100.days.ago") &&

... and this here exactly 90 days so that our test is a lot more narrow.
Same for the subsequent test, where we could've made it 29 and 30 days,
respectively. But I don't think that this necessitates a reroll.

Other than that I'm happy with this patch, thanks!

Patrick
