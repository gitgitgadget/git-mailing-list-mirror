Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858CCC433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 01:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A84F61040
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 01:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244609AbhJQBYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhJQBX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 21:23:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24106C061765
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 18:21:51 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s17so12114667ioa.13
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 18:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A9SXpcwxE38yJWzlnd61N/T446gqq+mCn9QLTmK6OdI=;
        b=oVg9in9KlbpT7mjlKjYiC+bcxVzNtX49XCNUwCaNEuNO/e6zoEEsKObbUUkKWt+1Dy
         DCs0I7Czc/cRky24ZZop3qYXEwMTTAPkcuUqIpGJms+OCm1T3wgy8TeyDRbnXor/rhS0
         7TF1vA33ARc5f0IRk4pLKFnqHBc8ePeqHURP7dh8B5n8GI9M5GTgizxmnzkeTLKp1gFn
         U7NoubUYo/wKk47vjoexsVhpY1VCDoQAwnkW8QRFVGFXY4H0E7/NfW7e2WN2ljYa3c0l
         Ajyqng/0buei11YYUekI5r7nC9cMCtFDGeRp9v2y67QpCayJSX0YcjWn8+cW8j1zb5tG
         9DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A9SXpcwxE38yJWzlnd61N/T446gqq+mCn9QLTmK6OdI=;
        b=qJDPNQNS4AZTPWwVEYFSQGuzj4MCMDmvI7r7ygvjo3nwBYY6p5laXO5gMoylCSegpQ
         bYW84knhtrIv76Z6/h2fAGQsVALJLhh7BThS5iLcqX88tVi6beu6PtiSaEZ/Hdctn1VM
         W/U/H2qpXIIBGIzByAsixjcPGz4NnwOd4uV4RMmrI+iB5kZkMwmzR+cG73DFtCBqJy3m
         cZbjpu9r2XEkwifcfiYSd2/v1kHjhTCQHPhkPXG1qfUBdHrF+J+70TvJaiZy2XlQilde
         04y3SomaBwcWo3WEkMoKGLwssgaSM7QmNE3EwzpXHNE2cyh08Ou1Nyg+v95ozgrD4WZ2
         1tEg==
X-Gm-Message-State: AOAM531Jc7W1QPFz9H2lehKKZnqiN1/NkCeRQB1nI53lrRNj5U/fi+Zs
        rn0hInKY7SxzhaYa3HT7ZS11NdaR0po=
X-Google-Smtp-Source: ABdhPJznHzy5ymJ6TuBBkacLPgJhbfUzbSx0t/wsjaixqQL6HtiYHZFrMyfbjccKsGhEbEwNY8z58g==
X-Received: by 2002:a5e:9314:: with SMTP id k20mr9149894iom.136.1634433710381;
        Sat, 16 Oct 2021 18:21:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:555e:45c2:a7f5:2da2? ([2600:1700:e72:80a0:555e:45c2:a7f5:2da2])
        by smtp.gmail.com with ESMTPSA id u7sm4895279ilg.22.2021.10.16.18.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 18:21:49 -0700 (PDT)
Message-ID: <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com>
Date:   Sat, 16 Oct 2021 21:21:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
 <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
 <xmqqh7di3qfu.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh7di3qfu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/2021 5:53 PM, Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Use the index.sparse config setting to expand or collapse the index when
>> read. Previously, index.sparse would determine how the index would be
>> written to disk, but would not enforce whether the index is read into memory
>> as full or sparse. Now, the index is expanded when a sparse index is read
>> with `index.sparse=false` and is collapsed to sparse when a full index is
>> read with `index.sparse=true` (and the command does not require a full
>> index).
> 
> Instead of calling both in-core index and on-disk index, perhaps use
> "the in-core index" as appropriately in the above description and
> the result would become much less ambigous.
> 
> My knee-jerk reaction was that it is of dubious value to spend
> cycles to make the in-core index sparse after reading a non-sparse
> index from the disk to give to the caller, but this hurts only the
> commands that are not yet sparse-aware and call ensure_full_index()
> as the first thing they do.  To them, we are wasting cycles to
> shrink and expand for no good reason, and after they are done, the
> final writeout would create a sparse on-disk index.

I think you are slightly mistaken here: If index.sparse=true, then a
full index will be converted to one on write, but not immediately upon
read. This means that subsequent commands will read a sparse index, and
they will either benefit from that or not depending on whether they are
integrated with the sparse index or not.

The new behavior here is that if index.sparse=false, then we convert
a sparse index to a full one upon read, avoiding any chance that a
Git command is operating on a sparse index in-memory.

The simplest summary I can say is here:

* If index.sparse=false, then a sparse index will be converted to
  full upon read.

* If index.sparse=true, then a full index will be converted to sparse
  on write.

> Besides, the on-disk index is expected to be sparse most of the time
> when index.sparse is true, so it is hopefully a one-time waste that
> corrects by itself.
> 
> For all commands that are sparse-aware, especially when asked to
> perform their operation on the paths that are not hidden by a
> tree-like index entry, it may or may not be a win, but the downside
> would be much smaller.  The cost to shrink a full in-core index
> before writing out as a sparse one should be comparable to the cost
> to shrink a full in-core index just read from the disk before the
> sparse-index-aware caller works on it and leaves a still mostly
> sparse in-core index to be written out without much extra work to
> re-shrink it to the disk.
> 
>> This makes the behavior of `index.sparse` more intuitive, as it now clearly
>> enables/disables usage of a sparse index.
> 
> It is a minor thing, so I am willing to let it pass, but I am not
> sure about this claim.  The write-out codepath ensures, independent
> of this change, that a full on-disk index is corrected to become
> sparse when the configuration is set to true, and a sparse on-disk
> index is corrected to become full when the configuration is set to
> false, no?

The previous behavior required an index write for the sparse-to-full
transition. After this change, an index write is still required for the
full-to-sparse transition.

> So the only "intuitive"-ness we may be gaining is that the codepaths
> that are sparse-aware would work in their "sparse" (non-"sparse")
> mode when index.sparse is set to true (false), respectively, no
> matter how sparse (or not sparse) the on-disk index they work on is
> initially.  That might help debuggability (assuming that converting
> between the full and sparse forms are working correctly), but I am
> not sure if that is something end users would even care about.

I think you have a case for concern with the word "intuitive". Even
though I agree that the new setup is the best possible interpretation
of the setting, its inherit asymmetry can be confusing.

Thanks,
-Stolee

