Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A93ECBE2
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321995; cv=none; b=UlNRCtSM6B3R0V/H0tt1MaR8muIfo1C/D+ofAPkMHs6fTXD95Gx/vEBWcTaYNQj9/sjwy9JVbZwQ95GaR8Sq/be2KkuCm0GjUOF/jAOW+Ci6soel4sTcTDj0nz/wl25mJuRwiuUPcmHNYWo90eQWgiM4wlEPDHPZO5VVFsiL/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321995; c=relaxed/simple;
	bh=QGgiMy0mAiGZVJure0tOUzfEroT2K3CkgR1QMzlzBFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1Y52KJQU8ufqkpUCX/wlZjO/3Oy6XhoeWkC/VLenXJfUYsprOFP/e1AGWbD7TWPx7c9kmo6aPjrdaVylIjd4x/DRkNKWkCqz2YtB87yyFsscZGay3/mRKmq5tkzuVJftTIOPU15xKyOVtCctIGpkMpx/dNdYcb6fsn+UJfotsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jWPEvD7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXYSpC7t; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jWPEvD7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXYSpC7t"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 647AF1D000D4;
	Mon,  6 Jul 2026 03:13:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 06 Jul 2026 03:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783321983; x=1783408383; bh=rx/cfEtGWX
	PPZVEKlfkEExiYzYzkv0g1QxEY5gMhvvY=; b=jWPEvD7FUpAuQFXjbQbv9YSPVU
	JL8FueNFKo/B8FjUgXmKvjI1/UjR17VphT04SFTwt84tNzzHFS7G8F7JHUHFuYTv
	jQ2vo42Nq8jZ6fIgPSxUBpJL3jr6Mvg2zTNPDlq6zNISYyWPeeTi99D7rpeZ47yb
	D5/TfoOtG9aoVXzMJCRIlHbJDpPhSbBV3GaTMXfwxxXf8BPlF9UiglRuqtdgSvbi
	BjuHxWIS32HUdG6zVHpZK6nxLEkeffkyX98QSJe9gCuXszw3IVbvLVBOEL7oAhMU
	OsrAJayfdKokmHPqyzx4uJfypoJob87zB0OFHbQv2CQ9PWTHNfUxJ/53uqcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783321983; x=1783408383; bh=rx/cfEtGWXPPZVEKlfkEExiYzYzkv0g1QxE
	Y5gMhvvY=; b=fXYSpC7t/s1E+N//mF+QQAwBR2IpWTH9yuxZaoAWJ2hzxokza+y
	drmsKr0doB7J6nnBexSnlKJDNlp8DGFUrbU05VcYc93pX7f7oOjl3mNXjtG5c1a3
	YcBhxqAQPDX4U02rzn1/igmR0IjkcsNsa1i9i1Fp/K2oqFqkEmhniUo+w7X9ybdt
	c//w4LwlkJinRBxRcM3rb2FUQ29WqwLmF4OqMzyiRkXEPhIyk6lF5VBzNZAv/lu8
	pQjPJSFyBDL4IFqQASV5SYpl7SVArr5YbZOST5hTPhm08CnunIQqI9ak79ztvHbT
	elB8IEvCXqsoXKFcmpcwqsZ9+yRuAllntww==
X-ME-Sender: <xms:f1VLag_2SV3hy3mMa_hcZElUsIk7G-tbHwX20yf8Ib_Oo-gZFcg1cQ>
    <xme:f1VLagI2NbUTu3vjBc7gelONI9L6AL5hyl_vd3o3q5Coyg2NdI8WE0YOr7V9O6KrC
    T3O1ULgr29cGIpv-ajiITFWdSQ9Wid0NWTrstg_G3JNIuy85jjnRQ>
X-ME-Received: <xmr:f1VLajbTg7D-bnFjdsC2meBeEyhiJOiOWUdj2_tJ9JUE7cENMnY7THhxeWbG9SQMvNKIdd_t2AXt7xBCjjn5Qzn5Hq8_spdERCwvwgXWWyk>
X-ME-Proxy-Cause: dmFkZTGKTvpNUCiQx9aqq+LZ745vDeli3FN3o5LtH9akWfkiXwj3FiKPAUHC6P1MWssF2N
    tfIw/Qe+CRiqLbRiVhawLBVVWnaVdFT4UxYI1k40nGunZiFNwrHWc969fI5SbLk54v1PQh
    X0MyEfRHPoicrgyfLQDgEDMW1ZDjiEz2lIokr3kpkDs8Sdz0LXITj8AAXY+oHjJlGy3fJ5
    /nxPxrT9PoJoecBKXMVhbCjBcB+wozf4FTo/SrWMqDbW8CL7jP9TsO0/npPivfDAObXISm
    QKB+T/Bp1P/O9RNgzMdpQPcmJnryJpfwxl8QUOLYFkmaGFco+gT2KmkJkuBy70YTCaQCH/
    H8c58E2713A/qJJS4uJkiuzL+LafXsZYiacXg8pYXkAk59RgLWk7jq7s87QB2b9Abfub6d
    lMKqmjvBdH1U8InJeCHp6vkcv11s1jXvcC24cIjLoOYJvsFLdyUnNGjs6mhqjJHUYCNy2Y
    S7VnGHKlRR5CPedfundzJM/6Z8XkQscAfzuvY5dzsqg0h5pNbn2MWOdc8Er6UOlvEt6fsH
    EmWjeh3PNhiej3LrXhJfMZSNLGACKJs4G0WQZ/NGkDGfryXDYekiyazywdbGj2ik009eJk
    KfxrAw/z5g6iZAucs+rzzJbPnf7ogj/qaKqE1qJJOdo4zzAsHtZUTqAMWYnA
X-ME-Proxy: <xmx:f1VLaqL1dQptCvuEIRdJXeT6ueIiptXXpIb2rTD3afd41cZoCFzbPw>
    <xmx:f1VLapCdosb-jRbwxT8lFojQVWfWmcmval_WnuIFr7PYRQ2bE8Xefw>
    <xmx:f1VLanr3HdgX8VV6MIV-12_Sxg6XhgmkmNZLeAIz8fmQzQfadsHaVA>
    <xmx:f1VLasgEZU9BLwfjzP8c3lThW10x_8torVqjY-UNL_DZOSLk8lksXg>
    <xmx:f1VLajw1A0m9iUclNGqqGmk03qDEx30yIuSdjShgp9pjPepdXoulEpaj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 03:13:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8ec7f2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 07:13:01 +0000 (UTC)
Date: Mon, 6 Jul 2026 09:12:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] builtin/refs: add "rename" subcommand
Message-ID: <aktVeqTiHV7c_CIK@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
 <20260630-pks-refs-writing-subcommands-v3-5-deb04de1ecef@pks.im>
 <87o6go2lgt.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6go2lgt.fsf@emacs.iotcl.com>

On Fri, Jul 03, 2026 at 04:31:46PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> > index e6a3528349..ce278c59bf 100644
> > --- a/Documentation/git-refs.adoc
> > +++ b/Documentation/git-refs.adoc
> > @@ -23,6 +23,7 @@ git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude
> >  git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
> >  git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
> >  git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
> > +git refs rename [--message=<reason>] <old-ref> <new-ref>
> 
> So symrefs cannot be renamed with this command?

Indeed, we don't support renaming symbolic references at all. This is a
limitation of our backends, even though it's not necessariliy a sensible
one.

Patrick
