Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305363A382B
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767403; cv=none; b=O4teB7AcJqzk9GOSJhW9zjyQoUBHxfSCycjwQX1jB/GMnF4WMemG0EPjw2b5pCXWAPqeJAB4ipb1F2zwJ2w8GCAt8sbnhf0sEcg6W43igKV7LPc8hprco1VCGnng26bMevZeR33wg2swOJkJJGZZP7hvaY2JHNwB+A+/8PHczI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767403; c=relaxed/simple;
	bh=YYPQyFrrKhccIqaG3hqPFeIMIODe+6o008S4YCqbM+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGknYuH3O0lBaF1sUd8RiBmzBZe+21B6bwcqAbpcBq7Vkjsex1yxvDv2Ltiv/dzwNqdekmEE+zcYuziKmw5wuD/uIR+3Ez54jcBitXQXgcjqjhj7MXpuzeCYK7y1rObsDy1z44+/zgH9zW8zSHlCdOkkxvZhiWIUdwpIVEA6CnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vocm6i5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T90j4XnD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vocm6i5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T90j4XnD"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 185611400202;
	Mon,  7 Sep 2026 03:50:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 07 Sep 2026 03:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788767401; x=1788853801; bh=lBhrHB/uzy
	fKBPXse5wx7zHQWdqIzSsq9oLvVbY9eK0=; b=vocm6i5rSwVKjPDnoJkGYc4FVY
	Ut5cSqsh+J4MeTFyC4ijLPkw/oFTZXB3bG3wKHkJDgqyglyE9p/X1zthzfd0ljXG
	3RJD0wcrf0VPNS8G0cDsAL70+nBFc8p6u1MBtMbkGvsYzoiXeenKIosQSXVv8Hiz
	xPEw6HTXJyLCgEn7gD3z1MG3v2ZjnRN5yQgMZBj166Cfik+2ypB0QG3IEWE+TSCY
	WeRvqpot4euVn9Wz3BEmyMd0jesFRfl9IcYO8Xfj0Stl5TI6RYpVRf3WlfFFvO/D
	N3gZrHhfrhj/ggv++xfihtXxi2mqtlSbPiQZEf1aLRdv44ubFtOfg2krMiVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788767401; x=1788853801; bh=lBhrHB/uzyfKBPXse5wx7zHQWdqIzSsq9oL
	vVbY9eK0=; b=T90j4XnDgHC7h6eOta6nux5s1KQ1TqIb2+Ybkz3+EZGShAIyZ+1
	fiS0tediGHwl9j8My9hTtsSJg97T9fThnUdvfpv5tbvu9S98Thh9iPNCOB2CXtI+
	d4HRTxuFuBCyOQ/hA48dOz/YZlfTht+AxibT5OlP1nuoJQpf/hjlsC67YEuXZMSr
	9/lDTsaKX+aLW70O5a7lCXTwv6HuZtmYv1GSOcRjqBtHMnlSNT24L5gjOfVDfZRL
	PFIfq0Oa472n9GJv7kn4cni7QX/dF3bzUQbpb3GaWVJwrtqJgRJ5IlXzdU9CRJZr
	KOVxuLRT0MJewnopGSwcPgHT5tU499Ir6aA==
X-ME-Sender: <xms:qGyeatlq9XN8xWspZphkBIW92goYnOOXAw-BYvNNI-QuIYtdAA8G-Q>
    <xme:qGyeagRsWz0pQ4f1r_sRbf8CO21K2c1dimFB7h-xMP8NOkUXAd11LFdX6lpm1jaOc
    PEETltoSXfDctfNgDJD2pR_jfudQv_wIRmTQ4ayWRGICSqWdxQM3g>
X-ME-Received: <xmr:qGyeahCeJoOsokjPr73FJl9Ssxl_xH1wZA7CJZzn2qvsRIykwLQWNw>
X-ME-Proxy-Cause: dmFkZTGIfEMd0QspF6Fwv4c84alGxsyPIoycVHSiL0/nOmaH7O1Uj6EvSKOGPrxcMGKhBo
    t1nwnrpIrRlIYj8bW8rzwYfl/q1ZaxpBA++og7T8OrDkljwPlFBEicOSIIVpJ+WTN2S7W3
    6qe0R8xPg82LyTKg74i23/3ooIXFxPGD7clxoZ6CI7mRJkpb+UKAtFQdX0DyJA7HsjcxyI
    2uswq3ehtYFh/NE4li27/vXObQJdg5wqwrDGuWByVwakkMe8HoK48IeN8bdv+xXw4U7wiy
    Ponv7Qk5heyPdDkk15aCbDkdZ91anPviP5kzQVPmfxabSMQkFGE+wWh338VvWqf7NfCZC9
    vYn2aNEL51pcT99yiDsoDRuhXbjZsJafjg6aQ6wQARSwissxOllzQAIZcUhtOtyz7lccWN
    pC4yIY7Gzu0cE0UrUdp1hsuzv6LrxucxgMe8JaO8JUfarB+YTunl/w0ZrGkayywG9DDRk0
    zAy7ShGBtzqE4+SmfxnOpcy+pnxH9XOzPZ2r1QpYAfDgnNof0UV2bsumYnJsbKkivferd5
    GC1pRaIzI5WHMtwSd7FtjtcZBViNrHDBgQJ2JPQdzt6zsAT0Cego3EjIKfl2fCnszLwTeP
    V/48n/OLUW+znonKRPz1h7sTqTkA6FplyG1DLb6hjHjY8WgA/Hm88voD5Abw
X-ME-Proxy: <xmx:qGyeanQw_gijrGeI2h2IyortWcm27UzGA1aVl0rHzA2boQq9GA0evw>
    <xmx:qGyeavpUFOEaHI3EnHpKMYeNZs3gLqru63rvSgHNOVCYEgWG3FA84Q>
    <xmx:qGyeapxLCkeIXt434FMKR7N-4dk4lr56Wd7C5zgZ9Owgc_2Ixr4FgA>
    <xmx:qGyeakJj8-gkicHcACDVGT_vf8nE93FMbqr3Q_-fFytgOrxrfJ0LWA>
    <xmx:qWyeakTDApWqrBgzuDrzHj9K72eapUavlMcxB2tBI05dWy01p6JBrmx0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 03:50:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4be7cf7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 07:49:59 +0000 (UTC)
Date: Mon, 7 Sep 2026 09:49:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/13] cache-tree: remove dependency on
 `the_repository`
Message-ID: <ap5spPyWgga9b315@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-2-c6ca12fdea4d@pks.im>
 <CAOLa=ZQ=oCDtjAQXNXe51DvKUCCk0CK1EuM+QKhJ3iH8YiS+mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ=oCDtjAQXNXe51DvKUCCk0CK1EuM+QKhJ3iH8YiS+mw@mail.gmail.com>

On Fri, Sep 04, 2026 at 03:28:07PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "cache-tree" subsystem still depends on `the_repository`. Adapt it
> > to instead use repositories provided via the context, either as a new
> > parameter or the one passed in via `struct index_state`.
> >
> > Besides getting rid of `the_repository`, this also removes the last
> > dependency on registering submodule sources with the main object
> > database. When reading gitmodules from a submodule's index we implicitly
> > read that object via `the_repository`'s object database, which is of
> > course wrong. This works though because we would then register the
> > submodule's object database with the main object database, but a later
> > patch is going to get rid of that mechanism.
> >
> > You can verify that we indeed no longer depend on this mechanism by
> > running tests with `GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=true`. Without
> > this patch we fail in t1092, with this patch we never register submodule
> > object databases anymore.
> >
> 
> Interesting, to sum up if I understand correctly, somewhere in the call
> chain of looking up the gitmodules from the submodules index, we end up
> using 'the_repository' instead of the submodule's repo structure.
> 
> This is of course wrong, because we use the wrong repo, the consequence
> is that the lookup fails, but we have a last ditch effort of adding all
> submodules as alternates and retrying the object read, this succeeds.
> 
> So this patch fixes the repository being correctly passed down. Meaning
> we no longer need to add the submodules as an alternate.

Yup, exactly this.

Patrick
