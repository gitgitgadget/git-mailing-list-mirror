Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC703C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 14:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970BD60EC0
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 14:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhJZPCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhJZPBz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 11:01:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740FBC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 07:59:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v17so18486503wrv.9
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=haQce2hrd5SXTYcKvy3rHzifv6/9DtXiD1dzA7mbNVc=;
        b=jcf+Sc99Z/gx9EduxsORZWNmBKxZW77pKBTa/Znqvkh/Soby5yi5OkCNyYlhfTHWzx
         RQsm1b4AcxRAR7/YFSNlgOa+PJSRn+lYYZbMdOD0JG676TDNulORIsUHddzgfLlxVbyL
         VvcVb3yaXXueg2RuEXubRCTpbgXtcagzhkp4vckCy8ePlQ2OzQ90uh4NnhLI0HTFlx3r
         l9G3AWtpuFGHO6SXZD5M1Ugr7e62HGr7HI1YyBLZtIPOv1nUQ8fCDkhX8hhsTnspQq/a
         AgMMfh2vW+XyZjZPV/NlFjkJXwKspgM0x9esZp0FJgu/0Sj29FgoOiO2VH/XUOHX5/z5
         ZwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=haQce2hrd5SXTYcKvy3rHzifv6/9DtXiD1dzA7mbNVc=;
        b=EiWrMZ4368EsHAivUn2wa94+xsr0w/i/e1dZNWKywpx+Eam7QrgFFMc+3fJ82eBBlu
         Kw9HZi/Jf8/pvJWtsgmm2wvXKWf3RpgE9CB94Q99rCKUM1Sr4pzllVedY61rAbYUtiLC
         RNHolqMpQvt5BI6bxU95cBN22DwpeNuGjiT5byiS7R0OD+fQSKpZcneFysGnUvtETZm/
         RdnGSAFFRR0KeDQdnS4JcxxmWvYPlre4Xnpig+sAnkwrqo9ikLqGjf+xeGOw/uxwu7hu
         HI50oB7um7C2vv0GTloLIUv7bcGLzocUC/X3luMU9bvrIJrNfb7IBrJ4ZGYANcBYmfg8
         rOJw==
X-Gm-Message-State: AOAM530sM0Ry4K/uQm4fYCaHffWdVvE0+u/b5SblLMz8+himlkE5of2P
        OFmTo/6fj9xYGJJyG15WEHg=
X-Google-Smtp-Source: ABdhPJwbEOF+Wm6XR6jphseeMIv1DfPvyDPo6U2OwkV7jmIZa9X9N9nDcwwDXLiS4UnGAJ3Az2DNpg==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr3774844wro.346.1635260369920;
        Tue, 26 Oct 2021 07:59:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q14sm9746920wrv.55.2021.10.26.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:59:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfNvD-001qMm-IH;
        Tue, 26 Oct 2021 16:59:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
Date:   Tue, 26 Oct 2021 16:55:14 +0200
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <e9bc367e-ae51-da1c-558e-6836922b0d0d@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <e9bc367e-ae51-da1c-558e-6836922b0d0d@gmail.com>
Message-ID: <211026.86h7d3zvao.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Derrick Stolee wrote:

> On 10/25/2021 11:48 PM, Junio C Hamano wrote:
>
>> * vd/sparse-reset (2021-10-11) 8 commits
>>  - unpack-trees: improve performance of next_cache_entry
>>  - reset: make --mixed sparse-aware
>>  - reset: make sparse-aware (except --mixed)
>>  - reset: integrate with sparse index
>>  - reset: expand test coverage for sparse checkouts
>>  - sparse-index: update command for expand/collapse test
>>  - reset: preserve skip-worktree bit in mixed reset
>>  - reset: rename is_missing to !is_in_reset_tree
>>  (this branch is used by ld/sparse-diff-blame.)
>> 
>>  Various operating modes of "git reset" have been made to work
>>  better with the sparse index.
>> 
>>  Needs review.
>
> This topic had good review in its first three versions, and the
> current v4 has had one response that doesn't seem to have actionable
> changes. Could you re-evaluate if the "needs review" label is still
> appropriate?

[CC-ing Emily, the author of that one response]

Per [1] I think it should be "expecting a re-roll", unless I'm wrong
about Victoria's "I can add that in my next version[...]" there, or
missed some subsequent exchange not in that thread.

Or maybe it should be marked for "next", I haven't reviewed the latest
version myself, just trying to help by filling in the gap about what the
label should be, if not "needs review"...

1. https://lore.kernel.org/git/16fbc2dc-6fdd-ed0d-ebc6-3b0566142879@github.com
