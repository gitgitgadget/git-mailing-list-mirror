Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC7483BFF
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848547; cv=none; b=FZGrwaN4oSXiWLm0jzhYl7/yNKMMphxAeRSVNJI5V2KgBVrNsJbLiKmqDnCexrL4fKPVjHNmaFkiPp2gwf6XP+PJgF1qEMQq9MWj63/9QKAbr6cwPBJahx29wI5EV005o9mni3K0sqwwoqars6VszVLbC9KRZDry8Ncl6EC3C/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848547; c=relaxed/simple;
	bh=xlg9jN54RcGqaYi/02NZC7x7ZX6V0aBaSmBG8MKnknI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U7niGjeNaV+JC4mjyWF+aSXfvhHzf4p1eZ1SNSi38MQzTB4tZZuCZ9BvI+seKxpeA/bei8pRCXPjovgrjsOBvKFdF7f58/7M3/sbqK1cxbDvFdIUUff9uW1byFXL06ZnE74FAD0HUflBRnLaYnGlga/Mv8JtNw4+6lXCla1NplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gI7Syj3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WAp4g6ED; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gI7Syj3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAp4g6ED"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72DEA1400166;
	Thu, 27 Aug 2026 12:35:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 27 Aug 2026 12:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787848544; x=1787934944; bh=czsfuOZWbe
	nRAwIW0euVStYaRp2rYzEiXIbeb5iLIsI=; b=gI7Syj3go2VgSBFDaLkmv3U0oN
	vvYGsPiSFdJDcsysqtkC8stO3bbmYtTMqWrpCpcOfFMCpCk7PouJta26N3f1yHap
	JiO7XAez+xo9fUjFAm3Mytm7cxIVV/sZylGzyTtZGeOD18KkY3aFtoq/F1rGNiVQ
	ejnOFigTH7uSNxdYsEdc1cJl0/KiIEI+Kvp3sLUyOGAdXXiVDLEgi/wadJltyKEz
	IXknQuUvAyrTrDoybARy3pGC56pLR9ZS2FoNKON6ijW1PAl/paxuSe1g0fLR19xs
	cl8jj0uSrdLgByceYyTVEAyWjPYT6kRsi8sygp2CaOVVA+UTIdM5mWFxJaXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787848544; x=1787934944; bh=czsfuOZWbenRAwIW0euVStYaRp2rYzEiXIb
	eb5iLIsI=; b=WAp4g6EDA3ZZwr3bxp+lFiGhWFCuaTzh5pt4wUgHq646s6hgpSI
	soQCpIjNtIwEeNxdJ6sakuh6bLrubI69eEbXkiQTniKVWcI1DRp6bGVDjacXTCoM
	5cY1jeRbgyy0y0C2Yn7giMPyujuuwz62MS4qSZF0fWOzc1YgoZrZ+O3nbDNwnOLc
	b0iOWm0HWH45uR6nrhZdiUzThJeRrLA5yawX8YAIyi2zLH3c1p/czpOTNp5Jtk9u
	zt6s4MhUF/nQKQajP7dEBgDfkptERcV0PkUiGpnjvlx6TgFrqCcYH2IPXjP8IksK
	pAW3h+MD+w7yyulQlwk5kD3YjupQ+8cyqRQ==
X-ME-Sender: <xms:YGeQat-f9Oad4QdCYSzz3MNpWupc-Rk82G8kgrUV2QOqIpFI_HkOaw>
    <xme:YGeQaolSi_xjBukyNICBTxtu81bp0W8t6pXOAPJ2OryoEV1qOyWgkYfh0cIUydXJg
    e_aAdwg0nEN-TN3IOSdrqArp-F5LkvhPSWhq27p6fTvTyu1YoVt8To>
X-ME-Received: <xmr:YGeQajXN1zqtGJTskJ4SyRhLQsq4ohflD9lbdkGU37z3HrtCagcGxX51e0dWKY_-8tJaluXDfP4FxwZ-bBr__BL4siihd8EF0A>
X-ME-Proxy-Cause: dmFkZTE3x4azP1ix13LDWN7eDS/V9SoCDL1P8W7bP5/eBR+aSxyLGnDjN9ipRIkKn/tijV
    +/DNTb6NfAa+mRWXT5efDA5sXiTHHfdhrGf3ZJAqtb6ugQ0pw8ZI4UaEtdexrYqNlaHJqz
    gDubW+CL3YyzuG3rk+4NxxADT2m4hqtVDaYQLQuAgfOdbdDm0z6HgJmNhHMIPl5XQN5uBj
    N2KjoSSTO06MsN3x2u/OlqMhNVseQQ6gvq39VbMemCAoKiWJ/7RsCMC1nfUdnR3z5vdBbX
    urrfNL/n1zE5clkbK37ejTRERqRwk7N8J8M6ZrVkx+yS4X8J5XdreDqAJyeXgFFxxFZAHc
    ZpweqglvMrBOutupCzt/gRmLDWi6tHtTtsDs0UWkUu/0Oga71ofYb7S4nikR5TOpqY026i
    swY96RtYXWxhLQFTuEs/1k3xem4KY5Z6hFqmt7FozuFCFc5RMFErbh0mb8kLX1VbmKs8oI
    8lpz/jzZrf4LMfouhUXxIqX5QBz49hHsReuXi1o9cBmxbFRUO+N2jdGKAz2Gv8DdegRBW/
    DBNhXWdT3Nor4vB4VRWM/r5oApSDWVBpI/QAiPSRKVF98gQAmQ4TcIQT13TnHwwgK0TEQk
    9Nz3gQezshO1WevdxGhGKd3Hxr6QLgrTiIDQOiXB3pyNK9VoaeECrweITJFA
X-ME-Proxy: <xmx:YGeQatEnvZg5d8Om02KUnGpsNhnn_9AbfphCCspdn1Ko1WExm1rIwg>
    <xmx:YGeQavd2ESLvAtvJeBfZdGfZJAUErKaYzqlBJ1W2bmxhwsD5qeIXBA>
    <xmx:YGeQauLqARSaUFbi4M2JVFykW2DdAhWyY_dzDht-aZJT1hjOofR7zA>
    <xmx:YGeQakFWaRjyvh8Yv8d2qmQSIY-9CJOlI-TDpjmbtWOkCOoJxQpS9g>
    <xmx:YGeQai1z5mkhWJyKJvPCqOipBy29b3tXPTISMaSpKGR0gf1J4Izrgdzn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 12:35:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] commit: reword the empty-commit rebase errors
In-Reply-To: <65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Thu, 27 Aug 2026
	01:02:12 +0000")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
	<65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 09:35:42 -0700
Message-ID: <xmqq5x0vbjxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> When a rebase applies a commit that becomes empty, it stops and asks the
> user to decide whether to keep it or drop it.  HEAD still points at the
> previously-applied commit at that point, so either amending or creating
> a partial commit is refused, with one of the following messages:
>
>     You are in the middle of a rebase -- cannot amend.
>     cannot do a partial commit during a rebase.
>
> Neither message hints that the real problem is a commit that became
> empty, and "during a rebase" is overly broad besides -- amending and
> partial commits are fine at an `edit` or `break` stop.  Reword both to
> describe the actual situation.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/commit.c              | 4 ++--
>  t/t3404-rebase-interactive.sh | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 28f6174503..0d908d72bb 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -521,7 +521,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  		else if (is_from_cherry_pick(whence))
>  			die(_("cannot do a partial commit during a cherry-pick."));
>  		else if (is_from_rebase(whence))
> -			die(_("cannot do a partial commit during a rebase."));
> +			die(_("cannot do a partial commit while resolving a commit that became empty."));

That is a mouthful.  It also is awkward to say "while resolving a commit".

More importantly, I am not sure if whence == FROM_REBASE_PICK at
this point in the code flow is a sufficient sign to tell that we
were not just in the middle of a rebase, not just a rebase stopped
with _some_ conflict, but the way the rebase stopped was because a
step in rebase resulted in a commit that is no-op relative to the
previous commit.  What makes us certain that the rebase-pick is
empty?

> @@ -1334,7 +1334,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		else if (is_from_cherry_pick(whence))
>  			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>  		else if (whence == FROM_REBASE_PICK)
> -			die(_("You are in the middle of a rebase -- cannot amend."));
> +			die(_("You are resolving a commit that became empty -- cannot amend."));
>  	}

Again "resolving a commit" sounds a bit awkward.  What makes us
certain that we aren't seeing an ordinary conflicted "pick" step but
the one that has become empty?  If "rebase -i" stopped for conflict
while applying one step, you edited away conflicts in the working
tree files, and instead of saying "rebase --continue" tried to run
"commit --amend" by mistake, we do want to stop, but wouldn't it
surprise us if the message to stop us said something about "became
empty"?

