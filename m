Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50974C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5B960F35
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbhHQKV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbhHQKVY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 06:21:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677EC0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:20:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so10668662wrn.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2gsoumtDtKoowJSDEd+CIfmwmwWGReJnUyTOBAFP+zo=;
        b=HenL4m2xDRHxQ/fh/TYkkiw5WIMsAuj65th+xyTyo9FDMBk8FrFE78IO4rlHmOcUGH
         N3yIDQETPtI1WqbpvnBZiUL1Yg7U9y21NtKzOq8Qzi9JhQBF0Pw3G2erxGGbpfqfqPhh
         b7wKkmV4Y1WYgQbV/6M3E+/ERMJjGc9Km6GJhd27hYabyf0HImR8wV/uC9X2WS4Sjk8D
         kRm0yXHfSJn7jVQKy8MXHSuFidxEWlu90QKqKRT+c5onQf5qWPo6nPT0IRftlnJOnh5T
         9V5c2M4cBsDRvDuhVe8FrtLhqx/mB6300f/9hJhw85A+9pRKypHJKF9BDVM5w2BvIhEb
         tekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2gsoumtDtKoowJSDEd+CIfmwmwWGReJnUyTOBAFP+zo=;
        b=Gti/Jtzz6LVjN5uxZfRp1AXskYEHSoyQ5/Si6ZTbUQcZbzi6ih89tLFQaG1d35Ab+i
         BI/qUWIGoRRT21kcEu4TwaEdhZ65ZCTUrNv3+kNsZ5cd6T0VH/br8d0Arv4L8xBMma0J
         +mosQ7bh3aKtETfH/72KNsZuOeo5JlCJW1su8xye03k0egWGNpVE8wCz5wyFdYWcHjy7
         llOWZ30es7lL+FMT0x5VwDbZWEfd5A/bbcvlAiAKS/uo1spo4e3NwzXFcpJgaXp3jCFw
         LXgmliItogPHnO1AKOv0cHQQ6+n0uisUxNie7nLys0SPjKmsVhi6DJ/FBqzU9b7CHUTn
         QqdA==
X-Gm-Message-State: AOAM5319vavA0qa344xPvExgtdLlZEk2f8W1PM/vKKX0nw/t1KLRmQ20
        LS4E92SAZzR7O+QAAKscWsYKk2iy9Jc=
X-Google-Smtp-Source: ABdhPJzQo3/tPfZZe0Rcf2RWBWutIOp2J4wuckRiHLiqX/f0gBt8QoYjgcryAa1nNJrXKRH2RvK+Dw==
X-Received: by 2002:a5d:610f:: with SMTP id v15mr2942012wrt.415.1629195648604;
        Tue, 17 Aug 2021 03:20:48 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id d4sm1930448wrz.35.2021.08.17.03.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 03:20:48 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv945ng61.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com>
Date:   Tue, 17 Aug 2021 11:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqv945ng61.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/2021 00:06, Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen',
> which means nothing more than that I have found them of interest for
> some reason (like "it may have hard-to-resolve conflicts with
> another topic already in flight" or "this may turn out to be
> useful").  Do not read too much into a topic being in (or not in)
> 'seen'.  The ones marked with '.' do not appear in any of the
> integration branches, but I am still holding onto them.
> 
> Git 2.33 (final) has been tagged.  As it was a shorter cycle that
> lasted only for 10 weeks, we may see some regression post release,
> so let's see how it goes for a few days before starting the next
> round.
> 
> * pw/rebase-skip-final-fix (2021-08-13) 3 commits
>   - rebase --continue: remove .git/MERGE_MSG
>   - rebase --apply: restore some tests
>   - t3403: fix commit authorship
> 
>   Checking out all the paths from HEAD during the last conflicted
>   step in "git rebase" and continuing would cause the step to be
>   skipped (which is expected), but leaves MERGE_HEAD file behind in
>   $GIT_DIR and confuses the next "git commit", which has been
>   corrected.
> 
>   Will merge to 'next'.

Thanks

> * lh/systemd-timers (2021-07-02) 3 commits
>   - maintenance: add support for systemd timers on Linux
>   - maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
>   - cache.h: Introduce a generic "xdg_config_home_for(…)" function
> 
>   "git maintenance" scheduler learned to use systemd timers as a
>   possible backend.
> 
>   Waiting for reviews.

I'd really like to see this merged, there was some discussion a couple 
of weeks ago (cf <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>), it 
petered out but no one seemed to be objecting to merging it.

> * zh/cherry-pick-advice (2021-08-14) 1 commit
>   - cherry-pick: use better advice message
> 
>   The advice message that "git cherry-pick" gives when it asks
>   conflicted replay of a commit to be resolved by the end user has
>   been updated.

I think this is getting there now, I need to look at the tests in v5 but 
the changes to sequencer.c looked good to me.

> * jk/commit-edit-fixup-fix (2021-08-15) 1 commit
>   - commit: restore --edit when combined with --fixup
> 
>   "git commit --fixup" now works with "--edit" again, after it was
>   broken in v2.32.
> 
>   Will merge to 'next'?

Yes please, there was a new version posted at the weekend but I've just 
checked and you've already picked it up in seen.

Best Wishes

Phillip
