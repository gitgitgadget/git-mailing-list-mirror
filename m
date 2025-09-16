Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446B28134C
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010179; cv=none; b=gTYOCKCUOJurK9a9lRNGZ5UkHT4aTSNZj+SqH1pDt4IaQc0PzAmSkqlyKmKdZOALx3Qzo5j2ZSjCHmpEWHnFsbVSRvOZ1LOZ/l11WLfh+YJ32JJqrbTriGcJGI2ueoBC71uATNQDc1UB4GiGB9rzYgB/m3NXCbhQBg3N7bG0Xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010179; c=relaxed/simple;
	bh=PfGIiOs6oGl4/RDi6ZLR12Jy3i6ZIKP5fUAXf8k/+jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV3Qf1vShKUxpKUGvE6R7+eGL3U/mswyo2tbTfi8XHpTyR8uIXbF1FwGCaNNpgjtfMRxzhfckJmEJ7noPq8mKaKOR1pfghTHUsZKplfkrvAz3RYEUONRu4jSn9VGpTCBh8eGQqhNKQIiy9tEIJa6z425qr2Oe3CqDdK3UPim+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DwwTkDw/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWEIfLYE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DwwTkDw/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWEIfLYE"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E6417A027E;
	Tue, 16 Sep 2025 04:09:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 16 Sep 2025 04:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758010177; x=1758096577; bh=8zSl3OHyIC
	TrujpOaKV92bqM3oUOe5hhdq/JhHrce78=; b=DwwTkDw/CA/4wL5BgRx+UA58aj
	gua6NxOBNhSF0Fu30+4eWbUKK1mX8vIldloLcW3SW/j1j/brKy97MjCdY2xvkAdn
	Zq793kF/ItRaK+DIjJ0NPahlYQtwIrlwP0jGgJh6ck0WqqB5KyhYd4QY6VdBJRdu
	pQlZqJ50jffe49EqwkkLgFdJQNSfIMjcABeRhxXisdTuSoHp9DxzyvP9M02xELLY
	7Hloip0tjpWTKq7ZuwcCDSB97w3Ld3YPKATQuM9ldp5rzzinU2mA3OiqXtUVCHau
	IELgJcwi0RXPC7kUfJNYXs1K97/ePf6l+4hu+b+H9mfYLTonNQcPaC67wXUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758010177; x=1758096577; bh=8zSl3OHyICTrujpOaKV92bqM3oUOe5hhdq/
	JhHrce78=; b=IWEIfLYEJkxcz8OGIU5FbQoVNIBUzFERkO2MJGor/gjRd3tk3z3
	SneDLtIvFO46qeyu2tQm0qGVtWjBxNZ3WKrWS9Hhgdypu/woLlNJCOi/2e7Lfmw2
	XRJ3/5JUKjVED8okjD9uw1iaihPp5J3DdFSU7Ao5P95eZfgIs/lxO5mGPHiOFCWM
	5+HSsei9hqjAm/pCsEXJMOwfWW4AVEJnYSwpE6iL0LIzJ5OQzHr5ifsh+gTUmA+L
	4INf1PNsYJXtlyudnG1pLuQNa22mg5qZkq05r5sgw6r/hOgSDD1Jt218VzAJ3avJ
	vAWRBVd86fOQGy807L6FRBLiIWRErPsbkcA==
X-ME-Sender: <xms:QBvJaPBJZrhT1hvB8FQokEqyMWXrTkkrjPT79sHBOTWgZL8zmGz1IQ>
    <xme:QBvJaBgZ85OzzzVklt814aPB2zHiCHc8OoKurlqwf8bqqjqMbK5ZotiqGu6ANjPKN
    AxBD8ux82ewX0BCfw>
X-ME-Received: <xmr:QBvJaMyP8NtdxlUU_AZO5slDee_OxMnSga3kIHp9_ItzgUhNNuQnHyiVpVPQzrrp81Xo4fZtmW1M_C9iIvlEuV1L7MwjFamq6womVqr3fCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtph
    htthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QBvJaC1iYnFfJS-tjW5tltricXWRf55aciL-fzruIoBGjWTZ6194YQ>
    <xmx:QBvJaB8QsrkhqUzioOLFUOutM476lCZzw2PlUmN1j-juktUru3q0hw>
    <xmx:QBvJaKpsbdegM8Lpc-t2HM79ecVf5DvK9wzxKWDhM2c8uteSqf_qCQ>
    <xmx:QBvJaDQwcCMJb681jexm6Rrmtg6nTJg58FP96-foBIaElqzqvYysaQ>
    <xmx:QRvJaGC0LFRa2Ev1KSxP-_vuLzMbbYj8Cj4IMtVuI1OAtnw3XQ3b-Iko>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 04:09:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96280a71 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 08:09:33 +0000 (UTC)
Date: Tue, 16 Sep 2025 10:09:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 18/18] builtin/history: implement "reword"
 subcommand
Message-ID: <aMkbOgLlDDRlqt7a@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-18-509053514755@pks.im>
 <10696a16-3f2b-4844-9f9c-9815976b3e1e@gmail.com>
 <aMfdMe72WB3DR4gW@pks.im>
 <fe671dbf-5177-4e66-a89a-8f99b379ac75@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe671dbf-5177-4e66-a89a-8f99b379ac75@gmail.com>

On Mon, Sep 15, 2025 at 03:10:56PM +0100, Phillip Wood wrote:
> On 15/09/2025 10:32, Patrick Steinhardt wrote:
> > On Wed, Sep 10, 2025 at 03:05:04PM +0100, Phillip Wood wrote:
> > > On 04/09/2025 15:27, Patrick Steinhardt wrote:
> > > > Implement a new "reword" subcommand for git-history(1). This subcommand
> > > > is essentially the same as if a user performed an interactive rebase
> > > > with a single commit changed to use the "reword" verb.
> > > 
> > > The sequencer already knows how to reword a commit, it would be much simpler
> > > to reuse that code.
> > 
> > I'll drop the second half of this patch series for now to reduce the
> > scope of this series a bit. But once I send the second half I'll have a
> > look at whether this can be simplified.
> 
> If we passed a todo-list rather than just a list of commits to the sequencer
> then it would be as simple as writing "reword $oid"[*] in the todo-list.

One downside though is that we'll now be in interactive-rebase mode
instead of in history-editing mode. We could of course introduce
history-editing mode as somewhat of an alias for interactive-rebases.
But the required changes are non-trivial and all over the place in
"sequencer.c", so I eventually stopped pursuing that route.

I still think it should be possible to at least separate out the actual
operations and share them across the sequencer and git-history(1) so
that we can avoid some of the duplication.

Patrick
