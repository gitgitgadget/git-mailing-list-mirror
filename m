Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443FE56E
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397682; cv=none; b=Z2/qaHDIGWburOLQswNIS8UT2JzrQ4eZKltaGBJAmB6ZRvmt6bsUby47K4YNJkBrvD07zlBhkrvA61qj3MUWjvgabUU/GB3HgXGPfPqPMPx1HganoZakPkx2bc73RZHo4G9+3WGevv9B09lJM/s51qmmM0w59aWZp+XYXZo5N14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397682; c=relaxed/simple;
	bh=WsEa2rTkwF3d9hc6ADx+f+xgr/gEpEOExuz6764OQuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBg1p9FDzkosO6+Xs/OsoDIJkNPRsC0leUorA57E9iMozvltN+VuBUiqHU+MJfhzc3D0dej8IVDCsGmxabTKjZLwvFQ3NJJafUVmIxLyZmpUKpeu5xShdb1qJIbRSwhUv2gDeYOVdxxubLE/Xn/xqDnYXT4N83YO/d4ty0DCx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzoYOxTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqfhwyzD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzoYOxTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqfhwyzD"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 82457114677D;
	Fri, 23 Aug 2024 03:21:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Aug 2024 03:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724397679; x=1724484079; bh=0gUIJAygUU
	tmdM4A3uIZgYlqgVKyOlWhVYbxK4OWbG4=; b=hzoYOxTBM+QtmrDTo0lmetuNij
	3vAo/datFjABbegQmrPBxacSwvrYGa7dZhJdoOCiu+BXjpVv2/ncmfnThi75DU3b
	d9+oo5JN9ZoU2msanmoSibW6SUKEkCkS2qpRQJip5vccNIKOBEMDa/ojuOebTSgG
	z3gLnjdiB0wDSpbyt4iHIPDcZy0g0kwA81/PIUZSHdeapMQKFtdnO3WN+J1XGtFk
	a52f1RkLfyt7Ialt2QkDi7hsTVFa2jBLzMeJk2y7aMn25EPcce3+wIbrWTpCQtn8
	6McbhUwvyGKe3ahBQyhfBHpU+I7PWQiepQDWce2go3PO1wieiTcC+JYd8DFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724397679; x=1724484079; bh=0gUIJAygUUtmdM4A3uIZgYlqgVKy
	OlWhVYbxK4OWbG4=; b=eqfhwyzDRjFrnW0qOrFqyc7Tuw2aG27nDkOiWVKJPVQE
	jf+eT/EzhJHX6SPZxFU65R+kYtrD1N7lanN2NCJ/y8aySlmlMFTBRXoUPSXdK8sM
	jNTJnzaX3lOEu0xiIVQ9QAg05R5/AtsKAImGG0Ul5uPj2fOJQT/FU6ymcJOg8Yn6
	NLngTqhpt2T46O1bLkDhUVyW4tenLqOTvgHEBWucVu6C6AdZSSzY7NcYljxpvcTQ
	4XY5Z+2znYSVSyN+Tc33EqDtf//LN1P+xPjJrz8+plPQxMKpx1xiOtDnnmVIRsNa
	NueVq+wsbShneR3CscBveFj9DemZ+xMF8YIxsKHRhA==
X-ME-Sender: <xms:bzjIZn4niBBAVZsMfD4vvRMzfeFO1kkKyRJ4a0fgeSMdJhhe84ecNg>
    <xme:bzjIZs4gklEFS35HmGv6XZZM0LSe_1QDD7X5BFPKtsdleIwpXct6k0Jo28DSse5O9
    Uu0Mu7Sd8omy_dRvA>
X-ME-Received: <xmr:bzjIZudj-d3AsWXi0TJ8wMwhIYvWO-CRsx2rYLnbitNWlstM6V9oDsqUuYRNgbgSWRr3iYSPLoKkQCZlhV87AXiQS6uW22-KmCAUXqr7olTZJB78tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvuddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bzjIZoJ_yEK889iGbxNXToSXu_0EqzS5WQpZP8lnM1qUVoi_35stZw>
    <xmx:bzjIZrLaCBYSwGw6JMZT8N9Kt9jUd21pXLtaQZ71OJkyLJLEm0-N7g>
    <xmx:bzjIZhymP88GQ2HcBqn4vx8AjMvIP7vMBEScmcuXQDcMHiXpKMnJ5w>
    <xmx:bzjIZnJzxElrXWRN0KTJw2udS00RunI4VB9vRUPfaGi1mmdq20BJcA>
    <xmx:bzjIZoE-clixmJYfm3jIz0mkgmuZXemTXaSzH52Cvl7gBbuIqKheVu3p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 03:21:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ceda6c6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 07:20:39 +0000 (UTC)
Date: Fri, 23 Aug 2024 09:21:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zsg4ZLHFD4nzISc6@tanuki>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM2DRDbJsvNjAM@ArchLinux>
 <xmqqed6j9m24.fsf@gitster.g>
 <Zsb64NTyqc_oHNFO@tanuki>
 <xmqq1q2gtu19.fsf@gitster.g>
 <xmqqwmk8sfaz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmk8sfaz.fsf@gitster.g>

On Thu, Aug 22, 2024 at 09:17:08AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> So any reference that contains additional data is not a proper ref and
> >> thus should be warned about from my point of view. No Git tooling should
> >> write them, so if something does it's a red flag to me.
> >
> > If you find such a file in $GIT_DIR/refs/ hierarchy, because our
> > consumer side has been looser than necessary forever, and we never
> > have written such a file ourselves, it is a sign that a third-party
> > tool wrote it, and that the third-party tool used our reader
> > implementation as the specification.  That is why I am hesitant to
> > retroactively tighten the rules like this patch does.
> 
> I forgot to add my recommended course of action, without which a
> review is worth much less X-<.
> 
> I am OK if we tightened the rules retroactively, as long as it
> starts as a probing check (i.e. "info: we found an unusual thing
> in the wild. Please report this to us so that we can ask you for
> more details like how such a ref that would violate a rule that was
> retroactively tightened got there", not "error: malformed ref").

Okay, that makes sense. The fsck infrastructure does have info message
types, so this should certainly be doable. I'd argue that we might want
to make this an `FSCK_WARN`, but I'm also fine with iteratively bumping
up the severity from INFO to WARN to ERROR when we don't observe any
complaints about this tightening.

Patrick
