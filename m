Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E664135A53
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738216982; cv=none; b=lLFpbdho6ezky4+t1H6cOPR60059l0o2FmEjQFmQCk+Yiq2Xaa7XUcXjO1MMR35w4R0notO4RkjUPpDiCf3MvcwUDwX16+Xsnrh3yOqqaXlhrn2ymFyjcCM+HB4PTZ9PpmCDQsPiFsvTHmhvEfMb+l0i4T1EqTSo/F4sOifJYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738216982; c=relaxed/simple;
	bh=u/nxbhVNWl9I0InJZkNQ3auCJ5aV97SDNrfNRgR3r1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvJm+fbNQV+IY5M3HdvutsuyU/lbAqo3/RApqIDegSuu+K19Qq38ChtHiq7Z7XhCbYJV7PonjyvOiLI0p5NjEm7lFLsLfbjO+YknxHpOMFjADUKdLH9IoE7h3i8PCNUy6g3SG039b+nZah/mN9Mk/Q/qguWgAD8XqclwK1UjeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C3/cZdbx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kpj75oTt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C3/cZdbx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kpj75oTt"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 72B1B1140101;
	Thu, 30 Jan 2025 01:02:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jan 2025 01:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738216979; x=1738303379; bh=iD8ewNxXi3
	jvRz2U2oUbx88Kq9zC6w9j5rr6WR54xSY=; b=C3/cZdbx4CcKzF2+v0gSFLTOBj
	qdIDYx/eGsCDPFX8s2mXOYeC+od1D9Aty0bXSXXsIGuXf+1Se49F1XBVwArylm5L
	HNnCnd6FO6/qNBW/nfLHFA+mNWDRsfq1AsWRjIM6UEgQ6CuDi74pYlj2U8bl/iHo
	eGoPOUBdCTCX0SW4XbyAaIOI4QVCyA85i8AANoKYM939U6fzAtWsZulKPLsrmf7X
	9kmJmwplVyFN5dsY4rYupSVVs2aZhfbQXWFwMKNgJT9rqFNRDM25Ts2TOulSKDE2
	9fEzObAx8c6jSEOyZsKPje/hPJDH6w3job9WH0mC+QQtWGZgDm/9vaN7ONSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738216979; x=1738303379; bh=iD8ewNxXi3jvRz2U2oUbx88Kq9zC6w9j5rr
	6WR54xSY=; b=Kpj75oTtUTn9DLn0NvtinXYY5FynLKlSOohti/nLzQnx9exFF+z
	V1hOVxhaz4xxL01Pos6fq/lCt/QkDjrE8atbJnJMu9qg4SpMHqToU7XX32YQwbKm
	sJcF2pBS6V2jDfhO9SXEDGhxBLS/3elm6FXy1TTXJOjnEdQsekrgCPF5a49MyhPk
	AO7qExCSSMPyT7q0bN4QTZ6WY2l6kYFDDwrZxk/LOiyWmt1AgB6jDOBDl7kZWZZj
	AHApz+Xiyujau55Q2SovcM19vf0YFhFsFXc4fFi2aKaUyENWmbtHUW6IJxlQhQzB
	VbgXM0jCslHyq5gtf5xfcDm/stX2WiSrHxg==
X-ME-Sender: <xms:ExabZ0OV4LjuihYD9tL-JwCSo1_AzJ9QtlnhRCdMZe_X_AhjQSQD2Q>
    <xme:ExabZ6_bc3mIEVkmUiN2oeB2Hgsl17HGVkfdc2ijvebtdMIQBYGy_FlvFxj4e59pm
    03r3LLR-yJHfsMEYg>
X-ME-Received: <xmr:ExabZ7QbaAzy3zb52hItf96AxZnmuksBAqvAeDtDbz21NU4X7xs0VcOtOciiGnYtEny0s5UP3QSX-MVmG14hhzHF__ToLSu_BcgP92GAk-WC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ExabZ8vvCrhNFommrCtrl4JQg0qwis8cm8fgFtyz7O-5O7TAZNzj7w>
    <xmx:ExabZ8c_gIWtHcxUBjz_6fe94U8WWd-JM_77bnkiZrhpTjZ6Q9etNQ>
    <xmx:ExabZw2OQu9WtadcLVskyVUE_BE2UBgMVQhQykbqPmbEJr0WGhIrGQ>
    <xmx:ExabZw-7j1dHqwnkRKHrLTv04l1svIlu7Ap67g0bIIwfStzjaWVFhA>
    <xmx:ExabZ07IV67ZGrKDpszGGR6qjzA1BWbZLCMwqH1DfpC6dI9Xa61n0xam>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 01:02:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 992b9b1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 06:02:56 +0000 (UTC)
Date: Thu, 30 Jan 2025 07:02:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] unix-socket: fix memory leak when chdir(3p) fails
Message-ID: <Z5sWCxEF3J7t8WvW@pks.im>
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
 <20250129-b4-pks-memory-leaks-v1-1-79e41299eb0c@pks.im>
 <xmqq34h1k02k.fsf@gitster.g>
 <20250129200702.GB2331283@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129200702.GB2331283@coredump.intra.peff.net>

On Wed, Jan 29, 2025 at 03:07:02PM -0500, Jeff King wrote:
> On Wed, Jan 29, 2025 at 09:21:39AM -0800, Junio C Hamano wrote:
> 
> > > This leads to a memory leak: when we have already populated the context
> > > with the original directory that we need to chdir(3p) back into, but
> > > then the chdir(3p) into the socket's parent directory fails, then we
> > > won't release the original directory's path. The leak is exposed by
> > > t0301, but only via Meson with `meson setup -Dsanitize=leak`:
> > 
> > Did you mean
> > 
> >     $ meson configure -Db_sanitize=leak
> >     $ meson test t0301-credential-cache

Oh, yes, I indeed forgot the `b_` prefix. Other than that I wanted to
abbreviate steps a bit so that I don't have to give the full sequence of
commands, but my attempt was somewhat lacking :)

> > I'll need to figure out how to make various tweaks at runtime
> > working with meson based build tree.  The next thing I need to
> > figure out is to see how to get verbose error output from the tests,
> > as I cannot just go back to the source tree and say "cd t && sh
> > t0301-credential-cache -v -i -x" because the build is out of tree.
> 
> I did:
> 
>   GIT_BUILD_DIR=$PWD/../build ./t0301-credential-cache.sh -v -i
> 
> but I don't know if there's an easier way from meson.

You can pass arbitrary arguments via `--test-args`:

    $ meson test -i --test-args=-vix t0301*

`-i` makes the test run interactively so that stdout/stderr remains
connected to your terminal, which also allows you to use `test_pause` et
al.

> (The "b_" prefix on "sanitize" confused me as well after reading the
> commit message).

You've probably been confused by the lack of "b_" in my commit message,
not by the prefix itself, which was a simple typo.

But regardless of that, in case anybody else reads this and wonders
what the prefix means: the "b_" prefix comes from "base options". These
are a couple of flags that Meson provides out of the box and control the
base mode that the compiler runs with. This includes e.g. sanitizers,
`-Wl,--as-needed`, LTO, precompiled headers and other stuff. These
options can be discovered by running `meson configure` in either a build
directory or the source directory.

Patrick
