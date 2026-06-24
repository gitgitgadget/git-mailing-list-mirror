Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47F34C124
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782332392; cv=none; b=Ovfjl5S9bHV4BMgXkA083gUAKIJOV3HQ8jF9cqnvCLI5ZLGmWxKVtALfGjzcjMFyWwlNSqMFy2rFymKcCSxbQnVaZTzQGnZdnlR0lhSWizsmvqbdjVNeh1f0lWDbV2KWr6UqzoGAQjCHxnY+EBwrI/JY/kPFg/SwqCItxU1QIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782332392; c=relaxed/simple;
	bh=0DTSF7y2xLOnHrbuhmkUDbVSeoP1GMetqRJofexPngM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7Tbzix9dBBwE9CLVkUpEf637Wbr4b43UC1YYYtVCmmXaEIZU6VD29aKMM4PIfzTGMrVsfQiHVhPFPu06fyJ/GzKTLZDbAB0aFfjsVdhDhznSeqFrqU8rD++GWNPPuUS4cf7ApXBUCUgOp2CBUDxKtzM4dxUob5Xgn06QXQmSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f7PdmfVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dY18YuMt; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f7PdmfVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dY18YuMt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F90F7A00E1;
	Wed, 24 Jun 2026 16:19:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 16:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782332389; x=1782418789; bh=BARZHpcbvk
	F5GL0wnqXWII0B0CM7ATAAheUdvepfUWE=; b=f7PdmfVv/vPKwM5+CHYITefoNd
	qHQmZw+uLSJjrfjn6VA3/h0tPet2m7OJTW18jNX5aKIq2Qg5BhdJbDV2OzVlrXv3
	kzKD88ATtqIWdg7Q8hu09bERSiptJTs5blVYX3vmVWXkXZWl4ppyOJn29u0DdjJU
	qYuTVObeSfGGwFQ2dsKe5SivOWe8/anOrHzXPzwLom7Q14X40ZUyVNuya4AjtHSE
	PWTH3hvZY6hN3v1PBDFoJhSZq57E3fxzRie+tjxZMKopiPKET2vrQjzfdDM06+dq
	60FpS6b3ApxoN3SUYZcwiRBHbFsNdrUoKEw5P8MpruuiawfjpITURNekxgUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782332389; x=1782418789; bh=BARZHpcbvkF5GL0wnqXWII0B0CM7ATAAheU
	dvepfUWE=; b=dY18YuMtwjKE0105Dz3h9BfCcNziXBDqKwuPcuPj78IiZ5M6ySj
	OKCs8c3GtqklVzYlDctbub3bf73sCukY/RGFhpo6WaYK7vT1By/jvF4sKwqr/n3m
	4PYiSvxOiLOPDqLKTnjxbaIGLfdXVs2iilqnEvcERpUj9jISremETyqNox67eL4g
	CuifKL6QC2SdrZdIQFYlJ1gGepIH3JLAHv89ZFvFXPwjp4bZ0UMM0Yz8uy9oxeEm
	uvqJI+o1pTtHgaXgN/YTPTo2l4rWxl0GxFe3t0Uc8H/7mdHSU01D+2Jq7/9D/ViA
	JUEOyWHMEtA3N5Uyvk9ZxRakSH5m1PZxEhg==
X-ME-Sender: <xms:5Ts8ao394m0HI4eSCvEL-2V5SS70WyzEayVUCj5ko1geYwpQsD9zCw>
    <xme:5Ts8au4NoHpgk0WNQMktAQnEI7gyixoTAF7-8vCoumDr87tWJAvFugrBBaJpeLRLC
    OeUslDH1ZdRLwbHlZ29icVJzhaDL4ViiMfV-dHBpchxrthUKWZtvg>
X-ME-Received: <xmr:5Ts8asT7YgbpYQtT_SAF4ZqrSCr-q0_E3n7s_OODFhul71dZdB-3kWvN3Wfiyggj_xiI0n4hfisQWXtWpf_npmrELr_SN6mMSO6b0rY>
X-ME-Proxy-Cause: dmFkZTGlXbdWDZyVWfDrvq7qIfWR/omGEPyP08oTGJuDserGflHLdJiz5/DMri3McaETMW
    00BbXy+5ToDRltUkpIbUHRcM6EUNt4Q93NDqT/DHgvpp+yIe6eEJLdpu6OvNJ80QLVHiXH
    sXfSMgiFDe35XM67VpU2M3RuIpASLGzTPvnp8ThbIUPaTvTZjdPTx/DcR5+oPzp4iDDOsx
    m2GPS+MsrchvG12vUtAEf06LDBczyr6qv6di/+KMkhGOI2P9YIS4xQn03u+KKGObGtkutf
    lCHUs9pdjkM8DZ+dbwbO3Jss3jRsJxIA2eCYAPUVt1D+1TikagJpzZUcCZpezI7jqV8ckR
    ogba/pGQeSONSqgb1/FheZ6lFIec0vJjdwK7jkb4tNk8yz7i4DCPiCqHZZ1FLpiSQFUFpf
    wQjjq+1U1eksIrLVZuUi9nOtWxnYAoUykG+UHIhLWw4/oWGvIErSzuxQ790O8vO4cKG2Fu
    1lizEn66dneEfSidd3mzAXnT+HPaMBlBk9BFKIsDuBrZW41JyBH4D/BFm3rgf8L7aKCRjV
    vLhZWqVR92AZ+i3hNGUEiIgmfbXTuV1Rs81F/hnh3E5oEckwu7Yx+M15flMaK9nfEsvClM
    tlbGV2gMY2Ukbjf4oIsF4CWX6IbWhlTUq+7fC4Rho8MBEVmVvSxstxK6jzkg
X-ME-Proxy: <xmx:5Ts8arWHtelrz6hdItvSurZZArx01XP60aLj-MqaK8gMNS2mkd_tyg>
    <xmx:5Ts8apH8nfH-HZrOi4HjTjc-BEgmOuRSG6sEbvCSmY9Dzs6Nnak5Rw>
    <xmx:5Ts8ameh2Y9oIBTHX5aOcuwFOURcoN4mrIXGckFaagPHQvXbfhxgEA>
    <xmx:5Ts8aqpQOa2_WKAuHotCNPpLwt-CL_xpelBG9W5i6ZDvY0baL8WKSQ>
    <xmx:5Ts8anQoyhISgfLyalIq24emd8_xb48t9YYNCWKx9poOlZ5lGRElXw5i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 16:19:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  peff@peff.net,
  eric.peijian@gmail.com,  chriscool@tuxfamily.org,  git@vger.kernel.org,
  jltobler@gmail.com,  toon@iotcl.com,  chandrapratap3519@gmail.com,
  Jonathan Tan <jonathantanmy@google.com>,  Calvin Wan
 <calvinwan@google.com>
Subject: Re: [PATCH GSoC RFC v13 06/12] connect: refactor packet writing
In-Reply-To: <CAOLa=ZSvxXuf_bSzKMvViNQ5MuDAqxnQdo4asF9vfMhJaDQcVw@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 22 Jun 2026 15:43:01 -0500")
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
	<20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
	<20260619-ps-eric-work-rebase-v13-6-3d4c7315d2f8@gmail.com>
	<CAOLa=ZSvxXuf_bSzKMvViNQ5MuDAqxnQdo4asF9vfMhJaDQcVw@mail.gmail.com>
Date: Wed, 24 Jun 2026 13:19:47 -0700
Message-ID: <xmqqpl1fhesc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> +/*
>> + * Writes a command along with the requested server capabilities/features into a
>> + * request buffer.
>> + */
>>  struct string_list;
>
> The comment should be above the function and not the forward
> declaration.
>
> While we're here, why not `#include "string-list.h"` and remove the
> forward declaration, is there a circular dependency?

Isn't it to avoid unnecessary include?  When the header itself only
needs to know about the presence of the type, and not the concrete
shape of the type (e.g., because it only uses a pointer to that
type), it may be overkill to include the entire header file.

