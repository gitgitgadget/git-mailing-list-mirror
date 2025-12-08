Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3FA13790B
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765177683; cv=none; b=CqbI1jgjdmm91Hs6Ol3zpz9jgXFmQLUQHfR4WfCfi2pkGdv4+BE8eufdqZU5MGPW/N5wRsd6K17tbdaNt2a60GfJ6E5Jsh3rWuUbdQyIH8i4zJs0AOEgZoAbM9HwgcDm/WRgAa4+kTWv/Nj8VUeZYsEPtmc7zhbVm36WpHoad64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765177683; c=relaxed/simple;
	bh=Edo4ug0vOUJ0l5QPEQZTYaj7iDPtEslxpOZ8ouwW9hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrrSYX4zUwJq6dTihY5RGzPlKjFUT193Igb9dRw7U3JDqajQvGelSM50DZHea0S7/aYErUdrGqXGPCACU06Qv8LfXHNp5zJAESHZfXjjkVSN/P7cruOs43UrI++ZXMd7UtqwCPVS4koxuGY/Y0d8cmamfok3xU4dBobKv6HNbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QFnXeIQJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y+mPk6GY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QFnXeIQJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+mPk6GY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A7A431D001E0;
	Mon,  8 Dec 2025 02:07:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 02:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765177679; x=1765264079; bh=o4zUVlLnAU
	Rne26Uwy2bywYj1PgWjkMuafz+clgmqbQ=; b=QFnXeIQJzUjAgNfSdxt6bZYVUD
	jHfFGCvLT0X8+aTKJo+fFhlvpdK1lZjuKt3JEYjJFjniTZiDcDEeUa/SB2me3vTY
	hvAZNwuN/Pmk37Jib6vf9CuRE7FW9T4zvKHKVgmw7OfP7fx0tZXEZIXV/pTjfzYW
	d9Sc8wC84ViVNjzRJP0LJu4ujq1IXdxsgsXyXg1QV0LGQpMQlhnzr/6u9bLOFYbg
	4nvEEmabKhcYioQCwtKaogh0VM1q9QWEdewPttr2ZMMHgMDdaOfnIM9eZh2fm675
	N9KAmkB4ABXYM3tAfLYUtAdi0Fc3R/7QursEukJ8maB/FJvPC6wRdVVAtwkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765177679; x=1765264079; bh=o4zUVlLnAURne26Uwy2bywYj1PgWjkMuafz
	+clgmqbQ=; b=Y+mPk6GYyE0jY/n2iHbKOqCww4/sT+YEQblqApQnX5uFrSLxmnf
	vG0/K3uRZayigSLSkaGtSa7bUhhJnRD/UPlgOl0D/EwkJgcc45g1BQqiVeQ1N7zO
	OWxFPRGrtqeIA6EYqmcmOG/w3lJOFIyCtvxZJllBg2vyduLe9ziKcWwwSwh37PjR
	juNAZwr5LWFNtcrre1Y3NTE/RYsrebYKcQIUbFbevljUryaiHQE+mn3j8nUYre+D
	PaHIwPDh16aOcEd44zgabIzLZHMbgmzZIx5B+ejLiAHwHsD8dS4EQ5KKItKOeOdd
	YWprV7/CemfI3DxmiPBGD94CbZSIlbg0DfA==
X-ME-Sender: <xms:Tnk2aV4y9klDSoeTlWprG8lzxlBaf_spvgZWDU44UznFPkuFb71Z-Q>
    <xme:Tnk2aV_nMNLVElppzhDQtgcaWnUYk3BhE1Zan1GVTvW5KttLyQdmsFhgaHuXBaJJd
    jH4jNB4IlkdyPe2BHqWUHDAG4k5qj03WD9e_9UQPttlDWTQNLRAjoA>
X-ME-Received: <xmr:Tnk2aXG1Y3hEV1-VhxT3q6DNphOBN39dEvOIzGOy9hswph8ILCZyrBNleVRhqwmt8Y9QlPBIIesDkhH5ahELYYnLhRfVxO682dq1XconQ3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Tnk2aaU-pvI1ADmUBzl7bTLEC7vTwsu5vOYGD0QIY3JIvryefrfw6Q>
    <xmx:Tnk2aT9T7RZSxoca1rqUNxXYZlGa0cQq4j8wd6CM2b3dzLn9WkY4dw>
    <xmx:Tnk2aX4cXR4vs1_mbpDWGXtVMDtuuvrXbtlrnH6i-JT40jN_hmfXaA>
    <xmx:Tnk2ackX4aacAC-ONErm-VCKH5rwM_RQEM3VXvO3X8XEqxzVNeDYsQ>
    <xmx:T3k2abF7uOS5qXJvGKs8zqCEFIVBTufBtPivCCH4IWjaS-7qpIXG5Qld>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 02:07:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 567e42e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 07:07:55 +0000 (UTC)
Date: Mon, 8 Dec 2025 08:07:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, newren@gmail.com,
	gitster@pobox.com, phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk, karthik.188@gmail.com,
	johannes.schindelin@gmx.de, toon@iotcl.com
Subject: Re: [PATCH v2 1/2] sequencer: extract revert message formatting into
 shared function
Message-ID: <aTZ5RrjnwJ2ZnT7A@pks.im>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-2-siddharthasthana31@gmail.com>
 <aTLDA11AKs0jlxFJ@pks.im>
 <ac12100d-4aba-4d15-8bcf-c50e6100c95e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac12100d-4aba-4d15-8bcf-c50e6100c95e@gmail.com>

On Mon, Dec 08, 2025 at 04:30:58AM +0530, Siddharth Asthana wrote:
> 
> On 05/12/25 17:03, Patrick Steinhardt wrote:
> > On Wed, Dec 03, 2025 at 01:46:10AM +0530, Siddharth Asthana wrote:
> > > diff --git a/sequencer.c b/sequencer.c
> > > index 5476d39ba9..9f621aef4b 100644
> > > --- a/sequencer.c
> > > +++ b/sequencer.c
> > > @@ -2365,22 +2365,10 @@ static int do_pick_commit(struct repository *r,
> > >   		if (opts->commit_use_reference) {
> > >   			strbuf_commented_addf(&ctx->message, comment_line_str,
> > >   				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> > > -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
> > > -			   /*
> > > -			    * We don't touch pre-existing repeated reverts, because
> > > -			    * theoretically these can be nested arbitrarily deeply,
> > > -			    * thus requiring excessive complexity to deal with.
> > > -			    */
> > > -			   !starts_with(orig_subject, "Revert \"")) {
> > > -			strbuf_addstr(&ctx->message, "Reapply \"");
> > > -			strbuf_addstr(&ctx->message, orig_subject);
> > > -			strbuf_addstr(&ctx->message, "\n");
> > > +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
> > >   		} else {
> > > -			strbuf_addstr(&ctx->message, "Revert \"");
> > > -			strbuf_addstr(&ctx->message, msg.subject);
> > > -			strbuf_addstr(&ctx->message, "\"\n");
> > > +			sequencer_format_revert_header(&ctx->message, msg.subject);
> > >   		}
> > > -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
> > >   		refer_to_commit(opts, &ctx->message, commit);
> > >   		if (commit->parents && commit->parents->next) {
> > Is there any reason why we don't also handle `refer_to_commit()` in that
> > new function?
> 
> 
> The `refer_to_commit()` function depends on `struct replay_opts` and its
> `commit_use_reference` flag, which controls whether to use abbreviated
> commit info ("%h (%s, %ad)") or the full OID. This is specific to
> sequencer.c's interactive workflow where users can choose the reference
> style via --reference.
> 
> In replay.c, we always use the full OID via `oid_to_hex()` since it's
> designed for non-interactive server-side operations without the
> `replay_opts` framework. Including `refer_to_commit()` would require either
> passing `replay_opts` to the shared function (leaking sequencer internals)
> or adding a format parameter which feels like over-engineering for current
> needs.
> 
> Happy to reconsider if you think there's a cleaner way to share this.

A simple alternative might be to convert the `struct replay_opts`
parameter into a `flags` field that tells the function whether it is
expected to use the object ID or whether it should try using the
abbreviated commit info instead.

Patrick
