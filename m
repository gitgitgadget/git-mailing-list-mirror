Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0617A316
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745558491; cv=none; b=tRGDjriua0xiY8NKZm9LdL4OwLaZtvYRlot2lyGwXF+8n/bnmBRRzVPcX1D6S1aIbbTUufgKDYyebApz8YHqUsNBwP/Avlh8i/rk3Aw/n4nVl5Gy3QQDh8Lc/vLOjRO0BnyD0T75n4G5rI8GIuSX8EIc3Zlwdk1VRSU32TNf3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745558491; c=relaxed/simple;
	bh=r3p8wgtty5sZKipKYD8dV8sKN2nQ1R4HrlQstSEv0Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5GdJ/64IRA1zitBoP/RqYQRFhVEAVcTFJz5IiTqSz2ZxdMTVMQHWCeZbBI9My/ASEHUsoqCD1YM47ttma8Oef1h5XQlmI8r5Ls8NB1P/+xZhisPSLbss+6Fcmpw7jfZgoM4/YH2qxG+BNLkbWpPfFsSUd5KNbZBVTao6iAWrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qhUgE8Dw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5+nagQj; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qhUgE8Dw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5+nagQj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A680B138020A;
	Fri, 25 Apr 2025 01:21:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 01:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745558488; x=1745644888; bh=TKgY8GBNRv
	jV4iCDlD9UkSHMI9cUU59UZ5PqyoqCOFE=; b=qhUgE8Dw8lpPK3UOaqluOhMNiW
	RLlbTAf6yCGnd/JbKnzZyfNib2pW6hJr8zK3c7uQHwPy6t61cbPuY2+Oougbq3ny
	TCxsL4mkDzezlSsMBG3CcabizZARgIjoE2VHvWpqCEhIg7doSpTEdAz4pBAQSI7D
	i/lzJup61zmoV1yg15qIuGJ/8RG2tekFIHkErvQeOq8ObOarXJb1JxGIUMHV5YYD
	9llnXYcLvDTzlCq3JhwkekiGzS/gtMU2+vD/68YlBqoETXoCVg43SzTKc+OlnqK/
	tehNi2PCTS2QzVkgCf4vyA5usH9ZqP/bvcOUHBeZ+8Bb2wM5kPDnLSVZNOFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745558488; x=1745644888; bh=TKgY8GBNRvjV4iCDlD9UkSHMI9cUU59UZ5P
	qyoqCOFE=; b=J5+nagQjpGsHWXTobXd7wanmccyfGRE/pucaC7VU8eVbsNJ410k
	5q4xwO3dVpdT+PTa4AZyvfAbWJUu9fRaqbJMfOHN4l+FLfUbZFPHIKOqaa8mG84X
	XN8S4ODX6fLbQnfjTIP2dQ0uVkxvoUVmXqkiNLkjng2sLMWgnUdiWoMOHjw0BD9N
	q+O4VTtgeEGZH7IMRo7nPdM8OH6joEVBEPtJBx2en7JGCgE7d9TlubDuGOoJ1Fbm
	pqazy4t/jt6L8mcctkpff5lCm78+Id3SYnlZAnhe/heVoUBPn8qxw20A9d+rc3p9
	Z2BzFkN2FK921FwZqqn1Ct1BXWLu/xvcYqg==
X-ME-Sender: <xms:2BsLaGcOXC3oOOWFGnzefxqx47ByMrmZshGrvTKwhXrKzc0FIOYReg>
    <xme:2BsLaAPIDOYZIvmjD0KYd1qeLGIdyrMO4RZHRSA0KaNIrHybPWVs1bqdgr51OeV_G
    tx8Ag8l9HKMuSSeIw>
X-ME-Received: <xmr:2BsLaHgzSGMMKtFIAYCp_cKar0LmW6memExcALnRWzZBDXbPpltKJ05g0xL0tPUVpylLJF9Nkkk_0bU-83wO3-pnr-at_zvhDY9V2B7m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshdr
    rhgvphhorhhtsehgmhigrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2BsLaD8mf-uIE-NQTjrhGzSX30mO6731ZgvQqWaOuee7SZqJywRl_A>
    <xmx:2BsLaCun16FSKId8m4JNud43BnWByCcW0kK4xeAOzcQTaoQ7EYET1g>
    <xmx:2BsLaKFrjY95eJMa1gjLNi7fzrg3dafsZkMnVqUqrD7YLj2TDgfhZQ>
    <xmx:2BsLaBML83acSofxOWR7vW1CZO7ioVds0hjf_wG7L3_R_GjDKcxziA>
    <xmx:2BsLaMsM3tKiBj2DXEr6ap6HiG-XmCzTCsWArJD9HTTuJIVteJUu_sW_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 01:21:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd81815c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 05:21:26 +0000 (UTC)
Date: Fri, 25 Apr 2025 07:21:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH 0/2] meson: prefer '/bin/sh' over PATH lookup
Message-ID: <aAsb1UCPZyiMcqy2@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <xmqq7c39v2gh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c39v2gh.fsf@gitster.g>

On Thu, Apr 24, 2025 at 11:28:30AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > at GitLab, we recently got a couple of bug reports about Git not being
> > able to find its shell anymore. The root cause is that with Meson we
> > have started to look up the shell via PATH, which may exist on the build
> > host, but not on the target host. We have worked around this issue with
> > a cross file:
> >
> >     $ cat >cross.ini <<-EOF
> >     [binaries]
> >     sh = '/bin/sh'
> >     EOF
> >     $ meson setup build --cross-file=./cross.ini
> >
> > But this made me remember the report from Peter [1] that Debian also
> > faced this issue. So I decided to address the issue in Meson directly by
> > preferring `/bin/sh` over a PATH-based lookup.
> 
> Perhaps use the same SHELL_PATH environment Makefile based build
> has used for ages?  That way, those who are dipping their toes and
> possibly migrating to Meson based build eventually would know what
> they want to twaek, no?

Yeah, that's basically what we do with this patch series now. How
exactly this is wired up is different compared to our Makefile so that
users can use Meson features to override this, e.g native files. But the
end result is the same on all POSIX-compliant systems that have
'/bin/sh'.

Patrick
