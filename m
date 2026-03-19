Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD53C943E
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932372; cv=none; b=QOJERWqxG4uGfylnwqcinvySEKtXRgudrJLRNagYIgtGNQJjn6UqIl9hSQMFaOCokIfZaplJcn26Gt+3MK5N1Nl90msSHbT5GaLqrdeN7qzQ7KgG0qbeZgv0tmWQFfHqP00QGE0Xd+lEjps3tgaCi+3qInpYKbbVTSzXM8s2fD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932372; c=relaxed/simple;
	bh=vFJ1QNnFDRU9EzmFYuwHtatHf8WjjuVDkM4j5FqmZYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZu9bKnWSqZqCymUD8mEtw17VoMi9QY9Q5Xo01PIJcLJ1PwDPj+bRzczvpWX7rzdcK8J951MCWKjqPpR0YMz1LFWjdHdnt7mnvuEwxU/M95MoFfYozGU81q5RRXt4kNVStR9NcECJR9gDZE3JKupQ0J1ropbJGNMwJFzCj7PGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KIdOQD5B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xYKZ4IJ0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KIdOQD5B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xYKZ4IJ0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E97B97A01BF;
	Thu, 19 Mar 2026 10:59:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 10:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773932368; x=1774018768; bh=jZdJLZefhl
	7XjI9hcj7YWWwvOJHazcOYYjeJza+XrAs=; b=KIdOQD5B1p0UJu/SexDDEyEn7b
	htPWhygYESYNeACYbjYi1a2HrXN4uSTwJKM8m6JXaPQg4qMT2/KpT196Dpt+NE59
	ib9mEJGB7K6qL9yJTl8BfVvYkd4TtYQEmTEYwyTAQ7kPJo2+iVHgSzGnjZr6b4cT
	MPwgjJgTewglnnMCSnmGXaXKmPtcg/nMN8H9U6WQfLeyWIkZOR1Q9Du5PAYtC/Lc
	E7wL++8aKkywAnkAORb3LJS+CFQIXfASnTfQDyOA/xnIlw1qixKW3/8x2Q3aM3wk
	hZ/3t3YPizZ5ZjqNuwPc0zutSoB4y+Bdjqd+B6wm3y8nN27gHxLI0CaskeDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773932368; x=1774018768; bh=jZdJLZefhl7XjI9hcj7YWWwvOJHazcOYYje
	Jza+XrAs=; b=xYKZ4IJ08qkqq2VGejYBIXmQK/9rIZXKsVzfszhwqVNzsy5pWvv
	qQ383Zjai0lTOhPW+g0YEepizeEh3Ql8TJEthCBlYWv66C0xGqi1v/enxKeEvuxz
	Fuq3e5/THK/DV7kfaP/2ckEYt2Wdy2KVYc5QuGHH8uvb1lwNUsoYv6nfrlA7P7mU
	LEZmf1KVPu2GDkp2AGhHoiwZ3vNFZpbo5G/kgHezV0Yfrqx8cW9o+CPWp4iVIZGL
	aJYROhBYU+qDHI4qWVAGBYZxqH8IMQf8Le3fBe0vwW7oD5FI58OkF/hUyScouJAO
	VDx9fk4HDDsz9S3bUCfx1Pcpr9QWLoodfRg==
X-ME-Sender: <xms:UA-8aa0JNRo1Nnnmi_IZek1G8p8EUBak1-IAqBXxpFc_gWszhGCQmQ>
    <xme:UA-8aTEsVpl_J_soVnH7AoAxAXtDC0UV0wH7iEUrPoi4DJVpwIZc7xGBV0gxjPjRk
    qkBlcq_ire4ht5vdKOyA6BTqB2o_leTsxzRU4WD84L-bPmlsaPH>
X-ME-Received: <xmr:UA-8aQjN2ST4w9rb2FDM6TDropS-GqScYH7iWV7ZEliciqp9sNN9-rJv3yA9OunMuvP8ssdaanrixN84IszO-41Uwt4M5euUcczDkRARHUhD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UA-8aW_FK3oajlp8qnM4M1cOgOd4FXo0AM-uXJ1dgACXIUzsM9c47Q>
    <xmx:UA-8afpHH4YKTzWQJ61SiaSDRJnI-2lXMuShmgzLxXsGDtXiQvbEuw>
    <xmx:UA-8ad8sDPoWf1jKZB68L_RHQvQmpszNPHgUxJJjCtSNUS77S0LzqA>
    <xmx:UA-8abUnqAKelvrkMbJQ4lAA18sA9YtDNc4q7V3XwfyU_KiwatJRzw>
    <xmx:UA-8aWNy-Xb0sIuuHuvJafUBknhvfr68YAcj4y_fr0khxIDuZ7jOn7i0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:59:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3db382f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 14:59:27 +0000 (UTC)
Date: Thu, 19 Mar 2026 15:59:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/14] object-name: backend-generic
 `repo_collect_ambiguous()`
Message-ID: <abwPTMKSmxb61Od0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260319-b4-pks-odb-source-abbrev-v1-7-5ddebad292b0@pks.im>
 <xmqqo6kjnbdz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6kjnbdz.fsf@gitster.g>

On Thu, Mar 19, 2026 at 07:26:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > those objects to a `struct oid_array`. This can be trivially achieved
> > in a generic way now that `odb_for_each_object()` has learned to yield
> > only objects that much such a prefix.
> 
> "much" -> "match"?

Indeed. Thanks!

Patrick
