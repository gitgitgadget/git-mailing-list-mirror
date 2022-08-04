Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48474C00144
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 06:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiHDGjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 02:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHDGjV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 02:39:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979D93AB31
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 23:39:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b96so13757841edf.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=s6/q7AH28JlwQRoXjRuT7qfFMuWFyXOamcActM/zcmY=;
        b=hjDgRE6SYcppL5+cvRoFnNpjfJlFhz9/bDZywlsnE5unexvFxnp9ay9aybzkow/Mih
         Yxu0bhzMd/ZVNR6T8wqoeVTYY9GlMTaO7NhYJn3cnYICCEWF0LzNNBmhXoBbhBc0kO42
         xshdIjEgpw6oJ5UVD7d9i6AYpnPoMd8SFpLvRtPRfHJaxPpXsYMte6mNvqhuSfiwYkJF
         1BjY75d3Rdm3TUBLNufGl7/17uor8aFYToT6POBVnnq5FV1cRq7Wq6qOfNgNDWVZ2Obf
         Tty/4ZXU8ep7endScZ+G+tOfeIQLzA3+RjwqvwcZpothadD0alzovo8sFbcJhFn7JQoR
         PpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=s6/q7AH28JlwQRoXjRuT7qfFMuWFyXOamcActM/zcmY=;
        b=P/6GYyZiT6lTVdwPp16o4Z9ZsPiRcLG2BLFJCb3lYrMKpUzfa7ncixv1MEGwxdt2XA
         qSox7YDC5X6BupRhAsldZsKO2WNgi+JIoXjCDTkgeHFeGzA2uWrj+D3TRDwI3uUmCIEW
         bEke4hcbXMSYx/i6xvOS84mkiozN4D/KO5yOHRCHFjaQDTUCJQtBMDbWOe/LwCTnZy7n
         /DdIq9Njb7qE6+aNlUqj3uK//ThsDT6NHF/8j/wEAXKRjvTMuNqwT4/tqTH+oNsoJG+2
         ed2SRzC7qZIsURwVgCIYWiFt3fso7E8YHwZ55ts8j7yqmJVj4Pp1fUC90V0lL6yjfEVG
         bFyQ==
X-Gm-Message-State: ACgBeo0Vl+OF9YwKzTboI5dIkSPMD9aoO/l2hP6A7GKqg74kqQlqrywx
        JiU8IWriGj7FPHOd8Y8OskwoI1xuPbk=
X-Google-Smtp-Source: AA6agR6GHfax4Hxxs4e6DuZgCTuopQgtDRt4ORsF1Ang9YRRIPBNzP6Olt36u8uk+kjhQ85VHV+aQg==
X-Received: by 2002:a05:6402:28ca:b0:43b:5235:f325 with SMTP id ef10-20020a05640228ca00b0043b5235f325mr498688edb.320.1659595156898;
        Wed, 03 Aug 2022 23:39:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b007307c557e31sm4354797ejo.106.2022.08.03.23.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 23:39:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJUVn-009dyU-1T;
        Thu, 04 Aug 2022 08:39:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 06/10] builtin/diagnose.c: create 'git diagnose' builtin
Date:   Thu, 04 Aug 2022 08:27:08 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <73e139ee377f9c50e671b0d94a28b93c1db28a69.1659577543.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <73e139ee377f9c50e671b0d94a28b93c1db28a69.1659577543.git.gitgitgadget@gmail.com>
Message-ID: <220804.86zggkecmk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Create a 'git diagnose' builtin to generate a standalone zip archive of
> repository diagnostics.

It's good to have this as a built-in separate from "git bugreport",
but...

> +git-diagnose - Generate a zip archive of diagnostic information

...I'd really prefer for this not to squat on such a common name we
might regret having reserved later for such very specific
functionality. I'd think e.g. these would be better:

	git mk-diagnostics-zip

Or maybe:

	git archive-interesting-for-report

If I had to guess what a "git diagnose" did, I'd probably think:

 * It analyzes your config, and suggests redundancies/alternatives
 * It does some perf tests / heuritics, and e.g. suggests you turn on
   the commit-graph writing.

etc., this (arguably even too generic then) made sense as "scalar
diagnose" because scalar is all about being an opinionated interface
targeted at performance", so there's an implied "my repo's performance"
following a "scalar diagnose".

But as a top-level command-name I think we should pick something more
specific to what it does, which is (I haven't fully read ahead in the
re-roll, but I'm assuming is) mostly/entirely to be a "helper" for
"scalar diagnose" and/or "git bugreport".

> +	switch (safe_create_leading_directories(zip_path.buf)) {
> +	case SCLD_OK:
> +	case SCLD_EXISTS:
> +		break;
> +	default:
> +		die(_("could not create leading directories for '%s'"),
> +		    zip_path.buf);

This seems to be carrying forward a minor bug from bugreport.c we should
probably fix: we should use die_errno() here (and maybe lead with a
commit to fix bugreport.c's version).

The strbuf*() before that also seems like a good candidate for a utility
function in your new diagnose library, i.e. to have both bugreport.c and
diagnose.c pass it the prefix/suffix/format, then try to create that
directory, then replace the copy/pasting here with a one-line call to
that now-shared function.

The two codepaths only seem to differ in the prefix & suffix from a
quick skim, the rest is all copy/pasted...

