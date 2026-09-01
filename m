Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B52F260C
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270623; cv=none; b=JL3ybOYLiBrdU8xzGVL5Wq1tjBQvoY5WTTUjr4f5WUQehCNrxjaW+RWvFmMSfUtUibFjj4G8YSLP0vGsgWC+YZ8FgCqkyG25FlfMRf0NR/z+mqiT705AibDfUgVZ62RYdrlcMwFEhuQOrkx1nfBWvnGNl7pPfgtVOyBTPtiEo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270623; c=relaxed/simple;
	bh=hQHZz8iRpVo5drZby6Cgay3qV6Q8yT00r6T13kcwb+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pS9eE7V4mMq4PMkmtWG30iJXdBhN2ZmWwj06VwPMgmTffcLf9tFhA0LT6beWNMW4pRSg14JGqKsCB8mhAu03RHd1LesN+YyiXGDSexxjS4hm5rj+VTn1lLb3pWsyBIeVfxRNlpzuNLIUOAJfyGm+rw/kIPtVJ3LwG3JSgbblTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i19BL6gu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U3HYWEgN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i19BL6gu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3HYWEgN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3745C1D000B6;
	Tue,  1 Sep 2026 09:50:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 09:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788270621; x=1788357021; bh=MseVf7sg5p
	DmMIUB0Gf3CEoza4p2v6m6gyM8S2GUGG8=; b=i19BL6guEXE6GkagG63+AS9Ka1
	+EdCI3yEHc6iGOv+bzFMuIRLUVG+oU6KQBtE3m0VGJKx5+ljRyFkD0LS+d3yLL+J
	HYNdNAl8dGas2QW1JB2RSt1PFM3M3uT1rUVoB1igFziULnoZFBy6f3gGfBy++qZm
	32gWg+nIVAMibB8YTdrz/q4+i5pw2o592SbkoHsV+edl5aAV52jUfUFhOXAH1wbI
	3FWEC/RIz2X0V3TyQmAMz41h2LlvJZ31pPmHelIPDACY3CNhaMWnLlKI9Jiv2JM6
	O5+CmfR3C8jMA0lxRVojrDEHrkKBEshxIaqABM1TA0YarGEZ22CA7/oD1YUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788270621; x=1788357021; bh=MseVf7sg5pDmMIUB0Gf3CEoza4p2v6m6gyM
	8S2GUGG8=; b=U3HYWEgNfBX6+aaXoF315SiduSOmjGx4ZY0ZDtMdgzw+ftdZQvz
	YmBAWRbqPuI3uXqNuBkTu248KcEsd31TMiTZPM1jFg02P4U4syXCXpk3KEuf4vCZ
	dGlU1AQHkAiZNFJdYwQ56BAoOyy+/mVcS+Kkvod1w/5D76pQzRbgYTm65zIRKI1D
	2fawNVxcO564amASHSC3I1ig3rnIkAD+NhUi5j1kKtzAOQpQWKrkAFzFu+YfPFLb
	JnPcaVwnCCYOCofiZIP+spXycQzEUp+gs2uWvHmRsPMpQ3XK/kuw5ecgUmxP30LN
	mX234+Hpj4DX0/JFBDV9zKmUIhFHLb2/gZA==
X-ME-Sender: <xms:HNiWaj34rz7ANQZxX_A5NIrl2fm_OfDn2zTgIfUJVdn7Y-vwVcPC3g>
    <xme:HNiWao9mXKMsmX6v3PTlFjZ3BaIhricD9WJ6uCgqZ03aVnJXDPLr_JWkr9NYEalns
    VZVGBe5Y6nDgZoTXAZZrGReBaOnvA-3_hvKA05MDmrU_imqBgVD_n4>
X-ME-Received: <xmr:HNiWasO3YsMooRD6t-4n2nnNGaiw16QM382POGfZCxyRxWp9BrkrwrS4YRbP6_A8FRuy5nlaO3QoD1NnJG63zhSE81rDwM2XPw>
X-ME-Proxy-Cause: dmFkZTFBRy2RAsg6alMnHtus8Ty3VOjD90csj6KvGxIlm1XpfRpHXpVF4W6jpYcmcPzov+
    xNRdNc4fwBBSxu+agb7TMt76uH4WvQmi+hrYIL3Sv4faz4U+R+2F0c/nysybdYSw9p4PfQ
    h/bI9e6vbyZ++JmOmC1n67dpFFvKpxk3mKd1Jq3Ru2LWQeFL/QdaMJ8d6YKIOaYIBg8lGZ
    dsmPiBvC/gUM4xy4BEkwGmDlTpSg1jXPk4MkEwobP3VvDM4ESmZAQXcW25z73OV5wpeROw
    vFa6l8Gp7qRZLT6RRb23hswcLOwNYnURwp6BrmDm87t/cLS2aqz0uiY9iwwFWn/pxknQb3
    nRTuA24r9fp43amYPUztVR1rCi2DoHuEJ9gkymk+yqn5obymE2vqGqn3ODdViyWvv6S+xm
    OB3V6HvQu+eQQ5x2ME1ldQnvjeSkvvEJUFrGOidcdyYqx8m2V3tzhmYgjMz+3+fZbgLa9q
    Th1xNtdiMeTQ68UKZMoUK0pZldklBHsizmB5jbSHuhbdEvVKaxjGDPOXf01uBbEMt+wLk3
    I2EeSv7iK2ZJBx8KqxJaLNh/b8LdYsopDftKjF5pQpjKA/V02XqIJGbDwylzXdCEmjor7d
    Pu03pKYA451KCgCE/wZX4FmZOq2p8elEYCpv/2tQBIC/Ewf0uO0ZCSddB/zw
X-ME-Proxy: <xmx:HNiWakeahuk-byvgDN8taB5IYxX0ztKIySFV0vsvUjFK8D3c4NtzJg>
    <xmx:HNiWajU3dV3Qos7vmyxb7OHFwlTj-FFMa348wzgjrEIhFXRPlir73g>
    <xmx:HNiWakh5WvkY9-NM6SGAoWaHmmgfTRjj5ueSSmFDsJ1UbCFlT9Z-Qg>
    <xmx:HNiWaq-bFQk7i0Mg7S0r8TFPKzxXOYtTsLJYqX6njmOl8gXXi9cp8Q>
    <xmx:HdiWajv7aiCtb9tcBWuo_TdCKDf3vOREsesOuvRbpG0f8eLNfqdy2UoB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 09:50:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] checkout: print blank line after autostash conflict
 advice
In-Reply-To: <af051ecf-0d94-4dc1-a6e5-0184b2b6e1f1@gmail.com> (Phillip Wood's
	message of "Tue, 1 Sep 2026 10:31:42 +0100")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v2.git.git.1788177601572.gitgitgadget@gmail.com>
	<xmqq4igaxl5t.fsf@gitster.g>
	<af051ecf-0d94-4dc1-a6e5-0184b2b6e1f1@gmail.com>
Date: Tue, 01 Sep 2026 06:50:19 -0700
Message-ID: <xmqqqzjdt71g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> 	ret = run_command(&child);
> 	if (ret > 1)
> 		ret = -1;
>
> would catch run_command() failing and stash dying or being killed by a 
> signal.

;-)
