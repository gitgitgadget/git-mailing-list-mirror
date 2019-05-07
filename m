Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63E41F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEGKyw (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:54:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36174 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfEGKyt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:54:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so3289180wmj.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67X3eJEK2kUN9OVcYHnwirUCcjlHUs+buTtJhANNXLU=;
        b=NdqXUu/uI8GPxWCzdyJe1MR3dLkrcVhtW9yY+ycCyNolDrGTr0/fO03YruQxMz11j+
         zUZwqOIyvw0+uwnSoZcbKGnUex/jxHnf9kEHC0avn2UWKZPCFx4ZTJqCwECEU1B6lfVy
         T00cSDdjZ+03/7Jkkb/ezLB08o+VvUU9/jIg33cUlbQBRNGdd4caUGuhOAqW8nXUGDb9
         +9k1DcZP3dkZiX9rkDVZOOHYYZ5LpMnemGxwCTNFYuD3yVRmeElzxo/ol3RAZOmMByil
         sjRgsOL3Fh/cFNvO21jQwls2vcJluttexz0K1xQzlXzJ1l7AesvKQqOnQjNOqyd01LPC
         1HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67X3eJEK2kUN9OVcYHnwirUCcjlHUs+buTtJhANNXLU=;
        b=ARaBym049VMimH67MjsyOYxCg1yIA9g1sUj76neuV/TvjYmhqN515M+v+rIqzvx4r8
         NKoFbZ+4HwJ30fYklk8HTzhTmOe+RjrsTEn5pwXZmCHCNX7WKVsXMVcrX7xzln2IZ3Au
         cdZBOhpMPkYLOHyxG08M0XkwOFey8eDXc/BhXGgoUNwCymxLz/y4EnS5tHeQfUNq8Ai1
         eFP/2K4YRdHS2hYuotrI8+CIe53XzrFyN9fMbaqdTBbUBFXSSBoyo0OfzVT/v9HsriQ3
         4o+NTKSz1wQouVehQgOh/Bi57x77Dk5JkiCh0tyYKL24nJvPg57BIhKn6iJjOJa8hVDC
         AN6A==
X-Gm-Message-State: APjAAAVbxLaTy11Fm4YNGKwyC2C4+0n6VRomHtK8YmYworzR1WLg1J/n
        w09dnKZDAJ/fZR6qENQugiuUEeobc0A=
X-Google-Smtp-Source: APXvYqxFYX89PASRRCGd9QtSn3m+RZBdP37VN9wCb5SSA0i55F6W1ALdG/8jX4ajvVc1erpn+SvB5g==
X-Received: by 2002:a05:600c:506:: with SMTP id i6mr5342477wmc.3.1557226487078;
        Tue, 07 May 2019 03:54:47 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm11029573wmb.12.2019.05.07.03.54.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 03:54:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] perf aggregate: remove GIT_TEST_INSTALLED from --codespeed
Date:   Tue,  7 May 2019 12:54:30 +0200
Message-Id: <20190507105434.9600-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506232309.28538-1-avarab@gmail.com>
References: <20190506232309.28538-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the setting of the "environment" from the --codespeed output. I
don't think this is useful, and it helps with a later refactoring
where we GIT_TEST_INSTALLED stop munging/reading GIT_TEST_INSTALLED in
the perf tests in so many places.

This was added in 05eb1c37ed ("perf/aggregate: implement codespeed
JSON output", 2018-01-05), but since the "run" scripts uses
"GIT_TEST_INSTALLED" internally this was only ever useful for one-off
runs of a single revision as all the "environment" values would be
ones for whatever directory the "run" script ran last.

Let's instead fall back on the "uname -r" case, which is the sort of
thing the environment should be set to, not something that duplicates
other parts of the codpseed output. For setting the "environment" to
something custom the perf.repoName variable can be used. See
19cf57a92e ("perf/run: read GIT_PERF_REPO_NAME from perf.repoName",
2018-01-05).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/aggregate.perl | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 494907a892..f6518339dc 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -312,9 +312,6 @@ sub print_codespeed_results {
 		$environment = $reponame;
 	} elsif (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
 		$environment = $ENV{GIT_PERF_REPO_NAME};
-	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
-		$environment = $ENV{GIT_TEST_INSTALLED};
-		$environment =~ s|/bin-wrappers$||;
 	} else {
 		$environment = `uname -r`;
 		chomp $environment;
-- 
2.21.0.593.g511ec345e18

