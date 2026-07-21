Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74A4189DA
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784671408; cv=none; b=MpMApdJKgC0Gl9rNEb/asosDq3gMQytkzqtFf/VUWimAb7h/2PmzFNs9MF2t68vq7mpWCRbVaCb+jUbvCV33ApM1PGvTMtje/ky/dFCjrLhqiCS5Qt8pZ7X+RPxr1HN2xTQ1i6b12lonbjSjXNIVKJ5cypNSCEnk4JsdoQsVEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784671408; c=relaxed/simple;
	bh=PXIpw5Jn/X8QrOzwAxqkJl4YziAw7hHM9nLRHBNf07Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C27TRh1mmuRf7ibCRVidmnvNiT4MH3M74rBkyxUezHlDnOgxvxDtuD9dPaq09ZznT2aQSDqCpmPHkkljKLFqybEnk7PXY5P9F99GT4yozykpZkhIySsdBjhjIanZ96YuWEumvIZQpXmc1dhBI1jhl4SjYNjaMHjWkMHMDexrQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gQhkJ0Vs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jonDWz8c; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gQhkJ0Vs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jonDWz8c"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ADF941D00112;
	Tue, 21 Jul 2026 18:03:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jul 2026 18:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784671405;
	 x=1784757805; bh=jWXvyKIlnvWPjceJRVdLBao5M16Nh2P1Tq2DCTrHgeY=; b=
	gQhkJ0Vsj1R7WoiA2OsGWHRzNisOjH8RpwHmMV8vG3RSnIEsDLIJnRDOwLYYTF6+
	VMr0n9TtJyzi6mY0pP0MXEnps+JiCP2CVAwUsrzzln4UWfGhoOiwSzj4R4wpjvH0
	GsEQL2GhBgAQ47ZtWG2dyj3w4krvVnU68YM5njJE77/nmZDOa+1s0UBz/uvG8dMU
	0JPfbeO8GCOWcJLvKL5HBIBOg01FvqvsxIwe6Hg+VT/qwr+XeHCWjApZ0OyZLEJo
	N/h0m/NvpYv5ZrxKSrZsmYR/gNZ4SkL9ctyGuNnlEhuj8wXJesciN//C3VLVmu+A
	dCchz3QfiQb3Q6WlJAqd6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784671405; x=
	1784757805; bh=jWXvyKIlnvWPjceJRVdLBao5M16Nh2P1Tq2DCTrHgeY=; b=j
	onDWz8c8isubV9/bVpgxEMCe+PWa41TZnjTRaOb5bPDBx3Sdlee8SoVyw13uqTqg
	LRBi23TbFGBF+yT/nWVmOwpgnEga8mR59tOzRpd1aq9LunRApwKmxBotRK9QRqn3
	fZ2T2Y6C8Qx6GNsV9FuBZOc0dAV/aqtXH3epQ7P6qq0hkKKgGYxV8pvNMqRav6fT
	4owfoY02HM/8KF7n4khVqik88SJ17t+efcT9sbvDbMlUQkU2xkC3yAlewpy1xxEd
	1WnOZ2YLRWfEI2oSoDbRIR7Ob6caWkcbumABPjDsCWYaOPx44SSxTXw2cmFssYqu
	WTd+Ppvx7j713ah3jmv9g==
X-ME-Sender: <xms:rexfakydlOdc__S960nG_q_en5xhrKNYOm3yQXdE6DqqIp525AjrYg>
    <xme:rexfavs4e7uiNS4lXU93dGMBiPK0GyYQdjh0HVoE-9-ouZeeLXGPLnGVdUy0xhH1v
    MfBqCPPIVFjL6MxNpFRhndlkfE6tI2en191-7ay3YTo3n5vAxUhmQ>
X-ME-Received: <xmr:rexfajvNiu4qwvVbjcbVA3sRj7QHlEs7IcTZ4-v1aDZ08rt-e9vszdoSnvy820dZ0dR1MDQeetW7QshTb66GpRa8lGjSEQZGy66JWvL8PIWc6w>
X-ME-Proxy-Cause: dmFkZTEaeTm5HMySyCAzgdrqdDaJdmzkrqM06bSO3DDyflWrnyJbNkX2egLA59vMwfP7Xn
    3kXlxvpUgRE0JLfJR9TJHxcKVA/Jy6V+8L+z6G07QSpRz/Z3pCnE6+be55Ud0syCHQwglq
    gycaL/ZmsbZ7d4ksR+kSFWbWPSmLvgIDmDRy6UxeUt1cUyiQT7LOHWl7dtOemxLu9Jknko
    ++7ZMppXq2mF/kWbnhqSgc4fknDDJXrJp48t/0WLjmedxb2l0Ex2P5GdDSzKH76nksdLff
    gxzWS2GSrgmJp6kWCIGawcu5fpzq+6BI62Quq4mzBK36ZAa/uVw1eoJsMekV7hj14nM1sG
    5WHBzVC9dl/J8OuIk2MelyN8hBQlNSqW4tW7RlNS46wh+NfN8JfHc8XY2naUEalDDgNdsj
    m+zRRvlOrgIHsJqiys4JvTNcm7ATTNp2wE6tA5BrqyE5/vC2kyxzqN+ySqEUuGUnr/Nq1r
    /LHUB39VVq76CK/Eek5dPSuHRvUOOuH1El516EEeGlaG3b8aQxfpc1Ye41JkYrEKScHA4H
    3IndwphasNt6156TB0+5wbZ4kxfMsROPkmDJT4PWCVailAt1pnoONx5C0x9iCx3QBvfRql
    d/sg4pKVaQKOQCEwY1DenHDwxzpSb1Ml91ZjUQNm8JtqhxImT2st6/bClWSg
X-ME-Proxy: <xmx:rexfasPnqorNsm5l_dT_4XE4dNt9WOaCIJapsr7aKZHDBsDsS3081Q>
    <xmx:rexfap1bI8NYQuwIBjIupyhDXxrH_dXU1v_Udbexj7LBgWKy8weZGA>
    <xmx:rexfagORqn9VvmNpn7JNSrnyu9ttp3qsUMQKKpIk3mIyqmDzIo5IDg>
    <xmx:rexfah16f1CkiXlPQIN8mjSC5wCYJXNWhagF0e_8ROizidOd_7p2Ew>
    <xmx:rexfamUf05a6YnSgWAGWNX5swzSsncpZyG47QYgr-Hx-OmIncIm4nyB_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 18:03:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4586696 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Jul 2026 22:03:21 +0000 (UTC)
Date: Wed, 22 Jul 2026 00:03:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] use
 repo_hold_lock_file_for_update{,_mode,_timeout}() with custom repos
Message-ID: <al_spOloKmeCp0oe@pks.im>
References: <20260714175956.54601-1-l.s.r@web.de>
 <20260714175956.54601-6-l.s.r@web.de>
 <aldYW4TPUqgDMRcf@pks.im>
 <3c0a8031-7082-422a-b474-938418682b60@web.de>
 <xmqqmrvmn6a5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmrvmn6a5.fsf@gitster.g>

On Sun, Jul 19, 2026 at 12:11:46PM -0700, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > On 7/15/26 11:52 AM, Patrick Steinhardt wrote:
> >> On Tue, Jul 14, 2026 at 07:59:56PM +0200, René Scharfe wrote:
> >>> Apply the config setting core.sharedRepository from the repository at
> >>> hand instead of from the_repository.
> >> 
> >> We only do this for a subset of callsites, apparently. How did you
> >> select which subsystems to convert and which not to? To make this
> >> explicit: I don't mind a partial migration, but I think the commit
> >> message should briefly explain the reasoning behind it.
> >
> > All those that have a repository reference other than the_repository.
> >
> >> Also, as you don't get rid of the old functions that still implicitly
> >> depend on `the_repository`, I think we should have an additional commit
> >> on top that guards all functions that have this implicit dependency with
> >> `USE_THE_REPOSITORY_VARIABLE`. This ensures that we cannot accidentally
> >> call such functions from other subsystems that already got rid of the
> >> global dependency.
> >
> > Probably, but the lockfile conversions deserve their own patch series.
> > Patch 5 is only included here because it was easy to write.  We can drop
> > it and leave the low-hanging fruit on the tree if that's preferable.
> 
> I am personally indifferent as to what we do immediately in this
> series, as long as we all agree on the longer-term direction.  It
> seems we are in agreement on providing additional safety in the
> medium term?

It would be an easy thing to guard existing interfaces that depend on
`the_repository` behind `USE_THE_REPOSITORY_VARIABLE`. But the patch
series is already a strict improvement over the status quo, so I don't
mind if we merge it as-is and defer that to a later point.

Thanks!

Patrick
