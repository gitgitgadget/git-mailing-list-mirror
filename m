Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF747AF65
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037399; cv=none; b=Z94vFcpumUBFSt4Y5u1zNwBXpKUfOjS+Pe5sj5u5qw7TGkrSOuouIVONQnaEyPL0/O08emTlUifa/Cbe+GSsIs8QB6a/kf/d+xFtLvTXCvB2Or+uSSif/5Ws1cumyzdy1U1u+JvRWPXQIm70vmGKvaLG5HR84Mwu3GrMvO99esk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037399; c=relaxed/simple;
	bh=9JOsUHKyUwmQJLsOucJE/qJRD3yp8R0/shZr31gmgCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDtntMOy92ncfsgH72BVa9bs7xFiwKuYZD/hpg9MGPTPPb/OJNpwnmRBYnR2N3nWAgpEY6oWXerlQRjEmUyeg5rVo5eXr7HspZ+Rbi8nbw4WdG8aHzxnRm2eVDKWP05JL7D/6MUpyOGN8hTZSeVnIe/GRnOgd/OUzwi9BTjPBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZBhAXvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jL64911A; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZBhAXvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jL64911A"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EA2FFEC0022;
	Tue, 14 Jul 2026 09:56:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 14 Jul 2026 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784037396; x=1784123796; bh=GHIadM4bfm
	665htIh4+kknJNesaPxNBVQv+r1ur0a3A=; b=jZBhAXvuJxsLEXe5dwV3XybpDE
	ktrWQwO92MNhT/Dn61jIjNxJP2D22qz33bXvGkhI9G2MbUkEjYzfACpyDZT4B05y
	jfgFYUvVvXlEdP59ZlUxwsKP6I6RTNyNdCQe0E3qpd/wAnx0qW+CAAkF+eRbnT0s
	jDWYFTzz1X5ttHeVlrPpo5RRmIH6t/Qev+JLozis5eL/qu2cBTAY+29foRoG9xLq
	8q4SK/oDi5HdGtIUe0TtrhontQV7cpjliW+V+OSoIJuKyD4fPBThCOxm3/uk7hE7
	sA7He8dAbazqA213soLLm5QIr47XpLmjkN86YzfoNjs1iRTIil22jJjQ0sPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784037396; x=1784123796; bh=GHIadM4bfm665htIh4+kknJNesaPxNBVQv+
	r1ur0a3A=; b=jL64911A/4gr6yC+sLT6BKaWChjx20/zhe0hoqNNga56r8rk7gj
	KrBMvabVaQJJUdehsl5fEfcjRTJQ2uBo3r47nggJUEIqRMEFZQo8yJJB/Mol+9Wk
	ArAfwHdCS9djJqRuErrdo/9J3dz9JNbuZMtPxK0dq/hJv95gI7ZGy3Mha7vc4w+p
	mtIfO3OygCGdG2IM4VxJclOblMEhHv8XuiY2H0b2JnjR5ROwvBRznp0EpQOiR6re
	ZQo1BzjbNuWscdGHOtwj4S7gGtaXHr0k2x5dlufCEx0PRHQs+AjBLUnsWgmaJalv
	3XgWRZzPeB/+Y30esZ2OU3jeGmxt8LhRYHg==
X-ME-Sender: <xms:FEBWahFqEyvWgbPl5RwovWMHjcyjr1Fkny9AWnPtlyFe-GcbV3XKnw>
    <xme:FEBWatxmDQAUj0gWydLhd2fxSCjDMMcIYkFbfivGUi-kYFQsHU7hd8Ly4F63fdBBz
    xGyNUHWHWBaZlNSG0ZDT0RGtvRjLk246x1p079KHW1w-9Tt4MTw4Q>
X-ME-Received: <xmr:FEBWagh8bN8nXhQDLuuMcVAT9pFsr8c_RhBN-RZ1B6SPFWMbPJopFzx3UaCoDaOszwga9gDZDybXhPq9667ey9h7BvM2BwwPFiVvpH6sMw>
X-ME-Proxy-Cause: dmFkZTGtS+KdWWBweU46NH8xeNyjj8RJ9Q6g7Td076kGd8qZgQ8CO4fmMwzBPrS2qg4ETB
    tUTe81nCwvY4FpA16DGepjRwwSYIdweAB19by6cKuZQx4uCNIgkY89YjtQLZzfeE0kSoRM
    9NtMVGfec+LPm4Ojacq8j9tttffHfkx3MnqS1yncqdgxbK6cM5onEQMwx9chCUSQMafsPq
    q3HeuhVKHPrnf2ljswLcy2LWgjj73Vllc0WA1UgG5oa3iBWj7vBU0m555C8Jijfm7PjfB/
    gBSIEnZtOPDDHK3ldy6RXGAsentf0LnBHMIHb5ms4PS852p2CBewctt2LmmiR6DZpnIAuD
    vzyZrCFLhqh0GbjAjnwnGxqhHdqZryvj033+M1C1GF2L3kvB5KPpJTorqOMPSHakDxEnOO
    HUMHK0JWVCTxAGKavbGQV2K4sh/p6yRxb2gHTrqcLM2kVC3n0sLqpxopLHDa84Ad8ZABoW
    vH2FOoSO8UtxxHTqJb7poDXJBbs6lFMsoyKECMDo7CfBXwZ+vJRsihlJlRHl5XWAUogkwr
    NMZfEm5gsRGekC0rIwTtBRYpEkqe4RZsF69Ns6ZHYGOmxLVb6Gbvx2Hk2Cnhorla7wzWmw
    D4SF3/s5+06Younp74hFJROHVMrPZ+VR+NQ3PoKjdnFJwNVVDRyI2sT4zSKw
X-ME-Proxy: <xmx:FEBWagyDysjSBu631L98xhFm70OMT3TamMtNtkS14ctdu6PM3u1pSg>
    <xmx:FEBWarIPaBE-c-8ngXC088PpejlghCNEgo7H0Xbfr44meQxFe0rdnw>
    <xmx:FEBWavQbEsav4GwBm8Ma-ue_26Z7lCYQ2pF3LkEkjV7aZiu5wW-9nw>
    <xmx:FEBWaroolmWgIlugVyO3-Pq0lrQHhTg_J1wGyLB0vpmNjeaddaklHA>
    <xmx:FEBWahy8EXrwkNcxCKPDi4v-CuJe_C8EnsbDevVlW6YaOwkYpathQ_vE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 09:56:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a49c1d87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jul 2026 13:56:33 +0000 (UTC)
Date: Tue, 14 Jul 2026 15:56:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] t1100: modernize test script
Message-ID: <alZADk3gB5GRxUiC@pks.im>
References: <20260714071633.35446-1-diy2903@gmail.com>
 <20260714122033.61947-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714122033.61947-1-diy2903@gmail.com>

On Tue, Jul 14, 2026 at 05:50:31PM +0530, Shlok Kulshreshtha wrote:
> This is v3 of the microproject cleaning up
> t/t1100-commit-tree-options.sh ("Modernize a test script").
> 
> Apologies, v2 crossed with Patrick's review of v1. This v3 folds in his
> feedback as well.
> 
> Changes since v2:
>   - Patch 1/2: also drop the extraneous blank line before the "flags
>     and then non flags" test, as Patrick suggested.
> 
> Changes since v1 (carried over from v2):
>   - Patch 2/2: reword the commit message to use the present tense, as
>     Junio suggested.

Thanks, this version looks good to me.

Patrick
