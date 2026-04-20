Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F580242D84
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668796; cv=none; b=jjEM3+G7lxryvlcmuqfotpUVmH8yi910TH5m1Ldz55R9wyHMdeUnOZk79on1MJQyphi4mNOR4Orzn2vcuVISoH7HcMVUwX0O8SsxY9BPnfacTgQdOOyI48G3FDMS4ky1jE5+dLvFie4LqyNgZCSdn2nfRlDtc3hu3QY4PDpebNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668796; c=relaxed/simple;
	bh=qxJbVMwcmbcAfATD1ESH6tvLyHxj8KeE8iDcE4Mlujw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVgyGfCSUiguWm3SgtsTVV+1JmdGhHGecava+oMsaQMyfEwoy6ZnZmO/VZsNevlpl3p0IEfUY3Cz+jfDJniR2JNxz2IcyZRJDo9zgN7zu0dWNnZA0PeD4enKga6YD48r37PxfKbVLxx9v9TGtjqD80ssx76kIaRmWV6FBtz44ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RRkokLNi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2pxKAa0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RRkokLNi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2pxKAa0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C47DCEC00FF;
	Mon, 20 Apr 2026 03:06:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 03:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776668794;
	 x=1776755194; bh=WASQTMnmZIw2W2tZbL+s8ghPM43j4zQ17cjorqQThoM=; b=
	RRkokLNidQgPqdjbB03xOS42hYSJnJocVk8sjpZoEzdOuDWCgHUCjFrs0MZF+7U3
	C6+3UOk63Qb7H9s0+/fGq8I+lSr564lF2D2hO/35zEwERV1ZRjmzf6dt6+jinLho
	c3l4G8OBMkbBOU9e7pO5CHE6M8rt3zJ9vvlCX08Ahw8rCXRHnQs4EQA5NIYVxZNV
	olamEZuRz+wIBAYjgsCiTQTgwBpRQzJOfZ0aDXPbBaFC4PCEWPuS+lgWMy2THVzc
	tB8hi0vbijqE9f4RLDAGBAmtRfgWjvNVf9nQwygk+oG24ns1RWLj5Ju/GF2KTdaV
	TFhuq0cgoJiI3JpzX4GkeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776668794; x=
	1776755194; bh=WASQTMnmZIw2W2tZbL+s8ghPM43j4zQ17cjorqQThoM=; b=h
	2pxKAa0qAwdfC9iRPCOzbuf01DCieOrzytmBNt4FPU58vYF9dos+JBWeBD3SYVIV
	mf36/uzyiP46Bz39/y3vY9kN1Gg62oAoL/bBH9SAkdxbUzkoIVma4HRJb/op4qCo
	pF/Lp34qeCVnicEfitff/9G6Z1BMUyqn3KWRo13XIYcU/V/dm2reZDyIACca61Q/
	l0a9WJyNrjTmeqajRqq8skuvryFFpAdUt+Iz/RiU7IvaygMxZ4Wj8+iOzx2jOIeD
	KrLcHWp2m78UlyAHUQquLJExilDGlHvNK2ppN0sko4zUWWREhSAiQgmQ5ossc1ng
	2l510vx0eC4BgSamuDdiQ==
X-ME-Sender: <xms:etDlaUPM0fA0PTnwa4cH-GBa_afuxM-GMtwzwNF8Nju0P0mXCorSiA>
    <xme:etDlaQ_KL0dHV9L6SyYLytFwu4ZVc60takVKb3hur3ZJbZgY50iBOulVwZGZ0ySMj
    pdGDrhjVrc76YIS_kwBjlnpvugp2Zcq2WYk0IKaeCSV9JSkAXBk3A>
X-ME-Received: <xmr:etDlaY54_7q-yUOezl25KLz38K24Vl6izx8O2zkFi5ethyots9Sv7ZKGPAKZFAuejFxHI92EQSU883OnUIadzYj5tRW42OQ30vCHZeCkdt3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:etDlaX0x2JMKnYPc5Od2Afgk73fw5GsMhgtTO4LnjexMn2EiyJrhbg>
    <xmx:etDlafDdhR7fw-fjTdKFwL_g4qLdduPr8ByhuuKwXkvukAMGWnYj_A>
    <xmx:etDlaZ0KPZtH4uiIqk8v1xsBo2Ndg7AO0VEOz40QfmNdTvSpjpM3Bw>
    <xmx:etDlaZtF17rbrraD_y9TV1V4RFjeLp6kGbepC9AlPVH-qq2Kv0rhZw>
    <xmx:etDlaW-T1OrAznjs5OtB2aHunPMAisxAMyYGexk7FGYMIPPITkv2ykhl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:06:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08cbe111 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:06:33 +0000 (UTC)
Date: Mon, 20 Apr 2026 09:06:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/18] setup: stop using `the_repository` in
 `set_git_work_tree()`
Message-ID: <aeXQdhffoA-wO_-J@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
 <20260330-pks-setup-wo-the-repository-v1-10-0d2e822837aa@pks.im>
 <CABPp-BEe0oN3ZfV6ZhFSADWWj_zEAx0_JUhc=Qc76-aqpSOxTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEe0oN3ZfV6ZhFSADWWj_zEAx0_JUhc=Qc76-aqpSOxTw@mail.gmail.com>

On Fri, Apr 17, 2026 at 06:16:30PM -0700, Elijah Newren wrote:
> On Mon, Mar 30, 2026 at 6:19 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/repository.h b/repository.h
> > index abeef3129e..7ae3d34484 100644
> > --- a/repository.h
> > +++ b/repository.h
> [...]
> > +       bool worktree_initialized;
> > diff --git a/setup.c b/setup.c
> [...]
> >
> > -static int git_work_tree_initialized;
> 
> Okay, so we replaced the global git_work_tree_intialized with a
> repository field named worktree_initialized, _and_ changed its type
> from int to bool...
> 
> > -       git_work_tree_initialized = 1;
> > -       repo_set_worktree(the_repository, new_work_tree);
> > +       repo->worktree_initialized = 1;
> > +       repo_set_worktree(repo, new_work_tree);
> 
> ...yet we still set it to "1".  Shouldn't we initialize it to "true"
> given the typechange?

Good point, will fix.

Patrick
