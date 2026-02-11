Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C348460
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810523; cv=none; b=jRxRZnB7JMJ42lLXtQcStARz5DZNQ/wDAkC0jviNhzA6XsWCP/Ur8gNHZvgA1m3EDtWbiZ0nRdIWuCQ3Oxa4UmppPrieNwHl/tlFAVKow5ynvlINynhURXUFwfdnoyuGneXyT8vOhTszg6r+usbCiTHEfBdEl3f4U34mSKUs2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810523; c=relaxed/simple;
	bh=NYhzIHTyTaURSAKUFyRuBx1n5hGDBUeKVD0GenaN3DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6J3XH1jyqiqR96QQ5xRIdFsLBXl4y5HfjZizoT/jfp8QwwefA7aB27ZP+UbFKNEbu2MWy1L+A6/Pdc7vIakWFeSNFe9pqHzpKE5gt9BDZI5kfMooJU8vPXH1+/m4374UZXsWgjkRMVKhU2fitaZ2am3ZihdcdDIb17z64TepFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XFcvsdBA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kzPTwn5S; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XFcvsdBA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kzPTwn5S"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9BF247A018A;
	Wed, 11 Feb 2026 06:48:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 11 Feb 2026 06:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770810521;
	 x=1770896921; bh=KGqFqk5CDifhktzAa0Ue+KvtRXWE547FfGHaWyi8jSY=; b=
	XFcvsdBAFhV0YlVskpvfZNP4FAzkZvp0rRWNOj7Nr4+GEwwt79WePMUwFgxRXOeB
	SChiZOKtE9DN/YQyiG2xU5Or/slW0dK35JevozAapr3CKQiLEUfTvEC2XwRKvWSE
	XEJ29f+nrPoTTgogVI9xsff0AbdfXYsujB/k3g3n51ECQqtyqPj8NCakxRYv+uE1
	Z8h8DXlMNaMBO37CzbG2rmyZ7VR1EDFsnAqYBMOnlXuh7yVP834y3YRs7Dr/aBQk
	G2DT0lSekSGg14QKZmbBvjG0GvQPLOVAn/5MtFOZL8M2qyy7HiJv+eYQBbBzhxNO
	QNF1Em/c/CjLvojZqOoVfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770810521; x=
	1770896921; bh=KGqFqk5CDifhktzAa0Ue+KvtRXWE547FfGHaWyi8jSY=; b=k
	zPTwn5SUx6LqoY7l3nWD/6zul7Y3MqNq3Ah86r0zg/EJep52xeAVxYauz2KRbqBG
	4w4O/3CmG0WJONBthKvgEHI/wifJnJfA4GHbFLiDxleNuu8UouFfbjO1BQatzbcf
	9vW0QN+O7+pdHrOyNdUqcvnOFNcaeXMtD290OVNrvAtuWOfthAi8yQo8lDtBkPrM
	n1dAlqMPU1dZxF//jsIi7c1tlOj1Sjyi9zNSux4inhSaj5JYWiYScne/babhiFKS
	1u6GcW9Stlua+OICJ4eTG44lzolO0idDXJ+0I6LtHMWxmCcGL3UQEFeAxl6DppmA
	s6ltn0FNCM9O1hQDcl1QQ==
X-ME-Sender: <xms:mWyMaR_QV1uFLNVoUPK0E9WvoWZKbem9x0DkjcNYEmYe3s5g7CG_pw>
    <xme:mWyMaX97wYbHK67PY9uYCHXIX_SKs109-JAHQlmpZfdgKv-ObAmXiyVPE25yLzD3d
    KN_3qM8yUL2pXPTehNEQsHREYf0kl4Wt_H4nPjB-2ypEq_kwexF>
X-ME-Received: <xmr:mWyMaRSLrRu-eKNm4d94AFo9CiBkHAv3FWdVSpmGpnJWrVEET36iDerqKPmvk8VMa0gSHqhXWdge-mwJ5R3hWUIHss3umgG372llsOAVoCGF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mWyMabed99DdGV4NAg9ST1s33SgveFS6_tKc_6W80-v1otXtYMjaFA>
    <xmx:mWyMaVBlic8ffKYDPegFVZ4iTvYxP4r8hkLhAWE7Zhv-2aMecSkKEA>
    <xmx:mWyMadlik-YudIVysddPjH-0WC4tfktbxvgdSneVQ_ZB_9sGJo2N5Q>
    <xmx:mWyMaQdodlnKTpsNQZ3bbp3YkPg3PiHuUgJex3_PSDIigqxfU_4wAQ>
    <xmx:mWyMabD7-s3ebboFg3rAaSgsqd-xBeOmBYAY1zt6o946JNeZtylgoTAn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 06:48:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4f9422d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 11:48:39 +0000 (UTC)
Date: Wed, 11 Feb 2026 12:48:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 8/9] promisor-remote: keep advertised filter in memory
Message-ID: <aYxslPnqyKP-mgcM@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-9-christian.couder@gmail.com>
 <aV4v9WhL95Gcqr2t@pks.im>
 <CAP8UFD1za=FowTWBqjanyRFANKBsc-+LOcbSsuBzjeiK8T_fkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1za=FowTWBqjanyRFANKBsc-+LOcbSsuBzjeiK8T_fkw@mail.gmail.com>

On Wed, Feb 04, 2026 at 11:57:42AM +0100, Christian Couder wrote:
> On Wed, Jan 7, 2026 at 11:05 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Dec 23, 2025 at 12:11:12PM +0100, Christian Couder wrote:
> > > diff --git a/promisor-remote.c b/promisor-remote.c
> > > index 8d6d2d7b76..d5f3223cd0 100644
> > > --- a/promisor-remote.c
> > > +++ b/promisor-remote.c
> > > @@ -837,6 +838,7 @@ static void filter_promisor_remote(struct repository *repo,
> > >       struct store_info *store_info = NULL;
> > >       struct string_list_item *item;
> > >       bool reload_config = false;
> > > +     struct string_list captured_filters = STRING_LIST_INIT_DUP;
> > >
> > >       if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
> > >               if (!*accept_str || !strcasecmp("None", accept_str))
> >
> > Nit: I found the "captured" terminology to be somewhat confusing. Can we
> > maybe rename this to `advertised_filters` to clarify?
> 
> Well "advertised_filter" is already used and I think it might be
> confusing to use a very similar name, so for now until we find a
> better name, I kept "captured" in v2 even if it's not the best.
> 
> What about using `server_filters`?

I think that'd work better than "captured". But we should probably not
call it "sever" but "remote" instead, so `remote_filters`. I would be
happy with such a rename.

Another alternative would be `accepted_filters` to stress the fact that
it's not the complete list of filters. I'd be happy with either though.

> > > @@ -935,3 +963,23 @@ void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes
> > >
> > >       string_list_clear(&accepted_remotes, 0);
> > >  }
> > > +
> > > +char *promisor_remote_construct_filter(struct repository *repo)
> > > +{
> > > +     struct string_list advertised_filters = STRING_LIST_INIT_NODUP;
> > > +     struct promisor_remote *r;
> > > +     char *result;
> > > +
> > > +     promisor_remote_init(repo);
> > > +
> > > +     for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
> > > +             if (r->accepted && r->advertised_filter)
> > > +                     string_list_append(&advertised_filters, r->advertised_filter);
> >
> > Would we ever accept a promisor remote that _doesn't_ have an advertised
> > filter? If not, should we maybe `BUG()` in case the advertised filter
> > has not been set?
> 
> I think it should be fine to accept a promisor remote without an
> advertised filter. The server might prefer to not advertise filters
> because it thinks that the client should determine the best filter
> based on the client needs. That's how it works now.

Okay, fair.

Patrick
