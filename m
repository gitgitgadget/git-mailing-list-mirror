Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E29ECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 07:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiH1HD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 03:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiH1HD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 03:03:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87C2AE35
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 00:03:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x80so1498594pgx.0
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=Xnij0bQcqvknS8b5t7mCAk0KjVF6K2pZWxYVo/TJ+Z4=;
        b=HjWEqqKTQ5kmkitZJi9QJC8OuAPUYcbwYqB1oTwsx/ypv2vT7rU+o3oqk6FBDVZiqt
         35rhhGt174g1jYM0ldZQBDJ4MVFZmrp1U3e7muFX7JFbJHXPOgoQzCBQOp4LdMeMmlp0
         rY/mBMO29cZnXA666vDO+QVQVl/O7ZpVkBtX37UV/EoMQso6of32hPTdT14lpvai732P
         PBPkd7mN2KlZagYcJAOOFPG3NUEKEfYqPhIPTnyOEAZTLKnjKo8LdgYOINi6sZRXahSU
         lvZ5dgKkI8Q+MqdmQk7+LesswnZ7TpnI0Th/S5z8T/rdG76Alp2o0TXUBmv/YbEYoMNv
         FlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=Xnij0bQcqvknS8b5t7mCAk0KjVF6K2pZWxYVo/TJ+Z4=;
        b=ai4oivSlBcdtsYyHLpWv1MSUXYs/nPkvsll1XpJXaqUw4JBp26y94rDWKWq05wJUOn
         AyTngoMwI7IJY1agRu8ZqLrTUG8R2c+wJdHXNGwcMcI0uobN7oDkGdPXnediqAC4XTnF
         uNW83r56GpnL3xu1PMjCQ3HWrLE9EaepG7ve19L4I3MS76xSTP2g1BGCS2dCGDg4MsVm
         B+1r1n7wiVxRaRLJ22n0T39MAk39jZyZtjIaogDjbpThkZMrS0ypdJz9UV5zSIBPJNpU
         R5+aXTBd/5GOLWXYsZVfgVmcK3mbIFqZq123RZuyx8QudBl3akhvTVM4Ek2PQlgLjoRi
         PGQg==
X-Gm-Message-State: ACgBeo35n8LBwCZaCj9O7MS5J590UXRe450PbqVgtNDfZIPIP+Aaiu4/
        +NukUFeLnnnyjgDzLlY1cqpQNmPx0ds=
X-Google-Smtp-Source: AA6agR5Q/0gGyvtBjY8gdHCRnUZLPd+BH5pBcQJgY/EET9MF48kaOG8+yoLgqJpKI/NEleWfzRlSYw==
X-Received: by 2002:a63:6c42:0:b0:3fe:465:7a71 with SMTP id h63-20020a636c42000000b003fe04657a71mr9437899pgc.101.1661670234661;
        Sun, 28 Aug 2022 00:03:54 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c74-20020a624e4d000000b00534cb3872edsm4753221pfb.166.2022.08.28.00.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 00:03:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 09/16] bisect run: fix the error message
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <409492ad830828f2b5f341706ad9ad1c64f66d6e.1661604264.git.gitgitgadget@gmail.com>
Date:   Sun, 28 Aug 2022 00:03:53 -0700
Message-ID: <xmqq8rn8voh2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
> in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
> the part that prints out an error message when the implicit `git bisect
> bad` or `git bisect good` failed.
>
> However, the error message was supposed to print out whether the state
> was "good" or "bad", but used a bogus (because non-populated) `args`
> variable for it.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect--helper.c    |  2 +-
>  t/t6030-bisect-porcelain.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index d797cd1cef8..a00167f1373 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1430,7 +1430,7 @@ static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
>  			printf(_("bisect found first bad commit"));
>  			res = BISECT_OK;
>  		} else if (res) {
> -			error(_("bisect run failed: 'git bisect--helper --bisect-state"
> +			error(_("bisect run failed: 'git bisect"
>  			" %s' exited with error code %d"), new_state, res);
>  		} else {
>  			continue;

The change to retire "bisect--helper" from the end-user facing error
message makes tons of sense, but I am not quite sure if the proposed
log message describes the change correctly.  Or is this a fallout of
some "rebase -i" gotcha that a log message meant for one commit was
applied to a different commit, or something?
