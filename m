Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086325B0BB
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104483; cv=none; b=CZfM0OOcujP/1RhwbGa5IozQVnX7IhtdkGMWKy6wQ+RsLNvbrDOOKIfx4w3KaiiYpYznuuCYBAeNueoDd/c6WXsnGEVL7AB+pjEOBU3gg42SR0CSA7gzjq+At7pD23HGZ8HTDP8KdVJzjYgt+TYhvyMphLYqswhV84kag+DtJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104483; c=relaxed/simple;
	bh=1CKFbXb0QDXE0fPPvMXQeSNEaeioKJQpzazMFQeB4Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkQQFRzqq3bAteWZ2XAw+6WDEAOm138hK6Js8zyEyUcY5UbWSFUaJiApBJKffFNfhZk+nUgqoS7I9ET7QzIs02sbpqAQzhoe5ALT0fujbHvWRb9/vuOfP8Hj0yVKiIWdw4nfeXVnA9Ra8LBtzIaKzFEyEOh9JEtsQDvQLnyMbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lydKZHEA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWBfQ58e; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lydKZHEA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWBfQ58e"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D6C311D00072;
	Mon, 22 Jun 2026 01:01:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 22 Jun 2026 01:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782104480; x=1782190880; bh=IcjQypl4fc
	1JtDHEF0N+bVgwfPVTZedLFEwlAEO1urM=; b=lydKZHEAF1cynU4spCbE7yUEOy
	SeTpWnu4+6hUgHpYQlPrEZIEbswYie1Wvx763gWhtUCpGD55mUr7QwXaB3BnplTr
	sYO/FUbC3t6lJ7i9o3SxqaKfFyd3Vj5jrzHICCFnZOgP9pwmFcoTO8mslgzcpeXk
	Wg35XhUlk+ni+HMEtvA2AUXiU7rATaYaijukJ0nw6Q653e8PZbWbqdOGLW+mxh/s
	rQPM2T5ToY7hqRrut7CIf2qlNX4hxJQlQmDcY2/qsCbUfgGNgH0m7sbj1pfBUszt
	9AhTFUTm9TYpGmLtbboD1F8u3kciJMXge8y0v6d73opWkGetmScoTajPICJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782104480; x=1782190880; bh=IcjQypl4fc1JtDHEF0N+bVgwfPVTZedLFEw
	lAEO1urM=; b=PWBfQ58eg/cPx11ONESfYQZAGiJ6FC45NOv6wq2q6zNLGQzjr8I
	MaD1wJPiiId8Kr0A8QbvucjH2if7BYtQXOyvbjik1GsR4qB0CCKEddC5L0NbifUz
	wJr6PtuLs9pmE8+ar8RVKoOhoc0zOz6QC6OAGpy5ooJK2Fv+uVRB1/57VCHmaC7P
	kVqusSAN8aAqfTsiF6mF1J1XWt2KkMDwdM6nMLUISubPa3FqwK8VYupsbU9hbPv3
	HE1XLNernE5A9WgANA7rKjDhgWKhGBhfqxyQA7I5dnhi+E4vvJni8tFWqHy3MZ/t
	Yx33y504MpC7D6z8yNh7FIPTVBagY29n6fQ==
X-ME-Sender: <xms:oME4aqeJ26dM4-z9nckcY59cTGYzE6GlDn2Z28GaG5bLthHMmo3xpg>
    <xme:oME4arGMRoky8uRRoLsOfDmT5DCukrPVVjnXl1w00GHgU74ht32vjj7MmnI6W_v5t
    7FqSKf_Y489hBLBG_b76EQnw4r_qbcyHu9EhgzMNv9OFeEFAqKHuw>
X-ME-Received: <xmr:oME4aj2Ar6nOHi9USR8giALJg5V32MxS6KxI81R5McgI2ETGTFEb-AmM1YTXLM_RB90UGJ9WiOoEqU9lgktZChRZoxHCtBKQ9ZCcwx2C5w>
X-ME-Proxy-Cause: dmFkZTE4ITkoJnjRXmRIeNAr3iCykdmT1ZxgGlULAmyJyydRnjZi7rbAirkH9mv/6jpInr
    vBHjGAFYSLI7jiMlj5RzSLCuPvUtM+6TtK6qZcrR6X9r6VPDoAgcwpQQ3a9K0kUnifXFfa
    uu4PYK+oOlvp5SkLrolzuE3D4VWZT/VWaS12nRqIUXEzyl9BLesDSrW/ulP3pl4NsWiUee
    AMxTIaRe66Cyr7JFDMlAFGGLUskk8TBdF8PS+z12sN+sBPOuRsEKFkA48tk+5rOU03HNPf
    jsweaHfREnDOkkhnX4fbMn/ticUHA3cUXqSAedTKxvoJtsz5azCeT9W4oggEgSVt4l1nGT
    yFUBUSh8HDobzeVisWiHaZuLRJlAS4f2VjKsLr0suVNaDHo0y1tmSCFVh3BkwGrrCbwncj
    JLlwtjYxUQYaia6jIMcXv1L7XFbntAarl7Dr6k5odG81p/cDIAx/clmZx3HZuG2O1vbF0s
    J/6xE9re2pqNUcVuAixDg3waCR51y1lA1lMLc7C+QofdjQdjcCRfC5tc12c01xSQpGEpm3
    xGqOrW3GOI8xqQwBIJqZARhlX5TJryFjYo07K3+q3uFPHl76NVDznwPWx7iciofiI3+h82
    REAYEuCoF25LmTVvOCcF/MFf6DTA+0UZSy2lfiD+iYb6SGotWy0s8EezWFrw
X-ME-Proxy: <xmx:oME4ajmSzZCs9Hry0tbN6_4vVj1E5znAbOtgePHH4FyvgYEEdKnmLQ>
    <xmx:oME4aj81iMgJiiaP4Mr46UiYKUnHXlYulw3lWrO9wMiWe2tFxMB3-w>
    <xmx:oME4aoqf5X139aTNTZEu0nb1v49yg3_HLngA7wSbkcXAxkyOfpTKwg>
    <xmx:oME4askxjP3-Pjzz1qvkpNhEzTL6EeQ9yiBiOKSnHXnLLMSdnAsK9A>
    <xmx:oME4aq2V6nUPv0l5KfdAFOTnhtB6gJSELMW78ZTbA3j-X68v3oxqohtc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 01:01:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e64c5b6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 05:01:17 +0000 (UTC)
Date: Mon, 22 Jun 2026 07:01:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4216: fix no-op test that breaks TAP output
Message-ID: <ajjBmi39IFJW5p5V@pks.im>
References: <20260619-pks-t4216-drop-unused-prereq-v1-1-2ce0d7bea088@pks.im>
 <ajVMZpjTKiXc7TRe@nand.local>
 <xmqqa4sqlchz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4sqlchz.fsf@gitster.g>

On Fri, Jun 19, 2026 at 09:29:44AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > Given this and the above, I would probably err on the side of
> > designating this as 'test_lazy_prereq' or otherwise silencing the output
> > of 'test_cmp' so that this does not taint the TAP output.
> 
> We can argue the merit and demerit with a good log message.  The
> central issue at hand is how precious 52a9 in the script lost by
> this patch is (in other words, are we checking more than "is our
> char signed or unsigned?").

Ultimately, I don't mind much which way we go. But if we want to retain
this, would you mind sending a rewritten v2, Taylor? I feel like you're
in a better position to argue why we should retain it.

Thanks!

Patrick
