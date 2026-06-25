Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2233009E2
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369338; cv=none; b=pLprcLVv2isekaW2zYMhuLLRvYgYtpu1wHtc22JQqI4g6o4j/VV7+aXoJ9c8ZpHx4D+HSqDIV/o2QXs/cAakYESBC/8InXxJiW8iWvLJAiX1pJJCynj7Z5NcnCFrjnaIAXbryvYKyC7OZqX+NufbBfMYTyZwM56RyIM4lCUpPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369338; c=relaxed/simple;
	bh=9gn8yAb1ggj66bAXazSHV6xDic6d/v0jCb9oJUbp8Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSUWXHiGYs0ZX2u1anqQTj8fFKfJiJmmxTCfI84gSX/+y3pAPjaNBi6zMIuK8IJQzFBqTzUvD3/IbGGrmNhd26zMlQY5tJU/UEp8q1lw16mmVxqnL0lLAqwUmNRk+DGKgQWl+RFYKfLn0z7PZwFHUK1Dgl9G5JK6AyWGbxTuy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QpomjvaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgKUoV1j; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QpomjvaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgKUoV1j"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 40C451D00107;
	Thu, 25 Jun 2026 02:35:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 25 Jun 2026 02:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782369336; x=1782455736; bh=em9EI7A7hY
	dM/iZOx1YSaNmWuGHUP8ZiTRMcWCTrxzI=; b=QpomjvaM7PoY44m+SNlEs/FtYY
	SfPNoneC5e742UgIR9WGOhxWpFqmqO5d6pjXQcuswOa4xTKcXZpoOenaxi6r/o8S
	S18nr5LkUC4OvAU/QWKZNqTmELSHj5j4Aq3TeJEYse0igvyz52HL2C0eejaBcgFb
	XtLu8zEuTdRzjOMUipo18LgjFLIqGzXoHj681SiQnHQBRXLXI71FfCXBTdQJg92M
	yZoskaPS4c6CDwEj5MwrDoN/RZCf1m3gLNKszh5cm3u5/QkqEKchWvPQIxsUBIee
	S9xxAp+n9Tw53ZzyG49M+7s08aoDvm7WLH+EyBGXG8J+8FuM30RUv9iXmBog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782369336; x=1782455736; bh=em9EI7A7hYdM/iZOx1YSaNmWuGHUP8ZiTRM
	cWCTrxzI=; b=LgKUoV1jMvW9ZWJt036SMyuRnrgi1VkmUO4gIbphZ9XG97XH4SA
	Cuo3D5dGaCLH6dibbKfKz2JMEiNryGARWLwf6F0M9CAl3LO/hsJIRvSIUB0hT+IE
	ijlyC2UEvsqZU+d8r74h9ZHsU9qFEN8vJAzVsofsaF+snlKzQ1XDPArvjmmuQnZD
	Ae2uC5cb6qrFxEaNZJN8wZsv84Uqxe7AZ1hcySoDFANNwVroFGzvOp+NxQ1PYnbf
	oJtKYDuyWYflzFSCMQ2BJclhtZBIM/wZOJ7ggA0wVEpDTG0Op5G6CtcHLhtEOkBW
	fRyRu67D6xKH3DfN1FMNVtwwfjwOSKKaL5w==
X-ME-Sender: <xms:OMw8asiueLDPx3TuUkem3ioDRLMLACxTyLS--MwwzSOJAXem-xzRyA>
    <xme:OMw8asDb-IMXMki5B9mOk62F0HR_RtyGUPLTya3Mu1DdhOGwQbzBRqE5fAugTGwL2
    uhCJCJzas9O-J8QqRmXzcOAEk3bHr2lllyzIIdLZmKU4W-qS19LtQ>
X-ME-Received: <xmr:OMw8apEeTkmcXuC7A2KHko3GSxa-trMLkYXi8-ycYZ_vbmuDfTdCgr7cBpi-ojfAdfx938NPbZDoow9uM0xby1xLvolDE0MCPL5vIpYRnA>
X-ME-Proxy-Cause: dmFkZTG4hXZxPrlQ3JQBSMtM8OM+fltKO5dZ9pBWUS2CkVIBy/cLCHeLaXdk8KTb847Hx/
    CZoLhIbDP/9xyQ3oTsCV0Z0uQhn54jJzPGg+2AGQSdgiQYKWHBLacmPk8qwuuxqY7PDUEx
    oQHsxQugnBo3Has4LK+UBL+T9wXvXG3OzRvF00A1Ttsb4iTXsAcWgSI0EySDbeqnLV6x+4
    xy08YJrsAnPxlF4DgEyLIYgG7u9cplSUj7YwI/73W/XNps7S5XWdgzI8xyOIJJldc3d4bo
    DRr2/+cLDFwhEHrbDv1CZ8AwEmbC+p8URYT6eAaPblXdA98V/SdLpJdU7O32OBIjmyB5JD
    N2IK7k8Avp92EzLDneXUprIwfCOi5XWVL4N4FkpOR1uF7QJ+wvPusrfIvHjMW3BaCH1jZK
    oIavCESYwej5d4MPWRph6uyRgk7eK2U8PrtyObTHBgplSTdo8Ba0z0c6YknYH4xizCcqFS
    VDJZ3DabH01/AVtEQeuDxHWMeMEwbRcMwAJ489q+//7t+K2YZ/R1HISR4R/qLySvmVis17
    i+k++2sR/thQK1RKp3W6UbtgFmmZNH69QxCrK8a5ugtHrV+yFUPEOy/FjWMHlgEQqDFW/v
    HzSfR5za8ZP3FLYdO9YmJ0gATnsjwVGd3rnMqpInZAQer+sOeSiRHkNhmmyQ
X-ME-Proxy: <xmx:OMw8asJXhSrvG_TnXaVc0yj81I35vHf5YSC-NNdvOBm4azF0HeS4bg>
    <xmx:OMw8alnft7dFaEuihC1UR7H79l1GwHS_lFq2hoKgfe3ah8OiWJOKRQ>
    <xmx:OMw8asRcls4Tgug40wTK1_IZCqUi0ssax0WzCumNsKX1JBMmL8ZJlA>
    <xmx:OMw8avKq-BFcEXEAdEMYy6AVM0zG-dFGJAk-c21_xT3fJuY0BFv4nA>
    <xmx:OMw8ahJL60uQaLFqudOgHpgSWE3ZaUha0jIkb-V7T93xczm6DD91Cp-Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 02:35:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8876435 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 06:35:33 +0000 (UTC)
Date: Thu, 25 Jun 2026 08:35:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 07/11] refs: move parsing of "core.logAllRefUpdates"
 back into ref stores
Message-ID: <ajzMLEgOs7E9kiBK@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
 <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-7-018475013dbc@pks.im>
 <ajxEXMTBmii01dVP@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajxEXMTBmii01dVP@denethor>

On Wed, Jun 24, 2026 at 04:22:07PM -0500, Justin Tobler wrote:
> On 26/06/22 10:28AM, Patrick Steinhardt wrote:
> > diff --git a/setup.c b/setup.c
> > index 79125db565..0c6efb0560 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2584,10 +2584,15 @@ static int create_default_files(struct repository *repo,
> >  	if (is_bare_repository())
> >  		repo_config_set(repo, "core.bare", "true");
> >  	else {
> > +		const char *value;
> > +
> >  		repo_config_set(repo, "core.bare", "false");
> > +
> >  		/* allow template config file to override the default */
> > -		if (repo_settings_get_log_all_ref_updates(repo) == LOG_REFS_UNSET)
> > +		if (repo_config_get_string_tmp(repo, "core.logallrefupdates", &value) ||
> > +		    refs_parse_log_all_ref_updates_config(value) == LOG_REFS_UNSET)
> 
> Huh, can `refs_parse_log_all_ref_updates_config()` even return
> LOG_REFS_UNSET?

It can't, so the second statement is really redundant. All that we care
about there is that the configuration isn't already set, which is
already covered by the first statement.

Will adapt.

Patrick
