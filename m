Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24C4302E7
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830602; cv=none; b=ZQ/PF2h21TQz1/n6YoQVw8y72hyjXom+BFGnaqT1Jrg68KoStfD8WEjE8zt/UbdQLHTbvymwR5i0aUqwmSUoelO+MedbzsivxTV7CIADIAI+oNJAb3EjBYrAFdvKoWM7YzHGrxVYvwNL+tVqn8K1P/tkDxlHs2ERbdlENCCT+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830602; c=relaxed/simple;
	bh=hSz6cIphwcpD8D6I41s5T4/l6htjxzW2kHTsdEtduqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA+gnvGElncANYmQazJ8gye1jxcKy4a6uHLxXZTkxHuaUKaj0McWhLn541UMRHFc4cjFTSJvDr3zqCj0Sd8We+PLlMoxNpN7Zc5pSH0y3/wBSUdCfXISxf2jxBHMlQSth/R0TEFgG9aTsGmjHWHXq4+u38bHJhPtRoJVi2PwoK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JnwgeqX4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xpy20xzs; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JnwgeqX4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xpy20xzs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD9457A013B;
	Tue,  4 Aug 2026 04:03:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 04:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785830600; x=1785917000; bh=gxKJEej5U6
	mp/jzjDjUKfLzrcEJ3pRTx57lLvBCM1Uw=; b=JnwgeqX4hjB6srdcyjj2HbQdma
	4RWSDMOko2yMc9dRrUSFlJlD9dSiAQ9NBlGJjGFt/ufXYK6kDywkviEB5LbUSRtl
	WjMMKJRxD4Qo0EdJAoDIYBQ0rxmGBG5+ijajU34Y24HuthsJYEZt3wjCFbCV6579
	2KBkWYvr/MwwyrYq3hzz07B22cG2k+dAXCRx7KUVmukVPqIHgS2oLYdkUll+/SE2
	RiM8OhLr/mFTRaCrbz5UXpauPtCfxILcFEOAxiydHADh+20cdj/DQh4+t/Mj+YSQ
	cIxShXuDdkE99u7mGMgSSX8qH9rSjopNxMmRIaI46uJAzpK5dj1lvZtjRu4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785830600; x=1785917000; bh=gxKJEej5U6mp/jzjDjUKfLzrcEJ3pRTx57l
	LvBCM1Uw=; b=Xpy20xzsEB3y3JA1caWNRxUHbgydJywApxIvL3BwrDr0cXkddz+
	u6ualpp/6TwDleiLx49qdRZppb7mfXYxVEU2+OREeOuSQwLL2JB5HiIGJ+WIwdIz
	trxpQ4v24bF+MXN+68InmG34AlV+ZXDqsxqhn9Vardam8hCas5cIemyzjCrE+VHu
	VBi4rnANYM/IXSEnh6OqdYVebWqKWmvv8Rr2PowyBQ3OkXplytM4gmfuxTAu/MlF
	uIdiOvwu93mTe8/2WifjHX0mMviJPJp3J5Ac4cXtJtXxQ1PdnTGBkpeR96MBtWen
	H9ebOyqbcdZgNLRyy+K4PZ7atrt/oOB24JQ==
X-ME-Sender: <xms:yJxxajmC44HXQSBDygjsHCtwXYilBEDRnvsIRgUwL6GpNABpC-_iwg>
    <xme:yJxxauSfO-Gah-0oqLtMDTbTSaC1NbLx89F-cJauplc1rfQKdDHIQSzNOxjIkvTKu
    IaqREmAvB4nhksffy9tJonVHQkWWUc1j1CtvvKvrOZPrlWbXGH6Eg>
X-ME-Received: <xmr:yJxxanD0t8rK02QjooTLVHY_eh4l-AmQfKPj6ettRJDZtgEYt0VlsdC9IGwcI79cdwPW-EOKWocexcQGngtUwGpuqK6IltmVT3lA6wFE>
X-ME-Proxy-Cause: dmFkZTEMyfMZ4MCBMDknvoQhuOGJ4XBygHLgPxELZswOLLDf8DV4OfWay52zKITWOjzV+9
    5xHdT5BCBCLjL4u3C0L4A3/dDHHjGTU24pDc0o/1ZoaV2q4XoCds+X32ISwchX9VqjRJv/
    eWYZtWrGAHIZ49/5F1vhoVLsApMeNStf5WXllhwdLV1aCE1W4ieHSX3WmSBJaj3TCfjWbY
    9DicACDEsBxFhq+OyI+qDoL3x5CE1l4MVKto6CQ6+kfu9uYmmBITE3U+OZEzqWFaNrzdS5
    dUtw+/vv7eUzZtmV6bFXukSAega982KuVY2jjF53294cHFhuWMOa/mszx6PYPR+N2KRPQT
    qllzgPBiMEjhrSDyB+dqIYja16NsRkXgpsSfyzdwqXhEkh+IQGLIJE570FI4DxSo8ibmMO
    ky4cPiiOGC6bMsnS8kLmrfn/UCoNV2AyXUmbZ1Wrv4Si84nI/ZsOKVRQPjMprHwrxnUyo1
    N4MD0eFowDaMWxsWceaAxU8R7I7O6fIpgNvAQA/U8nWmtiKx5I0i+k5OggBpGDVcQejeVO
    IsBt3JzrGSXANdfqNDiEAvLS8tOUxvVl4ektbIZ8jzqslhBDw9i6Fg0pjrhH7bRk9nHAgf
    OB3I4rMK7GfsU5dzndrEPAQKtYDkk58ZyMeBK9V180QZf4lLXreplDUHO9Dw
X-ME-Proxy: <xmx:yJxxalQ3-vV9DJzalTY2cu3DaguLjODC0GAY3JpzPCLPyuViqIlY2Q>
    <xmx:yJxxalqCEM2rbDxtjukxjR0IE4U0m5Brr0L7QUJjsCwT48QhhrsIfw>
    <xmx:yJxxanzdrWYs_Y0UIifBfCn7nxryS3vZFIAjVVXV7BKc0ehRkqF1Iw>
    <xmx:yJxxaqK_JxGatJrSNzT2xgSmFdMijyQJYuPcc5yikOgR0_OaEZctGQ>
    <xmx:yJxxamvWG8zgNd6N5VbXuOZLdDUNl4UC7UwSSTqKU6FuBNrX1-m7sfRX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:03:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c7aacf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:03:16 +0000 (UTC)
Date: Tue, 4 Aug 2026 10:03:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 1/3] t/lib-httpd: fix apply-one-time-script race under
 concurrent requests
Message-ID: <anGcwAZgbarxi6_k@pks.im>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
 <79b56402c0d5d8b709f41b25ca66aed98ebbb007.1783704657.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b56402c0d5d8b709f41b25ca66aed98ebbb007.1783704657.git.gitgitgadget@gmail.com>

On Fri, Jul 10, 2026 at 05:30:55PM +0000, Michael Montalbo via GitGitGadget wrote:
> diff --git a/t/lib-httpd/apply-one-time-script.sh b/t/lib-httpd/apply-one-time-script.sh
> index b1682944e2..adb9cec528 100644
> --- a/t/lib-httpd/apply-one-time-script.sh
> +++ b/t/lib-httpd/apply-one-time-script.sh
> @@ -6,21 +6,37 @@
>  #
>  # This can be used to simulate the effects of the repository changing in
>  # between HTTP request-response pairs.
> -if test -f one-time-script
> -then
> -	LC_ALL=C
> -	export LC_ALL
> +#
> +# Apache can run this CGI for concurrent requests (for example a partial fetch
> +# that lazily fetches a missing object while the first response is still in
> +# flight), so the helper claims the marker atomically with a rename, and only
> +# once it has decided to modify the response. A request that loses the race
> +# finds the marker already gone and serves its response unchanged; no request
> +# is left emitting an empty body, which the server would report as HTTP 500.
> +# Scratch files are per-request ($$) so concurrent requests do not clobber each
> +# other.
> +#
> +# The script may run more than once: the marker is consumed when the response
> +# actually changes (the rename after "cmp"), not when the script runs, so a
> +# request whose response is not the targeted one runs the script, sees no
> +# change, and leaves the marker for a later request. That is safe because the
> +# scripts are stateless filters over the captured response.
>  
> -	"$GIT_EXEC_PATH/git-http-backend" >out
> -	./one-time-script out >out_modified
> +test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
>  
> -	if cmp -s out out_modified
> -	then
> -		cat out
> -	else
> -		cat out_modified
> -		rm one-time-script
> -	fi
> +LC_ALL=C
> +export LC_ALL
> +
> +out=out.$$
> +modified=out-modified.$$
> +"$GIT_EXEC_PATH/git-http-backend" >"$out"
> +
> +if ./one-time-script "$out" 2>/dev/null >"$modified" &&

Is it intentional that we swallow stderr of this script now? We didn't
before. I assume that this is to swallow the error in case the script
got removed by the concurrent request?

Patrick
