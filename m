Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB030B51E
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627487; cv=none; b=Fn6Bw3gs/cjB+E1DIpbSj7mPVvv8AO5RNSMb9MgD+VmXxHADC5xP/ss4QgDP82X8SR4yy/AxN/So3X4TtD6IuRNL/JYRghpTySkIBgT86YJ62q/saJI6bGaev/OThOQRtJDRXxK0hQswq2zhzzrvTAVql7Y/wLQwCrICfwYUT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627487; c=relaxed/simple;
	bh=UdzzUkr7IrbbqSCbE1I0B1apKcd5oq/4FBe9npDEQ3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bsm1AxcSc28xv8LbocjHbi8StipHVHsX+aXCyj8Q7ceu7aACssp/rJFtWd7nvZFmjtd3E4jdfVViD3oarSjg2SOs5ryEMgDfSCrMjV9PNUKPlJ6fXTeYcqTD+jn89t4emQkzNvTrKVOHWHPv1KZFGNdLec3XEJr/O8Rnj1NDDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f+zfGWa0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSLOlGMx; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f+zfGWa0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSLOlGMx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BFD8F1D00084;
	Fri, 27 Mar 2026 12:04:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 12:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774627485; x=1774713885; bh=JZhMHb5ahd
	95lihUy2CI5mGzFs8llLh5QRtNNb9DpAo=; b=f+zfGWa0r/h5co6dClPkzRY5US
	08tQB39ylA0aLEdeks9Zn6rTq4r6iBKtmdxnz0zLCrGB0ntT3oyg/7aYczD/XFhp
	yCmTQ5BEekXO1xyq2MEf6Q8O4i3R4SvwdWy4ylhoLhU9/2HcUClcrw5r0Wy5dw/U
	lSjp8dwPDH2vMxAc7P8sv/V6snCBTktVzQY+lgvfIAgTMpoCuElwdWSEx10PIsKL
	47aucOUCoPvANf6orOGNJoC+sRIAngqrk2zOPCtaubstqfioOKRS9mTOtiKZWD69
	vWFnp6pB6v0JQIKn7sepw183Gb92x8VVfkqyRvE7ctxAifjMSUV4hYQgNn7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774627485; x=1774713885; bh=JZhMHb5ahd95lihUy2CI5mGzFs8llLh5QRt
	NNb9DpAo=; b=fSLOlGMxuDYG26zh1oMvxjrR1ewqSmMbCb3mUAZgLqQBk5SqLHc
	jOz6mUMtt19aygS+R130SA59g31hyPjeENL2zXrQIhHX2KRbpmWQYqaPg9RSkwNK
	8dpnXZWuYtWwNdUcwKQz8JuoXOS+fBckvebSDzmV/8EXvLZUaVSPk7rst7uAyXts
	KTlbG2KteL1bFniWUXKddVRto0U8EJArCfwSRrNry5Hn7qoUP24nrvVL4LnM43iE
	VCfCjzywUmy30RUJZWBavGqceBhEFxwOkiHDoNe136O96qnU9O97AAGnjNB38jQb
	14rYBUMxk/tiG0J9CYjCLW2D/AMZ3/3YJIg==
X-ME-Sender: <xms:narGadiIRoZuQGXBEfYdmLOm39iz6en_nyiqzUDSifGS7npIoIBkUg>
    <xme:narGaY46Rx1sahx9nEX18rutSd9_XMk1VuXZRsLybo_-EUIe1Mkn1sBPZ27PDSmLZ
    UKSnr8yk46HsbBpvzAIZjfWNgXSdBQy8xBvPzj7hLB62RoETHv34Q>
X-ME-Received: <xmr:narGaVYV6jeqXRigmaptY9TYb3n8VdQp-fsjvoA3z_2DIzNQw3v6pBn7aSRr9xPZpAt0Bu4ERTKiyU77_5yF88G6dyg7X1JTmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:narGad6Dv-Jw8TT1AmyOrmtohLixa7ltbozZLGXpeyB4-AfRXLS5dg>
    <xmx:narGaYBWwuXPs5PexYsO12VW_8bpnRX0cRSQmD_aJGTmixLwjiHX_A>
    <xmx:narGaTcuci9bTdgGHoOcLaFTLPfHuh1OWCeM2Z94GQTGcXTKyu6SUg>
    <xmx:narGaXJfEGyQHNYIk9h5Lab9vd3z-xoXO9ZWzn0KmZyrYqLISzYcsw>
    <xmx:narGaQLyLZDY2pZbmq-JiVIgfLM7Dd0-808S8mDc7vdOc6jHIRqcGWTF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:04:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
In-Reply-To: <acXYSm1JoX6YRuoL@exploit> (Mirko Faina's message of "Fri, 27 Mar
	2026 02:13:05 +0100")
References: <cover.1773959395.git.mroik@delayed.space>
	<cover.1774284699.git.mroik@delayed.space>
	<xmqqqzpa489h.fsf@gitster.g>
	<ad6a32f9-1b48-4bb5-97c5-96d1dfea3074@gmail.com>
	<xmqqpl4qr1he.fsf@gitster.g> <acXYSm1JoX6YRuoL@exploit>
Date: Fri, 27 Mar 2026 09:04:44 -0700
Message-ID: <xmqqldfdmf6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Thu, Mar 26, 2026 at 09:37:17AM -0700, Junio C Hamano wrote:
>> Yup, I tried "modern" and generally liked it very much.
>> 
>> The appearance of the list looked a bit odd that each element in a
>> list of things with heading was shown without any indentation before
>> the heading, though.  I'd probably use
>> 
>>     --commit-list-format=" %(count): %<(72,trunc)%s"
>> 
>> or something like that myself.
>> 
>> I seem to be getting spurious blank lines between the lines with the
>> above, when I lengthen and shorten 72 in the format string above,
>> though.  I haven't figured out what is broken, though.
>
> Could this be because of strbuf_add_wrapped_text()?

Ahh, I think that would explain it.  In general, I think it is a
mistake to use strbuf_addwrapped_text() for any end-user
configurable output.  After all, wouldn't %w(w,i1,i2) work in the
format string?

> In a previous review
> someone pointed out that there was no wrapping,

When the payload _can_ be specified to wrap (i.e., end-user
configurable output format), the wrapping should not be forced by
the mechanism.  A project that is not ours may want to keep a single
long line for their commit list entries.

I do not mind if the default "modern" were defined to include %w()
to force wrapping to those who follow the default, of course.  But
do not unconditionally wrap what the end-user formatted to their
liking.

