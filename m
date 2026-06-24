Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECD22652D
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301625; cv=none; b=BHa4j8K/cruwG1X+N9QOTqcwAR7ynLYJibOTbOYygF+tF6GbEAVOyKe4YDqKGK283bmIUCscJOMsGunohPOh6xpTZqkVCmYTtFnQIdHJWs8t9Tjo9Ve0e++Ncra9V62bdVok7BPTJQasOkkNq/fpXBqnyxnRcMbrZFSxHKxeIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301625; c=relaxed/simple;
	bh=A2RkW/2BlzGbmnVAd40gPPjz1n4XCcD9ekDQbt2Vdi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5JdvSsgpeOXC0uOkDSJN+iYjPLp66vwBEhDwHrYGczsEr11ENUPZeXqa3R/m4ifNYR0fufNHcij0/0A4sl0G2Mwgyh/6vt2kIhQMm0xBjK0XWhGItVMVhcHpj+O/I7UqPU8/VfuyVn8gJ0JG+1J+PYuGzoG1+06XkXhcK/TFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=deaVIfmv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AISxc6RJ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="deaVIfmv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AISxc6RJ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 146B07A0104;
	Wed, 24 Jun 2026 07:47:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 24 Jun 2026 07:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782301623; x=1782388023; bh=FV0ozG/v8c
	kZMNrrgrMa/cER8PCw6vKEUdhXvOmTj7Q=; b=deaVIfmvLCAMA2vAqfDarUA+br
	jVUKFE40/7Bl2rmd6TJ1IvTq/L+BbPPhBoYXlh2GEFtA3asUXwSXorsmSBlbh4MZ
	uHONy3GOK5ssx3FfXC1k/zbvqahtnY4TOUFbVwcgQ7M0NpR9yyPhILqAFEgD5Z8V
	ogDQxfbkmw/S9Kyg5iv2lbNut2uO50QRSmDDv9olD106tB/h3GPELS/gadg++LVe
	XY+oXungnjqhjPrK1Jv2EuZkYi/ps4NNil0LA/fx6+iKPIvNyk6tNvARuqCWQoZ3
	qJ0Zgx880ttf/4aF9yX2emyUhS9MkHmRsrbSz0Ye0NSJw2x1zP9H8rRoOhaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782301623; x=1782388023; bh=FV0ozG/v8ckZMNrrgrMa/cER8PCw6vKEUdh
	XvOmTj7Q=; b=AISxc6RJdti7DGojKX61uDRyb3dZytvTMm8/ng0YimuQr+o4cCM
	HesMXteff0dsxq6cGBKDP6O8bGuj5y9egMQgyTYwFHJCR/EzOgRyQbm16cgVDn1H
	+WpBYOrGXLpf4DVpEc00NRPbySGnPijjvfTatfLD7ozVkbrpg7q2yYcRXoe+KBxk
	zt9HEXKwKPwhDWLqNPGwX1xYUSevPfJlqP8SaJy7m+SUP+NSZNSMcAPyYJ8U2hlW
	O0wLAfxb1/tucIB9SPj20ZVzqg2MUJzJNfKcz8/hoWb44kopn1ZCHJp8DLaFs50u
	u4SbY4yWiy6ToyfgOGaL/pwi0YF+OksmE/A==
X-ME-Sender: <xms:t8M7amTo4vzq5U6rDPOM1Ilp0vOt9OQdF4i8aUMNMgGkX3x2ggp06w>
    <xme:t8M7ajPCaC8Yfg3L7sBIyt9ngGmfYpp4YZ46mqEDuePLmUn1WXqdV2flLDxGc4jwa
    azqiEqxHGXEqdJy32NbAQxm5RPFWA_7jq8T2lImg2dNhHnQKqQzVw>
X-ME-Received: <xmr:t8M7ahOKlsM5joyCkfST-gX53-beXWyWJ1v_rmAMy90bkmko21uWnLdDNjdpHqJOYgxQNQ7ogJXNgswxTKe1iir3GPD416KrFPX6Yh6t>
X-ME-Proxy-Cause: dmFkZTGl6/q6xYKiR5peaSJ57tqZeCZImwaTg0DWQA/murCGlmVqKfFrwAiVcTb/tfuQH5
    bVKjIz4q0mvhRKy+c4YSl8sieZRHLiBOUZwiE6cc9Pck39dVAdI0Nw7/KmUVQ4CftHz3u+
    maxf1XBHrvobAsxeOvdPiojLtnmJhot86I2YIko1gUlN6CWSYNSK4aFJGWe5PWChwE08ap
    JuWiyiNpxeEpiVHTOS0GaWnQFnEyf5UPlx2KDeZIKMaLHAWUtmLui3F1lOlg1cOcPIiWZN
    ZRD2OAiTXCuN3tSPEds5kwiFzkwvlWXPtVbWZsA04mOEa1tCj/x47U3Z9nqam+Jc2fGGHl
    DkSVGWfCCZCz7e5uTyNNC3c4/PrRadgeRMui9Q+oUHp8ir3Mh5/sgTZV+tQpgHh/pbon9G
    h7Gy63FSvwsadTy9uRr6jVZj7aYwIhQZBUsFIq/ipUOzc7f08f/sd4Nv8pC/CDaGEFCiYg
    7Ly+iGKOYAAs9LxeyqrrBVqLNA1ZNVHBfH4SmwGPxK+KS/3tWCsQy4I3/bvuXfxsGVrtcB
    dBmzstWQGZm2WTVxnCm7EJZy3l8Jm4dM3UX0WKb18TXKKaYLDfP5Yrowe/p1LejNUqUX5s
    BJ88mC56/aJ709GgsoctzvmABy9t+vJ90ge/Sc6/mv5CD793j5jNlPz8TWMA
X-ME-Proxy: <xmx:t8M7artfdDMhd_VvjtF6QsOmjKipBJyUn6-IEGl4LZSd1LgkaUlxXw>
    <xmx:t8M7ajVAVEv7IMgHPQLC3jyE72hqOA16lggF4bXgjOCSj1zp_EPJHA>
    <xmx:t8M7art1_PUHzbk2A6ws2PbaFwAykx_YVj1d3eL5nRsjNy7CksTtcA>
    <xmx:t8M7anUse65dCQj1qZpXQTjFc9WpIWI806ILiBR90qa54GQX9VLQ3g>
    <xmx:t8M7ah0fDKZkrLgfZIWeo1qNGKLmRdas_WgDNIG5Tcc8QJfHPuc-Ku-f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:47:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f148ab8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:47:02 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:46:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] doc: advise batching patch rerolls
Message-ID: <ajvDsy1qVCZoqiCu@pks.im>
References: <cover.1781714757.git.wy@wyuan.org>
 <cover.1782028813.git.wy@wyuan.org>
 <e1050a6ef5e26299b2c6d9743067fe3d7f4f8071.1782028813.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1050a6ef5e26299b2c6d9743067fe3d7f4f8071.1782028813.git.wy@wyuan.org>

On Sun, Jun 21, 2026 at 04:05:34PM +0800, Weijie Yuan wrote:
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 00704ab91e..35105bc3b4 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1330,6 +1330,28 @@ previous one" patches over 2 days), reviewers would strongly prefer if a
>  single polished version came 2 days later instead, and that version with
>  fewer mistakes were the only one they would need to review.
>  
> +This consideration applies not only when going from the initial patch to v2,
> +but also to later iterations of the same series. There is no fixed rule for how
> +long to wait before sending a new version. A useful default is to send at most
> +one new version of the same patch series per day. This gives multiple reviewers
> +time to comment, gives reviewers across time zones a fair chance to
> +participate, lets you batch feedback together, and gives you time to think
> +through the comments you received. Knowing that you should not immediately send
> +another version also encourages you to review the patches more carefully before
> +sending them, catch small mistakes such as typos and off-by-one errors
> +yourself, and let reviewers spend more of their attention on design,
> +algorithms, and other substantial issues.
> +
> +The right timing depends on the topic and the feedback. Larger series usually
> +need more review time. If the only comments so far are minor, such as typo
> +fixes, it often makes sense to wait a little longer in case deeper reviews are
> +still coming. If the comments call for substantial rework, do not rush out an
> +updated version before you have reviewed the larger changes carefully. Instead,
> +reply to the review that prompted the rewrite, say that you are preparing a
> +substantial rework, and mention which parts of the current series will become
> +obsolete so reviewers can avoid spending time on them until the updated series
> +is ready.

Makes sense.

Patrick
