Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54714C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E69260F6F
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhJZMop (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhJZMop (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 08:44:45 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C14C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:42:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id h20so14808291qko.13
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=qqNFaq5gQmlcvjGsBm3dQkkWPWLOdk6LYuQCF+S0ELs=;
        b=In3ZctiQiWqiRvn5KNrh01g/GrdvbHABUQv5q/nBObqrYAMDwfFjHS52l5wwtv32+m
         lC6Iq6zu5wgE4Z2lgDkrYKU6uPo9oIWrjWpJOliV5je98KMmrJJ2gskRmWQqgeEzWEDT
         rz2yzACJ8XKe6brcZrFhb2ZlAyPmEDkOp1koubFz6odF+iwUJulAm/eC8uPQP9FaWGcX
         jhD0Bx2emHT4/U5B/INxDJvJED98Eer01B5D3eztyYxme1k1mdnzvHae8ljX5ODRoxRu
         pFapKSVcGrZWBYbn7lMMQJ2JuCoBQHukcmzD5QyDwzBtklvjHD9IFpMY8COBcxe1xiDx
         adnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qqNFaq5gQmlcvjGsBm3dQkkWPWLOdk6LYuQCF+S0ELs=;
        b=rOQWlmhCyCx7QzBKNET7WW+SFf0LAwLsAfZYKmn8TNe9Sj2J+fzhh5y8nHkYnzEMX4
         FH/N6kpr3LqTMyO54FK00ciJhlnUkhZAsdJ6vJHnoqsWqy3/zz9EbCtw7n6P189pUd5R
         HFd8nwaNFU/S3BWrOzfyUNGyKF605qOfhwpf/CWsfbCAeNUpOJa2YJz9G7lD7T0JmyjL
         S22UT7RtAazWhDreLLb15RGovLdE77SIlIlOlOXopQu6nAsHAevPZEMULfqKf3ZL14FW
         N15W3WWc0DYFNoVKEZcH+SwGetwIK8yERKdcSEheMmp+x2OO6yjksWKsI5JkseBGYPp3
         tTvA==
X-Gm-Message-State: AOAM530vpkoPnIUBLp33uwlYx2aAHSNVPw+GbW+tUfee2gbJWsbbBxkZ
        Ew2njWlcWwYivkuiB5GIXdJYcvGf6l8=
X-Google-Smtp-Source: ABdhPJzctz4vR0ZOx9H6BzNYLq4a7QwZCy1gHkyx06RsbEh9xzK6cnh0xF7+fpiKUTeinq6WRSvxoQ==
X-Received: by 2002:a37:a88b:: with SMTP id r133mr18782791qke.290.1635252140035;
        Tue, 26 Oct 2021 05:42:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:86f:cede:45bc:10f6? ([2600:1700:e72:80a0:86f:cede:45bc:10f6])
        by smtp.gmail.com with ESMTPSA id w9sm5177563qko.19.2021.10.26.05.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 05:42:19 -0700 (PDT)
Message-ID: <e9bc367e-ae51-da1c-558e-6836922b0d0d@gmail.com>
Date:   Tue, 26 Oct 2021 08:42:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>
References: <xmqq5ytkzbt7.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5ytkzbt7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2021 11:48 PM, Junio C Hamano wrote:

> * vd/sparse-reset (2021-10-11) 8 commits
>  - unpack-trees: improve performance of next_cache_entry
>  - reset: make --mixed sparse-aware
>  - reset: make sparse-aware (except --mixed)
>  - reset: integrate with sparse index
>  - reset: expand test coverage for sparse checkouts
>  - sparse-index: update command for expand/collapse test
>  - reset: preserve skip-worktree bit in mixed reset
>  - reset: rename is_missing to !is_in_reset_tree
>  (this branch is used by ld/sparse-diff-blame.)
> 
>  Various operating modes of "git reset" have been made to work
>  better with the sparse index.
> 
>  Needs review.

This topic had good review in its first three versions, and the
current v4 has had one response that doesn't seem to have actionable
changes. Could you re-evaluate if the "needs review" label is still
appropriate?

Thanks,
-Stolee

