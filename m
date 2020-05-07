Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAA2C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC9D20A8B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNM9H9aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGR52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbgEGR52 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 13:57:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D56C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 10:57:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so3134569pgb.7
        for <git@vger.kernel.org>; Thu, 07 May 2020 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xwnl67QyzUDylhWZfa1iIKuTYm0vjWKFmVIC31MFbwE=;
        b=ZNM9H9aBthPmSIvZX65q/hpCC/FnRH9h1342iOFwI2bzShTu9cMjOfc/RTW8WHktmo
         GOwAMh+p9+oWBeFBn04bjF/on/rAsqQxmFERUecvOlBbdd8/jE/n77SHSHlS0MBv5bNm
         IWTMWdaYkTVa7lNpDvLrWj0QKLAEmRfWav3Ziyif5tHEQh8d0FVP/E08Gcmk2Rf9WZcB
         086KLR8o+X+TF1MKXxuuGF7ud0HElaxL4Pdfn+9WbNmV70Ubk5uRWCk8HH+FFRrnlxdC
         5tAW44afJJNtdWk8Y6OmIShk/vyzhl5K7Xy0wroqyP9TZngas962BKcAnQYwIbwvAkTm
         jNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xwnl67QyzUDylhWZfa1iIKuTYm0vjWKFmVIC31MFbwE=;
        b=ofP3VDJXSV/icbWMCJLn6zyfSC7IAQFkC4eSq172ic+kDE3BQCuuwAzyeavCYJiXPB
         bc0yzbH3SA/JRW1OiJn3IopzX3bm29gHFx+WOpHWlUc6l8NmG7nCZ58UpEXiB/M6NQ+1
         EM9+UuBtjMtoEl6//PEEoZVl2SKYckNMmZaOiaYwMvkH//a3NTN32u5KA3gWDN4XzlwN
         HW9f3QtmS2VrY9JuDPUpgqYlHg9xjpNsWC7mBs4TlnDudneyEdUHssFcp7zbQWqe0SxA
         /k78NNMtbJd8RxFvG6LO5OP3A7iPLdo2kqnvPTpEA4tDoVYVtg3Q2t+UcL6IvBRfdcMA
         Ljbw==
X-Gm-Message-State: AGi0PuYabR2Dq2gGKeC0cCC/OQ35hinbk9A+ZLTJ7DN6fPrW3Czg3occ
        +ODlMSg95jzI7wv3m3m7qWQFYikW
X-Google-Smtp-Source: APiQypI4AKfZEb7/jkrcsO4CbYI/Xog/CtEfsVYF5q3i6mr5ERsfXlIDzv0Moatc4Xa3S0Nr0U8FzQ==
X-Received: by 2002:a63:7b15:: with SMTP id w21mr9848780pgc.228.1588874247424;
        Thu, 07 May 2020 10:57:27 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id r31sm4279312pgl.86.2020.05.07.10.57.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 10:57:26 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] t/test_lib: avoid naked bash arrays in file_lineno
Date:   Thu,  7 May 2020 10:57:06 -0700
Message-Id: <20200507175706.19986-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.717.g5cccb0e1a8
In-Reply-To: <20200507055118.69971-1-carenas@gmail.com>
References: <20200507055118.69971-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

662f9cf154 (tests: when run in Bash, annotate test failures with file
name/line number, 2020-04-11), introduces a way to report the location
(file:lineno) of a failed test case by traversing the bash callstack.

The implementation requires bash and uses shell arrays and is therefore
protected by a guard but NetBSD sh will still have to parse the function
and therefore will result in:

  ** t0000-basic.sh ***
  ./test-lib.sh: 681: Syntax error: Bad substitution

Enclose the bash specific code inside an eval to avoid parsing errors in
the same way than 5826b7b595 (test-lib: check Bash version for '-x'
without using shell arrays, 2019-01-03)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/test-lib.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b221951a8..baf94546da 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -677,14 +677,16 @@ die () {
 
 file_lineno () {
 	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
-	local i
-	for i in ${!BASH_SOURCE[*]}
-	do
-		case $i,"${BASH_SOURCE[$i]##*/}" in
-		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
-		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
-		esac
-	done
+	eval '
+		local i
+		for i in ${!BASH_SOURCE[*]}
+		do
+			case $i,"${BASH_SOURCE[$i]##*/}" in
+			0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
+			*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
+			esac
+		done
+	'
 }
 
 GIT_EXIT_OK=
-- 
2.26.2.717.g5cccb0e1a8

