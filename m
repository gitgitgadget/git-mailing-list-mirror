Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CC386C37
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301574; cv=none; b=gaP3RAkVy2+9M85zR4i8MOdRTXzWO9cmC8kUiyA4ghxjf9owvf5mNhm1W06l87R9R+eCm5K4rGZHKJ5EwJgW13rGVSyEgR7A+hXXGny7D5/nTjBqmwRuTZHW8hg5t6sQZu2sT+tCJusftuiLeIqegJGsGuh3yIykI19ggZjSAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301574; c=relaxed/simple;
	bh=8+JbuAF4730V0vdNGpukyKnL/oIn+QPKFMsNoVTNpX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/lVpJB9CG3dhcoTMxd8u7+coNshKtywU5zh30AzwSPiPS9ZwjYYkxsa1cKWougg9f+gafTDuCxHRVqEaizIjeJljvcEx6Oz1IfYZ5PnOUr+zlo4zBZFm+ReLG5UwgAbr55I/CemE++N/EerfPZynuakv66sk9GdsPiIjsNuzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d14XJkAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dbMtFqva; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d14XJkAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dbMtFqva"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A7F99EC0093;
	Mon,  1 Jun 2026 04:12:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 04:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780301572; x=1780387972; bh=8+JbuAF473
	0V0vdNGpukyKnL/oIn+QPKFMsNoVTNpX8=; b=d14XJkAnbBgcnhZpL0SBuLFwVQ
	6/FxVf3Ltm9dw/D8dKQ0X8sT5rHc+PBz/7Yr9lpOyXqxBo5L7yVmH/qPkkfmC98Y
	vY94GlVaiLS/b8HIZ2JzmrqCKii3VPti64CEvstLsdzRhWeoIFyhcyGqEeIFGbyd
	iJNVpO4RVJyZq/rDUEGT7FYsG3pV7a2rf7CVvTpWkhql2gKHJZsVQdZRNbWOQuNU
	rFatvX8R7S4KVE/xQOnURyiwgQCXcyQqXrvRZhRWf+Wke8+KOn8kEpXyfCwnkugD
	KjZLohG4sZg5s4bWHKnoWDpN8WRGrX8q+pv8H5HxPY076cv4IONClvWG+SJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780301572; x=1780387972; bh=8+JbuAF4730V0vdNGpukyKnL/oIn+QPKFMs
	NoVTNpX8=; b=dbMtFqvaQXttqrXIG4U3GvtLTeW+P/331vurE4yaqf6LN5IR3iQ
	F2HDM9pmSqoibNo50O+6IXF5u1wagWKOsABSED9JZavg7AW1fTDZFhWwL/7fuHAc
	gIFjVSOiBGHX32uby01moWsgTQNtdC6cgDFLYFXFQrj3LMStUNuzb3RhoZKC+NjL
	MDf7LgnESF4SRblf9KWAK9al6dAKSSgo8NcLO6408AaTbMJbKJs0at175IH7f3Wb
	a7lldkFGzKBOAB0uy8YoEJwVrNoZzM3SlZFqDW8kC1g0PZxmvltyCrhGDEUEZUqD
	pu7+ZZUi2h2L2pntTMRFUp6eSyT8rxCPcMg==
X-ME-Sender: <xms:BD8daoifDDfSXFUNSD9V37BqbLgQkyb3UJNIJQS5WQnPITnAQUehRQ>
    <xme:BD8danC8p6HmRSq6c3Gv9TqZwv_M-RpUrzhKaQSUDqHHMYkSH5OcJSrL9TWW0QwcQ
    Ki-cwZb8OdU_lXATk-HvmEeXXyq6Khf9VJssMX_blepT8bdlVPkoA>
X-ME-Received: <xmr:BD8datvRQJNBEOO5AyH3qaxEDwZvQl8SyNr6v6tUFNe2hYN2dQrht590nduQ3C6QzAvVgqRyyzWn9pJ6nFT0Qnp9QgvHCFZHfVJezarFIhqS>
X-ME-Proxy-Cause: dmFkZTGVOmvis7Q3GP7PmB0r3f+GWth65Zct/NLuWQIP/XDzTbFwUcosswMI8kU3LkxgTG
    uZdcsE+kI6BqfoUzTDuFgkLBcT/q01tuu4YtVdxXVsoFm83yEi0do3DEmUhZAlyg40SApb
    /6u16Ri03EFshG14U1ko4wC9U0ZQ5Xjs+qxZZf+A0555qexbraodV6jImlA72vvSk3uXV5
    kSa8rVL/rdsUgoEWK6+JORx60zsmfHsZfrFGvbLab6ryjZVbIYgQCZzHIGgD6Frb7hOI4B
    svFq12vxMh/4hfJ1A7JT3UIiYoPFKMbWd3q0RNyNmr3p2TzgMWiN9qS8Kk9+sd7+8ylenU
    Kon14etJrHml03mnFJhioTzg7IzihKjGs/MSLR0UFmi+jbh8KzKjpPt22dQmLNsC5KIf9/
    8sE/JK8VO8gISzN9fHBQoDwbDBHIRSNoQrcxj4UTOIJ8K7ThfiyFkx2xILUsu1SyHP33/W
    uuA1Ijk8/nd7yMrvVhlRrHN4zv1FKXgbPr4wTlDD2dEdMr+9bSA4peqdD9a5S4RFllRMSY
    jUDftfjSwt+L2A6HjAkQN8xmOAEk7e6LKaulzPtZtKPmaYdOYrCC0siCQ5VKJQCemn6Fwo
    PczoOSBvXt2CMltJ6jEmC3g5Hd/0jim7om8fLTNjFjSrFsMNPGnVLGxpZLcA
X-ME-Proxy: <xmx:BD8dakZl4nZRSxHOiiLNd7LxiMJ0qF3yq-rJnebnbx-WaKOePF5-GA>
    <xmx:BD8daoWAsP_wFqV9wBRsHXwozyPcVcWRsam86_EYlzQZxiOmkJx8lg>
    <xmx:BD8dag4i0t8RyIMeNcdrZ2ywu9KtAUPE5kjQIu4RwEDu0kkeiT1qVQ>
    <xmx:BD8darjGjXuyf7oiGa1pyf6HBpSFeHRTZ5txQ6otsszNDgAhwpFGig>
    <xmx:BD8dagRTBMrSWznsCwbztqcRrwljDq9JbV08f6nfVjSmoL9FIURcssNf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:12:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7e712f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:12:50 +0000 (UTC)
Date: Mon, 1 Jun 2026 10:12:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Amogh <amoghdambal1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] test-lib: fix typo in test summary message
Message-ID: <ah0-_w2znxOPWmLU@pks.im>
References: <20260525053633.73153-1-amoghdambal1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525053633.73153-1-amoghdambal1@gmail.com>

On Sun, May 24, 2026 at 10:36:33PM -0700, Amogh wrote:
> There's a small typo ("passin", should be "passing") in the
> summary/description message for t0000-basic. Even though this isn't a
> user-facing string it should improve the developer experience + reduce
> confusion when working on the codebase.

I'd be surprised if this actually causes any confusion, so I feel like
the explanation is a bit lofty. But ultimately, one less typo is a good
thing, so the change makes sense to me.

Your patch is missing the "Signed-off-by:" trailer though.

Thanks!

Patrick
