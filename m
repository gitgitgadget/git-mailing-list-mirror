Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB61DF748
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159570; cv=none; b=NxyxdQx4b88mX9n1meabLumx5mknEyuIbp1j5u2hb8Y4XgjdljZEt6yYrTvPZKy8LlDU1bsorrpO3Elb8uiP5ie5+YZtJaXa/BdYbT63AFiNn0oAp/UCx3w9lL7iRZM12x0wXGNBSdTT7P9Shk+VDZL5GqNnVz9OXrtqzpgAYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159570; c=relaxed/simple;
	bh=jory1heJVjSbTxFRYZiZcWuRZSjReBjZjtP6VBc12mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG1InfIlT8jkYTAUmieMoiamvaJtw6+b0XaEzrSqxqKccXRPfovbt9JdDIyiI5expFgEXxfG/7K2Yv5mGn0e6C57peYD/suFumWm4vmHk8k6o87Gtrq2LQ71QFkoF3RM+TKZp9l7ebKDAHNx9pBnE23H1TY9qoo8g9nSDqsFr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=akBBcFh3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iC6QuvGy; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="akBBcFh3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iC6QuvGy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E9ED97A015C;
	Mon, 31 Aug 2026 02:59:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 02:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788159564; x=1788245964; bh=jYpVyOZE2e
	8K0JbdwAaaUgPeSQ/f4do9HJD2K+CfAW0=; b=akBBcFh31KWzvwnZB2B4wHA0YX
	2ykqdnxpdvUUSbP+FR8cpV+sUjckgU2p/l1M09Y72zOQ4DmWw1+w03HnXPRr6Tc1
	ea/qEoO+72hbBS5s1jF+O6xNGRcQ+v8qviEFmri/BJw+gqPXxgbeoECeRduBGeEc
	yrwCA7O3WcLUn63pq5KGjh2M2eLA5LGTFw6CUAvWaAzDLo3PYwyp9MjSv8Iz+7Z5
	AiAXaVc4E5ZxqgB/afMICHxp3SFalgHqceQvpZJoH7DJli5IOCM8pKXWbPoY0+BE
	lngr55GiVFFNrAcAQkt3XnAe78ghzot7wLqxZ2IhGS0LhpYNO9RtCAV1HfOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788159564; x=1788245964; bh=jYpVyOZE2e8K0JbdwAaaUgPeSQ/f4do9HJD
	2K+CfAW0=; b=iC6QuvGy23DfE+AIJr2NQwVBWNhsD5mWSJrefOvBAZ0yv8WVXqJ
	04vW4frToxd5dbiy/pZA8hjBnyMfSPrbUz9sH4l9a6EXb3UwGq/Y9Ugk/iAPCqk6
	V6jsRE+5rPYTysf1HtsQqFteI3N9BYo5NarYfvAJNL6fbEpWVcek601MKGd/s/ki
	WBVYDLJBXJuPMNwBvL6c2O7HwgyKADTD35ByNwmVV/WoXBzInV81NBtbe19alnZd
	r1mI/Jin25QwqCp3/njXpk3UUgMHdYGrM+EUgHmN2Mf4h+3cS+1lzcBdTH5sKsJU
	Cz6iO1xul5ggI7mEoPZ8uH2C7E0aqUuUDug==
X-ME-Sender: <xms:TCaVapN8YvxX332ekpymKSTHK4AJS9PzlJpPlTyXkFUq2JsG2NIRwg>
    <xme:TCaVah-88htmr_ikWX4mU6ifHOVNRR2YE2ct2M6G2pHFzTWlA07WtF1ZL-gb-6lS2
    AQwSUj7L4devenVl_4O60Ed5tJPe6AaebNXidft3F3zlzypfjGzGA>
X-ME-Received: <xmr:TCaVal7pOn6w9UsbXIivKG_9RxvkUPOJaDPcbnQaLn9J2iVPzmE08ym6khLiIvBvpwFv7A>
X-ME-Proxy-Cause: dmFkZTGlC/PgquiDlkZkk172sqX3M/1K+yhtSmZBCTQ9BBm33yGFK/ubBFAHip4wiOWEfT
    UJE48ynNSVZVBtm4ha/qbGE4ZUxD+Ru/bMmGDDBdQpKCdze3BPvVIsPuhI/zngJIGx2Snu
    7wn679njVruY/AMfS0MfAwPcl8xy1E5RoI6FlrNQOMqutO9S1UteUcjnXwTexdSd+ariM+
    fZx7Rdy6HrUZqt6e7fJSxN/S8QLrIdUsz9HCYfAUfbq5jJshTi6KcVGhj59LeiuzbJdbro
    ng+nGryzU/2xfd/1fCwt1Mq45DbM8f6PSZo/XQII+6jJCGSGTXmv+AqkagWfy9aaf5s2Uy
    cfip4smdZD2bph0sSF7bOWqz/+sEhGhnLwelhWAIhVOzJiJq5Q7QGlVgJjCupTZ7Zq+L0o
    UGKE3rAuc/EJtG0rdlSPbynzzAEUJzRc4pMKOgYuUH526mWXgVK2XprGDkuvUy3ttz8VN6
    EHLkVRxHnv2K8HEIv35VqNu1Lj26+IPdQZEf7JKdenKSFulW7mAaeIEThHcBLPQvvbsMoJ
    gVusrinpMEjCl4PXqlGu26uuvpSDaAeE0WBgJY62Uz2p3+HlmG4643oZwt9ZkcVl207OeJ
    ZNr3t2EL/tdteZWfGjxxqi6OH3a7ihrafNFAKMbSbfGuLMuFw6JHcFlK0SLA
X-ME-Proxy: <xmx:TCaVag0aQntNm4mM6_v9lj68JXrbOX5wpgZswXpnRY9Rl1-kFfBoTQ>
    <xmx:TCaVakBDTxIhEUSp7KTpcpbHt0vz_T-fYRG0rur1OwMi1ztmF2rRGA>
    <xmx:TCaVaq0Nwx5cYpwXcX7q_Ivt_TPM95NsBxaVCLuKvj6POB3VT4R_cg>
    <xmx:TCaVamvzZtSe8WL6YaiUThvcgn0h5krRjG6Ayi0EZfSjQ8n8gHfvWA>
    <xmx:TCaVauOyYUeSWRW8UyMIfD-X6MA119e6ltFUFnmGw0IN1zW1ecGq5NiC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:59:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 169b9eb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:59:29 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:59:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] versioncmp: fix typo in versioncmp.c,
 t/t0022-crlf-rename.sh
Message-ID: <apUmRknf8gnd-Izp@pks.im>
References: <20260828-typo-fix-v1-1-24e80a87ed53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-typo-fix-v1-1-24e80a87ed53@gmail.com>

On Fri, Aug 28, 2026 at 02:38:01PM +0530, Hardik Kumar wrote:
> The patch fixes two typos in two places.
> versoncmp.c:            "fractionnal" -> "fractional"

s/versoncmp/versioncmp/

> t/t0022-crlf-rename.sh: "similiarity" -> "similarity"

The patch subject only mentions "versioncmp", so it's quite surprising
to see a change to t0022, as well. Maybe you should just split it up
into two patches, even though that feels somewhat heavyweight.

> NFC only updating a comment and a test_description

I have no idea what this means.

> diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
> index 9bd863a970..328c6e5903 100755
> --- a/t/t0022-crlf-rename.sh
> +++ b/t/t0022-crlf-rename.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='ignore CR in CRLF sequence while computing similiarity'
> +test_description='ignore CR in CRLF sequence while computing similarity'
>  
>  . ./test-lib.sh
>  
> diff --git a/versioncmp.c b/versioncmp.c
> index 3a81b17bc1..f1e451755a 100644
> --- a/versioncmp.c
> +++ b/versioncmp.c
> @@ -15,7 +15,7 @@
>  
>  /*
>   * states: S_N: normal, S_I: comparing integral part, S_F: comparing
> - * fractionnal parts, S_Z: idem but with leading Zeroes only
> + * fractional parts, S_Z: idem but with leading Zeroes only
>   */
>  #define  S_N    0x0
>  #define  S_I    0x3

The typo-fixes look obviously good.

Thanks!

Patrick
