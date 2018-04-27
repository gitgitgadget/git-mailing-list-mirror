Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475EB1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758475AbeD0NwF (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 09:52:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54128 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758449AbeD0NwE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 09:52:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id 66so2772782wmd.3
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IL/XvuYYXBXN2zN8WAJu9TpASYpHTPguyT/iLQAJ6G4=;
        b=qwE2RZWcwaINYX7NQHFvwxZfivtHMdq7EMdq4ncwa1fiJ/YGEhFCzpqkOiuj+H14UW
         VB+GegldMqAIPg3CrVUxXgaPYkwdqx9XQsyl/YELYhBbbrxVqfpAVcINlZeAO6OXXzjR
         7KnecKeb87TrWussmimm68ivWwqbw2o3eZNhbRGvkKK6TzUqj6upXBDJfopOD8Gj0fIO
         72zOQe+5DL0TRkoHEmIojUZYrsNie8mkTtO4NSAY4RAVQR2Xu/QtvfNiw3+yOb/mBuk6
         P8pihE18ouOk6xSi8aRRyH4hlZrUvjx5paV5aFlOObp4/smUbQODeoFOEN1aADT2WwjU
         KJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IL/XvuYYXBXN2zN8WAJu9TpASYpHTPguyT/iLQAJ6G4=;
        b=UmSeH1RLntRaMHkjpcryjorQkxXAo933vo+PK2sS+dL2Q7IyDIEHPMVQbnWkn6lJJi
         nV0vPTni96q69v3TNqy63bbkaT0t2mVPYAtwBeb4i66VMHaBrMzLKPD9Naot7c1pKVEh
         3abdZ6t7EpgQ8VSb8aEQSl1vkJh73TL8i67jTQsW/GyFA7AnVk31ZtET9qHqPkzv8tNG
         rGoyUWno1hNx+vCGDXjNy7KjTex29FnXMajplNyY9U8azlLhHxTWrysDzhkcRzRUQw1j
         bfL78z4lWK1GgfFOwwxD/+oW05gtHcZ+PzrNSjug8doECVb2xM0xyTY/POuy44DbtbUY
         Vmpg==
X-Gm-Message-State: ALQs6tBk+IBPP2j5qRiZO2Z2zoTqnIgjPFYRse5bnTUiDxksPyLHvQFU
        6EG5OQjHyRWQUZDvSphVbp2rE49n
X-Google-Smtp-Source: AB8JxZoPNQN1Z6YbO4nks7pDALq1JtLtYU8l0kbJiiPbbp+i58p2r1PslcFDAbK7WmQiofQ/wUlOvA==
X-Received: by 10.28.40.212 with SMTP id o203mr1547675wmo.92.1524837122741;
        Fri, 27 Apr 2018 06:52:02 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id a10-v6sm1763908wri.10.2018.04.27.06.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Apr 2018 06:52:02 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v1] perf/bisect_run_script: disable codespeed
Date:   Fri, 27 Apr 2018 15:51:35 +0200
Message-Id: <20180427135135.22931-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.257.g28b659db43
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

This in unfortunate because the 'bisect_run_script' relies
on the regular output from 'aggregate.perl' to mesure
performance, so let's disable Codespeed output and sending
results to a Codespeed server.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
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
2.17.0.257.g28b659db43

