Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912DDC2BD09
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6728A2464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYI5PNRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLFNIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:08:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33969 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfLFNIa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:08:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so7733904wrr.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aSIEo2CTD1Fq9I0+q8CZJbf/EZO+q7zNa6MBn/pl+dI=;
        b=CYI5PNRm5q0Z/jBlkWgKJaZAnG9VduoI9aQzLVOX8QDBzG82A6+41rf9ZaddKMFIL5
         cGm2nvtaSKHFrZ4Vkm3jJNL/yT6VkwU0xwKymaP7jcoG7HdYZ3MlZm+6VJ7M/0Wtbd0B
         hJ84n+foSPlUfw3pb3ubgLqOiZoT13U1C2riSmzkpcHqZtle9tqlAKmV8Aor2t38o0Dx
         OESjfvWlmoLBeXkDPcpsbVLRzykNqm3fRSr3ybEcGrQj810CrebqlrDaHV05hs4RlhPr
         FjyAvGNx4zwEcnMPL7dJUY9WXrEEtIe6914G9BllPhHgl/Is7m0eqrxAIjZ89D9zJzqF
         RZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aSIEo2CTD1Fq9I0+q8CZJbf/EZO+q7zNa6MBn/pl+dI=;
        b=jddR7fDyU4U1ofHkEhal1ZYw2hCRJe5lnOguWHeDf910OU+KB6jLfTEsd4vOjHBzhZ
         pG13ayJN4fJRTqJ5slg615wRPrbx2XvjhCNOt33Fy8bML2rK6unRcGCCJB91Zb8Vxmci
         CSmwQjC+M80XrrP6KPW5efcPQnLoutTFp8Zc2EeZnMMT9JG4cDK9EhQ+9kWW+uY0PWHJ
         7ggLfEdU/pIdPPCW/qsIDDff+imyIULqFNTop9OwtcabfjK99meGenKy/DVUgCl2KWpm
         flrSE8/f2esG7K17bK/RqFCIyzAU+cVRh0gqBHyE6PYlZDPWLxm5TPv7gpdo6gQyrOUp
         f2Jw==
X-Gm-Message-State: APjAAAVb3aEOQ84iTKseKNMqU0HmkRcwGORmVtHDPSXAD08L+2KXn/me
        7vIA7y5AeHiG3jfIVpHaXEM50zhQ
X-Google-Smtp-Source: APXvYqzKsdS/EPLpsWc8mhDweQ2CIsyb3Yq/Ft+ntXNHy8Z+1Ig9GunBFLHwN/Q3ME8HHtQenowtTA==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr15500663wrp.1.1575637707624;
        Fri, 06 Dec 2019 05:08:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm16061398wrx.42.2019.12.06.05.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:08:27 -0800 (PST)
Message-Id: <acfa1614afe1dfdf4bd63057824b3f033691c41d.1575637705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.172.git.1575637705.gitgitgadget@gmail.com>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 13:08:19 +0000
Subject: [PATCH 1/7] t3701: add a test for advanced split-hunk editing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In this developer's workflows, it often happens that a hunk needs to be
edited in a way that adds lines, and sometimes even reduces the number
of context lines.

Let's add a regression test for this.

Note that just like the preceding test case, the new test case is *not*
handled gracefully by the current `git add -p`. It will be handled
correctly by the upcoming built-in `git add -p`, though.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d4f9386621..4da99e27af 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -403,6 +403,28 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
 	! grep "^+31" actual
 '
 
+test_expect_failure 'edit, adding lines to the first hunk' '
+	test_write_lines 10 11 20 30 40 50 51 60 >test &&
+	git reset &&
+	tr _ " " >patch <<-EOF &&
+	@@ -1,5 +1,6 @@
+	_10
+	+11
+	+12
+	_20
+	+21
+	+22
+	_30
+	EOF
+	# test sequence is s(plit), e(dit), n(o)
+	# q n q q is there to make sure we exit at the end.
+	printf "%s\n" s e n   q n q q |
+	EDITOR=./fake_editor.sh git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached >actual &&
+	grep "^+22" actual
+'
+
 test_expect_success 'patch mode ignores unmerged entries' '
 	git reset --hard &&
 	test_commit conflict &&
-- 
gitgitgadget

