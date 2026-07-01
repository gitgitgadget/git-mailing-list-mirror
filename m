Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C273C37B3
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892603; cv=none; b=DOQ2taNGXcmxtl9qLVfVLU7W48jqgjNoqfrZSnxKCnIJpBShEUJQn5IdTxhzoWTJwqYQTkomhgT21h2YdkKdEeByx4IhWHzmTZz5tcIqnbLFBpRyQ+GCWTrR0ZMuE5GfXpDiYV501cPRuqtgIjhX5BgbuxozmFgpVGV6bw9/KIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892603; c=relaxed/simple;
	bh=UtuPgldFOSQbnadg1k9GjxRVmRhXuqiH4FBC8O2m23M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WljoI4sybUOvCgK3C/cdjm6UiuNmT4Xw4nATFm1pCnddLpzJtp78dwN1+4kmk0o7MRZc/GztPBWxlCAKvwiPh/a1L8y9VUmEty1+qIAoo6sBrpZARJG0cjSLVjuFVJTfUu5+UvWg8v/IMNyh3F8JagJfPYKjRwdeG56r9Y5H+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RtzX/wNV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJFZAaMg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RtzX/wNV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJFZAaMg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07EB4140004E;
	Wed,  1 Jul 2026 03:56:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 03:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782892601; x=1782979001; bh=9TvKXJSzgA
	puhWaelJAzq94ggs4zENcQGxP3DPvy02k=; b=RtzX/wNV99weibfHn93ISgeuuM
	UhWyjqcGp7iDQr109fTozG6Utp0a6wyftz1UC4KUNYQh0m2as2iHGLfQuOnqq00L
	DgFkY2+jBxz+Lq7xBhw42rhmd3068gr7cZzqCqZEKfs2m7KkJ6RQ1ow/affNtP3A
	++NGtcFy0+cLoSF0d+qhEIm3cDdW6DB4o1/pWBa0ndyxSYWUgBoo1jr9MwZ3RHeK
	IjYzobHj2RfHjQYyhVK3O4blJljWNCgtQ0B1n9fXFhEDRQD5pDI50r80yu/ApAzh
	DpaNb/Edl/aZFe9DozAnuGmjHYSCOTGYmEdiGuHdITjZ9b+pI0OGpPunyHZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782892601; x=1782979001; bh=9TvKXJSzgApuhWaelJAzq94ggs4zENcQGxP
	3DPvy02k=; b=XJFZAaMgqcO882x9k400hy3AktMUSaVwvKoCw0NcQApZN4Bg92P
	4aZha4d8S6fNqwaZDE/YdiRwr54Yyx6mSeY8SIsKYclFn9DkjsW7WpgOZMYWI1vx
	TYr43APHyUjkjFzhXmoHQ8Fvz9dMXUPz9pJec2jZ1pERD/uOhFHAT4ONPlyeD+Av
	Fn/EjRwiRsM27eY/s1WEJA+bhsW5S/nUWWxruSeH9ODuddH8LQGIjYG0+P/DyZVO
	Ntgk5jU2fSPilObLW/vYUrSWXq5Q+DKfHlDiCn5XypTUI05RG0UeYfH/+KEShUtu
	DFbEtIOZtzsv88q1PDbalafCqXKytxqQKRQ==
X-ME-Sender: <xms:OMhEajYJV4PPDicZ9HK-rIO04QMz_VojQmSe0OdZtRcUqb1-8Mbv3A>
    <xme:OMhEap1n7yH9mpfpbdCVAIQLMRVeGgpuud_D3n5PPCzUzJDAD0r78GehLavqMOVtq
    GEceJ3HQR8aME0XeZj9CSUMH7mQpZrVQkVJRZhJrd3vgchA6PQWIw>
X-ME-Received: <xmr:OMhEajU0QGkGPPdRTh_OPDWrhNrVXVuGvN3t1RItbnKrnnjrhr60ESxgyRfL-KgjIkO4JKGeSF_6Jp2GzfXtxPUCjQaurhh75LgqCCHpFu4>
X-ME-Proxy-Cause: dmFkZTFtX1O9DVmM431WHiNG9tQeWb1YE6n3zMc3dQdXijCycgqkj5Nj93P41TECjph0Ez
    GVvkliBKTzInmvmcE+bG3PvoNUfSg6oQnnbS3ykLtq05kN2en9CbuNKkcjt15mDFiJK9dw
    Jsq5wz6rsIvAoRYWCLC5KZtXAuNPmKbacibAwmerfa28r9/7ZVb0nr0nu2d0m0Cx+F7hwP
    qPFn0O/k/V9+24hvVyPI7PFTPNyJMB4lPbqZf9oD548K7z1On0Xu7sHVx+FPSwrCCynPqu
    haxkfLccNp5zi2cODUOvlLAoDyvsW/anKwPLwU5fXl16xCjR/W412iEsHSsnbXOOJhLEPt
    nlCYNXZoQvE5IYZxXIbArDj5uLeXcstGuAIdedxrSwBqn6QwwpqumJhjcHrReG8XHwcsii
    kuaXHTEC+zX26jDY39VLi0RxM9lF9uWwp/3gDIdrmpWeYBlHZDS/w1WhUftIqAZPqAkyb/
    0U/DJgcJue+m4bXqpuK2pagbKFVZDMugQCxsHf1WJX5fwAlkPs7PJw1Y2Jehaz3KhvU+XS
    TOrmEJFRxJZ+ekJjuEvjionbyalink/pHJSUc2Nkuw3r57MVJQYglpL/X1tUA6Tv6uu5b5
    imSvMYuSTnCEJo1VD3HxF5yDwggI5SdT8l4VuXYaLkQ4j8jSjanwpC5OLzAg
X-ME-Proxy: <xmx:OMhEajVc5H7RgXLkKVX5t33kOw6H31qXHO3CHzQqcIr8PXEa1TZL4A>
    <xmx:OMhEaidcUJOFfHHuosC6Po3KpxhTiU46TxDlLk9c3wqQrks5Ot5VpQ>
    <xmx:OMhEasXHh7xe6-Qh0uBHLwpIvyf2xBkGqLkvdsalZ21vu4IaU6sFdQ>
    <xmx:OMhEarcWurBBICFqtNFWGI3lzIW2LSd65OIMARoC4VlJsgtRmuQJDA>
    <xmx:OchEasXK3h8un2kuyf0jmrCaeuOZzojz6fFgTpsgN486f8O3F79XpQR1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 03:56:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e2f9243 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 07:56:39 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:56:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/13] submodule: fix cwd leak in
 get_superproject_working_tree()
Message-ID: <akTINO_S_NgWbGxG@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <6a43f952417259c23ca456c547b0e4587a0ce6fa.1782889472.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a43f952417259c23ca456c547b0e4587a0ce6fa.1782889472.git.gitgitgadget@gmail.com>

On Wed, Jul 01, 2026 at 07:04:26AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/submodule.c b/submodule.c
> index fd91201a92..8ddeebd8af 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2627,10 +2627,10 @@ int get_superproject_working_tree(struct strbuf *buf)
>  		 * We might have a superproject, but it is harder
>  		 * to determine.
>  		 */
> -		return 0;
> +		goto out;
>  
>  	if (!strbuf_realpath(&one_up, "../", 0))
> -		return 0;
> +		goto out;
>  
>  	subpath = relative_path(cwd, one_up.buf, &sb);
>  	strbuf_release(&one_up);
> @@ -2693,6 +2693,10 @@ int get_superproject_working_tree(struct strbuf *buf)
>  		die(_("ls-tree returned unexpected return code %d"), code);
>  
>  	return ret;
> +
> +out:
> +	free(cwd);
> +	return 0;
>  }

Okay. This is fine, but it feels a bit fragile as we also have a call to
`free(cwd)` a bit further up. So if somebody were to add a `goto out`
after that call we'd have a double free. Makes me wonder whether we want
to have a single exit path for the complete function and then drop the
other call to free(3p).

Patrick
