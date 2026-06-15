Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998043AB480
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512558; cv=none; b=IiFd6xC3hxn3Sj/V5rVWahCqFtiq5pDIu0uZmFNsws5kg4qMNq847csuie2eWHZzjELhIsQekDkXJJSCzhVZmKYrk0OLXAlGkIWASsnjVgJxR6F5U9iP+UsMGVNtPDW1UJZR2qNetsvrNj+AP7X564sc1+y9yrhkYNxh725rH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512558; c=relaxed/simple;
	bh=tDa7cKoArQ418/lIEavkkx1IwvDA8B/fEADLjfnl2cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWgDmHu8SYgOVnPqChgugcuOTKIYgkI6BLqmEr6MJBilovzsnJaHBUjORLZ+LJUitCW8dyCLhBmQ8p65+f5vgfkwjGXgVJOnxzF8TsOk6BXqEMBNwoSzGE9tc5M+cwvlQMeIbmwAC85PUztbFVD+zNU/Uv5h0dOOJXu3EY++V1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aocvCe65; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fDSEzBzg; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aocvCe65";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fDSEzBzg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A7FF81D00155;
	Mon, 15 Jun 2026 04:35:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 15 Jun 2026 04:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781512554; x=1781598954; bh=q0tUsNn0tT
	cSr/B/ZTxYpAvvQLdkJYW81CtW6ix/CBs=; b=aocvCe65B6BDjB5cjthaCJDiFM
	O0HHpxQpSkti4M/t7jRDCdMhEFjmEISOAiUvbaSpcnm/F0QHpjg6k2BV/7wwx+5V
	aF4NIvqR1a63BSHLJe7CZHSHxl4PevnPNhs5xKKQrpovhdTsPQJBB8U/KkEH5xyW
	Y0NnQFi2a0OSNT80P9SQOGCosIfg0TFJ+WN0e+p7G3Xdl8d8Y9fNf23ShK/cUYav
	wTwBoVU8sNjAb+AzM4KQuqVEdQcAJKv2YuUUs+IPSm69U3IWQyVX/jbgDh0qHYS+
	VD/GSWy2InRW7jH8nlpHrAGH3cyTOZKbOouGqz2JcRrD4JB9S3/718t/FedQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781512554; x=1781598954; bh=q0tUsNn0tTcSr/B/ZTxYpAvvQLdkJYW81Ct
	W6ix/CBs=; b=fDSEzBzg2/S237u01oUE91Mpae0b4iZaTqr+oAgt9SSkIapz/WB
	1FTA5fskr67qv7shCx76tJbGXBDGaeeGZKm8nmpHBpSA+/EEatRjJz81aS9YP8ml
	dQEucScQxuwf4sAkyHOHQ6Os4Kw4yeJQGzWvs5v/wE7B0hSQAPah/jfZevpM0oel
	yOWKGCYFPeoP4lNjNghiqhqcZ6WDJ4vppqaex6lUmT5nM4VCBTVIiRaTo1uQefsl
	1tgRM2aXipHqHzJhax2eULU46QdH5p5DSmhVxmSFR6l32+s23O/G61lC8dGII3Pm
	4IL56c/Q+EvN74EE1SJn8adDDiN3+LDN5Tg==
X-ME-Sender: <xms:arkvanpU49zgD88xl96LwqIS_IepOz3MttZ865HIi_ixT_e5vjwp9g>
    <xme:arkvaopUV1rxhipJhDtgKChFmNFwSKuSW5p028OQKdLNykthw4c1jH5dk67PJxlQM
    cXdObf2_Q9lXu8rU4aIPH_elVp-C3Fw62qgw2YGG3_u95oZ7ur73Q>
X-ME-Received: <xmr:arkvapMIRfYbwPLhwVBgXycJTqZ-KGt9tU5bxEqnZ9E1t0LTUyAUZH7aOnuq1QJ2xHgb69H_rrBjV_pBlTI0LTHtsuIp89RYtnpolZjdbg>
X-ME-Proxy-Cause: dmFkZTFN5nD/+HSh8Hg3xOEViIy/p51nqjEzvKnHdKlmB3+YTl1iI+TDDIXin8ChN+Uhys
    UsI1NGj3cdvSZTIkEBWG6kfmibyS2ssCFXXQirfnIr9wHX5Q+J9cZfIq05U14tBvxuYdO5
    xKXDUGkdcT0RMlxSQXzaJ7KiCmnh5XA91on/x/y+lopHQ3TsYEosiC3OPGnFhiBENHNJAG
    53o3BDagitLt+wfQLol+mRyUrFxw9LXduOJa+2DNWfb7BOz4uF+BzsxsFQcWsy43Sma/Va
    97M7r3U1yIop+CkLr659vJJAj1WAL730CVR23d8bH/OmP61InpRZruDw1SSb57IVxT12Tg
    3WI+UOM6fkjzKG50RJ+8iXoGPB0XSTPPFR04fFZ4LyRdKHlsxB5a+VdNeueMp2Ipm8Iujs
    hZ4+iUcNOxlUHyLNFlIIqMVFXqWhZH7WifAOBbKPqvfinApoLF6JUYKgCe00YfrTNCX/YC
    y8+AtwqERtANfSbkqlPcKyH3miDBYg1EL+EcVqgv3w1PDuiwX7A4WIUng/bdBmZr6ZCtWr
    bWGbstRTq8RMjYwD41JNg7VPsbNuBc0xd6Se4ru/ylRM+DoxEKSTFsU5w5uHGmXf1PwJqm
    uHNbD2QI81uIZx/6/gV6j19g8FKI7qPiNQT3MVeGjljcXWDKW8jxiKbfGaQg
X-ME-Proxy: <xmx:arkvapzGvBsBe5idr_MNfoMiUzii7jvnFYRBWGbEl6nCSdNXuUGLfg>
    <xmx:arkvaivu4XYnj1T89m91EQpcIwZzYz_0IuwtzgacfNljOB1oTmay9w>
    <xmx:arkvai5YZ8LtC32b0g5VlTCBVkR3hQYCVmN5GCA7gtcCdmTlQ2LpWA>
    <xmx:arkvahTzjFXv_IKZKKRjxxqvLZZVFUL6abO0j10OeTA3d_BZK-uOdQ>
    <xmx:arkvaiPV3ma4mjIHq02yLAp4R7cDwQRBPZUfCH5ZJo0KdB_qLV4V-t4B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:35:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4d4b2d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 08:35:52 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:35:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 5/6] hash-object: add another >4GB/LLP64 test case
Message-ID: <ai-5ZvDgc4smGfGc@pks.im>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
 <f48d570bba87f7604158646873b998725a4a9db9.1780593313.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48d570bba87f7604158646873b998725a4a9db9.1780593313.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 05:15:11PM +0000, Philip Oakley via GitGitGadget wrote:
> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 59efee3aff..f2722380ee 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -277,4 +277,12 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
>  	test_cmp expect actual
>  '
>  
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> +		'files over 4GB hash correctly' '
> +	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
> +	test_oid large5GB >expect &&
> +	git hash-object -- big >actual &&
> +	test_cmp expect actual
> +'

Same comment here.

Nit: I feel like we could've easily introduced all of these tests in the
first commit.

Patrick
