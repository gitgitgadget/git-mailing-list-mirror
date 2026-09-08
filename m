Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7F57C9F
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838026; cv=none; b=WxeW0uSO+wcs1MaA4K6foryh7NegSiK9QzOEzSV4CizrICtNiwV+4uyFrKEk8+RgXPUHIiHTyTnYnVw+6TxXK9NVmKtsO9CIzNpRQbegzbHGKxREFbhDeiBk+ZoMB/124gkaGDJJD4/WPKaZui8tnncJqZdFfRN54mERkIobEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838026; c=relaxed/simple;
	bh=EVwjNWrSOrzxk+A0ZZIW3cvNKtfhdcrcutw7GHHVL/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KYkP8Z4Khsqfw1ihzPTaFnkXpoh1UfsTsE4Nh64lQUd7kkl1gDG4qkMvDxfrGjIy47AKqPxPOidKK3IrQsFpCcjeCtS6KLfC7iEBGkp0i5frzRRf2nPAm6/vcm6AcGPNG4iJi3fkaNVTK4DFcHl9ZpFKpnZgSKaCNt/44b6hAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XtAQ8UFu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xdtoB9Dl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XtAQ8UFu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xdtoB9Dl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B9057A00CA;
	Mon,  7 Sep 2026 23:27:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 07 Sep 2026 23:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788838023; x=1788924423; bh=Rm+Gl+/9e5
	tdBIgUsOisFjxqmry27vFLcjHLx7C152I=; b=XtAQ8UFusruot1So/xdNEPnvC5
	LLAqCnnEj8NbDI/lz8Bxhk1Sy3nQ2H1SzhE3pEl2E8OB3E/sl8OS06Xz7Mp1b8fB
	1zhMn59tn8cw7ar8WmOh2F1a0ITRApbYCU47TItkDfuRdMT8yYQa74Gb8QCwCk9Q
	MGVPWEz9Sh1517Y3ZB/iF7FUA9290cm7ar3WUwMjwaWK/vDViYhkV0znDoxHMvdI
	1z/v9CkBMqUeLIT5GjEcgjfU+lh+pLV8ZTYdawxZUZh9UnTv9ui87FqgZuB6lj7M
	fdFyJpnQC+iq0VnLMd3J+XTPle8fxiwPQngkMYtxRLGCdMXU5Y2N1qIjLhxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788838023; x=1788924423; bh=Rm+Gl+/9e5tdBIgUsOisFjxqmry27vFLcjH
	Lx7C152I=; b=xdtoB9DlKJUCBgo0mp+oyt/z0uvCMPlq1woWCryJ2wwvCz6NY68
	tMM3ewJR3b94BoEUYVvJ53FWaX8H9bnOmqRH5YfBcHZUCF8O5MfRbE4X8pmdj+sk
	KTFjykarR1egVAYJ/fXvHYtsF7wWQDMY0dcMJibZhhP4jmUvW0EtwKW+32KxpVVk
	BojdpcwRYb3k++nmPWJ1t4/BLUtOaxvnAmrzUyxi3yIdhwV0nRgeIv4rVvjnuooJ
	1Z/rkvcCol56+KQkLQXrNUui5qHN2BEOnKLkA3XE8kq3W9zzNVkN3GRI5kfrXV6/
	ydfyligH6x6pQ9597PnOUL1ZeV9CDXQFzUA==
X-ME-Sender: <xms:h4CfahD2Khx-WlZuDBlMDTb4IsQTC7Q9vtDU57TfQQ3-vVbQKKNxvQ>
    <xme:h4CfamYLSmkKbPkKnQMQT-tstbArUSyeI9IRHJiIYwWrXftYLwt93eoRE1czt17pk
    VKJj5pOMeJtrk32DVYpZ_mvzKNGJn97DukpQhBblz8biEwcn-dFGAg>
X-ME-Received: <xmr:h4Cfak4R3_OxZ_FrkT6Wnbk6cNhGWXzIrBt4lNd7KyfscaUv7fk8WxUEMckF2ELMIv_6ZJSmXWHSG4prGYO12e8u4KShZIsml_TX>
X-ME-Proxy-Cause: dmFkZTGb6U/ampIArHvWdcMfhP6ab2k+gjDzybCS46OTEtfZk+myqsXaUb4zQSpeSCoBuB
    oYFF/YMGpToyrX1Eqodvfnjoj1oBjhWgqYEYLbJ++KEEWEvIUyic/yZO3D6tAxhUUH2eHF
    zPG4e6/02L1d6GI8qDOCPg9Bt1qoZu16BCiCwp5zEsmS9E0xyouET2TSXtJO9mU1N5dDQd
    cx9g+rvXG25Cz76uahfG/JtehfjcjOSg4lO6UO35eRkxGzWcshWW3X+alvEKPOKw0tFFAj
    sfRpVx0bpETvZiu9K9QaABZpRD6TqNKb7+gobpSczwTJtFX718gd/ZyZ3dBsewNHhWO3j9
    Je6Iym4Sz8pvuNKVWdlVE1SvrOlRwHeaMvkkCXRCuD3AhFOPqjsQxC55C0EujYDLRti0db
    eCC5DMribzbMRLCX12Sqj/DsiKfLwLugUIGMjXXTeVaHt8pSCphQs6BnxVV3NtKZm8BY4A
    TLXg2JXpgZds1mTHw91aRdlGjNWzwfLFXilyluKpd8r2pYWWeAs3sO4QXoK7SovDBlMYQp
    eg4znS18W8ZqNzbuqkkT4D/DMp+aVkIweHqdf8KuU5qbzMhaseuG355VKGFcra0dclYRHX
    mt2OaKbBXE0eHKOmbkRJBIXeNewhCPlXFHcN2CElRpXUM2PpwCbxpqmBvtSQ
X-ME-Proxy: <xmx:h4CfanacD12JmDYdSSWZguSawzr2b58eCPrzUKybyx8fyjxwlfiJ7A>
    <xmx:h4CfajhfFWwX20DWGPpdzXASJSUmxbkhess5biUukwhMT5GZnZY_Tw>
    <xmx:h4Cfao80QpScxnsXE6CQFxTvQtot0MkZvZ9fPr8wcqaM4kVmtRzEnw>
    <xmx:h4Cfauoidmfgg8K05cGX3kyvwE-m_hi9AVzCmt3lwgxP_8aW_SAzKw>
    <xmx:h4Cfag2GA5RByZw9al5epPxykuqAr31EoMNsYxcGM1jzh0auR8HfLhyg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 23:27:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ted Nyman <tnyman@openai.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: trace packfile URI downloads
In-Reply-To: <20260907212454.80627-1-tnyman@openai.com> (Ted Nyman's message
	of "Mon, 7 Sep 2026 14:24:54 -0700")
References: <20260726083310.16180-2-tnyman@openai.com>
	<anskQP_xB-Xw3nug@pks.im> <20260907212454.80627-1-tnyman@openai.com>
Date: Mon, 07 Sep 2026 20:27:01 -0700
Message-ID: <xmqqse3kzam2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ted Nyman <tnyman@openai.com> writes:

> On Tue, Aug 11, 2026 at 03:31:44PM +0200, Patrick Steinhardt wrote:
>> Anyway, having this in a separate test would've been nice, but that
>> doesn't warrant a reroll in my eyes. So overall, this patch looks good
>> to me, thanks!
>
> Thanks for reviewing, Patrick.
>
> Junio, a gentle ping on this patch. Patrick was positive on it and didn't
> think the test organization warranted a reroll. Is there anything else
> you'd like me to address before picking it up? I'm happy to split out the
> tracing checks into a separate test or refresh the patch if that helps.

Thanks.  This slipped below my radar.  It does not look to me that
the placement of the test is too bad.

Will queue.
