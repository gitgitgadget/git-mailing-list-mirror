Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33252C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 04:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CF324125
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 04:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzYFwiWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAWE3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 23:29:10 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:34151 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWE3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 23:29:10 -0500
Received: by mail-qk1-f172.google.com with SMTP id d10so2211623qke.1
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 20:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yrskkcbh+hDMzSH+uTNrJEqu5Xl9rDjC5mQ2aKrEK94=;
        b=UzYFwiWHmptKvfEmeVlNcKxqaUB3aobXPtm56rfCE8HQ/DbpaO4IQMDG1mpejhlXb5
         fu8xGq6g8cE2x33SAJAnqFD4nxN54A4UIsKoh6PTgWhSmM3GnPTNDz4pDTa/P07Sovlb
         xFz0BzzzbDnDvE+QaqzZmAqEVFjIDMtRrJSry/WyMH4TYNs6KhtvBMZpg4DOekzWeb96
         1+F2uoJ7/ZCsX3oiO/ZDhHLKdJVFNMeUshdOx61rGCQunQ/oiWi8CZQ4T/EKPCHUNfyP
         e1UIpAfFidfuvrFXqjuQ2uoozPKQS+Ik2gcdgjGo4u2mKQuZ5ORwJS7uUZ0M3E2NEgA9
         F0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yrskkcbh+hDMzSH+uTNrJEqu5Xl9rDjC5mQ2aKrEK94=;
        b=IyIc9zpA6DHDslJUt+5M37gCUbfkA6iX1zUt0tu1z22Bw3vzugwEHRhoyqEwFhIUsb
         vyISKAvllScqFKnfbdn3rDP/NXCC4U+D4nfxhnVkOo/qIn9ejmIKBYt3Y82vrdO99+d1
         KXFPga5lqJ4t6UFYLRRdF878uoBAYpLooRVP6b5CDmNk/+sn/+v4NBRp9M/By22rifTv
         k309FH+LZOXJirlV/d2HmQCiINpEaonB5rdQF+cgE2WlTjq6uJuIm0/AXVFFFCIZUZz3
         JamSFB9PXf1odtnyAF6vKjPKCxl88C6cljyhtqzHDuEdnavqf7LPlXqlFbjGQnYlqYrH
         BIVw==
X-Gm-Message-State: APjAAAWw3zCw9NQa9uZYcw47hiPO/uhh40H0R2BnfDfgdLdZ7QWcw30l
        yweV62MxvoqOzSFH+epP/18=
X-Google-Smtp-Source: APXvYqzRUeHjkpRYIWKkx1acWSHo8E3ZeRpUrY60FpmRr0xUra0YEz/9BTlmKxAkLBkij/7kSj8pcQ==
X-Received: by 2002:a37:64d5:: with SMTP id y204mr12142036qkb.459.1579753749449;
        Wed, 22 Jan 2020 20:29:09 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j4sm390696qtv.53.2020.01.22.20.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 20:29:08 -0800 (PST)
Date:   Wed, 22 Jan 2020 23:29:06 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200123042906.GA29009@generichostname>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Sorry, I'm back in school so I haven't had the time to keep up with my
contributions very much. Feel free to give my topics lower priority for
the next couple of months if they interfere with any other topics.

On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
> * dl/merge-autostash (2020-01-13) 17 commits
>  - pull: pass --autostash to merge
>  - t5520: make test_pull_autostash() accept expect_parent_num
>  - merge: teach --autostash option
>  - sequencer: unlink autostash in apply_autostash()
>  - sequencer: extract perform_autostash() from rebase
>  - rebase: generify create_autostash()
>  - rebase: extract create_autostash()
>  - reset: extract reset_head() from rebase
>  - rebase: generify reset_head()
>  - rebase: use apply_autostash() from sequencer.c
>  - sequencer: make apply_rebase() accept a path
>  - rebase: use read_oneliner()
>  - sequencer: make read_oneliner() extern
>  - sequencer: configurably warn on non-existent files
>  - sequencer: use file strbuf for read_oneliner()
>  - t7600: use test_write_lines()
>  - Makefile: alphabetically sort += lists
> 
>  "git merge" learns the "--autostash" option.
> 
>  What's the status of this one?  Are people happy with the shape of
>  the code?

I'm not quite happy with this yet. Phillip Wood pointed out that if we
do `git reset --hard` mid-merge with a stash, the stash will pop _after_
the reset, which is very surprising since it leaves a dirty tree.

I think I will have time to reroll this on the weekend.

> * dl/test-must-fail-fixes-2 (2020-01-07) 16 commits
>  - t4124: only mark git command with test_must_fail
>  - t3507: use test_path_is_missing()
>  - t3507: fix indentation
>  - t3504: do check for conflict marker after failed cherry-pick
>  - t3419: stop losing return code of git command
>  - t3415: increase granularity of test_auto_{fixup,squash}()
>  - t3415: stop losing return codes of git commands
>  - t3310: extract common notes_merge_files_gone()
>  - t3030: use test_path_is_missing()
>  - t2018: replace "sha" with "oid"
>  - t2018: don't lose return code of git commands
>  - t2018: teach do_checkout() to accept `!` arg
>  - t2018: use test_expect_code for failing git commands
>  - t2018: improve style of if-statement
>  - t2018: add space between function name and ()
>  - t2018: remove trailing space from test description
> 
>  Test updates.
> 
>  Will merge to 'next'.

Eric Sunshine sent out a reworded version of "t2018: use
test_expect_code for failing git commands"'s commit message. I'll send
out that replacement patch later this weekend as well.

Thanks,

Denton
