Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9E2E7F1C
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718448; cv=none; b=lo7QWhrdbCPig9YO+arSIHMFhXQ1MJQdidmNflfZeBDuXA/OScAJErHxm2smP0lFgI+V187/yGT7mKt5W3JxPWO70O3i6/w1VJpqaLqJ6ahCCqxcl7GkS7Vuyle1MtFIROpXXNgsVGcKm3O2mSSzwIf4fcJ5NWwxQ9veDaeTS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718448; c=relaxed/simple;
	bh=4Oru+X9XkK6Bb1hLnFbLdo+xo3S6uUUvL+osicyMpdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8MaUV07yKtDKj4xEaNXiQqozSM7Dd6wo5v3Q9X9qzG+jVHBzHkijDG25sxT6lMIsMlLn7UkkwLQEtuQ1WAeOCRXtdEkYbRyu21PozQ0vUa1uJoBlR0DZJ1YlhbeFcefy+Zru4QHBLILFHA/nU1AieQZcyrCHIOM5XMw0Q8cTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lHBwZ6/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljUT0RNP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lHBwZ6/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljUT0RNP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D5487A010D;
	Wed, 24 Sep 2025 08:54:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 08:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758718444; x=1758804844; bh=69z4ZtEXgV
	jw70+d+tPZz3Xacc0cECb6FgUSai86OUQ=; b=lHBwZ6/zTBeeDruA3vBDhNZ1iu
	scSGuKB5kOs4+HMULdVDKZ0I8AAxw9WM0gJWqavoXhNPgRg64ptYb+PbJUBnjo40
	r41dP0s5m2uf8kJjwQSfi+9Gzxi2Bc21rKL+BxIitrBBzQ0U4HjHn0DRI/6L74+m
	R7iCBTsglvCSChbW0A7U5CDfjXVIWh8Stigx2BY0MawzPeXHs4CfxRyAYnojxc0W
	t6KvhIPKjJHXERHnbmFdg2jlp4mxFvYmCHdgFrcvVKDi/Vw98IPbUVwAel7rzfr3
	mZ2mHXXuEGlDCrLYIpzKMiKZr0D0gNsEamJU3261VNDA8XzExloCHEDcNsKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758718444; x=1758804844; bh=69z4ZtEXgVjw70+d+tPZz3Xacc0cECb6FgU
	Sai86OUQ=; b=ljUT0RNP7MSAOJNXBm61yzB5d1gUMIckTd3WocyzRukssssr/Wk
	oY/T5sqvBiv31K2TJfOyAH4++WTMpePSR7amvMNAYQJui8AQ0lhS888JQmwnox1C
	C6OmMcY18KCPDg/eQnLkLj4JLBCh8sCX6A/UFi6smlJ/bDRun5NRh+HMRU0BOlHl
	ai9tsMoeZ6mnyKH7E+k4KIJw7W0aByRcDzwc0RlGGf7HpWOaXEJ7UTx+5Uexg374
	aashr5YgTA/BmzFoAIxalwLyTHHmxKHlrrOqjvlxvGpEIFYKvfb8VElZq8XUA172
	fHnA4nnRplckzsNuhF+yAG1ZNuq5HtAC5iA==
X-ME-Sender: <xms:7OnTaITtczHL-T7P8Z9Ns3KnE5k9HyvngvR20cIDoyT2VYT64_W6Ew>
    <xme:7OnTaF5KLOa_rmcmMVkNejtk68Mivtj3Ca9HE_YEC8xhvafrnolr3VbIDEUdKu99p
    vw8eNi2tRC3SUz-kr9p0fo1vP9sJIvJKK9tpUEY9lRcfUeOdWHzrA>
X-ME-Received: <xmr:7OnTaNQyiWW8Y9bzK4RNrWhnQ3Q-sMG99QE1FwQwdkHSjo0nfTlEKllJPiPIj5b1r-udZ509Zeb4Oha9OS6q8GRm61MxULLJBCIa92BXUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohho
    rdhorhhgpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegvii
    gvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhesghgv
    nhhtohhordhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:7OnTaCm8S998saL91e_T74VHD0ozR87JEepjaH1JdfBC0P4tHKgHmQ>
    <xmx:7OnTaJQXfz2RlC57Bp7UwEXnmly71d-BFlsUhDVlSvAxK1_W1DdsKw>
    <xmx:7OnTaBsH5wbdk8uPfzeCsDDeOZCbxc6Iz3oJ5KDXlZeSMLuLnBL5Fw>
    <xmx:7OnTaK67TqsD7AXSLHIwewYQFmjDOSMAFX4vyyqRYj1xOSjMZqASew>
    <xmx:7OnTaOFr7-8dhw_SIcyesJKGkC6lFiSddVbyM4A-2LcSUMYVCTZzv5es>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 08:54:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8855f43e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 12:54:01 +0000 (UTC)
Date: Wed, 24 Sep 2025 14:53:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
Message-ID: <aNPp5jA5k_nDNmyd@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
 <xmqqldmmqa1z.fsf@gitster.g>
 <aMfwGHL7dh8dk2cQ@pks.im>
 <xmqqsegev4jp.fsf@gitster.g>
 <aNIw23JzQE1vz2JD@pks.im>
 <xmqqqzvxp7ej.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzvxp7ej.fsf@gitster.g>

On Tue, Sep 23, 2025 at 07:31:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > There's a couple reasons:
> >
> >   - The LTS maintainer may not be as familiar with the Git codebase as
> >   - The LTS maintainer may not be as trusted as other regulars on the
> 
> If you assume that you can only get incompetent folks who would not
> be trusted by their users by their own ability and dedication, I do
> not think an endorsement by the main project would help them gain
> trust at all.  All it would do to force the main project to blindly
> sign their output is to tarnish the brand of the main project.
> 
> In other words, you are assuming that no competent folks would want
> to be the "LTS maintainer"(s), and you are arguing that if we really
> want a "Rustless Git", which will be used by the general public, to
> exist, we should be the ones that are working on it.

I think there's a wide range between "competent" and "incompetent". I
would generally assume for example distro maintainers to be competent,
but they probably don't have as much expertise in the Git codebase
compared to a frequent committer to Git. So there's nuances here, and I
think in such cases everyone would benefit if they had a helping hand
from the Git project.

> >> edge.  Most importantly, a coordinated disclosure would say that the
> >> update to versions of
> >> 
> >>  - Git 3.0 to Git 3.4 are found $HERE, 
> >>  - Git for Windows 3.0, 3.2, and 3.4 are found $THERE
> >>  - Git 2.98 are found $COMMUNITY_LTS
> >> 
> >> to make sure that people know where to find their updates.
> >> 
> >> So, no, I do not think we should unnecessarily mix community LTS and
> >> the main project.
> >
> > How about the following tradeoff: the community LTS is developed outside
> > of the usual Git workflow, for example on a forge, so that the LTS
> > maintainers can work in their preferred flow. But eventually, once they
> > want to do a release they send a pull request to the Git mailing list
> > and then the tag lives in the canonical Git repository.
> 
> I do not think, with your assumption that LTS maintainer(s) are
> incompetent ones that cannot gain users' trust by themselves, such
> an arrangement would work.  Its only effect would be to tarnish the
> brand of the main project if we rubber stamp endorse their ware.

Yeah, rubber-stamping doesn't really help indeed. The idea wasn't to do
that though, but to still do a sanity check of the new version.

I guess ultimately we'll have to figure out the details along the way.
There's many questions we cannot answer at this point in time yet, like:

  - When is the LTS maintainership handed over to the community?

  - Who is the community member that takes over maintainership of the
    LTS release?

  - How long do we expect to require the LTS release?

  - Will we even need it in the first place for Rustless builds?

So maybe it's premature at the current point in time to already spell
out details. Should we maybe just defer that decision into the future?
E.g. something like the below patch.

Patrick

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 3b54750621..bf3173013d 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -200,9 +200,9 @@ The Git project will declare the last version before Git 3.0 to be a long-term
 support release. This long-term release will receive important bug fixes for at
 least four release cycles and security fixes for six release cycles. The Git
 project will hand over maintainership of the long-term release to distributors
-in case they need to extend the life of that long-term release even further. In
-that case, the backporting process will be handled by these distributors, but
-the long-term release tags will be created in the canonical Git repository.
+in case they need to extend the life of that long-term release even further.
+Details of how this long-term release will be handed over to the community will
+be decided once the Git project decides to stop officially supporting it.
 +
 We will evaluate the impact on downstream distributions before making Rust
 mandatory in Git 3.0. If we see that the impact on downstream distributions
