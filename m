Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6393C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 01:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A23F61027
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 01:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbhIFBGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhIFBGh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 21:06:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3488C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 18:05:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t19so10122811ejr.8
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 18:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jlhn/UnxkI7eaW9QeA+CqoAyIcXZt1GRvPqwV2YBPfQ=;
        b=YvM9MNFmDhU7K7UXKe5ayJ4KBUtmQBWA7DqdTGSSFc1Rl+RC27G2VUTnnVYRhlUW1m
         lie408qfy/RrOHQ+/W+Co3/YHQcK83/p1AMC8xt7CzsAY3FeThQaqaCuOiMxoYbfWy5P
         8gZ6MKUx4lsykAxgGz85HOAPmjay0823rCUbh/iSVfP48Nrl07CdC4Hqefv+LmuXBdba
         NPCUMYX110awH8eisgqtvXKMcnWkTYY7lTu9BlfSVZ+i3zxvqRfr8MjODSKYaGfqTCZu
         VusAE7TH3xWLF7d33FfFm/BlHvN0hoa1hgJHNdBjmiXOkeGZskq13isWQf5TiOVHD8Ne
         mLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jlhn/UnxkI7eaW9QeA+CqoAyIcXZt1GRvPqwV2YBPfQ=;
        b=uPOVII1KQAkFMUYO6Ai5TpLk9QV8vuR/5LRl3LAoTphucPTjAKkxjG8WQwOPcyqJBD
         8vVzvbpuxB9x5St4f+huhIVmvzCwum2HFqKW0CLgAFV+2vqtZ/X8M26aof43CoilDKEK
         vjLRFx3la/aE3vdaX00z3YhiTuYg3cyVKrR/6vSpeKLVFxrxjKNURzUZC7AX2sX5lXMP
         UAh/Io/XHEiA5K20AECP5H82wHiGij7uzOPfjj1qqhK/n8T6toD7c+spEyWDo+rxJhJR
         5SPfeqGSy8rvOKin1t73lplxkDTx045HpaVDHjg/FGuErUbvKK1MKfiKpOVFJ2Qc4IrX
         502Q==
X-Gm-Message-State: AOAM531UJCczfiX4fb/SqAOlwPKxA7yNHFtanBjGLr2QnGimBsbv4gMx
        La6G0fSTLbtD782oW70Z+zin0JJjnCZ0wg==
X-Google-Smtp-Source: ABdhPJwHmdB/ngEcW6ekCEsG8jR8tflzt2KBbj2o5mGEtn48tDMcGJMmvfT7X8WWiDJoLeN5ixUIDw==
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr11015388ejg.548.1630890332314;
        Sun, 05 Sep 2021 18:05:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e21sm2939095ejj.4.2021.09.05.18.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:05:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/15] [RFC] Upstreaming the Scalar command
Date:   Mon, 06 Sep 2021 02:59:03 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
Message-ID: <877dfupl7o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 03 2021, Johannes Schindelin via GitGitGadget wrote:

> Changes since v1:
>
>  * A couple typos were fixed
>  * The code parsing the output of ls-remote was made more readable
>  * The indentation used in scalar.txt now consistently uses tabs
>  * We no longer hard-code core.bare = false when registering with Scalar

A summary of outstanding but unaddressed things would be useful during
re-rolls. In this case at least:

 - My point that the build system part of this is more complex than it
   probably needs to be:
   https://lore.kernel.org/git/87mtoxwt63.fsf@evledraar.gmail.com/

 - My point & Junio concurring with some style suggestions:
   https://lore.kernel.org/git/xmqqk0jxft1p.fsf@gitster.g

 - My minor style comment about the ", 1". Just saying it's
   "outstanding" because I think what you had & I just replied to in
   https://lore.kernel.org/git/87bl56plbi.fsf@evledraar.gmail.com/ might
   have been a dismissal of the macro suggestion (which I don't like
   either), not just the simpler "get rid of init verbosity to all 1".
