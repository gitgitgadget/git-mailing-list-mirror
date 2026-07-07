Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720B39FCBF
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405549; cv=none; b=tva8zTVWmSbzL3lRFDnaanfKdlSF67BD8K5bozjWtrWG//2j7bBo/AVBlC/i54F6SwH1tO5vchqMTExCCv6bJlc8C1xx5s3440rTjTXxVYIhAHidyFL3RwFFJwtAq0/1U8/6ag41o6jCYwutzVTneX9v3gGnzaTafpHdx2ZJoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405549; c=relaxed/simple;
	bh=DRHyT/uEK7oDyABA1/2ZZlL0fgOWGirIPHUVAaEulrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh6R+8aRJZszM2xAAWJyXSUdTjFHfOiOuvg1S5KVR/s6pNhv8qmPV5iY9fkDPG4i6g7MHY3Mn32XrOM4DA/Td2YxYSt3BJ7/ZsIkmXOYcZDWVHIhZ0HKnB9n2VvG+Hi9/XpGlfBByOf2Qqi0VMqmT7iKbl65A/K58lTi7JydqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G9IJ28Ew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Asn3+lnB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G9IJ28Ew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Asn3+lnB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F0461D00175;
	Tue,  7 Jul 2026 02:25:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jul 2026 02:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783405547; x=1783491947; bh=EZY943S4AJ
	NXlj7XVex/QJNGlrzCaNPXZDK1K9J/0XI=; b=G9IJ28Ewmeoi3tCsOnvjw5aQAw
	qEUgdaUpIappBMjXcYUKYTdqxdTjQmgQ+ejJr3XEdVSttynp/j82I6yZJH8dxt+P
	W0oEkSrER9klwA9vDYK/+W6d4Od0dEXrMZ5TFI0nWeSoFKxb6Eskn/h+9xAnGgBI
	sPOdAd7sxgnPM1NPji4jdvN2KFTNGwEZsa9v+N7NB9SY0yrE55xBJb9EEEV2t90Q
	sF5yLKs1onnCbKUCX3dZ2LVtbZ+eok0jVa4YsodfvXc2JAMaz4U8XLQ6MeWN31Er
	Hl1lBH9uZ8xu9Ij5JhqTkqTpjGikxsRh6mpUahCMb8lDAEXRtsmSUxu/O4ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783405547; x=1783491947; bh=EZY943S4AJNXlj7XVex/QJNGlrzCaNPXZDK
	1K9J/0XI=; b=Asn3+lnBauE531eA1sQHMRi1FLohCyzunMSJ748qKR20lo16rQU
	zPaq+zK9F2q5Dw1s6NOpdPhHh8ClRx0OdGwINObhA7ZZhuMwy//v8G2RgxpekTAh
	3CsL8LgYJteEwwbrRTojriQbig/LcZp2MDSFM43USrJ4SZ0q/J785iG3xhVtrQqj
	NTKpHUxxTah7dMwTEr1kdnhSQNW87VDWzfua/92CA73impEyEz09AcfewyjBFfTM
	vjhlDjJcmjyAc3fTupttjGlR3CJzYGiiU4HPF7Jtrc7C1FpEYEntQI9bhNIGeVao
	Q2wc5xoMgjBJbvAp0kvfL2q0NajH1Wf2R6Q==
X-ME-Sender: <xms:6ptMasPutlifTXggklzUTAI82bJorUkpf-DetnGy97pIQaK70pH1ZQ>
    <xme:6ptMao96vi5zIhNz6dcgyGSuFLkjRiTmCtyKz-pjZzOtiMB175e2vCWVgImJFwLGQ
    ndJlTPfqrRmRafIP_zc2bNa0mPSq5mjXduLew-cpa_Q0eg8nEvTEw>
X-ME-Received: <xmr:6ptMag6fUzslASxji8csX9yZTJUVzwILmU8rQoKuROjxw4HqKnG6Nf8f0uWHVwvZjiOqlc6b0FJgbVSgXwAC80d9b7sLUKeh-DMZfbqviQ>
X-ME-Proxy-Cause: dmFkZTFS/7ipyYUo0iy7Qt9MztIZJw9zdvP7UfaPhvlhQlFCILJfg+CxtYodQwQEwz6RGK
    acdivkB3Sd+8rC5ej8ederuLaSHAY2oGxy107aYn9Q9TDBIHWkjOINaMPb7Ou/5v3o8D7X
    9bjzQIIjWfFUU/ZY1i8uVF2Z0FbBFZBy4eq32WXIxzzjmRd9iD4PI1HnDA2JjffhZh9Fjp
    yJE1d8IhsEInLD/8ALgw6aS8WuvuAp4/qTbpdw0j10pf8GSBfhGEYgRYGbx1raebSDMirp
    R1wxNPGeFPQWK2FqdbvTsetFRwxtYC1KPmz2ylXJ4z4CXuRBYzYj0zvrh/mS86U2PU6WnM
    xRj8Lum6CWVcKalWTZNA15QG+1mtWZp1brElhukqQ4NFiu/+9YgrFEmwmxwbr5hHp0j4dF
    Z+XfLLYTBP33qp+pelZ/W30zdV83xlM1nXd33JniOvRqJlflC8scudF7LTf0THMAzMwRkV
    8Zj9L9k4ljtyiiRBBwL5N23D2ucNVn5LGz7zBdSnWkEVSO7Pgx4AlOBOfILTHy311Z4Qho
    7Btu0ZljVgTZTqexG8hZWEdFK6UhAGmw8OvD6SjlBygGU+GfKLUCs/A2NLq1wb2u9B2488
    zNS6jk40ppUa6XblBVSUc47d11wOp+xH57qSI3PYTXss6nJcx8/yyUPVqodw
X-ME-Proxy: <xmx:6ptMav2VQ1CVX5yh7He1ity3jjlQeMAxnkW3l59sjWATmQaY1dKrgg>
    <xmx:6ptManCoino3pGugD48tJWpuAqau3OZMbqb9APtANvOYC98ENB1WSA>
    <xmx:6ptMah1DNsVJ1M2dTxg7ClvLbHqB3vmRGppkpAkujR05JcGxXIEW_Q>
    <xmx:6ptMahtUt5hEjY1ahU8HyeIjOGuw-hHI4SdukLp1eWh4BkIPA0GfFA>
    <xmx:65tMau_d5-g7Dq2DDW3enkqtN5z8L3PMNZkHVkkCyiKPExPtuUtyJE5s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 02:25:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acdbe970 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 06:25:45 +0000 (UTC)
Date: Tue, 7 Jul 2026 08:25:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/13] setup: unify setup of shallow file
Message-ID: <akyb5vljS5kYiOO3@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-3-13864eb5a032@pks.im>
 <akwkS45ZknejwhuO@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akwkS45ZknejwhuO@denethor>

On Mon, Jul 06, 2026 at 05:02:08PM -0500, Justin Tobler wrote:
> On 26/06/30 01:47PM, Patrick Steinhardt wrote:
> > It is possible to configure an arbitrary "shallow" file via two
> > mechanisms, and the respective logic to handle these is split across two
> > locations:
> > 
> >   - Via the "GIT_SHALLOW_FILE" environment variable, which is handled in
> >     `setup_git_env_internal()`.
> > 
> >   - Via the global "--shallow-file=" command line option, which is
> >     handled in `handle_options()`.
> 
> Ok.
> 
> > We can rather easily unify this logic by not configuring the shallow
> > file in `handle_options()`, but instead overwriting the environment
> > variable. The environment variable itself is then handled inside of
> > `apply_repository_format()`, which is responsible for configuring a
> > discovered Git directory.
> 
> What is supposed to be the correct order for processing shallow file
> configuration here? Does this mean that the `--shallow-file` option now
> overwrites the environment variable? Was this how it already was?

That's a good question. The command line switch does override the
environment variable, but it's not a change in behaviour: the last
parameter of `set_alternate_shallow_file()` controls whether or not we
want to override an already-configured shallow file. So even though we
used to call that function with the value of the environment variable at
a much later point in time, we had that parameter set to `0` there. So
if we've already configured the shallow file before via "--shallow-file"
it wouldn't have been overwritten.

We can remove this logic now though, as it's essentially unused after
this patch. And it certainly warrants a mention in the commit message.

> > This new logic is similar in nature to how we handle the other global
> > options already, all of which end up setting an environment variable.
> > So for one this gives us more consistency. But more importantly, this
> > change means that `the_repository` will not contain any relevant state
> > anymore before we hit `apply_repository_format()` once we're at the end
> > of this patch series. Consequently, it will become possible for us to
> > completely discard `the_repository` and populate it anew.
> 
> I can't say that I'm a fan of using environment variables to store
> global state in this manner, but I guess if there is precdent and this
> is making us more consistent, it is probably fine. I guess the other
> option would be to store the read configuration is some intermediate
> structure to be applied later, but that may not be worth it here.

I agree, I'm not much of a fan of this either. I'd also love to
eventually refactor the argument handling in "git.c" to not rely on
global state anymore, but that's going to be a bigger refactoring (if
it's feasible at all).

Patrick
