Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA72C433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CC964E6C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhBIRDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhBIRDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:03:33 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB55C061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:02:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l19so7655938oih.6
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zV8wraS7kuZ4juToQpniNJ4OUN9mYDNElM+XDJNdfjw=;
        b=WXI+pogE6MhqBCC3Hgkm61YHvd5p6qbywv6a9aQaCnC/SnOE4vyptCpZXEGfm3MaLw
         aJQUsBxnQuS168fWDzspIfQd/GSvzwPbxKZiLSclI9RJDW1Mztze0iTVoXlIKqdJAXx9
         I2elwHUxkpev56SAuHZbRSM6XeO8nLc9qaVIw1xh1Cr5ZJN3WKkGILmqhZqykXLqxWCk
         gFf4VljIq2mESOhtCQL2PES5KrdMElyk5SNxmWcDEdLlwpjzsJuIE+H029vpVWHskd0o
         rw/jR++UN1EuJUHRVXIGIpTSCmP0d9BgtKyKACZ2mHd/dLTc3/fYvlckyOtmRgcEhkLT
         7G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zV8wraS7kuZ4juToQpniNJ4OUN9mYDNElM+XDJNdfjw=;
        b=Ju59jVaW9SJWmJAXzawTmVKxdrWUpXFkk+iJpOJGa/+yTJM3xbUhgY91L2SmWDzohM
         B+/G7sjcFFgkkOZXYbne90OfH/bHLMqUoFER9k/GVKxmt9AbAJ3hYLh9/qAARLPGTowg
         jxlhd3+USGZr0DAy1n0ijfCHsClxNHnuA4qgETzldGFqQveJhee2d6GlzzjfX4m/i18s
         dMam+h39V7lCkxFiL4+GXpL+2NCavmSbuo00ot1hQ3ThumVRtWIYlHK9hDQh0l10kiOo
         35YojVQYu0CTs0t25YV6zlAhFZ6B9G3HHvTu4azZ/rqFxUnpbFsPdW8wCaIYKJ71sCG8
         6/8w==
X-Gm-Message-State: AOAM530N8JcsBoGfqMU3CPiTV59NYqEZ7QLiU91oE7POc91Ngd2rMtkK
        pgAhIp7UhpqsLbkao4vDQfs=
X-Google-Smtp-Source: ABdhPJx0MTv1l9RNOMtMbaoGnLgo06W5gS7QS666azzYfdSUPfLFtLSlzauKrJsRaiXApMtSq8TsHg==
X-Received: by 2002:a05:6808:1144:: with SMTP id u4mr3120792oiu.11.1612890171709;
        Tue, 09 Feb 2021 09:02:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id g6sm4388936ooh.29.2021.02.09.09.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 09:02:51 -0800 (PST)
Message-ID: <9d8ee4be-33d7-6c50-f14b-0b92a4ebe949@gmail.com>
Date:   Tue, 9 Feb 2021 12:02:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 1/4] diffcore-rename: compute basenames of all source
 and dest candidates
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <381a45d239bb52a70373c385d8978005c9cb4800.1612870326.git.gitgitgadget@gmail.com>
 <dfbffe97-51de-9e8b-37a4-417909358323@gmail.com>
 <CABPp-BEsuOiUyvbkwPC384eho8pgSWuRdcvw9t5gkXhf+_j-3A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEsuOiUyvbkwPC384eho8pgSWuRdcvw9t5gkXhf+_j-3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2021 11:56 AM, Elijah Newren wrote:
>> Also, this is used here and below. Perhaps it's worth pulling out as a
>> helper? I see similar code being duplicated in these existing spots:
>>
>> * diff-no-index.c:append_basename()
>> * help.c:append_similar_ref()
>> * packfile.c:pack_basename()
>> * replace-object.c:register_replace_ref()
>> * setup.c:read_gitfile_gently()
>> * builtin/rebase.c:cmd_rebase()
>> * builtin/stash.c:do_create_stash()
>> * builtin/worktree.c:add_worktree()
>> * contrib/credential/gnome-keyring/git-credential-gnome-keyring.c:usage()
>> * contrib/credential/libsecret/git-credential-libsecret.c:usage()
>> * trace2/tr2_dst.c:tr2_dst_try_auto_path()
> Honestly asking: would anyone ever search for such a two-line helper
> function?  I wouldn't have even thought to look, since it seems so
> simple.
> 
> However, my real concern here is that this type of change would risk
> introducing conflicts with unrelated series.  This series is the
> second in what will be a 9-series deep dependency chain of
> optimizations[1], and the later series are going to be longer than
> these first two were (the latter ones are 6-11 patches each).  We've
> already discussed previously whether we possibly want to hold the
> first couple optimization series out of the upcoming git-2.31 release
> in order to keep the optimizations all together, but that might
> increase the risk of conflicts with unrelated patches if we try a
> bigger tree refactor like this.  (Junio never commented on that,
> though.)  It might be better to keep the series touching only
> merge-ort.c & diffcore-rename.c, and then do cleanups like the one you
> suggest here after the whole series.
> 
> That said, it's not a difficult initial change, so I'm mostly
> expressing this concern out of making things harder for Junio.  It'd
> be best to get his opinion -- Junio, your thoughts?
> 
> [1] https://github.com/gitgitgadget/git/pulls?q=is%3Apr+author%3Anewren+Optimization+batch
 
I don't consider the step of "go put the helper in all these other
places" necessary for the current series. However, the "get basename"
code appears a total of three times in this series, so it would be
good to at least extract it to a static inline method to reduce
the duplication isolated to this change.

Thanks,
-Stolee

