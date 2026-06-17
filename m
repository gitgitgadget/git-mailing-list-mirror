Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7B395AE6
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681202; cv=none; b=RhARgaLliuWubn/pK3snjvUdv+YHKjNwhkKrN3LyFGj5+EAPmJetTAmIbRRpgJyb96VxvUaiKEws8s6cgA4tp5DgCBkhyU9EGFONeYt1fdhEh9y0hHxMLx4b++cXbX+gqOT6w4JIVn0MzAVhf+7PuNMcOWXVZZ80/xNqpCzxPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681202; c=relaxed/simple;
	bh=3XgZ+wchULnd1AtHAd+NIC9HheN2wfIcOT3BleyyiVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxgk8Jr1XXtNdACPN8gjBtfe6OwmhQCwDxrmBA3Ysy1jA0PEq75IXu+b8DIdIV1W0/IKZ+ayHL5Rp8bh9faIrvp2Pz8xYV5n3ht5ntS1PpeugTRJEHZppukJkiuh/wEzGWIp/PyGs9JLPOcfn6fdjAJ4Nly+V+XOYFmSGL8bsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=soTphR6e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnxrTqQw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="soTphR6e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnxrTqQw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5164B1D000ED;
	Wed, 17 Jun 2026 03:26:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 03:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681200; x=1781767600; bh=lk18RkFrbW
	JKPBp+hool1dsF7NB2QnghM0UdnEyy594=; b=soTphR6eMTxM/AVMOj8cmmnr7V
	N75PkjBVUJT7ePY96wqLYuT635ye+AC+xv4rnqYUM3ne6LnN/HWVW097SbIT53YG
	Z1Y/da6XpxgFTTEcRxBwPDUIoGT1ZAMh/HJjVtVJLR+QOQwB7pYFqcx8DidGm020
	lxArQPr/F0VDwr9tDSp+gwIr/GWaL4MABIDtS6xlTzV7wzM7lQ3LQyh0knkRuKLJ
	FGhrSFydt7ral8rFQO2qjqv5d8TygfRKC/e8fhTOeydPEv/dSXlkIIHND9HrjfcS
	/kohUxjkCxuafM1M8sn9gSeIqQIzRDvJAmVyD26gHwDFn1fF7aIGPFgkvAAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681200; x=1781767600; bh=lk18RkFrbWJKPBp+hool1dsF7NB2QnghM0U
	dnEyy594=; b=BnxrTqQwmQTHZ1kjbMR534EJ+ktDSElhSO8r9lvNgz8I4Dbzqiw
	yUpld3Nvw1SRNOw4Z7kqcAwOieIjpNQqal9PRu0YG0RnOk3PCZahRyegCw3KUed6
	yAUBxpFGGtlmXR2d6WpxJpK5xyyLJKdG6gP/v/dZKdkVdMjdBx1Oq2O25jivnkKz
	fQsf2WBbwCb8GH7KhSMJFcOQlf588spkMvTEVUsNUCfzyliCh/q8QSocl384nTde
	2cpWDKUIzwktk5DcWErpFryBSAshaOrVop/6Aqo5CCBumKGGmmNeOJXiKAnji+wD
	KK2g54smR+CapClZ5KtJt2pM5P1ndwlMbxw==
X-ME-Sender: <xms:MEwyarROuwU3QtEF83mma6OYV7h60hs2IZzESzwIYz-oBwAUku23IQ>
    <xme:MEwyakMyOBEy8JVs0g6Ce3kAE3DDVay6LXWM4Ry7JP8VPAgEuMFFsndD4XOBFkS4Q
    VTDQPDSmaxBYpBjmDb75tMxALgCODWnk6c_aY2pF25_93L5kju2>
X-ME-Received: <xmr:MEwyauOgV3Z2saVF-LwdWnU7sXdUl1mHhr1ACe3gYUWcNrgItQRDy4O4_dAe6aTlbDFMI38OtXlPGXFEQH4h_LplyWRYntMR6spc4RI>
X-ME-Proxy-Cause: dmFkZTEnbiMUSllzpb8MOx7K5eqUuOfuJLmHpBFDBKB1QBOBY4tMm4PpL2nL0nXZn+zRWg
    3y4rRYuLGYXl98VnK8ZNap+xwdN/6aDcMdpxUnPgjNX2nzYocb/7F+c2zzeLq6Um/kctt3
    IPHpLNq4AVGV3y0tm0jtzYVf/SWd28Qb7UbtfJzIdvhZZC1PuUvoMh08be6MsBoZNgYbNM
    43pNF0uy0Txm0Cg2V3Jz/UVqNiyMe8xhkFLAD4h8WIz9NKonzfR/8qwj4qH5a+r6amqOkD
    1Z4yiAkmbAB8rNH/m0U4KBD4K8vcg3F5itg1/KG8+dqePetMKkcJHXl8WApnx1FtNhZuJK
    4nujOPcT2QIdr8WKyQmeOZBTHn2fDgz1m3IMzCqe5aowCdNKRulZDGv0hHM3acoOAkk5Oh
    P4mIoNlBADeNQQMnchBJdPWAIuJBFtDNC7xQ2te3QwwaofUs9cZFseP5CNRXdD0zgZER2Q
    pr9UqsaMRn8kgykanNvXWD4Jspi8inNsNyo9VWcfD7YvB+lW4LnzU722fJi5Rg274v+wMa
    kb117TqzZkItFENrP+Q4fiSpS6GLiWtNM0vyf1jD5rkWmop0rJyDjw5sZwQi3kQjGMGZjg
    cw6R5v+aipQV0/kGUK7G+y0pCAmXa6ci+nKPpIku4ouK/dTCW6a39y/GzZBA
X-ME-Proxy: <xmx:MEwyakv26TGwmQ8OBslNFGdfpPJREBv4TQWhFbdPp40f826roKH3yw>
    <xmx:MEwyaoW7avVtQ8ksrj5iN_-Vb2tG1dMj5yleGQXXuFeHft7rFLi8ZA>
    <xmx:MEwyasvWGKIHCTYdpuSXCKxjK35Ostg-IDPHqRIQ5KXJnJpLjz4ilw>
    <xmx:MEwyakXghNA0oQUw4UQ_HaNfyVyh2A8Q7w0-1sVKvpgs0Fv1F3R1jA>
    <xmx:MEwyaro2qtCdnLDeOxuxhkskIQRTfJ4gq6LPLSgazxuYcva3kVfyeul7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:26:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a39cea6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:26:38 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:26:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/17] odb/source-packed: wire up `reprepare()`
 callback
Message-ID: <ajJMLM2T34Gf80ft@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-7-839089132c8b@pks.im>
 <ajHDm_pG3Ckca4mp@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajHDm_pG3Ckca4mp@denethor>

On Tue, Jun 16, 2026 at 04:53:38PM -0500, Justin Tobler wrote:
> On 26/06/09 10:51AM, Patrick Steinhardt wrote:
> > Move the logic to prepare and reprepare the "packed" source into
> > "odb/source-packed.c" and wire it up as the `reprepare()` callback.
> > 
> > Note that "preparing" a source is not yet generic. Eventually, it would
> > probably make sense to turn the existing `reprepare()` callback into a
> > `prepare()` callback with an optional flag to force re-preparing. But
> > this step will be handled in a separate patch series.
> 
> I do find the prepare vs reprepare semantics a bit confusing. The
> mentioned change above would be nice to see in the future. :)

It is confusing, agreed. I have already written the patch series that
converts this.

Patrick
