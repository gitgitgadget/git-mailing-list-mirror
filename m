Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E2C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6232460F02
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 12:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhJYMsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhJYMsn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 08:48:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73441C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 05:46:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g201-20020a1c20d2000000b00327775075f7so4843799wmg.5
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uEBCzwGDwhv3gwFHQWi8Ws4mCxJfO1bGAqcXAwkb9Pk=;
        b=B2aUEvrUtVPXhO8IM6+MH6M0jbAXrglrnzcZ/yhBIeM2S0lpqobvVgdHx0vvJ+37z5
         4TfYl3GiMpLByf27DsNTZSq9vRVxRIBUkbiU2CWL4PhUbyY2EM98JW3jKiDwWtIZ1g8E
         OfEJz4ECLr5P1ZEYS8QacCrLO0nhObBxgIUT987oO2gBTTLqohZXaHBUbHGijxAKQ1ZT
         UPaOOwbi4Wr859NxXpclGBft+Q/9eqABw+1NVlDBtc3/NjpcEzGZLXs5/RqGuy8jfAh0
         kJ7sXVGtpUQ8lJoHSBtREYTcLylFZwI/eFRMQ2Pm7M91XymPnr2JcPuLGxRfU48DCxdq
         2qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uEBCzwGDwhv3gwFHQWi8Ws4mCxJfO1bGAqcXAwkb9Pk=;
        b=L7a8oeKQsMroqZw+Hqwep1DddNgGSgeTi1PONxx+Gwb9OMcYaGlM4fXr9CINL45y5k
         jS4vjabBVnCGp1yfe32otbV5cuPrCrio4jc8t+PZ3wBuUVHQeiFF2jsAbVQfndLXM0yo
         eMfkW9M72mY9qkpktQFgpHA5FFF+lQ0qm0oc/VoEAd05nYvwlgtE/7GGwrm9A1V7RWge
         vs8UJlTJNUYSwiVN1zBfNmxfmBaCmatZaLdDej2Ot+yyXUGHU3X+OpkMsB/C5YSvXyZS
         HmCfwI0Zr715OIC+u3/GJNOptcQSKn30E/xHZNFTYypxXapsWWXwGobcQ2Cj63CjowiV
         zzJA==
X-Gm-Message-State: AOAM533iD/+jLW3jnCWRvUVCVh8zvhEBC7W9Z7VzMhVJ36EQkwy/GM8p
        DlvNljfnBFl4+4mBdi3PNvJ6uoGhpos9TQ==
X-Google-Smtp-Source: ABdhPJxjdVWIukLht0gfKYhORS1Ssb4yhOhKax6lg4SxU5926BWTXNTWfOXERaZdiQ9s0xME3LZ+zw==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr49390375wmj.38.1635165976658;
        Mon, 25 Oct 2021 05:46:16 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d16sm8620457wrq.66.2021.10.25.05.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:46:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mezMl-001Wr4-Qy;
        Mon, 25 Oct 2021 14:46:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH] amend error message violations
Date:   Mon, 25 Oct 2021 14:37:38 +0200
References: <pull.1062.git.1635164026698.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <pull.1062.git.1635164026698.gitgitgadget@gmail.com>
Message-ID: <211025.86y26hgtm0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Abhradeep Chakraborty via GitGitGadget wrote:

> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Issue no #635 in the gitgitgadget/git repo has a brief description
> about the violation of error message style convention. These
> violations are - 1) Do not end error messages with a full stop. 2) Do
> not capitalize ("unable to open %s", not "Unable to open %s") 3) Say
> what the error is first ("cannot open %s", not "%s: cannot open")

Let's summarize the guidelines instead of asking readers to visit
https://github.com/gitgitgadget/git/issues/635 (which isn't even
directly linked here) only to find a quote from CodingGuidelines.

I think it's good to split these up, e.g. the rewording of the BUG()
message for the 3rd quoted item in CodingGuidelines from cases where
you're only changing the capitalization of these messages.

> One thing to note that I didn't change any .po file as there is a
> doubt whether those are good to change or not.

Those should be left alone, and will be updated by translators as part
of the whole "git.pot" process.

> -			res = error(_("Could not parse HEAD^{tree}"));
> +			res = error(_("could not parse HEAD^{tree}"));

If we're going to mass-edit these I wouldn't mind an addition to the
guidelines that says we ''-quote things, and add that when appropriate....

>  				regerror(ret, &regex, errbuf, sizeof(errbuf));
> -				err(s, _("Malformed search regexp %s: %s"),
> +				err(s, _("malformed search regexp %s: %s"),
>  				    s->answer.buf, errbuf);
>  				continue;

..e.g. here.

> -	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
> +	error(_("you have not concluded your merge (MERGE_HEAD exists)"));
>  	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
>  		advise(_("Please, commit your changes before merging."));
> -	die(_("Exiting because of unfinished merge."));
> +	die(_("exiting because of unfinished merge"));
>  }

Surely any convention of not using full-stop should extend to advise()
too?

But in this case aren't we constructing sentences in parts? Maybe having
the full-stops here is better than not, I'm not sure.

Also, have you tried using coccinelle for this? Doing this sort of
replacement should be a small matter of some inline Python, the
linux.git repo has some good examples of that.

It would make discussing these changes easier, and per the "pending"
docs in contrib/coccinelle/README any patches could follow such rules
incrementally...
