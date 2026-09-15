Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E23D5C3C
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483312; cv=none; b=m+MvC6EyPmJ5gVoZScCuIBgdWh1MxVonMp5yHa5di5tYMWbGB9eSiJNsHTm2iBOHd9plQkk1YMuWLzN58tYDSgclTJ+fJnsIHPlY3nXc2UJKQAW1DgYI3hnuBsw67ZvUvp6CAqqpAFcQ+3RTKxe0cp/3NjMzbnf/f3u+8Rg9EOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483312; c=relaxed/simple;
	bh=tiiAPqXxrCXC+z+z6skWc5qAFs/XiwStFr+ZiK/elIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPdUkSOH/qC7eJQo1482n+y1uqzSTk0+13pF6K6FYuJPxuTqfLeMUsYlOApo0I4IHR9xqwzpujmdSbBUjB1ltSKMoHnu+yoULTn9qjqx1qzmMB0r3Fc3Y13+34FKTCbpwhY8lgNe2pjFpDZjz+E4NOcEp06pevF13qP7GA5yVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rGPTcwJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=luOTq0g8; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rGPTcwJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="luOTq0g8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B65A7A027D;
	Tue, 15 Sep 2026 10:41:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 15 Sep 2026 10:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789483309; x=1789569709; bh=8BIYc8FmzP
	F8qJ81EtigTcPT5u+Sx+4NBeB0GVY5WQg=; b=rGPTcwJzuTYvZhddPozJ9Siutq
	7cj/ocLu2luDtkCw0t6ufzaGDzU5umW6zSGfurcxK4fI8sERUvUcN/wRYqkvz9n7
	1sLoTlHllu3CQwoD0MMnzr6AyKDiv55azDiJOl1D9PCrgKQ0lRqcjYcD6oTDo6bw
	5lTqtlqLpL2JFvuviZSOuUog9wtgnfNNe64MsjEriIT6/3NZbC4Q8n/MrIMXHDMj
	tQ9hQu/0FNnmLS9/0NZieV+Wr/KGjbiCGE61ik6rqdymg7RVaWgyLWlUjfEMVIgU
	JnXbMNZG2K+HBlXKEQi+67Xb3d2WcDo2m/0Jh9u60XJ+9eqilZ2moFeY0A0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789483309; x=1789569709; bh=8BIYc8FmzPF8qJ81EtigTcPT5u+Sx+4NBeB
	0GVY5WQg=; b=luOTq0g8AJNH4r0Ox3nUnLMxES7Bz7pGSiONZ00fA7VpqHVZxLS
	y6WgCC14+rD4xEDjHszYB78SMMVoncZn2vkznsidQAeOnmUzLp5JXWxJlWR9ES9x
	IwzhreQKtkqoWMBA62FRK1SkLj3uBSn2mhB007nN6Fz11K0QTtqucrqRXtdyM+em
	CNd0fZB6ftGgn7KjK5ZgIY+U8HEbcDnCl7gh0ljptld1/3xhWBfT//BdFiuQtDDs
	FaZBjj9au6mi7DvooguSkJFCW0xbhG5I45T9urSETW7SaIHr0e2Xcghv6ZNklR/N
	6OpQyxZ1Uf+nWJ4cZF7glMrbNTpE01AISVw==
X-ME-Sender: <xms:LVmpajDECpWjv4diPe1aBgVlyfcuXTUG_wmy0pPDhlnmWOsOnQvMWw>
    <xme:LVmpagaPRbklsTVulXqI-xcFu_NXskErwhyFjsj_rl3x9xGLfJl1WQV5zr5uYyxgU
    NnybgKGarAwm2H4D-9BJDr5rke9LIMVD9vUj33xWYyvXGJ7gxI4xfbL>
X-ME-Received: <xmr:LVmpam7ctxH8IJHU8Kact1ZSNi48tP9Q8Lkq1iwwa552Gvwm3fNLSaDfJCEEJv_Oq6BTJ6CASt-cJwF1kDZYfu0NINtlslGEVd2w>
X-ME-Proxy-Cause: dmFkZTETOS2kkBTbihxun4iNBHJGg7aUPlNlVR4LNhTGw6GS0os44xPyd3RX17hFEf2eds
    k7v0SfWGGE58WaVJT/0doMwIVgWOkvwssTaLi9shNqfj9GSF1cLeA3mni49gYiFvl7S3zj
    8A9+XbFWOoBft35Dn77y+NjobmZUM7Cc1gcny1/KN0UIDMe8Gm/4kI/Cf+FtuMs/V1rWVv
    +1Ze+HTGQviluhcYNaLc17ZWfmE5RAsQR6Z3C+QGbi2KndqzGsWqNiP5e/6EJ+mu8u25Bm
    WNkdk+KXDefYQGeBIdAM/x8+/NRkXIO2nOdNJmXOBpE2ZpqVjhYzediQ9UtYzJ9qypeWSh
    5r9NmqFxu25J9BsOuE4AoNkPP5NY1pxG6LcpTWMaDu0LT1txbwos1ua2CGk1E0KC0PmIjo
    bzWcduWijySxj+CWAMKeyXsfMGk9FadwqT1CSWdAyg1ElBO/pwPUOC+4MdaJdSDbEcr/XI
    kGcl5ri0CyuMDFPaGRkP42Ch6BiC/MXmoH9h1neZ4Y2y/CmDwOFo7qeWYK/mX8r3LA8qUm
    h10920rDNKLkmynavEQvrkG+InfrEiUd2wpiu74DHf4Jtta/pABKsGQR6mmcWXtLWUfby1
    US+jlaIJjFHUV+0tl32bD5LRYu8URLcvFxh7VMXDbCaO2XpuiRUE1ir16rfQ
X-ME-Proxy: <xmx:LVmpahbZXNpRrMVvigVxu8LroDAqEOhtY1sQq4MtK2wSZ7gkJYLRzw>
    <xmx:LVmpaljv781t7FdlxWe6onucQyxYX6GxS5hZW55Ic0vpGA2DP0F5Ww>
    <xmx:LVmpai9STjkTYLgxHFvx4EQzNolewTY7JHb9h8DvX-aNhBOSE7jh2A>
    <xmx:LVmpagqAvJ92wwOYR-rOhI2ZBCcJs_NEWkEBJ7lAJGfJ64AvbPifTw>
    <xmx:LVmpasoyx2Xml2HqPmY8Fw7RAJsB2bfCkf3QF4mNQnV88rj0_EdwpLYg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 10:41:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 01/13] parse-options: allow for hidden aliases
In-Reply-To: <c5266fff-8247-48d2-9679-3fc1f649cf34@gmail.com> (Kaartic
	Sivaraam's message of "Tue, 15 Sep 2026 15:02:21 +0530")
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
	<20260909-b4-pks-unify-ref-storage-format-v3-1-ca041fb40ad8@pks.im>
	<CAOLa=ZSh_H9tjnjEsRrmGXm1Ht+3a=gRaGibO6BKZvvkEabesQ@mail.gmail.com>
	<c5266fff-8247-48d2-9679-3fc1f649cf34@gmail.com>
Date: Tue, 15 Sep 2026 07:41:47 -0700
Message-ID: <xmqq1pau37bo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> Perhaps it doesn't make sense to add flags to OPT_ALIAS() at all?
>> ...
>
> Just some food for thought. There are a couple of other instances where 
> we are currently using OPT_ALIAS to represent the deprecated variant of 
> an option. They are:
>
>    1. `--recursive` is a deprecated alias of  `--recurse-submodule` in
>       `git clone`
>
>       cf. bb62e0a99f (clone: teach --recurse-submodules to optionally
>       take a pathspec, 2017-03-17) and 5c387428f1 (parse-options: don't
>       emit "ambiguous option" for aliases, 2019-04-29)
>
>    2.  `--negotiation-tip` is a deprecated alias of
>        `--negotiation-restrict` in `git fetch`
>
>        cf. 1a445fc60b (fetch: add --negotiation-restrict option,
>        2026-05-19)
>
>        Note: The documentation clarifies that --negotiation-restrict is
>        the preferred variant but does not mention about deprecation.
>
> Since they are not hidden, the deprecated variants still show up in the 
> help output of those commands. So, we appear to be doing fine with a 
> public alias so far. So, may be it is not a big deal if we expose the 
> deprecated option publicly?

The OPT_HIDDEN bit for an option indeed is a mechanism for
deprecation and it is not limited to alias.

When an option has a clearly better alternative, we would want to
eventually remove the old one and have everybody use the new one.
For that to happen, we need to let people know that the old thing is
on its way out, and "git cmd -h" is a good place to do so.  We do
not want to use OPT_HIDDEN in earlier half of the deprecation.
After sufficient time passes, there will be a lot of new users who
are equally unfamiliar with old and new options.  Telling them about
old way that is on its way out does not help them at all.  So at
some point, we want to start using OPT_HIDDEN for such options.

When nobody uses the old option, we can remove the entry from the
options[] array, or we can keep it and use it only to cause an error
message (i.e., "This option used to do something, but no longer. Do
not use it anymore").

If OPT_ALIAS() does not allow using OPT_HIDDEN, that is a bug in the
infrastructure.  It does not have to block a new topic that uses
OPT_ALIAS(), but we can leave a #leftoverbit mark to invite
interested parties to work on fixing it.

Thanks.
