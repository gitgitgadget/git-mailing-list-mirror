Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7DAC433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2074461184
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbhJFKW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJFKW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:22:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6FAC061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:21:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj4so7950519edb.5
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IdbGItdrsZlGRMqMH9zUc5IxiGs8OaytDS+QxvoiCHM=;
        b=FPWcDoYJOZNoIaNcSBxzi08PSMRwMYcPG5cx7gRTJxQvPFl/FxwOWhb9mmpwcMMq6I
         J7GOMKgEapAjyZhMZPCT79CoGefTu0OnvwWjMi+dubjMihFIGz+p92knSdRM+wK94gvq
         CiWP6NkxzLIB9EsZgo1WzdMKWsGg5J3DVfCmXBD1K0q/C+tU0HsoY7dmelFXugzmiVGU
         25DF7wVLW7vgfbpYwR/rONkQFlsgpkEei2PTSOwLOwnddj/A8s6Iw//ceF/d3+CtDJPQ
         J6ERokqI7yyUvwSgZDKJ0JJuncA+Dw8zdLgcX1s8oklhIKnRCCGt0FOF4xF7j7Borkf1
         ttvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IdbGItdrsZlGRMqMH9zUc5IxiGs8OaytDS+QxvoiCHM=;
        b=Vm9kN1Ygff3UQvdZRhMSt8R8JjczeGSLMQeTdgzY6SGxShBTYxQZfs4K0tHCSzPABu
         5b/qVulAcngcxdvTs+5mzhZphmV07GUMqQvR8oNeq01/cO9vUXlSKJIjsmBr0vdPM5vm
         M26nIno+uouuZPgAdIz+ysZAV8kQqjmoHJYz6pC5/U0m6wVwb24HfIr+S+rUK1i0o7n9
         /W+JxL29nekh3AgmT8GBJIfPhbqmPMFraOJM5CWFxcdHHDCvxu/ggpTWTIMIBw+TaYGJ
         Ujpc0USKmWuc4K0gjpyUFZMG6xUbAVWF+FSvZic52yUHNDsvT3nKOkeGy47sx4+iTuDe
         uNHw==
X-Gm-Message-State: AOAM533RR2q33gAGsXIO/Rn1l7UOBpfLtLGAdGyzJ30zridXdNNSxmsa
        La547RqYDs9onp7VTWc6T+g=
X-Google-Smtp-Source: ABdhPJxg8Tti8OJgfGUiFNk3aDiGmCOQDD8NcToo2/kWO0quREZCq77dXZT8328myuAqIQulg7+hQw==
X-Received: by 2002:a50:e006:: with SMTP id e6mr32304086edl.302.1633515664277;
        Wed, 06 Oct 2021 03:21:04 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cr9sm9771115edb.17.2021.10.06.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:21:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/parse-options-cleanup & ab/align-parse-options-help &
 ab/help-config-vars
Date:   Wed, 06 Oct 2021 12:17:29 +0200
References: <xmqqo884tkxd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo884tkxd.fsf@gitster.g>
Message-ID: <87ilyaihdd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Junio C Hamano wrote:

> * ab/parse-options-cleanup (2021-10-01) 11 commits
>  - parse-options: change OPT_{SHORT,UNSET} to an enum
>  - parse-options tests: test optname() output
>  - parse-options.[ch]: make opt{bug,name}() "static"
>  - commit-graph: stop using optname()
>  - parse-options.c: move optname() earlier in the file
>  - parse-options.h: make the "flags" in "struct option" an enum
>  - parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
>  - parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
>  - parse-options.[ch]: consistently use "enum parse_opt_result"
>  - parse-options.[ch]: consistently use "enum parse_opt_flags"
>  - parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
>
>  Random changes to parse-options implementation.
>
>  Will merge to 'next'?
[...]
> * ab/align-parse-options-help (2021-09-22) 4 commits
>  - parse-options: properly align continued usage output
>  - git rev-parse --parseopt tests: add more usagestr tests
>  - send-pack: properly use parse_options() API for usage string
>  - parse-options API users: align usage output in C-strings
>
>  When "git cmd -h" shows more than one line of usage text (e.g.
>  the cmd subcommand may take sub-sub-command), parse-options API
>  learned to align these lines, even across i18n/l10n.
>
>  Will merge to 'next'?
[...]
> * ab/help-config-vars (2021-09-23) 9 commits
>  - help: move column config discovery to help.c library
>  - help / completion: make "git help" do the hard work
>  - help tests: test --config-for-completion option & output
>  - help: simplify by moving to OPT_CMDMODE()
>  - help: correct logic error in combining --all and --guides
>  - help: correct logic error in combining --all and --config
>  - help tests: add test for --config output
>  - help: correct usage & behavior of "git help --guides"
>  - help: correct the usage string in -h and documentation
>
>  Teach "git help -c" into helping the command line completion of
>  configuration variables.
>
>  Will merge to 'next'?

There were some nits on all of these but I think they're OK to move
forward in their current state, and I'd like to focur on some improved
UX that can be done/I've got queued up once these land. So unless you
think there's blockers...
