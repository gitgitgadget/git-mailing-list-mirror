Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21031805E
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641202; cv=none; b=bIeNZeUKpy//QlbbhPLgdP0TC2VZ9pjad1tabRmGEG9BY4jH2jhA3YL0QPI++X5H7boheOGvggnI3sRW0nKd0LK1DT7c2ksKhQq2ZIB7Homl9pElbsWJwz8dWEHg5ZTUW46vkey+52+LIRgGksrIKYCwLlq+MHoR1ESF9/W8YNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641202; c=relaxed/simple;
	bh=nNDAklVu7Kz/XNU1p1dqqSK3nQo+YtWmeyRlwi4YsNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL8paFWyCGu9thy8C/vojvhL7wMYxxEBO5+Fe0IH0GEmyimq0jGiboUCwPGF2mMw7IOBnf1BmcYjle6f7GAnFIlIHYHDqsgSN102IWIxFy5g6dheN/qZIc7w9Xp3kPRfopHakLXG4QFwihgy8QxpQ/gzU7f5ij2cYeMuBeJnDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YqNw0dUz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARVDYIy9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YqNw0dUz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARVDYIy9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 656457A022D;
	Tue, 23 Sep 2025 11:26:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 11:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758641199; x=1758727599; bh=1xrttT0+g2
	s5iku+l+M9EcFFi5LyrF5QlpCv9R5PiGA=; b=YqNw0dUzwNjYdhi3BYNE1xgwmK
	cavdIxpPZXEQF/QS7mUYj88d0O5OjcrPCsI/UKkZ+BCXnzNzja1FafmAVVv+Dyl0
	taviXqOhWcjX52iTuAUKDR4eisRHlGrDK+OjGydigyGgV9mLjcYrcVMBsPSdYVJD
	g2WTeTQjx/8RjJ+LnOsr60HpHd9pX9WUKuOv41f+o6Ng4nsfzp++kb3LHvOD9XYv
	nd8rmbq6xjqNUx8SgIRwwMnqtPV8FHol8ZQngRFJnuBRQqJbzLTIu0saMTNT8P7n
	ePYuRtDic8NkdR0nSjGGtPNStTCLWDl9sGiMECPvfA3oxisuQ60cF6hVAhzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758641199; x=1758727599; bh=1xrttT0+g2s5iku+l+M9EcFFi5LyrF5QlpC
	v9R5PiGA=; b=ARVDYIy9UbW9V74Z0sVb0BdhvxlKUlAo55CEg8h0dMpMHG4kJzl
	/MKWII4jbTc22gsLQn/atftjVltQkXBh0HFfoK3NhU/kbOYiPHcwerIG7cSotQDG
	jlFITsUnrqp2crihEipXFlPIotO5XNn7ECTPevLrW7Ypqzs2PRIV+nvXMgL+URTI
	+zmSwc2oWxubSGl6fRymHXDUjOkuv9unhOJk/I/2a5BSXpiRUAuvcPB+/NkL3ZZA
	N9X566XYPxFO3mfNVhenuGrX0DDSnvSHzFOL/a9OcmtilUzLwNKAvtrstQr9YVLj
	bIU8cJb3JsB71KpIGCqBl4KONttLXLAazxw==
X-ME-Sender: <xms:L7zSaI3msIrT-Peln0pBCDR6YFUTThC2NnXWTqtzhsWXDR9fUqnjTQ>
    <xme:L7zSaKjPQn6EtpCF11605QSG5aO3J5WQpsb1uZTl7XNQ3bchjU4_UPpW9jUoAYEiz
    B04m9hv16QjDua2B2-sz2H2iGslzZy6kn5t5D1sclFujqDhdXHVuQ>
X-ME-Received: <xmr:L7zSaORiYRzhXdlk4Q4xiBG3wAPkrpWpPtf0_tvVW92Ns0lNK9ahKCEYofH3A9pU3hSCu1yvWHMqttDtTVtbnvt5E9ZTKQAqLDk5Rt59bolV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:L7zSaLh2Sl-bTWgG9zKPptabXa1tEXYx0_RaCh0KcUd6kR9NaiuBaQ>
    <xmx:L7zSaO5XX-Xg9LfXryIuk_vJvy2EvEXInrrrwd5hsEc4xNG78GEJPg>
    <xmx:L7zSaIDFkdDAZUyBDIt63yneMZuJNwtkxD1I8Tc-AYcuk6nIHvJ-pA>
    <xmx:L7zSaFYhVUXr7Y2nQHNBZEdonlF31CRqqVxnugaTj5aPpJIC6iXPkg>
    <xmx:L7zSaG9iIRI8aOblsEr2fluWC0eYo5EdH9jw3cMDHkLrUbjmAGVw69OQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 11:26:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8fc66d8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 15:26:36 +0000 (UTC)
Date: Tue, 23 Sep 2025 17:26:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 1/4] builtin/repo: introduce stats subcommand
Message-ID: <aNK8KujMRfV93nag@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-2-jltobler@gmail.com>
 <aNJ7_GoKT5ea4QJE@pks.im>
 <w4c752odnthf26stoiu7he2xk6fucocmsnxo5pa5vh5sg647g2@a6vphhukasgv>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w4c752odnthf26stoiu7he2xk6fucocmsnxo5pa5vh5sg647g2@a6vphhukasgv>

On Tue, Sep 23, 2025 at 10:10:50AM -0500, Justin Tobler wrote:
> On 25/09/23 12:52PM, Patrick Steinhardt wrote:
> > On Mon, Sep 22, 2025 at 09:56:57PM -0500, Justin Tobler wrote:
[snip]
> > > +static void stats_table_setup(struct stats_table *table, struct stats *stats)
> > > +{
> > > +	size_t ref_total;
> > > +
> > > +	ref_total = stats->branches + stats->remotes + stats->tags + stats->others;
> > > +	stats_table_add(table, _("* References"), NULL);
> > > +	stats_table_add_count(table, _("  * Count"), ref_total);
> > > +	stats_table_add_count(table, _("    * Branches"), stats->branches);
> > > +	stats_table_add_count(table, _("    * Tags"), stats->tags);
> > > +	stats_table_add_count(table, _("    * Remotes"), stats->remotes);
> > > +	stats_table_add_count(table, _("    * Others"), stats->others);
> > > +}
> > 
> > Would it make sense to not translate the formatting directives, but only
> > the actual words?
> 
> From a simplicity stand point, it is quite nice to have the formatted
> offsets baked-in. It is probably better to separate out the
> transalations though? I'll interate on this in the next version.

Yeah, I don't mind the baked-in offsets. We could allow formatting
directives here and then pass the translated nouns as varargs.

Patrick
