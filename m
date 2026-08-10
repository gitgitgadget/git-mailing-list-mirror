Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE633A7F4A
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351541; cv=none; b=H0W91fj4JXRZmI7Gr8SI7tgwIwKnjK5o5M2XwZ4u+8rcR+ydEFEA9LfL1CQ5xOrsOgvay0E6awvXT2fXyAUhM1n4J1RGdnH+APK0MYOXdj8bKXJ3jaMeBT+WVA+zRd4XbPPpswETp0fnYMCkbLI4yeDbLrPr66wge8dQ17F/Aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351541; c=relaxed/simple;
	bh=9BwdmE0WmPfz2gsTQs5LiGlUVwTLf5xwmxO00sEh8i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpsKZCSu4Ai2B352RWEARy6FC9Gwosof4/GlgBcPP5vRtbHv6IAEz1l2VTqMsBJGqrXsQqUh8+F9tKP0S2j55fqX68s81SOy/0eAADEahSNFmdOtspaZkLGvpVIVu2lCGscpcshJlsGmokXmF9Jad+quN1lj73VotvFeDgIDYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aQ+NAPtL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5fH+bVK; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aQ+NAPtL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5fH+bVK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5202A1D00224;
	Mon, 10 Aug 2026 04:45:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 04:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786351538; x=1786437938; bh=TG1Q6gV9qq
	Gq9iX1aF9XNKg0Qk8WRTMECWZoIIvOLb4=; b=aQ+NAPtLDEGMHGXFn1DhTNf2Z7
	Em05OBg0Juqi0NcbJhOBllzTIEOf1G5f5XG07ADwE+nE+FWS78L5WFhPsCIOnsyR
	8/EVnqYuDr739ziB0j4lF9XNQZjoy2rqQKyLWLlMwB16/l/NylJNHRLQuwBi1c7P
	/ZSMPstZU1eAZzWYRC2Glgl6BBEQnFgCvGrSmvWPOhxgXgp6PJVxD+JKTEPJbXsy
	zuxZc1tnpObD8BOy68WSGQ+Ox1ufdugUZrJvfFc1neVqCI5VhfHLinJ982ceXJ5M
	6F8Rf2z1MZCvHLfWBHDNR2Re8mLqrNr/vDQvTtz5iazW/LomAsDbLdlNWTtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786351538; x=1786437938; bh=TG1Q6gV9qqGq9iX1aF9XNKg0Qk8WRTMECWZ
	oIIvOLb4=; b=R5fH+bVKm1JixkmuefStcbcx+QP8jdEJZQltwEzYFTRFvONS87T
	H0otnrBRREXbeT/gAodgLwDy7sKO4MQJ2Zx+/gf/UKg22CBfRZg2Ol8EXDr3CuBP
	UECV9Nsx+gCer/NXV8A8SAdlG0wPE56yzU+r1eHcYpxHYXJWWMyP9VQEpQGAHztG
	ogoNiZjTByYRw+2wPbZgjwblFQE8V59Cokmg0BAwySBeUdF4MX/DuARv2icWp4BX
	++DVDzuBHBtwyy0y68W9EmMPKjLSEmEVsy1j2G1uf6F+dd/ewmP7Vq3neKmJwx0c
	ZdPPm2WDyVH93LGJFbBGysTwgDABs2fHw1w==
X-ME-Sender: <xms:so95as8aexW7u4OSYYuQZ0HJUhKSg1U5PoMBKdEj8xrjY3KWn6TYaQ>
    <xme:so95aoalxe9w9u3Z7YDlMVuU2Iuq4qeegY_aL7AH10RpR--OiAbyEVIB2lroW4CPN
    6V3igdualhDK-Dzhy7AadCwx3XPjGrRIclKSVNKdQmWFPYLvT4tsg>
X-ME-Received: <xmr:so95ar04Kb72VfvUmNVsB6EXfdod7IO6LvokXjh6NorQS-oNm-EjZrb718UrajHai96TwzyqC82B5FsIzB3DFf3_W58QPXMm89GXXqHiJw>
X-ME-Proxy-Cause: dmFkZTFcAafjabdGFy9Drut3rfaTk/MieoXZ573U5U2Dw2m3RF4IklI/0ebQk5noycnxRB
    ndmCAdF9JI5F9OLWBHTRxABMVdFsRCUGmfbzTlZ3YLu/6zKZFNHEPldCwNSJ3tZDC0bk3G
    3wgiftcoDzvk7A3+RZEKNzw0FGUv0ZnQCPfhgtIzq4yqrDi1n3/KcGr5NcbIw7biNR3LHA
    Qb4w9NyjIBniGurj6N/KbS+joWDNAKsmW/h1W1nuWfxn8wMsX5NLHZ8zy63QI7CGHvKCbe
    ojVpqR8MZTgDOZYSi5CUovSu+uwOOTRw3Py2w86QKpLgUcD2ea5HFJXKo1jqnG/gFGNgrk
    zXDq8Bmk/mY4hze5QYjVeo4QAcmT5s/9jBK3mcwu7YiooEyXPy5utr1vQ91eMpXFk/Jmef
    iTb5u60B3clh8SqvYI8/WTVenoDWsHoeZm0LP1Z2+cV0yjaM2YlNk0D6z2I7GGpZ1LRXmQ
    +Y+bouag+ux9tyq2BG8nMr1KOiEoUwZPf/lqotBXTJ97BnOl3oA1LZ8dhlUYnsOuJcBMBG
    OWxLPCCDrA+i/xsChRJMSYssD31KjZaRuaKWATNVnbAo3XS2I/27rJPmOLzuPMgtZLcrJk
    9SwB+PXg+1O9FynM5oZ2tdCe2BAaYxzHLwx+3ET+KVTsIgESQ/8nDKGnR3/w
X-ME-Proxy: <xmx:so95ajZmsBj0XJRTEnNKd75WgjKiYPoGnO_eLDKgLYPZWqP8lpJLMQ>
    <xmx:so95ajLYLXNIGl3Mmov2npcQ5eLYDv-PjuHy0vB-qj07HnfasLPjzA>
    <xmx:so95aiEYCnQiU2hr4aLo721gguitkfUX5SiXHOgwntxw8tz6ZeG2gg>
    <xmx:so95aqtibmRX8rE58HyaZ3yRtwPanypDoGQIdspL2BujTVlhSpznpg>
    <xmx:so95atrLj_QgV7zSv4vszHFVJOrHS7RdVaTvjY3bAXaFVf-L6KTOSSGf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 04:45:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4efecc57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 08:45:35 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:45:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Stefan Haller <lists@haller-berlin.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	"schacon@gmail.com" <schacon@gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
Message-ID: <anmPq_WN33chIEhL@pks.im>
References: <xmqq8q6ih924.fsf@gitster.g>
 <CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
 <xmqqfr0qexps.fsf@gitster.g>
 <anlpmNSjBUJ8p9RL@pks.im>
 <26c2f7e0-03ef-4c45-8175-adcc2e0395ac@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26c2f7e0-03ef-4c45-8175-adcc2e0395ac@haller-berlin.de>

On Mon, Aug 10, 2026 at 09:26:55AM +0200, Stefan Haller wrote:
> On 10.08.26 08:03, Patrick Steinhardt wrote:
> > I've been playing around with the thought of introducing ncurses-based
> > interfaces into Git. I've been mostly thinking about git-history(1) here
> > so that you can just move commits around, squash them together, drop
> > them and so on. But I think fancy stuff like TUIs can also be applied to
> > other parts of Git, as well, to make things a bit more visual to our
> > users and, as a consequence, easier to use.
> 
> That sounds a whole lot like lazygit to me [1]; it does all those things
> in a rather intuitive way, including Junio's original use case of
> selecting a hunk and staging or discarding it.
> 
> Is it really worth adding such functionality to core git? I like the
> idea of tools specializing on what they do well; core git on providing
> the core functionality, GUI tools on presenting it in a UI.
> 
> [1] https://github.com/jesseduffield/lazygit

I think it depends. There are lots of users out there who use core Git,
only, and we often hear complaints from this class of users that Git
makes common workflows way too complex. I certainly think that we should
up our game and try to make such common workflows easier to wield. Tools
like JJ demonstrate that there are a bunch of improvements that we can
do, and many of those aren't even that hard to implement.

So If we see that there are use cases where core Git itself is lacking
and where the consequence is a bad user experience for common workflows
then I think that we should plug that gap in core Git itself.

That being said, I don't think we should get into the business of
building a full UI, as that feels like a can of worms indeed. Adding
something like a user interface around hunk selection certainly feels
like core functionality that I think should be in scope for Git. Whether
a full history-editing user interface should be part of core Git may be
a different question though, as this is getting significantly closer to
a full UI.

Patrick
