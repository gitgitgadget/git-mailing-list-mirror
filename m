Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9171C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjBUVaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBUVaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:30:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674B11644
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:30:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s5so6482292plg.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DnJVS/msx9n1mG5wF/VTp4VhvTV/wnRa34wTOFb/bg=;
        b=B3YBGgosnupc+fI5VqHYFSr3Up2shPTaAksYExCv1X5Lc30YhwRuYXOmjObNDRBZnd
         OE08sfYeLoDiSYRcFGeq2HFeHzOu0/bfvveJNwY9m7LTWHxf0/sLVl1owXrxQlZlv1oL
         dl3a7ruZMew3/WaBgbLSeuoYjnee93Jbufv44bJtyJYHcWMGwesmBVAbWSkwrxuxBQEu
         eqCe7R/wMk3cr10/9sXtDAq1rTHIJiP2THRW1xrXIeRENuBPU0z5ZjQOQyK9YHN6BwJ3
         tVcG3f+yvIVqA6tAnAthvhl155LPCGrbkmLstmb5iO0ZDlBcQJwByuulrbvpNITLT3Qj
         11vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DnJVS/msx9n1mG5wF/VTp4VhvTV/wnRa34wTOFb/bg=;
        b=wSAdcdjSBSQmOVOIUHMUol14TEIZCtgHEk51YrMIkHuzeRLtx9LL/Umq2V0/FnCRaJ
         0v+5ct9YPj1ijKxOKI0jSHQQ/EC4gWsT7uOuPjKv6wRQb3f7oBjAoynSHKNqUJvjNUni
         K2exKU/ONFZ1i1R9fRRk/vwACWKYTc52xSOL6KLLrVM4r2P8WSCbJfRU385SNUQvyCyo
         rThbWX8ooRbYSpYwCQfI7ge2alsBFT7opVL5Ckz7cUm7rRxWeFrLIaLC1fMEApiW/IcZ
         875wLTGMxVvsH1aqKwz4o+mC8YO8OofjukIry391f/FZRV1Nvao4PidWUSLzxUvXSsyb
         WFMA==
X-Gm-Message-State: AO0yUKWnNxmouQNLTMJknfrd0fOHbT2/NlWfz82EN0zfmBWj/Q/JzJ9T
        Tpqj6FUn7hPGPAvmsSsVlXXacUoMxvRTDQ==
X-Google-Smtp-Source: AK7set9/xc1HGRo3zpR3kkvXatcmhb2lk/ces1tACoEZJGkeznGH7ApudS1HbTCmt6pFoabIYWq36A==
X-Received: by 2002:a05:6a20:69a3:b0:cb:af96:ace7 with SMTP id t35-20020a056a2069a300b000cbaf96ace7mr1935163pzk.46.1677015004893;
        Tue, 21 Feb 2023 13:30:04 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dg56d59ey2wgev.ipv6.telus.net. [2001:56a:740f:7b00:548b:6839:29d0:4517])
        by smtp.gmail.com with ESMTPSA id n24-20020aa79058000000b00592591d1634sm3637086pfo.97.2023.02.21.13.30.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Feb 2023 13:30:04 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [GSOC][PATCH v2 1/1] t4121: modernize test style
Date:   Tue, 21 Feb 2023 14:27:53 -0700
Message-Id: <20230221212753.85371-2-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230221212753.85371-1-gvivan6@gmail.com>
References: <xmqq8rgqeplt.fsf@gitster.g>
 <20230221212753.85371-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test scripts in file t4121-apply-diffs.sh are written in old style,
where the test_expect_success command and test title are written on
separate lines, therefore update the tests to adhere to the new
style.

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
 t/t4121-apply-diffs.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index a80cec9d11..f1cc42ff71 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -16,8 +16,8 @@ echo '1
 7
 8' >file
 
-test_expect_success 'setup' \
-	'git add file &&
+test_expect_success 'setup' '
+	git add file &&
 	git commit -q -m 1 &&
 	git checkout -b test &&
 	mv file file.tmp &&
@@ -27,10 +27,11 @@ test_expect_success 'setup' \
 	git commit -a -q -m 2 &&
 	echo 9 >>file &&
 	git commit -a -q -m 3 &&
-	git checkout main'
+	git checkout main
+'
 
-test_expect_success \
-	'check if contextually independent diffs for the same file apply' \
-	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
+test_expect_success 'check if contextually independent diffs for the same file apply' '
+	( git diff test~2 test~1 && git diff test~1 test~0 ) | git apply
+'
 
 test_done
-- 
2.37.0 (Apple Git-136)

