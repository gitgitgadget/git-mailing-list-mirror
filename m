Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3055E1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 17:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeGLR0T (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:26:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37082 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeGLR0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:26:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so6864408wmh.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oiqOLBV5dLRWT7/lwIWHiMV5e7lA9OsrhdClEqKnHhw=;
        b=DJYQie1ZV/lHn36KbjOusswTGrmgVedXwbOea842rXtZuRul6Jk4Pdc3aqcFSMxigE
         6VdvL1p/lwEDw6+e9XySGBu0CEWuFufPtYtexpXFgSKCcdrmtCgvzZsuXn6IzKOwSreb
         Szaa3fOcPdtJ3CIEyyH4m6Qgty9U5abUiCRnRTs0blYp7u9olvWcW4jCd3sw0yVmVrjH
         TNoX7qFAx/ebUOH0PrfKzBsZcWQQnWyZVs2YJQXmh+EsCCE/vpNAMhBdav0M0qvw0Rki
         lLkQ22loJmNbMwyH4rS+ondlAN0ZRuQm9aXYXk8FNjzaq0sfN2KSxD90MEo4WVzq1AUw
         BuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oiqOLBV5dLRWT7/lwIWHiMV5e7lA9OsrhdClEqKnHhw=;
        b=ihCQ/k4cFalWby3wdGrCJTBj0iUqeUbmWagTXT8ESBaVi52o4pIgU3C6tJ7Ha50NE7
         kz8qWmYNhQc69ftCBgIgqJNTZXs1+CPuYtM3/NOXiRQGguuxcOJznLQ0kHuhqUT2Qdhs
         gjsjxNwxEMwjRuC0gzySS2GfryaZ60TUmKbcWAhIpN/lisL8CM2mrbw26JqWTwf2PjeB
         1fvPsPZmU+qZiRwChbcZrgFDNp5IDDS2ewDnzoRtbwNTPBAhSJ3e3XKT9THcgw8tA8qg
         L1kEEuaCuNoCAH5GXUxcVEA4pnGtO2tvG1dnJCeLum+bz3rE1dAJ2m9HmuVj5YiIOf1f
         60DQ==
X-Gm-Message-State: AOUpUlFw3ZgTEoI+Vk3fGMrVI6Co5ejWxs+4G0Kz01HWcfAa69Zk3P+Y
        F1iHum63dDH62sfWxG33jzk=
X-Google-Smtp-Source: AAOMgpewXxlcxkt+S/n4VQJg9kZOTRHrwWuIV7cGaVmgQRPfraKmww8Ygbtw3/HlWHWj5Jp4Z+RLzw==
X-Received: by 2002:a1c:78b:: with SMTP id 133-v6mr2017208wmh.59.1531415749012;
        Thu, 12 Jul 2018 10:15:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i125-v6sm104738wmd.11.2018.07.12.10.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 10:15:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Daniel Harding <dharding@living180.net>
Subject: Re: [PATCH 0/2] Fix --rebase-merges with custom commentChar
References: <e8973797-fc5f-2ca5-1881-5ee66fc8279b@living180.net>
        <20180712030249.22071-1-aaron@schrab.com>
Date:   Thu, 12 Jul 2018 10:15:47 -0700
In-Reply-To: <20180712030249.22071-1-aaron@schrab.com> (Aaron Schrab's message
        of "Wed, 11 Jul 2018 23:02:49 -0400")
Message-ID: <xmqq4lh4z870.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Schrab <aaron@schrab.com> writes:

> Subject: [PATCH v2] sequencer: use configured comment character
>
> Use the configured comment character when generating comments about
> branches in a todo list.  Failure to honor this configuration causes a
> failure to parse the resulting todo list.

OK.

>
> Note that the comment_line_char has already been resolved by this point,
> even if the user has configured the comment character to be selected
> automatically.

Isn't this a slight lie?

The core.commentchar=auto setting is noticed by everybody (including
the users of the sequencer machinery), but it is honored only by
builtin/commit.c::prepare_to_commit() that is called by
builtin/commit.c::cmd_commit(), i.e. the implementation of "git
commit" that should not be used as a subroutine by other commands,
and by nothing else.  If the user has core.commentchar=auto, the
comment_line_char is left to the default '#' in the sequencer
codepath.

I think the patch is still correct and safe, but the reason why it
is so is not because we chose a suitable character (that is how I
read what "has already been resolved by this point" means) by
calling builtin/commit.c::adjust_comment_line_char().  Isn't it
because the "script" the function is working on does not have a line
that came from arbitrary end-user input that may happen to begin
with '#', hence the default '#' is safe to use?

> Signed-off-by: Aaron Schrab <aaron@schrab.com>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 4034c0461b..caf91af29d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3991,7 +3991,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  		entry = oidmap_get(&state.commit2label, &commit->object.oid);
>  
>  		if (entry)
> -			fprintf(out, "\n# Branch %s\n", entry->string);
> +			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
>  		else
>  			fprintf(out, "\n");
