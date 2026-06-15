Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AA3CF663
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512545; cv=none; b=RIfJJm2ZzNEpsWTVPuDzQMNs+pP4MOF6E3L1e2iSRqyPUsHE2cjN9uLYuCY1zDSZ4Ubufg0NCtLTyz5OwKuNSiLpS7Ld8knW63VQzgAdFTmWsyerMrbA8xmwpY4UWSLoQH0hodwyXTo6TMFec1hRry1u8P7TST3xPUs5S34R1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512545; c=relaxed/simple;
	bh=cFqzHupKz9oBsqBIOFJNq/HEsP6mtk17AZTZIynVliM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BExtTzvkvPx8lCGhBXVExYdKtPyqgImGDqVTCzbm9akYE6Mh+ZVZjIehsKITcPy+9BGRVqx+YpynJeMcRVs1EC/CXJrq4ZUN0nfhHIjlCVEc+7gpFR3Mf5ZQYwyhiOgyqACtY+aAz5o9zPcOKZ7VYaPHjnaDWoiLc0s5jVB7Xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MkvTMiEa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmybDksC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MkvTMiEa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmybDksC"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB8157A0172;
	Mon, 15 Jun 2026 04:35:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 15 Jun 2026 04:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781512540; x=1781598940; bh=+Bl8j0K7AJ
	rIyLz7b8kAP5ezPawqdi22JDsyWel0Ef4=; b=MkvTMiEaPj2pekM+mE9D2UjXwH
	XkaHTzhcsxFHO4UQuguuvXqgjqO0fG1qbOIreUYthyVHeaLLW/5g1c1wy7dFsrpj
	AvKZG+0wOIZVv/Mge6FOa0DyYkRNGwAUfWP7aBQ5Z+K70QzL4SJZbbbqAqxTr9N+
	XMydADl1OpBx/7+7mfqYkPnL795ksOumUg4NTSf330SB0+B5T0rfNUWPnOPArb0R
	Lqlv0Y/lmmQRpwKfFQ51cJ4MOpL7d5kuZPDxXtGqrEHid/uM+Us5mZ6/W83KQkX9
	D+plzKbf5N03gcRogvPXU8zivax5dTaaqmhpz/GS3Dmp3IZbPDxYdxMt6CyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781512540; x=1781598940; bh=+Bl8j0K7AJrIyLz7b8kAP5ezPawqdi22JDs
	yWel0Ef4=; b=GmybDksCX00NyJYSIxcq2E7Hf8ol8aS5L4iGcCwFum1KHr0MbvK
	72ihDcqfAHMP/KGbjaTRsXcKwdFQBfLk3Y0pzvmQ5KU8l2Tp1QmbZi+EU585u3Kq
	2mmeKEws86EKYg2sA3e4sWDOj+PFmpc55P7o73r3qSyTjfBe3I0CBhmB7Hcbbj+V
	4O9hd6DM2cA6wew4a96z+TlrbuKXrXkzHX6BUKjOyGKGJ+7mkojufPF+OhUweU3+
	9ZiNbkjxfsKqmUCKwThU0PB6nh2X7/zsr+/LUphLive/P3BBlJpM/75IoD+glAY3
	7Ushclv0d1HosxOHcU4MJG7VvKGPp0OB/nA==
X-ME-Sender: <xms:XLkvathpi97GOp-UVGNAbWL1jNaSbGA1XyxOPFLl5hRhZb8NARhX_w>
    <xme:XLkvapDhwkhqHZUVLhzbdirECoDp0wpDt00juEBs2J2qFnpaiFPccmEXefODFYh3-
    KUoR2kzvmpd5xDiVXnsFAcWDsGtql9D2NyrZ545WMQ9ZStklL3v>
X-ME-Received: <xmr:XLkvaiF4S1Bc3Q11v7k3JzPafAvSZq-DP31o4bu1zVNRcFtZ-8JIUewaKsie4UtfZrObNdL5Wg1Join84TIuYaVTpRKEY7vLcZhjzACwQQ>
X-ME-Proxy-Cause: dmFkZTFqRGv5BEiS0BniXxYlelXhPhhcdY0WUQePTpB8XnRm3qvarROREyDeyxzVd2oMaJ
    LrOloOjDmJp059w6ohduOAwwB+IAXjfeIrafXRBUYqw3vBa7YHdkDLUCQ1eHU5lNu+TTJB
    19Dfv6e0xXfBsxLhyFk8XTlqLUf6+mwZDbVW0ZdP3OfJbgGRdHcnYSd2atEJd8D3kLdJDS
    hGe+9fb0gLseJOFV22FMmgz9b8MkuShluRa6ttGixDGXXInfSgF0YuiJ7hcmZrYshkKfkO
    3Ay2NswXAxUPAGz1idyBg2/1qbKrJBBBAbCBK4jVusSC4H72P93ovi45wsqYCqTJVYpTk8
    vVVzj7nuFu76YR/veQtuPzKz8e/sYEzyU1CEdfGWV19eXRM4g/0qFkeDQn8YEoId0rHkNj
    XufQFBWrV6R43C2YMBz+Zz2DLjZMqpcesoBbT0dv401Asc4LlftRtNSmYvoHtNj4zEL8IR
    Rag7RaemoK3b5wIeg+bWzisXmoSZQXvWiO+woPUV4aDBOnhukNSyWW9M64+CKzfhZKsyOR
    H45ITje2kn83ZKXM3YVt0Lu3M6lWANrqU76zL8zZbrx872xLkoX2J9PVue1XXQCXYgmsK9
    EoBqTK1UbTvkEBFNMmLmvkIcm1A7mhFaO8fWz95WAjZOBrD0mft59/p+5dpw
X-ME-Proxy: <xmx:XLkvahLamzPaCWnmqBc_gyrvTg3maM2CVzl9xrBEdYsnAYbvrMdvgA>
    <xmx:XLkvamk7IVFQvicBMznrE6voHAwEL0oO9EbQvelLg-VQtMQfO79sfg>
    <xmx:XLkvapTv6IcWQx2PMvjk_pvwxlKGfrm4F5gd7wJReizQinZt56vIxw>
    <xmx:XLkvaoINyOFlUUBQTtFAbVrgWbPdJxvZ05EANU61NJvft1DLtlccCg>
    <xmx:XLkvan-EgorvOo_E-TgS3wRgrXVtI-zksmEd47Lyde35AL0497dB3lxg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:35:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 11e5dc7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 08:35:37 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:35:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 3/6] hash algorithms: use size_t for section lengths
Message-ID: <ai-5VmawU2MRiAHQ@pks.im>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
 <253d6f8004e710d05b5de1f8279d67d2220f83de.1780593313.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253d6f8004e710d05b5de1f8279d67d2220f83de.1780593313.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 05:15:09PM +0000, Philip Oakley via GitGitGadget wrote:
> diff --git a/object-file.c b/object-file.c
> index 1f5f9daf24..c648cecd80 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -581,7 +581,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
>  	/* Generate the header */
>  	*hdrlen = format_object_header(hdr, *hdrlen, type, len);
>  
> -	/* Sha1.. */
> +	/* Hash (function pointers) computation */
>  	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
>  }
>  

Thanks for updating this comment while at it :)

> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 7867fd1dbf..10382a815e 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -261,7 +261,7 @@ test_expect_success '--stdin outside of repository (uses default hash)' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
>  		'files over 4GB hash literally' '
>  	test-tool genzeros $((5*1024*1024*1024)) >big &&
>  	test_oid large5GB >expect &&

Previously we required `!LONG_IS_64BIT`, because the test would have
succeeded on platforms where it is 64 bit wide. But now that this test
works on all platforms I rather wonder whether we should completely drop
that prerequisite here, as we expect it to pass regardless of whether or
not long is 64 bit now.

Patrick
