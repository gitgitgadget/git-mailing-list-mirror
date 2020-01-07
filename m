Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC3C3F68F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3092E207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exZfRakb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgAGExo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46296 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgAGExm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id g1so4022249qtr.13
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgaLyiQkjXbO+vBVUmE3syCbCvisT6JTQ0XXXX2DoVk=;
        b=exZfRakb8I54+yZJVdP0s/n2dvc0jcxeNyPxNa7FEUvt9r7lR5fLXobqbPV5XUVF7W
         zkwEwz6FhNS8J4geTLon+GPShsVFbLN+ECAG53oDQd9VAkoAKTQ8HkDOA0NGtvcNNwTw
         hjPjid2GYlqMrnXxTJZSKakB0IVpbCLZgjBMxM8v7FNtg7peI+AXjbjAGA1XNTVv+LMk
         63mI3CBAWT+Eb/kxU3NGgg23Vn5bHb/vrzYc6vvAKVkdrjNDvcNKdVmCrLr71C3TsA2a
         ZFwso2vk2S8ZRSdhqjUSUCTB4KtiGSYLJ9d6xmF2KHE9HBVIO2rljJPzZVm4rPs8jGN8
         tVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgaLyiQkjXbO+vBVUmE3syCbCvisT6JTQ0XXXX2DoVk=;
        b=LtWF4VvkBcRjGih5GZIYD3QYjtdeNFuYwetPh8U9M8FuJPWNZDOUGRD3B7tWMk/Ktl
         ZtKJMnJ3/Ulpp7o2JWva5qnVQhdhbTBoSBTOEzBmIO50S6BPuyzYG9jPefuWRO0umOzl
         f+eJNU3bB1s4l//xxBxUoEMRRdl4BEC59yhfQPxnPhRQzfWtN1B3BeqWGSHfLwbUBg5e
         +twbOTBhjEEXINHjmydOYT+mnMD694xW7vk9F6AawSg69h9/WVG4OQdQ8OJa3WQMvQCy
         LafjNCY+wN31ahtezNR4wFZ5WVqdJyHMDOnIUgZ7wkF4XOBfL4+1Bwkx9EBhC5yImuc2
         ZjRA==
X-Gm-Message-State: APjAAAXqAqc9H9aFg0DT3I0efdCHY/1II+dVrHpWQuALuBKYuh3Di1RE
        Jd/r58HVxtGIYx+ZBWrEhWs/LG0W
X-Google-Smtp-Source: APXvYqxHl5cobnL7nvb0BwjXDSHQfAfZ0WTT4yDqkguU2VgDPfw4STyETAhqaeSRGqEtpgefI846Ew==
X-Received: by 2002:ac8:5548:: with SMTP id o8mr79933912qtr.338.1578372821502;
        Mon, 06 Jan 2020 20:53:41 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:41 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/16] t4124: only mark git command with test_must_fail
Date:   Mon,  6 Jan 2020 23:53:13 -0500
Message-Id: <b93ebc0e42dd145699c68587f4954775efbfa86d.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since apply_patch
wraps a sed and git invocation, rewrite it to accept an `!` argument
which would cause only the git command to be prefixed with
`test_must_fail`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4124-apply-ws-rule.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ff51e9e789..971a5a7512 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -35,9 +35,15 @@ prepare_test_file () {
 }
 
 apply_patch () {
+	cmd_prefix= &&
+	if test "x$1" = 'x!'
+	then
+		cmd_prefix=test_must_fail &&
+		shift
+	fi &&
 	>target &&
 	sed -e "s|\([ab]\)/file|\1/target|" <patch |
-	git apply "$@"
+	$cmd_prefix git apply "$@"
 }
 
 test_fix () {
@@ -99,7 +105,7 @@ test_expect_success 'whitespace=warn, default rule' '
 
 test_expect_success 'whitespace=error-all, default rule' '
 
-	test_must_fail apply_patch --whitespace=error-all &&
+	apply_patch ! --whitespace=error-all &&
 	test_must_be_empty target
 
 '
-- 
2.25.0.rc1.180.g49a268d3eb

