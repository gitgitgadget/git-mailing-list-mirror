Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7933386C08
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259249; cv=none; b=KZFp9iTzGIp7q/kk8zDdcPcGXe4SnLDt/DaeSitqr/JC5B8f39RI8FnliCcSnMlpvT0GjOHCK0IbIw+5H5qmWW3fHqaCg98MucRXlHHXfvKiM5GIHg7PWsJa3ir0IQGJhKXoJJo2r09LQlQv453umHtNB50M7HbILw0t/CrZ1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259249; c=relaxed/simple;
	bh=Cp72cPr/klkFnJ7Dy2rkFgS+zd2TimFM7wRRuvEId0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFeyZOjfI4GRlPP3A+7QIeFiAm9/1V5nB4ImjADSm1roDCmTJmGbpCSwWhHx/n+OkNNvIdBCq+FkBofECIsopDuNHJTmk86pTIOsqSqJ/t2Brs3DZpFiZF9uZprRWMobPLy9uc7/VGf8j8S1eCqiq8euQ9Mu6agD9TohMc0ya2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ppWfwX6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5o4AkE0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ppWfwX6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5o4AkE0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 177B47A0123;
	Thu, 24 Sep 2026 10:14:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 10:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790259246; x=1790345646; bh=GQRfLRTX7N
	QYy9EpQm38hO4/rRM5TDP3U2I69zY3jGc=; b=ppWfwX6cn/nR9uGYklCs5pLlXn
	t5nMjMUqeYc4NYp1SUl5PGEhGzJzP8a+X2O641pnUox6hdbiGjkycc8+mrwbEq8T
	XFgUQU7c8Q6pVHu8xZVozsgnq6Q8UFBWLIjbWDqgd1eHcRX5RkEcDTznrfdIfK1z
	nijoPqHxw+gV2iX1j0/XKCtakL6NKxfHPBq5y2JE1Ta2G+mLi7BKFfCRWt14ooGD
	cxbwCBbMz+gjIJXdgQ6bJ/K9jgXaHlkjIZ50620+WCejBiQ5Ck1o7A+AZQJKhCQP
	e1yifvZYTsmY90p4GT9u+UBQrNg0FWr76ktH6o2VKhD/nj8uE2HT2tF1JCNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790259246; x=1790345646; bh=GQRfLRTX7NQYy9EpQm38hO4/rRM5TDP3U2I
	69zY3jGc=; b=I5o4AkE0CxSl+6v3h+3wdJABUE7ZJJcfUbzEm07ErQHBNlkJtKX
	BQccuuI2jbSqXltESBMVs8GZ0upaql/GPgU4wKEG4Clxm8b8J3sxkKqadnjLZHYH
	A6SFpybAlo5vlkQBK4WM5tJhUjkLqw/vkRGmS5XUp8oNraTOBxP9OvQmfgR/m726
	6mn9CRUwz+v21ZEABkYiNHZwL5eJa+m65m+TzMj5grEWBIW5ShtdrCT1BQsY8NGf
	/dNX0ERVuJ69kYiZH1KgR568HfKE50kAlq3z2LI2j4SzLPUhd5hjjgoP49Gnpp1e
	WSw1cFZLjwi7ZqlSQrFY6X6u4wI94xwNoOQ==
X-ME-Sender: <xms:LjC1akYNvaAOFXWPhFHt4on_3P3TMKpxjmezOT26y7MPNEfWGkpFHA>
    <xme:LjC1am2Cxezdfxrr_Tl-4Op6JMccGgsOyKTXSBZdWgT9Sm45A6MMMXoI90lv-CUxL
    2WLBobQ26ufWTbXkvfTC8CACB59xrU72aOuDvCZzf5dRpEhte-g1f0>
X-ME-Received: <xmr:LjC1asV-QDqDUc2qsEBQT6hVrz628Wzre-E5vaR_WruIXjszXwtg7eG7TrX8y6zUlnEbEuc>
X-ME-Proxy-Cause: dmFkZTFbNETnJOAaKiQyvjDAwBEffioJwbZYokWe3+GPGfYQ6ii4YK61vtCI8M/rfzB/tz
    OcDlwDIDQLL8nxeXv7pB8qLiV9kmGCaJq6ezF6euAAnQqzhVVVNu3urdppF7VSQVzX7QRb
    CCHkqEwCsFXENiITu5pmp8bgaK9puwwgDvt35IyRvuXg9UcIuF/jwyE9JJF64dCEv4t6Bp
    L4svZ7BIs+VfBpy7xROgk2u4ARURCzH0dF2anAOydkxMe8tRNJBROVjV5mHg5xr8EHCEMm
    3WiXMrOoo34V9RvZqhtIfxNFW2VZq+R2F1xX5WfRkHznOk1U2K5J99b1rVULvTXOnoK4nm
    3FTpMg6CqLzZk1h3iLZdAmVXNMnON16ghjoJ0V/c+kowd0H4Xl0/XlIKUWnBNScDf2fm7u
    FOWOBwnRMO2+YG8qR+k/4HLzZF69mJnIVaL9J7Yuhv4h+KayIrdFt2WwVX7f+Pb2sRqI/Z
    NktACWw1yw3pAIAGSlAhlROLnqpydrpijspIp41qeZeeVFDt9KnPFeQnsShkyzGeyQUkAw
    7gjOjTMn8PEzbUCzjd84/j6HHd6Gm6j5uD8BXn2cJqSZ/BU/TRKjuiKLXYp1XATI5adrdr
    8g4zkMuQmv7xefG807KNs4KWwk7tedBgTM0mmNhhYj6+mCcBR8k665olhOIg
X-ME-Proxy: <xmx:LjC1aoV7wVsS7SV9hMGEfl9jBiJfP-OI7B3sTzl4QTvsaEC78DQamw>
    <xmx:LjC1ajeRWIVK-FhnB6AP7IH7Dx-9SCmVRIS0Vz3BEMWN_qXiJ3GaRw>
    <xmx:LjC1apW_cvRSLHEVapOig3vTGZnPc1PaL_t91Kqw3PhC8jGJrDnYjg>
    <xmx:LjC1akd6Km4n0cZNGHf_SV-2f5e98cn1zuzomgQQ-CaSZ0uaK30P3g>
    <xmx:LjC1apWmb9Qebxhlad9Qf0147ZCI9ryvj-6QtGrhFk5ym-R_s4FvBY3C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:14:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f33886fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:14:04 +0000 (UTC)
Date: Thu, 24 Sep 2026 16:14:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] ci: fix unit tests not running on windows
Message-ID: <arUwKpju14AVHOIy@pks.im>
References: <20260924-785-unit-tests-don-t-run-on-windows-v1-1-223cd2e4df43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-785-unit-tests-don-t-run-on-windows-v1-1-223cd2e4df43@gmail.com>

On Thu, Sep 24, 2026 at 03:09:18PM +0200, Karthik Nayak wrote:
> Since 3141df7ec4 (ci: don't skip smallest test slice in GitLab,
> 2026-02-19) both our CI workflows at GitLab and GitHub use one-indexed
> slices to run windows tests. Modify the check for running unit tests on
> Windows to also be one-indexed as otherwise, the unit tests are never
> run.

Oh, that's something that I missed indeed. At least we've still been
running unit tests via Meson :)

> diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
> index ff948e397f..d0063efc42 100755
> --- a/ci/run-test-slice.sh
> +++ b/ci/run-test-slice.sh
> @@ -10,8 +10,8 @@ TESTS=$(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh)
>  group "Run tests" make --quiet -C t T="$(echo "$TESTS" | tr '\n' ' ')" ||
>  handle_failed_tests
>  
> -# We only have one unit test at the moment, so run it in the first slice
> -if [ "$1" == "0" ] ; then
> +# We only have one unit test at the moment, so run it in the first slice.
> +if [ "$1" == "1" ] ; then
>  	group "Run unit tests" make --quiet -C t unit-tests-test-tool
>  fi

The diff looks good to me, thanks!

Patrick
