Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7E3FC5A1
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004866; cv=none; b=CnXGeWEITujA1h1KSvOxw9irykHbeoocF7gcaZCIrsjKFgLZXaLrpUa4eh6Gq5S/0F9LYyVPJG/COdPyqzYf4ABFuEa6hNhVsPg+xpepqbl5zkxVRfHwag89uMi7fsbg0nklQFIRLZJdZIjQyX93rFJNxQ8+ud7OafbyE54umEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004866; c=relaxed/simple;
	bh=3raiHIhWG8CKXPBsLr5jkQHnRLM0xRCZia3258CBszg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mkk2j2iK9r6ceSu0uvH4Lr2pCLQfdSkCtIpUDZAZFWQ2OwRotPjM7brVRKSFuLPN/fv4QNKjdcQocz0FFyAxRy1Ymf59NocmWGlrWEi9Qbx3P55iHqNHyYFER/zAOG9dzgkd6v1ZVIB1o3i3GacNBHhCRjFRGZlvf1TDhZxGD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=agYw28wY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkPs4/ID; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="agYw28wY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkPs4/ID"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55F9D140008F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:07:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 15:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792004864; x=1792091264; bh=dgipVy8RHW
	IOeUiXjmDgBQHijRa8H53TgKz81Blk1tI=; b=agYw28wYlxcpEfohC4kctwWYX4
	nHRTkGAIeQtHWL57RouA88cSO+bv33PMMJrd14HcfN9tmb8pjW0mCPqsZqmYyNfS
	j9klJsyhqr//NZtgQlOzH6xuKKWF0wk1LIkoUrcbsa8Q3kvnXEj+twxZpmoQAiDH
	0uvw4Dpnhpbz8nwntm8h+pFnA3AeggKxwz7Mw8c2xy0WHxdf1BODXatKkbPnHLfG
	LCHzzydfOonTW0oSl+w4NGYIW66vXScLsBInmMxnwewGPjhJd/pY5eaXSvddsTV1
	XsWYjOrauaM7wR+idwHmHYJorZ8j8w45FzmWab8qme9yOzjkS5wYPdvoXcxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792004864; x=1792091264; bh=dgipVy8RHWIOeUiXjmDgBQHijRa8H53TgKz
	81Blk1tI=; b=CkPs4/IDvUtLlz/w+FgcawJFbnIt0F7nXNyhNHbjo4vfFZdX2ZW
	rebq83hx57u4IKXLSKpVPO43an4LAkIayXQo6xX30YdTSPGt5j57tjJ65prOdjHM
	EWUpy/QRHHcyk1zWh2H2Ci86AZJknFWG7UnFGY/AjpFW2l1jqURxkfQWGN7BcWzj
	d/SV/0XwO339gY1yrCe6IdAjrHUByqL9I3qRfbmiF3+uF/uPm6sF/p4pBpw3bNdI
	jwZEZHRXZO+PG2eCyBfoqy2yY7csb/0LJUV4epF6YZ2LTQfnMOuORc8wAuZDL8Ms
	ZNUShw2dGDym/uOeZMnJkZfdAHmXGv9rg9g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792004864; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:o1aWqMQ0l0tA0rsPlqOIuQrqYeSjMhfB9g8CMUUKZ6OCk+x
	/6aqE7Xz2NFQlBDpECn2KqAz7f+6DwgYeDPDQNd41dV+/I43wSk2tf5LGWrK4m37
	H0D/5iYfcSsQ+LFx1WelIba1bDGTZ8aurVLNHg28nkBIsafiHId3J1YTkmEi1U3p
	G6gC9Zw22ZJyxQa73XDdcw0VVSddt7pbXutauEUJ6qAihaQi9egU0sesr4S5boz1
	udmpyrtzQClSgyZlkQCP0iMH4cAgOnKJNqiMlVJqSQPGC3BjNpyb8QYsZpdJECiz
	LxPv4LaqK7QS/O3qa2rEa548AVdJrV50AbhQfRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:9WG9csdxZIz+vjNl0Dcjkbwmu+GRdNcwN6pNh0fyAw0=:3raiHIhWG8CKXPBsLr5jkQHnRLM0xRCZia3258CBszg=;
X-ME-Sender: <xms:ANPPaglG8c-9ekMkfws-zsjZtoTeOImzHM0mcVx92SestdNEoswVHA>
    <xme:ANPPam2oIRDGMXOeNmLUx5zFFaqJrrV3var3JVd9DOQa8mZrQbKpIxE8LoYGOTsV8
    MXHeJcq1G7fh_bEgtHiiVYvHVoGuXJtcLXdchtUbmyC03jw_OrcpKk>
X-ME-Received: <xmr:ANPPajqyDFSFHnhs4eRd1qmQMgHczzpm5sPVA9E0swcTWnS4W0gEC8OdRhvRwubrSalynXtYHGuGVdeGL_ekyVJzHL7WG2ixIG4m>
X-ME-Proxy-Cause: dmFkZTEfnQ/by1yunkCHj0uvwkm0ElZ5JkpSVpemWF6kX4BBnJXN+ZIFiBZ3QIkL0eY6PK
    f227E8xXve1Hfoh5EfRndQ6wYlmnWwOx7XERjTDuriawbUhpI/eAFtPkqZxi4UhQI/n5hp
    c+ewQ+vP9SPeZG1U5PME1+BzLplIZvmr79dj4RaB0FFA2jDWeBqZt4AQH0O/o3RB6svubd
    Hab7BeW3znNOBjHxFb7SPMPoiRQlmn4LFI4F0zUSiQ4rATAaNuXRobRBFv8CmH1+sWK8U7
    oNOfHUtc1H9vYXFaG0LI/H0mViPvAa9B4IqAsrka+HLm1dN3wyqC6Mj/nWo2utSugXYVni
    3yg6WBpRi/n9tzVsuh+hlcfsChTaHoplPNDFgi0cHK8bgu5m0llWVP/XLKR6siVrH6Tjjn
    fsuQ/HC7HS9wJYiNu1cUYu1n3lDELQi5NCSE9Ydeq50V2Irc3PN4phW7WKwGVYHF0dFKoS
    lvyPe+zRNQQREZzcxPcGKgSpfi0XGfFdXT0MjgmW/S3Uu57DuY+8zk8Fp8v9i3u4Sh56ea
    m7F+7scxgqnjEhKQ83Xh2oWuRrbUK9addHIgKbt3Xt3FOlg1lnMsW6n2Jl9j05BlkO8lCN
    IltJNRtIJTg8ilaDCstC3fscspyaQbkwCasWwl4Q7hBw8NW4H92O+OBYV+zA
X-ME-Proxy: <xmx:ANPParcMIKTbWBouLM0M4AzpYtbBLLQexsy_inh9nYi3oZ3Hq5pU8Q>
    <xmx:ANPPaqoJB8WR7YgM90dEpiSqt6B-x7ULmd4X8AdUFfTwEOhExFsNqw>
    <xmx:ANPPakEn_NlgofRl6v4pixJIJwsMzWykkM4ZE8WJAmo9_HyLDA337g>
    <xmx:ANPPaisweHFEhyhZPFiACFknB1oDHKxOQ6MEdD31F4Vh2ZJJiqFWhw>
    <xmx:ANPPakGlIm3KR13KYsIB_Ein7gjYfvuF_vjmaFVluV9-0x6wcq2Zv1gF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 15:07:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: jyotish kumar <jyotishkumar725015@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [RFC] pull: custom fetch refspecs and fork-point lookup
In-Reply-To: <CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com>
	(jyotish kumar's message of "Tue, 13 Oct 2026 21:31:09 +0530")
References: <CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com>
Date: Wed, 14 Oct 2026 12:07:42 -0700
Message-ID: <xmqq5wz4rthd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

jyotish kumar <jyotishkumar725015@gmail.com> writes:

> While reading `builtin/pull.c`, I came across a FIXME in
> `get_tracking_branch()` concerning the assumption that remote branches
> follow the default mapping from `refs/heads/<branch>` to
> `refs/remotes/<remote>/<branch>`.
> ...
> Does this analysis sound correct? I would appreciate feedback on
> whether this is a real issue and whether resolving the configured
> fetch mapping would be the right direction to address it.

The reason the "FIXME" you noticed exists is that the assumption the
code makes is broken.  Assuming that refs/remotes/<remote>/<branch>
tracks <branch> from <remote> would break when a customized fetch
refspec is used.

I vaguely recall mentioning a similar "map between a remote-tracking
branch and a branch at the remote" issue while discussing a recent
work by Harald to narrow a "git fetch" that does not specify what to
fetch, but I cannot find a mailing list archive reference, sorry.

