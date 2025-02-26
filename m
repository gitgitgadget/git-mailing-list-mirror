Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AE92561D6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607642; cv=none; b=gm6LDH4VXVRDzrvnVbMSZ/ebCfb4U4f9YAm1SzdL9+vHZKF/LtnNnOpFZkRSjLTUsOVvxSm5zm0vlTmnSekXlurCk0Ui1rC4aPfZYTgiw2o85PTSiQr7xpfgaoX5SL/j1RTXR3+baMbxSQK5TkJ3s3XJScdaEPoLlO9oADT9ArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607642; c=relaxed/simple;
	bh=PO+T7Tp1VRvWir+iPznBv0xKqgAYQ2PXruFfINLxkzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEv2h8phtknJgzNM90mTpOhHEoEnu6KyxJWM8YjBmWSYC4ByVR0PUm9JRmIssTr4mJdXEyHasOl1EihTvoqVE/rgHGjCOXzafii+T2yAuE82uUY25ZYvcpc7Ns2JZ7pyk1gxRVwsjwsXOpuVBRTjEUF94anNtz+cAtn96iX7DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KQI2uGxN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KQI2uGxN"
Received: (qmail 12934 invoked by uid 109); 26 Feb 2025 22:07:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PO+T7Tp1VRvWir+iPznBv0xKqgAYQ2PXruFfINLxkzU=; b=KQI2uGxN3tGJehirL+GfY1vO82RhEp/spRZ1Rr8vaihxhJj4nA1L8rYZxGxqvbinQoiaqk/M9G6X+jZfdzSbFaOwAacxAwKq38OD7ppB4W7/OinNEHj7GYCM5muvG7uhDEbeyVQJiVYJdcadnV3RbkyDhoSjv4hzjgMA2BG8SUsvAocJg2Y62AKJihEQe66nsiGD5V6quZVH8c5JFXXySYpTjCNtU2D2g5ljg8SxfHEDcgG5ukrId9SlrG8v4zSXH9XV1hHuwO9s4mJgLnk3SxPHdQ5xgwmqPVHk+h6b4+8vuGDsf0b6nGf4jdCQx7j0Rne74hz8MD+QVJpF39ujMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Feb 2025 22:07:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32293 invoked by uid 111); 26 Feb 2025 22:07:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2025 17:07:19 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Feb 2025 17:07:19 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Message-ID: <20250226220719.GB600528@coredump.intra.peff.net>
References: <xmqqo6ypiz9w.fsf@gitster.g>
 <Z76qYgV7B2eUJHiP@pks.im>
 <Z77EJRJwPDGUglLk@pks.im>
 <20250226074653.GA27455@coredump.intra.peff.net>
 <20250226082002.GA30633@coredump.intra.peff.net>
 <Z77bxuad7pFsz7ow@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z77bxuad7pFsz7ow@pks.im>

On Wed, Feb 26, 2025 at 10:15:50AM +0100, Patrick Steinhardt wrote:

> > I'm hoping you can tell me I'm holding it wrong, and there's some way to
> > do an incremental build when crossing these sorts of boundaries (without
> > blowing away all of the build products).
> > 
> > I do at least use ccache which makes the "rm -rf" case a little less
> > painful.
> 
> You're not holding it wrong. The problem is that this patch series
> introduces a backwards-incompatible change to the "sane_tools_path"
> option as it changes it from a string to an array, which makes Meson
> hiccup. Once Meson is not considered to be experimental anymore we
> should refrain from changing option types going forward, but until then
> I consider it to be okayish to break things like this.
> 
> From my point of view we can treat Meson as stable as soon as Git v2.49
> is out. So from thereon, I will make sure to not include backwards
> incompatible changes anymore.

Thanks. It's comforting to hear that this is something that's under our
control.

-Peff
