Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BB230BC1
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389163; cv=none; b=dWMbjvft/bzXvT5aJ0OqJSeYeyP+kMqsnRw6PiGYhx3b+D+5GToqsPckwGLbSqk/DeybclRSs9/wp5J0MNao7t3il10+CU76U454QQpnz7NxAWgHP8n3eOdacsjo11iJkl6UDxjoWZ2UYCQaCJQxe1DeXhiWQz1TPjWp21q+I+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389163; c=relaxed/simple;
	bh=cL3tZH5Oc0ugebZo+mURZjdRpweJei/3zTXEpsLY8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUVkSSqENqvi1uxYUB/cc44cMGO8DfhbkZYzl7ZoYP6+mz5shetyM4NuXzER/7wbCu+l54WYoYblx/7gWgGzd1jMgyeoa3/ViFJehoZ6seVQQa2K+2WvJQV8wkJI8SH6jomZDj7Gt3ws/UNwID/66El2UfCqe0tzsG0JkYZW6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pG7wc+4P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZT6EwRjY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pG7wc+4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZT6EwRjY"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27976114016F;
	Fri, 16 May 2025 05:52:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 16 May 2025 05:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747389161; x=1747475561; bh=WQhnbYwIzO
	BPebihf9O7NJF5ossNdfdxTIP1w496RDY=; b=pG7wc+4P6/iUL6OMBgzq3Jk14r
	qVb+mGgJVsrDFD/fvAFiVYa6jB9jXuz2uvZ7nuk323VA8VdweYIjMvf36c2UBK1M
	DGCiCQ3b2btORmYlcQRCj4IUl5/zrjsV1iYpHuOhZ3wOve09XZiaTxm6wLEH9FWY
	aoD6gH1p9l8GnNTcxRVyoHXv4RsmSvqpMIYPl0xF8B9MCKoS/uPoudeNLq6r9LNb
	JBaUqRTXRQa8SDfLuDoOtzqjpzZ4TMd9uQAV5HZ+WjE3dxdMBpn4kt/DLcG/ARCG
	IN08hQCFR41GIOMNPhy1Bl3r8qorD86QzuaWnLZropH8aIn8QCBSWFRk6pOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747389161; x=1747475561; bh=WQhnbYwIzOBPebihf9O7NJF5ossNdfdxTIP
	1w496RDY=; b=ZT6EwRjYZlpX1uJQXQMW9eF2E6GAHHRmDIGgqHOHXwRTXQe7I9t
	JWVrUDn0h037ORGczVEiVLz3e1e55KYPSeWT+GgEtBkt8ucP18F9H8DvRUfK3ec0
	4uNq79U1EIkEy1TCWoM/3QZ5Pt4O3smC6/BmFxzyIJry2MrE3OHqClXGIuSZIzw6
	GqCS9TcAA4JK8QF1imOleK9JKS4FU/HcOEYYKZgPs7v9klJIZodY51gL47sXkb+f
	9SWOKgo8BPo803vrEFo8VAYw0MQRJOhaYJ7EYAOt+VuYJ3JCiEBePCBLvoFgo1dv
	XNntuxPWAmGOT9hnk76rDbEfnVmm6UhZIzA==
X-ME-Sender: <xms:6AonaBCb-ukafNiwD04rWKpRE7RBvvLUrgH-2Dr2KQPwHds6yvZ5Dg>
    <xme:6AonaPiBuuHaCB0VSwaliBu2NZV8pKcJC7_GO_YXJ44QwVIOLMjJFScsRdYHMjTQi
    UUGLP6kOQmHncdGZw>
X-ME-Received: <xmr:6AonaMl-LoVBtIY3NlWuYm_r2nKRGAQAL0PqAmVfBdQLPtc8P39DLYI_OFWy0oJ49uqC1zclKSzvRCCKxj5siL3Dl5F8MtaJGw-i5XGZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:6AonaLz94-46fKPbdE9Zh4iIJOwi1_m168zztso8QqWIkAjS6KUG2A>
    <xmx:6AonaGS1nbq9oWMN_hARjCmQvTms6-jLCBUsPEPg1dl4qMCEQChzYQ>
    <xmx:6AonaOavNJcxBI7_EOwaWso4jzq4Erhv_b6x_Wc1jbanXshOLyv1qw>
    <xmx:6AonaHQaHcbgHCUEyY9e0p5N3ioPySducT8fU2g7j9aE5iwa1m3wUg>
    <xmx:6QonaHL-PmqynswzwxWT5wURdx9ga0xeMvEOMy1liZJAC0Bum099ynsd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 05:52:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2312b7d7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 09:52:39 +0000 (UTC)
Date: Fri, 16 May 2025 11:52:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/13] hash-object: merge HASH_* and INDEX_* flags
Message-ID: <aCcK5iF3h2j4gQf7@pks.im>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516045008.GK22242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516045008.GK22242@coredump.intra.peff.net>

On Fri, May 16, 2025 at 12:50:08AM -0400, Jeff King wrote:
> The hash-object command has its own custom flag bits that it sets based
> on command-line options. But since we dropped hash_literally() in the
> previous commit, the only thing we do with those flag bits is convert
> them directly into "index_flags" to pass to index_fd().
> 
> This extra layer of indirection makes the code harder to read and reason
> about. Let's just use the INDEX_* flags directly.

Heh, coming full circle with 70c0f9db4e0 (object-file: split up concerns
of `HASH_*` flags, 2025-04-15). But I agree, now that we have dropped
the `hash_literally()` function this is a sensible change.

Patrick
