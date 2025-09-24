Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5061EE019
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694720; cv=none; b=Q5jJVHQO8JuxpEX4M1uOpwZOHCdZ+m2ydSlsqK7YPmD5sz5V1dkf9lvj7/Q4292JGAcAbN2QLm7I1jP+Hwl36vjTwX6lwXktbuxNfUsrTmFlDs7JSFJrVRZBntk8A0e+ADWrvWWdnLNJwSS1QenYlnwbdL7WDEVmFiTdDIRjWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694720; c=relaxed/simple;
	bh=DnGc07C+CEma93ha2zxYjF2bGMHGLr9JduxBL6DcxBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG+QZhbF4aS8EsHzix5uXXNQdPEwtlQw34tfsXRHxr5RHFrkSLJ0rxhU+me3/bKEZLbCU3gs/+HDvgDCfdP9eu68dfsKwSA73tkFB7+BxXK+/uZnUTkVccpiYfkGpWW/1UBbF5JCyMMQ7Lpk2c4TzjQxi911yqO3dhBnrTG6d9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ERVspYYi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITXnBbu0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ERVspYYi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITXnBbu0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E1C30EC00EA;
	Wed, 24 Sep 2025 02:18:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 02:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758694717; x=1758781117; bh=9uN4UAQDeF
	UptzvNC6dY24poDage9161XZxz3E/Y/KI=; b=ERVspYYiVR3OTLzXiXXPk8vPMX
	yaOXURfT7V3yRfE8GHfSIOwoidt1cEV6wA5T0ZVBpDLGpq3i3coMdNyJLbNZc1hn
	QMOAlnTjppgVLo28SVbv5d1Prp0ibnjz/GdnIwSN2JDMmmqYAkDHjCWPfwIvnqUj
	JrRldusnAyIX9fvPGkhT/QjPkYaG6bDtE12r5LBgKk8WFt4EfehrmMHNYY0kcfTD
	cpYpuhVklJ8wXNyFP8W80nti1epe5NmK2+c+I6Ny2uUHQVS+arjdk7fZ0gE2qJDr
	IuBKR+ZTORYSdBFJDtI58SxFAqaMij74SSb4lPKMMbVyrl5NA/AqaM3V03VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758694717; x=1758781117; bh=9uN4UAQDeFUptzvNC6dY24poDage9161XZx
	z3E/Y/KI=; b=ITXnBbu01gl1GBvrxlR1zaUvYxKmxUWZF9fVdr4zaamgKI0NRuI
	LN6NZTAi5bi9zPMD68AaUJWcb1ay1agPSx6XRetQScvkhdJr0UPSKTvcjFsCCeXq
	XUzHPAsKFYwlpuLh6gOmAtAxwldbUU3wkFPlDqc5KquTwoVpHDBtgkrI0SgO9Dih
	H486djeT9U7pcGzKxkh0jubCKG/XmSJ7Apd3/kHzRB9CNukrcclVIlic+aqhih/4
	SJvJtjt3QvwAIwB1RIqm6T+hhk6dPvntlSfiG/8c5k0a5AhslUvXJ2Yoqliy0prd
	6h0m8tAhSBkuppEEpD5cjNLZvbg6A+tkOHg==
X-ME-Sender: <xms:PY3TaCY5JV5K2iGlWv-vJlp29TXfSJQGVzI6Dt9bD230NlMS6BgEBw>
    <xme:PY3TaMY5aI2IuWJl64zVozkqmAMH4-zT_fyWjfRes-iFJbGT8gMrkGyTuMeZxWtCo
    Hkd4njTj0tnrOS3wPRc3bq5VqlKJsI1hoTZ2f_hUk7Z6YKiyz2g>
X-ME-Received: <xmr:PY3TaB-Luj2hQHhvB-FCpXM0I7XkiU2idJGHpvEpCnM7DwZBPPCFHBG-jD5wnlcrSBTK1GeLPbbWA9LVBjCgX5XJwKKurXuqe-zZ6xsxwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PY3TaDgkH93Of9tqBauCTiVGiT921yFnLD2VhCNl_Ec8-3qtAB6xOw>
    <xmx:PY3TaJfxrcHUGO17BgI7g08ERDTq4rRAomVijIB_zp6-5-R40MLbyw>
    <xmx:PY3TaCrV57UfaLRpjWnUTp3OkzvuNiFefnvPIm_Y7caOCHXN8OuSTg>
    <xmx:PY3TaGCS3DNGrHPBN-lKbxOzNfDcEtMs5pPlAQyBJzbmMwNzkT01Ew>
    <xmx:PY3TaBcuULq33ZxZ96vV8Tk1j7ei6PMy0wa-ZH4XK5njWppQLOqtv-E_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 02:18:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d597c2e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 06:18:35 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:18:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH v4 1/9] refs: add a generic 'optimize' API
Message-ID: <aNONOM4W7kUQNm1y@pks.im>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
 <20250919082647.535213-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919082647.535213-2-meetsoni3017@gmail.com>

On Fri, Sep 19, 2025 at 01:56:39PM +0530, Meet Soni wrote:
> The existing `pack-refs` API is conceptually tied to the 'files'
> backend, but its behavior is generic (e.g., it triggers compaction for
> reftable). This naming is confusing.
> 
> Introduce a new generic refs_optimize() API that dispatches to a
> backend-specific implementation via a new 'optimize' vtable method.
> 
> This lays the architectural groundwork for different reference backends
> (like 'files' and 'reftable') to provide their own storage optimization
> logic, which will be called from a single, generic entry point.

I agree with this change in the architecture in general -- "packing
refs" is certainly a term that is specific to the "files" backend. So
renaming that infrastructure to instead say "optimizing refs" feels like
a sensible step as it adjusts naming to reality.

But what I don't quite get is why we end up with both a `pack_refs_fn`
and an `optimize_fn` after this series, where the latter is always
calling the former. Wouldn't it be more sensible step to make this a
couple of simple renames? E.g.:

  - `pack_refs_fn` -> `optimize_refs_fn`
  - `refs_pack_refs()` -> `refs_optimize()`
  - `struct pack_refs_opts` -> `struct refs_optimize_opts`

It would probably be a bit of the bigger patch to do all these renames
at once. But there aren't _that_ many users of this infra, and I'd quite
welcome those changes.

Patrick
