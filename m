Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566252D3742
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913405; cv=none; b=G8HebQf8CfHKlrbvX4eoYx2ojy91zTUuG89bpthOd+5K/l5WIHyHR7nE7vPKUBFC1YCGCdW1rbogHCgXlytlF0HUg54nOB8aJxj9g9Eb2Ts7xSykdeRr5K1Cea/VD6SxuA4lan/kJ1BI7R3uA0SVjVHe4G6wpb9F/glUzSodXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913405; c=relaxed/simple;
	bh=fp8RwHiGskMfWDWLv0GbXO2hOmFenWDZUCq1rhfHeHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgaqoHptolTC7b5AOpOcJwfHtW66b/yEZBvN0Xfun65RR11WcKXmgPOusED1GrLcwWRyVUZI5dqRoSSF7SrM4SSxommiNZMraaPXKvR7RxSzFL/Dpa8lABVsBU0jVylebtO/pm40JHdPcciaiUWZvGhB3oY6nvVFzkCu6unpSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FO0kJ+JV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fr/1wFOs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FO0kJ+JV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fr/1wFOs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 463C71400021;
	Mon, 11 Aug 2025 07:56:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 07:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754913402; x=1754999802; bh=KtimCpRQnP
	8mriTIM78/qtJRpG61kLPnRUgSgS2E+AI=; b=FO0kJ+JVAVw+MUIP8VN+qhk6Nu
	ep8k0iRzJEqWQ79MzPm0EbyTeeywocFk0/ds0MdfkZc+bSZjaQd5sFIdlteAn71u
	Vibz6OH6ICTjTDJlJrADuqBCdThxzt7hKAb9MI10qpmm8sVRnfcBoPQGaR1EkRA+
	YhMCsEHWFGegXY7DLEqy8ySbXp+1q+C+A7DhKcsyf/3Socl9/IDefXj7jN+r9Fxa
	/9C9y5xBgdBrI+8d7bzEsGIworfz7pvkcWiJFMp2MMOwGTzg80ORe85H6+XwWPHI
	/qu63LmbcWwvnmJpAMFOjTqCQQPqCfHDygIe5Tbv1ErPeErrBuN4RzVjPUiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754913402; x=1754999802; bh=KtimCpRQnP8mriTIM78/qtJRpG61kLPnRUg
	SgS2E+AI=; b=fr/1wFOsOYnk+uRsKnLba771cFeEKpsZM+zJtdXrfJPdx3mjejK
	IalKxMdNx3b0Uvpy3NAFcrPSGQZsA6bBzXUdIqt7hG5Ewk+SLEolECeJBQFvz46Y
	WR/C17k03uNaAx1WeoxodzW6a4n/FQPScjxc1xZgDqzBLiyDnqECYozdF6sz1JEk
	y1yawPDXkycdSKC/inIZ+PB/yZLWLNJCWXFTkIbvuaCEZe+nUKhCIdAECw5O+xL3
	6+n/TsA6iPDbQi3e2rxUkAtGeI+HeVw7RBBhYMhqn95qPhufYI0bjle+u8bpRBTd
	myeODo9a6cHc5sbUmLU/Fojtzhww3N1wWDw==
X-ME-Sender: <xms:edqZaGhYIqLOvi6cH9rGMyQIVclxw9JfBA96XBfbXRQwieYevgi8Og>
    <xme:edqZaKQca8iqeBpmCzTLpD6XIRE7fspPK5pGNlW2QHRMr0hMUu5_lz8dYrQR1NSMX
    _1uIOCN5P_Y7_7LiQ>
X-ME-Received: <xmr:edqZaHgNURkN42jcIkLOdKuoqi-Ke3am0Sr3t0YeubAwOldD6Ct1_HagBNNvFKHGtbHjfdBOu_1Ekc3B9jBxpO8CyS3WETWfgiIlA8dWazE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:edqZaK4Hnn6AvpoPsFjt9iPDK0rpKAyKUO42KdCPpkDrMNr-W-0JRQ>
    <xmx:edqZaEAaKefuWiOdjSnNSdvRcWNzALEUF_JcQP5EJf2VgkxKc71Q0Q>
    <xmx:edqZaBa36HqHHf2K7mnwyPhhOODSzoISkNuyIaX9XosUWPWF9ZuLDg>
    <xmx:edqZaPZ4CqnTApxLgmml8B_XEm76xRhIKw5Hz1AD91WMTgyYCWpZVA>
    <xmx:etqZaHFG1M7c8LnkuINKOo9BLDoVunm_OXJ2WAtCxDbCPQLAu7C1ZweS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 07:56:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5a563de (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 11:56:40 +0000 (UTC)
Date: Mon, 11 Aug 2025 13:56:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 3/9] odb: return newly created in-memory sources
Message-ID: <aJnaddzo3aRbmEta@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-3-bcffb8fc119c@pks.im>
 <aJUlwLJyxSmD4EQF@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJUlwLJyxSmD4EQF@nand.local>

On Thu, Aug 07, 2025 at 06:16:32PM -0400, Taylor Blau wrote:
> On Thu, Aug 07, 2025 at 10:09:53AM +0200, Patrick Steinhardt wrote:
> > Callers have no trivial way to obtain the newly created object database
> > source when adding it to the in-memory list of alternates. While not yet
> > needed anywhere, a subsequent commit will want to obtain that pointer.
> >
> > Refactor the function to return the source to make it easily accessible.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  odb.c | 37 +++++++++++++++++++++----------------
> >  odb.h |  4 ++--
> >  2 files changed, 23 insertions(+), 18 deletions(-)
> >
> > diff --git a/odb.c b/odb.c
> > index 61104b7cb8..7793816f81 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -139,23 +139,22 @@ static void read_info_alternates(struct object_database *odb,
> >  				 const char *relative_base,
> >  				 int depth);
> >
> > -static int link_alt_odb_entry(struct object_database *odb,
> > -			      const struct strbuf *entry,
> > -			      const char *relative_base,
> > -			      int depth,
> > -			      const char *normalized_objdir)
> > +static struct odb_source *link_alt_odb_entry(struct object_database *odb,
> > +					     const char *entry,
> > +					     const char *relative_base,
> > +					     int depth,
> > +					     const char *normalized_objdir)
> 
> Beyond returning an odb_source pointer from this function, it looks like
> "entry" was changed form a strbuf to a bare const char *. Is that
> intentional? If so, it might be worth mentioning it in the commit
> message, or optionally doing that as a preparatory step.

Done now.

> > @@ -316,17 +315,23 @@ void odb_add_to_alternates_file(struct object_database *odb,
> >  	free(alts);
> >  }
> >
> > -void odb_add_to_alternates_memory(struct object_database *odb,
> > -				  const char *reference)
> > +struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
> > +						const char *reference)
> 
> Not the fault of your patch, but while we're refactoring, do you think
> it makes sense to rename the second parameter here to "dir", or changing
> "dir" to "reference" in the declaration of this function over in odb.h?

Ah, these are inconsistent indeed, good catch. Will fix.

Patrick
