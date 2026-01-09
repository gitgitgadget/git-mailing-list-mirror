Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703F1946C8
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958691; cv=none; b=c7jITk0+UVgcDhmZv7aiMpwDPnrKKUJCvy56b8GRKM01f9ztuSl0ZLufj2xNngEd6lBAhd+SgF20lNcbmy4CDnfUDw5q2X7Jf2GQ8b7Kjr9AL/GdGVfb1Mgd8fxrx6EtdngQHu8m7BhZn6nppen6fJYIWfW1Q1Ptw15hqfM+HwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958691; c=relaxed/simple;
	bh=cio8WC9r8TubcGTR5FyLM99LwCbammHY1IhPF4yb9v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4bB9+O+EURPFzI2zLAr1lmvZYB4BWOptFkqK5QbXbOEQ0JJEIN0uRDIsl8leovqckucEChYqgz0jJ/6Txu2H2xvySIt4bq0I7/Oj2fRwhigld+laYcpZ4nexKAQgQJbPJ2SCSAswBD9I8WKOUtIYmG/X/DCD3lHCyFnn3NQmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O4Gdkp7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOq+gSjg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O4Gdkp7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOq+gSjg"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C3CF2EC01F7;
	Fri,  9 Jan 2026 06:38:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 09 Jan 2026 06:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767958688; x=1768045088; bh=37d/fsuMQx
	/nyS9Q01vPLG1M1QqvgOA6KDGy4u5auC4=; b=O4Gdkp7k+7v2OyGfdZmohWraG2
	B0J3Ozc5r7qEXel67F4CwuyNfFLk+eMK0kRFAzHJNo8WypzXv6hO18D+HhW8HiBt
	fMTOiz/+xA7clviX7F3x2eH/HteuIR3PfufZf3nyIyBjmqsJZ9Conapsh43kYN8V
	xDokdHZD/nzJ3HuhmYIbvZUzouzzez/rQV0QZDf+Qw/y2gyjtqti1NK8RdeRDzBp
	16dnhU4Wx1v1vu/+EUpqE1X4H5j7zhWUGO7s+AFeakFII9ZbG32SxjNsWlRG1XFQ
	frOeOSCw/wxJimAaBgu6AMBfzYjXfo5t5g5LvXlxkosfdtWB+B+GKmahUBgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767958688; x=1768045088; bh=37d/fsuMQx/nyS9Q01vPLG1M1QqvgOA6KDG
	y4u5auC4=; b=cOq+gSjg6+1nfJ+9ygSkQ91cJvk7aEcY8oxDqZQ+9S4wD1kP1Uy
	h4UCR0zo6BAbAAi4Sf7S4gXztT+iY7afNnfO+GdcQ0yOz3roZY85yy/0FWRvsiFy
	l8EELrWyqonFiaDIvm5b1K+bmYHosSuTii26k7jk2TBOOElu5uIPF1z0kOqCHtV9
	EOmo6ZelCF/dvncK+e+t1/svoHzwUn+YqPrz6aOxd8ikYr6rDakzzoz/b4Y4nGkm
	MquLUsoJZCohGRHDvHSPTFgGAXKJN/BPUny41e1vFcEM7H50H2iec3tqCHYieOYD
	t7zQHrruBYNDofcrTTDGO1XjpSEN1g1DMxQ==
X-ME-Sender: <xms:oOhgaUhDRB4PE5hevwwXr4s_sijzJlivxWzIR8j-uK8h3gfXiYWM9g>
    <xme:oOhgaUdNtV-1fuztGQoMbjzHjSxQ1jdtNI3T6G0-q03FPmnWgKtF_CWhHBfRMjynO
    VgBTTr3nYZm7tyfHX4EfSzAMnMY0noimWBF0QgHFUsT4cRKryK4oA>
X-ME-Received: <xmr:oOhgaZe5kacRN7XdFFLK9RuI2G2CHOAfUGOrVmTEm2j3mxDrPobHvdaZea6FphFkAhO4Cbk93PrVcqI-HHykiY252rAqMicTrY-d6hlSSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:oOhgae8yyDcYmJTJF703kfN_sBr5t2oLahu6MH8UAHMyiCgIGFZEvA>
    <xmx:oOhgaVnltT4F50Q40ZavSk-Fi6JBIdBMpopT9I_hES8zFaZBl3iRzg>
    <xmx:oOhgaQ8eHsZUFApFzD6YSptEjSCDnGYetidW_p2b7XQ5sUaClHNfmQ>
    <xmx:oOhgaTlQe48WU59cI0iJUgluzBUst54xHf2LpC45jw44YKozgnWe5w>
    <xmx:oOhgacnqW5kKC4VaOELEHphJOX5idcHApCHkBll9ch7QJFYOI1HbQ9Zz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 06:38:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53a17f4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 11:38:06 +0000 (UTC)
Date: Fri, 9 Jan 2026 12:38:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 0/6] doc: patch-id: six small improvements
Message-ID: <aWDom0myZVrO9au6@pks.im>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CV_doc_patch-id_3.1ab@msgid.xyz>

On Thu, Jan 08, 2026 at 07:28:14AM +0100, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Topic name: kh/doc-patch-id-3
> 
> Topic summary: Improvements to git-patch-id(1).  Fix git-diff-tree(1)
> mention, Fix '--verbatim' documentation, and four other small
> improvements.
> 
> This is the third patch series for git-patch-id(1). This one only has
> small improvements.

Except for the small nit that you yourself noticed on the last patch all
of these patches look like obvious improvements to me. Thanks!

Patrick
