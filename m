Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A372D8375
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157497; cv=none; b=P0cMz9EDJd7pHm9Oww7maLOXRqaBlwKKgiX64uOJzWRuAJSIKiVuW3bZcBNFuGaryH6sZ2CGHiIXoUcv/LlbwYfL5vQSbKm0L5qCz/7rgR3poPOjDDG3i+dGqUY/qY8I3tgIews4VKseCmaahPZYPlCXjlXlbBdwOA/ouxcfHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157497; c=relaxed/simple;
	bh=OSlwPiX31/MjyfazhqtamSXnmIDSn1b9yiGmhJDhLiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kNohjXEcUwuXJ31L17Wn6CQe4VQkLke4Aq6Zn2f+B3T8ZssZXFQoVgzYLYl94f4OOqveao1A7quLTOMW6E45NFnzhGiQ1JNEinkCUzGIVEknsiF9KkaQAr22BjKddXb+608CJcZNjQKk7dg2Os1LhZkkPhVTYumGhpCmMPFOjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HdwtSi8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qOaViB9B; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HdwtSi8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qOaViB9B"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BAD1EC011A;
	Wed, 22 Oct 2025 14:24:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 22 Oct 2025 14:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761157494; x=1761243894; bh=+duaajv0j4
	2PqnxLCkBl29B49GUkUYE1wpRDMPNwNQs=; b=HdwtSi8XhwHG9V4MtG9WriFgbf
	Ti6cKT6XvNADDzHw4CihaG1tNWoJeGrN9muSXl0F8V8VsvOgHdBnZqCvFCtDiXX0
	aepwZJY5ydPxvb0DViYHMsR1/3aqjpp5im0PlcX1BPzimNP7cTD7bC4Td7LaKbc2
	xiGEY8/2fjaP3ic5N0iaY4wGkMq7/zDwWOUll5JVCMK4YvMJfOz00vH5wKJXftiO
	OLaPGAXgmMr9fFRQSuOi+WQFPrruZM7J10KvH6x/DLmNp3HZo0vu1coswx8+ABaX
	3E35TgAdO29nosnTE1ngPAB1Dj4qOqG4z2gZ1LRACUcpoSwcrs/XWQ9/nlBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761157494; x=1761243894; bh=+duaajv0j42PqnxLCkBl29B49GUkUYE1wpR
	DMPNwNQs=; b=qOaViB9B5NTbm1PxiX57LNrljwKJbCP0/wBPpQ8OhHNFWubPfjV
	a2sGU9n7aip1WamT2zl34Evuv2Qm/R4gqFg/GiYjT34u5o+lD7HAn0xy+5s5INK9
	gEw/A0UfHryF9BLG+80XALIpoT3JN/bieU9sxpU+yqDRAZyp2SIhwO7jVL1uYRu7
	Fl4z8JbxDjUPI2G9hZL2HhGVGxNVN3FU4JFsJ4Vr8SjZ2M2PqYTEgBKc150Dj3fZ
	govzDIscV0j27OEYGgLJ2Mwlu+NJpTSr71gH9XGbgH9gvBZCgOgXq9cOqmAUPkQZ
	Ak337fw3D7tmpfXeU4bVAxikDrrnpE4pQNQ==
X-ME-Sender: <xms:diH5aDmsGCRaB1j-mcdrS6xMAHrFL3FJijoDvjiPK8o55yhNvahSpw>
    <xme:diH5aN1K9x4HNXKu8JBNtwg8Z8RIVGsIDsv3HGw2rNnRcvAzk49mjVmBi6A4IsRzX
    ouVY4h6GFL1zqcQ1ow1Qevqbt8GwNOqa9FKLfBuMLcVgAIjHmExdg>
X-ME-Received: <xmr:diH5aOp7M3TbhqcnreUK7eo_XZ2GYyHewTaP23wn-FS2Qony0iXAYOW-g6camRJXhwqyEd3TSwjdTT_xgjmwfJqDaoJS0-jvIRBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peiihhhonhhgrhhuohihuhesohhuthhlohhokhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:diH5aKcMGLzzMynmzjKPo66DW3szpo0z02LqB6rOKa-RFU5TrvDFeA>
    <xmx:diH5aNqi0NpcxIaRejIjMduyOQiqdhwE4VL51kjz9S7-O62U4Vphxg>
    <xmx:diH5aLGAsxhipjLYpCpBx2wYLGPiFE3oZKM_s45AKOiJxGW2XAPdpw>
    <xmx:diH5aNvkI3OpY828X8fCPJoW5bgTJCqohRx54jrt_IL2M2UnwWrxeA>
    <xmx:diH5aLWa8e4ITJ6Xcu4hci0fdY9ByXgLcLQ_GHNEgLr8TUpX5Um7LCBW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 14:24:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ruoyu Zhong via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ruoyu Zhong <zhongruoyu@outlook.com>
Subject: Re: [PATCH] bisect: fix handling of `help` and invalid subcommands
In-Reply-To: <pull.2078.git.git.1761122173126.gitgitgadget@gmail.com> (Ruoyu
	Zhong via GitGitGadget's message of "Wed, 22 Oct 2025 08:36:13 +0000")
References: <pull.2078.git.git.1761122173126.gitgitgadget@gmail.com>
Date: Wed, 22 Oct 2025 11:24:52 -0700
Message-ID: <xmqqwm4myetn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ruoyu Zhong via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ruoyu Zhong <zhongruoyu@outlook.com>
>
> As documented in git-bisect(1), `git bisect help` should display usage
> information. However, since the migration of `git bisect` to a full
> builtin command in 73fce29427 (Turn `git bisect` into a full built-in,
> 2022-11-10), this behavior was broken. Running `git bisect help` would,
> instead of showing usage, either fail silently if already in a bisect
> session, or otherwise trigger an interactive autostart prompt asking "Do
> you want me to do it for you [Y/n]?".
>
> Similarly, since df63421be9 (bisect--helper: handle states directly,
> 2022-11-10), running invalid subcommands like `git bisect foobar` also
> led to the same behavior.
>
> This occurred because `help` and other unrecognized subcommands were
> being unconditionally passed to `bisect_state`, which then called
> `bisect_autostart`, triggering the interactive prompt.

Very good observations.

> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 8b8d870cd1..993caf545d 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -1453,9 +1453,13 @@ int cmd_bisect(int argc,
>  		if (!argc)
>  			usage_msg_opt(_("need a command"), git_bisect_usage, options);
>  
> +		if (!strcmp(argv[0], "help"))
> +			usage_with_options(git_bisect_usage, options);

I briefly wondered why

    $ git grep 'strcmp.*"help"'

gives a single hit in parse-options.c but that is simply because
"git bisect" is an oddball.  Everybody, including "git bisect"
itself, takes "git <cmd> --help", but in addition, "git bisect" also
takes "git bisect help".  So this addition is unfortunate but cannot
be helped (no pun intended).  In an ideal world, as we support the
bog standard "--help", if we could remove "help" as a subcommand,
then the other part of this patch would take care of "bisect help"
without this part by saying "unknown command" ;-) but we cannot
retroactively do so now.

I also wonder if it would be cleaner to add "help" as a genuine
subcommand to the options[] table just like all the other
subcommands.  The above would not be needed if we did so.  But I do
not see huge upside for doing so (i.e., a single strcmp() with a
call like we see above, vs. a new helper function to make the same
call, to usage_with_options()), so what is written in this patch is
perfectly fine.

>  		set_terms(&terms, "bad", "good");
>  		get_terms(&terms);
> -		if (check_and_set_terms(&terms, argv[0]))
> +		if (check_and_set_terms(&terms, argv[0]) ||
> +		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
>  			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
>  				       options, argv[0]);

This change is a bit hard to reason about, so let me think aloud.

If we were saying "git bisect olde" after somehow changing bad/good
to newe/olde, then we do not want to say "unknown command", and the
way it avoids that is to see if the given command is one of the
terms check_and_set_terms() have updated.  

In other words, if argv[0] caused check_and_set_terms() to return
non-zero, we do not have to do "unknown command", because the helper
would have issued a warning already.  When it returns 0, it may be
because it saw a valid command "skip", etc. that cannot be a custom
good/bad/new/old (in which case our one_of() would be false and we
end up saying "unknown command"---have I just spot a bug???), or we
haven't set custom terms and argv[0] is one of bad/good/new/old (in
which case our one_of() would be true and we avoid saying "unknown
command").

And it turns out that my finding about the 'skip' etc. is not a bug,
as these valid commands that cannot be good/bad/new/old aliases are
already caught by parse_options() call and we know argv[0] is not
such a valid subcommand.

So after all this looks good.

Thanks.  Will queue.
