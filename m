Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF7D4E0B9D
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889683; cv=none; b=owb5QB7fiEuI/uFdk3GWr4TB6Qe7Ltot3hkp84D42FKYHMDvh9zYnnG6/CYqvWVTJqlAuFjFYXWod75gsCV5C67iKpJmcrF+qDAAyIeRSzDdZq/qUyfsnaZfMiS0nLmE7C7ycDEyK+mC8dQYlBINCLw2URJOGiPHd7uC4GOEtNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889683; c=relaxed/simple;
	bh=AsjmOsR02iOnDEcJA93WnGf7o8cwYA9czX2ksGq/+/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aam0Xp8y9e5VrFKxlPe/FWYjw84ZglwQNnYtDMqzXNZ1R3YWZ9dSHTbkbjDLB9i/hMVajEx36SZjL+MYnWMCtO+sfnCm8T1Ny4CisJyYJJxlUYV1p7Wqmq0H2EIf0V5NZ+bHC3tuocX68JC2FznOfcSJTRCGKstqdt4Ew1DUTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k/tNJ73B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JKFXjMMC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k/tNJ73B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKFXjMMC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 92DE1EC04D4
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:08:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 07:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791889680; x=1791976080; bh=ShytOGCVdd
	/Vjb6N5osbLivD+fRccUeC6DZF5Dotd6Q=; b=k/tNJ73BI82x4Iu204+et1D3gO
	79QPobVngGkTRDIvby8eFWM1fWh/pxkMSLYk7xLd/24zCma5t5ARQ17ZIuyn/DDZ
	g1dSamFQh/LJnK5pQjqULqg9efGECcf4Xrgb62DfSlK1oC6HNQoHkRey5xQspm7s
	awO4HmViq/IjmIG0xTXCvbYKPTWjuYI/nviCyfAOjwpOpURP6vMGEC7I0HysYkd9
	jQqyN92RVd40NdcZ6aUe7uUcn0+RrGll2EjGg8fsFc+K+bzqzExMoFgQFiWGqOyP
	QlTPE/4FwIbF0TRMV/o83d4LDFwATQ9PaL82dmNy/dhgy6+iceSwOEa8Qcmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791889680; x=1791976080; bh=ShytOGCVdd/Vjb6N5osbLivD+fRccUeC6DZ
	F5Dotd6Q=; b=JKFXjMMCyEkMH9u0StAFdjJFRQLNla/vyPmPrD7/lGYRaVCncla
	tpBIZlcZRZRHv49aM8dhke8bfPmupvN0lxer/2cQUFC+XUDm0MvH9XQsPMer1uF1
	kQbHQi5L41onQKvyvIjUFiILhTjstYIvYWmWm7Di6m3/maVmi4mz5ro8LcgWNOVN
	Qd5jRu2MM8oFQeVp2ToD8jIEsZhBmblg/xnZNTuA07aca2c3OuRufvxjE/oNXrlP
	jUgOL16g6OfWPGLN7afKGk8kPiMzyGooqqmKPr8AlGbxGv5mKI4BMUmKoBl2Zn3T
	dERGqO2LKUKxWPyI7Dm3prtS6jPMAQjv+wg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791889680; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sHUDJ1p5f36Xk82qfdqhKIs13iVN9HIFLan7pq0C98dKyvM
	wIYKOuVRoy6eAksd3YkrRHRV8ATR00oIfhNfa2UGZmCdxSXmckuG7dxulMiOYxEf
	rpqoTOlWZEcxNcojbNnE/e9x9tdjzgj4y3WLx08Re0qrm5NdgaKohggQsGDHjEaH
	8rP5gK6j8iyTOYm0JHeKXjrVtJdLJT0lnH5DblWpDNVIgJfCU2BSQ1DWFZjgM+c3
	Wae0QYiI6CV6c/7vxPBe2rLvFc+aw9QKCwgv9kGmasUOL8l1ANzbDeVjCPEvaK5e
	0wDsYlvb3orzhQ0O/GKJbnRsR+4pV/W024OTD8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ofb7eW0LeIVSBMx7Zq7+mNntpVczBrfV9YdF+IowuI8=:AsjmOsR02iOnDEcJA93WnGf7o8cwYA9czX2ksGq/+/A=;
X-ME-Sender: <xms:EBHOarac1LZ286LFq19CevjGpszU6XTL9-Zu12biOc_5EJOcdyCs6Q>
    <xme:EBHOahQkR0T77ZRDGS6GzDeJGAuGgBsGewKNBF2x77QX5nQ2R8K1nTGzfwLJdXDD9
    4P99EDDmG0a2iocoYoLZ0M-dAQVyj770Rdjhf0E8kS0L9jIRIw6_NY>
X-ME-Received: <xmr:EBHOamTnNjoqWuC91YGVYkFfCtrevYiSC96BJBtNHUvLppXS7QBbNw>
X-ME-Proxy-Cause: dmFkZTE////y82QBfg8pCrBvjKyJpJqdpNuPlwL7ODs34qGHwJe4WFOgY0utLO1ex1OgA2
    bRC/yRTjq513Nywcwe8jFql7hVhEF1/vwCanHVaFBubkUGKcZFdyaZwpb9ElUfNUM/CMIU
    fXrcjfrZIKhF9OEjXydQQsGSmy+FlSSLfCySXaxTDh7l+61XGJFp+5S/emPeKPOPkO5f7y
    YEpoygjqAGTRxSm5JehPeXiOfBMUao2PkFudCXag99KK3TEAzfQT533Jq1rW1+MgYceMFA
    UvmV57GRLScmZJBurDkEhfYqcG8ZBeH/5slVdYORMFcDambmHbxvO8T86A4E9J1FqYpRo+
    Qs1zZDG3JoWUdRIYpXLfnI4tbnW672tcGptafnjwkJBxCFSKRP8UAhfd3WmETHoM5ukCeX
    UuwklJA/DgWfyiMOzeIqKM3gREZE8uUv8UifwbI1GHB191FAywX1LHxvKnRFV8S0FBkNXR
    iDUCjzdJgYl+ndyAqEZoIjlNnPV3UVjxdWOe/RrXTrDm66UCe3d3W9I3lr0352fFKQviMY
    3ZSMJ1Jpj129wbU0qunTjgSO7roIQ4oVDmG/UVaP8kr+yrb7nsBWlbBSUwuHx8kMmQJ5Q4
    FsSMztde7yttwATwuHP6ASUtAEHbs/oK6zonpLMtAlKg0eHotGXgucv7wiaQ
X-ME-Proxy: <xmx:EBHOatSHFasFyYlyW1x583u35Esv0IGSmYyhQE22MVyMPt9Zojhe2g>
    <xmx:EBHOaj4KuXSoNDUYcXfDAt7Cbq9FinXc3MXyQmFgo7jvVjFLNeovIQ>
    <xmx:EBHOah1qISsIFX6AzaScQR1mmpF-DIJdWw-yr5WZ_M0ZDnQABQFatQ>
    <xmx:EBHOamCEhbHktCYMHDLbSsWQJLAnieHED4GeSwx-bV409XU7bEQ5bA>
    <xmx:EBHOalwZpRyKIcerCcG2_M1MUp5N9K9VIePnqaQCPYqFsZ2uADn3UaCK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 07:07:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 68719390 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 11:07:58 +0000 (UTC)
Date: Tue, 13 Oct 2026 13:07:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 5/6] doc: git-cherry-pick: link to new merge conflicts
 guide
Message-ID: <as4RC-g606poy2WB@pks.im>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
 <f99c99f955a101d1aa8c55c0689e3c1230e3d303.1791816795.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f99c99f955a101d1aa8c55c0689e3c1230e3d303.1791816795.git.gitgitgadget@gmail.com>

On Mon, Oct 12, 2026 at 02:53:14PM +0000, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> Remove the discussion of merge conflicts and replace it with a link to
> the guide.

Nit: you don't really change the discussion anymore, so this commit
message is inaccurate by now.

Patrick
