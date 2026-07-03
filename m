Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C283242D4
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057343; cv=none; b=aQO3mptIse2VTXKrs8I5qhBfJPRwdWwgke0SiKQyrch5BG3FofRlF40sq+e5s0tjizputX9IwyIJf2qSe52XzuxRIeCwp6/jPa2n0vHIGGQb/tF9UUSZ62NFf5QAf4eMZG3sjLBE/EwsUobPQ0rezf8CAM7xc8nWBQRlSGpZVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057343; c=relaxed/simple;
	bh=e1FkA4tE8EmeiozOFxlGfdmeh9D3Nv6wn3TUkW+I+DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo44gyOIPXVuvRY3+CeaSmbjidUhgb29jgXrCqe6IwCPrelhrBKWHrDT28quu+dykk8gYSw03+0c18jUPlxPjXe0LI4OFEC8HzAlwmrVamLYXEUMwFQ9pLYqrUTnUXk6JMmQYE7weXSBX22Lm7qVZWZeRyDxZ2plF5P5qKbTQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Np9l1mcf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5aCdtBi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Np9l1mcf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5aCdtBi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7EAF37A0062;
	Fri,  3 Jul 2026 01:42:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 01:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783057341;
	 x=1783143741; bh=o1JUVtntw6eM/lOeQKbljoK/iZh7K+tLkyGba8Ak/es=; b=
	Np9l1mcfgnSoF++PdqWZzs8og+OYmGLAbpeRfHTjZqm+xSg7F2xhQ1eVw4Dpjdcz
	Z3W2AcWqX2fpXlXBxQmp9yVk5PKFa+/xJNWHtkUF4JBU2pdbd9SdnChXax/4rCZN
	MLb48GPvPkxXlPCN2Za8+MNtBblI4MmvhkTqTN6tBBoORUKYno/2yWalclIfpwhI
	ZnS3cSgDuCCFZQ1eiiajCszYmAfz4vbkDpcD64ozlaQNLXFEaPVBY9d4OYYo8Ut1
	Rlvx+ecL/Gm0YQsplCjbpcG2+a0m++8q6/DWTRWF9GArbm6Q7lLk5VNQsKT5fBqW
	DMJkxjFMwM0uvZzc2Qs+WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783057341; x=
	1783143741; bh=o1JUVtntw6eM/lOeQKbljoK/iZh7K+tLkyGba8Ak/es=; b=Z
	5aCdtBiz/RzFzm//cVtfe8/iiiztY8Amo04ySO2YBZ7d0o8vWdmmTmSs9U3jrYAp
	YmpNAGHL8fWpI8qJ2+vI1wCJGkqvVOOVZ4vXnzlmbhNRwMO7X4aJMPPVXizWpnSj
	Rf2nKajWbdBoAHp2ARUhx7xzyVMDskBedw97PDlfRqJ/uMPW/yThsPm4pQf9DXxg
	kzVsgjOK2L5S1tq4UkevYD+FjV//Gn3j7eIRLiBX5YXhhZHrsesxt21M8RR79Z0z
	eJ4hxF3Rmv5XFsTpklpU+eFRZ1TkhQinZ9ehte9LZ/GNrV2Yh82B8AFOfCNx6dxT
	Oj0mCqWwKQCcSHVCLC4WQ==
X-ME-Sender: <xms:vUtHauiV9VnTru63Rm7_UwyVVrAbjsGE1TGpgCwnIvd4ie_7SXu-Vg>
    <xme:vUtHamAETrebr-xCqh8qPSvRxNhA26vCtq-XcWlcfbCBCJag0trPMiDb42oaKulQQ
    kar9Bj3l_bcLSBfw7OGob6WGw0uU4h3MdknS2pUaqcXTcG6sOY>
X-ME-Received: <xmr:vUtHarEqkNpSsMgoRo7PaRG2N3vzffq2zld_VPTbnEZZUE3aF4ksXjCYAS2eOVXu3eWO2ZwrWPYoK5EHxaV7vulIww6a95kdDOKlD-afPg>
X-ME-Proxy-Cause: dmFkZTGWuazHlERYkLdR3R2EWUQVNHR60S1SwQyZD0hlld9O9Dtu6rikGIoFQBz029lc7F
    kIHRwGd2eg+wzmc8oMkU0Qy9fkgmd9k+15zKSL4TKDojzeOBpTd7RPt2JvKeNJTSETu3NS
    tGKtrge5YzteUqJA5kyz+I/8/py55tVJq3wP1bltB7PFJYQjCKJIjrWOEonWQ+88tJ0yLd
    pLginAZ2zqsijI0LD8zSYDBbvlPEsdi2/k10AbBbkSjjf9RlOva1rXASBAPFofDAb6qL7N
    eK4fSZO5ObgVzFhtIfUFOZ2893TNQn35kPOgARxhrRweZSYdNCHySs0swE8JXgG0fUFmaL
    /YivoSGJZkQP9gvwIhA/R8t8SAMbYVB5ryAD9O27as0USjYVs9nZ+GIAW2QbYcR6Hx5qaw
    mPf69XnAyAQhF+iOq/Y1oM70oXVOk9U4yxsE42mMzuzzB7awZnKZUVInbXfIpnLkPbifiY
    +5R2rdwlidZWuNi+UeP00y3qvat70iKBDk0iqCRXvDbgOt68xQ4bl6v+q0BT/1VJPeHdS9
    PYN2aGIyUJ1/VqzxkK1TevIWsPeuG1NRP8r7B9Ys1xL9hOejatkGgXPepJjXlVqbbAcPT+
    HleGgmGj4KHA5RLK/AoumVsI2aWajE9FSJSTms8zQGJwJkzjNTZ78DbyygDQ
X-ME-Proxy: <xmx:vUtHamJBCUjYAeHLgh__bDeO7t2nQz3JJj_2a9M-7BFuufTpDMhpYA>
    <xmx:vUtHankYSOy940y0WEDX9xfuyb8SJOHJg8H1dGfJA2ji6ZnyZHhG0A>
    <xmx:vUtHamRv0SzqFoLBx6a_2qX6jSXONkuliyA2qTXpSrLiCg3GQo0XRg>
    <xmx:vUtHahJZWy__SPWzpBiVVBjC6B3rr2u4V9TVMVQMKGQPE0E6TtsZMQ>
    <xmx:vUtHagcvm66fwos4RxXJ3HgiR-llk2TMlwBK7S9sy14NOf5HsVYHrZpg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 01:42:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c546c23b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 05:42:19 +0000 (UTC)
Date: Fri, 3 Jul 2026 07:42:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/9] t4141: fix inefficient use of dd(1)
Message-ID: <akdLuICaYO5Hqd45@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-3-76b4d7bab3d0@pks.im>
 <akakvnoAswZx+DNI@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akakvnoAswZx+DNI@szeder.dev>

On Thu, Jul 02, 2026 at 07:49:50PM +0200, SZEDER Gábor wrote:
> On Thu, Jul 02, 2026 at 02:00:56PM +0200, Patrick Steinhardt wrote:
> > In t4141 we generate a patch that is roughly 1GB in size to verify that
> > git-apply(1) indeed rejects that patch. We generate that patch by
> > prepending a patch header and then executing `test-tool genzeros`
> > without a limit. This causes us to print infinitely many zeros, and we
> > limit the overall amount of generated bytes via `test_copy_bytes`.
> > 
> > This test setup is extremely expensive, as `test_copy_bytes` is
> > implemented via `dd ibs=1 count="$1"`, which copies data one byte at a
> > time. So as we write 1GB of data, we end up doing 1 billion reads and
> > writes. This naturally takes a while: it takes 6 minutes on my system,
> > and around 40 minutes in some CI jobs!
> > 
> > We can do much better though, as genzeros already knows to handle an
> > optional limit of how much data it is supposed to write, which allows us
> > to remove the call to `test_copy_bytes`. Furthermore, it has already
> > been optimized to generate the data fast.
> > 
> > And indeed, doing this conversion drops the test execution to less than
> > a second on my machine, so that we can drop the EXPENSIVE prerequisite.
> 
> EXPENSIVE is not only about execution time, but about resources in
> general.  While the modified test finishes quite fast indeed, 'git
> apply' uses over 1GB of RSS.  Therefore, the EXPENSIVE prerequisite
> should be kept.

That's fair. It's questionable whether 1GB of RSS really is expensive
nowadays anymore, but I don't mind reinstating the prerequisite.

Patrick
