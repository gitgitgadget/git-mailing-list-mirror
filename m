Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6E35F5E1
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484099; cv=none; b=pPzUj/6fEuXD0HARTy/fsVQYgTZllBFNeda1h7TyvjD/A7mAm/6pH13anoD9OTtEhq9U7Oj0tLMoBqJd1p4JSgLcgpN3eKKA/13emrLnm2mSXiifqwVdzi/LQjQwJP6rFFlNvv4afN9KbgESnh63GJjgbHiN7UdW3VfNNvamOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484099; c=relaxed/simple;
	bh=kpiQCFAOeaBEYtyLjpaHMg65HuGzyjmn2vlj+t5odag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oONPi8NpwBEnv/tBrolfN4n/VtDfFPwzKofvZAQ7rio22Rx0OGxNivVDBpMAkCwRJ6BmHKL7fgLytAu3lv+ZCQ44WFBpytLy3wyjb/c3zcIeWNRFr5fLJzvW4E8DH0789lXIpsTipdbY9woCf6q+0C+dGbD/YmmAA8Xxjw4N6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SgaTqpNi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OYNfUA+N; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SgaTqpNi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYNfUA+N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CB7CD1D0011B;
	Fri, 31 Jul 2026 03:48:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jul 2026 03:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785484096; x=1785570496; bh=+WrBB/U6+z
	jw27DurXROYUtgxGWUXGr9YyzsdUVj1dk=; b=SgaTqpNiJRdUjzWuuUCB9HjUPr
	fhgcOVf0jeVjpIMoCWQUJ/3lajp35gjWMQsd6YIgTTzpUnC7/55UgnA+TGxOnnpK
	20wwU1sxT+G1UbPHmbCxQMj/7IK2bjwxXnuqhLIf2WKiQiPbDRN2FXW0o4ZlMbtN
	lCQWYEkFPLV/5Y8kiNT8tjyNh94TQ/EETv+4NufzasWnm1FcXFaD3cQ98gOziFvm
	ThfeqtPYkISOgeM4DEhESBvhKGTI7FsujMUhu4NRexpzNndGduMEVsaJg+OUQhU9
	1Qoqw8v5V7u/xccv95BL80xZ62VXZ8xupWuzfVN0+tydlYTKJB/jgYbMJmjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785484096; x=1785570496; bh=+WrBB/U6+zjw27DurXROYUtgxGWUXGr9Yyz
	sdUVj1dk=; b=OYNfUA+NcfF9szS8F4IAq4zkkonQ2SZqgQYU6VDG9NkyAcwUhWi
	li+9Kcy6Sj6eHUzEKRpzyhiwtuZsYIklYNFOiOTE5GUHCsG/Em0N8JIOsoEPCQKj
	W+55vHk9XjtYbvHOKI3sC/BWMAPLt2URZoSQ3dR0djt5IFoJdv3ObvBb+oRO39Vm
	mcjJ4DBvOGPelAVE94aYmhe44Pv5I4Qeta9InCtLLS+vL9oXKDWsIIIfEKeg1+W+
	jHzdp13zFrhB0pHlitlteJZzj3arKKyqYSALB40FV/kzfXjKPQB/u5F8yrAnd410
	Ry1bAeJgedsLKtitFjLZ6KgdHtEkhBiTPSA==
X-ME-Sender: <xms:QFNsariP7ua-vr79r0hH3K1aP2p-BfRcHo5Z_aSukA0oFskermapWw>
    <xme:QFNsavd4JGhVVsKAwOBrjFpscm8VLP1fCEg9SeNYEGW9DRdegOjQVyhYzoCnsNHfn
    IlOYmBF6szImpQWyoAMTlpFZC6rXR5dfP4XY1kJPIHV0ZBdYfrSb3A>
X-ME-Received: <xmr:QFNsaodzZwbOjahPcOs2Z8AXW_d3GpQ_eWglTfEwjUqBoXBH-HHhmMH8HuPloOaewRVoBuXxxHIraayJ4wVffCRjl65_WNWurQ>
X-ME-Proxy-Cause: dmFkZTFN9AmAAB0p/9EEowvxVfHHfXmsUxnnii+vJ7cF6j0ypRJ3yB0RZQwprYTHkfqNaq
    J8u3aOmuLYy+IOZnzzgQf0VXinUr45j2RjIXUV4d7tUF/opCY3sNsf0nuDS2CY+F5YCy5i
    3MRM0M0lqv82o9q+gNn89P8B44DVbG9SkfgutIjNiImC/JUfiPqrJEYuAGDMulD8CmDBMZ
    kdLuONailjis2r7Ya++au0B7C4iqXnPtsE/DU+AfAkXqTqNyGGyoiBtGRHEElNC9TR3tG1
    dDOoKHnefHLDf4vGyGBEsjJO94xlyjtq/DgWZlOWMiIQwv+a9wwAcdzFD7Xk4YeNrG6wOI
    7psdrQwPaUJJbVUrETP2rNlmBNexvaV2dS1nQRQSl/v5BFM8YRNqnFn/t0aR7BzgbNvHnb
    BD60lVrWoXz3s5CftOVi5Uock6bFhrhy8pfRk0lbmL0uo8S6TevIw5X0pzRqSut1Dw3YaZ
    b1oY5tIwX5hU7VCO026n6WMO19SVFZ7bR4dHXliYHEEFlZ1J1dhWfGnOMJGnVv2PS9Kkez
    aj0q2HpOxPfzniBP/Cze8Vh5PQbR04c0ADrB+YkUbwXkaYyJfRS8msbtqcBdt3/seGZrW/
    8gZMzbAIUcXSFtm/H5PBvEJA9gFGdCD1Od4xG+7pgKysDcSebuQ4LiGAEH4w
X-ME-Proxy: <xmx:QFNsah_-FScGoWZEQlAEMmWQwjvdU7d6E3yFFNgLc_DklpZ0KEmdpw>
    <xmx:QFNsasmIoveakdYLRh1q2gF8gJCbKUqM0i8hVwc4Q4Is39AOAHBjkQ>
    <xmx:QFNsar9U9ujbVRVFwI5vE_GISA05Kz-LW2TMcyqb9A4NgD7jLo8GEA>
    <xmx:QFNsaim57LA1YjxAFqTe5Anp6pRYOkTIEldoFpP4p-cIAxfEDIR1lQ>
    <xmx:QFNsanqkdndhLEct0etNTC_eZNY6sW-RUHxxnOGhvzH3HP2ZGa3beF5z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 03:48:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in
 breaking changes mode
In-Reply-To: <20260729233215.398654-7-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:15 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-7-sandals@crustytoothpaste.net>
Date: Fri, 31 Jul 2026 00:48:14 -0700
Message-ID: <xmqqv79vha69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Git has historically allowed either lowercase or uppercase hex for
> object IDs, but it has always emitted only lowercase.  This has caused
> people to expect only lowercase and not handle uppercase.

It is violation of Postel's Law by other people.  We do not
necessarily have to follow suit.

Even though I said throwing object names in a single category makes
sense, it may make sense to treat the object names that we locally
use to access our own object database and those that we use when
talking with _other_ people on the net separately for the Robustness
principle, we keep being strict in what we produce and stick to
lowercase, while accepting uppercase produced by those third-party
reimplementations of Git.

