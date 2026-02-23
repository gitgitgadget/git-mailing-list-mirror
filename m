Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0663612E4
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843690; cv=none; b=FxUaefx4h2aAxbQuxuHdhTbeE1CyIPTzucxMkRtTsuQIDcmlJUyRFqaVsu7vFLRIdyklZ3UtetLm9voYuCvIVEN6uzpsKUU3kZmk/eUO9oOjy1vBAzYcgkttaxDt/WsJ640OlTrgk931WUs1Az5F1e/jz2/08netEoIJ/b+tSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843690; c=relaxed/simple;
	bh=DV07P43q/GgMAyEk6WBNRjnqOBCD/iiq2QL+BG3yrGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyJSGhLFtSLEjjXakkTmRxcmmQw1FUzV1IVyR8lLNCIoC3l+BYzXJtzcas4UU4Rx2cUy4YkqV43YUWn7jPiyXwF68X0mu54FW77iMT9uzpmjrEgx7EVXjiGrXNXExeJViLTHy4WY3jFXquMfmpjqM9IT08vDqNkOqsUiPYRbNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SrqStuHd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iqddWDyl; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SrqStuHd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iqddWDyl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 24F88EC05E2;
	Mon, 23 Feb 2026 05:48:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 05:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771843688; x=1771930088; bh=aaNHsLvRZl
	Qv57p4jOrYmTE7MRMQx/TSS+JOaxHrqWg=; b=SrqStuHdL5qSDkXc83ZsaSu1CB
	UJ055fJ2R+Kr1CegPNlqhk9bOCOMX5nqMY63KqSKSgwusQY4XPGnICWAFoqvAoPB
	hE2uqXA0p5AfTY2Wiyl558mf0VkwHRIXBrssx6fijIDm83z9SE8K1m2s03OXWp2V
	nFs8ipJUlAhwxpbLItmE05Znsylqt2AWjrH+dUATx8GhakvEOyXX5IFNHvhYW8OL
	sFu9puRz/Hh2njgcLnb739bNChviWQKiVcDGWwLbGbmQhio4T+PETlKQoHnJf5vl
	sddwhBQw/quGpWKfFuXVysaMS1ouxyQtv+PizMQTkYjcmu14IyiIhrl/SbqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771843688; x=1771930088; bh=aaNHsLvRZlQv57p4jOrYmTE7MRMQx/TSS+J
	OaxHrqWg=; b=iqddWDylJj07h3FCxGtr7tTgyG59o8yJwUjKxBdPEbs8GNyB3WY
	PBAGZv/ISdRVuLIDDcJYOtH99aCNpUBZmYOm2I0Ey2aw3Dxj1Ui8hC6Aejy0JVWw
	YAIGM0pb7Pss11sqBjsX+Y4Kn17OHfiRO++sJbpXVIwgzPYuPm3rthTvsJnCPGhz
	a+Oa4CLUW0OFveyyeeVSVo7eodxTApYBvp33z+FVClT80KK7Lgylo+Ult6BlTiac
	9KjCc0/UH347RM7QxrwIiA3Z1L6pu/PizT/eiJJlJyrRhk4edVdQlguz16QCYJZu
	AT2UsT3IPWZTrGxnejJhqU6Tdy0DPllnv3w==
X-ME-Sender: <xms:ZzCcaThWNkJf3Mxt5kPri8E0b0PzpfnB69end7s0NcczIBJFkJicow>
    <xme:ZzCcaWClzObPzAkNPDLfQWqZ49JOHl5eRR14xh5U-INCr1o5UVYBYsI1rqUIyXQjj
    zlfOXS9Y4UEYfhBg_7rQw268QvrpCbAdQSvF4YYY2ycTp8jLWBCBQ>
X-ME-Received: <xmr:ZzCcaQugfwpXysJbMvW2FEQIyE7LaXsPki0Rd7pN_JEGjRsk--1q259PfSrms-YC_VyE6_YOKJfEZ4rVj4lzUkcI0irZlJRPDPDJ_QRgDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZzCcabZPH15gyFyguWVtD1USUejCaf7Cw1B4dk-M526OQ_0vgFcDbQ>
    <xmx:ZzCcaTXygG4QFzPfbfh8Zf6JUK-uHZg53DhfmBTiornvJeG18Jgbsg>
    <xmx:ZzCcaf6p9sLdahANglVrdRiXuKVU6o3E1uJEiWrbdw4WZFA2jQYSdw>
    <xmx:ZzCcaehHfXW9tVMmEhOGlqtXR7NREOnoEe9liUdwABu9olD_lX2GCA>
    <xmx:aDCcabT0FexRLetPFGjqHePZg06qpUBtRUH7TDCuNoQwAgP2mz1bp7gi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 05:48:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec060fcd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 10:48:06 +0000 (UTC)
Date: Mon, 23 Feb 2026 11:48:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/17] refs: speed up `refs_for_each_glob_ref_in()`
Message-ID: <aZwwYynerY8Yauqc@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
 <20260220-pks-refs-for-each-unification-v1-7-17170bd99de1@pks.im>
 <CAOLa=ZRogQCpsD5eXOQrgt_DvgsXNfagbaxQm2eL+NwfUpw9OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRogQCpsD5eXOQrgt_DvgsXNfagbaxQm2eL+NwfUpw9OQ@mail.gmail.com>

On Mon, Feb 23, 2026 at 12:27:15AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/refs.c b/refs.c
> > index ec9e466381..ac34bbe6c1 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1862,16 +1845,44 @@ int refs_for_each_ref_ext(struct ref_store *refs,
> >  			  refs_for_each_cb cb, void *cb_data,
> >  			  const struct refs_for_each_ref_options *opts)
> >  {
> > +	struct strbuf real_pattern = STRBUF_INIT;
> > +	struct for_each_ref_filter filter;
> >  	struct ref_iterator *iter;
> > +	int ret;
> >
> >  	if (!refs)
> >  		return 0;
> >
> > +	if (opts->pattern) {
> > +		if (!opts->prefix && !starts_with(opts->pattern, "refs/"))
> > +			strbuf_addstr(&real_pattern, "refs/");
> > +		else if (opts->prefix)
> > +			strbuf_addstr(&real_pattern, opts->prefix);
> > +		strbuf_addstr(&real_pattern, opts->pattern);
> > +
> > +		if (!has_glob_specials(opts->pattern)) {
> > +			/* Append implied '/' '*' if not present. */
> > +			strbuf_complete(&real_pattern, '/');
> > +			/* No need to check for '*', there is none. */
> > +			strbuf_addch(&real_pattern, '*');
> > +		}
> > +
> > +		filter.pattern = real_pattern.buf;
> > +		filter.prefix = opts->prefix;
> 
> Can't we now remove this option and cleanup `for_each_filter_refs()` to
> remove prefix trimming?

No, unfortunately not. This is because the glob pattern is expected to
match on the full refname, so if we were to strip the refname before we
pass it to the `filter` callback then we wouldn't be able to do the call
to wildmatch anymore.

But the stripping part is still a bit funky after my refactoring, as we
unconditionall strip the prefix right now. This is the expected
behaviour, but it is somewhat surprising I guess. I'll rework this part
a bit, thanks!

Patrick
