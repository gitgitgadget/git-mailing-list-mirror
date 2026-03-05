Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841F19C54E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717017; cv=none; b=NYGlSnGJ2QUN7t+I26mm6Yc3cYOB7vNV87vZ717Jy/NgxeJk5zhlzknasu1YUZYEgVw+NYUKleqBa28JSFjjZg68FJfUaq/J0sr0Hygi8ppuZycUn8D2fFwVyeQMyY90xNNb9m1GC/bD4nkPv2IPGv3SNe9YL2cQzPT36puHg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717017; c=relaxed/simple;
	bh=rMDzyhRu1jDMK8YGHsXEYSrN0kNWi+ZtX+2vPVrxB8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfQiUjrrR/zaCwrcR0tY6fd2Fp06GGAnbTT7S+lKbu91FllfGWclNUFcT9TuWYnMPL353gX53q4l8WSQFFzxWzVBNyivYmdm0IfPPsQZrppzeVK+lsFhEDiC5FUBC+bv6DqJ4eNyKwQgQGpj69etOwB3n6xS9YzO0iuuSxwNzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=osX9LcPc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y4htIbW1; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="osX9LcPc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y4htIbW1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76DDF7A01AE;
	Thu,  5 Mar 2026 08:23:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 08:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717015; x=1772803415; bh=EzEqbtShXx
	cmoZwKrTJuu3VUJexnfDaMv/20EhHxqYE=; b=osX9LcPcdp5XrEZb730B82a2xQ
	2VzMfKb5zqbsP/T2OniFHXG3i76vVJ/XcvUVI29lF2Sx6X5lc6080fL1ahkN9azO
	C+IcAANaRP25Vr+UQ0tWN7eGUFdqsm4FhMVHR/Uijrz6AxcUtyohqoN5MO5Y7aEZ
	FV5+AnIaMaUtY7jWqUg6uGMlCKgIjAorf9f2g7R6BgF1snqFmT8N7jbTjutfDHVK
	ytdwoguVwVuVxoSpjpqX5cwtDWvGSfyHBTTwXEhzcS3wdSrjFBvBs6rNT83Mb/9x
	vuCNostz9iSGccaL2fla1s6qGxBjN52PNVUEoqy5IC9ujQasLk4v7kMGrZTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717015; x=1772803415; bh=EzEqbtShXxcmoZwKrTJuu3VUJexnfDaMv/2
	0EhHxqYE=; b=y4htIbW1EEKJIfoBxxRZscU3SPwrVCwe8N8TLWn7ddwp6lnONKd
	n9soccQVCj7s2sGBjgXmchZb8q8pa+u/ZSCDNGp379ba/TsCWk5p6PH92+D6soHD
	G2VNuCefqmReijpJGNzW0bhAnQc4CsIgsxzt3Tbv3sxyOyddR59mOu0AFO/C7dkx
	AwO1eXD8989eF8kzppIJBV7I+hcpzsxjd+vq5eQufgBVjx9mthLEKfREHH4n4Ia+
	kUe1Pj3rP5hhZre4deU3YVlE6QkzjHyPeUGRmOWTjg4GkqHzJluymt93obe0i2Wd
	mLNVmgWRybilzElZ3NSJwfn8cRj1T9OeSRw==
X-ME-Sender: <xms:14OpaTUAM0pjALGqSgf27xI-gZ4lH8vXlTe9wAQ_1P4jdcAZFD3naA>
    <xme:14OpaRlUVmnU5MZ4zBS5e66aB40duFE3uwPIHfny88FotPL9xGzGUptPBOEtmtWWa
    VTimrzBXSdHNSuVCu-gHQBHzgRrORI2uiQLj3saO9R9-3Snyo8pbQ>
X-ME-Received: <xmr:14OpadA6pdLBg_pJ3pjHPY9qa_cdwphzuvQ5kLYXcw8CnxOFSAFviTYaWlyd-DDDsnB7yHScatTmrcrxAmq4Dv16NU41dH4xRFR2asJD-82V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:14OpaZczy-KWfCd55QJGFozwPPFfbNOQKSb7hxt6p96J9IiROMkl_Q>
    <xmx:14OpaQIf2YtasfrKCbY-N51zGIuyGN4BYbXirJYPbz5nDnYRt8RRpQ>
    <xmx:14OpaUfrvYyfTVLbaX3c5U8Rxg6Pt2_6M_kveBSwBjcOoXCSnGonrw>
    <xmx:14Opaf2pR-HjeeAMYC1VsUH38fsz6KcKCvGP8vohrR0h38sRKmxcaQ>
    <xmx:14OpaYE2tFyryu33VK8NkLb2zMZPXExcSX5cKmKKHggdpwfuruqStwP0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be6de9da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:33 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/17] odb: move reparenting logic into respective
 subsystems
Message-ID: <aamD0yUNTb0r2JQZ@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-4-253bac1db598@pks.im>
 <aaiSFpWY0YQ6XQcM@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaiSFpWY0YQ6XQcM@denethor>

On Wed, Mar 04, 2026 at 02:39:57PM -0600, Justin Tobler wrote:
> On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> > The primary object database source may be initialized with a relative
> > path. When reparenting the process to a different working directory we
> 
> I find the wording here a bit confusing. Maybe something like this would
> be a bit clearer:
> 
>   When the process changes its current working directory...

Yup, this reads clearer indeed.

> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index a43a197157..df0ea9ee62 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -1,13 +1,28 @@
> >  #include "git-compat-util.h"
> > +#include "abspath.h"
> > +#include "chdir-notify.h"
> >  #include "object-file.h"
> >  #include "odb/source.h"
> >  #include "odb/source-files.h"
> >  #include "packfile.h"
> >  
> > +static void odb_source_files_reparent(const char *name UNUSED,
> > +				      const char *old_cwd,
> > +				      const char *new_cwd,
> > +				      void *cb_data)
> > +{
> > +	struct odb_source_files *files = cb_data;
> > +	char *path = reparent_relative_path(old_cwd, new_cwd,
> > +					    files->base.path);
> > +	free(files->base.path);
> > +	files->base.path = path;
> 
> I do find it a bit curious that we consider the "path" to be specific to
> the "files" backend, but still track it as part of the "base" ODB
> source. I suspect this will eventually change though?

Yeah, this will change eventually, but it's going to take a while to get
there. I plan to drop the "path" pointer from the base completely, as
other sources may not even have a path in the first place. But that
first requires us to address all instances where we directly access the
path

> > +}
> > +
> >  void odb_source_files_free(struct odb_source_files *files)
> >  {
> >  	if (!files)
> >  		return;
> > +	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
> >  	odb_source_loose_free(files->loose);
> >  	packfile_store_free(files->packed);
> >  	odb_source_release(&files->base);
> > @@ -25,5 +40,13 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
> >  	files->loose = odb_source_loose_new(&files->base);
> >  	files->packed = packfile_store_new(&files->base);
> >  
> > +	/*
> > +	 * Ideally, we would only ever store absolute paths in the source. This
> > +	 * is not (yet) possible though because we access and assume relative
> > +	 * paths in the primary ODB source in some user-facing functionality.
> > +	 */
> 
> Should this be a NEEDSWORK comment? Or do we expect it to remain this
> way for the forseeable future?

Once we are able to drop the `struct odb_source::path` field it should
become feasible. So I don't think we should add a NEEDSWORK comment now,
as it might mislead fellow developers to think it's already doable and
can be worked on right away.

Patrick
