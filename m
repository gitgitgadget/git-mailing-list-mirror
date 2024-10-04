Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EF1BF24
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 04:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017942; cv=none; b=BM97CxOQfWJnpe7L/SgeUlin1wHopwq+NyTkK4ka2KYh1H5my4bJiFDnS3L11yxhfDGevghEj6rdpwBG809Bnhzzh7FYrgloaBvjFGUV9I+cvfYWz5zyq9dInNhZUU3z/MTbZVbMYC65gmXVw0RL7npFBI4mG4mBBoEkfzim/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017942; c=relaxed/simple;
	bh=Q2+j4D+OZujOvrXttB0uXx0DTOHpOgfZRCimieX0IpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjRKSuVWJvn+kBL9qmH3kzM/rhDC3n/GBrDGpHc5U9hEMnRso4Kk50FwYq1U7Cz+x3Sxmkh4HjrUpQfLazz6JKWnIbJeRw+wsxzSikUKnrrpocMzOnfFiq4HRMsM8nOdukvsJjNukk2Ds+6KOZnv9089FwmrYPouc5GHn/f4CRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MUKpoZ5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWCzrK4j; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MUKpoZ5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWCzrK4j"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB6B81140242;
	Fri,  4 Oct 2024 00:58:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 04 Oct 2024 00:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728017939;
	 x=1728104339; bh=1mZ6Xdq9JmroutiTA/BS1b4OSKvFp/0ZrczNCvsrll8=; b=
	MUKpoZ5rNSvE+I+izhaV+mmTDoFlU6+tfqW0r1qHuNGg5mWOflISCkWEpLOl2cQA
	S10BLrg0CSJ6tE5VN1cjUq/F9Gj33BcWMSjAduJ6DwAbBFAuxM/kV3Enl/urWjg6
	5v06p6/ELo3P1iul3JLlZqYJ2kOeAut5rKB5Q9E5cl+0joadPHPRFrvM5qjWJ8pS
	w8EYlo7R4S6g4dra04Nq0O/dUcVm+UBeIW6qP+FQWIEf+6YC3VicZly6mOinEd/M
	QXyPF4R2fOj0kCVu8qZIHEZ8o1TK5OAoGVkY8kSFrp+yqTPIJgQFjRz3EnbQ6xfe
	MTCwMnxd92v+S5agxe3D2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728017939; x=
	1728104339; bh=1mZ6Xdq9JmroutiTA/BS1b4OSKvFp/0ZrczNCvsrll8=; b=e
	WCzrK4jP4FW62/07gQL2XM70QzTbsIBdocQkV1lNrjdpTUWz4ZlpvNkI3OAZ+/P6
	i3A5dsrvAqSCjZliBwSOZUA83E9J8oHIe/oWLZFX+mv3DFqrQ2Z3UjC7e9WzCSOX
	9wjF7uP+z7GyS8Xapl136Ez2pLr0IUgVZOgmWOMY73q8X7p3vqLa0eJh6U8snoE/
	N9dU5N3HmTrwyOdl6Qc+iR/cKNY0ZfBR3F/xBNatZNCJtu0KcAPVQmFuRNl5camh
	5gNO8K9c3CyZWhLxlTjpu/Wh9OsLgEgA+9rAbvLfIRlHGaWa9gD5gjMqQ1R8OZiY
	n8hmk5EUQ6bGItOVeOqbA==
X-ME-Sender: <xms:E3b_ZsqRV1HNWM1dUEWuTBrFsz6zyM_SqMg_tlGuPMSNzwvHVjhjiQ>
    <xme:E3b_ZiqrcikM01VEMaUu6ipILBbJeREsXXZxPTkkrByuJKXdza0WwpRxemmCpmbKP
    fwJMyH3yoclAShA9A>
X-ME-Received: <xmr:E3b_ZhP1stkPDuOVyVIoALJTKG6Be7GNlJINNr7M9H8Xa4rdWyd9-6l7DcdvTrI2Y-8Y3xBmTat0HEDNk-30MDtscWEv6MhTg6TG8rQNJwQNl3e2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigv
    sgdruggv
X-ME-Proxy: <xmx:E3b_Zj7XyCWN-gkl2_mzjyGpJLs0qNNQbX88EQgn0RMTzJZyPG1gsA>
    <xmx:E3b_Zr4dUfVQ4XC3EkCqXD3B4IcuTjm4azz-xoBXUNdJdeoOjNGX0w>
    <xmx:E3b_Zjj6UAQFWLU2Y_UXGoiz4vKLVDnsL6GUMhCdGw9N1rqpW4pbfg>
    <xmx:E3b_Zl5rhkWoX25kK6F41N8eU0JKvkeKmuv4d1SBhC4xwkX1QMFIIw>
    <xmx:E3b_ZhQEewlb69-IDS-4IXs4J3LhSMj26s2ZaNhCVdbdYmXFB1XK0V7i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 00:58:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2297f995 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 04:58:04 +0000 (UTC)
Date: Fri, 4 Oct 2024 06:58:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5 05/25] reftable/basics: handle allocation failures in
 `parse_names()`
Message-ID: <Zv92BRolDugwLuOn@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
 <bdfddbebce9f77959fd9544cd5ba3496d5b9dccf.1727866394.git.ps@pks.im>
 <CAPig+cT7nni11bGmNyYCQZ0P0QZ_HG-izPtsymq==sUOkOn-Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cT7nni11bGmNyYCQZ0P0QZ_HG-izPtsymq==sUOkOn-Lw@mail.gmail.com>

On Wed, Oct 02, 2024 at 06:07:14PM -0400, Eric Sunshine wrote:
> On Wed, Oct 2, 2024 at 6:56 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Handle allocation failures in `parse_names()` by returning `NULL` in
> > case any allocation fails. While at it, refactor the function to return
> > the array directly instead of assigning it to an out-pointer.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/reftable/basics.c b/reftable/basics.c
> > @@ -152,14 +152,26 @@ void parse_names(char *buf, int size, char ***namesp)
> >                         REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
> > -                       names[names_len++] = xstrdup(p);
> > +                       if (!names)
> > +                               goto err;
> 
> Am I reading this correctly? Presumably, `names_len` can be non-zero
> here, right? And we now check for names==NULL to detect an allocation
> failure...
> 
> > +                       names[names_len] = reftable_strdup(p);
> > +                       if (!names[names_len++])
> > +                               goto err;
> >                 }
> >                 p = next + 1;
> >         }
> >
> >         REFTABLE_REALLOC_ARRAY(names, names_len + 1);
> >         names[names_len] = NULL;
> > -       *namesp = names;
> > +
> > +       return names;
> > +
> > +err:
> > +       for (size_t i = 0; i < names_len; i++)
> > +               reftable_free(names[i]);
> 
> ... and then we potentially index into names[] because `names_len` is
> non-zero, thus crash because `names` is NULL.
> 
> > +       reftable_free(names);
> > +       return NULL;
> >  }

Good catch! I think we should queue something like the below on top of
what we already have in `next` now.

Patrick

-- >8 --

Subject: [PATCH] reftable/basics: fix segfault when growing `names` array fails

When growing the `names` array fails we would end up with a `NULL`
pointer. This causes two problems:

  - We would run into a segfault because we try to free names that we
    have assigned to the array already.

  - We lose track of the old array and cannot free its contents.

Fix this issue by using a temporary variable. Like this we do not
clobber the old array that we tried to reallocate, which will remain
valid when a call to realloc(3P) fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index c8396dc525..df49cc8ef2 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -152,9 +152,11 @@ char **parse_names(char *buf, int size)
 			next = end;
 		}
 		if (p < next) {
-			REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
-			if (!names)
-				goto err;
+			char **names_grown = names;
+			REFTABLE_ALLOC_GROW(names_grown, names_len + 1, names_cap);
+			if (!names_grown)
+				goto err;
+			names = names_grown;
 
 			names[names_len] = reftable_strdup(p);
 			if (!names[names_len++])
