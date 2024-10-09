Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAA17C22B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461127; cv=none; b=JVjTnZEJawump/S6YvrEui09eq4G14ajR3MbEpp4DKQAngWvvEpwhhMfOrxkHGSW/CNuzGx9e+9a4g6mFmF6X2EmY3U8b3p02IMF61xnvu7d8DdQ2oaF9MiCTjL2slcghs7a9v8kVlv1iW+HpIq0Fa9y2CYUgfTxeY8YgBLoF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461127; c=relaxed/simple;
	bh=it5zOTxYQcQwohDYBPch40ofvdUaoBPEJH4a3N86/Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qexBDg4OJ8NG1ouf3YOhVSGQzVfl2LKVh81TlcDjg/GwJzEihBw9y5gZXe6cTx/UVoCWP+LNAAam0R4DTaI6r7j9uOnfb5oVsJfNgyLOnAlWlKnJWXNUSi50pDXkAHMy1j8k4EXWXcNKoEXBKA/Tx8BvovEWOCkf62wA2ueuoxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I8mmgP5t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mB/LBcwI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I8mmgP5t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mB/LBcwI"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C1ADF138047C;
	Wed,  9 Oct 2024 04:05:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 04:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728461124; x=1728547524; bh=4UwPOoYwvs
	t1ocwWJ8TAs6/WuU0ZDjtLk+rruKsYf40=; b=I8mmgP5tDdEXG+fa8Up1KMcfHg
	3TbZYnaAMuy6/oK9vL5rkBGYPsazuXEgKsWkiXYPLs25HUTxOi4pq/anf79KOenk
	ZHd2ZN5huiqKX6d/zKH1OwYLtibqAMUu4k4xcO8NJdmC+GhakfWcuSyRnZ7WR0e6
	rI+e74nX11TReKAy7Q34GaVz228+1dPzl/BKKcGP6bttI8i5DZMpJmzLkoOah/c5
	v4ECsEoYyLkp7o5YvR4oXxca3tb4K1K2s6ITl/vgqnll7Ygf1vSu8nfYL7DZNa3r
	a4pG5Q0r7CA7NLtUqXHvSvFCR0rEzWtLSOqCoE6aJeV04ztWmgYpdt8CbMTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728461124; x=1728547524; bh=4UwPOoYwvst1ocwWJ8TAs6/WuU0Z
	DjtLk+rruKsYf40=; b=mB/LBcwIn7PBcAU80IUE6B8e3xAAo4oOARIX6TzYfOqq
	FyAwoe6kRF1MBQyf7WaQss6FjCSmvO77h4Ek0Jg2RyHiucAg0rbXWmjMJFTcuBRs
	vxf0BqNgb1C12Uu/d9DK4XVTZhD/9V4Xc7lsN2b0lh2roBzjwG+LLSSbgiSsK1kb
	FYQvJcWhUDgrgsav9B4/jtam+N4/mq5rFK8uBneMuRh1duHxqMeOajXp3QJYhGOD
	qvtPFXnUS9PxENBPXhbFzL+ZrEm13plEPy/7J6JXm4zfgO1nDusjvSI/7D4ikk6e
	eG53+96j1LhLLG6MYNni+pG2LgdH9gtaL0lNU2vSCg==
X-ME-Sender: <xms:RDkGZ8kRkd4NizXOiQt5lDF18uJ-mp7bjPoNYEzdzZOhNQVNHLkbog>
    <xme:RDkGZ71EARX-jVNwIhDgnumRrrfIu_LIaTzPc6y6TvJyf-3gbqriw_4CCeDYbtHYm
    Ar_thLfILwQHgs6dg>
X-ME-Received: <xmr:RDkGZ6pq6FDcLg2tV21qgUkgru94tBLlnYA6jnFXV9hLkQs5U_ZA66p9B26jVR-j3zmTZoyZfqmvgHAxFH_ojVxZIGxzZ3SeRr6WRhauhug7nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:RDkGZ4mSZUjHXyqe4y1EknBSceJKPrcNvMQiMLVJXi0n-YIf8hwP-g>
    <xmx:RDkGZ60-djUmXox0ZPQ97RzaWch_ad6-wEFAopEjzcP5_L8CcVvTqw>
    <xmx:RDkGZ_u5Ck7I6-va0ZTHKpSqHZu6TG-iBpPdDzgigl1o3o4IupdxhQ>
    <xmx:RDkGZ2VDqm36XD3Sb5yCDtSqxEQS0tC8k0HpJTonTsEfq413bgtf5Q>
    <xmx:RDkGZ9T5WLB94WUhVQ-Tgj6rX5AvsDCZs_qkf4OOoNPy9f3c3Ux08x_Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 04:05:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dced6617 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 08:04:19 +0000 (UTC)
Date: Wed, 9 Oct 2024 10:05:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZwY5O63OI01LZX1u@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
 <CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>
 <ZwUkZuCtYu7niuFM@ArchLinux>
 <xmqq5xq232wa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xq232wa.fsf@gitster.g>

On Tue, Oct 08, 2024 at 10:44:53AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Tue, Oct 08, 2024 at 12:43:20AM -0700, Karthik Nayak wrote:
> >> shejialuo <shejialuo@gmail.com> writes:
> >> 
> >> [snip]
> >> 
> >> > +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> >> > +		ret = fsck_report_ref(o, &report,
> >> > +				      FSCK_MSG_BAD_REF_CONTENT,
> >> > +				      "cannot read ref file");
> >> > +		goto cleanup;
> >> > +	}
> >> > +
> >> 
> >> Shouldn't we use `die_errno` here instead? I mean, this is not really a
> >> bad ref content issue. If we don't want to die here, it would still
> >> probably be nice to get the actual issue using `strerror` instead and
> >> use that instead of the generic message we have here.
> >> 
> >
> > Well, I think I need to dive into the "open" system call here. Actually,
> > we have two opinions now. Junio thought that we should use
> > "fsck_report_ref" to report. Karthik, Patrick and I thought that we
> > should report using "*errno" because this is a general error.
> 
> What do you mean by "a general error"?  It is true that we failed to
> read a ref file, so even if it is an I/O error, I'd think it is OK
> to report it as an error while reading one particular ref.
> 
> Giving more information is a separate issue.  If fsck_report_ref()
> can be extended to take something like
> 
>     "cannot read ref file '%s': (%s)", iter->path.buf, strerror(errno)
> 
> that would give the user necessary information.

Yeah, this is also in line with what I proposed elsewhere, where we have
been discussing the 1:1 mapping between error codes and error messages.
If the error messages were dynamic they'd be a whole lot useful overall
and could provide more context.

> And I agree with half-of what Karthik said, i.e., we do not want to
> die here if this is meant to run as a part of "git fsck".
> 
> I may have said this before, but quite frankly, the API into the
> fsck_report_ref() function is misdesigned.  If the single constant
> string "cannot read ref file" cnanot give more information than
> FSCK_MSG_BAD_REF_CONTENT, the parameter has no value.

True in the current form, yeah. If `fsck_report_ref()` learned to take a
vararg argument and treat its first argument as a string format it would
be justified though, as the message is now dynamic and can contain more
context around the specific failure that cannot be provided statically
via the 1:1 mapping between error code and message.

> The fsck.c:report() function, which is the main function to report
> fsck's findings before fsck_report_ref() was introduced, did not
> have such a problem, as it allowed "const char *fmt, ..." at the
> end.  Is it too late to fix the fsck_report_ref()?

I don't think so, I think we should be able to refactor the code rather
easily to do so.

Patrick
