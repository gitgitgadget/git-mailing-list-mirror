Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846D223DC6
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625805; cv=none; b=WMQ0gBEo0+ngg6NuGZC6uIz/tsJxsE7lG53GsGjdVZ0PJ1CqPiGTmAexd9JP0bDcMDPKoJ4f6q+zwPnSEvRLYgmcYbWzvM5Eo4EB2Ns4cGTaSk4HN1KRyDG16Tx7/WEqa3Znl3KsIPf+NwdJAx3zAmvdkw0rZznF9g/wefe/vo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625805; c=relaxed/simple;
	bh=mUGr1/wxvwz8Q3K6bculryA3DIThks2tHQ/WkXKGekk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ozsj73MPa/KXPS1AFBXSHRatfuH5Q5RD+kv7e+Ia7pan3WenrOP8Zc6DTrnkfTK/JsoE/AOVx8ChvZ6/xRXrz4Ch5ATX6hArMCLKA9gNrP8wOBh2jf6Fn9k+Pj7upaxPz2TN9WXzAn0gcyMq6QJzoIcrwYFB39LN1ME6wFdClCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YbJ1MHud; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O6/dr3jN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YbJ1MHud";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O6/dr3jN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 356511D000CB;
	Sat,  5 Sep 2026 12:29:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 05 Sep 2026 12:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788625794; x=1788712194; bh=ZJSb61dcC5
	U0q8tcgidKsLtdKK3VqAiuriQb+MfOVh8=; b=YbJ1MHudfgm5WlmI/6w1Fqpj+t
	FhzqpHFwqujaToX6aUetmSSN3WxwVg7sXx7loWH6mEK+QJB+i/3ZUQ1SrTkDZGXQ
	JFLrnTUoo5vWTwDMqHuTJmdpe/PZ7EonCn6Vnxx5Zkjc6gkD+Y/JVFdKoG7oGbC3
	8lDQBK/r0hmPUk/VFxoMueEhjR6dWcdJ1Rgu27J744TYb9PHW/iVqxj54/gCi+Fy
	V36Buc7RUsVA9BNeGIW15R6BG9CwPSgQh/aIwxZ9xVj1Y2NzuEq4hTo/aQyvGLJS
	iZcFzEMN9I3lmN7GI5fnvP1wapJVmisVV3FM49EszuefSD8vO1QN2o7rDgMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788625794; x=1788712194; bh=ZJSb61dcC5U0q8tcgidKsLtdKK3VqAiuriQ
	b+MfOVh8=; b=O6/dr3jNhZk/23tZqp8YdcpEkwbRBrW5o0r1GHC2FpgLoOGWvD+
	+6MOKBKcfgPt8AT5a49BEOXq2yZqPfmsTOas4L84zA2lCjQ6EdHd719fSc7WzMM/
	vTzVl6wd4+Dvr4tiSugHinz3msH/FeLLRiF8M3r5Hipq1y/stYW/9faSPYEQzb0l
	FtU/JgV98HKgQ7geBS88GTaxVPVcvpm0dOhKfhjIb4/Ilao7bg3TFA9eQX/ZPc5M
	XoWdvbtCvPR+rS+Crp3lSj1LUz4IWCBU0mCLiItX1N1zjrdEKL+AFu+xyzaYa1DB
	yjw2iEtlrFTPUuOhUEv/0ggfeTzJl/cbQ+g==
X-ME-Sender: <xms:gUOcaiwPO5F-8JIQ76kE5lVZ3NtcUCqgDHgHfR6ogIHt5ke4taVDKw>
    <xme:gUOcahgG1T6deX4-GeYj0531_LI53mbf8wcrWdbpDHeDlc74pQU1ZkbgJZV58205J
    EA10MVioybEhkrUD9GiXXV-Xy0WTu7Us7U9ZJeDg3SvzSatRpOVE4k>
X-ME-Received: <xmr:gUOcatyrF3tZuKWVcWxopcVptqr_CmxzTRZTrzfOH960b8l1K3dqsY56KhPcoo50HMQOWKwcM2MZcg6dnBJvJxFMAm8zu-Opglhw>
X-ME-Proxy-Cause: dmFkZTF6ByjzyVBERtOuSL9KKdmBXvQsDrIDSWH1/nbN1UhUZcLmev1tGb/nBx/9OPrgpF
    sYJT6wqknGOIUL1rgX18f81q/RezQsJ5Lan5GpvYyY3H7eb19SocbsbbcZpiw9TlH+8+k5
    ao9GbNBgZ9Gmqabq0ZQ58aPc3AH0bGyiQgza+ibFg4BdR0eA4L1sNdQdSv0wYcx4b1Rvp2
    3L26CZ5rAlsU8Ah+K4GtfnzoldnRhy2LIeDEh3QkzWLpJ8q/nQcaP2R7xJV73otkUzFt0q
    PAphPAeu+TMgYAbZeqE48WuT56nyO4nWK2yiSueXQc5LoU0fLv99p5LEQLO5i6WxNbTFB5
    CQP5UZI3u9lv2iu4hYMTgRBAPv3el3Y3q3OSUgqz9+mR6SZ0CMm3Rw5eWvtaAXpwEd38fg
    jHLwMDybyCRDcLDXMRIUeIbOWwPJj4hVzAGxqcli1S+3RhK64drXq2c7ZuiLrUiA0UI0M+
    VMTR8CGm6ClqbEPcCSMdfTerkYUKqFiJoSA2mMUj3IygofuDnOwfj2pV/y90GBBNEl/E8f
    /HVGNj5+MgKlY5sTjyfhFfji5IsF1Kbl+9cDSSg7nxm/YF+7kAwLU1IqEAERT3cs45JPUh
    7c3hrueE7VinXRSrmgUaFeAmVjqiVLZokXFL3W808maUKzglIENY2DwnDCXA
X-ME-Proxy: <xmx:gUOcakJQrU5UvV5JeU-OFK1w-oolsh7DRCLDcvvu7JqjQ9iP7cqWMw>
    <xmx:gkOcakT5T3lTOp8qnZpzHkvXl6he5PHa1koddiqQKh4WjPNGT-WcFA>
    <xmx:gkOcaspDg7HVoBFzq_ChLNbdrhVXxT66-BxSyez2IHlZA2xbGs6ifw>
    <xmx:gkOcapoZMpGkTnYnC8HEd_uOe0XqBPciCAa-Ws58lpawKVwghq2Zrg>
    <xmx:gkOcaqIIrUQxM4kd-Z7Kinvhg1jAJGxMO_hSY--yfbUtcEPBMYV3gS4c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 12:29:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc: cherry-pick: note --no-commit skips
 CHERRY_PICK_HEAD
In-Reply-To: <20260904124435.12865-1-f@lex.la> (Aleksei Sviridkin's message of
	"Fri, 4 Sep 2026 15:44:35 +0300")
References: <20260903125524.67889-1-f@lex.la>
	<20260904124435.12865-1-f@lex.la>
Date: Sat, 05 Sep 2026 09:29:51 -0700
Message-ID: <xmqqik4j64qo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksei Sviridkin <f@lex.la> writes:

> diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
> index 42b41923d5..24a28d4e65 100644
> --- a/Documentation/git-cherry-pick.adoc
> +++ b/Documentation/git-cherry-pick.adoc
> @@ -25,7 +25,8 @@ happens:
>  1. The current branch and `HEAD` pointer stay at the last commit
>     successfully made.
>  2. The `CHERRY_PICK_HEAD` ref is set to point at the commit that
> -   introduced the change that is difficult to apply.
> +   introduced the change that is difficult to apply, unless the
> +   `--no-commit` option was given.
>  3. Paths in which the change applied cleanly are updated both
>     in the index file and in your working tree.
>  4. For conflicting paths, the index file records up to three
> @@ -101,6 +102,11 @@ OPTIONS
>  +
>  This is useful when cherry-picking more than one commits'
>  effect to your index in a row.
> ++
> +This option does not record `CHERRY_PICK_HEAD`, so a plain `git commit`
> +afterwards records you, not the original author, as the author.  When a
> +single commit is picked this way, `git commit -c <commit>` keeps the
> +original authorship and log message.

While the added text does not say anything false, I am not sure if
the last sentence hits the mark.

Maybe we should hint that this is a deliberate design decision
behind the '--no-commit' option, perhaps in the description of that
option?

The reason 'cherry-pick --no-commit <commit>' does not record
<commit> in CHERRY_PICK_HEAD is that the command is meant to work as
a better version [*] of 'git show <commit> | git apply'.  The point
of the operation is that you can continue to futz with the resulting
modified working tree to build your own work, and in that context,
you do not want the original authorship information.

So "When a single commit is ...", while not false, misses the point.
After continuing to futz with the resulting modified working tree to
build your own work, which may include picking (with the same
'--no-commit' option) many more commits or writing your own code, you
may still want to borrow a large part of the commit message from a
commit, and 'git commit -c <borrowed-commit>' would be the natural
thing to use.

But that advice belongs in the 'git commit' documentation, not the
'git cherry-pick' documentation.

Other than that, looking good.

Thanks.


[Footnote]
 * "better" because unlike patch application, it can use 3-way merge
   machinery to take the full file contents to wiggle the changes
   from a different context into the code that is currently checked
   out.
