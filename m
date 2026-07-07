Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EDA39DBE0
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405543; cv=none; b=U+EIn5hW3Z6fiyBPCa/yB8o3UkdB77ZMd1859IkhiMq5y75jw0N+7tnKqyRGV5lbI6gLiCkPox8VYFfKWAj2I9xPitcTeVf4US/GCdNkDiB3hRDQGFsrYrI/zqKyu9hAnDdEis5I0U7zpnpiWNsb/js9vkQJnrgvEVmAOkpmkzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405543; c=relaxed/simple;
	bh=NEBqvoKPVMCjv8SUz1NWz6EiGjW3Ww4ljgwLK5y/et0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovp77y8oTiSKXeFCnLwhyoUgThj7OczC80YmitCjCZSB+06+HPyBiPFbd1iuSxWBZU4BCVg069ZrWKn4KEkizJKzSvFy+yw8TVxxx/PaQ12tug6JRH0Y7t/JUDz38av+6wiYyiPKz/gLES40ipYRnSXrY4IsdwstLzHYh3gxMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PzuaxcEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gcdm3FK6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PzuaxcEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcdm3FK6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 014417A001F;
	Tue,  7 Jul 2026 02:25:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jul 2026 02:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783405540; x=1783491940; bh=/FMdy4HkKZ
	qqlJzxaKKgKQLtHVk/KzVCxVrOYKDj04w=; b=PzuaxcEuvZGCyhKz7TvD1mP+9i
	Rp/IVEGMdnIisj+t0ThfdYC/rPQ09E9BmhWLqpOsgOC7LPUaVeqeXlq7EMQ7LOxm
	lgMPCSxUDN477lLe3aQrlbSqt/6JfAyC8o/rLSJ+0PIDcb7k1DZCG1GnrXNWGZjM
	ndcUtS923N4Xr1xVvmjSCxFP8JKKL4+GY8YPJ19EEl/LVKn6qA2YTNlIEqu3YpBP
	YNTtTw7slEJZIbmKH30cEArTcEgVAB+D7Oykzf56N4HVarkJUf21n4QGFdBsvk6T
	YsK36ENSuFmhwPJ+yZ7Xh+qlbVDf8/F/zK2HXK49+DT3S1e+HAGahI2/iGVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783405540; x=1783491940; bh=/FMdy4HkKZqqlJzxaKKgKQLtHVk/KzVCxVr
	OYKDj04w=; b=gcdm3FK6wbjErFplNnql77d4SCKib6rx5qZrTN8RZwsYckKeX88
	bflKJizogkbYnG2ys1C3An8bHBBs6yYxKZ4HfMUZE2BhIYVlod6YmMTPJmQfdfmX
	nH9oLiNYJ5Ahx7mculnGDCL0fixPHzpuakIDnZC0AJBrcMNEgZ/hSYIN+Xr466ZU
	ZqSX3+vN9gVRnLnaWaQdK/Cm0u1j6Ho16S1qrVXChWuvGAurVywz5wACYAm8WBZq
	AftQ+Rrl7XUNNFGIEVjqMgQlqE+Vb2B0XLOCMuviBmaluEK1JsTtdbqgh7zDJxNK
	R4N3Ttxh3PYo2YSBBnjVqjTWgtI1yDNws9A==
X-ME-Sender: <xms:5JtMakV-ZZ0_6vqmxQk0kbOfZS3P-amuvGLtGBrdsqEoPeCxMqer6w>
    <xme:5JtMaulg2EksfOnAqrwjMfwQxjDgR-71nDLFIW51FF84TAI4HOY3B_2dpXPGnO4IR
    hlU1PKvEOjsUnk0GhUh1IsfKWFSk3cA0p_ZauIIF_HGb3qGa4_G1Jg>
X-ME-Received: <xmr:5JtMamCPR3E29gquKQjLwbYgahxJ9hLvPLlKciVFY-gX9jDDZpuOmtoEZXYHON20n9PAi0ht3xORwc7HoaQsihwjp2qTPqAffBEdP81NBQ>
X-ME-Proxy-Cause: dmFkZTGFPsrJdhKTDr1spWrqYaSqzq1RIgAknWH2QF0cfneaC2bQXkigU7T80p1x5mKzgB
    hYgGOkRxfvnHe592/sQJPDvppfGPjcPf1Oh6D1o0Tc+/wGBmRmmcFjtZlZpuzXyZbZdLeX
    z2GW5mI2D197Is3662Jkb3CGdJLlAYOhdc/KG47POwh0B9/z89Mmm4+JNcST6swzP1quUH
    8q7SiMYLybbrvA+WR4ETiVdtJjH9LgDfJR8HQkbeiY31yR0LJjp7S2lP6ld7fCeTF/fnI5
    yy41FhZYx5pHkAIKqk1ijgtbcU5CPy67mR8FgRW3Qpu2nAdmbFhQQFYvKs3N0PoxC93dqX
    wLTsmFpuibp4R5DC72ihfc6Dh81rQhNhM3e+AvSCn+s91kbRI0Xuhz2AVzVQKstPBJS+KG
    EdMaHVADtfgfNpTdugk/cGQcTCHO3TYjOWLbVvVyl7hNr5CPb4FBqpygCCNRJAeQ0uoIJ9
    dY+kyXklkG4OvSt0L9ItXJ+xA7RQSP4Y0vQcM9moYIUmpIxgrCaoUJk8xJhA64m5AJpdoP
    UcnQREN/jb+f24lW6/L4NbnPwRgXOZhY2NxYXQzpeBNJOfLEVP6M/vHb/MC74xJ9ZdHkNF
    Bs1Ks7tv34ddSCiMIOaE2I9Fj8aUtQqONQsp5wqQBd96bboYIQ6wq3XdNoAA
X-ME-Proxy: <xmx:5JtMaueUohonYJFHUYUzgXFBRQRR47KU4iaOFKSv-CGUJ-RJH6G3jg>
    <xmx:5JtMahJuu-mPwdtjt2xYYbol8VtYAeTj0KoT6MJm-Trmk7NqJ1i7Hw>
    <xmx:5JtMahf14ZtNdVD4gnVuohVP-C2tFbua3rUGKO_54hln_WM6qYtvDw>
    <xmx:5JtMao23MCBUAgCQD6bhmCKYO6RT99---CkMtLpqzWsyDFg_knzIRQ>
    <xmx:5JtMapEV5DZ8PVorXA1ncCIEhvVaPVD9-xQTwhp2ccPPA60rGYAtPh78>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 02:25:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c5ca83a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 06:25:37 +0000 (UTC)
Date: Tue, 7 Jul 2026 08:25:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] setup: mark bogus worktree in
 `apply_repository_format()`
Message-ID: <akyb3o5yG4QMSudd@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-2-13864eb5a032@pks.im>
 <akwfAmyeIVJYXj1h@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akwfAmyeIVJYXj1h@denethor>

On Mon, Jul 06, 2026 at 04:49:41PM -0500, Justin Tobler wrote:
> On 26/06/30 01:47PM, Patrick Steinhardt wrote:
[snip]
> > Note that this change requires us to also explicitly unset the value of
> > "core.worktree" in case we have the "GIT_WORK_TREE" environment variable
> > set. This is because the environment variable overrides the repository's
> > configuration, and we don't want to warn or die in case the work tree
> > has been configured explicitly regardless of whether or not "core.bare"
> > is set.
> 
> Hmmm, does this mean we now just silently ignore the misconfiguration if
> done via environment variable?

We do, but we also ignored those cases before. So the behaviour with and
without this change is (supposed) to be the exact same.

> > diff --git a/setup.c b/setup.c
> > index 118416e350..f54eac5e5a 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1768,6 +1767,12 @@ int apply_repository_format(struct repository *repo,
> >  	if (verify_repository_format(format, err) < 0)
> >  		return -1;
> >  
> > +	if (format->is_bare > 0 && format->work_tree) {
> > +		/* #22.2, #30 */
> > +		warning("core.bare and core.worktree do not make sense");
> > +		repo->worktree_config_is_bogus = true;
> > +	}
> 
> We now perform this validation in `apply_repository_format()`. Does
> deferring this check have any meaningful impact? Or is
> `apply_repository_format()` always called after
> `setup_explicit_git_dir()`?

No, it shouldn't have an impact on any user-visible behaviour. We always
call `apply_repository_format()` eventually, as that function is what
does the final setup of our repository.

Patrick
