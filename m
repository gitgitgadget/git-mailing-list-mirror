Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044E329C7B
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007382; cv=none; b=oU9eiC9PMU3ullRJH/OJuvrIOZNIhqe3YYZSdRhKeyq1YnlrvIKB9jXzq34mroGiYsPrDHJ/loYe8/IxuTo/RXcf/u3JzspTfqnFejulb3497KwaCNQ1so9WSLtbERRFJM5gn7uk83txHlZrKFVnk1n4xil+9Ff2xmEmw8iDa58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007382; c=relaxed/simple;
	bh=wWWCmBsprsyeB058zZy7+sco5U18kKIetsHvadHi5No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HepiusQZHx1e87Ol5dMkfQ80XtYu3r28m5OQ/uz+F6MF6103zx3LtOn8vr83/u+yZEodO6BuwBgIqtQHsbGHdBfyH/P9kQCWcCBQ6YuAqr5VHFIhMdRzWb+p7vrNmWIRbxTZWLFR4bUXO0kxLFuVpgDIraSpjuYE8X74D3fHPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XL4hohQ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EgzD/0Yg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XL4hohQ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EgzD/0Yg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 698971D00123;
	Tue, 14 Jul 2026 01:36:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jul 2026 01:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784007380; x=1784093780; bh=I9qaYraJOV
	RuvBn1wnbS2kZD9tmVP2xYafrW1+qk3b4=; b=XL4hohQ9Udaixn1rEimMM+9lXq
	hRvVSbZ5vE/iK/mPkHn04xBsE9h7CV126lBuBFCRrVz56ZDPKuydUmOaGQ7Z+MZB
	EVFKTS91Pw5IauBOlwcxFxqRs0cvnI2Bd0+WnJl08j+W1z6oKD0IXSU0eM/vShmd
	QMPH/QYPP8ykubhK9ktqgjI6e+ntADdlel1YcPvEjXf2/BxixB6A0Um2CDQPPfU7
	vLEjc5AG6svtVt+qdDxlRTGfUEyz+/IkejOL/L/rRLkN7ihDc9qnxMzLuE8oCe2q
	uRkdAE0PNS9N0iwcHBUtAZitSkg3CA+vE7gHvAZcf0CzrRXJvgxuREO9r5gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784007380; x=1784093780; bh=I9qaYraJOVRuvBn1wnbS2kZD9tmVP2xYafr
	W1+qk3b4=; b=EgzD/0Yg8jbHIaiMQfEph9Wjtq1mKZAfe+na1WJd56zPJfvmhMb
	GbxGr33gcBonKVg/nCO2BbrVLfwClhtgnOsQXwrCLjbNHAZZ4rJVSkFb1m3uGSqA
	Dk2GA9EJXVyBGbZt+e7f+ClArrxr8fLDK5xYPXLrwH1e4Le+1kfoNgYEQZm0QOhr
	DoGV0+NRoyQvY5iwsGLwvJ9BQ5lSo7w0DMgfCJM82PWspYPs6UkxUr/mRl/qd/t2
	KFjIfRiIjtcVFXAkwDMA77QaqTzeCBFCDH+gmj6lMXzmspUljzpjs89HHyMu9aFW
	1F2ZoPnYMiFZLWP0dTdsSM4248EnoQsoV+Q==
X-ME-Sender: <xms:1MpValhhc-PJWgNoRoNSoQVO_BK_YcH5qqBMMAEMo6Av6Fmpd9XkaQ>
    <xme:1MpVag5p4qnWJfqdfg0IoyT9rj_7jEjsHQpwNL1eA9EvEJ3oLekGqT8qDylzuEcQi
    FHQgPqoLrez6zRDZ8UjyQnSP8t0LFzr192agRoVBCrf-Waz-a8>
X-ME-Received: <xmr:1MpVatbhw1_vtCWdOzRSHAKaUCHuI9P3TT-e3YP92kQ6sZ9GUms9mNCJX9Tu62fEheIYlHBvktSujMnBT7ffOcLNIe4Oid2UWmrrexETUQ>
X-ME-Proxy-Cause: dmFkZTF6mmQN3qQKuhojLNtYAfwNE91sA5bHwC7yFI/5xjgTvBtdTDvMTQeOk8yISiaUCk
    /uFrkkWqWaPuNKvxLHBiCgsA3k5TsVTHJUrg1P/18hcYMXciU78aSl6R6R7KsRZa3CmCFX
    YSK9UtzrClpJNAQpFJ6I37DqHBJlQy/NvUIYlIbx5k8OgG3McSQ+nIp4dTMYjqlxwu0S9m
    EZByd/3o7MdmG1UWNZodmuk5IFbYaYof+yptL8zQ43wSEs9pMN0xDwNax17vMIzVNi5oMI
    6eYKhrWObpwPtgtkMrK1708qQGzbjgZ5eiomOtepbOqWSpmQGnJjDLXaj2l8EBLSbzheaM
    8oK1SBIWCTi+b+RkbPOWbxuHndz+sPik2LcUYm2ZuV9megPieYhnQkLiDjk893WQEYgn9T
    V5B+h72H+JTvFUvBLZ5tRu/tzofAIFmMuyqbmf13gepXffO5awnPlZmvAf2IBXn8FvshsK
    8ECqLj85QXUFp8n3pY6HXokrk0p2xFzSNsdE1ymhgilDo6qKZbJk/D+VRUY5omKwOG6Y/5
    wmO92s9kFe5RPDOT4Ne25Xpe+BKWklG6NI1QwCwt3jsxieZ4HteKE1Io9dE6WJwQyUMg5u
    RExJLq/OeZnJmY9ZgxHXU0Tmd1esxjfTnvNZvXqZty7hY3wFGjFOxyjnVvzg
X-ME-Proxy: <xmx:1MpVal6WNg6gd3gagCM7zJI3bsrZMOcTL0I7SeNdBKutCDCzYKeVbA>
    <xmx:1MpVagA3FHBDZMXnEAFq3SBQEEdtxydJRiTLukpPt1gotLrPdVLT0A>
    <xmx:1MpVarfEAZoJSAsCRDzse-lYEtLLH2OsKYFL1rVvd1zcIz389P050Q>
    <xmx:1MpVavJzaoqM-mED_CjBrzuOSJGUJJvqAR7fQ_VlpnYazxyDW4ETeQ>
    <xmx:1MpVam03_ueSN3Cets35CPJEW3i3XEV6IZ5TmHCr1yFzjS2Zvug-mjkV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 01:36:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b8458b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jul 2026 05:36:16 +0000 (UTC)
Date: Tue, 14 Jul 2026 07:36:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/9] odb: introduce object filters to
 `odb_for_each_object()`
Message-ID: <alXKzb-GHodV6uGj@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
 <alW0KzSZuZnHmOZD@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alW0KzSZuZnHmOZD@com-79390>

On Mon, Jul 13, 2026 at 08:59:39PM -0700, Taylor Blau wrote:
> On Mon, Jul 13, 2026 at 04:41:24PM +0200, Patrick Steinhardt wrote:
> > Range-diff versus v2:
> >
> >  1:  baf2adb012 =  1:  7c0dc1be0d odb/source-packed: improve lookup when enumerating objects
> >  2:  57eecf3031 =  2:  2e5908c9c3 pack-bitmap: mark object filter as `const`
> >  -:  ---------- >  3:  f4d66ccfc6 pack-objects: drop unused return value from add_object_entry()
> >  3:  92dd6a6f6e =  4:  af475654b8 pack-bitmap: allow aborting iteration of bitmapped objects
> >  4:  92fe41577d =  5:  6ca42587c9 pack-bitmap: iterate object sources when opening bitmaps
> >  5:  e5d59959e3 =  6:  f62c3bbc81 pack-bitmap: drop `_1` suffix from functions that open bitmaps
> >  6:  ab3547ac2b =  7:  b2d25b6e9b pack-bitmap: introduce function to open bitmap for a single source
> >  7:  026f21f522 =  8:  a5bf309bec odb: introduce object filters to `odb_for_each_object()`
> >  8:  534b25c817 =  9:  600b15a907 builtin/cat-file: filter objects via object database
> 
> Thanks, this version looks good to me.

Thanks for your review!

Patrick
