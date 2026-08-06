Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B164175A5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996294; cv=none; b=jfdJv7vfmla4YPSjiWsAUcG73dlZBCwi1xjg1IZhSaVRTMEc5Wol3ypwoa3XQ0S6WRj8INQQtvxpMQchls36YF43icXZts6FGLa/3gTFMA9Vf3OP2Ivt+s5uIVHFKPkOWsznMOqwUkTB+Qi/C6+MTd18kal+PTpk47cAxvxI9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996294; c=relaxed/simple;
	bh=NOL8sUprrdddNilQ35w/ecDbjem3+IkujX4vDq+rH5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6X1ClsUvue14YWdsB2mDcBcnHSXdLoWUX8dxY0wuHgAP5S/dynK1gQtJIdl6Ul1cn/JgnHinMxWs5KZOqgARmfgNdjMf+rQ0m10GjvZDVKbKqZYaFrE7mo+vYjRJtQkOIA5trsWJjpFN07ZynBrbxBeEGJooFjWfVAqwyUg3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QyQWTHuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ardwxF8L; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QyQWTHuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ardwxF8L"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC0617A0159;
	Thu,  6 Aug 2026 02:04:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 02:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785996292; x=1786082692; bh=zNrYSWlJau
	c5ilX3QMlr4kDyLvUfozeLAQROLxxhFSs=; b=QyQWTHuYMwcC/9kCoVhB1aNfP1
	IYgDRERe7b4YE8wJG1KJNdYlGWS7Npr+0r0T4Bxw9ZHJ/uBSYB8Of5eFFy0PoirY
	7CKpf4psrEIlC/5TtqwWWJuiUEGanUJyEJW3ctJ0r+ezl/zBcwHkBDV6rjte7xkz
	zMwNuQRqZWhs71mPXopYgb/s1XEwrfFDjlMiUQ+bGgwU+ILVldELffTDGuV2s00H
	6U3WjGmyx+gpOmPcbvU1sHK+iu7h3Jzv+uqaZ/gVHWY5dHG0UisqRu/0INmS0/jg
	CAgsDhlEiEusJG5J1+3Oqx/KJgTqQdWzLWTF7kvCTO+D8J56yAlbQAzv7B8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785996292; x=1786082692; bh=zNrYSWlJauc5ilX3QMlr4kDyLvUfozeLAQR
	OLxxhFSs=; b=ardwxF8LY/VB9Xuj6LKNcIeLxDQ5YJFKyeYvLwKLiVZNZqkqONl
	pxWeJn3KnAAsOkUsOc4O6hl1bWu3x0gyWkPe+ew0wRkAwzqcCNdtqvP26KmZ0Erg
	m7RB0LPlc1StlVlDT08e/hd6g9j6Y8WagXfhZOiDpvnOn510Y/wmjE8g40FOcfh+
	6saaV5f375bwW6SCCDBzZQ8oam9qnS9sKitSYPA7KbykIzLjlqvB8cDocxKSoipn
	YXUYcl5KmTzD9fl4/39Vn2L3pO2FEo3SXyIT/xCH4LJOEm+lE9nBRaV2IneUqWIK
	vNzKfZ2RxRsePX60KzFbiTc2XB+ewTWymRg==
X-ME-Sender: <xms:BCR0ajFmlvRVi0fMdB7vuII3HSMWScooDz13q_EOJ6oU9IpTfxnd1w>
    <xme:BCR0anVJNFr914a-rnrmWe_J6AWcVlowbTqXC1LehJ794Rl6-yP8RN69iNuQIU7W_
    8-nhM1n9G3meNfF00oYiCyfjy3M-cOvf4nqlHXtkgWwVfwJMeWQJi8>
X-ME-Received: <xmr:BCR0aqJyCP51Xho7SAc5jI9saA9YBW3Nk9lzsQ6FPtMGQOfsTgTuEJFrlcpBtACmrTmrHRUBHAeS63tFhSY9hK0gcMBsrgNTOqEkOG2J-1E>
X-ME-Proxy-Cause: dmFkZTE8DiukXDdX4UbJNTO+A3AMGbmAd8DBqGQ+dDj1eLn48R+X24Ps9h63uFbygQofoV
    1aKGMfeDQ0QHlmzpGx//aESfkfTbOyJ1KY75q5SFxfqe7klSJbpuPZR+4mJspBsTDYLXje
    lbY5Ut5f3jervZkN2Z/A4zRm6J5dC6U8klUTwa9r/CE/tKGxZBuZzEU9zSIXCiV0FeN73E
    S85ZftmN86c2RcuSceqt/VHxzTbAqBLHcNDuNd0nP9she4vWn3YjB07m8gDaV7/SYLc3+y
    cOAdHIEbK5HYpiKbP/FUZ/yOEiuOjPIlNXti3wyJtACfUnDHzObb69Cl6CwBa66AqeqIed
    dltj8Hic+9Ag28v1KnKmw2Z0ThljPMQ8rUeLpxReXFXwHHsO0xhzdPOvzHE9foQ1tsMH7o
    9ypWRkJtHup/LlWDpNBeSROseRh0VqTjIhJNr830XoNYqoGZ8BzLMrYwE7Ry6YMLstqxNK
    vjwlCUM7TVRQT4cTza4mi7nh1L/tw4DqBGBi6656+G3ne6YkWoQPwCFe+Q4hQXGXPALOGS
    +Uqv9wFrJnuRadKySIrNCl/u7VwvGb9zgROr52QiWg2J+4wCpKapT66lBUiHpRdQzAHPQ2
    ewwYniMC90IFo0GUx0uaKoxPZ6NEEoIgJas29qoD43Ok0sguFhtX7t7HrEgw
X-ME-Proxy: <xmx:BCR0av9oDsMi4DSWt-PAZ7bQk_MGUEmslps921x8DKYYDdoZTT7klw>
    <xmx:BCR0alIEzZkm9z7Miz6IPSUoXpVtDGHI42Io9d2bsfpjYP6s1LeiUw>
    <xmx:BCR0asnQWhR35SjTuj3-QKaqLCtOll4QsvlhR_EcffTblQxg2Z-bbA>
    <xmx:BCR0ahOPdpEkfBFRJAXsMV983IbtqDLm89_dMU4mqJnlH5YfZpYIhg>
    <xmx:BCR0akLOBW5M7u4H5i4to57wkOf_ma8y1uICG_EfKX7UuuwJ1B_4ycSg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:04:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e37207a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 06:04:50 +0000 (UTC)
Date: Thu, 6 Aug 2026 08:04:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 3/6] setup: handle ODB-related environment variables
 in `odb_new()`
Message-ID: <anQj_ww0Y2guJDcM@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
 <20260805-pks-odb-create-on-disk-v3-3-c0ee3ac5141f@pks.im>
 <878q6k66ha.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q6k66ha.fsf@emacs.iotcl.com>

On Wed, Aug 05, 2026 at 03:29:21PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.c b/odb.c
> > index cf6e7938c0..b463afa072 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -1004,26 +1004,30 @@ int odb_write_object_stream(struct object_database *odb,
> >  }
> >  
> >  struct object_database *odb_new(struct repository *repo,
> > -				const char *primary_source,
> > -				const char *secondary_sources)
> > +				enum odb_new_flags flags)
> >  {
> > -	struct object_database *o = xmalloc(sizeof(*o));
> > -	char *to_free = NULL;
> > +	char *primary_source = NULL, *secondary_sources = NULL;
> > +	struct object_database *o;
> >  
> > -	memset(o, 0, sizeof(*o));
> > +	CALLOC_ARRAY(o, 1);
> >  	o->repo = repo;
> >  	pthread_mutex_init(&o->replace_mutex, NULL);
> >  	string_list_init_dup(&o->submodule_source_paths);
> >  
> > +	if (flags & ODB_NEW_HONOR_ENV) {
> > +		primary_source = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> > +		secondary_sources = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> > +	}
> >  	if (!primary_source)
> > -		primary_source = to_free = xstrfmt("%s/objects", repo->commondir);
> > +		primary_source = xstrfmt("%s/objects", repo->commondir);
> > +
> >  	o->sources = odb_source_new(o, primary_source, true);
> >  	o->sources_tail = &o->sources->next;
> >  	o->alternate_db = xstrdup_or_null(secondary_sources);
> 
> I'd say this xstrdup_or_null() is not needed no more, and so is the
> free() of that variable below.

True indeed.

Patrick
