Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DE3A9D88
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136429; cv=none; b=ew6Pi3FE3DXST9HTLPS2TPRqJwTxeVC4A48FBgT0VOZsraPQJsui4gnwCeluCDvAUJRcrXETjQOaFZiTjwUVQcaglSVNkKvQ/RdGlgrX2QsHx2z8Bw2mCP1McnnLLoI+nTyJxE05SnyPyA4Vm/2mpWxkvFhN3ViaEElN4YchKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136429; c=relaxed/simple;
	bh=R86jy5jK/chAmNC3FK9lRMarS4HzbjsTy/9P6/sq7WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0ScZIw+3vhOY2w5V29hmA+9J6DqGrbEHygj2K9/J0l9lJ+AMhW6Hog88MH2/Ftz+gsv+LrA1mNFEScCbVtM5DrjnQF4DD4y7OuM3jGbyFtIaQ7azU5sgPyElgN56kp/Z9zdxVCPozEpWsdyE/96B/QrIET47ApUrfitzBCUPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kZqmlCel; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iISJ8THK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kZqmlCel";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iISJ8THK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A88D1400200;
	Mon, 22 Jun 2026 09:53:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 22 Jun 2026 09:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782136427; x=1782222827; bh=Lv35fntyRJ
	RBDrg4VmbSZr2wcDAz/ucKozF5cuQZoLM=; b=kZqmlCelFnEUR4viokfZrBzb1R
	jX3Au+vhez9DbaKJlSFN8F2944UmeoGSWxXeJM3S8mwljws9uMpbslrbJBDd0ufY
	1hiXzQh9i2wOM9POo9D4fnvto1vrn0/JQ/lYHKkvJU+XwQ0tHukuFYmrVpSVwsM0
	2VBRHrt1TPnYr/udvpIy4oBSoV54lEvyeaYUEb/SAgYbA+oGEyesw9Ciy4nyODVh
	XjXnPrc3B+PlELe1YH+6O4kZPnM89nB+CJT5DB84CX2OLdIp4zYvI1kKxRKH4Ccw
	SAqO6WJRc1xTmtp3y7ptmZVNxVCEI05fgmhBU29ZDFEj/IEhdKp40tW+YMGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782136427; x=1782222827; bh=Lv35fntyRJRBDrg4VmbSZr2wcDAz/ucKozF
	5cuQZoLM=; b=iISJ8THK5gDDa+QY3q6b7WhfMgmOu0s7ZWN7AxnfKTX6GXspzC5
	+YcfO522VMbZZKmyGtqvtGbmfqV4bcnZROIT5r3gE4E1k3McP8q3hYo6xaZdYnAv
	i97UWEPwXcfA8cDl0bsOTC65FP/+b5CQ6PbE4P5y6Sa9sIPpVaSovQ1hE7liXXns
	BUcuj5RgKzqQxSbb64bK03ivl+7l1rhcSHM0DaE42+SfVyi97gP+Ce7OK382jLcD
	wSTQPUZu9V0l8ca1vkEO+U28NPyY3XVvWblo33uRu3dK9yDNPzq9v7/trI182gV6
	bR/DQCaDQlNJht+j8gM4CH0f8Qhu6+DMMsw==
X-ME-Sender: <xms:aj45agQSvpPJDiZciaWE2Ev5wmRTVfwX1WuUhNdCKDcpJP7FpmscZw>
    <xme:aj45alM7n3FHHPCBUOFbaJSUOWaUH3D5PCvu7IErr60DgOrMAKf-bcb4hoFvij2f7
    OCT3ahJwQfbw_GUt_P_XqQUNfTn3D9dIAEBAna9gGpeMiTLewM4VQ>
X-ME-Received: <xmr:aj45arPcGk-dKoJjfdJbfJlZGOCXJVfXZoGptaODYkXoBolRBMYDcPsaULN4mq6MonJGndnpCd-CSEeOI50NGCijHbTmDedP8fac9SI_jg>
X-ME-Proxy-Cause: dmFkZTFP9G7rdRNbZW9L/nQfLB8/CQQSJ3r9QGTpBNdXtr+vnVFoiP0HQQ77zN9Q1U8/G5
    1y+EMsZ8tUJ2kAAGBgWnysuE6Llfp55Q9fZDx+3JP+NXf95aMhjH2usWXW84skxsAxjdPJ
    tOJI5n/5JTr6Iy8LxIShuom85vAfPmqwpYsth2iDyz14gQ2XYjKeVM9HdiEQXDxl/Ly4Xt
    FohK1Kt8osB504VDnavu9kd+LSpRBwLVqJq+Vc+osQZv0yrTQwtEljvIE/jc0pjOpUOOtF
    Pd5Yt5KlWy5H3LD/AIoBd+wzxXLaebqof0bUNnHxGh8cJl2RLroO1vEMJn1AzletxPn4Jf
    KthfHQdP50fWMM3bWTqqn1a0BuzvltGauhpGNDkYeca4vZ9mKek4DqduwTYNjLylaPOXvr
    ti7M8J//eR5tz23XRFF70b9GT5AhFxWePBx1tCZEs5jrNYqZ5a2w7zaf874eLPtUD5Y8D5
    7BlaRqqc5dJyigygjgy1IqYCD6nTkkICjRoNrbu61xe81p8ZUhZZp89Z5xEupJ3/EPMhH2
    j84cwnoOWyzzmjYKH6rNPx0GAp7rryHM8F/gRvCIhbHfK0itdfeiapP8Ah9CtmlGUnwIgk
    PMB0Pj+nV++a/3OyXIkUYRuSk461E/PfgkOxRq++8KsejTQG57Oe1NFYa/cw
X-ME-Proxy: <xmx:az45attNh2gsZ9frOZ1Q6ZyWmJn7SCIcwnNS8WM7w62JLtBIXdgi-g>
    <xmx:az45atVj1Ct4wjdtX5nEV0CaW-rHJGfamOzJ3MFSJjxIkLdt5venQw>
    <xmx:az45attgDUQkLXR8OU39vI6rFnCwjUE_9AFQOdQwHJmCG9PyTaqYdg>
    <xmx:az45ahUJbqCwaY3logBHDUbyQHMXVQyP52k0nvMvph_Id4EGOHNqpA>
    <xmx:az45alMrtretUlG9uBh9G2LP5jqf9w1YE-w2QeACHHhSzSGZA--miAps>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 09:53:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7ec1915 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 13:53:45 +0000 (UTC)
Date: Mon, 22 Jun 2026 15:53:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/3] replay: add helper to put entry into
 mapped_commits
Message-ID: <ajk-Zok5pAClw7N3@pks.im>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
 <20260622-toon-git-replay-drop-merges-v4-2-ff257f534319@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-toon-git-replay-drop-merges-v4-2-ff257f534319@iotcl.com>

On Mon, Jun 22, 2026 at 02:41:56PM +0200, Toon Claes wrote:
> diff --git a/replay.c b/replay.c
> index 1f8e5b083b..7921d7dba3 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -256,6 +256,21 @@ static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
>  	return kh_value(replayed_commits, pos);
>  }
>  
> +static void put_mapped_commit(kh_oid_map_t *replayed_commits,
> +			      struct commit *commit,
> +			      struct commit *new_commit)
> +{
> +	khint_t pos;
> +	int ret;
> +
> +	pos = kh_put_oid_map(replayed_commits, commit->object.oid, &ret);
> +	if (ret == 0)
> +		BUG("Duplicate rewritten commit: %s\n",
> +		    oid_to_hex(&commit->object.oid));
> +
> +	kh_value(replayed_commits, pos) = new_commit;
> +}

The khash map interfaces are quite awkward to use, so having a small
wrapper feels sensible to me. It is one of those interfaces that really
make you wish for generics in C.

Patrick
