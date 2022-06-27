Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0390BC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 20:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiF0UG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiF0UGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 16:06:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC401DA48
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 13:06:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z7so14588287edm.13
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=e0AWfsH0i3p4+KARUjLdvW3vBm0uOuwnQjAvMhPk5Gw=;
        b=qPkjYQBXetNx0bamMYQlG75ZsPnoAdVs901Mt9XC+1chDno9n5EvyOBxUST3T+jc5D
         UXT1YcdOS5dlyiY8DjryzXUimNp3C8lS+MTNRTaKsGyr/55V0lrKyNV0jvq0glXUtW9A
         4pL/nbezbPxuOFj0v3kEWyYWnr55uVU42UOv+unS86MpuoFKargTJijFD5id4Kxr0Ehf
         kzeKWT1NvhiPuJ79TYT2uEdFvSN3RPxWCFb44CBSfnoHcI3J0GPq9wURCF0mf1E+QdDu
         hLht55uwD7S/BH3Gf+xtrfRvov22Rm003pjjDEDA36fPfbmrF0mzi7Z78V6a69FNAqak
         uzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=e0AWfsH0i3p4+KARUjLdvW3vBm0uOuwnQjAvMhPk5Gw=;
        b=BcfaG6Cuazi94ahvWDIk+43CD7yj1thslzX3Gv7jYHRsniEn9np5uSCJ+HGGkmsnXI
         /BH+KeexYXMAXT0jUXk+JMtxI+bFJr37MFjOEkqMtgJq1n6RCbIM61I5dA3+rWAoGzXn
         TTAavviFk8BCNqh8NuGFUOTT31+OpDsEXzm7nS+NhhyOdeS+wQ0KAhNT2F9m+0QyM0D6
         l8iPSif7upoyeK46rUGlhj+t4W4xuEUQErxYCY5aCTbIg2Uzy2QfoZx+jdHTBOObacsu
         +o4qpsJFYc991OZVrOIiYbkFCzT71glAYtT30oPGbiu45EHX+0TwKW0l2LkS3DmwX7J9
         0OqA==
X-Gm-Message-State: AJIora/ep+rUzNzIM+LtMqSZEhEhqcJPdecr/A7th3reyZwP9aehywpY
        tCg0KA9yRhgVkJPvJcIqyluNRi6Hb/c=
X-Google-Smtp-Source: AGRyM1uTnaMKmAsQx4FPEHEuGe9jM1hXPryvYK4AGqDAJzGNnus+IVvIsOwMBj6toy03fVDMh6O4GQ==
X-Received: by 2002:a05:6402:4243:b0:437:618c:695a with SMTP id g3-20020a056402424300b00437618c695amr19302030edb.222.1656360380218;
        Mon, 27 Jun 2022 13:06:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t15-20020a170906608f00b006f3ef214dc0sm5434067ejj.38.2022.06.27.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:06:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o5uzz-001fMY-2M;
        Mon, 27 Jun 2022 22:06:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 00/16] Finish converting git bisect into a built-in
Date:   Mon, 27 Jun 2022 21:45:04 +0200
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
 <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
Message-ID: <220627.86mtdxhnwk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 27 2022, Johannes Schindelin via GitGitGadget wrote:

> After three GSoC/Outreachy students spent an incredible effort on this, it
> is finally time to put a neat little bow on it.

I probably just missed this in past iterations, but there's no
GSOC/Outreachy students in SOB, or even Helped-by. Was their code not
usable & this is the rewrite?

If that's the case it's not clear what that has to do with the current
state of this series...

> Changes since v3:
>
>  * Rebased because of merge conflicts with ab/plug-leak-in-revisions.
>  * Fixed the bug that git bisect --bisect-terms 1 2 wanted to auto-start a
>    bisection if running with a git executable built at the in-between state
>    at patch "bisect: move even the command-line parsing to bisect--helper".
>    Since this bug was "fixed" in v3 by the very next patch, "bisect: teach
>    the bisect--helper command to show the correct usage strings", v4 avoids
>    introducing this bug simply by letting these two patches trade places.
>    The range-diff admittedly looks quite awful because both patches overlap
>    quite a bit in the lines they modify. The end result is the same, though,
>    the diff between v3's and v4's builtin/bisect.c would be empty if I
>    hadn't been forced to rebase.
>  * Added a test case to ensure that this bug won't be introduced again. This
>    test case is the only actual difference relative to v3 of this patch
>    series.

I think there's still a lot of unnecessary churn in this series related
to migrating away from parse_options(). Your 13/16 still has a side-note
that I noted as not making sense in a past iteration.

On top of "master" I tried this trivial alternative to what you're doing
here in a *lot* more lines:
	
	diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
	index 8a052c7111f..38b23ee5fd4 100644
	--- a/builtin/bisect--helper.c
	+++ b/builtin/bisect--helper.c
	@@ -1321,6 +1321,29 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
	 		OPT_END()
	 	};
	 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
	+	int i;
	+	struct strvec args = STRVEC_INIT;
	+	
	+	for (i = 0; i < argc; i++) {
	+		const char *arg = argv[i];
	+		int is_cmd = 0;
	+		const struct option *o = options;
	+
	+		for (; o->type != OPTION_END; o++)
	+			if (o->flags & PARSE_OPT_CMDMODE &&
	+			    !strcmp(o->long_name, arg)) {
	+				is_cmd = 1;
	+				break;
	+			}
	+
	+		if (is_cmd)
	+			strvec_pushf(&args, "--%s", arg);
	+		else
	+			strvec_push(&args, argv[i]);
	+
	+	}
	+	argc = args.nr;
	+	argv = args.v;
	 
	 	argc = parse_options(argc, argv, prefix, options,
	 			     git_bisect_helper_usage,
	diff --git a/git-bisect.sh b/git-bisect.sh
	index 405cf76f2a3..0fd63bf34db 100755
	--- a/git-bisect.sh
	+++ b/git-bisect.sh
	@@ -57,27 +57,10 @@ case "$#" in
	 	case "$cmd" in
	 	help)
	 		git bisect -h ;;
	-	start)
	-		git bisect--helper --bisect-start "$@" ;;
	 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
	 		git bisect--helper --bisect-state "$cmd" "$@" ;;
	-	skip)
	-		git bisect--helper --bisect-skip "$@" || exit;;
	-	next)
	-		# Not sure we want "next" at the UI level anymore.
	-		git bisect--helper --bisect-next "$@" || exit ;;
	-	visualize|view)
	-		git bisect--helper --bisect-visualize "$@" || exit;;
	-	reset)
	-		git bisect--helper --bisect-reset "$@" ;;
	-	replay)
	-		git bisect--helper --bisect-replay "$@" || exit;;
	-	log)
	-		git bisect--helper --bisect-log || exit ;;
	-	run)
	-		git bisect--helper --bisect-run "$@" || exit;;
	-	terms)
	-		git bisect--helper --bisect-terms "$@" || exit;;
	+	start|skip|next|visualize|view|reset|replay|log|run|terms)
	+		git bisect--helper "--bisect-$cmd" "$@" || exit;;
	 	*)
	 		usage ;;
	 	esac

I.e. you're spending a lot of effort on working around the
parse_options() API supporting "--options-like-this" but not
"options-like-this". In this case it's much easier just to "fake it",
isn't it?

Of course near the end of this series we'd need to adjust that, but
doing so seems pretty easy, either just treat "start" as "--start", or
perhaps patch the relevant bits of parse_options(), but just
constructing a new command-line as I'm doing here seemed easier.

Now, there's a subtle bug in the above, I passed "view" as-is, but this
will error out. I don't think your topic introduces any bugs related to
that (that I've seen), but it goes to the "confidence building" part of [1].

I.e. here we're converting a bunch of code that doesn't have tests, and
as seen above v.s. the relevant parts of your series doing so in a way
that's not the least invasive path to that goal.

In particular I think all of 08/16, 09/16 and 13/16 (and maybe 10/16?)
would be easier & more straightforward to do with such one-pass argv
construction. I.e. if we make "start" a "--start" and e.g. "good" a
["--bisect-state", "good"] shouldn't this all just work without
migrating bisect--helper away from parse_options()?

In that way this seems a bit like two steps forward & one step back,
e.g. with the above patch we could drive 'git bisect' completion via the
usual --git-completion-helper facility (with a trivial s/--//)
workaround.

B.t.w. I think your tip is buggy with regards to that, i.e. don't you
need a NO_PARSEOPT flag in git.c when you s/bisect--helper/bisect/ so
that the completion doesn't try to use both --git-completion-helper and
its own current 'bisect function' (but maybe it works by happy accident
now?). In any case if you're set on converting this away from
parse_options() you should add that flag in git.c.

I think as far as this conversion goes we could say "we'll use
parse_options() again later", even though I think doing so is
unfortunate, as I think you're going the long way around to migrate away
from an API we're generally migrating to, when we can use it rather
easily.

I'm mainly concerned with the lack of testing. You have a new 01/16
here, but as noted in[1] and above that's really the tip of the iceberg.

Maybe you're really confident that that was the last bug, even without
testing basic things like "view" working at all, but the CL here doesn't
really make for a convincing (to me) argument.

1. https://lore.kernel.org/git/220523.865ylwzgji.gmgdl@evledraar.gmail.com/
