Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6072DF12E
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846606; cv=none; b=l+e6Yiq++bsG/6lNOGYLi2SpsOSM+fvgp4mu8tlPCkbnoArSHtuls/WAdUcmf1dsGknleTCndmsbHaZbYxapLe6v0y/rizlnQNQKj4bW5lC0H2uK/7krDZCNttooPDdZ+4R+XxiEu4I71Xo+tEmCdVeGmavqb8yxfAAQ2SilCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846606; c=relaxed/simple;
	bh=75IhXYTzNUhoTWLsBk/plCztki9cmgRmfY8rpzCBEXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzhJlrXa2bVjky898POoazTinJi90zYZjmMFRNK75ijjBj199ENpX98E8iP/SBDc9fwbWtDpnGSwOcGcCVv2cP3Kx2N2mpXVH/tECk4QmzV32RtsQAw6Rsbt9qN6J935GCvBVfIV5rovBYaNHWPDAJofz2coGYSRUYN+kQN8V44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ndpKvgX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNmK3tbH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ndpKvgX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNmK3tbH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A63931400209;
	Thu,  4 Dec 2025 06:10:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Dec 2025 06:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764846601; x=1764933001; bh=pqhbNSDzsK
	pVFE0F9CW/jh1ZU20IXgi2ZlXvvHpGNpA=; b=ndpKvgX6gocCh0WtQUpdTs2dGQ
	4P4SP35jTmatqFLGJ+f1AFjq1wl+ad5Xsl6mXbYUGAmSzhLIKjsay0pCLmj94hZh
	6BoEiz3TJR9qVnAhdzD+KjFP2UNGrQswh4sHzr6QgE574secEiKL8qny9uVxW4Wx
	rIvn9ktWbZ23I+zM/iaS9pGP8oBsGWOe/35ExVFs1gZEqCG1IOm5e87zs3STbJCw
	GhAvDzGhFetrvF2L769Sq5LW5TJ1A1szSubJvHleAX8/BJgXn5YVOrxqXZMGxHuX
	hWEiLaJ22jG4oprKdybqf16AuRakAGAMSWAO4Iw4FjGwuJKMiblisMGJPQNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764846601; x=1764933001; bh=pqhbNSDzsKpVFE0F9CW/jh1ZU20IXgi2ZlX
	vvHpGNpA=; b=TNmK3tbHqEwzaWlOltzkWnCtHhMEUo39yHPjGiUxjNI9kRGJ4//
	CP4ve2sntNpreYphITEAXppnzWNV6L+43m3bjTs5kwTlgSepOaIA3EhEWQpLBY8E
	oWoGKuVr7Y3f1g0lhU05COFrsZ5vInTgKxYb7H0PHW4xWtQTYH+yQNmS05GMRsbG
	DrOQhloDg/Ll3p9dj7VVfy/NChNA94rf1FN8h6raDZd54Vy71Z41ghlsL/Lv4MPi
	2/I0OmKVVSxTTu1dzyiRRmr44xJnmzHTZERyj/AbU5x/M9AvG995jmGkxe+UkzYH
	ekklzQq2MkK0JsoWWDDxt5J1ksyPEQUe1ww==
X-ME-Sender: <xms:CWwxaYWbxoOHr7q5Z_PFisT5GIT4X1VXq0Czk9P_luORRVCtrp4iHw>
    <xme:CWwxaeHfhsXanIKI7iC5dhXPDUx3Mg8jNAT8CUAsANoFcA-UsHlTTTDRI84XSPgjI
    Wom2UGCZVPFF0ZVJujpm6RRMyGDQgfju_sBGNmZWheecCyEA2vZ8A>
X-ME-Received: <xmr:CWwxacc1E_5liXtVAKi0GG-ayPzt8Ktjk5p7r91nHq2ZVperGo_y7JcFM4ZpUD0fBbqhUQ98rldINFa0GFyU6SIrAkDvmS9qgv9cQMN3sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffud
    fgheetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:CWwxaXIJ75mehSEdPJe8Zw0lUtcsstGHXTaxVobn9BjIEBSuJ99AFQ>
    <xmx:CWwxaZG5lDRGA6xKW38pcg6zqG2LvujZT22wUJo56bjc3qR39E27lg>
    <xmx:CWwxaSCKKMnP180uQIwTb66nXnUtYBlfq35823bTcJZPGFDvNga8NA>
    <xmx:CWwxaU_qnnBuUEzIZF4U8M7DLUBTcYkUFIY8WYS6BGIN8iyyAolepw>
    <xmx:CWwxabYcAa1kzPbZ6WltTUDFJvVhiRln3Qboqze0LmMpAiG6ED2ZSPY->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 06:10:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f058884 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Dec 2025 11:09:58 +0000 (UTC)
Date: Thu, 4 Dec 2025 12:09:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: my complaints with clar
Message-ID: <aTFsA-jJqcRZJs53@pks.im>
References: <20251130131351.GA198697@coredump.intra.peff.net>
 <20251130131537.GB199335@coredump.intra.peff.net>
 <20251130134625.GA199421@coredump.intra.peff.net>
 <bd0a8a76-fccb-4b6c-abb7-b53dd890e9e0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0a8a76-fccb-4b6c-abb7-b53dd890e9e0@gmail.com>

On Mon, Dec 01, 2025 at 02:16:13PM +0000, Phillip Wood wrote:
> On 30/11/2025 13:46, Jeff King wrote:
> > > +	/*
> > > +	 * Do not use cl_assert_equal_i_fmt(..., PRIuMAX) here. The macro
> > > +	 * casts to int under the hood, corrupting the values.
> > > +	 */
> > > +	clar__assert_equal(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC,
> > > +			   CLAR_CURRENT_LINE,
> > > +			   "expect_result != result", 1,
> > > +			   "%"PRIuMAX, expect_result, result);
> > > +}
> > 
> > This was an exciting bug to track down. If you use i_fmt() here, you get
> > some neat undefined behavior. It worked for gcc, but failed with clang
> > (but only with -O2!).
> > 
> > Obviously this was me using it wrong, and the "i" in the macro should
> > have been a hint. But this invocation is kind of ugly, with the explicit
> > mentions of internal CLAR variables. clar__assert_equal() understands
> > PRIuMAX as a comparator, but there doesn't appear to be any macro to use
> > it nicely.
> > 
> > Should there be a generic cl_assert_equal() that fills in the first
> > few parameters but is otherwise type-agnostic?
> 
> Patrick's got a PR open for that at
> https://github.com/clar-test/clar/pull/117 it seems to have got stuck
> because of a lack of review.

Yeah, this is indeed a long-standing issue. As Phillip mentioned I've
already had the fix pending, but I lost track and just never merged it.
Phillip now left a review, and I've polished the PR a bit. I'll wait a
few more days before merging it, and then these issues will be a thing
of the past :)

> >    # start of suite 10: parse_int
> >    not ok 59 - parse_int::basic
> >        ---
> >        reason: |
> >          expect_result != result
> >          10 != 11
> >        at:
> >          file: 't/unit-tests/u-parse-int.c'
> >          line: 41
> >          function: 'test_parse_int__basic'
> >        ---
> > 
> > OK, but "prove t/unit-tests/bin/unit-tests" gives me:
> > 
> >    t/unit-tests/bin/unit-tests .. Failed 1/59 subtests
> >    Test Summary Report
> >    -------------------
> >    t/unit-tests/bin/unit-tests (Wstat: (none) Tests: 59 Failed: 1)
> >      Failed test:  59
> >      Parse errors: Badly formed hash line: '---' at /usr/share/perl/5.40/TAP/Parser/YAMLish/Reader.pm line 244.
> > 
> > Yuck. It actually does have what I need (that test 59 was the failure),
> > so the extra parse error is mostly a red herring (though it does prevent
> > us finding any further failures). I think in TAP that arbitrary output
> > is supposed to be prefixed with a "#".
> 
> TAP also allows you to embed YAML and unfortunately that's what clar tries
> to do but that last "    ---" line should be "    ...". With the diff below
> (which I'm afraid thunderbird will probably mangle) prove parses the output
> correctly but still does not print the error message. I'll update clar's
> self tests and open a PR later this week.
> 
> ---- 8< ----
> diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
> index 89b66591d75..6a2321b399d 100644
> --- a/t/unit-tests/clar/clar/print.h
> +++ b/t/unit-tests/clar/clar/print.h
> @@ -164,7 +164,7 @@ static void clar_print_tap_ontest(const char
> *suite_name, const char *test_name,
>                          printf("      file: '");
> print_escaped(error->file); printf("'\n");
>                          printf("      line: %" PRIuMAX "\n",
> error->line_number);
>                          printf("      function: '%s'\n", error->function);
> -                        printf("    ---\n");
> +                        printf("    ...\n");
>                  }
> 
>                  break;
> ---- >8 ----

Indeed, this was a plain bug. I've merged your upstream PR, thanks!

I'll send a pull request soonish to update our own version of clar.

Thanks for the feedback! Hope that the pending changes will improve the
status quo.

Patrick
