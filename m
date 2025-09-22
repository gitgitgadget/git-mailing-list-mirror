Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3917E105
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546120; cv=none; b=D9J3d4+T+r6KEuLKcZ4m9zoCv6r/41bIPJb1mgULdSSY6VcmMZoFzwifyDIFd1pcUW+mNoHBu1GSpob3PZvRTinTLSvjuW2bV8nKWNvAcDJK9gqSgQbVwQ/AxBjOBnD0s1fUyPtw9h9MboOolNtLqGzL2x0sv5spbA5HyZQeHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546120; c=relaxed/simple;
	bh=bhzl6T6dp22YWvLi3rTkHEAkmVD2ZjzOt0f+DeMfc6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G57kv/7U9myTXnCCA9TciNiHnEwMJnh5KBVnhhlIIqUTvV0S4hbw3pECwLHLt4m7PS1FrZ+hChUQWL7i1IRRswH9j+ld07xm9Bg5OApim1u08GefluVzNcKihK5+0vQSgTXooDVuQPu6kZVd1Ai5InFf8AM1YmAT7TNzs4kvaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pX7X2rjl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kng+BVmE; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pX7X2rjl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kng+BVmE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 540B77A021E;
	Mon, 22 Sep 2025 09:01:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 22 Sep 2025 09:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758546118; x=1758632518; bh=7fXG6106sl
	D9liGXHQ/0DaivP1HEIxhIlt0uvDOfdOY=; b=pX7X2rjlqVJq0ITkWMpG69ltPW
	Xz20ca2/0s65fN1gh0FucDNk9OYUsR2XIzaYJLcTDL7CbHQBBSbYRQer7e5+DvQ6
	3lnSyAuP2QTNvMQ7/raN1syAGuMDTHRiVUilcwSY1qgTXpASsBe4Ibkf8bFbRxRq
	oWhW2F6ElLbv1ILLRO0bpPbKk7IUZxD10NXG/usANNJwvXfar/WEMSpgNR4alCjg
	xOiilb9sGB9rYYIHKNmf8BZ5JrKvWQMcqxpXBW0NjOc1u3Nzra2XElwmVT6lVMpA
	2upCCk5rOR8M1vUYWh0llP7+wAqley5RhBuWSt9hy5TUjwEK51G7TtnNrDtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758546118; x=1758632518; bh=7fXG6106slD9liGXHQ/0DaivP1HEIxhIlt0
	uvDOfdOY=; b=Kng+BVmEyeGdWIYtMUOlZFSyrUiQqDLeuvQgDqvF7NkOILfpRXo
	Iv0SH+8xah+SKdJkBaeL8a7gHVQjeC6I/tD32YqGz8McUiU1T7aLv/6YaCRj1Szl
	DojfNNG/fyp1G0d26MyavWeGkgTBGEI6geitNZtzL9TaV2wlOW3iPnl+/0jCqTDj
	Bizfdb01a4hRmpnRwmlOPfkIMfewU2sY15KesL253uUo6EX/LBsbgyfl/QeiAjT9
	9cauo0EZaU3fvs9J5J3nTeG2Oms7qiCc6pTNr0iA+kGaIw75tZLRiFHorn1gVpQz
	5kPh4lhBEIps96P1tdbB0nvyJWrCh/Yhdzw==
X-ME-Sender: <xms:xkjRaDdzFsi7dX2fVvW32hF4KrDo93pGlOxPdkVG_gnZMrANZnmQxA>
    <xme:xkjRaEsL2eikGuRMFM5V58seIXuQ7uoLKy-cgd_WvhM7mdHjPJYCB1bSb09rhI42z
    F4w4cS7CdN1AnmHCQ>
X-ME-Received: <xmr:xkjRaC9bVB1fsyJ4Jslb8FWQQ2nK2HG3myAev1CQb68i790aHy9nWW_tJN3Efgi6RyteDdzyWyTA6DQA5SaAbSX3IomdTWh9BPsxJIMDzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlh
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xkjRaP3JQE0pCXhqPZ7IgmMlAxlDMDdMpoEYMl8Ylpfrw9YfTgoAsQ>
    <xmx:xkjRaHCoR7kyQnfnqmWF2NmINDH3hNnCgisNIsdqiJM7rXPN_vs_XA>
    <xmx:xkjRaLefUAIqIsifNMRZoDxo8hSb5gglSE3jbn0o59m5FuarM5wzbg>
    <xmx:xkjRaE6s91GOWec5_h2D_eDMX-LY1SVVgfttJbMpzrJX6GPVqu8VaA>
    <xmx:xkjRaLOJkycIol4KKtu7m9Py-esAd_TOmBG6GGO86OCOKoRPK-Mq3FPY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:01:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5deb6cc8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:01:56 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:01:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
Message-ID: <aNFIwFD6E6Lngy5M@pks.im>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
 <xmqqcy7pc8ix.fsf@gitster.g>
 <CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
 <xmqqy0qcae6z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0qcae6z.fsf@gitster.g>

On Wed, Sep 17, 2025 at 03:48:04PM -0700, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > So, how to move forward?
> >
> > A) Modify Patrick's series to just take patch 7 of his v5.  Patrick
> > did say that the roadmap was  "the more important discussion compared
> > to the technical discussion", and merging that patch would achieve his
> > goal of getting an initial roadmap.  Then Ezekiel could grab other
> > pieces from Patrick's series (e.g. the help and varint stuff) and
> > incorporate it into an "introduce rust" series.[*]
> >
> > B) Merge Patrick's series and tell Ezekiel to rebase, while noting to
> > Ezekiel that the roadmap is the important bit from Patrick's series[*]
> > and he can suggest changes to any of the other bits.
> >
> > C) Create a consolidated "introduce Rust" series with bits of both --
> > what I think Ezekiel was trying to do with this series.
> 
> Ah, I didn't even realize C was what this series was trying to do.
> 
> I do not have particular preference between A and B, but I thought A
> was closer to what was being done with this series, and as long as
> Ezekiel and Patrick can join forces that way, it would be perfect.

I personally think either (A) or (B) would be good choices. I would
slightly lean towards (B) just so that we have something that we can
already play around with while building the next steps.

By the way: I'm also happy to change attribution of some of the patches
in my patch series to mention Ezekiel as author. I don't care much who
is listed for the initial patches that introduce Rust, but would retain
my own authorship for the "varint" and "BreakingChanges" commits.

Patrick
