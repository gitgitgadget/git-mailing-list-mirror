Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56635F184
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933150; cv=none; b=JV76AnPP3hHkHAjzYVQmddRMWkYAfNI5QXZHKlNwWXwnWZX0qV4M+U42CM4PW+hnvanUOZOi9IjEZLdJim3PT1eI2raA4l1eno2oZUyVlmNrdPUoOT4SaKyJ07Lf0Gc+gYTEbllhGT97yqHu55Ku+z6KMNU54rIHY0dcWuj1CD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933150; c=relaxed/simple;
	bh=cIpX3OqQ5GQOrKjI9dDMTuIZrTZDDGdQry8EWlWnMOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVlEKEsElfTvdiU76Wi5WFh+6kRP399cMl2Pk1rQN4AcK0PZ6gjpkbRSWptK4HAi/Xam0fSzfzOSsjxos6BqcPh6o2P0BJg57NzvGKysmD2kwMJ0UdQnAiompgdwqT7Gsm/7JQ3oeAX8ZeIwb9o4novsybj5HlMmNGc+/NrHnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vjXEcWEi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MuPjMNAN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vjXEcWEi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MuPjMNAN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 97AEC1D00078;
	Wed,  9 Sep 2026 01:52:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Sep 2026 01:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788933148; x=1789019548; bh=eLjp2BCEwQ
	JFLmaoLk/I6haYTb8udrc9S+LGTfo50B8=; b=vjXEcWEiDy87G3j7KAi1xbjXhP
	aZJX3cYc8nPg2yK3Md46Q1e14joRyymhHY94s6O4BT8suww+wyvRC+aeAOQUwy5h
	rJlvxHwXV1NSCGuf2OYKCeCkaP/WSSRa93Jmovrx1G+Uj3kCB6Kqqg6y4LdwvquW
	8kMITqhtEjQgDzPsMnJVfvBLLSte8X7U4qPnOiYbkoa21BLyeOWta3bunTARKiZX
	1fILtaRjekn/rjKkjbWIfidByKHvjOk+mw7ZS1OaKOaOGfJHY4fG3RjMW++Y4j80
	LMNrtoMYjtQZB4Sz7qsHwcTcC7HQOGBjDMjV58QubRRN8sBEpHCuEEspbmOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788933148; x=1789019548; bh=eLjp2BCEwQJFLmaoLk/I6haYTb8udrc9S+L
	GTfo50B8=; b=MuPjMNANi1ng6JgMbHAn+FiGtnCMfV+6mbVRKJrvCfCP/K6yXDz
	KCohsLhuwIWCcO4cc1pzqIDr+BeWXRqug7SBpK1Qn0a4M3N1L2M0R6uDlWuTvGZ8
	kfVRpVUo3tKPdCJG58RQt+7N144TF0QMIX9n8kqIIkhYGGhwT8rjph0K6Uezsek7
	3Ja2P84osAhHfNxi6ZF+9cTLVFLVEHobEQWlpfpIQFJ5wpBPkc2cwhwIZnU8VlcY
	r31OoW1SkbxxhEzLKOucpQ+Nxqm0/BeW9MJCMoNkAf0DsQ6Io5s3HKpgHyTrJIpt
	3rhhK8lMECcnKrvBLVdUXicbwsIaVIufsXw==
X-ME-Sender: <xms:HPSgavsixZODmH0w0Tr7rWrE9cVEW5acmMMx1BWddLxOs_tSpFpXEg>
    <xme:HPSgan5ek6NWeX46a24mGuDx-RdyXJLM1iE9aK2aH4m4uFiGdU22ROBJGkc3IUtJc
    o2js8chIa93m85vb_9UyDiPIBwzC_10ZkZYcD9RdRtGTJDNq_ggXVs>
X-ME-Received: <xmr:HPSgagJ4SqH-YwspoGeAfUOxxTtANr9lx38UrlUj2GWJ7JBSX9W6c6mbdbwYL6_FxtM2ig>
X-ME-Proxy-Cause: dmFkZTFsTjzmcP91mI+yZHqymkIiMDnXcie6o10o+bFBIZG2mxBwSL7XCpGvBvg2+i0y1M
    B8+JicRvagy4EMGt40FU0ZHKgsGVF4iOp73Dp6Cb0RqDHLxrCWF/q7v72e1O8LCGF7Lr7u
    kc1kcFiiYxqna2qLNVZmBJsMP6Fu7RXx45yaY+ifMcZvMFVC92lUtbAkRYj9rrdHlazj/g
    3oqXrerCXV9De0iOL5KkhDk6BpNTgaaR93gYPySNgRCQROxwDfHMGDu3/rsZ4Qqc9N3Fz/
    bRfY0Im06+ovRZZv8D4XUAAjxtLg5Dm43Vj9gP50pwh/Q/h7ExGG7+deBNvEdMGSzbhiSH
    ytXNGiaGlMA1XIWQj1R28N6x/GaaNtdvSvJHn6rkUwlDuKGc4/DdAZuefBoxauZO5ggYxs
    b3leY2Ww8ZUekQcKdQ7kRJplYxxnD9baI/5MWc+3Fc37u0Bu0kdgpbyPgh4VYzYjIbeovK
    b//Dr4oAWfPDHQ8Jv4R6QZh70Rv0eY+oAwYCAJ8D3YtrM/cF/uwRPBQdqQ4wBvM6fMZpGk
    Z9wE6qoF5cMpW+8F3NAGRlmrGvpbhtNkDJds65x7nU4vJmgxf0yP93Nw1vj1pb05mag3QY
    pQ6AxkBy7CyBscgDkbCF30164g7+01BsuJyIcluxSl1inVpsz3q8UyT4QAGQ
X-ME-Proxy: <xmx:HPSgan5oKdvkoqbkjAxAaG6j9qBz04M8yDsXfQJZxBvqtD2rsFC0Kw>
    <xmx:HPSgajwtDIdxto5MRWKD2xy_fPtQDuIIca3XEUmILKfsMBWYLUWxLg>
    <xmx:HPSgarartDaaxXjK9AD5CCS6v4FwuG8XgQHaAH_goIp7B0phXzqlfQ>
    <xmx:HPSgalSqzSogwIb73luFd6hXt_LWcOiak3e3FarmakafmEIlb5z0rw>
    <xmx:HPSgaj7S-sLriuzsKzHgL6hUnVrTz8ZKb3o_30cGiFDDXUJjed-OH6my>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:52:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b708a73b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:52:26 +0000 (UTC)
Date: Wed, 9 Sep 2026 07:52:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/13] submodule-config: stop registering submodule
 sources
Message-ID: <aqD0F795VKJ6jUFd@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-5-c6ca12fdea4d@pks.im>
 <ap2wj0vK0-VUvaW5@denethor>
 <ap5sqR6RBamJjEeP@pks.im>
 <aqCTAXB3AbGW8Dt8@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqCTAXB3AbGW8Dt8@denethor>

On Tue, Sep 08, 2026 at 06:04:54PM -0500, Justin Tobler wrote:
> On 26/09/07 09:50AM, Patrick Steinhardt wrote:
> > On Sun, Sep 06, 2026 at 01:38:15PM -0500, Justin Tobler wrote:
> > > On 26/09/02 03:34PM, Patrick Steinhardt wrote:
> > > > When reading the ".gitmodules" file from a blob in a repository other
> > > > than `the_repository`, we register the repository's object database as
> > > > an in-memory source of `the_repository`'s object database. This call has
> > > > its origins in d9b8b8f896 (submodule-config.c: use repo_get_oid for
> > > > reading .gitmodules, 2019-04-16): back then, `config_with_options()` was
> > > > not able to read a blob from an arbitrary repository, but would always
> > > > read it via `the_repository`. So even though the blob could be resolved
> > > > in the submodule repository via `repo_get_oid()`, the submodule's object
> > > > database had to be registered as an in-memory source of `the_repository`
> > > > so that the subsequent object read was able to find the blob at all.
> > > 
> > > Ok, so IIUC the problem was that a gitmodule blob from a repository that
> > > is not "the_repository" would fail to be read by `config_with_options()`
> > > because it would only read objects from "the_repository". The workaround
> > > was to add the other repositories as another source to ensure the
> > > gitmodule blob could be read. I had to reread the commit message a
> > > couple of times to follow, but I think it makes sense now.
> > 
> > Yes. Do you think I should rewrite the commit message to make it a bit
> > less dense? Otherwise I'll leave it as-is for now.
> 
> It is a little dense. I think it is a bit confusing which "repository"
> we are talking about in the first paragraph. I think:
> 
>   ...we register _the_ repository's object database... 
> 
> is a bit ambiguous since "the repository" is actually a repository that
> is _not_ `the_repository`. At least for me, I was getting a bit tripped
> up. XD

How about we say "we register _that_ repository's object database"
instead then? I've queued that change locally, but I'll refrain from
sending a new version only to swap out that one word.

Thanks!

Patrick
