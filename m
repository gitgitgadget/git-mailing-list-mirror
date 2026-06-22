Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A3371867
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121687; cv=none; b=BMeDKcoHxhX1Swmu3S6DeVlB/7ApP/IVhfsptXgUBH0ZFXhPcH4MqIvsIcuVY/k1U8K3M9c1pOjchpa6OXfoQS7mylS7LBGY6dtQMy7ESsvYLVK9iQ3LKW523Yx+1ATLg6978FtPtzvaMr3qZ6aNR7lyKOz/m7cXVsTb9StqvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121687; c=relaxed/simple;
	bh=rd7K3aZ8Cwq2GJVG0pIE8uDcbYI3qDpeyMfATN/zzqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4+/afzB70QJG2yvKpjUFers3mGtcMaF9xTjsKYqoMmgjKxiCFGhvRQriifITIX8xUiKJB4wgvDZ2PjZUUlMR1rIq11q7stE/0huKpZfVJl3FUKIDoxFRprY7adWv/yhxxg/h4TuAlp9/HOksQII7WifeRUoH6o7EXIcUOfO4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sEi2hYoL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+mzfnC5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sEi2hYoL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+mzfnC5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62A8D7A0176;
	Mon, 22 Jun 2026 05:48:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 22 Jun 2026 05:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782121685; x=1782208085; bh=bB0d/r4KMk
	L/tJQIO2P/1feSo1c3iQWKX5SAsV3npng=; b=sEi2hYoLaQTR50rahBBNQ6vE89
	RhAkjQqvzYEZtNWNgzzelnAu9r7iL/RJildPkznbD8LCiTd8W/6BdIP5+edBcADm
	dqtWT8lUe8HBelthZH53nc/Snk9epDhit5k1U3Ue0hBrXqXd5NMMNDCSHLLpUFwa
	ZWc1GzMrCUguUtIid81LsGzHFpvVOSZ9A6PKgTutQJuQDy92yTWjTGlWfoUTqGZC
	q8F2M4f1AUhW7h3gIYZeFElk2DgoMupGnE4qZW14uxInslBooC26l20Xv+2Sbx3p
	WIbikh3xEegMJFcB7GvNwRucK7VzhRkNiOVq6Tuczoxo6DIuw5TZDxDYMVJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782121685; x=1782208085; bh=bB0d/r4KMkL/tJQIO2P/1feSo1c3iQWKX5S
	AsV3npng=; b=T+mzfnC5DpGp+7+UeOCOzkTQ2l3gXfSNfyQa0AOKDtFOsEUc7Ny
	7Dcw7dkajJEBe7N1S43DdxIcRFd0uygxJ6uDHnjNMEzMFsel2cZicwE7whGp1WCm
	u188Uf20fn6G+ahFMlAWbInSk15rQllwQ2jnT6+SaRs5kU8BmjV8WzxUarWyuSlo
	isLNqDyTVQJ9qXAuYn5D7F2o9+hchEzzTIDHK6PS7r4Pbashp/qF0WjsyKlP07mV
	NRiXGl3qoAODJ6xfBJ18ckXYUnYanQULD/Bo7+GWpxzj8FT1cAQDw/YD+g6K5vI/
	r+XML7P56grMPEtfMdW+0/edBabeyPaAVug==
X-ME-Sender: <xms:1QQ5atIsoU8_zv2hGB4dgA_wQ-Ogz7F4HtiFfJteQFq8B6Dj3VMbsw>
    <xme:1QQ5agKCq4bKt1YibE44qT830H_fNng6pt4lCPZaaiEkmzU8M8HgRMvbq1QhVGGyK
    lHPLBvGdJyrYlYYOSRKJNN1ucsbF3fsNtRDdn6vfdWKgpIQpoV8EdM>
X-ME-Received: <xmr:1QQ5aqs0lnHDkMuy49R_5tAfyv_GGADQ1hVjkDkm7y5f3DZr1lAwYyUirELvA2bvNWhWLnIpt3CwF__IOs2V1K0rV5FLjV2dfMbWJYWhWA>
X-ME-Proxy-Cause: dmFkZTE6yzp+mZU/m8eTlk9I1NiBPO8fUEtUEtu31MvhebUfzXXgNr9ai++xb1dCjQ182z
    9WPYnnS3flMJPpXV1rtyfDcAij40HkHVFhiYZTmN098cFJJbkQmUerdsIlzbJo3iccDNsZ
    K5RaEdetA8RESFAdW/NJPzus6OvVSIkY2mvCdLEQIjZ8IYjarsce78SIR1AWc66lOngRed
    +V/NOt7JGqjqPUrOKi9aHlutR95xRhpdZgHxjTxkT+gwSIrM7RsfO8oWXpLL1xl/wxd3yC
    5yQfn+ZcVLfSvusyHBP0rKlqBHVaH4wtgyCgXZsX5+YMR6WovBXDMx7oAdQsMeE7Vl6SSG
    2t8Dic5j+q5c1uOmdCHlcq9pBOK3ZFmGAhD/vNBdQ/4t0jyNY4u600H0QfoapCZ1aseu5w
    TuqjxgOuSzWiIpzsVoprc3Ahw9zKg7De7jyOyfGDQNz6U+8Wa9ddhOfyQtkvynluc1+lxm
    bd8cAbFIfFm4+5G5BuUIstv8ubw/zyAYdRoV5vW+dzETY6huYlkp1u0A0jxb8vRRvW+k/h
    zoeda1eM4altqdlFuD+zxn6ZWpbNeI6M2K54nUgvLCnbnqGt4CZgPVPf7qk/66SdyQOoIN
    csHfbO8SKBA1EpXcp2RvoLXRwDFZGmOtBhaktm6ZlKqB/5Sur68a/MsypUlg
X-ME-Proxy: <xmx:1QQ5atQcCgHnoAfmNMqX_yEzcmvFRgPGMQO40ZwbrJlP9XI0qWLb2w>
    <xmx:1QQ5agP05Z95dSiJnLt26IS_4B6xAMsyFbXSH8w0EytQk_hUjHclMQ>
    <xmx:1QQ5aiblfYngsHIxqR2jQ4aJztauyv4LOd-CTzyzk6npv6jIdmjz0Q>
    <xmx:1QQ5aqzIbWHxua5ZdTObfTrYU_mdFysMrbp7zWcQF9eOyAhoz0YIUw>
    <xmx:1QQ5agpC61xYLtrAua8MWNlot6fPm_QPMa-WSgNpWyIpvEUogyHVzdp->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 05:48:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 109d840a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 09:48:01 +0000 (UTC)
Date: Mon, 22 Jun 2026 11:47:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <ajkEzhdqzmAePk_P@pks.im>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net>
 <aji9MOE-NTHKXYqn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aji9MOE-NTHKXYqn@pks.im>

On Mon, Jun 22, 2026 at 06:42:24AM +0200, Patrick Steinhardt wrote:
> On Sun, Jun 21, 2026 at 05:34:07PM -0400, Jeff King wrote:
> > On Sat, Jun 20, 2026 at 08:33:13AM -0700, Michael Montalbo wrote:
[snip]
> > > When it is wedged the whole chain sits at 0% CPU. upload-pack is
> > > blocked in write() on the ls-refs advertisement, curl blocked in
> > > select(). So it looks like an HTTP/2 flow-control stall on the
> > > response side. The same stall resets itself after ~60-85s on my Linux
> > > box and on a bare-metal Mac, but not on the GitHub runner; I haven't
> > > pinned down why yet.
> > 
> > We had some HTTP/2 stalls/deadlocks in the past, and they were dependent
> > on libcurl and apache (actually h2_mod) versions. IIRC some of the
> > non-TLS code paths for HTTP/2 were not well tested, which led to
> > 8f2146dbf1 (t5559: make SSL/TLS the default, 2023-02-23). Of course
> > after that commit those cleartext code paths should not be a problem, so
> > that is probably not exactly the issue now.
> > 
> > But it might be worth checking the versions you're running locally
> > versus what's in the GitHub runner.
> 
> I didn't observe any similar hangs in GitLab's CI systems, so I wonder
> whether this is because of different versions of curl. And indeed we use
> different versions:
> 
>   - On GitHub we use 8.6.0.
> 
>   - On GitLab we use 8.7.1.
> 
> Now this of course doesn't mean that updating the curl version is the
> fix to this whole issue, as there's a ton of other factors that could
> play a role in whether or not the test hangs. So while we could just
> upgrade parts of the stack and cross our fingers, but that feels rather
> unsatisfactory. Still, one place to start could be to update our build
> images to macOS 15.
> 
> But the big question to me is whether the hang is because of a bug in
> Git with how we drive curl, a bug in curl itself, or a bug in Apache.

I noticed that a osx-clang job failed today in t5551 [1]. This time it
didn't hang, but produced an actual error:

    2026-06-22T09:25:45.1984230Z ++ git -C too-many-refs fetch -q --tags
    2026-06-22T09:25:45.1984420Z error: RPC failed; curl 18 transfer closed with outstanding read data remaining
    2026-06-22T09:25:45.1984520Z fatal: expected flush after ref listing
    2026-06-22T09:25:45.1984610Z error: last command exited with $?=128
    2026-06-22T09:25:45.1984660Z ++ rm -f tags
    2026-06-22T09:25:45.1984710Z ++ :
    2026-06-22T09:25:45.1984830Z not ok 35 - http can handle enormous ref negotiation

There was a second test failing similarly.

Patrick

[1]: https://github.com/git/git/actions/runs/27940620478/job/82672854726
