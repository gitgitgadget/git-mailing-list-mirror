Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70781385D63
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555672; cv=none; b=RJg3kxZkpXtcM8lZ7Q91x9hG7XMdLy5YYmsTRWeE+IP9kL3IO5/1l/YaIHfiIMhXWHhfjXawa12+0TED4AQ8nP2wWuQ1CqrqhdVntWWkQKJ0UJDqGWthgnf5/nF5bbQG0zS7JpEGpowmDz6dXWIOc/jBWXM062XUNWdDCLjtfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555672; c=relaxed/simple;
	bh=wPXRBtn32S5yf58pozOR6q25uSTpW5ftz3vzN7BZtgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYKOWM+KnMwkQXKuJy08hYOWXaNBZ9MFC0LMeasK+QeARFJwHivtRkRZ3729TZAStUKzil3cHeIM8MuGn4oXxsNg7qeUroYDe8gu88wtjp8yNh5GynNiZBlHeHPUUL9RoVvrzwITG4dhsnVo+HY/jPKUGgDrjINKLehufVuoZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J3mm2DQj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ReOvJ5Wy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J3mm2DQj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ReOvJ5Wy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A0331140004E;
	Thu,  4 Jun 2026 02:47:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 02:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780555670; x=1780642070; bh=/9TgK4uD/A
	fmWScKshkzU1iMhei15izPBVkZu7A4KYw=; b=J3mm2DQjaadhrJvc1xKws09Hic
	9EOX20LB/v6hYghwOf8CNVK7a1W2ojztPaHZ2MfQfsJAzlV+mJFOxOHndI8yBv4D
	sRzqxH5V7QFDI274sZ6tYrBA/ZnuUqq5mo2T6rMw9thTzVwJpya0t38B2dxSuKGs
	f/+pyO0+p5ztiuK8efBdSxKyj+2y+dDtzWlgDVsH6ijuxA9lDyywGagMmr4QPnzU
	jPUIDo/HRKnBNq/XITuvQprd9/HB3DE+CZzr40vexyTGfnQkor4j3Pr2kVxR0Zi5
	w4I7/SqKEVM0jDPez7MmHSE1AIZpwn0iPnVcT5aSAi4+/UczQKaJDi841FEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780555670; x=1780642070; bh=/9TgK4uD/AfmWScKshkzU1iMhei15izPBVk
	Zu7A4KYw=; b=ReOvJ5WyCNnWTcPELylckUJqiEUpIEM1yYiBEC2To1C2eCxIc2R
	ft4vBIWbYAwG+QIAnOvOpcWuhY0bURPrLSyoMSiMBuHf0h3EvkITPtkA0BuPXdv6
	OMMtjLGlD7AWdRzGOF0WLqT8oi7B7zSEHuVXSrOznjXIcykiz26jGRgXtGe0ynIy
	d4Q2/ZwpbOPhdwscHAFL9VHSBhVMsczqa+WaW8GAM1v9mItmu2sX3UFrtGqcvniH
	aXNBVxh/FXFEvqVpO6oUh2h6Jan9Im5rkuvIi8lVaK6cOK1i5Q0oNL0eEo8goTUB
	QsAjjgA33yJr8zk2C6jE5gT5dl/IuzgBDxg==
X-ME-Sender: <xms:lh8haolHmEWeKEVJyuBgySoIQF-wnc3FpqSWbkryw_FOEiJgvX7ing>
    <xme:lh8hautxlE1R-Gb-qQF9GeR_MVvlxPQ75CrtMxmBsS3k4PeBSObImiE-1BsUvi1qp
    cTzvlZtpcytn97hFY1AdhTs20qDr7m2Lfw9E-v5JhFb-ZPEcpV4NH8>
X-ME-Received: <xmr:lh8hau81RNj2XTp-e_GaiZuifxHeqRS6jZVRB0dEFa3Jg1DxGH7iXSpWxoulBtfF58c7vxPH7qgmIy_Mw_8sQcRMANmKEtUMJZbVBmMN9us>
X-ME-Proxy-Cause: dmFkZTFWxuOfrOovBY5uNnKZ366tfUJnIdhWa6RNDiywGEuzW6afYsTjpaWiiNvp5Y0APf
    xNW5m1iW0qIp6xOK2Bkl+6CVwyDU7R4s/+bPyTO/145DH6GuQLZVXytN/epos1mw9rXDhH
    qoXYjHUp9IW0EruJaM1TCUfvf4eAeE98vbraXf3FMxzuYQ6PhwPoN3RB28WvR5uD44/isJ
    cni2PUFP7e15SY08GsqrdiqLnO0SrZ8rjXqgxo1jT8bPzqCXS1GT02NHvhogXj8QJTczPH
    FC0a0Twu369CCVl0zNfPvolwBPdzkO/L7FzUt8jyrgAipV7QMMwCCpUUM/wiNIadiV7KIR
    olDl1KW2Gxdko2gRq1HJRtBEa2+Q/DynkePLpmyj1CEpGSHOHhyX7b0KO/Qx75hkkMVyDn
    10Vk6ndDbhMLnYkjrvXFa1tt2NgkDGpx4+nbC2fD1+jppJPvUN8UhiGszJe/X+a2G1oN5X
    Wp6eC76VDQhVJjFRP+Fldd60GF22rfXkbQnFTqDK0ksb4NrNDszz0PRVYq9o40+kYKShHK
    aES/+BRn9jdZnUybCh4lpQkzFwrAMwlhWJdZcdXcYA2VKFGysR1nH6k+LaFfARtftPa9IC
    WiOXnlNa0ui6yJv+iPsYfva8gXdihB9mqM7P1Ef+RKlKcdvTdbwvpl2iQ+Bw
X-ME-Proxy: <xmx:lh8hagPbdN2euLVVQjsVEdTiPokh9mJK8GKzoJ5pcyp_reLioYHFTg>
    <xmx:lh8hakGvX_2fLUfZc5AmdNu-nTe3vkmroHCHrod91EjIR1hDCXgAiQ>
    <xmx:lh8hamReGsvsDCKhmZK4F1J-M2vEPwfe6n9izX5LfiR8R3R7mcBfrw>
    <xmx:lh8haptQcT059mK1sj9A8x4YhYO8ixyK-qg69d3Xe5esW97xRU0iQA>
    <xmx:lh8hamfTpl-ckM3fc0r-qR032OVZq-S0YLuTub023mx9Nr29nTVbr34I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 02:47:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab2f8a18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 06:47:47 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:47:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v1 2/4] read-cache: move 'ce_mode_from_stat()' to
 'read-cache.c'
Message-ID: <aiEfkOtlnemkWgXV@pks.im>
References: <20260530160520.77859-1-cat@malon.dev>
 <20260530160520.77859-3-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530160520.77859-3-cat@malon.dev>

On Sun, May 31, 2026 at 12:05:17AM +0800, Tian Yuchen wrote:
> diff --git a/read-cache.h b/read-cache.h
> index 043da1f1aa..3c4af2faeb 100644
> --- a/read-cache.h
> +++ b/read-cache.h
> @@ -5,20 +5,8 @@
>  #include "object.h"
>  #include "pathspec.h"
>  
> -static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
> -					     unsigned int mode)
> -{
> -	extern int trust_executable_bit, has_symlinks;
> -	if (!has_symlinks && S_ISREG(mode) &&
> -	    ce && S_ISLNK(ce->ce_mode))
> -		return ce->ce_mode;
> -	if (!trust_executable_bit && S_ISREG(mode)) {
> -		if (ce && S_ISREG(ce->ce_mode))
> -			return ce->ce_mode;
> -		return create_ce_mode(0666);
> -	}
> -	return create_ce_mode(mode);
> -}
> +unsigned int ce_mode_from_stat(const struct cache_entry *ce,
> +				unsigned int mode);

This is moving goalposts a bit, so please feel free to ignore: should we
maybe add a small comment what the function does while at it?

Patrick
