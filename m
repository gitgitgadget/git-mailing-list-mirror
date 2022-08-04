Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B3AC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 14:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiHDOsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiHDOsO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 10:48:14 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A23818C
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 07:48:14 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id p10so44554ile.5
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GjPdoOAfr/UmN3g030/w/hOiGA5979MXao0cKQ2Kgyc=;
        b=X61BjihieGl4LqIKfPEvrldTGIAT3HX/fGEpXuiMz2o8GBA76wSsUL3/dIMPH6ZUof
         jBmr4x3NxDeWFOAjobYdQnAb2JjfwfScqKc35758zOJeNd+c1z9LPR8X0z/eMskjosRg
         TdXkx/3yZ8kz5ch27XhiCt3M0mYEYJ6FukHUBO70bN7h74DNlmn3AgtAepnWQ5IreXDi
         sazuS9oW9K1uAhAhJOS2QrAN9Lx5EY18JJ5iENnw3om24vK6zl5O3H2WDmxUJO1Etq2j
         iVaEItYqmwG1X7cOFd8x2Q9xtricvVuxRMsp6z+GcBmL9fBkuM5lvGIvhGyQqRW7Q/65
         C/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GjPdoOAfr/UmN3g030/w/hOiGA5979MXao0cKQ2Kgyc=;
        b=tjxtN3t4c2+jNB6JGzCfZzPJ9SE7teXncZuCUv8tOOMu/fNcKRa8+IOg6FbLIo1Zb0
         0fsF27deQugRUxTRecURnMgoTS51b0nxZaEgHoofecKAaeffQEhAuMMtCXskANYrYsoi
         LjDmBVMv2FAsmM79cBgyqCfbFK0pWytEhDqeVjPxBxt7hOoNUyhmhgVxD+LFQkkBJehp
         5DQ7UtPEkKfZ+ZZQjlYDIGO4lHziThFeVjQ0ZXsyFveb82tqIoAmvsm8gayvJTEh1N8O
         IwMatSYNLNJuDSlcj/XlHQjgqIlzcIcrq/7xoinZUhz66/BNFDtTKI+yAIA1rHpUJqT0
         zl7Q==
X-Gm-Message-State: ACgBeo3/EnPaae6SBL8HBcv5GTOuZ7qt+O3pgS2UfA2R0ux7Q0oCxmQB
        qsiN51hxdCJPqQTfzCbVB8WH
X-Google-Smtp-Source: AA6agR6aK6Z3zQywO3aGQY+vvlaGbk7iDA+lorEKgW+16GTBVzF1/Df9EBM3ZQgocj9xrD3496cREg==
X-Received: by 2002:a92:cd89:0:b0:2de:553f:bd9d with SMTP id r9-20020a92cd89000000b002de553fbd9dmr982633ilb.179.1659624493366;
        Thu, 04 Aug 2022 07:48:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id p5-20020a02b005000000b003427daba276sm515533jah.129.2022.08.04.07.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 07:48:13 -0700 (PDT)
Message-ID: <999169c6-a727-af2a-3361-51ac7b1f1d80@github.com>
Date:   Thu, 4 Aug 2022 10:48:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 4/4] rm: integrate with sparse-index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220803045118.1243087-5-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220803045118.1243087-5-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 12:51 AM, Shaoxuan Yuan wrote:
> Enable the sparse index within the `git-rm` command.
> 
> The `p2000` tests demonstrate a ~96% execution time reduction for
> 'git rm' using a sparse index.

Sorry that I got sidetracked yesterday when I was reviewing this
series, but I noticed something looking at these results:
 
> Test                                     before  after
> -------------------------------------------------------------
> 2000.74: git rm -f f2/f4/a (full-v3)     0.66    0.88 +33.0%
> 2000.75: git rm -f f2/f4/a (full-v4)     0.67    0.75 +12.0%

The range of _growth_ here seemed odd, so I wanted to check if this was
due to a small sample size or not.

> 2000.76: git rm -f f2/f4/a (sparse-v3)   1.99    0.08 -96.0%
> 2000.77: git rm -f f2/f4/a (sparse-v4)   2.06    0.07 -96.6%

These numbers are as expected.

>  test_perf_on_all git read-tree -mu HEAD
>  test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
> +test_perf_on_all git rm -f $SPARSE_CONE/a

At first, I was confused why we needed '-f' and thought that maybe
this was turning into a no-op after the first deletion. However, the
test_perf_on_all helper does an "echo >>$SPARSE_CONE/a" before hand,
so the file exists _in the worktree_ every time. That requires '-f'
since otherwise Git complains that we have modifications.

However, after the first instance the file no longer exists in the
index, so we are losing some testing of the index modification.

We can fix this by resetting the index in each test loop:

  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"

Running this version of the test with GIT_PERF_REPEAT_COUNT=10 and
using the Git repository itself, I get these numbers:

Test                              HEAD~1            HEAD
--------------------------------------------------------------------------
2000.74: git rm ... (full-v3)     0.41(0.37+0.05)   0.43(0.36+0.07) +4.9% 
2000.75: git rm ... (full-v4)     0.38(0.34+0.05)   0.39(0.35+0.05) +2.6% 
2000.76: git rm ... (sparse-v3)   0.57(0.56+0.01)   0.05(0.05+0.00) -91.2%
2000.77: git rm ... (sparse-v4)   0.57(0.55+0.02)   0.03(0.03+0.00) -94.7%

Yes, the 'git checkout' command is contributing to the overall
numbers, but it also already has the performance improvements of
the sparse-index, so it contributes only a little to the performance
on the left.

(Also note that the full index cases change only by amounts within
reasonable noise. The repeat count helps there.)

Thanks,
-Stolee
