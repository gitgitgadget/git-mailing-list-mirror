Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F52C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 13:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A23E6101C
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 13:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhISNxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhISNxP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 09:53:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B510BC061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 06:51:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h17so50012582edj.6
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gZmsv2ErhsjZ4TKl7zrtOo0FqAwZ64RDMJH76wiukIE=;
        b=o7wxhuBoL4KxiX2hl6T4gpwPerswOWZoDV5qECI2vK9KBRESjdziE6LAW+URvshWT7
         W1ynPIFVDlMilT/Tj0QXPnYROmS4fiuZ1RsOzCsmUrtJVL+1ztHbUqk2PeKFm4LIASAU
         Zw1Krx1QrLy2Kft0UcGvZA5SxEOo9Mql5h5+DFDXrIO/gwsvsLxawvQi2YRt016B4uOB
         6yaYFiQ+a51yXE/HWM+RCkZKpy6kccfTzY6+R4avWlproGx4BibLhfXg8Pi1kt6nkxzc
         kYjrxnrNrjHL5RiIrVuWd5h5eyApmcqqahArSXO2m0Cn51+isQsfM/6im3bhlPAUWKSZ
         Z4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gZmsv2ErhsjZ4TKl7zrtOo0FqAwZ64RDMJH76wiukIE=;
        b=qMymTPXNFi38jdWAM2/tXBoqhatNH3dS/roiKsz5C2+bXBfm2zDrIH+MckQ01zMPR4
         R0vsNH6Iq5SVsaNa2Ri99zQBHZrHv7hK2s8nsq/lSRawlpqrICBC0u7x0h/lE1Ok3u3u
         VU79A6h9Bd5noYjTEY7FPutacJRWqCOiccRy3IaXBOabS8ke5bXVkP+4JY+7Eg0gOO7Z
         1bdL8KY2G2xAT1DkHhxLt5Vx2bYL/5x8Gs9JwyslGo52lssXoiyKyV28K4L/PwOZK8p/
         PcudkUseBoRmvXOmX4X0uF+SdDWF6ZUCV3ViRKSZ2AD7ZbRXXQ8oOOnl8PqlzP82oPU4
         OgEA==
X-Gm-Message-State: AOAM5329xO5D3hIPlu6KihcEq3LjXZlMm/91IFGWaywybCclZx1iSx4s
        Xs5ymEyKrfh9l3+UNz1GbRuWg+xvKG8W/Q==
X-Google-Smtp-Source: ABdhPJzR8u/7QU/D5M1BIQj0iVb7bhyJPW8K65VNPbPHy1fa9wDhAWsy7ec14xkUeOPsqO+qRSRYzA==
X-Received: by 2002:aa7:c9c1:: with SMTP id i1mr24089087edt.204.1632059507921;
        Sun, 19 Sep 2021 06:51:47 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m13sm4969578ejn.3.2021.09.19.06.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 06:51:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/6] Split unpack_trees 'reset' flag into two for
 untracked handling
Date:   Sun, 19 Sep 2021 15:48:49 +0200
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
Message-ID: <87wnncbrm4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 18 2021, Elijah Newren via GitGitGadget wrote:

> -	opts.reset = reset;
> +	opts.reset_keep_untracked = reset;
>  	opts.fn = twoway_merge;
> +	/* Setup opts.dir so that ignored files in the way get overwritten */
> +	opts.dir = xcalloc(1, sizeof(*opts.dir));
> +	opts.dir->flags |= DIR_SHOW_IGNORED;
> +	setup_standard_excludes(opts.dir);

Is the "opts.dir" free'd later somehow?

>  	opts.head_idx = -1;
>  	opts.update = worktree;
>  	opts.skip_unmerged = !worktree;
> -	opts.reset = 1;
> +	if (o->force)
> +		opts.reset_nuke_untracked = 1;
> +	else
> +		opts.reset_keep_untracked = 1;

In both cases opts.reset_keep_untracked is set to 1, I assume it's a
mistake, aside from that perhaps betteras:

    opts.reset_keep_untracked = o->force; /* or !o->force, depending... */

>  	opts.merge = 1;
>  	opts.fn = oneway_merge;
>  	opts.verbose_update = o->show_progress;
>  	opts.src_index = &the_index;
>  	opts.dst_index = &the_index;
> +	if (o->overwrite_ignore) {
> +		opts.dir = xcalloc(1, sizeof(*opts.dir));

ditto potential leak.

> +		opts.dir = xcalloc(1, sizeof(*opts.dir));
> +		opts.dir->flags |= DIR_SHOW_IGNORED;
> +		setup_standard_excludes(opts.dir);
> +	}


ditto (also more omitted).
