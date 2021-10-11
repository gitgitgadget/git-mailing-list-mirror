Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CBC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEBA60C4B
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhJKP5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 11:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhJKP5D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 11:57:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D306FC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 08:55:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z40so15443591qko.7
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YOhCjmT+sRezXtCXx14HWP8UiTjeUU7ovHSHRTJYDJ0=;
        b=iKTSakV7zDQ2SoP3zs5SgqtUsrYshMKGCsFTrsMmQl6Hsp2o14uNd6o4Y7kKotzs1X
         R5ru0ZkN9zMcIpD6+r3MFKatRRSU2E4v09PHrmuleMDycPG5dDlPVtarfjbCR3+nzlIx
         c6LaNBEmryYenPJEJ0BQstofPFvFP/pL3/1gQl9GnUoacwY2HugiBSZy371ph98KXZfR
         MCCNndp2qAJRgAz13qz2+Gx+GlE1RscIXrMBAu+k3FE/wfj3MO/4ZPOTC6LPIpCPF9KF
         O/XB1Xf8fmoRF2NGuJBhdvVLO3xwAmz9oqQJdGEl/H3Aeig/qil+F0n5puq6tb5/WhbR
         49fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YOhCjmT+sRezXtCXx14HWP8UiTjeUU7ovHSHRTJYDJ0=;
        b=DRQ04EhMP4DAwIqwU9gHLEQIiPpVw1YyiWouCAFYiCJgoz7iqDvJzwepvW6lPu/OWt
         GkvqSexL+PeXTEgNKY5bxHYZO86+7SfA67DaW+JJNQwKhbp7SI89hU6PHWmBHZlEDEQ8
         15JlBctwKkWanj9B2+Qf/tZ/mAJrRj+P1Jm331btGiBVxuZK1D3768UNhx62xi+8Vgua
         8GRGLvlMk6B7mrfZb0FyvPmEU/U12Q04qX/4Rzf1WT+0+DeFdT7kDxCxO/Tv/wR3Pvr+
         VIIHwUxTtv9J3BAvOb1Lk/agmGHSMNxuZ7F/B4xK3hiZrahrBZHtE5BJnfR8jYTSmGk9
         00RA==
X-Gm-Message-State: AOAM532CeCYBzj3FwNUA1KnKgB+oFkGSb6So/oLjpye8TC8vzlRGKcXx
        HjLIul/Zk6UfEAtYXbXERfqS6E6bhcw4
X-Google-Smtp-Source: ABdhPJx8Tq5pWuAqvxWr/vGhRv/bIRtbnEOXXMkiYmkmI/br43gexevDdz9cO53uXKdFnnKhXqx0IQ==
X-Received: by 2002:a37:5884:: with SMTP id m126mr14718970qkb.460.1633967702042;
        Mon, 11 Oct 2021 08:55:02 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id t11sm2938994qkm.92.2021.10.11.08.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 08:55:01 -0700 (PDT)
Message-ID: <4a002488-09ba-efed-ac70-c0ec16d7dbe2@github.com>
Date:   Mon, 11 Oct 2021 11:55:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
 <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
 <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
 <xmqq1r4vl65w.fsf@gitster.g> <47d4c810-0b56-45b0-944c-72c4d047f9b6@gmail.com>
 <xmqqlf30edvf.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqlf30edvf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> For most callers of prime_cache_tree(), like the ones in "git
> read-tree" and "git reset", it is immediately obvious that we just
> read from the same tree, and we should have everything from the tree
> and nothing else in the resulting index, so it is clear that the
> prime_cache_tree() call is recreating the same cache-tree
> information that we already should have computed ourselves, and
> these calls can go (or if "prime" is still cheaper than "update",
> these callers can pass an option to tell unpack_trees() to skip the
> cache_tree_update() call, because they will call "prime" immediately
> after).
> 

After some basic performance testing of `git reset [--hard]`, it's not clear
whether `cache_tree_update` is definitively faster or slower than
`prime_cache_tree`; more conclusive results would indicate which of the two
could be skipped. I'd like to defer this to a future patch (tracking it with
an internal issue so I don't forget) where I can perform a more thorough
analysis across all of the commands currently using `prime_cache_tree` and
update its usage accordingly.
