Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19558C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiGSVFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbiGSVFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2F422DE
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d16so23385903wrv.10
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdFR5yOnaJKc098kFERNw8BRK74DSY5KQMGB2eJACkk=;
        b=WbNcYN6pBIV4f8pzxrV643vCl3XWDttZ0rME/qzAXjCFUAGJ13gHKldea50rYT1pPF
         71S/28nQl+bokNzvT+vQFVhjVLHvqobFjqOEaW26EyBiNijA6vqj6J5oyxWPl1go4ZU1
         wsv2xTMywHWp6kU11xwEc+feXKFAumygdu2vFTrhRdvzHRbZQuGcisDbD0TGxGVmSvXV
         +aqUrT6CaOfOU14YBLwATTZ8AcGHAqWpvtQ+3lDfdDLlDq7z1e9u3bpfSTU2wH7wYT7W
         U7iG2xgIwkXooycqgbrSJYV5n9+7sHj1cPD80p7XayUt+/mpCQh/cinimlIHuvUr9t7E
         gMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdFR5yOnaJKc098kFERNw8BRK74DSY5KQMGB2eJACkk=;
        b=UPbesVHJ2dXpzJrSMkqk4WHRV0r3H8LtOMLvD0BhPGtAwAR2SVm0T9WcnbObi4F1H/
         EjnpJd0j7QTvdp9VuMtGwSP0sJaEhnYiTL7SpDlP5uhiD5QZyHruTyyxfLfXzVBqznMw
         opDauXP3+ZxWWOyRHvMblo6clcrwO+7AajqPjd9Hi4XsB6H0AhaUawuuU03rCSIDb6PO
         ApcEC4JRoS/deHiWCroRNY3+sNjruZn16I8qt7uh+NKujHmRWhRYzRDVeOP53YJg3zOL
         vA4omLCXholoFPwFTDgoO6Y0+Ns2YSElmS+qYxImcPAUICyarkUjh7vmGK9j1ODwkwUD
         tFyw==
X-Gm-Message-State: AJIora+2SA1C3j4xvLwB/KG/EE/J4D/3iRtHSxNGN2bGDPUfo0jR1LVe
        dmVYHkClQwPr713umOityl/LtzcBmgUaxw==
X-Google-Smtp-Source: AGRyM1sah7uOhM9bDuum5zNOsCKaMMUL1YSrwy0LyIPTzgzBSTeDZy5EKnDmhMcFVit80jXqfR3nVw==
X-Received: by 2002:adf:d0c7:0:b0:21d:764b:12d5 with SMTP id z7-20020adfd0c7000000b0021d764b12d5mr28752014wrh.516.1658264737846;
        Tue, 19 Jul 2022 14:05:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
Date:   Tue, 19 Jul 2022 23:05:19 +0200
Message-Id: <patch-05.10-6f474a0f83d-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation added in 956d2e4639b (tests: add a test mode
for SANITIZE=leak, run it in CI, 2021-09-23) for brevity, and to avoid
a merge conflict with another topic, per [1].

1. https://lore.kernel.org/git/220719.86lespun6l.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/README b/t/README
index 4f9981cf5e3..7f409392537 100644
--- a/t/README
+++ b/t/README
@@ -366,12 +366,10 @@ excluded as so much relies on it, but this might change in the future.
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
-GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
-SANITIZE=leak will run only those tests that have whitelisted
-themselves as passing with no memory leaks. Tests can be whitelisted
-by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
-"test-lib.sh" itself at the top of the test script. This test mode is
-used by the "linux-leaks" CI target.
+GIT_TEST_PASSING_SANITIZE_LEAK=true skips those tests that haven't
+declared themselves as leak-free by setting
+"TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
+test mode is used by the "linux-leaks" CI target.
 
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
-- 
2.37.1.1062.g385eac7fccf

