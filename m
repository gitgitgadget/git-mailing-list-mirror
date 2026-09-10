Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F564A1DE0
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050422; cv=none; b=TULNqSOP3hjjMeyPs58XgTBZksJW2SYlBJ+V9bIh77PndrKUOgQungvN2FSqQLbjDBJat0JOKCdJ2rg0mN5csZrG5+FyMylAiHqX6mPD0kaDP4P1ERAw6iDOLZnjvLx6Z/2zJQeZLw92upG4I42/M/DLrmXrZt3IBq2xbcNp6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050422; c=relaxed/simple;
	bh=Lc66ip0RI5MVmfttBNwI1rYrQ8UEXQXi45WR5/qlUeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3WsBWw37JD2cMsYrvtfv+OZDypgNwC/hmiws4c2nzfjEJ8YgDgWdlXHdqb7kULdDj9fI6uBYo71QiVhUnVYSXFUBqsGFQqTGkaip7Ymm12N3TmIaFzrGYiDRam7lZeo94pxPHez2J/+mYnYGn+3tyLo0glBmfnVWPXHKq9W2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dn105Z/v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZaYzD6y9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dn105Z/v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZaYzD6y9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F519140006D;
	Thu, 10 Sep 2026 10:26:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 10 Sep 2026 10:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789050419; x=1789136819; bh=0lfWCkZMYS
	hZUugIrSLC+CShCvqpjI5RrJS0Evjh/0o=; b=dn105Z/vIYeGHz9gC1vr/Hkugr
	/e6rIQ8ZZ4yue8FNejY9iS32kuYBnWs2jlPeEJINol/aWjJkahhTUunCy3F/ORzE
	ciDijQD84s5GK9Y9b6CeChI8s9fkXhEP5Kw4gRhEao2CLjg+2NeXhybcnHJIcgeQ
	AehOPF4MyDWpYcyShUJffy9BxE/w8nkwdHYJQpJt8scVAYnwckTmJmdBlk/USgz3
	S0mHWn115lq9tMnvp/VS0PycP6tbXQOwBmpwn1b/+QYBMj2K+ag6yPYrd94GQ9Xn
	g72k2uMbkbJ+rpgwyzd3y4vhRxMqi6lLjbxnAyHsiA4I864UxSZCAhLiFc1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789050419; x=1789136819; bh=0lfWCkZMYShZUugIrSLC+CShCvqpjI5RrJS
	0Evjh/0o=; b=ZaYzD6y9rFbiFqm4zjjxvt5+s9yleDn+XWfitf8UnFlbw2+QTaw
	JNk2aQ9stQNECznSKjocK8SJ+q67sVa3erWJpygrLdjwtFIU5PZSsvItyOMvX1RI
	zVBCv9CoqGUIMERi/CQ96I2n5KAmwbGMtzS70LC6/dmb9D6/5SW9gZ1e9+DEXK4V
	4JrdiREzgpSKsMa+d6imNTM+7BHlQi/mjCp5Xyz3fdzvH+ZvnPHjF/OauHM+YIWi
	YAOgVomIw+y7p5zqg3QedmdFQeFx/Es5ozNE+EdJWzvg5KK3N/n5gJi4ixjro0VB
	67/7pDx69UgOWznbWSaxPIH2c9LR8cHYqJg==
X-ME-Sender: <xms:M76iahHBxiL_etaZ7IE2oHXWUcHo56QaUcRIMMKl-Vq4X6idPZnSVw>
    <xme:M76iatNg7jR1-L7wSV2Bke654kKjpTGeH-dMqTuqEyZDsDtGg6mxf6yCoUjGHThkO
    eDwpOfGlM1KDjzpU2pcZAwNSI5MLTDQTuYpLGw8Ve6626rWWE2_nyI>
X-ME-Received: <xmr:M76iardeE5T7OaylqtJwGe7fC9b8OMagMJyOCP_JIDEA3AZ00aNs9w>
X-ME-Proxy-Cause: dmFkZTGEP2cImBJzuW9v0KesgF+w1wMpVZ3xulVTy7KD/2Xd/qcAIepYSmd9Qw+51EWqNY
    mqFE6w99UhzPx2D23M01xLeIzhnpTDMVcfKLzyPI771OmpmUNjFybzbJC+SjUg1+rY/j/l
    9B4JOQi2oi+1Rr1iSwsb2a22SYP5r0PCWlrCz9ri2USCJ8MsXceNWgYkH8bfcZnksn5oTB
    wZ98VU/TkEjnxUCH+u2zyya7qqrSlZ4Mh3qNf7v6xEYaye1DV6ADXrBU2Me0SKEBYr4vF2
    Yw/d5+SP0F+Wp19ySgQJjGopqUoMnghkMSRKn0hvemJiZ7Zb+v18YQWtnNGSMQ01bzMDV8
    hKYxEwcuSV0tO5R8i7bLi5NoAx0zyOyuMwWAn1rPigexFEmO3Agnmcf1JNwfzP4BeNHcBy
    +LGM2qUT8hxCMI4StjDTH6LCaZ6olNVBrNQxOKyjpJN9pDv2TC+EgLL7zpUzghpVWwcufo
    c+ZbH0ivO48bMW7gxt4byhBezKKAiu5Zj6tSsoZhItq2jcIp/fy3rpI3hUoy0FD7+3ylYb
    z3b692QV78KeiKLKvCIKfd/NhCOPn+P2PLn7+WTxjBh4x6WunJJ6w+TdyPQqzpoB6EtIVC
    b2ZgO3bEDagatxP1wa3UKc8U4Eq+slM+1NDywP6kxwvVik22XWbwyY4Y1JeQ
X-ME-Proxy: <xmx:M76iaivorPt4EUsrepgRbHMWqe4pdvrRAlOJaPvwLqBVM4VzFBeTgg>
    <xmx:M76iakk57wedoCmG53R4XpxhSWytOfys2d2b6Za3Lh_wwFCUdja7HQ>
    <xmx:M76iasxTm2-bjp6qIq8WGxJi2dlq0AK9Yb-_TKNebgv3y1lWh8s0DA>
    <xmx:M76iauM9tZBXkM3vd0CFIiWxR7ntpVFl5vU_NgoMzzh5qXu5kD9RKA>
    <xmx:M76iavKzENcchLzP5cQZh3SS3Z3YkU5mHOkxaxE0vN9GD_VD5uyHt4Co>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 10:26:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8b3c54d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 14:26:57 +0000 (UTC)
Date: Thu, 10 Sep 2026 16:26:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 5/9] builtin/clone: move setup of alternates for
 shared local clones
Message-ID: <aqK-Lh6HEU1BCbBf@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-5-d8a78ffc32e4@pks.im>
 <CAOLa=ZRu6D16En7hSmT19geC6OvptRXQg98ZAaDgoh4X5Yc6qw@mail.gmail.com>
 <CAOLa=ZQLdB23c0b0tzUeYew=Gkqc11fLnROy0RUCUBg6qxxy4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQLdB23c0b0tzUeYew=Gkqc11fLnROy0RUCUBg6qxxy4w@mail.gmail.com>

On Thu, Sep 10, 2026 at 05:54:50AM -0500, Karthik Nayak wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> > Patrick Steinhardt <ps@pks.im> writes:
> >> diff --git a/builtin/clone.c b/builtin/clone.c
> >> index 8786a49332..011fc867c8 100644
> >> --- a/builtin/clone.c
> >> +++ b/builtin/clone.c
> >> @@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
> >>  		for_each_string_list(&option_optional_reference,
> >>  				     add_one_alternate, &data);
> >>  	}
> >> +
> >> +	if (is_local) {
> >>
> >
> > Shouldn't we also check for `option_shared` here?
> >
> >> +		struct strbuf commondir = STRBUF_INIT;
> >> +
> >> +		get_common_dir(&commondir, src_repo);
> >> +		if (option_shared)
> >> +			strvec_pushf(alternates, "%s/objects", commondir.buf);
> >> +
> 
> So we do it here, but then commondir is initiated but unused otherwise.

It is, yes. But this is done to prep for the next step, where the
`commondir` variable will be used regardless of whether or not we use
`option_shared`.

I'll adapt the commit message a bit.

Patrick
