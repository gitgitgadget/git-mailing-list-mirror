Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44719F421
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754368753; cv=none; b=XWG/c6E79QZSmiDE/O8X7jd8uNt9GwnoCd2fsyRN4MMkiRN76rXzmkkO6DkkINUvLuP4vQoQYW0J8BYNFV452nI04KC23OfwYS5rqfqf5/YYLRHigKGUsShD7poDa/BckdncO6hg0SV8D4eZiUvbZ7OHqr+JFpAhVyt2qjod9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754368753; c=relaxed/simple;
	bh=8dVg1NZcfBppYmVpaglJqlZte0pveTIN6LeDqVkjTvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8phvsz10Zi+3hFz2jez7GIUvRYQCpPDlg6CRBm7KqzsQVHmxlXBJ2RFNuD6GsGnkXONfk7T21ymIuxiZczhqnZQ92R3DlzFVZPxuwPdK34SdX7P5b6FXvVrlhZQRFo0sUEE4KgrblT4ebAwpjloYectt7fouJ0/0asQ7xJJOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hFDS/pp9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sc8cXUNK; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hFDS/pp9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sc8cXUNK"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56E2114001E8;
	Tue,  5 Aug 2025 00:39:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 00:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754368750;
	 x=1754455150; bh=jN3lEiLjWSEzwetXRo+DW0mWwAnJzKHv6V8Cz7MPUtk=; b=
	hFDS/pp9JEO/FXfambh9Erm/5BC7vFpXojDQsLC6z5b0iP89vBrhh5FEzkegpfKr
	GjWg4/NqLjUlAQJOdR78uUrXVdaSiGVtd5B2EoKgPi8iiw+KnmZz8PaN6ltditSV
	UzaZTyipylCwUYB+i90LtNHZKHjq6z1PtH9CVB0qCQ6HVxumfY+VtC0AdtwMEg3V
	mSt34fom1C/hN2uUxHwwPUZg5TAG51xq6xiLha/60q+GVzSTL6tCjCwaLVVMo328
	pvJAR1gRFA8rzPyfRvWBReu1L/As0CZ/dZR/kvtJygRWypFtK8wi0llQj/UJO759
	A+wF6fVSDEI6yS6Ui0qf7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754368750; x=
	1754455150; bh=jN3lEiLjWSEzwetXRo+DW0mWwAnJzKHv6V8Cz7MPUtk=; b=S
	c8cXUNKPT9j7F3rEbs9tnPo7ZDiwmqD3NdYEN8oOF1f9UAByEE1NZL4KSctbY7ES
	JoJsCe7TsT+hRHWHyzAF4wS9X+Hgdd9POsAPJMzCsO7BsaMViavem+eos3qvbxXc
	ERr+R3U2Be0Y4Q9MIgUSLG8SPoUw55tZZaLmM4pmXfainbYO/SAiWcDLUkKX71ko
	OdHO1Gi3X5TuGpfGO8t7k97Ra4h6mc9JMY9Hh6bYPJjnqv4c1pyq0u3HwPuMUvVm
	UJdfThqSJY22pFksr5hkn+PEMoDplHPy9Rtzp96Zs9MnTM2pnPeNM/QSm1kjYThN
	N8FB/+seOlfwpG3XSfHgg==
X-ME-Sender: <xms:7oqRaHLatJQe4jeBPG7yBSwzQ-wOyAVt-8cKtnAoRwcmpVkP5ijiLg>
    <xme:7oqRaOZ22T6Fr2rN5l6vrx4H5rXuXPxJpZDBSeJjNp2yAXKl-5gyoopRTNy6hwbaX
    663QrKKO1LxM-rqkA>
X-ME-Received: <xmr:7oqRaJLHPBxJipFWvmOYbQCIw8oUEkFyQob1qid5fvbf_QrJPQjJU4CfYASlhACQ641mdrfukPfQQAJpr8LSGGPM0Vf4xIocef36SIZvuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:7oqRaMCgJ6LBg5t_9PPEntdOrKvUqbqG1RnnfH66oESFCS3y8ena5g>
    <xmx:7oqRaOpy3WB7CI8NYiqZSu1TxptLdVkJEXk2D24GsIFB6e5wvU9GlQ>
    <xmx:7oqRaHgzE30JoyBS8EMzh-ngc4BvU9V5bNCmZmY5Ei5tl5EaEQAfBQ>
    <xmx:7oqRaLB6OWcPjBt_tS16MCmVVuFjlF0FWMBFck4IBcLR-Hiy_ooMag>
    <xmx:7oqRaHUvT4jF_Yza9YPRTomHQc0LfGoivX_H4CGILm_c381lMq_7B_7l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 00:39:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42cd1faa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 04:39:09 +0000 (UTC)
Date: Tue, 5 Aug 2025 06:39:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 5/6] merge-ort: fix incorrect file handling
Message-ID: <aJGK6XFdmYj50I9J@pks.im>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <2c7d4e022c59609bf263a7045fceb1854441bb29.1753197791.git.gitgitgadget@gmail.com>
 <aIx7SXfRabJWpa0D@pks.im>
 <CABPp-BF_UGf2VXvkAj=nkEPwo=FVQTgVvrDFURkBnFv4Wkiknw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BF_UGf2VXvkAj=nkEPwo=FVQTgVvrDFURkBnFv4Wkiknw@mail.gmail.com>

On Mon, Aug 04, 2025 at 03:08:50PM -0700, Elijah Newren wrote:
> On Fri, Aug 1, 2025 at 1:31 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Jul 22, 2025 at 03:23:10PM +0000, Elijah Newren via GitGitGadget wrote:
> > > Further, commit 98a1a00d5301 (t6423: add a testcase causing a failed
> > > assertion in process_renames, 2025-03-06), fixed an issue with
> > > rename-to-self but added a new testcase, 12n, that only checked for
> > > whether the merge ran to completion.  A few commits ago, we modified
> > > this test to check for the number of entries in the index -- but noted
> > > that the number was wrong.  And we also noted a
> > > silently-keep-instead-of-delete bug at the same time in the new testcase
> > > 12n2.
> > >
> > > Fix to merge-ort to prevent multiple bugs with rename-to-self cases:
> > >   * silent deletion of file expected to be kept (t6423 testcase 12i2)
> > >   * silent retention of file expected to be removed (t6423 testcase 12n2)
> > >   * wrong number of extries left in the index (t6423 testcase 12n)
> >
> > I think it would have been nice to also go a bit more in depth for what
> > the bug actually was and how it's fixed. You do add a comment, but that
> > only adds a single sentence of context.
> 
> Would something like this help:
> 
> ...all of these issues come up because in a rename-to-self case, when
> we have a rename A->B, both A and B name the same file.  The code in
> process_renames() assumes A & B are different, and tries to move the
> higher order stages and file contents so that they are associated just
> with the new path, but the assumptions of A & B being different can
> cause A to be deleted when it's not supposed to be or mark B as
> resolved and kept in place when it's supposed to be deleted.  Since A
> & B are already the same path in the rename-to-self case, we can
> simply skip the steps in process_renames() for such files.

Yes, it would!

> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > ---
> > >  merge-ort.c                         | 11 +++++
> > >  t/t6423-merge-rename-directories.sh | 69 +++++++++++++++++++++++++++--
> > >  2 files changed, 77 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/merge-ort.c b/merge-ort.c
> > > index 9b9d82ed10f7..feb06720c7e1 100644
> > > --- a/merge-ort.c
> > > +++ b/merge-ort.c
> > > @@ -2873,6 +2873,17 @@ static int process_renames(struct merge_options *opt,
> > >                       newinfo = new_ent->value;
> > >               }
> > >
> > > +             /*
> > > +              * Directory renames can result in rename-to-self, which we
> > > +              * want to skip so we don't mark oldpath for deletion.
> > > +              *
> > > +              * Note that we can avoid strcmp here because of prior
> > > +              * diligence in apply_directory_rename_modifications() to
> > > +              * ensure we reused existing paths from opt->priv->paths.
> > > +              */
> > > +             if (oldpath == newpath)
> > > +                     continue;
> >
> > Makes me wonder whether the additional brittleness is worth the saved
> > `strcmp()` comparison. But on the other hand we do have tests now that
> > would break if the memory allocation patterns ever changed, so that's
> > reassuring.
> 
> There's no brittleness here; one of the many optimizations in
> merge-ort.c was to intern *all* pathnames in struct
> merge_options_internal's "paths" member; any code that needs to
> generate/compute a filename that may be part of the merge must check
> if that path already exists in opt->priv->paths, and if so use that
> pointer instead so that all filename comparisons can be done with
> cheap pointer comparisons.  See the big comment near the top of
> merge_options_internal.  Nearly all such
> string-equality-via-pointer-equality checks were introduced about the
> same time, and in other functions, which makes this one kind of an
> outlier.  I figured whoever reviewed this patch or ran across this in
> the code might get surprised by the pointer comparison, so I tried to
> add a comment to address any questions.  Looks like I wasn't thorough
> enough (and the first paragraph of the comment pre-dated my finding
> other bugs this patch fixed, which makes it slightly confusing), so
> I'll try to see if I can improve it for v2.

I think the current version is good enough -- it feels brittle to me,
but I don't see a strong reason to change it.

Patrick
