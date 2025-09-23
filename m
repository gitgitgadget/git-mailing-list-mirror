Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7266266584
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603916; cv=none; b=e8aa5Aln3qIhaSH9oZ96HbQIRpipvfsbHTeO1uqYp2kS4FL8+BNastJojQ3hJcYa1NN/xu9hxYs8NbiyHZylqWI1dyJ5HSOYE9+N1k6W+TULLfSUQzsbkP57Zx0ciWJFZaXqVz4juN1bXYxQrnAT/paqENUFDv5dwV9b/+YBVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603916; c=relaxed/simple;
	bh=Gu2tqsdm3IJA1JnNPb4NIVa6QV69weWaWRRYV8uFUmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdsS8ZZSjwAOg7KBzjR5OnXegGvsqJmnf+q5ywTH6eLx4dfv6maYI41XlTMuHPTv1SWrvYtDKMKZAq5fPcWhtvtCG98mHPBHrpXXqKbFWm10dm5BM/9Q/pfKaMPnV6o619DOP0UdaKXVXJ4OJUn2Ga9ZW9aoR4wxEr5gFkmsiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XPseiG6b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=grhA1wwb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XPseiG6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="grhA1wwb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 129E0EC00D4;
	Tue, 23 Sep 2025 01:05:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 01:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758603914; x=1758690314; bh=UhqBUeyZtu
	Gokmi2Xw+MCTzl2uefxBhfHuJ5OfZNhKI=; b=XPseiG6byDfFuwuxMUwcJd8KF/
	/OO2MkDmRt1IpODrks1hRhr7BcVdMEYuaFZc6dQhiWGaNCQh/XWuKSZonv/+fyhy
	DDb0oAPTW8pTF+rv57aZmEZ1lN4jmhe0V8CiKkl+XgDOc8Ywo2GjvbsC7jANO3ia
	QxEzaFhJcWScUVEELgkxda+97S0NS5+0i40DX+V7KQO0qjpecVQ0B3B8ugjKrR8R
	zYzLDY/9jIVoguH0eJkIfo59WVYP1OmFjT8Rx+G4AULVXdZyNQgEJtIdbqdM2ceC
	CUYl0vsz4ecEHbQScsfYyi8GlDjnbTNp22hXNJ04YPEj3Vm9j/INkb6gEGcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758603914; x=1758690314; bh=UhqBUeyZtuGokmi2Xw+MCTzl2uefxBhfHuJ
	5OfZNhKI=; b=grhA1wwbTbsxi41u3WMqPMlaUF0tLf2kFCYT8aoV3yqi/Zv4sX9
	Y2fKXiIlUfvUfv253GUnodHthpJp9ik6JUZHk7GaVMdEd1yKy5H0J3DO/LrMbUTO
	uJicqETav6ivoLca3ywqaDF2Z5LpGYBujm5NocnTIRn63m4LTheya6JmbhTeKpZy
	UhFdSz1BOQ13/oPFZOrPfr2EBhOzrF0qFmEfBQiIeJu2d+NzCmR3k2hREn9HsnL9
	2zZfEP1HOImmwDi4IGTh6aZWzlp0EKZcKO2hdAmY9y2u4xodG/gDDdbWrwsee3X6
	P7b9wttT849KeTSi/9pxgyRCzxTC3NvzWxQ==
X-ME-Sender: <xms:iSrSaOn8mLPr14XIuj6H152QRH0xsC8f0qtlguF78ppKnm8peVXDZw>
    <xme:iSrSaGR401PbU4LkMHgTPtJ20xB3K9RZi3rABFfs1OiajIZaUHDMLdtfcKG3gvcM6
    rDBSzFCqaTn28ugTnBynf0woLMNr9W1Y8EtwSdq5cmUhNJC5bAm0Q>
X-ME-Received: <xmr:iSrSaMaKR8QbSQuSkW-0ifaEMIAAn30zTHPcuEATNdnQZtd-Tc94NlUVFOxMyBgUTdZ0w040JBcAT49oVyr6jPzjQJ4F7qmJzE893vkFt5GE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehleekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhesohhrlh
    hithiikhihrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:iSrSaO_JPdL5ehaqfvjZmkIfjdpF_IkYB2QBZj5pms0PBiM5pQA2iQ>
    <xmx:iSrSaGm_uoyrhleO_RcMQsVulCbTWfBh_PLQjNgDjqPxFgXfKeQPww>
    <xmx:iSrSaDY1--m7Iun58VJ83Kbx5OrYAb8xbFolyMUjxvOqphoHHuFYdQ>
    <xmx:iSrSaOOz3UdipS15RposP0Od-yF0QGuf81b41bajU8UMX9mouQAtDg>
    <xmx:iirSaNUE36F__CTSDk2txam2DSVgguSJ2H1hGEl-5JCnJEYPRzVerbK6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 01:05:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5bd4d5f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 05:05:09 +0000 (UTC)
Date: Tue, 23 Sep 2025 07:05:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Orlitzky <michael@orlitzky.com>, ezekielnewren@gmail.com,
	20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org,
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org,
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	newren@gmail.com, phillip.wood123@gmail.com,
	pierre-emmanuel.patry@embecosm.com
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
Message-ID: <aNIqgghQwyWV7Tis@pks.im>
References: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
 <20250922155949.27019-1-michael@orlitzky.com>
 <aNHBIHXYPmS5AvpP@fruit.crustytoothpaste.net>
 <878qi66tyg.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qi66tyg.fsf@gentoo.org>

On Mon, Sep 22, 2025 at 10:47:03PM +0100, Sam James wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > I don't think this is going to happen as you anticipate it will.  My
> > original policy was to target Debian stable's release for a year after
> > the new Debian stable came out and that will make using many crates
> > nearly impossible.  We are going to have to be _extremely_ careful about
> > dependencies in general and the things we are likely to use are things
> > like bindgen and cbindgen, where typically an old version will work just
> > fine and which are already packaged in major distros.  We are not going
> > to be adding dependencies willy-nilly and running `cargo update` every
> > other day.
> 
> That brings me significant comfort and I'm glad to hear it. I hope
> others agree with your position on having significant restraint on the
> use of external crates.
> 
> git has always been quite good about dependencies pre-Rust.

I certainly echo brian's sentiment here. Rust dependencies are easy to
use, but they are also one part that worries me quite significantly due
to multiple reasons:

  - Pulling in many dependencies opens us up for supply chain attacks.

  - Every single dependency is a source for vulnerabilities in general.
    We're already good enough in creating these ourselves.

  - Dependencies may have hard requirements on the Rust version,
    requiring us to bump the minimum required toolchain version.

  - In general, I'm not a fan of having even dozens of dependencies. It
    causes bloat and externalizes a bunch of knowledge.

So I think we should and need to be very conservative about adding any
new dependencies. There will be cases where it makes sense, but every
new dependency should be well-reasoned.

After this patch series lands, one of the next steps will also be to add
a policy for how we want to use Rust in the Git project. brian has
already written such a policy (see e.g. [1]), and it already mentions
that we'll need to be careful about adding dependencies. Might be worth
it to flesh that part out a bit more, but that's something we can
discuss at a later point.

Patrick

[1]: <6d065f550fe871cf010409f7bd2a63438cf52723.1756496539.git.gitgitgadget@gmail.com>
