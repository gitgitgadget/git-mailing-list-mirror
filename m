Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A7442FDF
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094616; cv=none; b=Qz5u4KMhQFEJY3hFNUoD982zHhGu3ViHdZlH2yJYFeuBOe4IYr4dyRVGV9e50nyXz8oCVFePSExGXzlZtyoh6QF97nktVqCANzFASu16uwHJUJZTC7Sa4IIKCgrQoo6fKRLQ6ft6bIysOpe0jlKIRcVDgKMA9hnPy+pCnLKEJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094616; c=relaxed/simple;
	bh=p6yxV1ZwF7a6FNrRk+9awG1qd+s6vWGirVJaoF7KuxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tB1COt5wQXnOqp2xu8ekugyHISK6hDP3vmkNlW5e9v+93w260l+rv/NoMhAphIQkvMrN9RVsosdJu+pYnnYQBpoUgcpCv3oDwDs0G4AKY8LW0jAqlsL9s/7SVESk+aQ9XaS7kl1U/+UE9szMWal5R/+gki+hyoyqxfn6x8fve2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C2948RcX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIYugLdr; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C2948RcX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIYugLdr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB5C07A010C
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 16:03:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 16:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792094614; x=1792181014; bh=RU0Jgby48x
	XnTXhKhy/b4iveEj9cZEB4/B5YNtiMwGY=; b=C2948RcXtCfMw0JHy4rEmo2qUR
	tfAF5T1t8rZQuN6xThx60MtfuzgsuFJ1PfQiHkICaqS5CTpYj7TZN1ujk8LjwPAN
	sD+vI2L16x4RkfrH4eK4Ao0dyH8EkM31mu0nzImwz2+KxRgNDUPV3Ih5pOlJtXjb
	lpq1zphYcYrLavv0pAtaZD2hHaRJNwg3VU6pNsohq7iF2wk3MIBK1OhM8oeVEjyo
	nOkCSDjKktFFUy8WbHxcLk2iXJPdhzfvO3kqRqZfqzHz9osAO71Es9U3g1O4NQ2g
	oXQYwB8bSvA26gdLfgAkhroIa6cQoYGLk7lGESUqIh8T7LHOBt1+v1RqjRWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792094614; x=1792181014; bh=RU0Jgby48xXnTXhKhy/b4iveEj9cZEB4/B5
	YNtiMwGY=; b=eIYugLdro7o1Z2CdClAUtnQOcUWGdAccziCqN+LTu9sW82wM9IC
	9XWVzINQXm9y4Tj0KL3G7OqJ7J94CJ1opXz4KsVtfgIZ6GHHHUrMLQW6XHkKMGx7
	LhFw3+jZent0xJankXlY8xDGfHYujoJoXcGPgWyGlYVYKnK6fG6Q2yYGqKkaRJKU
	yZyaAOyi4UPAhJFDmnU2IoVDziG3fFSjK4mBcUyioSrh3ddXwYe7q46wBJ+duEp6
	KPfFBKpg03kfwwJBZct1FXso1uZrO9tX3r92nnjDI/guUsZdy9QDreQXGp/QYzZz
	CEvqv8ZrkAjlr0LM/RkuhwAfL++68qlujgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792094614; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jB2TvP+HHlBr95EpxXS4C7b/ogBQ9C3olbZcVmqVDj9DQXd
	Dy1lF5+N4HcIK2KQ413tYCI+MQEL+Fhr05tjpJ4KISrcqGVQfz/dvQhe18Bg/V60
	fVwn80GovBS5lvh/o0sLI3cjEWa68Qtk5EWcSwW4D9+oYXKgQPSC7E7dPgGlLK/h
	voz7+lKQiqYgWPLM+GKnZ9/nZuBqAhDqG2cD+m5UCXq2fjSD+NFUuJ7IwiRMMLrs
	P/KvyvcARCpQaD4ssEUMv7ETM0/jpBcx9HTRBkcXJwq6sSrBYhkJMqDiFH7T4TVS
	zwWmwGXUt2ESWqGQTl45i/2DLpkxS7MrL7Z7/nA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:V2Gz5yDy4jizhXJX0emZxhpcgPLaSCbmVx7iaUbrDxs=:p6yxV1ZwF7a6FNrRk+9awG1qd+s6vWGirVJaoF7KuxU=;
X-ME-Sender: <xms:ljHRatm7PhdKyjoY93ldOhXXfC_tuOSkMtjvVet33K_LKo8HesOYYA>
    <xme:ljHRasgy-JMlfgKlN6trSOPpFRPW3ea6n8h8CzsLLg8r6ovYS_JFIKh89siWzP14n
    QVi9-N32lG8A5OnMRdzcpNDryCpozbGU7fUDcwmRx3qy3GuCqTKkC4>
X-ME-Received: <xmr:ljHRatepcIfLmpnNizNfBIPRypO50CrALkXYCvT6uP_TLpt3Y7KO7UCLHp39YUz3Cv-tmRBHQgc8p_CO_KQG7lpzoGTOX_agb3NM>
X-ME-Proxy-Cause: dmFkZTGD7sGOPzBnoaphHo3lSeqoSSG4cyYMWsEUadlIyHknkvCmwAdeayE+5C3ZzxUckD
    aFHQIw4o8sb/tdrRvHbY8X8weHGbij7kSbjvqWEWoxAVTraDoNdwk0rSFPRNQIatlvJrgA
    erXeYEezw5ouilqPWGS0HwEiTxjMsENKeTiRVl/R9kuJTHyGa82nj9LX1esRMm5JoGzZjg
    6rR8qqzGkaUwcUON36rb0fyi2zixwoL4aRDvY/+AzitHQ7PibmZ2cH9DrVwYqzs/KDiRyk
    YfWbIWwH5weTE/QtCZVq4bPa04DePKFW6RCEa2OdA3epnRLy79Gy70EaFn/Bs6mqIwWjX2
    06rvATxvLRg3YXCYjjfdmoZSqHwH6/wCLmeRKuasKGzu25cPPmges2RLv98qRCINfe1tF1
    lGyA5Gnl5zhz5Nj1h0860zhYHRZ9JeAKoWOV8ZgEEl/+tJ6SREgZ7kNxfbE1emt86W2Xfx
    /9gc54cY28saXDhx7/w2GEY5lx5aA6IMzKQGVHnIYTaSW72ID0u2cZ93mRvE2efqhNlyjq
    k+SCJ1Q50vbyN2PmfAVU2eU7AmwfTn47n2sutvG3yYK3GjIhbTyYJVIbY7LUkoRfFL9aIA
    KQQBTVTgYnD5Q7qsZlfhdM9Dm4qAwMx/YOyXD4msFzgzYWbXPZ8A6vFh3+6w
X-ME-Proxy: <xmx:ljHRakjqsMsdlgnKbOt_ZKcG4MPso_v9SGeWC4UnNmmjvbtJFaPbrg>
    <xmx:ljHRatw_pn0WyOk4PcJJyuVVXXUk-eydJ87ofddXtvIMLsWeoewP1g>
    <xmx:ljHRaoP3KBOb0-KdRxHqkBrmKCoYYN7dhXD10O4tM7RUFFdSrEadNQ>
    <xmx:ljHRamWLnctov7lUAZPR6csluc---jGJc6mhjABLPRRb9xomnOA0NA>
    <xmx:ljHRaiJ3EmYWUVXblIl1Vql45Dz7xBh0mxqyNnc5ISoB6aIvwM8wDHQo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 16:03:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Rong Bao <rong.bao@csmantle.top>
Cc: git@vger.kernel.org,  Mingcong Bai <jeffbai@aosc.io>,  Rong Bao
 <baorong2005@126.com>,  Tamino Bauknecht <dev@tb6.eu>
Subject: Re: [PATCH] fetch: fix --depth= and --unshallow for multi-remote
 fetches
In-Reply-To: <20261013144441.1632978-1-rong.bao@csmantle.top> (Rong Bao's
	message of "Tue, 13 Oct 2026 22:44:39 +0800")
References: <20261013144441.1632978-1-rong.bao@csmantle.top>
Date: Thu, 15 Oct 2026 13:03:32 -0700
Message-ID: <xmqq1p9qn33f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rong Bao <rong.bao@csmantle.top> writes:

> When running `git fetch --all --depth=<SOME-DEPTH>` or `git fetch --all
> --unshallow` with Git 2.56.0, the fetch isn't really deepened:
> ...
>
> This is because the parent process doesn't pass the --depth= flag to the
> fetcher subprocess.
> ...
>
> Fix this by passing it when specified or implied by --unshallow. After
> fixing, both flags would work on shallow trees in conjunction with
> --all, as demonstrated below:

The above observes that "--depth=" given to the outer "fetch --all"
is not propagated down to subfetches.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2decc6cfdb8ae86b8b1e92caa85f4961ffc47ff..a110a2dcf09c7e6764eb232bff73286753b27009 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2247,6 +2247,8 @@ static void add_options_to_argv(struct strvec *argv,

This function is used to prepare a command line to run a single
fetch in a subprocess for 'fetch --all', and also to fetch
submodules when '--recurse-submodules' is in effect.  Does the
latter case share the same problem that '--depth=<N>' is not
propagated down?  Should the depth of submodules be controlled
independently by not passing '--depth=<N>' down in the first place,
in which case, this patch may be a regression for users who depend
on the behavior?

>  		strvec_push(argv, "--tags");
>  	else if (tags == TAGS_UNSET)
>  		strvec_push(argv, "--no-tags");
> +	if (deepen)
> +		strvec_pushf(argv, "--depth=%s", depth);

The 'deepen' variable checked here is set to true when any of
the '--depth=<N>', '--deepen-since=<TIME>', or
'--shallow-exclude=<REF>' were used.  If the outer
'fetch --all' was told to deepen with '--deepen-since=<TIME>',
without using '--depth=<N>', what do we have in the variable
'depth' at this point?  NULL?

In other words, shouldn't this be written in a more obvious,
simple, and straightforward way as three separate additions,
e.g.,

	if (depth)
		strvec_pushf(argv, "--depth=%s", depth);
	if (deepen_since)
		strvec_pushf(argv, "--shallow-since=%s", deepen_since);
	if (deepen_not.nr) {
		struct string_list_item *it;
		for_each_string_list_item(it, &deepen_not) {
                	strvec_pushf(argv, "--shallow-since=%s", it->string);
		}
	}

Propagating 'shallow-exclude' would probably not be a good
idea if this helper function is called within the context of
recursing into submodules, as their history and refs have no
connection to the history of the top-level project.  Please do
not blindly copy and paste the above to an updated patch.

