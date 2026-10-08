Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9944CEE66
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471823; cv=none; b=Pe3P3F+JHyc79QoL3q3qiOhnQOHKJTrSIyIbttkJv6UoOmYFdgxPLmfUwCndkAS27K5qQeY8ovOP/XN6cYdQdFmGZPBAOdlzlK8s7qQtPCkKq55GiYRXyK7WnibvJSak1jLFgsyIkIBzh9oOmkgCecqwdWInjvTOfHIGIhKeCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471823; c=relaxed/simple;
	bh=LiBXcHolJt2wRQ5AY+foejd5gxiLLycdhg9tNe8wlpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGW9aX+MUcfMRlHOPqwx9pjwg3VV9I0BHx/axEOS4nCIw6mvY9bQL+i+h4ut0JetjoSeaTZfvI2NRurgYItuINaXJfZzOftXKlasL6yTKtrymdxF6H/JakuL7nAMPXNT+68+u+row4pX8N/CqHjbstprlv3ZXla95LyCU9s8kBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ScvFmhk6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IwYC6M23; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ScvFmhk6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IwYC6M23"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0FD87A010F
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 11:03:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 11:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791471818; x=1791558218; bh=u2ENCGAtEy
	zpMZ/GTHNS/d2di9HOJOl7s1KTr3cvZPw=; b=ScvFmhk6E1S8yEOhmonkhBX5xu
	3gMRdatSzXjwQTU0XO1rBZk8wLoqNjHiUWPTrf2SZuqLQNQ8D4MK/tKRQjanji0C
	upY+QjZDiS5rCPo7mOG31TDoNxn8NyOYc57qmFcNnFImnXwDdNsMZoOlbybY2wCV
	pCibjTrmClEX2r3PSxnpukhKixRAnmG0kTNlJNHM7TSAgMEzfZXB/6uN+nIMQzBH
	TBSbicjnV9LBWSenxkkWgQgDXgV30zeGYjms0rC4BvbbNM+wBUSQ9VvrrvSAkwQ3
	Msj3R8cbWpFpxe+4gFTmPgrw642jiHpa/nDVDFOuXJO6XNGX/b0tpx5/Fr7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791471818; x=1791558218; bh=u2ENCGAtEyzpMZ/GTHNS/d2di9HOJOl7s1K
	Tr3cvZPw=; b=IwYC6M23BJVA+fC6F4byalCd5N1to8nxw0sGou34+Ytr8P43KCP
	zL6KRvJrCV9JdgjL8HmTdYIfvM4BG0QyqkiIEB3ObZ7EXfM7Qgvmf3s/EHBCT17o
	DY7ddI/36Zr2Sg/fRCa2XxJAw4vWsJdJcDJbsLmQhoxJDUFNpdsceKb2Gq+UPw3V
	VWF2wuGsJnYMh0mc9ouYl49ktm9mTXS67aFzpkeMRAjiFzdOG5vdSDBxVQotS+IJ
	FO+kHzbvJYbyNhpJWHnAldR+mKjqOLWLWne+qrFAhkDahfiOFIga/kpymsxuY1mD
	BnAd+MvVW+vrgH7Pg8OygfQoHwme6TE7N4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791471818; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jN+pX1vt41FHXVK1b0XZMnRQHJxf004PE1e1UTbYWG0214O
	NGdwB+67J6M5QLj93Egj3C9LuWrNEZP7voohLlWkUI1Q4ssgz+YeaTvfS3Ncf+QU
	9pdtB1S4SiUnMmqx7yqq/cgEW+hj8al+wAebeWeadFOcKQCbbub2RdnYemwHH1N5
	BZ24mvgPp0byIaPhZLPrG4+8nreYqcmaT4swVVfM9vlqqtXMW4vyWkH5jkwB0+sC
	CvWs/b0pGUB/F0k050l6tyOrUYLfcxjljrviB0qtt7G5mOqc2Ljl0xrfYkUrKTkE
	Zs41b8ZvZ3nY+Yhpl3Y6FgO4P55yiKXiSDoS2Sg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G8JEVdAKGMMbR4uYIkJPZc8eiGCgCm59NU+TmhNS7rY=:LiBXcHolJt2wRQ5AY+foejd5gxiLLycdhg9tNe8wlpM=;
X-ME-Sender: <xms:yrDHak3WQSryK9J0YVzBZVY_g2al1zrr0vgrfI4QBJJwbWj81u43Uw>
    <xme:yrDHamEtvNy6_ZlDchyHpD7ezZk4lHgPQCTXGlcdNRBYvVeYiwdpcc0CymQb5wMg-
    -d3o7Blse-8b6zBexo6wd1hD8qbfNbVKrCykghhn39rnC2ZCSMttKI>
X-ME-Received: <xmr:yrDHah6GOm68opm2CWfnYy9Qac3c1nuoKhIFMutfm-D7syfVQJAqJVZMiDzbxtEzmJ1giLSogomV0fnPqdOZ9RVgqZqm0LGDGgU9hUU8MGtEMFX4cSSQSG4>
X-ME-Proxy-Cause: dmFkZTF8jXM6q6Si954JtVPfHBoGpr38qlWegnsEzv4vN5cmh9RUzH2WHtoUle7gWbMgts
    qWIH+Cxda/VSwQAqWZCK4cgzZB+3u69Cc6KZjQmboCb2vVP4AvF8aGroXI+0AM8ry1W5mT
    bS6+wZBsiW2uWOngAV1wBHSO7aTGT4PzwXjmeW/UUEsWlvPxHKtcDdcyTswe0Kbe1F01jn
    aBAaLUIiRm44fxDazVJy+8N33fzdt2jFP5C/8uUZh3/pbvSdjc/obyeVEIT2ximCBkrsv1
    xF3Pq4gFCTZdalCUMXFq0fZMf79DbhsbHlC2zM8Pfyd9mL7YY0Kea9eBrC0UjQ+4FGGGc7
    dJAraRL+7tv/r4MlOBAnY5LfnRUs64GRu+hQqwloM+yXg3DVidTYMAcCHJIB1Kgdw6Eorl
    FOZu/vNyfuYOrkR9khp2+aKymvveBflYPnjfYoKfUSxOZMcvZqyFU8wbTDCT0eCg0x8ZGf
    NRuaG5gMRE7h0UMSsgo+8ennUbp4nvpW90IUHly/8CAHjmoi+JWeUzNy3DLtHSp6NkUbIS
    CgeB22WRTkgZtQfrnprj9txRGC5LGcbg38KY+i9Sepiy2EXCAPZKu1S/DF5QYAVFKjIhJ2
    NkpEud6p+1cg99LhLIcBFNwWmJ3YNA7rSwfPxGzVHzA3aSmr1GAFaSejZTjQ
X-ME-Proxy: <xmx:yrDHasscMgQye7P61I0s8Ikt0SeFO-tXthiXHIQ1-tbxxDsPusC62A>
    <xmx:yrDHai7amRH_jgpvMWj93YhtUXuPrEzpFJU6ND2vgxAh2gtiHQoQBQ>
    <xmx:yrDHanWHhQ21oDa8VkssIRRiCOXUYiLxAG9DNjA_OjYKJ6clwEb4wQ>
    <xmx:yrDHak_eVJet8DTN0NI3iLOclcmQ4oUqcZpNKIxn_LoYXF1akgmDlQ>
    <xmx:yrDHai0V8nkk-7EyMqRfHG4BZW8ITeZZ9BagSZJS3_cgmrZ9v3ZHgQbT>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 11:03:37 -0400 (EDT)
Date: Thu, 8 Oct 2026 11:03:36 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] ci: switch away from unsupported i386/ubuntu image
Message-ID: <20261008150336.CzZS-oEZ@teonanacatl.net>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
 <20261008-pks-ci-housekeeping-v1-4-baf015c589c0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-pks-ci-housekeeping-v1-4-baf015c589c0@pks.im>

Patrick Steinhardt wrote:
> The linux32 job is used to exercise Git on a 32 bit platform. That job
> uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
> nowadays. Furthermore, Ubuntu has dropped support for 32 bit entirely
> with the 20.04 release, so we cannot easily upgrade it to a more recent
> image anymore.

Should "with the 20.04 release" be 22.04 (or whatever
release dropped i386)?

We've been using 20.04, so i386 support wasn't dropped
there, I presume.

You could say "after the 20.04 release" perhaps, but that
seems less useful.  In that case, you avoid using a version
at all, e.g. "dropped support ...  entirely in subsequent
releases" or something.

Cheers,

-- 
Todd
