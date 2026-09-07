Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7A3AE1A2
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765824; cv=none; b=PF8p5HoeZdgoLdtnFsEiJJ/R28ffIG5QNq8BXLJ/gDypNmEdgPTIoUrAkrCeJT81SUGz4v3PHd75wGnB336s8/5H1ZVLQXObprgfDqpQv4CMGNg2txpouXBRu7zquVUYqOa+03S37VU5POeB0mDjMt/iOkXMsRgJZdmJ0sTtsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765824; c=relaxed/simple;
	bh=9Gt0eye0Wbtz3xSGS7xTFH39uojwCoKHMMH2Znoiyro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaRQvvVK6XMmuT0vlzaecbDrM4EgClCg5qSapzY/htpq1+JG7NlUaJICzHbeKa1idkuAlxbGwabRmNxg8gDslWXfd7oT9inti5lcf5Cy3mxpE+WgS2Rd1C6mhle4WpcAkjvtebJ+HtNezkFYU/o6+1nedWF9IMVAMqJUNMKeoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yVPDHKNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASxnDOQ5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yVPDHKNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASxnDOQ5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AC8F7EC0258;
	Mon,  7 Sep 2026 03:23:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 03:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788765821; x=1788852221; bh=lFw8Ji8ytD
	z/ig0z7Fk06J566rsZXhBOwuZFJXVARyg=; b=yVPDHKNEaGYhKhcchnIDyyLpcU
	AFuu+amnzCGIRH1vmNhphMRLMMTns+quKWB3IQ1jyf6d3AyVGqkL6sphW7LB/glt
	vagzNHHh/1gDTl9AEu1+gPG4hVMPc1Wub/8FW3PR3ywKSLnDg18TrE/XqtkPmgeF
	qLjylYcjg2lxT14iqSL7akJN7XE8MeOuf3fQbPJJ/g3Km5OPowYlI0HdzUTtxbRt
	To2+JDs9BTs1x9UTya/2zxO7m+tiL/PIK7khlXbnlgxg0tU5kTWrIhFJ0hsyKx55
	sPY0b5k2OA/SPdO3sc1lsZIudRIYIT0299R1iRFTDNWkcFK3cC4l0SfN2buw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788765821; x=1788852221; bh=lFw8Ji8ytDz/ig0z7Fk06J566rsZXhBOwuZ
	FJXVARyg=; b=ASxnDOQ5HsiX7BKFg/GBlvqx+MlC41mj2togL2ru4SBEit7cyhQ
	yxDg485DvRAfLpYj93KeBmdupVtNIHM4XAaAkrotK6/1OldPJ/H4wteUvCTOSdMu
	/twrOWtEiywiHGxptBJZy2sWNlxdMav/BgoWzhwXiuCPnn4S99ncsZNu3Fvnvz0v
	h6deW0YT0CDnGutCRoUFwSeEXX9QdC0Y2FvuQcW7iu2M5u0NABNweYZel1xAD5p8
	B1HIVrpAJZab3EbkBLLN0p0Pve4uMxPyYhxpZH7o8i7LnJVxILlL2dvtSv5sE7kg
	mpDSAIqUb6rFzmhExwSAPcMpfYJK6jpnvRg==
X-ME-Sender: <xms:fWaeagwfIylK9F8UOFky7guvmL-yzVPykH8d9Ok3YrP2lEQKzFIleA>
    <xme:fWaearTAF3y0o88sTzSLTpuUVJF205XePKGBYHn0iBd6xMFwqzBD3zCKY0VfLYjY6
    -7PoylY_PGFabeGTeyzLxx4VXuWpdnv6z7kY2mQAprgD9Bi2YszrA>
X-ME-Received: <xmr:fWaeanXSGFmtn8j_Ne61fwqq4_JD3ah3WnoAFmGHspIQ9McqKYlSNA>
X-ME-Proxy-Cause: dmFkZTFo/X8otW/j3M+0BIqpUIHZ+tBmESP3UMI9agA6FmK31kLZgtzzGcE+Pz5kq8akBr
    91C4PJBV5XbIMHRtOP0qE+47qidOf4kLMEqzuUnVQA13Cw8rsdJTDzhmNm3YQRksYREQGs
    wgdA0FoCipDcFDzNieyCSd60Ie8URvTAjNh6WJhOXILZrkJXV4rN8UvqbGKCvJ7J2x5GJj
    6Axale++yhARYjxAAgUrLbO0rfgpPnLVBy18pb9yLvwiOAXMqRaSzVyUaVJOcuT3OWSV8q
    W76bwUedwC+FAf8+8MdqlvqotS9+mACxg6dA/5htelUx+pLSzS8LiPxbWKlwt8DlHcPdKW
    iwj95PoqBdRD5WF3+4dWXnuDs6RtjWlWfvIiSmeOj7F6VqJxAIk6n5u4HuJ9Uytqbpy4Vv
    N+6jLOliyw5oJqFUvfob2bWt0KMXVYu8DGiTpuiqw8LyuqAEhhy9HQK2zWKn9+lcDybUnW
    hQY+wzxqtd1lOdSr4S0pqkQ3Pt0spAEJVwIB1Pd1bZA8dctenIhrXXENefe3N6nO8BBUbl
    IgkiqP9m+lpXAdAocX2+XHEMHWe3OLmKNeCnD8bowIuXiygTv3fewwdCQsERSfEyzKUoQI
    Gr7CYVmwkHNDHK+0d+NEDnJRDyKf1UhotrSUyjD90LhEsK0eH2JCQ2cEq+sg
X-ME-Proxy: <xmx:fWaeatbHoo_JDrpNfYgzMsnUvkeCoHLOnIBtaYne29_wBp_esQ3KCQ>
    <xmx:fWaeat2PYuKK5qvzZHRRNnGWUqWcbV96vuZzEfAvXsFwHmb6EQAN5A>
    <xmx:fWaeavgcioXaqIIiy4OB8XNdUUpS_2cCC0EcjD_zFNpjpQgGhgk1-g>
    <xmx:fWaeahY5YD4vGo703WvQoc76nA8xEvltbl3l27q4-vN5ypOHmIyhMw>
    <xmx:fWaeamWPJvtcNGd6f_DXyFVaeh1qDGrm5RQSFXzOfThtHIVoUHwPhyk4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 03:23:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28d94226 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 07:23:39 +0000 (UTC)
Date: Mon, 7 Sep 2026 09:23:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] odb/source: support writing alternates when
 creating the database
Message-ID: <ap5medBVRZbjI0gM@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
 <20260831-pks-odb-write-alternates-at-creation-time-v2-6-aecd2382ba1c@pks.im>
 <ap2bu85Ut_bN4wkt@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap2bu85Ut_bN4wkt@denethor>

On Sun, Sep 06, 2026 at 12:02:57PM -0500, Justin Tobler wrote:
> On 26/08/31 12:02PM, Patrick Steinhardt wrote:
> > +struct odb_create_on_disk_options {
> > +	/*
> > +	 * Alternates that shall be written into the newly created object
> > +	 * database. Whether or not this option can be handled is specific to
> > +	 * the backend.
> > +	 */
> > +	const struct strvec *alternates;
> > +};
> 
> So ODB interface here still exposes a way to signal alternates to the
> backend, but an alternative backend may not actually use alternates at
> all. Out of curiousity, does this mean git-clone(1) options such as
> "--shared" should only be allowed to work with the "files" backend? Or
> should the expected behavior of such options just be backend specific?

The latter. It's totally feasible that an alternative backend may
support alternates, but it's also feasible that it doesn't.

Patrick
