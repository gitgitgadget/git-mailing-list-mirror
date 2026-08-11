Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B2EEC3
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452567; cv=none; b=HkzBd/07McHB1tumxzbqigeSibNLI1LiXAtDmeoDTPucDirE5xD/3st1XuBHskXYvM+EvLUbW1FWFDRPTJXV7Vi/QAwTfUpcTI2uRNVGWobLPO6GAlPuWa/n/c/Xe9DUnTI8msbloaosMBvYqrbcz5UzNFizu67dMKGADFM/wV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452567; c=relaxed/simple;
	bh=n6JkEcO6/gk66hMdq876BXZg92jqht+sY5ZEismGUDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ3fywQ54rN1PdyTFpXUd1X/zNLg5kgZXeyXwd8XYW15l9JANrFuZTN6kU7wGIdlu1IMtF0GAd7WROd8DvL0pLuC6J19C4etfhwMcCrf8bnCKgsdve0+9F4XuHO7CdCw3yxkfYHh5fi+a8FkjHcAZ3oObBiGYvYHIUJv98bTE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iUFMuZf9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2m26Vsr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iUFMuZf9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2m26Vsr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A37A0140002B;
	Tue, 11 Aug 2026 08:49:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 08:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786452565; x=1786538965; bh=hh0bSklETt
	X1IRBmk2Zt1LGPx/fp//6oTi8wJ/RY4g4=; b=iUFMuZf93roCD5cFkuqFhl0068
	4KEb2skG4outjCijiQHx1vtUn6TDifMYYAUcoiMzIebpSzZufKR7evUu+t4fGdOF
	ycnBUc068FkvTHnN60GfWb17AWcJltnJQv4VsJZCwHkdcWSi+qvoS8Bl35sn2HXT
	I9TsQDZF3bIL8Nm7niZErgAU+70Fa/17ZzXspAHzLZpPbyN1+xD29SrbLKIlKos2
	ZPajy2q4RMfcLaNOdbSGRh6JkMQh3Wv9/5FlBtPcxB4/mubLwR8GRVlt1fXJ6DEr
	FBwZapiLOirmHDGbXX1yXB/FAKec4N4Xd/NMPN9mCbDbVZh22YkASySHKP2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786452565; x=1786538965; bh=hh0bSklETtX1IRBmk2Zt1LGPx/fp//6oTi8
	wJ/RY4g4=; b=K2m26Vsr/HcHJZ9J0TKoWXbD+FUDapgtFYxEN57B3SGTslKgG4h
	FHxmkddFksoP562huMtxoNMLuTBjyyrWBQwCeUwppe/jADcyMhzvcOVMY58t1n12
	f9Jy5putTEvJ7ZPh8DFcsTLEA2iOYUOiaZyaPePJjJAxqPj9GtIpZQn5HJRfYRJ6
	neufQ5cy/oSCmxb+QMBam8Tuw515dOFinMxI2eEOs1xOMNnX2QcLNE161DokLN5L
	m5zT9IEx159RJzl8NyEPkXLjqQ5b0ijKpEDHFttS+W59l8gVePBFpkbDRztkW9eB
	pOdcpnOwojSQV4vrPU1I4zydrd1j9cY/73A==
X-ME-Sender: <xms:VRp7auVpXnrUhaYgutsq9Qj_zxeNy8Goi5pnk2eImno_T4wfydFopQ>
    <xme:VRp7ahmVoYVq0gioQsHzf9K8S5hYfeHsNxVaPzfcHXI6QVpLKhqtx2aOkw0g3e9tp
    v_lnvoD2AhifFwCi4r4OSCgufOD8-NP_0EQiVEWm1XRhdg5eTzqlQ>
X-ME-Received: <xmr:VRp7anb_tqDIBOLJETZ2v18Ar9VHokyjoti0CTcj3us2kJWlTm9GIpAZkYyiKVBUm15nMzq2A7VjUS7Yxs55YC4wB7rJMmGUtGliNYAihg>
X-ME-Proxy-Cause: dmFkZTFNM+RBmc86Z+fyMfo3xi70HWdJ0CvF2GZIfayFihOVuScaBomXDUgmbUyMYdhUBK
    PsDEXYnwKJSbNtBLqyp1waCpCMcxFIez1r1IH053RW7jSiC5UhnGLI1BTN/Pyocy+FX6Vh
    Dfq2aLBlgpckYqIXVrp6si6z/hEwep4MgWq1eN37Bvg0TZYNqOP7aVWfN8Rb/uysS34qYy
    DFfxVih+d7mZlCgN7GPh/9rR2JoL93Esnl9xXSiES06aVJ2/toHiDgF0/4AxAYK8/7wgyn
    epjzpyrxNWYomygndnV5ATlMLdDT9i7z7DilWAHXiI2zUrA+XMMvAc9f9uyKIBBzSQ6tF8
    N+GbZ2Py0kTFXCeqOvxB41jFniv6LlUfQNKXTmMVknlRmfkVl9fnJ0oklYSK+aBRrChbu3
    4hPzdxquGdduNjhnUJpYE+e2S6KhhObEcsW85vOruvyOFmluh5CVeoiEDPiY9B0BG0dmh9
    odG0o9ULrKVkoRAKnJpxVF2NKA3PSsNgn2Cmd8mIeXLm//CD0NDOiuGGEcUZ+2TLsrlwuR
    rjPL5ASvXq5HXuMpNV+kJGX8TIMDDv0Z4lGegHs+MDPtpsRVP5ePzyzOJX1frFMYSM3TXk
    Vm3UH0mWdPKXTEwypa9t72DgSZtnnWAZEoHmuhMFzrrolORmL6jPLJyq17TQ
X-ME-Proxy: <xmx:VRp7akPXVoX-Vo5r_jo50XphuGIajEzC9bSgnejAYo88tyDVq4W-Ig>
    <xmx:VRp7akYPZQQltVHvStatc-RPbNyQuvrBelppBCBpikB6SgeXnnpRmQ>
    <xmx:VRp7aq2y3sHbWG9IFum0Ns8rzIprpZ2Dbd1NEqDE50F4EeU7XH6vgw>
    <xmx:VRp7aieVwOVOCyRcY29ZpG_CE2SOWfTxk2FRAorGXPhmYb1OHxKQGw>
    <xmx:VRp7atYD_zsdmABYJXfWLMsHyadKL2XrEa_D_YlaGzVVypWPzXYJXFLc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 08:49:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 94d91b05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 12:49:22 +0000 (UTC)
Date: Tue, 11 Aug 2026 14:49:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Emin =?utf-8?B?w5Z6YXRh?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Emin =?utf-8?B?w5Z6YXRh?= <eminozata@proton.me>
Subject: Re: [PATCH v2] stash: add 'reword' subcommand
Message-ID: <ansaTmLSGUjWegFG@pks.im>
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
 <pull.2180.v2.git.1785149687514.gitgitgadget@gmail.com>
 <xmqqbjbsmkom.fsf@gitster.g>
 <xmqq4ihjf7ds.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ihjf7ds.fsf@gitster.g>

On Tue, Jul 28, 2026 at 08:42:23AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I wonder if the reflog API needs to be extended before we can
> > implement this properly.  I imagine a set of functions like (there
> > may be others)
> >
> >  * refs_reflog_replace(ref_stash, idx, &reflog_data);
> >  * refs_reflog_edit_in_bulk(ref_stash, num_edit, reflog_edit[]);
> >
> > will become the foundations of such a feature.
> 
> On further thought, I think this fits pretty well into the general
> architecture of the refs subsystem.  Both backends would need
> refs_reflog_edit_in_bulk() in their vtable, while the single-entry
> edit can just be a thin wrapper passing a single-element
> reflog_edit[] array with a 'replace' operation.

Our reflog interfaces are still quite awful, but they have recently
evolved so that we can at least batch-commit reflog entries via our
transaction interfaces. They are still severely lacking though, and I
haven't yet had the time (or motivation) to improve upon this.

> If someone is interested in implementing this, there are a few
> tricky details to be careful about:

I think instead of introducing the proposed interface, we should first
investigate whether we can make the reference transactions more powerful
to allow for all of these use cases.

Thanks!

Patrick
