Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B238386C17
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899842; cv=none; b=M38ui33EE8jwYfsX6wwSH2ujF4RlsxMtCZ8Gh98VPRTIpEdhLsUHd9UM7vXzYAJn2veeEEjCPxG2dZZ41y38cGXoTJri1lEL6H8dnQ+q5uj/xlt7jeM19HTZIe2yMMOdZKx+J6IN02nzYopWnuku+HTaCgBFpLk1PXJBJtF2LgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899842; c=relaxed/simple;
	bh=C0ffHfWyWYw32NA3omEp7Rv1IJNRO/qCpvBa+DzCcPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUO9PUtOMCGyTfN+tyvIs3n/0dNw+KwULshjFCqgHFaKj5C1nG6eQh7VmuCgHAryhAscrHMrpa9EKn8hfiwytTbaHtx9Nc8VLtyxV09blsIqwnpcEJ/9KqW46ZEzmLlx5xA8VcxolqtLj6ukGA021MK57SXtmk8EyJ71Ysmlmac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NJJe+duc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fvbZbUho; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NJJe+duc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fvbZbUho"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FBD57A0068;
	Mon,  8 Jun 2026 02:24:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 02:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780899840; x=1780986240; bh=3v6OUaISb8
	NvbcENCPmZxnmf4AM0L14c7BQengOiTEc=; b=NJJe+ducjQdpdX5vCtUSde/Zbd
	zCxvmyHPPBv+qlGwx8TOLlMF4sWoIj20f4PMlkueCHlrt9Yau81yolTHp0MaxyS9
	4s5sMDZUfvErs4mdILuRp/k9pMzt1j6sFxSBAdyxAHikWrI4FmrH7MbuhmAueMip
	RCdVvq/M6sGNP/NoUhRFHdyJvb9UDplnPNmAiDZ+Bf2ETy0DgsdO2UEMHwZ1a74S
	F3MMIG+kKDsHIBZsYT/XBwJRm3TpbIl26u5d1J+i7OTi/8PAflRSLSXueEXNGv0B
	Zx/4MoU/VvB+4+ovLiBMk015jXEZBF7pYd0rIv8GgZDCCu9Kftpol0pfc7hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780899840; x=1780986240; bh=3v6OUaISb8NvbcENCPmZxnmf4AM0L14c7BQ
	engOiTEc=; b=fvbZbUhobWX8aefvA3SXo0WdbI/7FbVEDmLlxAUzzGvdzXsqQ2g
	dA8TOHQwSl1saqa0uHrgagpoKt6Fk4rdeDqgRe8RF4dgpUsErf6uHf8zENQ3FQ8D
	B31/CbcqLU3yD6+l3/GWt8OrAUH09aw5withOaSbWzb2zZunWt0MXUdk9aBFYsIn
	jBvqb/0p5kj3YY8SsDsfE47Z0YAlJ1VFSyL9KrT1VuV4Hnw7ZH4l8vxSNyvI6AuK
	HfABJFygAFC0SvUCIE8facwOAmj8e4wnBdHuUCrHvNmucLRuxYWQkTqilrCokDNj
	9L5/37u9qxEYH5wXjz0DM3wBXn25qYXTyIA==
X-ME-Sender: <xms:AGAmalbS4hMAXZ2U1bH-NLFegZ8Zxayp4otsU1RdsoAwvizqXVJEPg>
    <xme:AGAmaiZyaJS9IaHIOuAnzXdNPnerVA2VM2_-5t_StJ4R2OrnNIVY2s8U-Tv7eT-lh
    SIxmu6rT7VWCu-gKckYMXaVQnXvg3i-jX1uVcYhYXt9VUUxlTfF>
X-ME-Received: <xmr:AGAmalm0V2q4xuhiLV545X68bb3KnJU-fB0xO28ivluN-drcVMeZl5b4ET2i9jo2Eg7LyXyOdyq1P58IC-qPs8_J__Iyjg6aTQR9r6n0VA>
X-ME-Proxy-Cause: dmFkZTFF2EYtR10Kdrm6C+4KAgMG9mhYuNko9VLXTQztmvZjgcD9mTlMdtC8oyoMpzcx7x
    eToxXSieRBdBHrWKcE97iNpbP/cQaMX410/ZOc5PQwCjIlVcYKJQWqUrbnlFFcwjgdTZRg
    TxEo2TIf+BA/wwwK5omYghnA45FHccomZlNL+2cmY2G8MAEwbhs7poie0Gq2ZSbeYTAEZI
    tKtLDL8dBKg2A/wzlBseDqTsPakDQhequxDoj2IeIVsyLYY/aa5XsWskkbUNI6E8VNXLDl
    enXCb9mqjASSCx3Ljrp5Lp89bKWPlvU9O2/RMyYw9n9OMsF8rkyKWr1YzXQvjSw8hHPXeJ
    2unJMQmQlmJAozdk9vBejeyaLlAoYuAxaxOvcutfONi2rbBUPypR78Y3EUiKwH1K+YomIY
    1fjWd5XdagkmYLLE2VPigjkXF0pA/CRlrIDmCL1cRgDI4/DYZPdjCzfaoVxMyANTPXGnQA
    iIHqho0kcSR/50INqZLo7aFx7hHdJZYH8ysxH19jdGmIv1Ow+J/Hu5rxLrLASGR3WyclOV
    s/9M++dD2VjmHwFLQ7f55FO1+QDQSiJIBt4qPXS1ncvi7/3tpfsrNaxNJCe7zZRuXY+L5L
    end4Uk2QORvEC9fMqPpCju+7lO/RV98+gfprHL2B6wuWQk4USaPg1BGk974A
X-ME-Proxy: <xmx:AGAmauwIRqvcHuhxHPWkIAuajexTHC9DfJ-Zr1mdJ1gZrYVthGUPNg>
    <xmx:AGAmajNSLKRIAeTA2L7bhmVBaMjDImCk5-y5kwBbmwYVe_zm9YTavA>
    <xmx:AGAmaiS9VFcw0E37ENDLGRJpL5zsIaqOwujzq418e1paqg3GdNQHJg>
    <xmx:AGAmahaTx8E4xReHix2P2dbpYcja-HQm_KBZkEvIT1SyqUFw7gOXHQ>
    <xmx:AGAmarKCJJOIy5S8k3O7qEwg541CDtBFrksgFyvBu38BYB-HYJda9Q-x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:23:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef7c8acc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:23:58 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:23:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] packfile: rename `struct packfile_store` to
 `odb_source_packed`
Message-ID: <aiZf-_o9bH_EOtwe@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
 <20260604-pks-odb-source-packed-v1-1-2e7ab31b4b5c@pks.im>
 <CAOLa=ZQhGbjFbn_cpOmhYYN0xNjp1K8_Pj2mi34WzS25DG4ZEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQhGbjFbn_cpOmhYYN0xNjp1K8_Pj2mi34WzS25DG4ZEA@mail.gmail.com>

On Fri, Jun 05, 2026 at 07:25:31AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Not too long ago, we have introduced the packfile store in b7983adb51
> > (packfile: introduce a new `struct packfile_store`, 2025-09-23). This
> > struct is responsible for managing all of our access to packfiles and is
> > used as one of the two sources of objects for the "files" source.
> >
> > Back when I introduced this structure I didn't have the clear vision yet
> > that it will eventually also turn into a proper object database source,
> > and how exactly that infrastructure will look like. Now though it's
> > becoming increasingly clear that it does make sense to treat it just the
> > same as any of our other ODB sources.
> >
> > The consequence is that the naming is now a bit out-of-date: it's just
> > another source and will be turned into a proper `struct odb_source` over
> > the next couple of commits, but it's not named accordingly.
> >
> > Rename the structure to `odb_source_packed` to align it with this goal
> > and to bring it in line with the other sources we already have.
> >
> 
> Looks good, I'm assuming we'll also rename drop some of the
> `packfile_store_*` functions as things get cleaned up in the following
> commits.

In fact not all of them, mostly because I wanted to not make the patch
series even bigger than it already is. I'll clean up stragglers in a
subsequent patch series though.

Patrick
