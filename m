Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732ACC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 15:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345819AbiEaPtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbiEaPtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 11:49:14 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103767D1F
        for <git@vger.kernel.org>; Tue, 31 May 2022 08:49:13 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 2so14543247iou.5
        for <git@vger.kernel.org>; Tue, 31 May 2022 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xh1C6Do/pT6HhQHo1Ka8i6MIQ///7MRbsQLlxFXE0Mo=;
        b=hJmOTcTd31lesyY/DTE3d4imWS7AVoNtcJYvKPoGLln5/1vGjnv6Y7x4URcmbDq1rl
         oi1GmXwOuJIHdhhVqy8InKqekawODZGM2kfI+jYhyz/QuLW2G/rcTTwA+aZg6OqdZdoL
         vjUMBdRFFjwpqNGYftm3Qqnev2EjvvYqmxJcpl+Zeh+nakDpvYL7X6c0xTWRwucm1WML
         Eo7Hjj/K6XAIToy1vGSP35NU1Yw/ZekH0B4TYu61BXyxhkutwBYwxG/TqmBXbOEo57SB
         bgHm0KmusQ8BPRmmMABwyzscZk4VfLUhLAQy79/0Po0RP5WYikS2jmOZltuvFYsRp+5/
         JUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xh1C6Do/pT6HhQHo1Ka8i6MIQ///7MRbsQLlxFXE0Mo=;
        b=Je3k26N7vmf4s01PLApCET5DX+aZtSZUl4xokmN/lsRj0BVKx2L2iY+elNZQHz7L4u
         UupggUcI+ryS8idoGl246JXIhHcA74jolMCPyU99XCFZq5iNFYiVSlBmkrHNNwftt2NQ
         n63HYWLYkd1gxqrFe8gU+n2evY9AMzTTHP2lxzy3SkRyt/GVyV6UYQQ0b9llf0NIOJ3M
         GPdRdWDG2ss7AyMsOry8NW9cdDT3E+wKX50XtXk3BOjSMzcpyDBVwA3wb8TXU+Rha7RD
         lautvweFyTlw9W07HtlhfemEJ+e4BOgbJCr/sS4DgzWsD75DH4RTPYbhDBCUdiLWzet/
         T6Gg==
X-Gm-Message-State: AOAM532Nbft/CTSLclQPF/r8NZfIXvy52weDI+ZFKSOa2TfkriZexJaX
        nBjfpWMphmJdNrSPbP3Vmle6
X-Google-Smtp-Source: ABdhPJxpFuvUEMjQwwjIlEIqWH2Q5+3hi2Kk7uQriJ8VHjlsuXY8Oo2ptSPuCQenOXVtRY4vuoesxw==
X-Received: by 2002:a6b:c94b:0:b0:662:f230:132a with SMTP id z72-20020a6bc94b000000b00662f230132amr19495591iof.55.1654012152683;
        Tue, 31 May 2022 08:49:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:14e9:7db8:f78e:25a8? ([2600:1700:e72:80a0:14e9:7db8:f78e:25a8])
        by smtp.gmail.com with ESMTPSA id cn9-20020a0566383a0900b003313b7a5731sm839868jab.178.2022.05.31.08.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 08:49:11 -0700 (PDT)
Message-ID: <4e02f672-b246-d32d-b208-8a51b13858c8@github.com>
Date:   Tue, 31 May 2022 11:49:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [WIP v2 4/5] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com,
        newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-5-shaoxuan.yuan02@gmail.com>
 <bc51f198-629f-0b68-a8e4-8135f61c0d03@github.com>
 <CAJyCBORo-x4jbKhtn+vUE=1TxpM83_3JWj5cvJEJJHHsv2Q0bg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJyCBORo-x4jbKhtn+vUE=1TxpM83_3JWj5cvJEJJHHsv2Q0bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/31/2022 5:56 AM, Shaoxuan Yuan wrote:
> On Fri, May 27, 2022 at 11:27 PM Derrick Stolee
> <derrickstolee@github.com> wrote:
>>
>> On 5/27/2022 6:08 AM, Shaoxuan Yuan wrote:
...
>> This appears to check if the _first_ entry under the directory
>> is sparse, but not if _all_ entries are sparse. These are not
>> the same thing, even in cone-mode sparse-checkout. The t1092
>> test directory has files like "folder1/0/0/a" but if
>> "folder1/1" is in the sparse-checkout cone, then that first
>> entry has the skip-worktree bit, but "folder1/1/a" and "folder1/a"
>> do not.
> 
> Yes, it is checking the first entry and this would not work without the
> lstat in the front. But I think the "lstat < 0" makes sure that this directory
> cannot be partially sparsified.
> 
> It is either missing both in the worktree and index, or missing in the worktree
> but present in index (with all its content sparsified). And because of that,
> I think only the first entry needs to be checked.

Ah! Good thinking. I hadn't considered that extra detail, so
we get to save some cycles here.

>>> +     }
>>> +     return ret;
>>
>> At the moment, it doesn't seem like we need 'ret' since the
>> only place you set it is in "return ret = 0;" (which could
>> just be "return 0;" while the others are "return 1;"). But,
>> perhaps you intended to create a loop over 'pos' while
>> with_slash is a prefix of the cache entry?
> 
> I agree that this variable is redundant. But I fail to understand
> the logical relation between before "But," and after "But,". Please
> elaborate on that?

I was just thinking that if you intended to write a loop as
I had suggested, then 'ret' could be modified or used in more
places. Feel free to ignore since we resolved that.

>>> +                     else if (!check_dir_in_index(src, length) &&
>>> +                                      !path_in_sparse_checkout(src_w_slash, &the_index)) {
>>
>> style-nit: You'll want to align the different parts of your
>> logical statement to agree with the end of the "else if (",
>>
>>         else if (A &&
>>                  B) {
>>
> 
> This one is interesting because it appears just alright in my VSCode editor.
> Later I found that it is because git-diff is using a tab size of 8 or something,
> but my VSCode uses tab size of 4. After I configured the git-diff tab rendering
> size, it looks alright. Same for another style nit down below.

That'll do it. You can double-check the alignment in your GGG
PR, which should use the correct tab width.

Thanks,
-Stolee
