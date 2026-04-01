Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562763F7AA0
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045645; cv=none; b=MPyX5XnU76r7XWy6pI4dL8zr3ozpFSheUDp/OiLdT7DA4+QpJQdyBwqXnfJO6F47lgYvbbYPt+mCUK1rRJ5JHFMbjDheRiMfbmuFk0+NWNBwECFgrVWmBSVZ2lc7T/yE72t6UmhZFgzsDx3hGPZqvQT7p5WYSzYpGtWNl/kGXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045645; c=relaxed/simple;
	bh=KiOkRySfYqXuqnwC+BVp2AMsGM5kg53GmiPnzl+ZtjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzFWIOCUYxjjiBuUOIrWB/+2mxPUOmEKjJa7BQsTx3CR8MnWINeLSdPbNydP/CjTyAH+3TRS59ZJQ4SN6hW9Mcf0eQkpEmTkUbrycIOtvppgGKbDa7vAsGLEbZW/9qDKj/F/VGgQNhJhckDTn+wnd4fGmDsuoCM10ryE26iMj8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GcRjEmGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rrs143JU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GcRjEmGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rrs143JU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 912C91400091;
	Wed,  1 Apr 2026 08:14:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 08:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775045643; x=1775132043; bh=J/Vl9wPn1B
	UYEloBqeJJ3sJNYrldsY1l6y3p9hvnEmo=; b=GcRjEmGKa8rvbV0Qj/XE/pJiyv
	8ACMet+H1SoxW1aEQHA2qGB2+Dllqs3ONkRN/PmJvs5oHKYbVrh226iaY9AbKNri
	GETHq3rbLtVyATxBDtlnzyPwclAGcUPYyy+3DYzohVNviEZwRfy25jV6htrSVaQ/
	mOYjjm6FyalcpvhcrSGD+ziM3VuaJz6ahzi5Bw+hkbLI4jHijIXgbs9hJOp8rknt
	TRCflPx1namxotYddhQB+xTTM6tKN8v9Ae5d7A3Lr43uZTqdDNlN2gCpaSYYE5/7
	7OsrX96eDvT/GDjFmXzGMY6Dzv/WNYwnTpONuW1UrAb75Tlar2zriP9wKplw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775045643; x=1775132043; bh=J/Vl9wPn1BUYEloBqeJJ3sJNYrldsY1l6y3
	p9hvnEmo=; b=Rrs143JU7CmOX/fNCXJE/+fBkYzieWvo+bNP02VcIZzV310iaP2
	NvoagIP6tPyuTqukD0Q6woP0zZ7u/uRa0C4HL0f2SBBnrO3GiEpN9QOk3dfUvG/h
	wqU5VHeZweccbu9mvUhCyJN++JBlByNPVpgN3TTBJSRrY8O/Sw6vSvQg5AJYMG1I
	4dLtIc6JpWIQmwOuaptAH8v8TpotLaCENKB5qcxl2oWKuJswgxpBcN6OQVe+0Urg
	LTOruc1zR/rN0Jjpv5pPoJUYkYvqldF9f8dCYE5SPaFKdYDxhOfeuOsEbKJqgQNx
	wXXqoF36nhcUaA2pTxdMVOdFNwF600qc4Cg==
X-ME-Sender: <xms:CwzNaT-GbTJcYGJFUHhYiuptxbE1SKHVqb4XAERIjM_tzoOz-pIvDg>
    <xme:CwzNaVti5hubCwFYTr0DplqdCirZxXDSCYjzdd4ee-ebfOjbwIiGqHnLM2lopPydv
    Ln9NKdA8tOh62pFEArFH3oLxiR2Z8FQy2Jx9o27-pdbdSLiVBji>
X-ME-Received: <xmr:CwzNaeqYoqdhd_vUwn_7716imWl8YCiXYVM-b5O_WnG3aK3eNa112Sm91RHIPTk3pbJXADhdtGsNbgDnpcu_n7WYu2_ekAf_DSX4tzbC0lY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CwzNaamgL4FukqDWh5UXZQ3ouFDkhtlWnuFvIT2J9JsIF0YOTfXykA>
    <xmx:CwzNaay7MV-9HYDWmVL-z0ypWWll7jYZOHDhI7UxZ1oTl-EJKLAPnA>
    <xmx:CwzNaalb8f5hg_YYMNmvF1-p6M_V6o6DzCfKyhkrZvGyQFIkbP7xRg>
    <xmx:CwzNabePfk6GEf_IXOGl6D3cX-wYL2lAjF7dtgaw7qBpVt3jO_yqhQ>
    <xmx:CwzNafWfVZx5dTl5UPbYEZrwiXFHtdVCAu-5fzIwHpnsl3zsyRmyvrsh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 08:14:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 017fc3a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 12:14:02 +0000 (UTC)
Date: Wed, 1 Apr 2026 14:13:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] reftable/stack: don't call fsync(3p) unless provided
Message-ID: <ac0MB8O5h7ek_8ZX@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
 <20260331-pks-reftable-portability-fixes-v1-2-46bfae55c68c@pks.im>
 <xmqq5x6b27ms.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x6b27ms.fsf@gitster.g>

On Tue, Mar 31, 2026 at 11:09:31AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Users of the reftable library are expected to provide their own function
> > callback in cases they want to sync(3p) data to disk via the reftable
> > write options. But if no such function was provided we end up calling
> > fsync(3p) directly, which may not even be available on some systems.
> >
> > Drop the call to fsync(3p) and rely on the callback function
> > exclusively.
> 
> Hmph, reftable-backend.c seems to do
> 
> 	refs->write_options.fsync = reftable_be_fsync;
> 
> in its _be_init(), so this change is a no-op in the context of our
> system, so this may be _safe_, but for a caller that wanted a fsync
> to happen, returning to it without doing anything may be a bit
> unexpected.  I am wondering if it should be more like
> 
> 	if (!opts->fsync)
> 		/* BUG("whoa where is your fsync callback???") */
> 		reutrn -1;
> 	return opts->fsync(fd);
> 
> instead.

Hm, I guess that's a fair concern. Anyone who doesn't want to fsync can
just provide a no-op function, so it's easy enough for others to stub
out while being safe by default.

I guess the only question in that case is whether it even makes sense to
specify this as an option, or whether we'd rather want to make this part
of the "system.{c,h}" interface, as well.

Patrick
