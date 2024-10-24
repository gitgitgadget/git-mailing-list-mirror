Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB5189BB3
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754413; cv=none; b=tS4ZLp4VRGPENSqFeZaezNxuQlXg4ExFPRz1NNHKvxCq026OOgPxOF9nR9WqJLRa0u0n0fhIQFjRpa1pnEb8+vYl8q1kwf0HC9XZ2tLNQVIAsSwk4mh9ftmzUh94DzYZx3SBRm85nncZFO40j7bBUApWwc9DkGJ5jdYP9Rx3pwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754413; c=relaxed/simple;
	bh=qp1viWXcZOXY42gbQPBFetvBe8MfAnW3rZTqquTEbnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWl3fZKAcU5IumurvMk361FZuNOiRyVebL/9VtBD53rRXtuoz1mrI+8b4zx7PHSzRlV6aagkozpj11Z0m+fYergY0H7tACTwgyGvNPf4lwSGsciN/PrkmdzcDdkQoX7OsXG62M3i4XZuTCPGGXk30KH3NwkvN5LpCJ4YJrO9usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jG0uj620; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZO3RkmnN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jG0uj620";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZO3RkmnN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EE24114021C;
	Thu, 24 Oct 2024 03:20:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 03:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729754410; x=1729840810; bh=9JsaM04Lu7
	mBdmkaUuubktVjoP2vZjg5oijRsj4RVCU=; b=jG0uj620Hprvm5DJSEYLERUvbU
	CozYZ5XCmapsiq6Qg+fH0IS2nllKFrLQbFPgA93e8uLE+zaMhx5b3n/XqDwJHT9H
	Y5DeJf8crzl3Hlz6R9ImlblyBqo0tlynlJwew5S/2T6Nrn4kEvIQdqyj212y6qz7
	Ea9XbFKRSNZbVw6FB4zJsEACak4snJO2clnWZcgnLU4ZLuGvF5/4QIvVTpbjQxX3
	maB39DHFFoGd628vItGOpvjRJ+AHEkYqvqbquHmSn16PWwpIls0okSTuzXA+3fCu
	A85US6ca/w9TBGI57Wm5M5VHmAW4C5Ce2CVnxPjTFe3uWm6ddl3d9s4K4jlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729754410; x=1729840810; bh=9JsaM04Lu7mBdmkaUuubktVjoP2v
	Zjg5oijRsj4RVCU=; b=ZO3RkmnNjDgut0Zh1zOlJbQ08Hq+Zqt5KptVFt5JpQFH
	fnoKKfgNziiqP7t0TDzr8rXgios2dBlbnwQqI5IvQTsxYDNLBLJDU0HnYlvxvrBf
	kLiPI1ZeZYMY5XyOQCKFJGAlzhOnIt5BppAlr/Cht4Xn4MLzygFI+UAmikJH0Uaf
	gJ/3PGkMW+3tkGOiDlNTi+gYVzXpmEr9gbD8IXG1kAHKgJLQ5/rnkegd4gSwtQiV
	bDET799Y26hJTZ3bWkYsjSXCDsw/yCUJOevcOnyIDcACUk1j7PbsiS0Fw2uNSD62
	KSrEQeGVKidWo9HV6LeB/yildDRPJUOEiyVTocbvfQ==
X-ME-Sender: <xms:KvUZZ6zQwuliyBzXDsHm3WJglLm_6lj_jPqDilfi6Si65lf9N4bwwg>
    <xme:KvUZZ2R9811_gYrh1HPApcXd2_7Uw0vLSukst5LhH9Cj-AqJZBM3XM_ewCwNuhnPX
    telggB2gpB8fRKqqg>
X-ME-Received: <xmr:KvUZZ8WT5AqqDBLpfWBok7l36r6lGX5sk3j1HnxuccQhKTqG1QvtvuZlH0LjP7QBuoIS9bXVEtLdlsRRrqdL4yCT4sC0BI8pD_cVeC2Vqz0Zxm9W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:KvUZZwhVlVQRQSu6QJeq8O-dZIZb2f0-sp2vA-nFa9CcJZJ9QSs0dQ>
    <xmx:KvUZZ8Aonr2_qMcutpn4QNn5Z100bYPe6VtPIQ7G2Bh30oMo0E38rg>
    <xmx:KvUZZxJ22mYPN_VnuBUuqfHrFqLUjd4DX8yifP34RmhwLGGccJJoYg>
    <xmx:KvUZZzADTvixUgBmTMWb4tP7x79CDN_tpvKd9GRjXku_3XztZ2w3pw>
    <xmx:KvUZZ6AohwUFjCHiANJsdV6dXp6e3Klh7ByGmqaPJXCBoo5ke8pm1TCA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 03:20:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d785f42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 07:20:11 +0000 (UTC)
Date: Thu, 24 Oct 2024 09:20:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <Zxn1I5FHSrsPN6qp@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <ZxLOlx69KQp9jXDF@nand.local>
 <ZxjmQQ3MxDlaJid7@pks.im>
 <ZxlZUP5uZtjZxFoU@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxlZUP5uZtjZxFoU@nand.local>

On Wed, Oct 23, 2024 at 04:15:12PM -0400, Taylor Blau wrote:
> On Wed, Oct 23, 2024 at 02:04:17PM +0200, Patrick Steinhardt wrote:
> > On Fri, Oct 18, 2024 at 05:09:43PM -0400, Taylor Blau wrote:
> > > On Fri, Oct 18, 2024 at 02:23:47PM +0200, Patrick Steinhardt wrote:
> > > > This series is based on 15030f9556 (The second batch, 2024-10-15) and
> > > > has the following dependencies:
> > > >
> > > >   - ps/cmake-clar at c6d3e52c91 (cmake: set up proper
> > > >     dependencies for generated clar headers, 2024-10-15).
> > > >
> > > >   - ps/upgrade-clar at f3501edb0e (Makefile: adjust sed command for
> > > >     generating "clar-decls.h", 2024-10-14).
> > > >
> > > >   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
> > > >     FreeBSD, 2024-10-16).
> > > >
> > > > These deps are mostly just there to make tests pass on all platforms,
> > > > but I wouldn't want folks to go test things and discover breakage that
> > > > is not caused by Meson itself :) You can also find this version of the
> > > > patch series at [1], branch "pks-meson-v3". @Taylor, I'm fine with
> > > > keeping this out of "seen" if you prefer to wait for those dependencies
> > > > to land first.
> > >
> > > Of the three, only the last one is marked as "Will merge to 'next'?" in
> > > the next integration round[^1]. All three are in 'seen', so this should
> > > apply cleanly on top of those.
> > >
> > > What is the state of those first two topics? Are they ready to go, or
> > > are we expecting a new round for any of them?
> >
> > These have been merged into a single topic now and should be ready to go
> > from my point of view. But they still require reviews.
> 
> OK, so: ps/platform-compat-fixes is in 'next', and ps/cmake-clar has
> been folded into ps/upgrade-clar. Have all three have been combined into
> ps/build?
> 
> If so, should this topic be rebuilt on ps/upgrade-clar so that we don't
> see the same patches twice, perhaps? Or am I still missing something
> here?

No, you don't miss anything here, rebuilding this on top of
ps/upgrade-clar plus ps/platform-compat-fixes is exactly the right thing
to do.

Patrick
