Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4864BC76195
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjCOQS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjCOQSG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:18:06 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30FDA255
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:17:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x1so1029349qtr.7
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678897075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gwk3QbzAQ7E3hZzfQqmAR4LPD5dLggAD3LKyW9mRXQ=;
        b=QwE0IZhnsqolJQEJz76RzLBKRl/HrfQluaDklBKA7hjCmfk2QqnsNgwoTKCoMX/ykx
         PQgapGcdi4GyMcaG0tHxrIObNlB4tfM4CHVLJcKppAcQe1J7SCyAVTkYmHjjVDYDELrN
         mVHrJLVICBIKnDhk1sZtp3oohjyt0/VmCF46t8zhnJdlEOhRQG/opTMU4svEy4MWEg6M
         Qoe0GKjKgEEtrEOtst7sD77rqIDDvLY5M/E2IUbt/3SDosyifTk7ba+kdR5J62CGWFZL
         qX5IVrHtdCN1JwRyLS2FFRBavCI+yPQMTCsYtgIEvShaXKU4bmr/MUEu071rXUJArNJQ
         jpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678897075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gwk3QbzAQ7E3hZzfQqmAR4LPD5dLggAD3LKyW9mRXQ=;
        b=jH0yZCe/2iKK4w0WL3nwyt9LsdEmhpj3YrHAQMxGUCBEHf4kKouXYJ09AtPEo6aHIP
         Gtt6tA1PFrpd1TnI7ui/94Vcl+d75NAaJsQN5wyti9GYOGbwdb4gvagXQZplUblYxBtP
         DNCnyL8c0tDIm62SjTzaySLZleWDia81gPzfvzdXGLSeFKuqH+dhTWstN2LMH4phDw5y
         6j3SoF4uIKSuSpjkvI0pernM4JBCVx5USKpl3MM2+x1esobNusyIkiK74z/dMV6rMBPg
         8moCIHYpMiVD5Vj0MJv5KZnjiPqyVJ/FoZ1IyS+5T+0CyNCPFDeTLHhA9SZP/xHqeDE6
         glGQ==
X-Gm-Message-State: AO0yUKXz9eD0s2ygQPHwGTbgKUph4NzLF5rC+m+6Gy4Ca8684LOog4E+
        4OoY9mcQIo8AjFmTojyvVEVAnHoeYewJbJIc+w==
X-Google-Smtp-Source: AK7set8Q6/naTH3a2KXtNMzo6dX47PYNI46QtrFfJjWWqGuVfFCh/IvqtE4VwNq+mw/oOIRoQgcfJw==
X-Received: by 2002:ac8:5e4d:0:b0:3bf:cfa6:8851 with SMTP id i13-20020ac85e4d000000b003bfcfa68851mr859513qtx.20.1678897074812;
        Wed, 15 Mar 2023 09:17:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b4dd:42a2:285c:8312? ([2600:1700:e72:80a0:b4dd:42a2:285c:8312])
        by smtp.gmail.com with ESMTPSA id de21-20020a05620a371500b007422fd3009esm4095565qkb.20.2023.03.15.09.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:17:54 -0700 (PDT)
Message-ID: <bbf4921b-851b-7630-c185-f7235f6b28d4@github.com>
Date:   Wed, 15 Mar 2023 12:17:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 8/8] commit-reach: add tips_reachable_from_bases()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <f3fb6833bd71d559a3076d9617a235614ad9a5f8.1678468864.git.gitgitgadget@gmail.com>
 <230315.864jqmxfd9.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <230315.864jqmxfd9.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 10:13 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>

(omitting the_repository stuff which will be reflected in v3)

>> -test_perf 'ahead-behind counts: git rev-list' '
>> -	for r in $(cat refs)
>> -	do
>> -		git rev-list --count "HEAD..$r" || return 1
>> -	done
> 
> Why does this change require deleting the old perf test? Your commit 7/8
> notes this test, but here we're deleting it, let's keep it and instead
> note if the results changed, or stayed the same?
>
> More generally, your commit message says:
> 
>> Add extra tests for this behavior in t6600-test-reach.sh as the
>> interesting data shape of that repository can sometimes demonstrate
>> corner case bugs.

This note is about t6600-test-reach.sh, not p1500-graph-walks.sh.

Not only does the previous message note this perf test, it has this to say:

  The 'git rev-list' test exists in this change as a demonstration, but it
  will be removed in the next change to avoid wasting time on this
  comparison.
 
> And here for a supposed optimization commit you're adding new tests, but
> when I try them with the C code at 7/8 they pass.
> 
> So it seems we should add them earlier, and this is a pure-optimization
> commit, but one that's a bit confused about what goes where? :)

I can make it more clear why we are removing it in this commit.

Thanks,
-Stolee
