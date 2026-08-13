Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6635828033B
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602712; cv=none; b=I1WqHqZvlXlfUc5Jo5PmX6n5QoHOQRGMNuvy+URW4YpEMJ5xvqraqMtkh42Jki1dp5p7SLGuiox2jiRLikmk5vl0QBGeX4Y375s4sOQqSld+siG7+k+1w9T1KG0JQxRUlno8lBA+3pQD3s9wvnwfyt3a6HA6MqK+Sg6UeP+778c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602712; c=relaxed/simple;
	bh=tVmNxgvZ83eFoYiH13JDAqN8BxznV8/e/PrdPSit6ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pACH2ojlwdzMiqVYzoeIqgZOa8OZUKx1BWt792FvN1exWTmGS1/UkwzHUkVT9/Uj6STugeuMcPoIaUlLz0m1WYSaaP8mZXijejZxbvQvoCTfcPTXZoCJILKz2Cw5NOTJxDwWZcA0y/Znc+dkAxXPyAjQl1U0ZKA/2s7s5SRA3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jYggV6TS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNwWR5B0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jYggV6TS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNwWR5B0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A0B81D0005D;
	Thu, 13 Aug 2026 02:31:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 13 Aug 2026 02:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786602710; x=1786689110; bh=c+iYKk1Ucv
	3oja/Ah02RAdjbdfnuWpdF51+etvwQaVY=; b=jYggV6TSVxVPZkXGVK5UKYZPeu
	Ut7cHFw2XQ2EvrriAxzp1aliTkuxPPG94hmovbuxfmFLs8xCUO2XH/eBm9vlZEa9
	1QpTNNiPWo46ikcF0Eo4QnBPG2G9DP+NDeau1BS0YgKxTIt35rCvUotHzLtaqKhD
	kxG1Nm9YdTNtNGa+JMt2rd899dIbK93m5shQGfybbFky+Qh2OxryY+7jE2+S0AsN
	DLyBgTuGSiI9kLFZj18kxIjoqI3sTKsCWw0mzrKxfJU0Bfx5+/8vXKhzwbV7aUn3
	PRio/nDQWmUcoZYJVlt4aJOx+KfbZp0F3LVuhSV0is2RNwdYO4qqPAGAro3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786602710; x=1786689110; bh=c+iYKk1Ucv3oja/Ah02RAdjbdfnuWpdF51+
	etvwQaVY=; b=CNwWR5B0RNkWrWWlyIPbWppRv9KdgrdbTFF5Xaoy9+IRjGEcvTu
	doG/DH6z5rNjtcbMa2Kaj9S3zeibAY2pDe/E/eaF/gVwP1yG9roUBasJhyjeud9i
	jwaTm/B8hQvLpd4RxHqEWIdN5OYazuNkeB1ZxQiP9z1EiM5YQKkvVUSatIoVTxDE
	XCdeV7xvMM4oHnAvbbUvRudbIBDkVDs8u+9uYzWhBt7MeJK7t/3Rv4+QPe6/ETj4
	/yf2W14741WoNz+eNvI8f5DoS3oz+nc1pRkAg7//MnvEM2pTLKdwppsm5oJkbgLs
	B9aORktoCbb4Oa/C1awmCyWiGBVbzr1bhIQ==
X-ME-Sender: <xms:1mR9aibxg23VOXS6u68CABgCLkKJ3lRIcw9mSKpXKl9RSwjnDeXC-Q>
    <xme:1mR9asS3Corz_hlJ-aF9vo79deQvhVabzkzWOWEYNChqLa-Zq_iv8IA8i01uxHWgx
    IFQoQjPhYQoHG7TsibU7Yx3MIBVybkW9JQqWw46xUnoMgwgTFTsV9s>
X-ME-Received: <xmr:1mR9alTpbGuclL942Krk1CXVcmbn9V-I2IiUL8GA_W8MWfEw6fAPWRppaLd0PemC90y5QntQlPmAMVxFl5BmaeuVvLnPyeHju53PXkby_P-i>
X-ME-Proxy-Cause: dmFkZTFMZMTxHyMa0ikigOs8G/H+p6I9JpCKKrM93jhZgM4q+k0BOzXvsdDKAeKx5u59ow
    rx2XLlSJ+NGnuPkax3JruHaOpWYz8/snZHhypzv4XMcgFKT2YHqifxYT2LRbRsnCFEi1rK
    S31RNcLaJIIajfwu/BSgYMtaMXfbLcJ9siTGudc/3ilbjILPjvmVchoIOVkvjuSlgGKbhC
    gCtbxpeOeSIoBb3NeC2ltzYTAYxyQqu6qfkYZk2+cUtfEMhGmLWQzS4Yk9NyjMfjXQTV70
    HuFNuWoYRRvoedW0MB675UEjTKvINa7vyvblPprmHuZz3AHQneiK17M9y8CtTCpSbtO4AY
    jsZxFSVrZGO0mcUBWATIw3XFrq8MF8j8Xy+YlYTVepR12MR9jR7QIBLzGY4Md4ri+H3pKd
    XwlHSWadGmD2Af6wFYUwHrjGqEHZYM1ZX8daTzK5/V9tqna/KO9jSJRF1pSoUgcLFD7gwu
    POiiQxskDeAy2zijV1aAQxAPn9nb6DSDHB/Dm+fVXx/LW8S/1RuKHf/OFQBZ28PkNw0Y6h
    9Dk215+uQP1lvJP9AQWKNm9U5bbZInZzZLMYIeaCIDaDxfXbvRQe0tz1n1XcArXAYRYmLF
    9EEcdb1OJqKlalSIh9OUHQQ6waEOQwykQeEsD98N3Al+qq+ewjv5lJqWXp9A
X-ME-Proxy: <xmx:1mR9agT7EQ5FT9V7uZhNAjsYCXWcI-XWojx5GncxxVdUATZ1Sca--w>
    <xmx:1mR9aq418zmKvbxCgJ24-HeggG8dHilej-o-0uetOyYwFmeivwPd1A>
    <xmx:1mR9as2ILJM_Ugw3mMmzExe7nB4ixHufwIgIN1KeMZdLUzq9J-f80Q>
    <xmx:1mR9alC1E-Yx9CvEi9DwCUHxkrX9uirma509R-HUvnY2K74T_xi4XQ>
    <xmx:1mR9ajtqnX3eXLzqKoo96hqStEqS5fS4RQLfytdeSMaofgWyeSnau5R6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 02:31:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0079139 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 06:31:48 +0000 (UTC)
Date: Thu, 13 Aug 2026 08:31:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/12] coverity: fix unchecked returns
Message-ID: <an1k0d5fI4EVsfsM@pks.im>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
 <xmqq5x1fxn5u.fsf@gitster.g>
 <20260812213438.GC152730@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812213438.GC152730@coredump.intra.peff.net>

On Wed, Aug 12, 2026 at 05:34:38PM -0400, Jeff King wrote:
> On Wed, Aug 12, 2026 at 10:29:33AM -0700, Junio C Hamano wrote:
> 
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > 
> > > This is the next batch of fixes in response to issues reported by Coverity.
> > >
> > > Changes since v2:
> > >
> > >  * Added a new commit to handle block-writer initialization errors (instead
> > >    of ignoring them).
> > >  * The bw->zstream attribute is now also deinitialized in the error case, as
> > >    suggested by Junio.
> > >  * The commit message of "reftable/block: check deflateInit() return value"
> > >    was rephrased to stop suggesting that silent corruption by zlib would be
> > >    possible before that patch: This turned out to be provably incorrect.
> > >  * When aborting the bisect because dup2() failed, a left-over saved_stdout
> > >    is now also cleaned up.
> > 
> > Everything looks sensible.  I am fine with declaring victory, but
> > does anyone want to second it?
> 
> I cannot claim to have read all of the patches carefully, but this
> version addressed the sole concern I raised, and in the few other
> patches I glanced over I didn't see anything to complain about. So maybe
> consider that a weak second. :)

I didn't spot anything that needs to change, either. Thanks!

Patrick
