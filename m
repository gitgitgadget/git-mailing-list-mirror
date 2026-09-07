Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4641DDF1
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767407; cv=none; b=bVruAWfWoISAb2owoDZ1rsi1yQwrVL+jvL/Uzqwaf5lwb2dfLZMDAMh9LIuetw62fuShHsr0WeJcb8Yc8JkoioiHSQELNcdnc34/UEaiDoDriECz89kgCZHNdCu9Ao76kxkarXPatvJg+HD9uhjxtNTi79jFtAO+zJXRxYxjBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767407; c=relaxed/simple;
	bh=CoS6rFjnyiO3afjeMY+v8omjS9hU/qRwZeRmA4ktx4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7rZNVk1EMo7eqGiEgXjsQSrCi9/Pzqk+PbtuEUgkm9MrpE6v4xTTAYq0P7to21mL0pp0Qky1PqLFCUMJ9ZgaVn6iCrVMjX0s6uAJVP/8zVZcbsJnmf8l6BrZ49lO5GJ3DkgErKs0s3Vsro0yY54yuB6tAkFRR04X/+Cgu3aMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vokfZsXg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1ZsNBn6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vokfZsXg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1ZsNBn6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0ACAE14001F2;
	Mon,  7 Sep 2026 03:50:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 03:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788767405; x=1788853805; bh=fGraDaQ5Iy
	lChlG/vTZTZUnjUIx324oj/EQMTjDSmNI=; b=vokfZsXg5KbOVVLThp6+npDXn5
	XOqXF5Y+2dDnq/SQmxdbIgnahriJcdX/p+v98NZE3scHI24HxiDFNS2C1BYV7R+f
	UwCTy3aKvIEF+WDsueGEbZl72S1nP7g8X9wl+NMnHLWKrcXuDBqzhZ0evREcPdk4
	+rD8iZRZN7R+AQoS6i0jbA53Jp2ZfJozeivRkUFLr1iEKa5bws6bPqFQXx3IlS0Q
	pbNLhU/s2tReBXnCFjsVJTqm1RtVawU4+l6py5XViKDvSCjFIwDLbF+ITWCQhW00
	26m+Ua4+m9ctPZe9avNfl73JWkqsR5bm2w1l/8gbq5GgQaHwPPIHxBADvlZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788767405; x=1788853805; bh=fGraDaQ5IylChlG/vTZTZUnjUIx324oj/EQ
	MTjDSmNI=; b=K1ZsNBn6B+2DlNNC+ludwUeOparD/rbuy8Ys2EoEhlol9gDrddQ
	1Yv/hKYhLYtmLvXCGs76dSu1Y+iXAIE1eSA0R9kBWH47/ea4zck2x5QV+tfa51oY
	wnodMO8aOUXQptu/sNyUOopTKqdNDv0VVubNAY/p7d0WYSOlByfwVi11YE1WZ5YC
	cuLSWWkpYn8f4fRaNWHiFQAvA+O6BJ0LuCoeEsza2+lkXK3taCkeRCa5op34a7jj
	YHgPQULAgLhMzQzBuoQsBWs0d/rNZDiUD64lTwHU8pYvY6Jq4Rm9bj4tdQeOxhGH
	zrk4yT6P07/PR7Pbk2qdPnjMQoEIUyL7YMA==
X-ME-Sender: <xms:rGyeavcmLK3TUrVedKeETiih1WmSgd70pYmdaquWPejFaazooDFKeQ>
    <xme:rGyeasp4VDYY_7-OU1_Eiqzg58MmF8ybcMs6Ogcvj5l6x2VWlcajdmMcma8VPYP3m
    XqcJH6YnucJwLCUoQ0r4WAEyCWFyoqBKrOaKZ5W1A_uz7m3nPMqu_E>
X-ME-Received: <xmr:rGyeal7yMsH0hzH6s_R_QDBpIqlsPIlGDic6qYSJ-wEbhaDV_UEOaQ>
X-ME-Proxy-Cause: dmFkZTGIfEMd0QspF6Fwv4c84alGxsyPIoycVHSiL0/nOmaH7O1Uj6EvSKOGPrxcMGKhBo
    t1nwnrpIrRlIYj8bW8rzwYfl/q1ZaxpBA++og7T8OrDkljwPlFBEicOSIIVpJ+WTN2S7W3
    6qe0R8xPg82LyTKg74i23/3ooIXFxPGD7clxoZ6CI7mRJkpb+UKAtFQdX0DyJA7HsjcxyI
    2uswq3ehtYFh/NE4li27/vXObQJdg5wqwrDGuWByVwakkMe8HoK48IeN8bdv+xXw4U7wiy
    Ponv7Qk5heyPdDkk15aCbDkdZ91anPviP5kzQVPmfxabSMQkFGE+wWh338VvWqf7NfCZFw
    QyBX807JXPKzkRvwDvsolwlt1AjlFRNJHtG1rfuVYTsXTnDgV0OvYSXy4EJQyM9vddB21K
    vqX4hlLqSU4ngEJqLbpDIWQEhy8cINg2ktMMDb2OArVzfg47FbxEHfDemB39yYOtTm37qP
    QpzeNfKNLzZW6/9OKgy0svqhzCeAlEvXA6WOaWOccXk6vN+e8dw+0YepEH90/kIjmtsn2B
    RvYBB1Zb+KwEUYCbWWF297G8IQM1gTdjBSZetedjr4aPXw07P5z+jx53QSiP5maVSskUh8
    aPUyVB4WH/4T+K0h8QYWAmT6LCio6L9Nx/DIVIP9UKv/4UM2wWnzFy8vwPhw
X-ME-Proxy: <xmx:rGyeaqop5ONpQC8P6tBkd4wP1lRMhzjTj55fzi5w6z1pNSFru3WG-A>
    <xmx:rGyeavj0rURTl8Ruvmn8-abYDxI9WOod6Kfx8yHqEDu0nkUQc0wqcA>
    <xmx:rGyeasKeWXdmceJsaNNVffXHVFakf-wOtqW5dm5KfpifI8AD5gx5cw>
    <xmx:rGyeanDudVp47tAbF3p9FZNtlUcLFD1O5ovEM3I_7SYoL9ZH5WMWhQ>
    <xmx:rWyeaopDe0ZjQAWwXLSN3v4Xk2UURwpE_Yw9fgYKA1imNBH4JYKT3-zQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 03:50:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83f08751 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 07:50:03 +0000 (UTC)
Date: Mon, 7 Sep 2026 09:50:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/13] submodule-config: stop registering submodule
 sources
Message-ID: <ap5sqR6RBamJjEeP@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-5-c6ca12fdea4d@pks.im>
 <ap2wj0vK0-VUvaW5@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap2wj0vK0-VUvaW5@denethor>

On Sun, Sep 06, 2026 at 01:38:15PM -0500, Justin Tobler wrote:
> On 26/09/02 03:34PM, Patrick Steinhardt wrote:
> > When reading the ".gitmodules" file from a blob in a repository other
> > than `the_repository`, we register the repository's object database as
> > an in-memory source of `the_repository`'s object database. This call has
> > its origins in d9b8b8f896 (submodule-config.c: use repo_get_oid for
> > reading .gitmodules, 2019-04-16): back then, `config_with_options()` was
> > not able to read a blob from an arbitrary repository, but would always
> > read it via `the_repository`. So even though the blob could be resolved
> > in the submodule repository via `repo_get_oid()`, the submodule's object
> > database had to be registered as an in-memory source of `the_repository`
> > so that the subsequent object read was able to find the blob at all.
> 
> Ok, so IIUC the problem was that a gitmodule blob from a repository that
> is not "the_repository" would fail to be read by `config_with_options()`
> because it would only read objects from "the_repository". The workaround
> was to add the other repositories as another source to ensure the
> gitmodule blob could be read. I had to reread the commit message a
> couple of times to follow, but I think it makes sense now.

Yes. Do you think I should rewrite the commit message to make it a bit
less dense? Otherwise I'll leave it as-is for now.

Patrick
