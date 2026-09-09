Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857B3BA236
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937423; cv=none; b=Rpw9x5M0M6tIoT31x/vvIP/jdOaJbMZzEIOhjIQEcE5pf/Z8yfvT9tFalmMDVRYAQOZ6StRE9YYAgyK93jBAQlKLFVVcYlS309k9IApvrRm8XiHkVmFwxrL9V6cLFl/S6oCyuRtXvLxhxu1pg/vB2PmUepwCcjN548XT1Bi7ezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937423; c=relaxed/simple;
	bh=JGnt4CaQrBUDz9FpCO+bpHLfduULqlRt0POE7SCeisI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOEu8beSaQJxGCYQxYy1oSWD+ffKq+bWQ8t3DD69RoOdRb6Hk5AtT1gBiQ93/RXMYSfnLp1y+eZn/ILqXxOV9hYsmaA44ZzmNIuvjO0rKgQ/G1cUQuMXckV9yhxNFEq9emd5B4r3XhC+PYty2cgUTEYy50Vef67QrPdPLb2QA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hx4OQ3kl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nzGgoeaE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hx4OQ3kl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nzGgoeaE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A59C6EC00B4;
	Wed,  9 Sep 2026 03:03:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Sep 2026 03:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788937420; x=1789023820; bh=KrO5jnFKwF
	aFodi9CgvAlIOozRl/LriGzFFT3idTQHg=; b=Hx4OQ3klLcufVqJXWRsPHIg3MW
	I6SrzMeEWLMBz5fihP/Xiot1tbulPvdnR8YljtfoGrAkAm/1AlI29dTwKWeG8265
	A05Icbv+SvJRMoh5wheGVLck0bpa/xA3Qrtad7v4DIJie0dYxOGbYOG1iivv0HPg
	dwF+rG4jVqJddgG/il/YQClsRI5ZuZ/3ADFf35ExTcT7jdeFkFI61VKHdqr+ihFe
	qksYWsNeCr1R2OxS05TQ9gj5/ERuKE3M5xS+9MynAw3c4lTFt4U0RUAsLrpVPqsv
	iKpT7M+w1+2Db6BxiV/uHn92KD7sfYW5nNFkJhB6QIlNi9bikyrJ1TRTO+PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788937420; x=1789023820; bh=KrO5jnFKwFaFodi9CgvAlIOozRl/LriGzFF
	T3idTQHg=; b=nzGgoeaE9+jeM5wG/5E/RZnzNzoKrI6fZXW80o55AbdWptNSv76
	7L1osQYVsv0yB73Rjzs2P9L8FnhktfA6YXOlLD69HURzPoHBvor7OQh9qzljH/lY
	i0LpohKWcyfthku/m52mZ8nA2z4q4N/6ZZau+IU1IF9lTZyGdwCAdxY4kgDlIuYS
	2EdNQLTqYacGsDX9hd9fmGWfOa+nPZr97b4q3C8YXW9Ed0hk/NGNt5tKpjVERCQD
	3W1AwAt9+v14hQxdUGOkZFT11iBx+ObUMu930/bDxV16nNIPfykXRM2pii9iZqT0
	gYluwLkAl3DZpi4xvYkj2svgBwHvWcHns6w==
X-ME-Sender: <xms:zAShagN4A3yWRd2bhegg_gqjvxinvrDHb7pU0ycEwFz6NiL5vVD5Dg>
    <xme:zAShat-LP4viPU86-nVp4MDNHsxfAIPmwdF2arngPRARqDln6U8PIs1KlZd4HzQ2P
    Q1KfkI4BEWYphEzHc-8fM6x-TNm-OFPJf6e7WbNfgrLAWFGA-w4Njk>
X-ME-Received: <xmr:zAShasT1NiPdmj7s4lTKyiNf1BsADMRFVBe31dHWV2CTbOUPkiEIXjSXwyXqfzlW_LZAMQ>
X-ME-Proxy-Cause: dmFkZTEc1LrQzykGOGRD+1S0nSLhWKhG7NH9rJczC9Xh0m+KNxpvsWTk8MVWfAa/Pg5VGC
    TvfThAxqogi6G7gtulACNWY8vFINppBzt4rFtETONSWcl9BXkvfk/vj0xIefvInI5PtkDk
    SJCDDzawpggKyl65GwrzZ8f2tPggHwZUI60+7o73nRKv7R0Y9r5zjLkLbHvHUuVXOEONuI
    Q01GCdHq6IDiOK/Z+GRdfWKyww6K97Cop0jbameKXsZJjwuVJCmfdrw0E+0T0IbTsQSTqo
    /65lSgsQTFouDbWQ9MtbyYhcpWzNPBJkT7Redq04TUtE+fgbEXzS1cnkIHhJ6HKxZMgmCX
    m35Ypg0M+zqTGLIk4uy19O3ag1DFe0imIT9VTLaRDCTVV7EWHLGoDo8B8lmEgv1PRPxAtt
    bawVNSgea7/hUTbgz1ZVSzByxqCS+wzmsOFI0gO1HnUGMsP7GmS3Inot1BTeaWV0ao4Flb
    AQQnFvVLIQgNc9S70j7kzRp3hirDLDA+W2oPgOPMniVvtJUYFS+mUF2qNaIfli2Kzsn+ml
    pSvfxp5jVWH0ZM3gsDk79nLeM94BxDIgeNV9EpoEdiYl1Gbu/r5fjJ4RfBS8TaETR5VZ5+
    NtTs1ryzTqGOnjVVaMhUzrZIaEHYN+yl4QPfuw7liMSX8Vgr4jBn2zD6OYxA
X-ME-Proxy: <xmx:zAShannKBMFLO6bM8JlskWPSfHzBCHqKv5Lr3CZezdfaOTaRGQmJDw>
    <xmx:zAShakQhwL8m70QhACFko5Bg3_IrYogea9trO5ai6AhDT0ZSBJgn3w>
    <xmx:zAShatOP9zNVZ3hxTBv-6ozzUHyi0Yfq4e3CteETSphiB8qL_HB5bw>
    <xmx:zAShalXiDqRSWhCVpoPWqc7owXgw_IPNHR1LIyvDkwJPXH4VtpFh6w>
    <xmx:zAShavx4uXPmaw37Fb8BwE9cYIMre-iolNUV3Pl-1PnOfrYNAS0Rd9nz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 03:03:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd3ff9df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 07:03:38 +0000 (UTC)
Date: Wed, 9 Sep 2026 09:03:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/11] builtin/clone: rename "--ref-format=" to
 "--ref-storage-format="
Message-ID: <aqEEx09ikVI5vFrT@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-2-6733c90ca5b0@pks.im>
 <1cbb335d-ed50-4e6d-9d11-bd09de1bcee3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbb335d-ed50-4e6d-9d11-bd09de1bcee3@gmail.com>

On Tue, Sep 08, 2026 at 02:51:37PM +0530, Kaartic Sivaraam wrote:
> On 9/7/26 16:48, Patrick Steinhardt wrote:
> > diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
> > index 1ca245c732..5eaf689d74 100755
> > --- a/t/t7424-submodule-mixed-ref-formats.sh
> > +++ b/t/t7424-submodule-mixed-ref-formats.sh
> > @@ -63,9 +63,9 @@ test_expect_success 'recursive clone propagates ref storage format' '
> >   	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
> >   	# The cloned repositories should use the other ref format that we have
> > -	# specified via `--ref-format`. The option should propagate to cloned
> > +	# specified via `--ref-storage`. The option should propagate to cloned
> 
> s/ref-storage/ref-storage-format
> 
> Rest of the patch looks fine to me.

Well spotted, fixed now.

Patrick
