Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17D4C10DD
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778528; cv=none; b=Ky2d4ypuT+bJuKECsKUd7ub//QRX6z1rZ9Ko0Zow7IbBmzps15aLNfzUj1Ccgn/RvcPE2zNRArFRplAaz8jB02KnVf9WGWXfzhmtL8iM4NlHiTUTrG4Hu8rvQp5LwylvPk78JGU1QBqJt08TIgqDVb0m+F7lGDHAd6ivTruj1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778528; c=relaxed/simple;
	bh=P7fyc7acqrpdIGo6nhHHXDUYTqy0+HDLI9VunMHSW2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5581gjoloL5czGYGGuQ6pjpwjrldTL1vhQCGf2EpKxiavijdLFQ9zXA6v/wE5MK2yFpd6hO+JsHQYvfFVNUknwYxss7ZRB04DhCA52hWsFZN3sv5oRWNDY28dXvjedID7jsdRPbaSBkZv5FChQV0u1NnKePkw5hhmN8u6u1eVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MU/FRlxC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JDwlA9OJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MU/FRlxC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JDwlA9OJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E8021400220;
	Wed, 30 Sep 2026 10:28:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 10:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790778514;
	 x=1790864914; bh=gwzhd+Z9ZtRilngP/hckVKF3NuzzlCWCd7p2yl1D1rs=; b=
	MU/FRlxCNe9Z3jSFIDxiuc7Cs8A+ERgAm4DWeyWDIYImd6yrvsGMDuZxKEVRgxTf
	Sm77DS43VRIekQ5KvOeW+/0eSrL763armovw1z/cAorjHFrnr6Razt7d71GDG04C
	7rput3oAbxQlgqGv8Nce/Sqa1AijyrmF7b5UqOWfS8186sUyVCCA/bisWvJub9v2
	lRDFbroblHQ5BHQ0mk3+uaGpnbgHSs94PuJSqXjFuyDQiMBADkFayqQA00BGVvt8
	Bh2rFOUr4AVehefv6Mog0yiA4dRA6IXlkTLSRuXBx3whNfjyiDVmUg/vRpNMAQWB
	twsMHRmJrXSRWB/EvZG8yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790778514; x=
	1790864914; bh=gwzhd+Z9ZtRilngP/hckVKF3NuzzlCWCd7p2yl1D1rs=; b=J
	DwlA9OJriS2SE9AYWwoPVN2aW1YoRwyMVWrvrr+O0fLlaRmnd99dT450aFVCiQK5
	S1JibhNwGi78ute+ZeZzDxsB+/MQmCnWmIoRRbkizz6SdeQUK1Fa+qCK4ucGjf3f
	iOvJPyp//sUwUmFLd6g2LQhxgvEtBJ2ljjjMFyaVet+y1vCpy8Fb/lfr5hbKQL+S
	8JFuUxQu3XHv9wRgCA2YKTkG0YXyZZ4zmXs5dEeM4iFnJ0UfYvBgq1r0TXSWCVq8
	GaKcJAEV306uwd4ZrK+3JoC9uRI8hxJ//9cDike5cfTJTHiGiDbHcgjFOUNoDfnu
	58qpbqg/5G0/sCPE7A8GA==
X-ME-Sender: <xms:khy9as85RyzU32fuEzIV4MiKGefTSK4sFW9YCubaeD9Z6irbCBoohA>
    <xme:khy9aqs2q32HkCdcFe0c5cN6sWxa6vUkmjR0H5HZJDo8vDij8W_V9tPQZf9HNODlJ
    Chq4wWF5QUz9vujvpnb2SgOM1otZ2cv6bcZrpBF_cVNqGyx2DsesmU>
X-ME-Received: <xmr:khy9avre8DhQLGHEnXj1ja2rmB8JXA8JTPMU8vG7S5hcDqIP--_hCg>
X-ME-Proxy-Cause: dmFkZTFbk2vJu6N5rT4coHsGwfnGPgXhRPjS5a8FrNDGquqeUu2PW37GxbrxTawODRSXc8
    YnQGIvgb7rtzc+jk/nBLpkCSwveI3GfxrBcKcS9gTnqHbmhXiCBDuUQklUFkqFn831Htcc
    XBsZxLeBF2O9vaif5PXiiPUatWdFOU7wdpYHgHYAn9bW0nZTowZI78jefQjMWJ/Iwp+uD8
    rzmFtjfgGW17pzjDYyDCKZnHs93BJPkWifIO4PeApnPOk9ciUhpvL2t6ByM1lPugVFmVUP
    1mhkQBAJUG8AWflkHJtoVIf1ZHD37k6m/PUgcz+7bUeeuPztCGcCDcbm/CSxiWhtEAO6cG
    Uyg5N7t+AUIs5/TyV81jAtXll5nxANZMpydWWTLrJFcg+BHC9Ty4KDccZscCjlh9M89uvF
    OZLdJ0quM2eGElw99mb2SfeKWZ58Cy/GQLjw8YBuULzoPvsy2oQJTgzCyoH6YMkVeWzcqI
    CEVciJYVYeOdXr8iBUJdIqRSoD5uP2CjJi3uDY4cRM/NY2voo4DEIlBH+7v+yh9VT//6y0
    LXimoq5y6xFxykMj6Vi2IDjzWkCYq5ZKZVbdwrw12/Kf+LGz/Zz30odnvssc8MZkD6eAFA
    DoSRAQcbSReGLcMuekbyJ1es2N44clOIH1bE2+6XbvkdRPKcxtBn16lqS87w
X-ME-Proxy: <xmx:khy9annVNSkO1Zw9aGKL4PcZcl4WHmM7-ctrFuVXqLU_FnS6bsbCvw>
    <xmx:khy9ajwYCY05NLqyeCsFkGJduXse_XiidplvEhBZsnMiuMgNCuwrxQ>
    <xmx:khy9avkkjTUwDUFJcExh_FkgFTURXEIjmXPINO_yTbLFyQLlLTBsnw>
    <xmx:khy9ascmcXvs-y-IaXEZwWbPEbwC7FdAy8wBJ3OKzPqEf08DoFmwIQ>
    <xmx:khy9aoVbYGEqvDZ_cKkZs1LHM-YvdhD96g7dkfLXwVysPTReYHbIRJr_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 10:28:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc6c7cd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 14:28:31 +0000 (UTC)
Date: Wed, 30 Sep 2026 16:28:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] doc: transform breaking changes doc to a manpage
Message-ID: <ar0cjf3rdrp6NAba@pks.im>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <gitbrchanges7_please.d1d@m5gid.xyz>
 <ar0OicAaDipYx-xU@pks.im>
 <2e53feae-94fe-4e1b-9665-2a639fe08515@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e53feae-94fe-4e1b-9665-2a639fe08515@app.fastmail.com>

On Wed, Sep 30, 2026 at 04:17:44PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Sep 30, 2026, at 15:28, Patrick Steinhardt wrote:
> > On Mon, Sep 28, 2026 at 12:41:25PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> >> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > [...] The one interesting question about it is of course what we'll do
> > with the document once Git 3.0 is out. Will we retain it? Will we
> > remove it? Will we empty it and make it focus on Git 4.0?
> >
> > I guess once it's a manpage we should definitely retain its contents for
> > a while longer. The breaking changes will be relevant to users even
> > after they've already upgraded to Git 3.0. But if so, we should probably
> > introduce a new section for Git 4.0, at least if we already want to
> > start thinking about that.
> >
> >   NB: even if we start thinking about it I think we should probably not
> >   release it anytime soon. I guess having a major release once per
> >   decade may be good enough.
> 
> I know you are wondering out loud here to the fora. But just personally,
> I imagine that this will happen after Git 3.0:
> 
> • A section at the end about Git 3.0 for historical interest as well as
>   people on older versions who might be browsing outside of their
>   installation (probably git-scm) (and who might be on pre-3.0)
> • Git 4.0 discussion before that, however hypothetical or distant the
>   release date

Yeah, that's also mostly what I arrived at, too.

> >> To that end, let’s move the text to a manpage. But keep the old page,
> >> just linking to the new one. (We wouldn’t want to break any readers.)
> >>
> >> Just do the minimal changes for the new format. Also demote the first
> >> section to the second level, i.e. make “Introduction” the same level
> >> as “Procedure’.
> >
> > I feel like a good first step could've been to convert the
> > BreakingChanges.adoc document in-place to use the new format. Like that,
> > it would've become way easier to see what's actually changing. The
> > rename could've then been a 1:1 move.
> 
> Like this?
> 
> 1. Convert to the manpage format without changing the filename
> 2. Rename the file: pure rename without any other modifications
> 3. Resurrect `BreakingChanges.adoc` with one line that points to the new
>    document

I guess (2) and (3) can easily be combined. I'd hope that Git still
detects this as a 1:1 rename.

Patrick
