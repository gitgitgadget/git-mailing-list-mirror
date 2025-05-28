Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC874420
	for <git@vger.kernel.org>; Wed, 28 May 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447727; cv=none; b=caV14Ffj1Rq+hDQI4bDcddrT5ki3k9pB4N0ENnycO3PPQkJ6L93Hzotd3R3W1ivwZ/JhKhwiJAlQzQGd0AIdTc4p2FABbv2oSnPZZTixOf+C7KnDA0isQem1OUsMbJlSutkHQcGy1bnV7bq0dP1Z3WhXxYyj2jmvO2beLCFjy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447727; c=relaxed/simple;
	bh=BNc4MJTW2u2WWWmQhh9bCQUPi9KFkc2tlTCVZtaGWgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNd3hqoAcsDcSx0YoLRD+efew9SBB4Ac6+VaHUUTMu0anwkf3j57+KYbMKtWlj4NtNgSQZcnwFWwmnoybZSB/DC6E4IU/5E70BbxqQTgtfFegZDC1gTuZ8XVot0yb4hHJbPsbF/feUbBooBK9GWiQynLvbuzNrJJ64VBDLWd0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NHCPEM95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VDPnLHFb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NHCPEM95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDPnLHFb"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 182EA11401A1;
	Wed, 28 May 2025 11:55:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 28 May 2025 11:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748447723;
	 x=1748534123; bh=gB7+WcziOjKd6QrF5Qn8hxFa/PqRE3WLd1w+9If3SuU=; b=
	NHCPEM95oIs94uCTXDMeyt4uKVR/oObzk44dGcX5SGBrfhcQkvsQM1gGqQmGVZjm
	fDVacxwyZ+AtrpVlbe0Xs/E5fZdxTMLjwABNbjR3EKtYbGcj05bPeVzZsxo+cCo7
	oKSwImPWGsLwRop1EgeN6pQGpIT/NB0eoAndPhvnBqH4Imn/XWt92lnlFVq8AWeW
	WF/gwSZwUltGnrv+ZN1AZakZBJ1mWO6NU6D92/Bit4kXrxHg6q5nj5TkNNht5nHX
	QYXIFIbeWuzo7avGNIc+wopDjvT0SIchoRkQ0LQhbMSvmVw830ZGNCM8oBONGK1b
	+4pZ5S0twynDDCbaKWZn5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748447723; x=
	1748534123; bh=gB7+WcziOjKd6QrF5Qn8hxFa/PqRE3WLd1w+9If3SuU=; b=V
	DPnLHFbMadkO/VT6JoCUafrqa8vPm0KA3NHxXQATczc14EBVbGQLiZmbtW+bLxfY
	55FRLtvgDQLAm7QOmwq8xh7slYxm9h4Fp0HCVavMZuUScylKkiPjWKJ+CZKx2Wmy
	WRaNC3x4v2NzZEHU1deh7B223HGqER+j00Hu20HpzPCh2MO904vC/+kZ3MaXGM8N
	6MPMBysZTGxALDJSocpLult3x4wUvLjZbgW2N3fQPc6fw4eLVTj4FC04BFrVfqCO
	Y05/ZcbxOiaHdhFbgMXl0KUgDjeHF/vhU8bw+t/2ixJj0z+NEdO3OhK7CYhVThv5
	M/CyI1pdVdgewY16mcycA==
X-ME-Sender: <xms:6TE3aPsinMwPjHV9p4d3_IHiUkeUIoYOHSEjEyJCmCIl2qzEsILzNw>
    <xme:6TE3aAeDQpfyiYFOtaxOnvgnynWMghwDM6VRBp9HZQheeANyP1Wnu1TxNnoHnaeAn
    FWg_55pysW9OBcYXg>
X-ME-Received: <xmr:6TE3aCxs3vxNwgRaS3RXgWgU6XqLvs32N8_uFO564nBCMQUhy4kFL6e1alMEikIcikhvdT0H7BuwZyqeAttoO1dvrRtpuGSiAtN2FcPaukw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeeikeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgfdvfeeuhffhhfeh
    vdevffegtdevtdekleffhfegffejkeefvdehjedugfeiieeinecuffhomhgrihhnpegrug
    gupghfihhlvgdrfhhoohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtmh
    iisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtgho
    mhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:6TE3aOMCV6U9I0exOuUQZ9vcQTbMSPq_3lK5cbfw93QI6kQtyc1Urg>
    <xmx:6TE3aP_wK1L08sPQF8_7Qvd0p50pNiJY4Ya1HZuBa5wbb6cTVOCxYg>
    <xmx:6TE3aOVSNUWptbrsp9aLE-I5ho8fsMooJLQxSGiJZ2V3Vb4AAQO8sA>
    <xmx:6TE3aAeb59OPJEYOXld7upm7_UA2he18L8vo4DY5FsZEbG5wm7mpBw>
    <xmx:6zE3aBQsWrRfKaOnmvD8_VQ2Rhf_hqm4oJhFDqudGdgYTKkkXxKVbHZ_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 11:55:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4e4b4e1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 15:55:18 +0000 (UTC)
Date: Wed, 28 May 2025 17:55:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 1/6] t: fix cases where output breaks TAP format
Message-ID: <aDcx4dXe12tRUyYd@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
 <20250527-pks-meson-tap-v2-1-ae360f77786e@pks.im>
 <CAPig+cSYhY+LQ5pD+a1O16Rxwo_js45WqfcW8wtC2daYmNyMCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSYhY+LQ5pD+a1O16Rxwo_js45WqfcW8wtC2daYmNyMCQ@mail.gmail.com>

On Tue, May 27, 2025 at 03:47:16PM -0400, Eric Sunshine wrote:
> On Tue, May 27, 2025 at 10:03 AM Patrick Steinhardt <ps@pks.im> wrote:
> > The TAP format does not allow arbitrary output outside of a specific
> > test case. If a test suite wants to print any such diagnostic output,
> > then this output has to be prefixed with "#" to mark it accordingly.
> > A bunch of our tests generate output outside of `test_expect_*`
> > testcases anyway without such a mark, which breaks strict TAP parsers.
> >
> > Upon further inspection, all of the output generated by such tests is
> > rather uninteresting. Refactor them so that we don't break the TAP
> > format.
> 
> Nit: Can we avoid the word "refactor" for changes such as those made
> by this patch which clearly are not refactoring[*].
> 
> [*]: From Wikipedia: "... code refactoring is the process of
> restructuring existing source code—changing the factoring—without
> changing its external behavior."

Fair. We can say "adapt" instead.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> > @@ -30,7 +30,7 @@ setup_repo() {
> >  test_repo=test
> >  push_repo() {
> > -       test_create_repo $test_repo
> > +       test_create_repo $test_repo >/dev/null
> >         cd $test_repo
> >         setup_repo
> 
> Yuck, but certainly the simplest "fix" in this particular case
> considering that, ultimately, this entire script ought to be reworked
> since it cd's around outside of tests with abandon. It would be nice
> to see this script get overhauled eventually but such an undertaking
> doesn't need to be part of this patch series.

Yeah, a bunch of test scripts fall into this category indeed.

> > diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> > @@ -48,7 +48,7 @@ commit_file () {
> > -test_create_repo sm1 &&
> > +test_create_repo sm1 >/dev/null &&
> >  add_file . foo >/dev/null
> >
> >  head1=$(add_file sm1 foo1 foo2)
> 
> Unlike the case with t1007, in which the entire script needs an
> overhaul, it is much easier to fix the problems in this script without
> papering over them via ">/dev/null". In particular, it would be
> preferable to resolve the issue by wrapping test_expect_success around
> the code which currently resides outside of any test. So, for example,
> the above could become:
> 
>     test_expect_success 'setup submodule 1' '
>         test_create_repo sm1 &&
>         add_file . foo &&
>         head1=$(add_file sm1 foo1 foo2) &&
>         fullhead1=$(cd sm1; git rev-parse --verify HEAD)
>     '
> 
> Note that I also dropped the ">/dev/null" redirect from the add_file()
> invocation.
> 
> The same comment applies to similar changes made by this patch to
> other scripts, such as t4060, t7401.

Yes, it isn't particularly hard. But it does result in a bunch of
shuffling that makes the patch way harder to read.

> > diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
> > @@ -7,12 +7,17 @@ test_description='Clone repositories with non ASCII paths'
> > -ISO8859="$(printf "$ISO8859_ESCAPED")" &&
> > -echo content123 >"$ISO8859" &&
> > -rm "$ISO8859" || {
> > +test_lazy_prereq FS_ACCEPTS_ISO_8859_1 '
> > +       ISO8859="$(printf "$ISO8859_ESCAPED")" &&
> > +       echo content123 >"$ISO8859" 2>/dev/null &&
> > +       rm "$ISO8859"
> > +'
> 
> Was the problem here that the `echo content123 > "$..."` was
> potentially spitting out an error message to stderr, thus you had to
> redirect it to /dev/null to silence it?

Ah, this redirect is not required anymore. I had it in a previous
version due to the exact problem that you mentioned, that echo spit out
an error.

> If so, did the file get created in the error case? What I'm wondering
> is whether you also should use `rm -f` when removing the file.

The idea here is that some systems fail to create the file in the first
place, which will cause the echo to fail. In that case, the file has not
been created either, so there is no need to remove it.

Patrick
