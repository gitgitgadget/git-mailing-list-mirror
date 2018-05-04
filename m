Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A264200B9
	for <e@80x24.org>; Fri,  4 May 2018 12:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeEDMhA (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 08:37:00 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39336 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeEDMg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 08:36:58 -0400
Received: by mail-wr0-f178.google.com with SMTP id q3-v6so20922698wrj.6
        for <git@vger.kernel.org>; Fri, 04 May 2018 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TZ6UNX+qPmfF2EzbBzC6lZN7xZRz5RQxk0xwU51SwOM=;
        b=Prw2oC6OsECEfrwafwikanJGAuobktnhUkM7qiFRSRWCR/QrQYHu9x+262+xFJ/qcP
         YBu8jwjJn1AYCbbPBKyz0WSDyc4V4RfYBFhhBSLvXYbDYI80WYr7KN7psrRNZK1Xa3pw
         0rYGNJq5AToX0S0IscQjw9RPNPcNvKCul55+8sglfxKbNUdxYbMv2pwJa2353OnFHsPH
         l0GH+TaRAzBNBh46V0o+YCBdDlZs6fKD4P9QDtvjZbxXFU8fBrgYLKVw7se6GabQo9sT
         9AwJz7ugtq5cNaql/Axxs7VNMZIjYsKUGZu+Jo93883wQmLy/8I+iuRNS2fzvCRGSqI4
         nEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TZ6UNX+qPmfF2EzbBzC6lZN7xZRz5RQxk0xwU51SwOM=;
        b=QpBIgpaFAditRttFCnriHcG3MeLPTNpzU9xGdnjLp9d6be3IXzYqfz/Bs0q+ZIMyYi
         K2kEHB98Pubbc49m9hdvKAf5/+gTxCQAXeliHUtY9CBgvIZC+N3C8grUeknE82WEAT1x
         fY5utZ8jAkulFYsCWPWlef3ZF2+5Tu+DFcmFkST41nPVILOf/qw0YKJP7K2kVEMM9u+Q
         HSSW4temJMDc9Nh+SAIuz/+xPZpTICuufV2LqpdJf0aze7V1Rtj5RiK7wnypYS04E26Z
         U4cxhSSlwG6M5uNMAfQFB9ZDmQFzHLF2uCOYJgXXTxsdlBlhgO7grmjlgJE/YgbGTNp9
         tjKQ==
X-Gm-Message-State: ALQs6tDn0Ynm8sTBE0HMNpOglvOPM9wk4xFzOg+lhvrkXgYkFidAoMvB
        UFsNTQfPmzPG4kDQVvmahI4o7nIl
X-Google-Smtp-Source: AB8JxZqOlO3X8viD3PGjLIbQyGjJPX9jjb894SBvUTExymXK0R37iYD/ymFnwi+lYqAcXUViOHQn3w==
X-Received: by 2002:adf:e985:: with SMTP id h5-v6mr22562963wrm.137.1525437416750;
        Fri, 04 May 2018 05:36:56 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com ([2a04:cec0:100d:cd09:952b:aae2:28ad:1def])
        by smtp.gmail.com with ESMTPSA id h133sm1719784wmf.47.2018.05.04.05.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 05:36:56 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] perf/bisect_run_script: disable codespeed
Date:   Fri,  4 May 2018 14:36:36 +0200
Message-Id: <20180504123636.13895-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.400.gd2f70daabc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When bisecting a performance regression using a config file,
`./bisect_regression --config my_perf.conf` for example, the
config file can contain Codespeed configuration which would
instruct the 'aggregate.perl' script called by the 'run'
script to output results in the Codespeed format and maybe
to try to send this output to a Codespeed server.

This is unfortunate because the 'bisect_run_script' relies
on the regular output from 'aggregate.perl' to mesure
performance, so let's disable Codespeed output and sending
results to a Codespeed server.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Previous version was:

https://public-inbox.org/git/20180427135135.22931-1-chriscool@tuxfamily.org/

The only change compared to this previous version is a typo
fix in the commit message:

s/This in unfortunate/This is unfortunate/

 t/perf/bisect_run_script | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/perf/bisect_run_script b/t/perf/bisect_run_script
index 038255df4b..3ebaf15521 100755
--- a/t/perf/bisect_run_script
+++ b/t/perf/bisect_run_script
@@ -24,6 +24,12 @@ result_file="$info_dir/perf_${script_number}_${bisect_head}_results.txt"
 GIT_PERF_DIRS_OR_REVS="$bisect_head"
 export GIT_PERF_DIRS_OR_REVS
 
+# Don't use codespeed
+GIT_PERF_CODESPEED_OUTPUT=
+GIT_PERF_SEND_TO_CODESPEED=
+export GIT_PERF_CODESPEED_OUTPUT
+export GIT_PERF_SEND_TO_CODESPEED
+
 ./run "$script" >"$result_file" 2>&1 || die "Failed to run perf test '$script'"
 
 rtime=$(sed -n "s/^$script_number\.$test_number:.*\([0-9]\+\.[0-9]\+\)(.*).*\$/\1/p" "$result_file")
-- 
2.17.0.400.gd2f70daabc

