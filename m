Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41C0C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbhK2Tm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347495AbhK2Tk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:40:58 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0562C061D7C
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:56:19 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id g9so13046823qvd.2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=LXjQyove5XtvDfgyKu0Tc9g2tiroPAKHmrbU8fyU4g8=;
        b=KoacBAg8wIqbwNA7Xi9nE+TM2czarSstf725GQyzodeg3ZCa+b7ZxqSGmKrpMJmGXE
         +lQGdWo+Urjc2TBlHOvExNZvA9R1HLl1XvNHt7qkz4kStNsOwPrwVn1JIS7yox+0Qkf3
         IcTYHvdEoKG6WuxoFYRdZIJCB/f23dgUC8jm1C0CsMgbdxnqB5VS+BZEQede/99SD5we
         Yw9chRy8+phkJdmhSg7NaH+Fl69qwuN6GCp5bRWc82E3hPR2cP0pPYdg1cj9xcORbe2o
         autkXQvIvg5BOSgss6WSwoOacywdavjlR4h+VuSVrMAckpdJgDIO/vNkUFJpBeV5if4b
         4COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LXjQyove5XtvDfgyKu0Tc9g2tiroPAKHmrbU8fyU4g8=;
        b=dawspVk3UR97SpzPl7FMiuq4xuM4hR6sR7yBO459WfTAdSm37ZzsUkKLiQYuKTmifs
         2hX+uYOctcAzcMwNeWCXwcrVn0pqBvmpqBE+GjdDuX145Ui8pXB2MU94czmXqL8gtFsI
         uG9r+Ra79lBWk7fY/bFswp41P/6aX72CpgNLYGQxecYghW27+NarC4BvLglUOnFMj5B6
         4E2Vxhh/KVETGZxb40PBtq7j/yHiHxesC9uf3BhSSfMDHJu3TMPnL2tsGN3fGGFHYJxP
         HbfY26datjKe8BAw89/PKmVt73CePv5p6ZtQO+WyqCMlsUYCsEanyC1Bw8N4uZMvGsJX
         tRLA==
X-Gm-Message-State: AOAM532iBkPVHFdtcCCuh2yY2mNKM6ypOpKNuecaR9imz+5OqBqDvgd4
        VOgcU0cnWvYu8VPbaNR2fx9HuYZKnTM5
X-Google-Smtp-Source: ABdhPJzI2GFKSYvIZivhw8PBqGoXxzhA1GHakrQM3mjPdIEou+VgPXynCRD7nGMNliu7fDwBt1t8xw==
X-Received: by 2002:ad4:5b82:: with SMTP id 2mr32353513qvp.93.1638201379035;
        Mon, 29 Nov 2021 07:56:19 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id l14sm7379777qki.133.2021.11.29.07.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 07:56:18 -0800 (PST)
Message-ID: <dc976377-6c2d-2d82-a128-a4316c3bcee2@github.com>
Date:   Mon, 29 Nov 2021 10:56:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: vd/sparse-reset (Was: Re: What's cooking in git.git (Nov 2021, #06;
 Wed, 24))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlf1caica.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqlf1caica.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * vd/sparse-reset (2021-10-27) 8 commits
>  - unpack-trees: improve performance of next_cache_entry
>  - reset: make --mixed sparse-aware
>  - reset: make sparse-aware (except --mixed)
>  - reset: integrate with sparse index
>  - reset: expand test coverage for sparse checkouts
>  - sparse-index: update command for expand/collapse test
>  - reset: preserve skip-worktree bit in mixed reset
>  - reset: rename is_missing to !is_in_reset_tree
>  (this branch is used by ds/fetch-pull-with-sparse-index and ld/sparse-diff-blame.)
> 
>  Various operating modes of "git reset" have been made to work
>  better with the sparse index.
> 
>  Will merge to 'next'.
> 

I submitted one last change to this series in response to Elijah's review
(threads: [1], [2]). I don't think there's any other outstanding feedback to
address, so that version (V6) should be the one to merge to 'next' (unless
any issues arise from the update itself). Thanks!

[1] https://lore.kernel.org/git/c97e4252-b17a-c8c1-3bde-cbfe22a6e4d5@github.com/

[2] https://lore.kernel.org/git/b3f33d40-d418-f285-4a32-1db7a2c4c465@github.com/
