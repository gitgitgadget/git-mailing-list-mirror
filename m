Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7723C8AE
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868926; cv=none; b=ZmfHbjh6s2W+U71SvW8OUNKaSuKBxlfgqlRkuqD0/y58AEIr8oD0Z30mZ0TzL3tr+4i92YL4qHqsfjBFVw4lm38QtEd8LpjWK4r2+jlzHGJTx3pn/2nrjbN02Sl00F97SDHueLlAkgHMK8RDK6WdaSgrUHM4b3mIbLA8Eth9U9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868926; c=relaxed/simple;
	bh=RuiXifb3epaQwRKcJaEc4vjLezn9zwfanTQaffm7eYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KHhcgVkvxQY+yzOku1uEZdcq9SpGhyUSSy6QzcfvgK5z8k/WmU/R5QFGW8BM1QLAoWe7drVPN8PDjiDF1Sa/G9iL0Qxd2J7iCXaJRnYgNC6doifocbvoXB9d//YJ3Jz4vSYinPN1MLJJOxlzsuZTBk+vy4P2LfI0ON02BlUuYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ka4HUSy9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARbkArOv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ka4HUSy9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARbkArOv"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AA6E713803F7;
	Wed, 21 May 2025 19:08:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 19:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747868922; x=1747955322; bh=BFieEgWUee
	d+cFwrRsiSQijBNALWCVcndsLJHLwsYkg=; b=ka4HUSy9hFA7T5bpSRB6cFW7jn
	qaGUjlQNhQeKsHpsuMM4tgcpnZ8YdLAzK1mLtgwWiegop7N7syp19NC14VIaa7cK
	INtDBeMmFA/6MsDKuWzThMqu8SRQ1XhwzSMxwYpxcxBsBKiy0b1o4UYxzZhy6eyC
	I072T4TGZUn5050l0jO9sX/dMeHmDeZakB2f7kT9Q6vPu7a38B2ZPhCLNM6Xf0mK
	+oJ7FJZ7hZnCG4P4UDT/5kDdCOoOshQfolXGBwkQIrU1kVwJ1E8Lff4TjKyJGSim
	lfdN1tbaDsm6S00vXoqgUGX8gHFmWBBUHOhO2mWPG8F20bQMDjTtpZdp6S9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747868922; x=1747955322; bh=BFieEgWUeed+cFwrRsiSQijBNALWCVcndsL
	JHLwsYkg=; b=ARbkArOvkSg4QQjgm7UM5dVa31Jx4w9JQh84Hg5ucn2Mw+EcXCP
	JGmz/Emt7DysDfAr2TZ87oy7Ab/qR9VzFfE6H9mjhQbvRNPayB1+uPjehLUSl9BA
	9Zryzq0ixtd6/OTr5vVMx3JyOmbD47UKpraTZiZrPBpx0nGccgccsDvAVdVrNM3j
	hYhIb7ma9CngtRPpI9g4e7c5sfybLL4cSkI+Z9Av4dz42f4JixaCxgYiXY8lhUtW
	CM/O7ow9ZN2jihloAHP7TQjeTkN1fn3O1bYxCJR6WOc7p3uZMUrK7LcJIVdEqDpl
	W3gYN0Oi0uZ0AdlhK0xSAJI+Nm2SGDtfbxQ==
X-ME-Sender: <xms:-lwuaM5_QnEFHpu6Oe4sLhyhRm3jVqLXvkIIJPSaMQVAtw7873nGdg>
    <xme:-lwuaN6aAbbmuHRnmkGI8RsK9VK_qdfFGSAKV5p-FA_oT8NcvgjbK8W8D5ORJ3FZr
    9OZnfQUIrnoY0Yw2A>
X-ME-Received: <xmr:-lwuaLe82i9uz29GQCZJl_0Q5Hxxoz4XtXb6LFQ_FgE9XEkMoiubMGumafhmrpp5M-W7DR0tpPfsA8323Vh_AW4SUTgPsE0-oSOoOOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegfeeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepohgtrghrnhgvihhrohdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-lwuaBIwRtXdqbvsbnUSktDSQa5RFdvJqwQ8kqW4h7yBMGnNkFq_FA>
    <xmx:-lwuaAJo7gbILcviokit-GAcXfjpmi8LTNODnjhc8kCVhYkwBfSxsg>
    <xmx:-lwuaCyxskPe_tbZbnzEtniJHKxGkuntwVcjWczTHxulD-R3OSZPHQ>
    <xmx:-lwuaEKJcE17Rm3x6Heb2cncB_RWdv6dhS6F1EzBnNWOwSJMilIGUw>
    <xmx:-lwuaFqnoGvPAX1iAN2lWBnqjr3ZsXb7tm0P-Fm7lYuzkHdwqEJQSJj0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 19:08:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Octavio Carneiro <ocarneiro1@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  newren@gmail.com
Subject: Re: [Newcomer][PATCH] graph.c: change graph_line->width type to int
 to remove sign-compare warning
In-Reply-To: <20250521191352.30849-1-ocarneiro1@gmail.com> (Octavio Carneiro's
	message of "Wed, 21 May 2025 16:13:52 -0300")
References: <20250521191352.30849-1-ocarneiro1@gmail.com>
Date: Wed, 21 May 2025 16:08:40 -0700
Message-ID: <xmqqtt5d7e9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Octavio Carneiro <ocarneiro1@gmail.com> writes:

> A comparison between graph_line->width (of type size_t) and git_graph->width (of type int) causes -Wsign-compare to complain.
>
> Looking at the git_graph struct definition, its size variables are int-typed.
>
> Therefore, I changed the type of graph_line->width to also be a int, thus removing the warning trigger.

An obvious question after reading the above explanation is if it
also would be a valid solution to change the type of git_graph.width
to match the type of graph_line.width instead.  And if so, what was
the reason why you chose to match their types in this direction?

    Side note: I personally prefer, when not dealing with things
    whose size MUST be expressed with size_t, to use platform
    natural "int" to count them, and on-display width of "git log
    --graph" output is certainly something that should not exceed
    thousands for sane people, so I am OK with using "int" myself,
    but if there are obvious two choices and a commit chose one, we
    want to see the reasoning behind the choice explained in the
    proposed commit log message.

By the way, these lines are overly long.  We aim to limit our (physical) line
length to around 70 chars or so by line wrapping.

> diff --git a/graph.c b/graph.c
> index 26f6fbf000..cb2221700e 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -1,5 +1,3 @@
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>  #include "git-compat-util.h"
>  #include "gettext.h"
>  #include "config.h"
> @@ -115,7 +113,7 @@ static const char *column_get_color_code(unsigned short color)
>  
>  struct graph_line {
>  	struct strbuf *buf;
> -	size_t width;
> +	int width;
>  };

When functions like graph_line_addstr() widens the line width, it
does things like

	line->width += strlen(s);

which could make line->width eventually overflow no matter whether
its type is "int" or "size_t".  Making .width that used to be
"size_t" into "int" may make it easier (simply because "int" is
often much narrower than "size_t") to happen, but your change does
not make the code worse than the original.

Since I anticipate some senior developers advocate for using
"size_t" uniformly (instead of the platform natural "int"), I'll let
them speak up before touching this patch.

Thanks.


P.S.  

A totally unrelated tangent.

I notice that graph->width and line->width code assumes that a
single byte is always one display column wide.  It might be an
intersting GSoC or Outreachy project to use Unicode graphics instead
of limiting us to ASCII art to draw these graph.

