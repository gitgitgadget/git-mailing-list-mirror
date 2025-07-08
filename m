Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F851E48A
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956707; cv=none; b=S/7zhNjxMYl4lGEx8EdAt4Z5s6VUOlbnLHJVqG8HEgB32bQ4g/DNCg9RKgTNzxrGAkz6PEiMC0eI6EmYdp6pXv17q3AFY6i1114ygqfKGmgnMtKcGn+6fI4DN/V1edbvqd4pz1M4EdbrDoN7agxUwfUN6RfAOH+BuQWnITxO5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956707; c=relaxed/simple;
	bh=0c78/lcHR1V2MVG4//ia2+FVflmsQ57vv1eBVOzj9E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEpkt+a2VZbEmV1aQAqB++CCgAdwtxHOvt1A1fvYN6mn8ez7sAPbdji2R1g8LuW3OSgfxfOzryvNEZiQlJBcRTt2ZPDKn3wUWnQDscsoYOLAq2l1wn/gkdbZfiyx2H+9zZq6hwpkwwioq/vH1Hm1gv+ceU5IY3cXQI+DINe3RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EE9SRgoZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQxnuvp4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EE9SRgoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQxnuvp4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EC032EC04F2;
	Tue,  8 Jul 2025 02:38:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Jul 2025 02:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751956703;
	 x=1752043103; bh=/vaG0vVTIJYTQO4121DbnUIS0ydeyI34M5gUXlVNTy4=; b=
	EE9SRgoZK1SZCAWIXyVfveqpA69vvf8IrHRgzRSnombXdGTJKdoEFllC6v+cFgCq
	0NsVeVrsRMuzE/68hh2uioyrtE8UhtMeuuSJJ1nw9PcoB1KfvoD9IlDPG03EexoF
	BBCmkSvyTw9y15eIH1hp1zRvz3Y5A1L2O8CGsw4PuLtLiFoczZ3rDGER0AZw56s5
	rf/vqkvvoPHTrTYzos19KukmwI9GwORPK64yhFlykdR8jGFXpQMDjLLaBPNf7xUg
	6xr31KFH8rUetqq0AgRZBNXMhzV+4BLXgve2wO6BaB1TmGRKmaUm+AosW0bz2d+O
	+nGiYkzwKNpVsSdqEDi3/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751956703; x=
	1752043103; bh=/vaG0vVTIJYTQO4121DbnUIS0ydeyI34M5gUXlVNTy4=; b=n
	Qxnuvp4gynqEB55lMXpc+f8ADFCAG+6Ha4mC9JeU6qVFvuiNBpKuztgieoRZFK0a
	y7X2VvhSOmp9OgiRMx0GSrjsC/YSbJWIVgYgTMxSQVY57X3XdjApye6NAG4KQod1
	XwhdnA1h5bxuPMB1x+d/hsd0yqVN/Nvdi9HA0k9767zLWDFf29/t1uGNi47y64+U
	GMYZu+etQZVpNJgk0R6wDICnX0dDPbM6vbgggS7IMPvpGwKZ40dk9KmrnAMrPfBJ
	8fvlxmEPmEk7q2QdRAemgrp1pHZgJEtMRZ4gd/+ssh/yQke0j3Xxh+SoHeQlnq8Q
	9k7QGdODAJ9oXt6K3JgYA==
X-ME-Sender: <xms:37xsaGS_F6LNqYkSDOxlaiGu-qIFCgrSBcYg7hB5V-UWygAAT5_DuA>
    <xme:37xsaIsTzRVuWI1QUmKQ19hCNQzojwOIsIwCe-wP0xM8Bv0Dz4aovLgJIBdcS5mXR
    UDEwmPKBLsPJPgSHA>
X-ME-Received: <xmr:37xsaPdR7YoKAx8z_S1kzRKqFw-PF06bb5qXEdts0nI7JsKQiRtTfMwEcdUx1FEuqLciFLfROAzWGqlB5pH_E97V-mpBbj_ko9kyvKw1148>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgeektdfhudetkedufeeutdevteevleelfeehuddufffgheegheevffeifeeiheehnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:37xsaKZeokjtwb4slyait-_wfukaPrOby6J05tK5fcZveNiVftNQvg>
    <xmx:37xsaJZu6-PltqA33aGoYaTi2UjxRvBmQEWEtpjTE7N-0EbtxIBNQg>
    <xmx:37xsaHIqpBlcM44sfEf5XajMBQ3RDPqFaeudmYLz-lDFH35iz2Hogg>
    <xmx:37xsaNte1JiQUhcf40q394VYJDOHemdXyNajmfaOIf3wQIl9EQhVHg>
    <xmx:37xsaFQ2A1BDV0klqTaYcvAm0QL9qocDJI10Xgbk39mPfK51s_a7AVnZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 02:38:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c684f459 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 06:38:20 +0000 (UTC)
Date: Tue, 8 Jul 2025 08:38:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
Message-ID: <aGy82TiRFcij5V_9@pks.im>
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com>
 <xmqqbjpv1ucb.fsf@gitster.g>
 <CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
 <xmqqwm8jxoj3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwm8jxoj3.fsf@gitster.g>

On Mon, Jul 07, 2025 at 10:03:12PM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> > On Tue, Jul 8, 2025 at 12:58 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Christian Couder <christian.couder@gmail.com> writes:
> >>
> >> > This v4 is just about fixing a few bugs in the tests using the SHA-256
> >> > object format compared to the v3. (I had issues with CI tests on v3,
> >> > so I sent it without waiting for the results.)
> >>
> >> We haven't heard much after a few comments were posted on this
> >> latest round, since Elijah's
> >> <20250619133630.727274-1-christian.couder@gmail.com>; I understand
> >> that it would be the author's turn to respond (the response does not
> >> necessarily have to be with an updated iteration).  If so, let me
> >> mark the topic as Stalled in the draft of the latest issue of the
> >> "What's cooking" report.
> >
> > I will hopefully send a v5 later today.
> 
> Thanks.
> 
> By the way, I noticed that you often do not respond to reviews until
> the last minute, at the same time as when you send your next
> iteration, or even soon after doing so.
> 
> That is quite different from how other contributors operate, i.e.
> respond and engage in discussions triggered by the reviews, and
> after people involved in discussion got an (even rough) idea of what
> the right next step would be, if not a total consensus, send the
> next iteration.
> 
> I do not know which style is more efficient form of cooperation, but
> it somewhat makes my job harder, if I do not hear much _heartbeats_
> after I see review comments on the list.  I do not mind waiting for
> seeing the next round for quite a while---after all, any substantial
> (re)work takes time.  And responding to reviews may need thinking
> things through carefully, which may take some time, so I would not
> demand an immediate response, either.  But it would be nearly
> impossible to feel the current status of such a topic---a few review
> comments are seen, the author goes silent for a while, we cannot
> tell if the author is working on a new iteration or where the author
> and reviewers agree and disagree.
> 
> Also a review response that comes at the same time or immediately
> after a new iteration is already sent out makes it look like the
> author is refusing to continue discussion and reviewers are not
> welcome to make follow-up suggestions during such a discussion.
> 
> Instead, the next iteration comes as a fait accompli, and makes it
> less useful to continue the review discussion on the previous round
> by responding to such a late response.

I agree with your points. Overall, a fast response cycle is key to good
collaboration from my point of view. I think it not only makes your life
as a maintainer easier, but it also makes the reviewer feel like they
are being heard and is the prerequisite for good discussion.

On our team's handbook page [1] we have the following couple of bullet
points regarding how to respond to reviews:

  * Respond to feedback that you have received as fast as possible. A
    fast exchange is a prerequisite for a fruitful discussion and
    ensures that you keep momentum.

  * On the other hand, it shouldn’t be necessary to respond to every
    small typo correction in case you will send out the next version
    soon anyway. If it will take a while before you send the next
    version though it is nice to acknowledge nits, but mention that you
    will hold off sending a new version of the series until you got more
    feedback.

  * Consider the viewpoint of the other person and be ready to disagree and
    commit. Do not ignore feedback that you have received, as that will lead
    to frustration and a decreased likelihood for that person to review your
    future patch series.

Patrick

[1]: https://handbook.gitlab.com/handbook/engineering/infrastructure-platforms/data-access/git/#iteration
