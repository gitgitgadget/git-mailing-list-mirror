Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E40AC6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCLUJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjCLUJb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:09:31 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D148113DF
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:12 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1767a208b30so11816273fac.2
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvKGP31BprEkJEt7iCJBC5GonowfTndZxQvVwml8PBE=;
        b=FlZcLKmAt5740RkrzGaZk0ivFeUpgN+VER6egfWWlC/GJ//U/24gEr1YcD9KJIMfG4
         I2g+i8lZvqGb3u52YIxBwB59THviMbq5X0Du53+OSPtZf1ib5UimnEpReOGfl22nIqTf
         upTkqaOzW3OzZ8lW2y87MSE4AxNogXmTdLKvf7m3hXjZAQnMSauXwVjzO9QrhFsNN4XM
         mSplRdx0gqaxvV5fPL4Dw0BsofElSqTbvj35+szHfBv1eN6BSeugkoAt+F/8ZLouhxXI
         SQiJo4AcvpfbtpvXDSJKhgzMuvMQ/Xspr3ltL43dqrQcv8rM8Y0VcGBMUWkEX+QqmavO
         cJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvKGP31BprEkJEt7iCJBC5GonowfTndZxQvVwml8PBE=;
        b=gSuEYwnmAy++lNGg4hsrdskYfG1K25TxrnYKDepEOgo/o93fEOQSvaRDaiVoFHtdqa
         Mqx5U683LmWJCDpTn9d+ZhDmEE5EJmoRARPsY7w9SA+qM8mKhlUzOybCaFbRejEKkt/W
         RVuuS3hpBWnoFmkx7YfD2GTYYuokNuRDcZZrzH+ui6WrWnaCTiOdVVv9f5n/WFzZuMAw
         ZwNo1P/GT4cWg9svRTl6FfvgtdNb1BXeNNTXirhxVLWpRcOQsaWB1rmZfAT68IfYzGUp
         3GMUvxK7vOwbf8gzPuYCw5A+G0h487CCmAMqER73T1tfossprVYZ+tSqp/PuzUZ2mX/H
         alZQ==
X-Gm-Message-State: AO0yUKX1P7/wxaaWc4L6MEpnOSH1lsuKYIIofFRx7Q6gjnj97egZIvLM
        1CxEBvbqpVkKVZdxI9oyVSZkHPCWAIU=
X-Google-Smtp-Source: AK7set/g3KE0kzcf9D4XTn3f1QOlj5KmDk/Grh8rvgjzYYhD/ipGOHyTmEOxyt4cRHnhd8OCXtRqZA==
X-Received: by 2002:a05:6870:ac06:b0:177:9c2f:cfd0 with SMTP id kw6-20020a056870ac0600b001779c2fcfd0mr2936955oab.44.1678651743948;
        Sun, 12 Mar 2023 13:09:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ax16-20020a05687c021000b00176d49bb898sm2329391oac.44.2023.03.12.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:09:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] perf: aggregate: check if subtest exists
Date:   Sun, 12 Mar 2023 14:08:56 -0600
Message-Id: <20230312200856.323688-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230312200856.323688-1-felipe.contreras@gmail.com>
References: <20230312200856.323688-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If no tests were run, for example in p7822-grep-perl-character.sh,
that's not a fatal error, just skip to the next one.

Cc: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/perf/aggregate.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 575d2000cc..a79451a0af 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -156,6 +156,7 @@ sub sane_backticks {
 	$t =~ s{(?:.*/)?(p(\d+)-[^/]+)\.sh$}{$1} or die "bad test name: $t";
 	my $n = $2;
 	my $fname = "$resultsdir/$t.subtests";
+	next unless (-e $fname);
 	open my $fp, "<", $fname or die "cannot open $fname: $!";
 	for (<$fp>) {
 		chomp;
-- 
2.39.2.13.g1fb56cf030

