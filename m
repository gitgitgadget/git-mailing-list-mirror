Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8BA3D3311
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513327; cv=none; b=jN9wjChVOVT0KSSlp1Pe1aLi6XD2UR0YiHXegp7fg61Kn25LcreXwcEIas+pHKyh/k7js2uXG+qT/WTF+HdngEodReGxWfJwJIKP76J1mQeHpQHQ7Ts0pBr5eQR4CSelpuWKA2T/XSPKWzft+deqRZ7S08nT0K2SezLstNqi1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513327; c=relaxed/simple;
	bh=Ud7oKejYD8i1iTjC8xZGD3V3HILthzCWgesSv6wb/gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7SWwpbqRjzLBZYSuwiitSNuhtpd8W0BwuRBBu1QfE5a0vEl84rLF9/KImYOcn8XVBScJCDSB6eWFJTFNydLWzm74vMN2dQ+ksCqt+9kuekhxubMBIjeXy5WKqtnRWlSjngSLzQZglfG2R63tgPvhW8kNoeLWVPuFzhSXTvR78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dQkzU8Zw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWAAiDdz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dQkzU8Zw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWAAiDdz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F8517A015B;
	Mon, 15 Jun 2026 04:48:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 15 Jun 2026 04:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781513321; x=1781599721; bh=w+TKdpjyh2
	n3JxfJqemLR+T4s/QgUAbYGoadmW7akBE=; b=dQkzU8ZwAWL0UiBlyHb8uKWv2A
	a3fP0SI8C8oaCy4crmraUFNLlX19zvSMpKv+1F/FHin7Yf6WuDWbNNP+ekPy9hSp
	1m9zcaRTEn9qg4m4aSCvBNPHVqZt6Vb6DqPS0u/8M1VTALCzkbtpTK97FnDDO/8S
	hXfNjkvGzrP9MdCUDn5PItgEBTLktR+UkUoYNfg7hvR96MTMF2gerk8vc2CdEn9b
	lQQLlvzBFPot+dy+R4dqzTig0W8Ib6Wf1jfkLlHr2eYrx2+37Ix8g/y9W6g0SIiB
	l/g/XwDh3oZccoqR2eUywnm69WYjA2bO4269w6d4oY4Ad7wrf6c6M+GADgXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781513321; x=1781599721; bh=w+TKdpjyh2n3JxfJqemLR+T4s/QgUAbYGoa
	dmW7akBE=; b=BWAAiDdzZvQApAjn4/cNjrPpcze2QvV65CzIpiqgsLw9Y6w7u7u
	egFAZ/XYrAN1bJHJie7bEmW5N8LRjDp71ey1I8wr3+3jPjHH9rYxB2H7p14vaM6t
	varD8W4qLdh5++AgCdu9/qfMsICOIYjHgXvSeWv4NFl8EUbpzAkGh/sl2D2h2Kym
	mAO2vm2QEED+jXXzo3cOsbbe3Ll9/RQ2RNLdgMjIWtvNsQOIoA9wnNKvy5iZBBOd
	hWaCNQH6wSmzOBETtTT/XkrO68lj9ReWUD2V88+hvS+sivXaTAxC6Ku9vLhpnDqV
	+7peilFjns+iUfS1Q6LSODbhR/SqC1r0BaQ==
X-ME-Sender: <xms:aLwvakd33q5hzukmBYHbEuqNva0zisvloW0M6O-Irfdsv0NG8vFLOQ>
    <xme:aLwvavgCRL83Pih59bBZL_mP-9XzjGUbVvbOMvwdIK_3rY1xG0fAViiw8PXzs2b_L
    _KO5BeEl2oHNbUFpq3Xr6ksquRzqSEnm7_X-TpAEyV1aWcJgR_1>
X-ME-Received: <xmr:aLwvaszitb1ivNcDp-ndf0kIv4L_eB0wq5lifm4wrxPDEvE2OX_SGgJ1nq1isksBjv2yAbasOsiEWTjdV-9yAfjYdvYU3UHih10Jiy56rA>
X-ME-Proxy-Cause: dmFkZTGnpM1w3LOWOlIe44uANqvbIojZQTk5Ew/li57jxc0mb5Y5L1AwlcPQgi5Hk0Hk6e
    2AbQXEp6nzZ4SAtBpcrO9Ix3GaoW2B9SnfPCdvRyqzYpmWFXhDdpey2ES8Txg9CW7q1Q1i
    y+wBhrzmR75OWAhUmiHeVpB5D5yfVOT13QG1+FIWbGWhxnY6buh/rZvGYUWz5ROYuR/Qp0
    wR3Ezr71wlaFK/az/eVF5sJWCcYS2iOMA6LsA5TlXZEal24D5KwJulSJ9LNJ3cIYyWGS2Q
    y3YbY97dry2aFR7pnQf1Cze4m7lGZ71GTprcHj7SqoDA8q1dMeCXetS6FrwGs2XjEOcqm0
    eVvGj0+3h2zqvHKDnvMlYLGWAW3Sfd9+pr5DN0Jyzmhu0hoHfdGLJKPJO5E70A8dMAshPy
    huVhxQVtOQHQxQgg0Nyt0zKkWEkrH2u96bOv0xeDz8CuASpax1BsFmLbzqJ4fnBysz6Fac
    hYYQ01/Q+NpboLk4gEzvZqy71U6kjiahyePYIhhhLM1wbDtJpkVIB0bX7ISM2b+rJQ0MCm
    WyCrImOXWcTNZWdPthYiz+TaatSChkKPjPiVBxAWgsb/ZGV/CcKPd0dTjt64nikv80Spi9
    wk+/bsSstms0rg4eWnns+mQCbgKDFev+sCVXMJuTg0fxvXnx55E4mFd96TCg
X-ME-Proxy: <xmx:aLwvarP3dLvNGtaBtVw4M44hx3eXx3oZ5ZdHhbRBc1_A2zpxguiecw>
    <xmx:aLwvatW_ZIhgRaEk6fW_0y7IkAenpPqdtV0CZf0ugZpURzOU9dnW9w>
    <xmx:aLwvav0PaSRUwaC3ENX5cGgjUQi_z9z9kFQBBb54N-BgimBd46jrfA>
    <xmx:aLwvarr4mPOrLZYCB_GUS8kIFMxSiSyj47aMZsaS_o6E4aTQukaN5A>
    <xmx:abwvaox6bNubejq4CzaEpC0AUtZw5TJZIWiqWuZUE0xFceIC-YjvsElP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:48:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f81daca0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 08:48:38 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:48:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Dominik Loidolt <dominik.loidolt@univie.ac.at>, git@vger.kernel.org,
	asedeno@MIT.EDU, asedeno@google.com, avarab@gmail.com
Subject: Re: [PATCH v4 0/3] compat/posix.h: enable UNUSED warning messages
 for Clang
Message-ID: <ai-8Y1r9zbWfdY8p@pks.im>
References: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
 <20260613122711.38662-1-dominik.loidolt@univie.ac.at>
 <xmqqse6qe6oo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse6qe6oo.fsf@gitster.g>

On Sat, Jun 13, 2026 at 09:39:03AM -0700, Junio C Hamano wrote:
> Dominik Loidolt <dominik.loidolt@univie.ac.at> writes:
> 
> > This series enables the intended UNUSED warning message with Clang by
> > adding a dedicated Clang version check. It also cleans up the nearby
> > GIT_GNUC_PREREQ() and UNUSED macros.
> >
> > Changes since v3:
> > - split style-only cleanups into their own patch
> > - fix the UNUSED preprocessor indentation style
> > - simplify the GIT_GNUC_PREREQ() comparison commit message
> > - keep the Clang-specific note in the patch that adds GIT_CLANG_PREREQ()
> >
> > Thanks,
> >  Dominik
> >
> > Dominik Loidolt (3):
> >   compat/posix.h: enable UNUSED warning messages for Clang
> >   compat/posix.h: clean up GIT_GNUC_PREREQ() and UNUSED
> >   compat/posix.h: simplify GIT_GNUC_PREREQ() comparison
> 
> Looking good and all the points Patrick raised during the review of
> the previous round seem to have been addressed nicely.
> 
> Will replace.  Shall we mark it for 'next' now?

Yeah, I'm happy with this version. Thanks!

Patrick
