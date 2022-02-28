Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB416C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 13:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiB1NyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiB1NyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 08:54:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9933ED1E
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r10so5743357wma.2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xrnXv4tY1nllDHhoczWLEcmc4mJHyOw/SgZ9DQyxI2I=;
        b=TUHTya9TIiaDoB3cP5V+2TnfINQdM/1JkrNbfPN5ZKKLK3/ZaCL7Oy3cyB05eDWpVT
         YUBOGK+qOvYnGWFY9L5BQbwt/S2FJB69oLwmoxqY/cLQzCYUJqOlcXBfE/mePvCVONCr
         ConemCdRDThIJaCg96ezDRTFLi+o/Bp/aJBE9foS39bNot+YnbNrHRI2t3pucYZoK1xt
         k2M/OBjaTCspC46BPpxMz3avSoSevaQfkiz8ADFM0m4mtZAnqAP6kaHkT3QNDPxScSIa
         jONVa+HZyw8ICtHxUD3qjsmtqPkV2YU3Vzeb/dTuLD+TvwsITZMJC4iagx7BSuXAlqR9
         cbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xrnXv4tY1nllDHhoczWLEcmc4mJHyOw/SgZ9DQyxI2I=;
        b=kbwYY0mKXuEUzqgzegcF65xxxHmhzM30jZJ8lTRE4N/c68T08c1UtuPxsb70X1Hhew
         RhS9pi1VIqWjfZ2RE65ymt9Dmk2iDSeGs5GS1ZMTa3t10oT9dissN5aGfKHnRJh3yUHF
         a4AHA2c8bmkL76dUCiR8jip2k7DyRvYeA6BrRlYIhNHfnhRwlZTdYOtkAZ1cBM4Ga0KV
         GYZuhLpcqYtEETyl0iTOfVA/GErCFJWp5G8NVWtC9Bzj+rchENUMftuptkszhFUwJ8Vp
         uDm15kCYPII4guPJ0fDOgWNNrvAn5fPpv9xdLp5hR+v8Hm1Apx6elbsknUV+ylnfZGeT
         GeUw==
X-Gm-Message-State: AOAM530q/Go5C4L70CCuq1T+GlqI/c+Stqmx1dll4Aat8siNgNaLcA5p
        CNvEinSIodnZMs7FtSjl1dw4qR0Os1s=
X-Google-Smtp-Source: ABdhPJxGZRZ5B6NQtDBZ5HNzly0zZqTw8a/UMxilRj1U/of56Kd+YJovmyoIKTpcJ4C2Rrk0exwQVQ==
X-Received: by 2002:a05:600c:4e47:b0:37f:d688:90d1 with SMTP id e7-20020a05600c4e4700b0037fd68890d1mr13627361wmq.18.1646056424490;
        Mon, 28 Feb 2022 05:53:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020adffe05000000b001edf8fc0cc3sm10542957wrr.41.2022.02.28.05.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:53:43 -0800 (PST)
Message-Id: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 13:53:39 +0000
Subject: [PATCH v2 0/4] Commit-graph: Generation Number v2 Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes some bugs in generation number v2. They were
discovered while building generation number v3, but that implementation will
be delayed until these fixes are merged.

In particular, Git has been ignoring corrected commit dates since shortly
after they were introduced. This is due to a bug I introduced when trying to
make split commit-graphs safer with mixed generation number versions. I also
noticed an issue with the offset overflows that I only noticed after writing
generation number v3 using a smaller offset size, actually triggering the
bug in the test suite.


Updates in v2
=============

 * Dropped generation v3 patches, saving them for later.
 * Updated a commit message to more clearly describe the problem with the
   old code.
 * Used an || instead of two if statements in test script.

Thanks, -Stolee

Derrick Stolee (4):
  test-read-graph: include extra post-parse info
  commit-graph: fix ordering bug in generation numbers
  commit-graph: start parsing generation v2 (again)
  commit-graph: fix generation number v2 overflow values

 commit-graph.c                | 15 +++++++++++----
 t/helper/test-read-graph.c    | 13 +++++++++++++
 t/t4216-log-bloom.sh          |  1 +
 t/t5318-commit-graph.sh       | 34 +++++++++++++++++++++++++++++-----
 t/t5324-split-commit-graph.sh | 10 ++++++++++
 5 files changed, 64 insertions(+), 9 deletions(-)


base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1163%2Fderrickstolee%2Fgen-v3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1163/derrickstolee/gen-v3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1163

Range-diff vs v1:

 1:  2f89275314b = 1:  2f89275314b test-read-graph: include extra post-parse info
 2:  6e47ffed257 ! 2:  cbcbf10e699 commit-graph: fix ordering bug in generation numbers
     @@ Commit message
          actual dates is too large to fit in the 32-bit Generation Data chunk.
          However, there is a problem with this approach: if we have parsed the
          generation data from the previous commit-graph, then we continue the
     -    loop because the corrected commit date is already computed.
     +    loop because the corrected commit date is already computed. This causes
     +    an under-count in the number of overflow values.
      
          It is incorrect to add an increment to num_generation_data_overflows
     -    here, because we might start double-counting commits that are computed
     -    because of the depth-first search walk from a commit with an earlier
     -    OID.
     +    next to this 'continue' statement, because we might start
     +    double-counting commits that are computed because of the depth-first
     +    search walk from a commit with an earlier OID.
      
          Instead, iterate over the full commit list at the end, checking the
          offsets to see how many grow beyond the maximum value.
 3:  a3436b92a32 = 3:  5bc6a7660d8 commit-graph: start parsing generation v2 (again)
 4:  de7ab2f39d9 ! 4:  193217c71e0 commit-graph: fix generation number v2 overflow values
     @@ t/t5318-commit-graph.sh: test_expect_success 'corrupt commit-graph write (missin
      +# 32-bits. The graph_git_behavior checks can't take a
      +# prereq, so just stop here if we are on a 32-bit machine.
      +
     -+if ! test_have_prereq TIME_IS_64BIT
     -+then
     -+	test_done
     -+fi
     -+if ! test_have_prereq TIME_T_IS_64BIT
     ++if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
      +then
      +	test_done
      +fi
 5:  7f9b65bd225 < -:  ----------- commit-graph: document file format v2
 6:  28fe8824ba7 < -:  ----------- commit-graph: parse file format v2
 7:  ade697c4d34 < -:  ----------- commit-graph: write file format v2

-- 
gitgitgadget
