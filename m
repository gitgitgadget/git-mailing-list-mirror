Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F941D65C
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586954; cv=none; b=MByK5WC0tLpEhYT9eBxp5svPhvK8AdKaVWCSRn52EE+SA3s7PhU1OwoF8f91AxteUGOMBDASd3z5+PSxNParVfQEVLDUWVjzoMtbgINd2qKJdmBupqdqm4CwTBouHZaKwnsjXIhc8EUCgngHXkgYkfY+Gyof64NEWn7PadOFj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586954; c=relaxed/simple;
	bh=o9n6fzra1oVILVf5k6Pxk5BdhtFYuYm3e0vL4Ea6eBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Py82dlj8//ZlUclu+KeNDnDOXuR3SvN+QJrU+Rzv5NA2I4ZkRyykk9u28XD/vk/UPQRBS0X0fnyQS/LpZRCCqy8LR8w2fFIvere7ETf0VaS9URobpWwOy+kcEYaWr1hgMim+WqRcuYy6yUE8N0WVDsnQKIKegdMsikk9v7UzTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UKSFug1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mUcZ124H; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UKSFug1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mUcZ124H"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6816F7A00B0;
	Wed, 16 Sep 2026 15:29:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 16 Sep 2026 15:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789586946; x=1789673346; bh=M+7PdxgNmT
	ctlxI54dddBxxUm4sJduqriJS4fO+komA=; b=UKSFug1qdGj/6PZzCWdL7Bln8z
	uG3I/haNgnFN2l04n4zUmh0d0d8FQP98EIBogdtfDpr1jbCl3dkNd/iED8sZ70CP
	I7Jp6ecF2T5+qgCdXZtDYlWAfzMez5Pd9lZGdfFa7yDGlKl3nOF8EmxvLlaJDjTm
	8yzLcYvVOaWJ74JelIQ9e/4huNpYjTmE6XOXge0Kcq+QqCZccq/qNWM1oEUh/jHk
	kgUczhDWcHWyvm1hBuv6MxfdUmNws04/RG/TWN36WcpdcGES0UohpHy2kPq943Eq
	r/P/QPaMf7bNTulV8Q904vhFI/jggpp0aO/3BGGjde0C1nE7LNGMdT6EJElQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789586946; x=1789673346; bh=M+7PdxgNmTctlxI54dddBxxUm4sJduqriJS
	4fO+komA=; b=mUcZ124HNGGKp/AWoKlUzbYUUesf5zXZ4yJ5tQbsua3g10tQlxc
	RG5hcuz+lsqV+IoWtuqQ3t+Io02VCWs/jfR+mYGefszrqd+G1NSUm5Q7aD9oWr0A
	m2N3F8PfzTGZZdVlfLPvRHwXgZf6rUF5dIckJcySCf3Qj+OwTKCf9UsWVqHfkqgX
	JwLjGTmP1SWyAdt5PLY15ReRZuSLQv9VOZUIKJMmPUhdlnYTRcdILKXFktAeY8Fj
	+lLv+gHz18XmmFvlPNFS0aE3sshP/xZ+wbO+GufLWZuOaFv20hIzaihlWYLJaM7p
	t1LitelCn05VN6vfngg8flNM3nWM396V93w==
X-ME-Sender: <xms:Au6qajzp7P_JkHh3z1d5PcsF6qCy9oLsuUbPoJDX3qIU3HOR6zQApQ>
    <xme:Au6qau93LNRIb5wtytt_miwbxO_KDzJQ3iizeXuZV-xA-eCp0URAPSBBq_q5-k4aH
    eBbFb3tyHTAr1D7jdXQYicW1lyxMCGvhhx92xjzqD9dLktYOmLFPA>
X-ME-Received: <xmr:Au6qanIlx2Vt339xQBtQR5_IhSnyRBeNR5tFS1AGiYs4NXP1dbH3USIFwwuFB-cJhr3JKFTbvD4_9FhMmf_3iQ4Cmt07ccIy3uar>
X-ME-Proxy-Cause: dmFkZTFfUy3dbCB9c1qVZnkrTxS+eZrqkEKM0HgCGrMv43TR39CY1dqqVvSxIXChY7BfgC
    ouk2JwYdHWhQLgJaoK90CHWQxgBGR4Gkrn6x7C+NxbyJDl6zuGN1L+pKuc3vKT5orlUwXW
    IoJCZ8GGZntkp5mppnX3kuo1cnvWIGRtMi1ec/SSh0YddmKt2g1KYysbuozE7YEriIlAtL
    cgyuSGAllvUjh8gCIV9c2+u6+GmYBpVp5qWXa4M7tJ8YsDff0GUYRjFPK+bebIjFf7eq+X
    1DqJ2/9UM0uuRP21R4cgSmaG37prF1tkUZg3vPP7ah1LmMBCJkw0FWVefbyrVRb5WOEZJm
    Oc/TXfZZugoki4JMvoqqv3kJDjkS+aTsNs++n1FzyauRYfFxDP/k5AKDLJX8XenbT0ASTJ
    G1G+B2aO55t/Od0+wWR+w6q90Zrxuwi7kDhvyysEqp9bFPAZogeDCZNVwJzjgMNrYEMBSJ
    7lJ8MHzZCr/HQM3OFazHj8FNA439yrVxySn6ol8Ys3C17ATv4JUE/fOvjxxcBW0bg3qBCf
    DpemLnxYaRGneN+mjSQry84+kUMZXpiT/CytLdNqTdaLB0GVsOz6K05M5Q1yh1rfgpv4eP
    rmlZvX0evyKsOMwksoxK3+sKnTt5DSv0J/tZD4zlZaRU8LA8nXIPTG5pRSTQ
X-ME-Proxy: <xmx:Au6qakfNdIYqOOLBGvwpOQtynW9DCwTfKpphJu_g66BOve8rV53U7A>
    <xmx:Au6qam8AE2awOMH8eqGqZFlWTmTD3t1i9u34HeGhuSPNwqhKk3V7CA>
    <xmx:Au6qahoI_7-ajV7Rkw_a06cAy77z5B0APeupEcXhq4aHYslGiytwDg>
    <xmx:Au6qarBF3vI1wvcG184EGC3AsBPQ7vFHfLoufdvD3qraCG-0yS3cYA>
    <xmx:Au6qanisdalOX-3D4-xvpiUwTOKtsTHk1zd2LEF8t7xlddUWdukhI58v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 15:29:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  peff@peff.net,  avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <20260915162348.97792-1-ggordon@gitlab.com> (graysongordon-gl's
	message of "Tue, 15 Sep 2026 12:23:48 -0400")
References: <xmqqecfez7ie.fsf@gitster.g>
	<20260915162348.97792-1-ggordon@gitlab.com>
Date: Wed, 16 Sep 2026 12:29:04 -0700
Message-ID: <xmqqv785uha7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

graysongordon-gl <graysongordon1@gmail.com> writes:

> From: Grayson Gordon <graysongordon1@gmail.com>
>
> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
> OCSP "Certificate Status Request" extension and any stapled response a
> server sends is ignored, including responses that explicitly state the
> certificate has been revoked.
>
> Add an http.sslVerifyStatus boolean that maps to
> CURLOPT_SSL_VERIFYSTATUS. http_options() is already the collect_fn for a
> urlmatch config, so the per-URL form works with no changes:
> ---
>
> Junio, Patrick: this is the combined version we discussed. The
> cases that need no OCSP setup stayed in t5551, since t5559 already
> runs that file over https, and everything that needs a responder is
> in the new t5585.
>
> A note on the testing stuff. SSLUseStapling makes apache
> create a mutex in a compiled-in system-wide runtime directory.
> I set DefaultRuntimeDir in the OCSP block to keep that
> mutex in the server root, the other way resolved to a path
> on my box that didn't exist and prevented the server from starting.
>
> Changes since v6:
>   - added t5585 and LIB_HTTPD_OCSP support in lib-httpd, taken
>     from Patrick's patch
>   - moved the SSL_VERIFYSTATUS prereq into lib-httpd.sh so both
>     files share one definition

The updated tests look good; will replace.  Thanks.
