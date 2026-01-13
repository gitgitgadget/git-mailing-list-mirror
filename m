Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342002E0925
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289910; cv=none; b=JHztnfdC+hnurMhPZuc10UKrtzZPNUmfw7lbf4z/f9Xgrju1rbhEqpme2J21q3jFshANiYMEqK68YFc4WuOYkxpCeiumnaBJiEsjGbkt79KzYUMnJN+AgxmCEntUBH3e2ZQAPk7l3gXsT7Tl7UnaDB/er2b/2aj1gR8jUgHCc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289910; c=relaxed/simple;
	bh=ts4CerHbtpHo6aghUmF64eCPj2COI1CIBGdS+GtwIsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzM85zlGSX7kjLNl2TISAD26pgOef/ZEvA24ld6JZjZ0wncLz8H3ciL4/8FjJjbUVjR8kRFDY/u6+imBQ5yn715ZiqBxDzplUu5xO1Z/BKGOqlOSnyqDLqc+nmn28x5+wPatH1opGbbU+vIdhWFPm/sKlDlYN4b13dgd4d2DRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f63X01bw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gR0F9m2m; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f63X01bw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gR0F9m2m"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CBC6EC0297;
	Tue, 13 Jan 2026 02:38:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 13 Jan 2026 02:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768289908; x=1768376308; bh=LmjC1ltQtx
	STAdRoHW0JD1HzZpYz24sUUGCpBB5nQwc=; b=f63X01bw5jMPsMpsit1jDlBPlg
	SmFCPCLxK39vxcilyEPjG/igqgI2yjGBFUVoVII/gFOTJ0aD0QR8tz/0gQO183sg
	g4h+hM+4iQrmDzHxajkRF5p9/QDCd0rX5SAEJoeAbvWDcrTTabZup87Lo+L4sUUU
	G6A5AuUpTYewayvIHzwm9W83PAXpl8AbOGKFEqt9cdgfEj6VcZytCHYaG7LzO86a
	Mu7/usIuU/IrUCuXujXG52rrpSuIPFLIB0fvoTmBL+urvG9qSi6zdT5eHI1E3jMr
	hoS9dqQvhG7PBoAmgOKHfIEh8bx9gtXk798x4foEch8YSvSeod+8q9E6EfsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768289908; x=1768376308; bh=LmjC1ltQtxSTAdRoHW0JD1HzZpYz24sUUGC
	pBB5nQwc=; b=gR0F9m2mi7rS/L7UYH9RUJxezPzoSilcKwxYnykkLFaoH3wFUIc
	rGIMwsnhDaO6AW60eHgMmiSjEV/QUo3FBAXYCl1zcpoW+BuF4OEr9DjuBWz0ulkF
	89YnfqxreYd8utPVH3L6fRGk+IbYUxsZP+d+UEl2szFvVr2tNMK4osEK/Oy8SP7T
	dRMwVv9mLz20WmxT3DjKb6KPXzJ1m/q5iQWt3UWpaeET1lHjQLeeUvg3Pls4NOJz
	CLvcusFZ5Eqi6iwKNzDujXUfaX2TKIr9r4AELjpJShTcXIZoLPDeGO6MYgwERTDe
	URdX0vYBiZ64QncHT94f/AR+OiJ4WnI5QTA==
X-ME-Sender: <xms:dPZlaSSbsKknfLfhxFkQrEiJ3JRYuybK5oWmf4INO6O0Ykwi8U_W4w>
    <xme:dPZlaewm84tcpmWzpLVI3z6kxc2BdmkVPUc5nzgxTsLalpON4CfBiinw3iBkzxeY1
    cYwBt8fsDGAASJyz9wUEmd4tgvE39TpTB_HlbaNSj4ogMkHwLvSdQ>
X-ME-Received: <xmr:dPZlaU2o-QJOCPumaZaq220RRRm5rOLo0520trIm5S0aWLCpibCp97ktiUIHhTOOXbzjc89NJmfc7JrGvv2n0_HKOmT2-AkWcpS7kvxtcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:dPZlac7knVdkrL2c-FnqPjSEX22LdXRB0V8QofmqupnLXlO50bMzpQ>
    <xmx:dPZlaXW19GhAYcqabGPFo5gQP-HW-h4fzAFboNqvsS-n5gyDirpACw>
    <xmx:dPZlabCuqpdymeknSlnQMfdxNLWLlxpbOlR1e3AUWkHKltyASVS0KQ>
    <xmx:dPZlaW6UyR4IRflWVPNpsFoiewdYDS_CB8yptrxrb1XWVtba5jHhLg>
    <xmx:dPZlacVQuOQshoYg5QetDF_8H5gHWioU258KRuR6KgZUhJeD8hzga8IS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 02:38:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a891128 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 07:38:26 +0000 (UTC)
Date: Tue, 13 Jan 2026 08:38:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] midx-write.c: assume checksum-invalid MIDXs require
 an update
Message-ID: <aWX2b9vj8olYODwc@pks.im>
References: <cover.1768261435.git.me@ttaylorr.com>
 <952a40c1bef40f5ad2c7f6853f6da64f99350976.1768261435.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <952a40c1bef40f5ad2c7f6853f6da64f99350976.1768261435.git.me@ttaylorr.com>

On Mon, Jan 12, 2026 at 06:45:06PM -0500, Taylor Blau wrote:
> diff --git a/midx-write.c b/midx-write.c
> index 87b97c70872..6485cb67068 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1011,6 +1011,20 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
>  	struct strbuf buf = STRBUF_INIT;
>  	bool needed = true;
>  
> +	/*
> +	 * Ensure that we have a valid checksum before consulting the
> +	 * exisiting MIDX in order to determine if we can avoid an
> +	 * update.
> +	 *
> +	 * This is necessary because the given MIDX is loaded directly
> +	 * from the object store (because we still compare our proposed
> +	 * update to any on-disk MIDX regardless of whether or not we
> +	 * have assigned "ctx.m") and is thus not guaranteed to have a
> +	 * valid checksum.
> +	 */
> +	if (!midx_checksum_valid(midx))
> +		goto out;
> +
>  	/*
>  	 * Ignore incremental updates for now. The assumption is that any
>  	 * incremental update would be either empty (in which case we will bail

This looks sensible to me, thanks for the fix!

Patrick
