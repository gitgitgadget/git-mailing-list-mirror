Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE82989B5
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824455; cv=none; b=Zv+J6L0us4qDeaxj/HEa1W1Ydt2JSPUgQBFdCJK32PktJFRo9zgvjgclqgSsgfMffnVVBonzgMsTqIjOTftm2nT512BWoUF4tk1w3dYQ+Ur+g7qSX5NvkbeqspckdV+Z9xUjriqS71Etp0pkAAhKPAPmqhWYpXL6WhCNzhtUOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824455; c=relaxed/simple;
	bh=EidI0sFVD+7rD3/BW0VVay1PWS4t1nw6e/e/V20gfSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCbmPjNk72aRAj5CWlK7Vlejbrge3cwVrBmz4aDaxUoH3A1bXsy2vP1PjowQzjIKEBukODXML+xksrGupr42OynfH+1KkShL1JBcr0KkkBz9yChNop9ccrIWaEskpjXizJdfTNFTiQZ+S7GjhgVc/HY1qRIrF/fVsa9mz/AI6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=QNX2lLpa; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="QNX2lLpa"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2a99so3249998fac.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790824452; x=1791429252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jwyxySeX9ZUM4CVke83cyq1gUGlwfT/adVFfY2uPw+I=;
        b=QNX2lLpaKzMKOQvxAF3yhqyKBsdKdZQw/jQE3UuIuM6fCsP2cvAApOl6VHlHkUcmyd
         hVUOHXyDil5ux4t2rusrpREgrCf5fEB3/a6ZOFlXXpH+ioo6748CRoVmJF/hwB+WnHde
         ZluG2hJzWlEAgRdsE/hqKld73tz/uvjv6TMDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824452; x=1791429252;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jwyxySeX9ZUM4CVke83cyq1gUGlwfT/adVFfY2uPw+I=;
        b=zCp0LjZy4Zd0m6covMXg6bTH58kBZScaNm5+XC/W1sinorQdSmmrdi7NrFqVX2mKPi
         ePVTxjBcSjvfdZjNBl3ti5p7/lkn/hPo9ALyEAhEbKCSWP0r6uk2CFOX3GvH4pXN4EIq
         VrsLxoAk10n6DRcs4266s4z13GdP04vXG5Nz5SCrMAy/93aJOFthposZTpeR99UyLx4E
         xDMalVY8+Bqjy+4UXG6G/tWFoBS0RlmOUzNdRdSPs2hOZbI0qCoNxQodAlEzvncpx8yb
         O+DHKKRCxSmjvBjUi2dPJ/Tt7HuynaMJF/iG67WD4pqcOPDhItZ58kbey6feoMXGY0m0
         Gs2w==
X-Gm-Message-State: AFuF++n/BmlD97sSdhMQOaK3/7n5poL4oNNZsvoYdytFed4DzNLV1peO
	GJA/To3M8JVbymoQSCJAW45cknN65o0j2LInlbGrj3UbtfRgMwrlLPPDWa5+YYtchBk=
X-Gm-Gg: AYBFou3/5DXZ2esLxyJtIVk5HTtCMdjRhq/AXjg0Z1xKOBVI5xHLJOYqso+UpAd/o1K
	FRq+4aIRpeXePfz8MHTtrDSlrFHGnGVTrABhTIBC6wDvMndNusek60T01naTGZ51CVPw5acVJ7J
	ihmYX7VGRIfz7anLKkX5oJRlmI3r7tUoWvtKoezItlAoqtLvSS/T3sCB2+3gFTpn1lDElDdwVOI
	Vi/OV5K7dijwib/4h4g16tIX0mY7ASx9PDKRoL4KT9bT45LqfDzhdSvqeC2y/fFLcfRuxVDQu1H
	VWZGC6zkPX3YF+eO0eKeUnjcpwrL4cbNvZKulktlGK6oW0/t191bSys6k8qJg6tDcJ6S0BtyT/F
	VBK65D0+ryEaHLmbK2fWV+oOhA4LzSIlty/tvynK6z4GiheO8x7gGCFsrqNGniwUsi3uSK3P6qo
	JGKPc+SCLpugPzhh2KAKJLJ0/3JUH7SG5BegH7ouPYd3ikP3NXhSFBG5puxQs/XK/NwhglRSn+4
	hchxmiBVcMoJg6en+e9si06B6E/kmfjRzn3Op7pbo4ks9jIf/5DH5wyrjGg79PtbjDofWqz6p9u
	lU89vNgs
X-Received: by 2002:a05:6808:c197:b0:4cb:26a3:a0dc with SMTP id 5614622812f47-4f1b4c6bcb2mr4550048b6e.20.1790824447545;
        Wed, 30 Sep 2026 20:14:07 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f34c787c02sm1328823b6e.14.2026.09.30.20.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:14:06 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:13:59 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 1/4] pack-objects: introduce `stdin_packs_context` struct
Message-ID: <ar3P9650Hj1uOR3C@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <64bb13e2db2e5c22e842c188e08861d63e99dc77.1790731662.git.me@ttaylorr.com>
 <xmqqik3mbpql.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqik3mbpql.fsf@gitster.g>

On Wed, Sep 30, 2026 at 10:42:10AM -0700, Junio C Hamano wrote:
> We used to take _data that is rev_info, but no longer.  We lost decl
> for "struct rev_info *revs" and rewrote its only use to directly
> reference ctx->revs.  As long as the result compiles, we know there
> is no stray reference to "revs" left in this function, so the
> rewrite is complete.  It is rare but I love this kind of patch whose
> correctness can be seen without reading beyond the context ;-)

;-)

> It is not clear to me what the implication of assuming a non-NULL
> 'ctx' always means a non-NULL 'ctx->revs' is for the code health in
> the longer term, though.

That's fair. For the following round, I added a small note next to the
'revs' member in the struct's definition to indicate that it must be
non-NULL.

Thanks,
Taylor
