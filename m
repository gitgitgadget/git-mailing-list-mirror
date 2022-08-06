Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36395C00140
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 03:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiHFDSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 23:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHFDSV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 23:18:21 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978DC18B21
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 20:18:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z187so3707928pfb.12
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 20:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EK6CO57TvKI/s2BucTTqGHLgWqMHaxt36o3Q5H3oX/M=;
        b=ZQga8W7r1L3TJwMqOQOYq4DY+WwozSH+WZ787RkPZBcRZ48IbMJzorj2yg8+w5df5W
         us9Zxol6gxwEckgpsLmO5Ue74aSiOkPxHRlfHK3w8FCt14LGaohc98l9oW853yxXNS1b
         Yn2KPiSx9CgqId2se6n3uvnbODzYq+7/t38m8SCW2fU5G0eVz4lhYISwXqvC8JS7c4FB
         LDS26TnlzYskc0z7F01GIU7fIriF/zTykHxQGa7JLlYrkgO8r+Ul7jgLpUqRyFMa24l0
         rDCtVTdZYyIfQnk81JOYTrB9oP/Wppln3OrzeFTkmcxyKTqUT8psArrEr/a1Tr45ir5W
         MP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EK6CO57TvKI/s2BucTTqGHLgWqMHaxt36o3Q5H3oX/M=;
        b=0FknKCEnOfCOZ6h/sQqyC6j3meRQ4fLKKuaoJa4RnNRMmU12ccdXj2Lt2kdfdfd6BP
         f3ZSorGMrHVG+LdP4KucHc7cr99p4UrZ98Sbhm8olj6zz4h9AqYgw2zlWIzY+Ag5xELH
         CmARwBLI4t/czVI9vJjfjy//0j1NOUjrbFVe3eQphg7cyUnrr/nIkc5p7S556PB7JuD1
         TSMwjyEr7iIbwop2fZFLKNW8gzNdDVoS7hFY2vM9ppWlo/tfl3ZJ8siHOwS8DAcP9a1v
         1BwzIJ5uq3hFENntm0fA7vw7QW2ig77tZAGiRWzowEh3KZYaCQuHSapJ/K6j8+Cs5KPZ
         XwLg==
X-Gm-Message-State: ACgBeo28EDuHjXo0BUntu9h/8cbYqTyJtnu+iUL9t0cCew+aWkNj29XI
        s1G95019aPc6UBmMOSrpSg25dbfkQeNWBA==
X-Google-Smtp-Source: AA6agR7SXl6eEJat+WtkFInIry0/seMRTDAn2I1JaPpaTPd59BFXiG/X+l3y6dncNhJ0nWB7GgwjFA==
X-Received: by 2002:a05:6a00:430d:b0:52e:2c15:bf21 with SMTP id cb13-20020a056a00430d00b0052e2c15bf21mr9578614pfb.68.1659755899975;
        Fri, 05 Aug 2022 20:18:19 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b0016a3248376esm3812864plh.181.2022.08.05.20.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 20:18:19 -0700 (PDT)
Message-ID: <12afcbe9-218b-528d-6d81-f39628388ba9@gmail.com>
Date:   Sat, 6 Aug 2022 11:18:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 4/4] rm: integrate with sparse-index
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220803045118.1243087-5-shaoxuan.yuan02@gmail.com>
 <999169c6-a727-af2a-3361-51ac7b1f1d80@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <999169c6-a727-af2a-3361-51ac7b1f1d80@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 10:48 PM, Derrick Stolee wrote:
 > On 8/3/2022 12:51 AM, Shaoxuan Yuan wrote:
 >> Enable the sparse index within the `git-rm` command.
 >>
 >> The `p2000` tests demonstrate a ~96% execution time reduction for
 >> 'git rm' using a sparse index.
 >
 > Sorry that I got sidetracked yesterday when I was reviewing this
 > series, but I noticed something looking at these results:
 >
 >> Test                                     before  after
 >> -------------------------------------------------------------
 >> 2000.74: git rm -f f2/f4/a (full-v3)     0.66    0.88 +33.0%
 >> 2000.75: git rm -f f2/f4/a (full-v4)     0.67    0.75 +12.0%
 >
 > The range of _growth_ here seemed odd, so I wanted to check if this was
 > due to a small sample size or not.

Yes, I do feel they are odd, as I've been checking pervious
integrations and p2000 results, they usuallly fall below 10% range.
But I was not discerning enough to name a problem :-(

 >> 2000.76: git rm -f f2/f4/a (sparse-v3)   1.99    0.08 -96.0%
 >> 2000.77: git rm -f f2/f4/a (sparse-v4)   2.06    0.07 -96.6%
 >
 > These numbers are as expected.
 >
 >>  test_perf_on_all git read-tree -mu HEAD
 >>  test_perf_on_all git checkout-index -f --all
 >>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 >> +test_perf_on_all git rm -f $SPARSE_CONE/a
 >
 > At first, I was confused why we needed '-f' and thought that maybe
 > this was turning into a no-op after the first deletion. However, the
 > test_perf_on_all helper does an "echo >>$SPARSE_CONE/a" before hand,
 > so the file exists _in the worktree_ every time. That requires '-f'
 > since otherwise Git complains that we have modifications.

Yeah, it took me some time to find out.

 > However, after the first instance the file no longer exists in the
 > index, so we are losing some testing of the index modification.

So true, I didn't realize at all.

 > We can fix this by resetting the index in each test loop:
 >
 >   test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- 
$SPARSE_CONE/a"
 >
 > Running this version of the test with GIT_PERF_REPEAT_COUNT=10 and
 > using the Git repository itself, I get these numbers:
 >
 > Test                              HEAD~1            HEAD
 > 
--------------------------------------------------------------------------
 > 2000.74: git rm ... (full-v3)     0.41(0.37+0.05) 0.43(0.36+0.07) +4.9%
 > 2000.75: git rm ... (full-v4)     0.38(0.34+0.05) 0.39(0.35+0.05) +2.6%
 > 2000.76: git rm ... (sparse-v3)   0.57(0.56+0.01) 0.05(0.05+0.00) -91.2%
 > 2000.77: git rm ... (sparse-v4)   0.57(0.55+0.02) 0.03(0.03+0.00) -94.7%
 >
 > Yes, the 'git checkout' command is contributing to the overall
 > numbers, but it also already has the performance improvements of
 > the sparse-index, so it contributes only a little to the performance
 > on the left.
 >
 > (Also note that the full index cases change only by amounts within
 > reasonable noise. The repeat count helps there.)

New thing learned, repeat to average out noise.

--
Thanks,
Shaoxuan

