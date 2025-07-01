Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0E273D78
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372286; cv=none; b=f7569yAKTO6akBmvIl+72jRBlbfC5N5KR2jd2BzmR7XBjXOkkY/fTPRLeXgGL1yTGyYArR209+a6FDpjTC4peR2kHi14UlYnCHyESp2G/7WhuESLW1ohKdePpe+i0sqa8NO9BCyD7sizhnItGF6RwY9bp8fgH23hHBe6ve37Alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372286; c=relaxed/simple;
	bh=Qlx+8QS+6iS3NdIt1l6l9ScaqONPo9lsrEbcVAffErs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgvvsy4UQ6wADyDt3Ahz6jCqvxrCHKc9q7S/974eXVnc6mHvjNX1+Dg8WQNdecgKdLRc6sGlCcTYk7vgIpzybBBUldvbXNu+mh58d1j+lGgD7Hvl1uEYJU1DUd3Y35BeyOUGSqiQDfd1G2MEuAjRcH9phYBf2pea9b0wPUce5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W6T4+Iy3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7M7J8Ui; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W6T4+Iy3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7M7J8Ui"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75AE714002FF;
	Tue,  1 Jul 2025 08:18:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 01 Jul 2025 08:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751372283; x=1751458683; bh=SsxbHXfhCa
	Nmka9sg9D3tBzu0zYCM92R3YHHInIzXhE=; b=W6T4+Iy3YPi90H5VNc+cZdqpu1
	BfagSCQ3iknRyE+apCsVuuY4VXp/9mFE+t6vWzInXB6nkmTt6vQljnzZy2TgUdOH
	iwGjHg68I4lK5CPCNOku//FGyx8ytSw6ilrzEPIY010SqdmRBqH4bO/pUbW8Del6
	KaSBk92sdJxV3PpUaeJjEVXqpUSxK1BDmqo55idfw/JODo+uB3Fj6KI8rkFq3kXL
	L4+x2OiJFwLH4bwFRUlIdYNNwnuQiznVA8v5CkDTV9aSAf1p1v5g+0RFO1QTumq1
	QMB2RfbxTKU1NR9xsLw/kNe/YmeUJb26O3Lnzht18ozXGiu0R2n/triA+lfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751372283; x=1751458683; bh=SsxbHXfhCaNmka9sg9D3tBzu0zYCM92R3YH
	HInIzXhE=; b=b7M7J8UiihOErZMryXwJuab4VXKQ+gOyziY7lZrK8kSH/NVx+j5
	Gi/i6FgjKU/0ZKnVpXcFxfDK9dShuD6qnbjAm+cAveWFZuCHWZkhFzFGZgitghXC
	TvtTds/b3cJPkLqRSVte/sJBJrA45l5xYdSORc797xKiavmU8HUGu2WEjGIInUG5
	zlVDxX9uIeGy+WW5B9erUFN7XPPjCPsuM74+oWZ4ba1g2Cb9FYDYz+3G9cI6+8J6
	waVi2svqJPL0L/FPU+rYqhkEvOA/3/anbeToslYBgGjOh8MEnM4aIrSMVXCbibmf
	H9XEbqNBE98WMANRNIg5J9uRmcpX3NaRO5g==
X-ME-Sender: <xms:-9FjaF1Ak-1KpbQcd2VuTU2LKEWI-_qzWcOYXtSv2RuZilS0fzfrhw>
    <xme:-9FjaMEROLcuURuxymfjDgDRd7hebFuzEmKZaVyKwDSl69kG7-3kjn8RwHliLBOwV
    6nWy-6tzlaZfaGFuw>
X-ME-Received: <xmr:-9FjaF5NHxY11P_PWKD-e5qm4Mzc2G3y0KlskgSdfl1m24bVV_RNPPJh39i40zHTHx-Bz_-yyo42jjCBwmbwVJHVcOrLRsZ5J-M6MzFuTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-9FjaC3RYabyGUUE0o4ZRjHqbTG80GaAiJgm7PrYIzAwa5TCF_TBCA>
    <xmx:-9FjaIFCVNHhqc4xqsMNfdxUM4LAR1sOPgX-mRiJ0OXwgOSoza08bQ>
    <xmx:-9FjaD_TcoJfsbR74R8e0GH50ykEdXjGXjdPAV9XD3DEA4zyxzbGhA>
    <xmx:-9FjaFkdYIduy3el5N6fIsAxIWp_i_hfyBYxBYU6OQ8UHIyDNkVLfg>
    <xmx:-9FjaGdgNIjWVs1sCzGFRc9p1EKkU7YaeXeKdSqWljINJnJv4PRqSXam>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:18:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7a98275 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:18:02 +0000 (UTC)
Date: Tue, 1 Jul 2025 14:17:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 04/17] odb: introduce parent pointers
Message-ID: <aGPR9zMyN1AZ4uUh@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-4-779d1c28774b@pks.im>
 <xgbzzqyfnfmjmtucnq3qd3bfqdal6vjkaap3xfspeetbs6ontk@4vclbvlreere>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xgbzzqyfnfmjmtucnq3qd3bfqdal6vjkaap3xfspeetbs6ontk@4vclbvlreere>

On Sun, Jun 29, 2025 at 09:34:12PM -0500, Justin Tobler wrote:
> > @@ -167,22 +171,23 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
> >  	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
> >  		strbuf_setlen(&pathbuf, pathbuf.len - 1);
> >  
> > -	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
> > +	if (!alt_odb_usable(odb, &pathbuf, normalized_objdir, &pos))
> >  		goto error;
> >  
> >  	CALLOC_ARRAY(alternate, 1);
> > -	/* pathbuf.buf is already in r->objects->source_by_path */
> > +	alternate->odb = odb;
> > +	/* pathbuf.buf is already in r->objects->alternate_by_path */
> 
> Should this comment instead say "odb->source_by_path"?
> 
> The remaining restructuring in this patch looks good.

Ah, good catch. I think I botched conflict resolution here.

Patrick
