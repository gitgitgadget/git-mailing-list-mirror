Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0C3CB918
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181963; cv=none; b=fygxX+dG8CRZMyhWur7ShnxwROB2HCYBjqyh+CxUTggMLAWDfvRlrJV1VqpWGT2g1eTvjSezT16iwvmAVxCEXyHdy0hhuikSFXpc2BvTmyNhSoEoAGXCC6xJK921vlIIT3yUsyeKMGh5wIeKk0LMK2GOuHWSIvx06vGzSzy6Iu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181963; c=relaxed/simple;
	bh=Rb8u6ndKh1UpX8X/bs8IP+/G1f7RzXPx7wdh9Q7darE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1E5EkZc8KwdY/PeU0ksMFV4tIC0SYgTfWrUNQTYi3xS+PX0Xml4bgZB3UZBnTD+b5U4En6HvNI6sqWGr8lwe2oVR+zRZ41SJbN+JK7tXSThwXZycMkCfKJ2BonNTakplXXbSp/vZYWg0740Tx6I/+J5etRAIfwmQF53g0xWJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JvL+yoBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XrtuT7dH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JvL+yoBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XrtuT7dH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6449F1D00159;
	Mon, 27 Jul 2026 15:52:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 27 Jul 2026 15:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785181960; x=1785268360; bh=QqJBKw4Soj
	8Ss+jpOYyc7Ek1mcFUGpvUE7auUlgqKdY=; b=JvL+yoBSun7yOSQJgt+EXxJF8W
	lX6i64hacaUka+5fiD8ZY84GdQimTBrJnXMF3Ch0Wji8a7HGUQ2E+zYy/eOCvAuJ
	aCAnEa6hWbTpuiO/NJNaqh1c25yAGwArtQp4/bwJADA9ycTEGSzozHykLcSmYzdo
	fHSvpX5XjRlaiHbdj08zrRv13Cgu6UVHJQZIfsGdYANZRVXKamaEGjGG0oCswWGB
	kiiMGRb4xnH93fzNRjRSMeyhM1047I27TsMxo/zKBvSK5TLDS6HapfOxDnDZgJ8f
	70bp7SPs74LfgK449IKxTU7Tq+0rtD4XQY6+W7lBHbofSBgCgGo67TN+yLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785181960; x=1785268360; bh=QqJBKw4Soj8Ss+jpOYyc7Ek1mcFUGpvUE7a
	uUlgqKdY=; b=XrtuT7dHU88WSYrdSmwgyh67J5uZNk7myYjFCa0t1UgzWhWrK97
	u3B2+rvfjzn9M/iMBr0d16kyEWZIcK3TByFLBIEt/+kznfbAQ5OnxEgNba3UcFxh
	8yWWie3Lt51wd39kq999zOyTuCn/gFOXfE8Rx3300B0P+/PXeUYf1WEKE6A91RDW
	S7o+ohzg7xrbgzr/7ZtuXgLA+M0XGUczsKP+00k5g9FxOgwNoCW0s1I0c9ODUtMG
	M8de4guFD9fctkt1fm0J54fiIJM0YLO5nbDL3MK6SDvBP5X3+YcXCjTYTh5OTfwI
	gG89XS2y7ZBXNASCnE2zcuK256z+fR9Yobg==
X-ME-Sender: <xms:CLdnauJNu6siTtaOhSjROECrDo2O4VcOrtEnwE_nS0HINCjyh6QZLA>
    <xme:CLdnaoY53y3IRVFlhMakZyL_40rzgorPH9Z5sc9QISRXvTlmMCzoUt-vRDkfqRkAQ
    Q8CSRqy2fhfn9mAk2cTDC53A1sciyQVrFLbk1tva1ELm0eTjUZweg>
X-ME-Received: <xmr:CLdnag--hTxvmv88DkZUmkdelrSnaaps5le-95oYqSFwbcPJiChvFx_qn27i9A6ACfq6rTQ1J6_Wzz-1ej7pwjfEOTDOXfNcjw>
X-ME-Proxy-Cause: dmFkZTEHkS4Z/a03lr1afrgkM0zxaIRmmsVo25QyoihpuChlIs/V3krWo9Wr+wD2z3WTRA
    M+qhkiUy3KvfkuJpfZ0JL7qPOBH5KDnOSVCmrLjKSYE48RHnqmbuFiDCx9qf7fc3FvmZBy
    4wjdV0ODoDpcwAZFf5LHpklLqoCCkf+271CU7bGUrqWA7SIwhVC1mjm2ojfjJLjsy5+2O/
    /3aveBTQ0d+DSsmZGCFZDbbovRpLyCEwI5EIe6W4qJnYPScA5emhlUeOMrWnRgONrMkb51
    eG2xqaDSKSOOKH7UxNDCEF/gy3ZI2xzJnLNfG2hb66+zHhpdUi7R1twdT64PscoDQ45jKe
    lR67PfPWaRiwWgS7CJaXn9hRuP1MhcqQLODFw7hHPCZjwUN9tlL67tkfeTgFiVoSWHAp3D
    WJz4DTSZJ62TDhg17fjamAw3U6XI7rdCPAdmREZkq0k8yRwzMtb0tTmdSHvbizAfNxjdS4
    qC1oLjpCDOAd3SCiXqGtLZOGUtJk75DORxtCmPKo5gI3ROYyscyKmls3StOS9FcGgjmU7R
    3gPaEcocgDUC5fV/91+XtFyR9KPas+cqXk6gtijUkvWiZb9XssQi2Kq+kauJnh6SQQiR+R
    nAubV3q50MAsV5caPt8Yq0wezgzpFedXYPU8spPBLs7btMUO3dxfC1wxIHfA
X-ME-Proxy: <xmx:CLdnapbUNrS_7Gs0WqAsl-WiUbf1_OQiiAWrOjHd1ei3ahVeX1U06A>
    <xmx:CLdnakMcVFSln5mOshQQiSx8Pb-J0jzmnLNFeCbe8aMyR5AjbaK1bg>
    <xmx:CLdnalCaRfNSWf5-HlVlM1X1auXrie_Ya3TwRtuoxG4Ev7tceU0w3w>
    <xmx:CLdnarLv4DIF0VPjEVUjgNA45m72eFsM0NmlQo_IuVU4CUDcnvH9Kw>
    <xmx:CLdnamAVLransvi6M-uHZ8ju21vIeDn5rvIeGnQQULyLSwoUK9wXOKKW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 15:52:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Hardik Kumar" <hardikxk@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  <git@vger.kernel.org>,
  "Patrick Steinhardt" <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Pablo
 Sabater" <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v3] utf8: make utf8_strwidth() and utf8_strnwidth()
 return size_t
In-Reply-To: <DK9HO7JD6QT3.1ATJX1OLR8YBJ@gmail.com> (Hardik Kumar's message of
	"Mon, 27 Jul 2026 21:50:14 +0530")
References: <20260726123427.173877-1-hardikxk@gmail.com>
	<20260727065917.469738-1-hardikxk@gmail.com>
	<e971400e-6d23-463f-ae9c-a21d3c5a3563@gmail.com>
	<xmqq4ihkpjn3.fsf@gitster.g> <DK9HO7JD6QT3.1ATJX1OLR8YBJ@gmail.com>
Date: Mon, 27 Jul 2026 12:52:38 -0700
Message-ID: <xmqqtspkgqgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Hardik Kumar" <hardikxk@gmail.com> writes:

> On Mon Jul 27, 2026 at 8:25 PM IST, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> I think it would be much better to remove the TODO comment as Junio 
>>> previously suggested and instead add some documentation to the function 
>>> explaining (a) why it is appropriate for it to return an int; (b) why we 
>>> must use the cast_size_t_to_int() helper to prevent overflows (see the 
>>> commit that added that comment).
>>
>> Thanks, especially for (b) above.  That needs to be stressed if we
>> are to go in that direction.
>
> Should this be documented in a new adoc file in the technical
> documentation directory?

The best thing for the new comment to do is to replace the misguided
TODO comment that led us to this exercise.

