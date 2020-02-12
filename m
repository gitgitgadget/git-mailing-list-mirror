Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D8C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 11:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD19206D7
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 11:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LucI3/T1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgBLL2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:28:00 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36782 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgBLL17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 06:27:59 -0500
Received: by mail-wr1-f41.google.com with SMTP id z3so1833182wru.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MtpR2nxgyE1feWxzLJ5KQz+9+nAw6qvZ/x2yu8CjiQ8=;
        b=LucI3/T1CuojqPIX9CcvKGjMbwwmkt6QKw4ardiiqbqfiqZ3+Cq/G336cpPRbk8tvb
         8acpHkY/1+4hw8hE3j70dPB8E2d5qSq+VMsRHgkhlkFAniQDIvrDiM3ZVj5hRiZu7aEo
         8J2N4Z6+2GkneJatFeI+VloFt7p1/oSfZXtnotgWM/e/Q/i81htxmWIgkqXBk8umkP8O
         HtAuwHeWptRzQVOFGhhxRG7DkiSS+1sPJ/0gJ/cK3L2qXFAw+BXzWyZHlVyxpLafPY2C
         MhvOOMf2+20Mh6jDWRCkXaBuBTO3vzg4yANB80FOZQBAoVSPT2l3J8R2Io4K0sJMkIKx
         7JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MtpR2nxgyE1feWxzLJ5KQz+9+nAw6qvZ/x2yu8CjiQ8=;
        b=JrxXDVLaUtGlN5rrHB+mRcKzCXmufFmrQOuRTfpneuz290l6mcQNYTcrnRdk/rBw6o
         A4JdwtuTlGJgSag1fey45ZdIedsiYMlzUDJewMhJ8dpdMQya9SQ6LmJ40D7UWVDx+zWl
         K0XB0wcfsTi4s3kmdzAcd3jD1pscg80pB9Xvj2fOoyy7tMXsNGhgTgUepucf6FDltfLl
         uhUkzxkCMeIYfckJhjgOrHheleDaQZ6Hm/aX3snvkTOipPHX+JAetUQMQfqBW5JxTssL
         vA2V5u5Y00oFo5TwQWwAru194s7ulUvADJS5iKia66+w+wTfXkYWZXejKIPeKC8fnn5m
         SsWg==
X-Gm-Message-State: APjAAAWJPgV8jJPg/I8xtl8zDPWpi5dkcIu3Ct4ryb15V6KilxfTMxPp
        Y8m9GDaP+gN2Rt9nrdMGAXYlt5ca
X-Google-Smtp-Source: APXvYqz4duGNdgOX+Runj4INrUli52UOcmiFU+mIYznEJesgPa4l6Lb6MgSZrN2z4MJ5NwSumfxGfA==
X-Received: by 2002:adf:fa08:: with SMTP id m8mr14667386wrr.366.1581506877442;
        Wed, 12 Feb 2020 03:27:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v22sm345869wml.11.2020.02.12.03.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 03:27:56 -0800 (PST)
Message-Id: <pull.552.git.1581506876000.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Feb 2020 11:27:55 +0000
Subject: [PATCH] tests: fix --write-junit-xml with subshells
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

In t0000, more precisely in its `test_bool_env` test case, there are two
subshells that are supposed to fail. To be even _more_ precise, they
fail by calling the `error` function, and that is okay, because it is in
a subshell, and it is expected that those two subshell invocations fail.

However, the `error` function also tries to finalize the JUnit XML (if
that XML was asked for, via `--write-junit-xml`. As a consequence, the
XML is edited to add a `time` attribute for the `testsuite` tag. And
since there are two expected `error` calls in addition to the final
`test_done`, the `finalize_junit_xml` function is called three times and
naturally the `time` attribute is added _three times_.

Azure Pipelines is not happy with that, complaining thusly:

 ##[warning]Failed to read D:\a\1\s\t\out\TEST-t0000-basic.xml. Error : 'time' is a duplicate attribute name. Line 2, position 82..

One possible way to address this would be to unset `write_junit_xml` in
the `test_bool_env` test case.

But that would be fragile, as other `error` calls in subshells could be
introduced.

So let's just modify `finalize_junit_xml` to remove any `time` attribute
before adding the authoritative one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix a warning in the Azure Pipelines runs
    
    Yet another thing I stumbled across...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-552%2Fdscho%2Fwrite-junit-xml-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-552/dscho/write-junit-xml-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/552

 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 44df51be8f..0ea1e5a05e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1083,7 +1083,8 @@ finalize_junit_xml () {
 
 		# adjust the overall time
 		junit_time=$(test-tool date getnanos $junit_suite_start)
-		sed "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
+		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
+			-e "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
 			<"$junit_xml_path" >"$junit_xml_path.new"
 		mv "$junit_xml_path.new" "$junit_xml_path"
 

base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
-- 
gitgitgadget
