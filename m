Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E81CC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0E420719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 12:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHV0tMYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgCWMoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:44:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45912 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCWMoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 08:44:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id u59so15969069edc.12
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rFblwr4T6Gnep2kHEfF1fDGo6InjSmoFKCwE2tOJXko=;
        b=JHV0tMYHpjIFQXm3wD7Od5YM+i+vUf6CDiKz5reyzv28dkjJo10oE7noPmZ5MOBAHK
         l+7uja+V7bo/l4v6jcuCqRqmG8S5q4BA6b4hha67qzVpoKPqqqiSD8FZoQ6jsMC1cJGh
         jaxaUd+UIG/3zCwEArbEDVEszXIcM8AeZBtcl5yjXJ9Qp7HVICp/F29XgHsvGNOd4bWT
         Yxqegw95xFzqXwceRWgn/KtReRaJG4wd57X8F/wdAtYCBL0u/baniPNrRSQYWCMgz0QM
         myJhRhKfgUYRyGLzkFcw1X3dFQixz6Q2Ubm+iJcZK/d9gb2DSiIsP4SymFlqUmrh876G
         rIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rFblwr4T6Gnep2kHEfF1fDGo6InjSmoFKCwE2tOJXko=;
        b=l5DDYIDfqPCy8dIBkYE3ctbIJGguWvdreLj/L4tEluUD8nFTRICIRNkIl+RMD5BJuk
         Kc1w3Wi0tXr9X5sWUoMjmEVoiW7ENdSGJx/6RJg2pZGn8rrJ2lSUCT5Kb3cFEY8keXCr
         ySen2rGBlgwNsHHuARn3Y7xgzmKMgMtlT5xfJssQRKSP7PjuqhjnV+a3vEM8D1Yebjgs
         EpKMJt6xUBjAmCLvjfylC/EDHP/LXDGBVUhtgIIyU8/ReeCY6mEMQKAKqSwTEt95v5Mx
         +lJi1/IOuBtuCEqoPO30wiLgBMVH6jYC+V5jDy1IBkCzjuKzsVAm49tFcTqBtafV3n/+
         8TCA==
X-Gm-Message-State: ANhLgQ1h2H6mr808fiKzexdSPFnOFyc8WKXmgi4EKL3nm8/0S4lYbshG
        N9LGDjoZ/2xA4TYzokiR/v3FWCNk
X-Google-Smtp-Source: ADFU+vv3WoFCo8oi9q4KlAhD38E5zHoi8exGLNgIiUbJ1lZV1qnoV2Ne4ih57DjoRpbPGkjRbfx3dw==
X-Received: by 2002:a50:c20a:: with SMTP id n10mr17779245edf.319.1584967476710;
        Mon, 23 Mar 2020 05:44:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g27sm852179ejd.69.2020.03.23.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 05:44:36 -0700 (PDT)
Message-Id: <pull.732.git.git.1584967475669.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Mar 2020 12:44:35 +0000
Subject: [PATCH] tests(junit-xml): avoid invalid XML
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a test case is run in a subshell, we finalize the JUnit-style XML
when said subshell exits. But then we continue to write into that XML as
if nothing had happened.

This leads to Azure Pipelines' Publish Test Results task complaining:

	Failed to read /home/vsts/work/1/s/t/out/TEST-t0000-basic.xml.
	Error : Unexpected end tag. Line 110, position 5.

And indeed, the resulting XML is incorrect.

Let's "re-open" the XML in such a case, i.e. remove the previously added
closing tags.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix Azure Pipelines for t0000
    
    When running t0000 in our Azure Pipeline, the "Publish Test Results"
    step complains about an invalid JUnit-style XML, and it is correct.
    Let's fix that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-732%2Fdscho%2Fci-xml-error-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-732/dscho/ci-xml-error-v1
Pull-Request: https://github.com/git/git/pull/732

 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05ed..7f0c02c016b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1085,6 +1085,7 @@ finalize_junit_xml () {
 		junit_time=$(test-tool date getnanos $junit_suite_start)
 		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
 			-e "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
+			-e '/^ *<\/testsuite/d' \
 			<"$junit_xml_path" >"$junit_xml_path.new"
 		mv "$junit_xml_path.new" "$junit_xml_path"
 

base-commit: be8661a3286c67a5d4088f4226cbd7f8b76544b0
-- 
gitgitgadget
