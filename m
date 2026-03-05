Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF48248F66
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716062; cv=none; b=HieN5L/G63IJDmeBvUDXlPROwoNpSpA45r93RlCncl9bbRAH/wIXrFtm9sp42kESkU8DpYGVq8eKsWOU5ezL9OY0fKX0ZELWxiDKphgKQ8uaT0u/eagVYOcZAXGewMPLXWEc9nhyYIFMMASWHr23d/S+PRmlPTY5Bq4kKVYwC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716062; c=relaxed/simple;
	bh=uPH2PxKR1cbIsQ2cFBiuUwv/Hm2BZNrHl5t63HVSeOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8hf4hhZSKcffjElAE5xzdrEQQFBxZ/jezPlGMaGOexHd5HyXq//wHmEwu6rYq22cZTnKNhQAbUf+OnmfVe8ClbPORSv+Rak2OQaLU16/6SYftWHTWI+tfObaWu4e5V/P8O0Axoq69+sTp6vdCgxdto/57FFBkzuXAI+7NbwGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WJOgtCkQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qFRfbCv3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WJOgtCkQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qFRfbCv3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 241C47A01B3;
	Thu,  5 Mar 2026 08:07:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 08:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772716059; x=1772802459; bh=diaLLGx6qA
	kLHxo8BY8oqMisWNWediB8DZA4WXahT3w=; b=WJOgtCkQ4Y6PwGuZx1BrFK6AIb
	4wwqb74AOUPjemJR0t6Wq5U3OjfUgiW1MXAAfPXDJYrYYmI2l4LrOuYrbSr3Y//T
	yoFfaHQPUVyu4Fphc8IXV71kOz61GLnRyUTiBRukAbAufQziS/AnJ2TX8soollZd
	LU2cFcmq7WhDf3XkPp1IM21drQY1apICTU2Ut3xnJWTJbchvVVFNkrKWPnHdvjAW
	4On/kqB3LgJE9ZLPh2kkeufPjSYNdushDpzNhRGUo3VM02IrfpDYrQy1DVdjQsiH
	YYTfYBNLx7HFKj20uEk6kED9ZorhJH7wDo4gcNzVpFvzirBZI+ZrUcKM2DWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772716059; x=1772802459; bh=diaLLGx6qAkLHxo8BY8oqMisWNWediB8DZA
	4WXahT3w=; b=qFRfbCv3CCUXAHAU8bNH3klBmO4dNR1nw4gcjhE7wWvwF8v/Sha
	m/jJQlhrBMxopXaigQ5/RB1xfJQhXQddy7uScNKl593QDX62uuFjc1eBzhoN2dSy
	YsGYCUAKr+0cQwBl8AGH83gdetiOnaWPqG/hku/YhrHhhCFksp0zI8SF/htBQoM4
	5Lry9cQirN+f9PK6FMHD/MMV7+evqSUodnxtiA5ELqTKwdvtgvPuu8KiXSco4qbD
	gmdqRxnITVGdWPq2qnaDo+u3OEL7eRYJp7LyUZ24CCFvMLnUzFhnzMEsSxVAN8vB
	lKjN3q2t1V1FkuyVUJQBtibi8vDpi4hpkLQ==
X-ME-Sender: <xms:G4CpaUuLbBIJZ8awAiFFIrs6ft41un_4sNJHVIr5H5hXZAYgjdwNpQ>
    <xme:G4CpaXdQFKnDXfhBXFniWEXo9-ZpG7NSdbylK3q2KHhPDQH1lDXmFphCt6MI8QS_R
    ceP7Rp52iX7DsQp82GBXhSyOHbEAkv1XAqWodYPQKQBPHSuJw>
X-ME-Received: <xmr:G4CpadYi7tH4i1MSUipJWuFXlpFMTEaB9AbTaqEL90pAqnKu_nTTU7jjJf4pD-2z1gl69HOUSKE23yVYzpsWFAq1EtZNEAetgb4wJcZfU-FC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G4CpaSVi0y4DhDErHQIXrvryC-tlU-VFfwk1ISsii04hS9lWHKonCg>
    <xmx:G4CpaXiFEFSveINv2LL4xejBhsG-PuIY3syAegJa4TOhdbKwdeBinw>
    <xmx:G4CpaYWPKlvVFL60D6VQW7aT8s9zqVl5r8-q7QzfeBn5MPDM8RFyMw>
    <xmx:G4CpaWNMQY7Ckn2XOug1QrGD7GNAdm8MOxDSelFes45VWDcwjd6AWA>
    <xmx:G4CpafcCBtSX3-4QW2FbqwMS1rbF7ZaNe-Tqdn_kpDr6gqENUZCbcxof>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:07:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bb8444d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:07:37 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:07:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/17] odb/source: introduce source type for robustness
Message-ID: <aamAFv0kEU-plSE_@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-5-253bac1db598@pks.im>
 <aaiZTjrK2oHpqmVQ@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaiZTjrK2oHpqmVQ@denethor>

On Wed, Mar 04, 2026 at 02:46:38PM -0600, Justin Tobler wrote:
> On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> > When a caller holds a `struct odb_source`, they have no way of telling
> > what type the source is. This doesn't really cause any problems in the
> > current status quo as we only have a single type anyway, "files". But
> > going forward we expect to add more types, and if so it will become
> > necessary to tell the sources apart.
> 
> In this patch, it looks like are only using the ODB source "type" to
> know to properly BUG() out when downcasting. Do we anticipate other uses
> here?

Yup. There are sites in Git that simply need to know the type of the
source because of functionality that is deeply entangled with the files
backend. And in such cases we'll have to determine the type of a
specific ODB source so that we can act accordingly.

The number of such callsites should be low, and they should decrease
over time. But some simply won't go away.

> > Introduce a new enum to cover this use case and assert that the given
> > source actually matches the target source when performing the downcast.
> 
> Does these mean all future source types would be required to have their
> own enum value defined?

Yes. In an integration branch I have four different backends: "files",
"loose", "packed" and "inmemory".

Patrick
