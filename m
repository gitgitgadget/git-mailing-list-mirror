Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58A3A9611
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503342; cv=none; b=adUXLdEbzOTBXkfyWe899Es/TYv7H5CNfhKl4UZ59XTlICOGESusOVAcKIHPXdNGux+ADlMa+2bTVVK6TR6BQnEvy3yaArqNH39CKO3vY92lT5QoM1vIc3mqKOgBK5qDAj+Nn+Kq08kfp/0UAzouBJDwndRj0UXilE2lD7BY4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503342; c=relaxed/simple;
	bh=eFJqJshwezFGae9hPbrVh5gcxixCTk63szLURhk5W74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPnKuBYFtCimS91b/GlPD5DBXK8pGf5nn0dfS37yfodffColqKVbrIL2BbjScT2cXTsjWJJeBlhT67kE/5l2ByyJAejTCspuHwIAiMTihs8M7kvcCceVAzFP/CrZsymirbCpyRnPhYpqgJZLGHG3dEpTBIMpdVGOSWQv/WUuvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lvFLoPby; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrHtfeFt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lvFLoPby";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrHtfeFt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 06A491D000C3;
	Wed,  3 Jun 2026 12:15:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 12:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780503340; x=1780589740; bh=zOFRUvOrH3
	G45lnPu0ILqPI1NY77X3KZ3/AmvBW0Q5w=; b=lvFLoPbyROm1pgJ2LKrzGPVZW5
	m7GjOxHhVSTnYtzv23trJGuMoxYgySlMvAq0UXVotvdnQynXFamEvHJ04AI2jq8F
	PhGWXb90CfpUem71zTZUbEgQhNXRC4vVrivk4WaFK/qzr/0QQsZnhyr3smXVbrMG
	cYhzqIJXdfSyIXi1TR/QFiS03YkfkdOHNEqonfPHHJRQ92bOZsNiACHmz0YZOOvQ
	DJAoxxm30+YlEEtIHB/5vzjqkj+a0zdo+s3/1v9H/498QWWV/3xQhEGB43k2PqKu
	wiZgk19pTcUtxOab7E0DV5O/BA5GCMuw3qOTBQIsMFunbztiGTC8nyRxZ7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780503340; x=1780589740; bh=zOFRUvOrH3G45lnPu0ILqPI1NY77X3KZ3/A
	mvBW0Q5w=; b=VrHtfeFtbxw55NwL1BgjCX18nK2cr/reE0e0N5uxrR23/TEh/wd
	Nv3m1BjUtnj7QkjfthNyK2quh9yVhkX4gDH1Tbk6Yg33TQ3hkSR/lMhH7T1HnxHa
	hbuc7NnUtJ1Xiu+esav3l2wa7M2oYSD01nwZfWGu9ZGpkVHsWnT9YIRo20PwNHBM
	p5hOBCo8vXz6QEGR1MFgRrt/yEW1/BpXyhdfa/iz/qBJakhxwSL4RuyW/EiuQlwV
	hRA2PXzFUM8+T4NFJyCaWzpevaZW787hNJBuqLSnSECv6KoZVFJ6Ba43Og0LOSo8
	H0AUketM5lWVO+e5KKSmn+LoIJ9SOJIeEUg==
X-ME-Sender: <xms:LFMgao1mTAS-Socmoc5QTFj0Za5rqSGndqehfjwi1UxNFTQkSkty4w>
    <xme:LFMgaqhPePoxHmoJBT9LgCK4GYkq4jteLXopGd14_kcwv7Mj8KMbbm3E0XiwmJY3G
    c9YLjB2TUlqpU__pEWg6obHyBl4nBc4Zo7WLkef5cVLwLGvNBOKUg>
X-ME-Received: <xmr:LFMgauTiKBDhKfpsmupggr97XJkImYYFG0vvy5HuPGuEktCOlW-KsGb01vTGJ226iH11alEflF78urSGCykIeLDAdjS6sDvkFBol43sT5AHQ>
X-ME-Proxy-Cause: dmFkZTGNFeSpRgPJrAZKSV7ES+czF3xXqSNbdU614Q0P/l5aq4m7+vl0Trd4X70AShanQY
    JXDbZbv2Jk9EXs3jnrVZNW98AMeBvnVrXNjv5evHDaQnvtvWdpc/vvwEI8PFZs1yK1+RGK
    0zd6VWuzony8zMWQdWwn8QP1o/v51hGj+ZXR/D2LVRCgN5qeVjOLGJtTKV0gotqn94kySP
    dyBEv2AH+eUPyOk1BX7rrHIAN4YFgtVDl6Px+Og+o6/uZpRv1oI06xOxYaCDLbtrgzTOql
    XF2luEoB2EfNhveBzljSwMNtTRMyrrQ88ubiQFls+mv+zHbQ2RBjaoFd4bl111aEgGA8sm
    a2Rq829K4/WY+3YmCpfmR7XiD9QJTY7XzmRj6TWf6AI8O+IsY+gHRx5nAh6Fa6C1MF/aR9
    b5KyYQhW2ckdcGELya+dufUVIgff8NFjLNtPJ/koqDLpz91GKtG5klzbrzlwv73kpS9TD0
    3WqTXwjF1PfeE9g5QcVC3rWXqyBStkSHyVustJi1Z7SCBX2iN3rw7hvrRqn1s7LYjkXXDa
    5lSWvZJ567mR5wEeLXpUFMkxICmU2J9psXeAnuVRu+OXtenVyMCPh7Bn7y/T+slvpNaD+u
    Dnnec2UoGOAdbPnoLBI/5jGJyqZ9aAn+Piz7i8M13TGc4v8+6PsP/HzGiolw
X-ME-Proxy: <xmx:LFMgarj2O2iJYSVmfCJ3CW844m9inPVgW0bfc7yb8XUGdUAUWhD0bQ>
    <xmx:LFMgau7XMq29QNXP7oZFVwHD89PHq3pIkBL3EWqy4LODfsOtSEkd_w>
    <xmx:LFMgaoBFn-phVhAoKuB5jMsEFC2xArEp566HwPObXzDiH8Av7eCFzQ>
    <xmx:LFMgalahFH7fmRTIr5MWVhO6aYk9SLyI4N1Z5ug2FsDAo5mObWd8rQ>
    <xmx:LFMgaugbnw93KNvQbScYVKwU2RDtLyfqfQjtY_25VEQS3NTDKoYNnXSj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:15:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d2001b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:15:38 +0000 (UTC)
Date: Wed, 3 Jun 2026 18:15:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/18] odb/source-loose: move loose source into "odb/"
 subsystem
Message-ID: <aiBTKKtj-evY4Xzx@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
 <20260601-b4-pks-odb-source-loose-v2-1-90ff159430af@pks.im>
 <CAOLa=ZSRQpAMGDwfP8vAiJi+G=WPW=YPrrs21pVt1O4j2Uh-zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSRQpAMGDwfP8vAiJi+G=WPW=YPrrs21pVt1O4j2Uh-zQ@mail.gmail.com>

On Wed, Jun 03, 2026 at 06:07:14AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In subsequent patches we'll be turning `struct odb_source_loose` into a
> > proper `struct odb_source`. As a first step towards this goal, move its
> 
> s/its/this?
> 
> > struct out of "object-file.c" and into "odb/source-loose.c".

Hm. I agree it would read more naturally with "this" instead of "its",
but I'm not even sure whether it's wrong. In any case, I'd prefer to not
reroll this topic for this one nit, if that's alright with you.

Thanks!

Patrick
