Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931BECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiIEISO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiIEIRr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:17:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA9F4B0CB
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:17:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q21so2653595edc.9
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=ZK0xdA333PpAAMH0byhWCO18rUy06FA1MoIrpvvxWMY=;
        b=G+hXTPpYQtlO1Nr9Qf4Jk7lf9p89FYgr6IW/XJ5SYeotXVGVou6e5t+02cgL8rMJ2j
         B+6aXgtua7NZ/M6vmSLD2sLoZNhH25A5ey1MAb3+bCG/lFzFt0bCuZCpg1BRACneVDxk
         FOxIlPvg/ObnaAarjUQ2UXU4R2KvnIkUSEKkzxTehMU4553MZXOTSKiJhBRuJoBggFAZ
         xFgteTo2WNWqjKwY/ikUEA/xU2QKQQyBvLHq++8hdRhKApx/sk+xLmi/BqMvZ5cV9Irc
         WY679k0kbfeaNxFJD2hU8kANjVckQZwdkD/GqwM8dWvRFOPmi5QJC0K7ixCKeMBUwZt5
         CG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZK0xdA333PpAAMH0byhWCO18rUy06FA1MoIrpvvxWMY=;
        b=lk8UsKjIphANZNeaBk9PDNcChk6YeG7lX/yiA2Uu9wsDhEuX/BUApuQY5o/ZXrlKfC
         1+TeGLdySg8ZI6zanvFmZxNjfBh7RySYKlhZ59DKm6BsD6PFcOyBVg62pvTxpDwrXGaS
         mp+a4fr1SM4J93pyn2wt0znCCMbhpVHqNosa4yr6B3pUtHC4B+Vx9MujKKPwuAfPh8wB
         c1S40DDIppvpHtCZJ2ZAMrKYJNV+s2stsaJxAIFjryTO7VkrlDP2b5KMR2b8C18jY95+
         dwYh+1TowScSqJn7qsWGegrhyWF4qyY2x3nk9GHHzSuHcCZfnrb0adlkQTJhs0onQnQw
         kB0w==
X-Gm-Message-State: ACgBeo3LIh2FbD4xwuMo6K7/ihP9LK0+nOrftkcdOSIpdB5GUKe+MUSU
        JoJBTmPaa1gwFvHHajjE9pQ=
X-Google-Smtp-Source: AA6agR6otoEmqf8nrxk22W/EOLR8VawPzgLxXkQv32fMXEb4+C67YIdA9U9TV0hrKiFIOtTe61vAJA==
X-Received: by 2002:a05:6402:27c8:b0:44c:f08e:4244 with SMTP id c8-20020a05640227c800b0044cf08e4244mr12273375ede.307.1662365847246;
        Mon, 05 Sep 2022 01:17:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id dm20-20020a05640222d400b0044e96f11359sm947657edb.3.2022.09.05.01.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:17:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oV7IL-000BaJ-1p;
        Mon, 05 Sep 2022 10:17:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, l.s.r@web.de, gitster@pobox.com
Subject: Re: [PATCH] format-patch: warn if commit msg contains a patch
 delimiter
Date:   Mon, 05 Sep 2022 10:01:16 +0200
References: <d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br>
Message-ID: <220905.864jxmme0a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 04 2022, Matheus Tavares wrote:

> When applying a patch, `git am` looks for special delimiter strings
> (such as "---") to know where the message ends and the actual diff
> starts. If one of these strings appears in the commit message itself,
> `am` might get confused and fail to apply the patch properly. This has
> already caused inconveniences in the past [1][2]. To help avoid such
> problem, let's make `git format-patch` warn on commit messages
> containing one of the said strings.
>
> [1]: https://lore.kernel.org/git/20210113085846-mutt-send-email-mst@kernel.org/
> [2]: https://lore.kernel.org/git/16297305.cDA1TJNmNo@earendil/

I followed this topic with one eye, and have run into this myself in the
past. I'm not against this warning, but I wonder if we can't fix
"am/apply" to just be smarter. The cases I've seen are all ones where:

 * We have a copy/pasted git diff, but we could disambiguate based on
   (at least) the "---" line being a telltale for the "real" patch, and
   the "X file changed..." diffstat.
 * We have a not-quite-git-looking patch diff in the commit message
   (which we'd normally detect and apply), as in your [2].

Couldn't we just be a bit smarter about applying these, and do a
look-ahead and find what the user meant.

Is any case, having such a warning won't "settle" this issue, as we're
able to deal with this non-ambiguity in commit objects/the push/fetch
protocol. It's just "format-patch/am" as a "wire protocol" that has this
issue.

But anyway, that's the state of the world now, so warning() about it is
fair, even if we had a fix for the "apply" part we might want to warn
for a while to note that it's an issue on older gits.

> +		if (pp->check_in_body_patch_breaks) {
> +			strbuf_reset(&linebuf);
> +			strbuf_add(&linebuf, line, linelen);
> +			if (patchbreak(&linebuf) || is_scissors_line(linebuf.buf)) {
> +				strbuf_strip_suffix(&linebuf, "\n");

Hrm, it's a (small) shame that the patchbreak() function takes a "struct
strbuf" rather than a char */size_t in this case (seemingly for no good
reason, as it's "const"?).

Because of that you need to make a copy here, instead of just finding
the "\n" and using the %*s format, anyway, small potatoes.

> +				warning("commit message has a patch delimiter: '%s'",
> +					linebuf.buf);

Missing _()?

> +test_expect_success 'warn if commit message contains patch delimiter' '
> +	>delim &&
> +	git add delim &&
> +	GIT_EDITOR="printf \"title\n\n---\" >" git commit &&

Maybe I'm missing something, but isn't this GIT_EDITOR/printf just
another way of saying something like:

	cat >msg <<-\EOF &&
	"title

	---" >
	EOF
	git commit -F msg && ...

Untested, so maybe not..
