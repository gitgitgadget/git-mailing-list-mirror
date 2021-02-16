Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736DBC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FA564D79
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBPQdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhBPQdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 11:33:46 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD8C06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:33:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id i23so11295102ejg.10
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGfs4lZQAtdRR5IStOGZCtzwmFodRk8vbsMaeFZWTEg=;
        b=k+oCs8ZAh0IcLekgb027uRS4FWKovEh8Afp5lxk9fQlFFp2acG9IYSJKsUc37Rq+lX
         6nclPC3wD9h/ZYwWVYaUxE5QDRieMkBbYUssVS49g+OK269YYCVGkQILrZspmuO/vuXb
         qA+dQKOHeTXgHYN0seNJwx/uTtiEOTF1B9iZGVt4KAmL+VVcBYIns5P2djmg1assxeIp
         AXRFAoSD63hbKZn9MPyN8Jy6uEVtDEMuIudRy1hpoxxPc+JIHNubfdU4pkbyXoAwh+cw
         ysTpuOTKLbHAH7Uob1uwacKzUE/Nm/BhZ0h3DIZcXATYepLgep5uFYLXo847LgucTTYw
         gBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGfs4lZQAtdRR5IStOGZCtzwmFodRk8vbsMaeFZWTEg=;
        b=AAuicM9V0/Z12rkYGQE4W02t61irds26g+hkmP7N2p50QgxTzv2b4SLTrxlYagJbjz
         1LnZgxyqZtbSQ82N0WYUSuWPmfC5MybvL4770dcAxaWzulQ2WtGKDadAHhNSL95cK0ul
         suKPRgFzOpLMhVL0Tmr6pio4h4ge5de4u56l5hRYBmaOM1JT/91pzbpoVYp2SWvmCe+z
         UtcRsgB1AF91qBlCgRqe9FY/sLZBy25v9TjzmPdz1hs0dQrM8dFyA4fxnAHHmAcNGCcn
         t8MXpt3AAygaQkJ5AIPwGUOGm322Akq8poG5wdPGew6Tp0HpwBEx4EGSn5vLVPdRpync
         Quqw==
X-Gm-Message-State: AOAM5316B7AoO0L7Jf6xMGazwqo4scNfqKMRQq3gwc6nlqD4UdETP+XK
        p54M4lwSkk33aMF2JvffugdRBEvQgGbIKHKG
X-Google-Smtp-Source: ABdhPJz4BltvKRm3hG1PQaCo1mfQJxE6w7wZkc/zthzsyWoTXX5r8LpPMfmBaiMpcnv6afKCHUcikQ==
X-Received: by 2002:a17:906:6087:: with SMTP id t7mr21745594ejj.90.1613493184127;
        Tue, 16 Feb 2021 08:33:04 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.26])
        by smtp.gmail.com with ESMTPSA id u3sm13708850eje.63.2021.02.16.08.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 08:33:03 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 0/1] blame: remove unnecessary use of get_commit_info()
Date:   Tue, 16 Feb 2021 17:31:50 +0100
Message-Id: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.1.850.g2d41e9e789
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is a code cleanup and consequently a micro optimization in
determine_heat_line().

When `blame`ing with --color-by-age, the determine_line_heat() calls the
get_commit_info() to parse the commit's information.  However, it turns
out this is actually unnecessary because its caller also does the same.
We can instead, pass the already parsed `commit_info` and remove the
internal call to get_commit_info().

The performance optimization made by this patch is relatively small as
get_commit_info() doesn't perform any heavy-load operations. So, the
performance improvements is not that exciting, not at least until you
enter the ms/μs realm.  Nevertheless I thought the code cleanup is
still valid and the optimization is a bonus.


  ... digging into the the performance improvements, for those 
      who are curious ...

Running Git PERF suite in linux.git, I've got a subtle performance
improvement for some runs:

	# git.328c109303 - compiled git from commit 328c109303
	# git.blame-patched - compiled git from commit 328c109303 + this patch
        Test                                          git.328c109303    git.blame-patched
        -------------------------------------------------------------------------------------
        blame --color-by-age kernel/fork.c            1.96(1.81+0.15)   1.95(1.80+0.14) -0.5%
        blame --color-by-age kernel/sys.c             1.67(1.53+0.13)   1.66(1.52+0.14) -0.6%
        blame --color-by-age mm/slab.c                2.16(2.00+0.16)   2.15(1.99+0.15) -0.5%
        blame --color-by-age lib/packing.c            0.20(0.14+0.05)   0.20(0.14+0.05) +0.0%
        blame --color-by-age drivers/cdrom/cdrom.c    1.62(1.46+0.15)   1.62(1.46+0.15) +0.0%
        blame --color-by-age crypto/crypto_engine.c   0.37(0.29+0.06)   0.36(0.28+0.06) -2.7%
        blame --color-by-age net/ipv4/ip_forward.c    1.49(1.35+0.13)   1.48(1.34+0.13) -0.7%

To dig a little deeper, I enabled the Git's trace2 API to record every
call to the determine_line_heat() function:

        ...
+       trace2_region_enter("blame", "determine_line_heat", the_repository);
        determine_line_heat(ent, &default_color);
+       trace2_region_enter("blame", "determine_line_heat", the_repository);
        ...

Then, running `blame` for "kernel/fork.c` and _summing_ all the execution
time for every call (around 1.3k calls) resulted in 2.6x faster execution
(best out 3):

	git built from 328c109303 (The eighth batch, 2021-02-12) = 42ms
	git built from 328c109303 + this patch                   = 16ms

Of course, this is on the milliseconds :).

Lastly, to get a better picture of the performance change, I computed
all the determine_line_heat()'s execution time, for all 3 calls, into
a distribution graph.  The execution time is converted to microseconds
for ease of understanding:

        # git built from 328c109303 (The eighth batch, 2021-02-12)
     	Time in μs     0.0 ~  9.0  |
     	Time in μs    10.0 ~ 19.0  | *
     	Time in μs    20.0 ~ 29.0  | *****************
    	Time in μs    30.0 ~ 39.0  | *****************
     	Time in μs    40.0 ~ 49.0  | **
     	Time in μs    50.0 ~ 59.0  | *
     	Time in μs    60.0 ~ 69.0  | *
     	Time in μs    70.0 ~ 79.0  | *
     	Time in μs    80.0 ~ 89.0  | *
     	Time in μs    90.0 ~ 99.0  | *
     	Time in μs   100.0 ~ 109.0 | *
     	Time in μs   110.0 ~ 119.0 | *
     	Time in μs   120.0 ~ 129.0 |
     	Time in μs   130.0 ~ 139.0 | *
     	[N: 3915 | Median: 30.0 | Min: 19.0 | Max: 137.0]

     	# git built from 328c109303 + this patch
     	Time in μs     0.0 ~  9.0  |
     	Time in μs    10.0 ~ 19.0  | *************************************
     	Time in μs    20.0 ~ 29.0  | *
     	Time in μs    30.0 ~ 39.0  | *
     	Time in μs    40.0 ~ 49.0  | *
     	Time in μs    50.0 ~ 59.0  | *
     	Time in μs    60.0 ~ 69.0  | *
     	Time in μs    70.0 ~ 79.0  | *
     	Time in μs    80.0 ~ 89.0  | *
     	Time in μs    90.0 ~ 99.0  |
	        ... [ zero's omitted ] ...
     	Time in μs   150.0 ~ 159.0 |
     	Time in μs   160.0 ~ 169.0 | *
     	[N: 3915 | Median: 12.0 | Min: 10.0 | Max: 167.0]

	Note: A "*" represent hundreds counter. One "*" is used
	for any count between 1 and 99. (i.e: 23 = "*", 99 = "*",
	100 = "**", 199 = "**", 200 = "***", etc).

With the changes introduced by this patch, the determine_line_heat()
mostly finishes its execution between 10μs and 19μs compared with the
current implementation that mostly finished around 20μs and 39μs.

Rafael Silva (1):
  blame: remove unnecessary use of get_commit_info()

 builtin/blame.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.30.1.842.gf6373b1729
