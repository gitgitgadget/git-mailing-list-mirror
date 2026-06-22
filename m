Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9538F227
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116456; cv=none; b=fRGYnvOS/qQq8WCk/FhBh//dbAgIKdufK4o2RHhOxtz9ms1LOAeoQBkgzv4vUvArH5OEM2s+fI1Rvfvz+VsJUS4iZc0Wcum6nfLxRSbB/E0KK/HhSc2EiBqbmx6gUWLzi5iUhBYqB/6LaMwP2Kfxjsj9vrpDBSjwH0Bivpk8kyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116456; c=relaxed/simple;
	bh=KPAOqGqgoixwL1eZeiqF4FzsvuBo9y4tgeD1NyxcoAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH8NLasVJNMNtnpQIIsl2gTNHyAgn0PVvlEV9xaXrH5g2EKs+a0Lxq5b11lXWMIwNdQZiKJLt7IpcDX++lU9Apkz/oF7ebmIMHSHwwsyYBcJmZDbc6YyLImTlsjZoMNsa4gZmw2o5++awpkTH3bkltdZ/kB0k9EG+vPBr3XIunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ROGaGLOL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZPDrMMD; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ROGaGLOL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZPDrMMD"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id EC2E31D00093;
	Mon, 22 Jun 2026 04:20:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 22 Jun 2026 04:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782116454; x=1782202854; bh=WaDZbmGVki
	LI3vu0i7pP1APpN4ju0ek2aeBeE8Cb3u0=; b=ROGaGLOLZgOgHpNdi3cWy7dZVv
	oHRiN3dUXwi1NqKLnqFuOqqFmFC8soPa2vJIdLLBC0HFxXfFVvNxKKlWL3/LvtZM
	YuT8xkeAJ+smCA1jvRzjQl6+Wwrn23vVeRrbbbqPGeY28cXCXiM97bktIrKajfTP
	7P74b/QIulekQ3kpg8hRJ3tmeI0qyiEHVPWaXKb1qHl1BLCFEdrGLPNVqULfhi5m
	K1xnxHzi9UHfd7ryFOhPVLR7VrjHp8TZMtkiS/A9YSFzjnID0tg7mtoUHOWrJHRc
	O/y2urnNGtdjJ76Q6va5av2vEz2dUpV5CZQ2Rns3BJyR9T++WMjEFSj4B5UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782116454; x=1782202854; bh=WaDZbmGVkiLI3vu0i7pP1APpN4ju0ek2aeB
	eE8Cb3u0=; b=EZPDrMMDSqkjgOL80/+z6eTYwKe9LYBRMsPHxxKS8B2cyantCGn
	ToxzX8ESaiEXdeuvyfrJe8TAu0d5xhKuS7Uxi4lrdu4yNgRDWDq3m1pBKeLBMNyq
	FTiV2AADO5ts/NF36fEv0s4l89fgJJEjPp92HUzs4mGFuekxRJNGIiT8Tg6LHpJ7
	20+d/6vMWE1u29S2WLHK0VddoIaWWXqlawkfh4rDIofzNoypISYvC/zn/FK+Hoka
	7pqQItjP8No1ZVn2/v+EuKLPYAjwAWpwr8YbyZSM5JU8uy3Kwdcv2aZxZxnkJiJM
	LI5v11bPilyWElrKq6u/awR/3OLK/UamQiQ==
X-ME-Sender: <xms:ZvA4augUaOnM_wEswOF0Z9mZGRiPuY6gSazOfUXr-xVB0_ZYHFKxaw>
    <xme:ZvA4amAXKL2K8xm0_XOuLZ49hKHhC1Sush1yGER03LV3Mhpgb8z2uK8gc_EpVQw-o
    2qJkdMT5JPGaAXea-tgoi2uTJHmvjAsHxzNUVqkgOz6UBAQ2jJW6w>
X-ME-Received: <xmr:ZvA4arFBfMlfyiDW0_Qo2BxrK1qchDJ7DWoB8gwfBZ-tNDxmnLn_0NuuYW_8bXVPCIpLl95mT4Tc9-11rALMBE3OVHX5oVn70aAbEKZEtQ>
X-ME-Proxy-Cause: dmFkZTFmFW3gFpwlGAQNXQnKxb09gp+VjueU4iv2/CeHUQWjKlrYb2oA4uiVsOuzaLXogu
    lTfZYy1ulrvQQ0s0bLqP/FNINmHL1us+GOpLRalq14usuZOxW9jJw7frX+h8iEjNtCAQyL
    Tv1mOi5vIzfVs6eiR53x13X8LQ0O8fHa40qyXYY77ibQVMm11+YdhkfE45w9Eg/l0KJSfy
    zAPabS8lmHJW0QRhuA6IhEsuvyfM2DJgDC02tyWeKTGQr7SAhcdFNZ83K/97gDWDhlVYvx
    KoVgfUePMj6ortK5LztTrMkmsWMSC/CGrZaIrEtqgJv6Ew/SFz/rAydJ09usUh9eFSjaAl
    rLhco547dFP30MiopntlCXqbCvZSkor1Sdnf18ca+RhHXSbiJ2CjEnA+yE7ErwxjFl6BUo
    2dK0RPzhM+xvFLkDG7k0F2rfTRz83DS6rbi09mtQEVYB9donfZsWKJlw3PMt1oi88inJN+
    a9gETomt12zfTBLJdC1CrzRvj+kWMH6qVHESlDXcTyePZEgwmxlllYl4jXbiB/epV76CjO
    GYp42iQzuPt/ceC5tCQZYlSmve1+XSipKB42js+xctvewVY7ud2pmd5QgTvF5FIoCHJraS
    CAavGPaRfJo2E5IYr+3k0dgU1f9/t9ovMA3znuQW5gOf9U92hfYqBI1rSz6A
X-ME-Proxy: <xmx:ZvA4amIMOVPVoLAqTL4U9MaSaNks30g6Y_ZIL8EHXL8hD60CVV70NQ>
    <xmx:ZvA4anmHA8QpM81-Z5Zf81wOGp1Qg3RcGBffiXZE7cj3Xko6pR_1sQ>
    <xmx:ZvA4amSyWcEqwY407ATs5HoW3bmzm9ildwcHLBTK31Q5KOEJ1WwEuQ>
    <xmx:ZvA4ahLgkZ3LvrDuDvPDFbooBm6PTuvsO6KNu5CKQKdGzNRYfriXkw>
    <xmx:ZvA4aikPDy_-wW2QTpLJAJgQ16zz8FCyEpBVEecpPEdUHGh5HwfuxylM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:20:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84b52718 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:20:51 +0000 (UTC)
Date: Mon, 22 Jun 2026 10:20:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v4] SubmittingPatches: address design critiques
Message-ID: <ajjwYGWZ6hQWr600@pks.im>
References: <xmqqv7bhxiby.fsf@gitster.g>
 <xmqqpl1oteoi.fsf@gitster.g>
 <xmqqik7eld2g.fsf_-_@gitster.g>
 <xmqqeci0g4mz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeci0g4mz.fsf@gitster.g>

On Sat, Jun 20, 2026 at 04:43:00PM -0700, Junio C Hamano wrote:
> Contributors sometimes fail to answer fundamental design or
> viability comments from reviewers and submit subsequent rounds
> without addressing them.  When design decisions are resolved on the
> mailing list, the final justification should be recorded in the
> commit messages.
> 
> Instruct authors to be particularly mindful of critiques regarding
> high-level design or viability, to defend their choices on the list,
> and to accompany new iterations with clearer explanations in the cover
> letter, responses, and revised commit messages. Also instruct them to
> explicitly document the resolution of these concerns in the commit
> message body to keep the historical record complete.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * Hopefully this will be the last iteration.

This version looks good to me, thanks!

Patrick
