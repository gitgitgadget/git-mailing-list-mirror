Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98BF52B1F6
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571001; cv=none; b=Pk4IO+xeHTv7QK5p8PtW2R42QoDqlAiOAmsCQ458EVj0C/NR0bP3d+SkRAPhAAzKLAN97th9hkv/oH6VJVxo/IKk6f6FrZ6X/D8EaUHoiJUeI2bskB45va+cgbMiVMJ85uQA2A1NcZLF9lVSOMEB54ZPTcZdM2Z4T7b7xSpOgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571001; c=relaxed/simple;
	bh=5H1mMEeu2nOk7gSYnS3XJtvLGvaOUIP+eBSju+P2M5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcfxBBGk5U/dDXw9KJ+kg9NMuxW4hZVqxblwcgfj/uHhKVs7BmVME/DjREAYqfpsyA797YJpF0u2q3NkY9Aot7LBEaoLy5jb62rj3NI0VLaOkZ9jJPTs7LCiMSxZ8YX3BkhXPObcw3hIE5rMZq0A0au5vWWhQ57IX9sHlsqUEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X8d87Cz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cHcoTtwQ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X8d87Cz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cHcoTtwQ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9A487A00AE
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:36:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 09 Oct 2026 14:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791570997; x=1791657397; bh=IHe2pWGNr5
	axM8F9rJHhUZxEXOLTtatKa+5BYAn2KWQ=; b=X8d87Cz+B/b6lzlGz7Mjt9fv6A
	Ysj+ACjTzI/YZUrck2hgF2F9cNh1jbSZ+257kL4SdR23hsIDFIpUTpKxVnb0bfth
	tm8+P2pMrdqPQjz93TRYrlm+/21DW2sW5yljaCaE/MX2eHSgSAGCIW3fJj3UFEFe
	7B1qhxPVJktopzX75VMozB9KDYe072Nb58yFziNdhlAVqZLuIMmiEbWoyj40JDch
	BSbGmjdNfVus81n5M4j269V0lIHjiGdoCnJVAfiD8YXfksV0mtsZpvNC5zgbUw62
	wUjmOHdmInpNRTt+1EJpRKFpunmzPg+ug6Bm9obBcHn/iGKUWIqw9AXYmsqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791570997; x=1791657397; bh=IHe2pWGNr5axM8F9rJHhUZxEXOLTtatKa+5
	BYAn2KWQ=; b=cHcoTtwQkEv7SuKcoyl2MLYNwnhK8RnwoUW7vuWtzbByRLWtIS/
	ulwuLOCGgJxacaG05vxQ1XRONa/iVEJWOJohOXRCCIdsmZ3ye/z31bM4vNWruFQw
	tufpDOcnGj5rINjlfQXcwhPHxjdO3ANmJf9dIJCA4+BfowMC1QlpaFX/EJ3/Rx+a
	wyo/HHwAI4lboINvOi6SAZMb2CPmImMdB3JoZxgVHUQmbtJw0bmfKjagcdDx5S8h
	MACoR80j59+iaPl/th+rr1AnfD1K8x/5fQGzG1gwaxQsAVTo22a6i1TrT7MDokT4
	nOGx9mgdxAngPJ+2U6F5e77C3KeCFUn9fFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791570997; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IpGLkC8+e9+mgstCezPY2B2k7Pik/E8H7KYr9cQNjTFy210
	9ki84Aa6bYMPtuPY/f6Yh2EdxAgSq9BM6EBwMew7JO729zpkzadpog++IwS1FKa2
	WI0kLLMNsLYLUwBvS4taaFGw8SZcolhI0j2cRhn2gPKTJFWD8Xu7T9Iz2oNFFXjm
	sEgJaib6nTKiaCxBHXvH/Eepc1KcoFTYQuG79UeWB+7jeu+Qd1uEQu+wjmY+bCzf
	hqvrES3+vLu/h+ayGAmPoDu/ST7pApLN5ECfMlO4TqCbUeAM4oMHwbetRyfF8oS8
	js21y+50eGQfy7bTCwmLU9qNKwrImWE2176LoLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ex6YY5fZSpGzpFJL1fS4oleZY9jknSMuMJJSxQWk/Ss=:5H1mMEeu2nOk7gSYnS3XJtvLGvaOUIP+eBSju+P2M5Q=;
X-ME-Sender: <xms:NTTJavLTad3ICYtfH-gldu4-K_vHzf-ni0iSgv17p6SAB2nTZcR7-w>
    <xme:NTTJalauYJjO8RHLYksmwOKLU4IedQj6eSk8e9jkprrbG8RaGUydfeQr0mcFUqU_7
    mQDQxk6f5Wxvc2IrZaapQ3AbR85vFElYG7ZUvNHJeQsW7wh8QNgygQ>
X-ME-Received: <xmr:NTTJap9aV_TPYJCXigIhSUevcKut89zuyO3ad11UEdPMStrRBFr5SH1x8GZKL5smwE5m6nfHkFcf2ifKUqfja2IKsUbllf0Kmz3O>
X-ME-Proxy-Cause: dmFkZTEZlO3scod4ksXbipTnFZ+6AhXyYr+w1glGJsxifHtVCJFmppFYhOdNGuZotTPnXM
    xezELNZ+gKadrk0pC8lM/6cdK/eAzzUrT4Vt8GAhl7rzWYxAbRiPQRc4lfCn0VlDNa5BVq
    4reJjnxbUPlh0K5br5/JFHtloluWd0iz/9+3dO2VXTZhCDtTmK5WYEXyBv7nNHdR6tfY9y
    TtHpjps54RDPCeM76inRnxSQg2E587HI/tsusrsbcMlYgnsZt0x9P2UazjsbQMpwBmobwU
    PndCoeeqnduiB21IcBJRnnU+lxUJBCuawRy7EHR4t8EfE4vbyPZqHfs6k6iv10OUAWcqoh
    ig504uOXEl2KdUoblAzn/Hf4M9T+pOy099S0AwaBTp+NfXdpznMfKxCT1w9XsFQOaS2Hin
    JTvWQIxtWNZKJFIT6NmzsFIequtKFPQusmaJ/8805C4ynJkPd5/4/bdWvQve3PDfXAxx8C
    XB4JuX9A+3ngeK4SN4z5Pz9wmDI2igt/+4Cf0/rnOX8NpYj0+3Y9h9bNMgEoRljAgerEVt
    2K/xja/v9ZlESmbITL7dfevT3KO7y0KM+HnXGiqLPL8CBEmbfL3U/8c6LFUVsbklWisyJE
    gFm1hshq9kSwcyWXnEqHzXzagL0mW2wg33I5DCiPGPoG2/QO2nGmv23V+mng
X-ME-Proxy: <xmx:NTTJaubd339OkPH6rhbD9e2GheCZ9cruqPE4LSCwrJpnqNT5Fwmr9w>
    <xmx:NTTJalPzat-lq9HJf1TTUeIfe2dY8X1mjlCiFqiDUsWP0EJ36hDgBg>
    <xmx:NTTJaiCM99NCXjXFy4qtgvGheT1kW6Yr5xYOdnRfF8qbkIhXS7PTkg>
    <xmx:NTTJakLFpQnMRmMKE3Ay3XJxUNHe0egnreIbBH1QQZdM5irHKUytyQ>
    <xmx:NTTJapdaFypSB0kU53Pkt1xR02fVt7eu-tY4vQoiid4gLk6zfrhSxqwX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:36:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/6] [doc] Add new page on merge conflicts
In-Reply-To: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Fri, 09 Oct 2026 12:00:07 +0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 11:36:35 -0700
Message-ID: <xmqqik3apvpo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Julia Evans (6):
>   doc: add new gitmergeconflicts man page
>   doc: git-merge: link to new merge conflicts guide
>   doc: git-rebase: link to new merge conflicts guide
>   doc: git-revert: link to new merge conflicts guide
>   doc: git-cherry-pick: link to new merge conflicts guide
>   doc: git-pull: link to new merge conflicts guide

I've sent detailed reviews on #1 and commented on others.

You add my Reviewed-by: on [2/6], [3/6], and [6/6] if your new
iteration uses them as-is.  My suggestions to [4/6] and [5/6] are
both straight-forward, so if you choose to take them literally,
you can add my Reviewed-by: on them, too.

Thanks.
