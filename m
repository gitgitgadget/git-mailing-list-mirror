Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94878492E5C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969861; cv=none; b=eHgWUt9vP/fDTYfCwRdxOrGNPFdiHtoyxofo95mi+drlGKiEIM+5WO8bamt7iF6tZ2W/P0I5JSrlwiPvvFbwhxZqKuagxg+H1TbMvITGVte/b/LGArETRdPjLulqO7BmVXBysbmdb4TWn5cDybuKsSJFm+1WFGSm82ud1lfSla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969861; c=relaxed/simple;
	bh=X/YLIEn7DztRPcmwuOk97VI/+zvpmUVwSNxXqPG8BE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ0CbDPh1ETE2cPaukMvcsfvvcmjL0Rjf9WeHSBxRlCXnzzfSBDlhFhzN6ypQATUNE01ErQa+24FyYR2FlldyB9CDbDH9UQAgnoWvrO9241mrXBh4gqxR6qjAlvXxuaAILRtay/NvGqaZr1SlHWCPstr8Og7+hOo5rGPotmLnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZ+Qf0CB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWla1Be2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZ+Qf0CB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWla1Be2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 395577A0118
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:37:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 15:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790969848;
	 x=1791056248; bh=qjFyz8VbAIQxhkvJEAAZEPHen4/qeFYpLB7pRrwWGKw=; b=
	eZ+Qf0CBGSwZVr4FrBLpIrvjjH1VnRlHSKZR6Ib3neHi2Ok9vJDTIUunqswobK/m
	5+o2jnayj5EB66/1YcrsAXAcswi2aMMX4a4LPHSRqQgQuNX5G4jlKDE/F/XTZvtl
	6hAM7dzcaQ+uvN9CESgMTdg7lojvLV3HYy4AtEauk9CAgY1sMPPzqumrpP53L7lT
	LitWbHR5GcBHMmQukH3FNj5PhC4ZaiWus+D9SbxzWGRb2MWQ6yCX+ZELwpXHdpNp
	GhfOSD2h5XwmygIYJUJSGM2r/ggH35aGJo2UEhx4OovU6fnq7AAbxm7MDnfE1ES6
	YPcTHK/L2AqC7n27vdVFqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790969848; x=
	1791056248; bh=qjFyz8VbAIQxhkvJEAAZEPHen4/qeFYpLB7pRrwWGKw=; b=b
	Wla1Be2xHwyifoFi8BPCQQgvAYZV0nJtZy6tVVscQz+wPN+WGq1wSgrelW5aQooy
	KrFsyy7ZJd79CIoHyxvIiPV79xgaDKn4ii0+JurcDsIZCoalWlBK4HqDAbMU3NEO
	tvw/xAGnqJwOoSOQ/AsO/1Q6LyJmf244WF5gvpxeALQvO0zD2Ls7JtTxCbnXmLUt
	sATHVWZRDSD9yJRHTgWpRDS10MlPLFDMkeAz6pdDzZoGU0veoV+uuIF94Uttp31a
	Dc9KFKKh96hc448D5SttdYeoW1gUHlpaY+vXEO47dKOADtgXyyV6Dm/RypbJ3yoX
	FSOPLWimtAMyil9VQ3pww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790969848; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:o1cqyk2YwpmfUM4Wf/hMlR/EftCHkzuYoWC3zeSgq5cKRQq
	jWO6HUaG3w3qhDW4Y8aqDNWHLe6DBu89OKir3XxUTRNhfsC62qsPNVTkTsMVy2TA
	i9RL2bDQTceNxMMnf5i4WhBwakebJFATSHkXTc5MpIHZ2NLs4PZgZvKIMRCOU/7c
	meQ9hUFQmGUkjJfu1CGbCfLH+vNse4gSsrdwJPt9vlU+pcA1yx4cmYV/jdDSh/Sr
	dEioQS/uZLrWzVz0bVL/P2fvyxxpLN7qJOY/ZeAWHWcvi9eHZc3RyXTSHGZsO+vl
	yHyg3KrlDXPHBbQgCjHGqS7rNasgr4W41rNdg7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zNJr8TUbZqbE8NwQn5fPHWUs6bQPnIoQF+aFAQZE7+k=:X/YLIEn7DztRPcmwuOk97VI/+zvpmUVwSNxXqPG8BE8=;
X-ME-Sender: <xms:-AfAajKnnz6kUfzsUDJaD3PUOIsQF_H8VZpRoJ10XBcuZgT7wbTsTw>
    <xme:-AfAaukTG0pzPtgLeP_2CVRWEPcfPJq0L8Tmmn_hHO9heKvGAcQ57YVqVXE4GjaKu
    zoTVwcs-esbWpStvpjZWL1h09FhYcn5eWwCKjNk8pyEK-v9lCFqaz0>
X-ME-Received: <xmr:-AfAapHYtH7QK1zlUnvGlTQPJKxDUn3U_nCIrhxt04HCON_K-11YCg>
X-ME-Proxy-Cause: dmFkZTGvNtMtHRy3VJpAMj3Om6FcuWBIIkJGfVEg9b+EHZtjNUfwOzpSr0/lLxDuDiCkn/
    OAqHsaZqjX3ATDxwNnsaeHkmtmiz14Ik5BrCLgEXE5aCT0dddDs0zyHQYpmU4qlxlJYhrJ
    7E6/U5bMdPn5nyurmVW9DhCDokxwFdA5Dtfrc8HX3LXWXYGtSdfgthKhcoQadqOVByX6mj
    JhGxXGHcHCSgxhs3TbiS3Gd4CMKKW0JeV/JBrHyJyd9dceHMazWgxoaDaWGwY/Q8eGnDJT
    FUraN8BpQtZIS+VAWT7X+FeqFPmlzdzgsItmePkbMSrlWzKWLcefMoXLOklp6casng1wtP
    s9oLAtQK4t2Un1RaK3GT1fvO7MW1H+IyA+F+InLjOAmgoXTsxJs7EA4DkfRFaXHceE/9Ko
    TuL03Qeh3uvku1d5fD8NHkKbpfhk6IXf+SfhIU0V1JNl80DUGM8RV3SJwqluWrMmK85Ah3
    VF1JxBB5m9ScvQ/VEQklR6neKdqmL0y64r9JedOpR6xe6Y+COI6NAsYkjix7FU1hhgS6Kb
    3X57ucSOyjXe9F/K/JsfIb0j8uZanLLyT4KJ9gvt5F2mM0GIOSH7ir9OedaVOeTxXZHBix
    OB4vAwAU9mY8z82UB6EuSwGlbZrWmHcYHvEpgS5wng3yKDZkgyLtN5zKbq+Q
X-ME-Proxy: <xmx:-AfAamH_CLrKE0C2X9Scwtm8vtCeVFiCErY5t972PJs2T3gtt-CxvQ>
    <xmx:-AfAauNdE0GCPy-oTvwkOsSignA_PXwtD33HUTyrEbEi7lKbItAt6A>
    <xmx:-AfAatFsbo01Xp2s3CW1YZZRNxACIjGKZ9tkYkzPUZ3w1IJAxIoNUg>
    <xmx:-AfAatMkR2q-adR8ZP8E4vS5PIJFBQybvblpCFMWoDVi2ePU3SPdsg>
    <xmx:-AfAasBCfPXCG8HFh8_4eWJzdaDqY1_GYr7txwR9ljVT74GGAlT0h2lJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 15:37:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73295938 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 19:37:26 +0000 (UTC)
Date: Fri, 2 Oct 2026 21:37:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org, Guillaume Chauvel <guillaume.chauvel@gmail.com>
Subject: Re: [PATCH 2/2] packfile: fix corruption due to stale delta base
 cache entries
Message-ID: <asAH9ma00tb4r-ks@pks.im>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
 <046C5954-DB91-4B7B-A89C-70B418CFDFB7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <046C5954-DB91-4B7B-A89C-70B418CFDFB7@gmail.com>

On Fri, Oct 02, 2026 at 01:48:46PM -0400, Philippe Blain wrote:
> Hi Patrick, 
> 
> > Le 2 oct. 2026 à 03:34, Patrick Steinhardt <ps@pks.im> a écrit :
> > 
> > ﻿The delta base cache is a process-global hashmap that is keyed by the
> > address of the `struct packed_git` plus the offset of the base object
> > within that pack. Entries part of the cache are never removed when a
> > pack is closed, and neither when the pack is subsequently freed. As a
> > consequence, the cache may contain stale entries.
> > 
> > For a long time, the worst consequence of this leaking cache was that we
> > held on to memory that we could've released. But the reason for this was
> > that we didn't even free the packfiles, either. That has changed in
> > 6f1e9394e2 (object: fix leaking packfiles when closing object store,
> > 2024-08-08), where we plugged that leak.
> > 
> > Now that we free them, a new packfile may be allocated using the exact
> > same address as a previously allocated one. And if the new packfile has
> > both the same address and a similar layout, it may happen that a
> > preexisting entry from a previously-allocated in the delta base cache
> > would have the exact same key.
> > 
> > All of this sounds very theoretical, but we can actually trigger this
> > bug somewhat reliably! When doing a merge with "--recurse-submodules" in
> > a repository with lots of submodules that have similar-looking packfiles
> 
> merge does not have a --recurse-submodules flag, submodules are merged
> by default (but not updated after the merge, which would be what the
> flag would do if it existed :))

Oh, right, will fix.

> > When using glibc, one of the packfiles will eventually get the exact
> > same address, and that will then cause Git to read the wrong entry from
> > the cache. Git detects this and aborts with an error:
> > 
> >    $ git merge branch-b
> >    error: Could not read 584ef938be4a749bfa13f68d5ac5545bc029e529
> >    error: could not parse commit 584ef938be4a749bfa13f68d5ac5545bc029e529
> >    error: failed to merge submodule G (repository corrupt)
> > 
> > Now in this case we're lucky that Git detects this error because we try
> > to read a commit from a different submodule via an object database that
> > doesn't have it. But potentially, in an even more contrived scenario, we
> > might even silently yield wrong data from the cache.
> > 
> > Fix this bug by evicting cache entries that belong to a specific pack
> > when closing it.
> > 
> > Note that the added test reliably reproduces the above bug on my machine
> > that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
> > dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
> > specific allocation behaviour of glibc it is very likely that the test
> > will not work on other platforms.
> > 
> > Reported-by: Guillaume Chauvel <guillaume.chauvel@gmail.com>
> > Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> Thanks for the trailer and the quick fix !!
> I’m still puzzled why it worked correctly on 2.56.0-rc1 on my WSL
> instance. From your commit message, I guess for some reason I get
> different adresses and so the bug does not trigger. 

Yeah, it strongly depends on the exact allocation sequence and on your
environment.

> I see you the test you add merges more than two submodules, in
> contrast to Guillaume’s reproducer. Is that necessary for the bug to
> trigger for you?

Yes, I was not able to reproduce the bug with less submodules. The thing
is that this also depends on the length of the path in which your tests
run because of how glibc classifies, and probably on other factors, too.
When running in "/tmp/" directly for example I require less submodules.

Patrick
