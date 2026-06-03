Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2A91B4138
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481210; cv=none; b=WXjbYpZzgdEb1FcFyPExPf8l849LiMs/Gnl+kUVHN2Y6fZdvh40TmH/gtmQcc9LAJO8VQPp4N45FggExk5u8jpJCSj34HLruG2dpywoX1NhMXRFlkMxUbQmioI8iThKu2dsN/Sq0fnhYs+Q/YPrv6bjtj+VDMKQL87TBYnq9hYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481210; c=relaxed/simple;
	bh=EjzUxAsTJUYQrh8V+ADGQ6Gut7e3LAV5ifclhgMU6O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkZNPLkq2V/4dTTYe8Lq5llZHEm1E0FAlB9E0l8GuHR8dXFD7MUAaL/kEnJJsZzGuU9slp5B/YcCQQaOH+6LCKKmeGDCZlOpm6+uDE6y9Grl6vGexhr1rnraR0cf1F39sCPbgGei9EzaPHOOVWrrDTpVQy83Lg9iNsSx5FhloXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qzdqR39Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dU4aW1AG; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qzdqR39Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dU4aW1AG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DDEF7A0090;
	Wed,  3 Jun 2026 06:06:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 06:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780481208; x=1780567608; bh=EqVL1cwZMY
	TGLtQLVXm6xff0/njimfVi5YKhFnhkgww=; b=qzdqR39QGQQKkqN2Au0rITIpMH
	nNXXgDtCT3+tESCLB9OKDFpWY9k8EP4hm2COtb1ahtsX54BXBWMUvY72J/JZGrj9
	Q7FOwoTPoa85ajoHcEWiwISK4i3gJgpLq3RXViOByeXH9hX0fmVoQ6RanMZSsrnD
	GuUN8QMzn7jvwnvBxTtiBYlb5DBd6AfmY5ed8/oc8zGEykTMQA3MCeP2Ee1zfD/c
	cC3Wirfw972OzXEdCly/jAa7N0iEXd/Se74Wt4hoPZ6eVmr35cHg9bJRE/TJUxsZ
	E/lYz5/K1KXBJOHSMwU8YwMecSzyhe7kZwRNqn1AL71fXMidA0ymeKRgZgrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780481208; x=1780567608; bh=EqVL1cwZMYTGLtQLVXm6xff0/njimfVi5YK
	hFnhkgww=; b=dU4aW1AGCtoB+FekqNaD70+M5qQPDE8S4RrkcvkdNrRppU9z9q4
	YNZar77vlmjNNz6ih2rhZ0C+1in4HvypuYTnt52L6i3ePcOzJEbB8pkt2mtUnPlq
	/VS1Vo65u2NgPj6izHSr8S/Jhvo6GADFKIALgGeZTDu7vrqJlbX7N4Tt7YNt4zsk
	6v/bpizlc9LioEQTCy+VXuPrvcNaF/eYqZFY/hg2PoZdFovPJVT7GK6tedzCeKQp
	/clMi++i6fi7MM9lJkrx9XDid+RvPByBYZhjfEjbefQmdHLaFSFTjw1ZXR0rrqin
	SeNSJlahf4AtxFyFqSRZ2kun951/qvqCi2Q==
X-ME-Sender: <xms:uPwfaiAfhIjBk7Vz0j1-WtC6WCKMcZfSwAptABTb4hUY8J45EMebMg>
    <xme:uPwfaiigSx598qr-ocplxME-KBw-SNuJHf-HKISKvp0mAW9InJL54q8n_RNFVnuyW
    NAWyQMQlvOOX4FFX2h-FTO3xwJm7JpCLRIesObYWIVA1ugqFKBf4Q>
X-ME-Received: <xmr:uPwfajMXQGGheArfx6pnkqUi4S77qBX-eHELRgBJ7UepUw2fNA2HFm2jEYnRpvJyCpWtDT4YiuNE16GUWeoXL4jXj8UogfMPvozMPHYkCHJY>
X-ME-Proxy-Cause: dmFkZTEP55kv7kb0CuJwUhQmnWjyHok7P7aJ6hZ3R4AtxUcaKNcVvewqz03UikEbLajzAO
    wN9CcLaDfX7erawAsN3ZB9Gqy4X2iWBhFmy2l2xKrsz1dnH3WyGd3fSisrNOseqE1kkUGr
    CPpD6fTx+8MDbbtDnQxYnvTJDLAt7qMukaBzuL3b0+fXI9M0hS/irHjcT+DKihDYUDOFWq
    VBOH13BBe5TrC7ktrDzt7Fjj959P3WoDrUn8vzrsjChGCC/6tebVFlH99lHHT6KKgdj6+P
    AHjNnvulQev3yA4p/StvTZ/sM4PQOWlAlozlofAu3CqDFNqQYvPmE/UTukuIplVdIYAsIX
    oHo9EhjpLdE7QLzRxL04pT/c27Iu5TeSpABTHzOclq126X1f4X31tjMchuvPjFGnztq/+x
    FtzyRrHBB6RsitkDd5T4fuaASJWxqtTAXBji8J1TpeICrlMgwT6BEXhQImWAD8Vfmyo6gU
    pRaecI1ou+S098BVc4tldKg9RUj41hSX9F4Jt/MKZv/aXxsCP31ZKuaSb6Egjp90Mlz+Dq
    5JGvaV3A7ohx3aQ+qOpLJk/QGrqw6VRX0KIvWCTcnQW3c1r4ADvybLpB34EKgwbu4+K6Ty
    l/I5DAW5F6CdltM1O/XFVWKkVYEtjvj6OIqCZmH+A04ycgUbBoecztGeUqXA
X-ME-Proxy: <xmx:uPwfar77_8H34v6C_HiPj0aMnpyh7x9PPAHbaFUBHbqhvsXjPjFnKg>
    <xmx:uPwfap1hGVdQoDIx9oRt6js_aSSi8CjFmGhuN7H2eVJ3uQLOFUPR3Q>
    <xmx:uPwfakaJ1aPrGvtYleoQ_X6AkGcRDk4nui-f11LTjpQsXbvZS9CihA>
    <xmx:uPwfapAJXbfD4bXP8Uge6QXEHDkyJlJtx8cux3dFcq8UNeOukFx82w>
    <xmx:uPwfalY999OsSbUw_tM84tWgOsGwl8Irkf7BnFmMfKvB1sP2bZg6EhrH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 06:06:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33227626 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 10:06:46 +0000 (UTC)
Date: Wed, 3 Jun 2026 12:06:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/history: implement "drop" subcommand
Message-ID: <ah_8s1Q1Kg0dgw6a@pks.im>
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
 <20260601-b4-pks-history-drop-v1-2-643e32340d55@pks.im>
 <xmqqbjdt25e3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjdt25e3.fsf@gitster.g>

On Tue, Jun 02, 2026 at 08:43:48AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > +static int update_worktree(struct repository *repo,
> > +			   const struct commit *old_head,
> > +			   const struct commit *new_head,
> > +			   bool dry_run)
> > +{
> > +...
> > +
> > +out:
> > +	clear_unpack_trees_porcelain(&opts);
> > +	rollback_lock_file(&lock);
> > +	release_index(&index);
> > +	free(desc_buf[0]);
> > +	free(desc_buf[1]);
> > +	return ret;
> > +}
> 
> The function looks very familiar---anybody who wants to perform
> "checkout <other-commit>" needs to do exactly the above.  It is a
> bit surprising and disappointing that this topic needs to *invent*
> its own helper function and carry it as a file-scope static.

It certainly is. We basically have this whole dance in ~8 different
locations by now, and given the verbosity that is required for the whole
setup it's a good hint that the interface is not exactly great.

One of the functions that we might be able to reuse is `reset_head()`...
goes down the rabbit hole... ugh, this is turning out to be somewhat
painful. I'll send a v2 that does the whole exercise, but I'm not a 100%
convinced it's the right thing to do. There's various assumptions that
we have to break:

  - It assumes that the index is always clean.

  - We don't have a dry-run mode.

  - We need to stop it from updating any refs.

  - We need to introduce another field to let the caller decide which
    commit we're moving from.

So I'm 7 commits deep now adapting the function to our needs. But maybe
the end result is ultimately worth it...? We'll see.

Patrick
