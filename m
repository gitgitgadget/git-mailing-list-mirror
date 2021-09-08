Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D815C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB346113C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbhIHSmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhIHSmi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:42:38 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBE7C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 11:41:28 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id w78so3663554qkb.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CqmTDP7cC3sam/lZ5ODAqRqh8Qyq9LdMdD/p7Ix8MsI=;
        b=Un/MOkz0JnbyI8a/SWy0jqoQ1pyfUUAj4aaHV1zuY6uQsfSyjUMoSInScUlmk+4LNM
         ZFaiHG1fjKQY/VGFkGrIuxo/OUIKuKBvNk2vt9Te3pruTNAYGDufepEyRT8/MLaumXWd
         794hDHY2aXpTmz8otbWpwjv05TYRY/6irMy0IqnNINXObmQD56839SLvA9Yxp/mEkhM5
         +dgubWQzCUpHHcaYbJGV5RLQXtgvpuNH7MVPv4T74pr6m1qlJa2nOfR6K/QY7/HmCz11
         9FtEEjRU8enkU5Ty9KmQT+5n3ORlDxn74n8nd220Hgc+G5ddEdsmDZ/ggohg1iItsV1F
         Na4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CqmTDP7cC3sam/lZ5ODAqRqh8Qyq9LdMdD/p7Ix8MsI=;
        b=A0Y596OFSV3gv3MbMe+NV3snAb6pWW8wXUkBRHDsCgVch5or0X+wkO85vQU+Vuipnc
         lDAsJKvaqqO7qD75q7meISxOK/BpAj59KhH018gVpz2+yLCMW2yfgFb1Ns7ZOdflPD+1
         puqpACNDTddDJOMhJRMiBghzrMZB6VfvhMMdT7SMSY7+UvvOhP/crYFDU5bUqFFWVZDy
         f8GDQ3lGi1rXAWPlBNQLx/yyaF6kLx82+yRx2gbx4fvt23tRtUB6aGpc6Wmc5r8SGrzj
         wf3IgCYSo7/rCDo+gG1Ewhm0UmSUXFSub/D/G09ae7jDnmDjEMzLgMIuO3JrmV+I5kVY
         WRNQ==
X-Gm-Message-State: AOAM5300Zhy+tiGaAWhAgpgbrK6fSWUHgkVPqICUcJLgG6++YTEVU9Us
        vHAVKCCYN8gJhNRnKV8kzUA=
X-Google-Smtp-Source: ABdhPJw+TPSM5d8ByStgM1H32sEgPC7VlR7COOCS71Itx07M1cf2mQdkYq12ioaktgR8A6gr/bZwTw==
X-Received: by 2002:a05:620a:2549:: with SMTP id s9mr4971308qko.256.1631126487858;
        Wed, 08 Sep 2021 11:41:27 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id z186sm2305014qke.59.2021.09.08.11.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 11:41:27 -0700 (PDT)
Subject: Re: [PATCH 11/13] mv: refuse to move sparse paths
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <d31c641180645ee4059aab9230841ad90f9244fe.1629842085.git.gitgitgadget@gmail.com>
 <CAHd-oW5-f2Kb5DR-UTfu1qB1fm63oHf62WYsbGd5ajZueOWHtA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <939972a1-ce80-f72c-d30c-b0ead351d2bb@gmail.com>
Date:   Wed, 8 Sep 2021 14:41:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW5-f2Kb5DR-UTfu1qB1fm63oHf62WYsbGd5ajZueOWHtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 5:20 PM, Matheus Tavares Bernardino wrote:
> On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index c2f96c8e895..b58fd4ce5ba 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -176,10 +177,22 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>                 const char *src = source[i], *dst = destination[i];
>>                 int length, src_is_dir;
>>                 const char *bad = NULL;
>> +               int skip_sparse = 0;
>>
>>                 if (show_only)
>>                         printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
>>
>> +               if (!path_in_sparse_checkout(src, &the_index)) {
> 
> `git mv` can only move/rename tracked paths, but since we check
> whether `src` is sparse before checking if it is in the index, the
> user will get the sparse error message instead. This is OK, but the
> advice might be misleading, as it says they can use `--sparse` if they
> really want to move the file, but repeating the command with
> `--sparse` will now fail for another reason. I wonder if we should
> check whether `src` is tracked before checking if it is sparse, or if
> that is not really an issue we should bother with.

I will move the logic to the last possible place before "accepting"
the move, then add a comment detailing why it should be there.

>> +                       string_list_append(&only_match_skip_worktree, src);
>> +                       skip_sparse = 1;
>> +               }
>> +               if (!path_in_sparse_checkout(dst, &the_index)) {
>> +                       string_list_append(&only_match_skip_worktree, dst);
>> +                       skip_sparse = 1;
>> +               }
>> +               if (skip_sparse)
>> +                       continue;
>> +
...
>> +test_expect_success 'mv refuses to move sparse-to-sparse' '
>> +       rm -f e &&
> 
> At first glance, it confused me a bit that we are removing `e` when
> the setup didn't create it. But then I realized the test itself might
> create `e` if `git mv` succeeds in moving the `b` file. Could perhaps
> this and the others `rm -f e` be a `test_when_finished`, to make it
> clearer that it is a cleanup?

test_when_finished is cleaner.

> 
>> +       git reset --hard &&
>> +       git sparse-checkout set a &&
>> +       touch b &&
>> +       test_must_fail git mv b e 2>stderr &&
> 
> Here we try to move a "tracked sparse path" to an "untracked sparse
> path". Do we also want to test with a tracked to tracked operation?
> (Although the code path will be the same, of course.)

I can expand these tests to include tracked and untracked targets.

>> +       cat sparse_error_header >expect &&
>> +       echo b >>expect &&
>> +       echo e >>expect &&
>> +       cat sparse_hint >>expect &&
>> +       test_cmp expect stderr
>> +'
>> +
>> +test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
>> +       rm -f e &&
>> +       git reset --hard &&
>> +       git sparse-checkout set a &&
>> +       touch b &&
>> +       git mv -k b e 2>stderr &&
> 
> Maybe also check that `b` is still there, and `e` is missing?

Good idea.

In fact, there is a problem that the '-k' gets around the
protections because it doesn't return 1 early. I'll fix this
by jumping to the end of the loop which removes the entries
from the arrays.

Thanks,
-Stolee
