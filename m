Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1D2BDC28
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041071; cv=none; b=uzxyQM2GCUjWgfsPFd1tTrlEAV7RtP8xgmVyRczRWi82Wk1UYYpvGjd6ohSxAoT8rFXtlmTAiOUDzsB2Kcr9cYJiGv1fvkMSJOtShN4vXBdVRBmSFVzw1QcPlkb4PtD9/8nOlCjuTKEQMka4c0J4eH2dThYzjYoJKKpP0IboJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041071; c=relaxed/simple;
	bh=YiAF/+qzOewJ+5qPD1HSmFLv21yYQ2P/vD7AXL3bOmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlNry1UIt6SBVZYW8qxpBnFLyk9rAkTAqw/v5zMef+XNEabLRtu2DHbIpiglOoTGKHBPr8lS+PiUqjgosl6t4zMBWhh036T4kPV1maCTFHVwbdI40zxopJbWA3mbEHzm5jzVyZIFGSvjLwx9z+o8KNnHUa22HFvWH/oJMPq/fJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o7/EleH3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQ0hwolE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o7/EleH3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQ0hwolE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AFAA31D0009A;
	Thu, 18 Dec 2025 01:57:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766041068;
	 x=1766127468; bh=8hFGoIsU5e7FO/5o55gJ1TzrjnPE1TxZt1LVoBTnTHo=; b=
	o7/EleH3Wb/9z/ADup+o+5meugDIpLMu46IuAAjljlBYe/DovuZmClBpVBiOmKLD
	ZxnzPF2t1p17TFx82gp8hlndluar5H1El94Dys6CiX5cmLZmtpgkxzBrjNIIR42k
	D4ACRvCQR1sRv+EyEbJgHtEUycEwjMtCQnBTYQsebztxksjHON68i65OCoALXqzz
	vTKqo6HsgbWsnAIGReLYXRCljZbYoR4J+cJOLdWB4VKvVXr5fONb9FfJZQRgMjkN
	Z0Z7dYC04f9ldv4vTE8hMhh/PqMEY4jE1rbyOK8vgXrnbh+9X0mQDWzIBv10BsQR
	lLj8y2EEHR/ItgF6oW9EHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766041068; x=
	1766127468; bh=8hFGoIsU5e7FO/5o55gJ1TzrjnPE1TxZt1LVoBTnTHo=; b=F
	Q0hwolELd/wOOl/JCeFsAPPO45LuvUkidNb3zepAttvWfw35vycd9GU/JYLyS0S0
	H/+vQU1UCitPLQ/2DZCYD6YPY9V0zcn+aPc5LMxkyyABrYMJZ+YeN1NEvElThnFw
	WHUZgRBBn+08YiLEM36SXEnMWN5xtaBoF2qKoYpSEJ3g6v1jm2v2btmGKEO3eJGe
	5p6cv/iIH9MmBIMgF9IExg2MWNgjBGw51ywxLegRNrYWFHnIxJZJkefZBeaikgaw
	vc+m8V/H1hesqnNQ0vvv/v54wLgR9gHU71nA0IPAAvKvpszNXnmed0QeZarcj9cs
	rB9kUiXtm7f8yATtqRzUQ==
X-ME-Sender: <xms:7KVDaQh4ggLoG3dn-Etdx_8uTe2uzbiiKx4Pz7f3PrBKVAKgd7p9IQ>
    <xme:7KVDacuMNdjCit3-yKjWsNpwpYIQTVhgGKCz4OnBwkQNieWTltWCrHw7rwtZzJyTC
    owwUj-ZFV0I-V59GZhQ9mMdofMA0LCKDd0JQuGoJQ-KJ2ktHJ4HDg>
X-ME-Received: <xmr:7KVDaR6vMkm8NvHAt5vKYar7kJYtyWfL_8XX4KtXs1cS8mnN0kiK3ixM2B_16IIEXFbTD5ZTTTBNNnASfECqlXDqh_g8awxSPa84RTd2ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtth
    hopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhh
    ihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:7KVDaYPzfgt37GKwtTt81VOe-3JLBJXxD36W9V-JK1i-gt1y7Ue_RA>
    <xmx:7KVDafsvD3GDLtoQsAlYWBVfw80giim6SBpwiYdB6_nSr70bOYlJ2w>
    <xmx:7KVDabYOJz16FyC0fMLmjgPerIH_hd-BDljHFwvVRklgHRJSvuyoEA>
    <xmx:7KVDaRw-qZKnNwFL_hSd7ath4ij9jXtKSKTGZ-8uv6X8-SxJRp2HiQ>
    <xmx:7KVDaW9P7lqO3XHXZ2bHPIzV-fzkg1Tp4vwf5fwGf7N4hY8rsn67zg_H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:57:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27a6ce1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:57:46 +0000 (UTC)
Date: Thu, 18 Dec 2025 07:57:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Git <git@vger.kernel.org>, Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: meson -Drust=enabled fails on macOS without GNU sed
Message-ID: <aUOl5h-13jMOPJhD@pks.im>
References: <aUApKxjYHMPHNIac@pks.im>
 <69EAE286-A7E8-43CE-A503-FAC707541244@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69EAE286-A7E8-43CE-A503-FAC707541244@gmail.com>

On Wed, Dec 17, 2025 at 09:56:02PM -0500, Ben Knoble wrote:
> 
> > Le 15 déc. 2025 à 10:28, Patrick Steinhardt <ps@pks.im> a écrit :
> > 
> > ﻿On Fri, Dec 12, 2025 at 03:32:30PM -0500, Eric Sunshine wrote:
> >>> On Fri, Dec 12, 2025 at 3:01 PM D. Ben Knoble
> >>> <ben.knoble+github@gmail.com> wrote:
> >>> I think it's due to e509b5b8be (rust: support for Windows, 2025-10-15)
> >>> [relevant folks CC'd], where we assume sed can take "-s" (which AFAICT
> >>> is a GNU extension). But perhaps "-n" was intended with a "p" flag on
> >>> the substitution?
> >>> 
> >>> I've been building with Rust enabled on Gentoo now for a minute and
> >>> haven't hit any issues, but that's perhaps because the command is
> >>> running with "-s" and not working as intended (yet still producing the
> >>> expected results).
> >>> 
> >>> The relevant snippet is this (reformatted slightly by GMail, apologies):
> >>> 
> >>> case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
> >>>  *-windows-*) LIBNAME=gitcore.lib;;
> >>>  *) LIBNAME=libgitcore.a;;
> >>> esac
> >>> 
> >>> but "cargo -vV" produces something like
> >>> 
> >>> cargo 1.89.0 (c24e10642 2025-06-23)
> >>> [...]
> >>> host: x86_64-apple-darwin
> >>> 
> >>> (on my older system, on which I haven't tried the build; the failure
> >>> is on my newer system with close-enough-to-the-same output). I'm sure
> >>> you can see why I don't understand why we need GNU's "-s" ("consider
> >>> files as separate rather than as a single, continuous long stream")
> >>> here?
> >> 
> >> Yup, that's a strange one. Indeed:
> >> 
> >>    sed -n 's/^host: \(.*\)$/\1/p'
> >> 
> >> would be the correct way to do it, while also being compatible with
> >> BSD-lineage `sed` (such as `sed` on macOS).
> > 
> > Ah, indeed. Would one of you want to turn this into a patch?
> > 
> > Thanks for the report!
> > 
> > Patrick
> 
> Work is ugly this week. I hope to send a patch this weekend. 

Thanks! Let me know in case you don't get to it and I'll be happy to
send a patch myself.

Patrick
