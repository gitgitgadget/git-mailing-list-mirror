Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D8C433E5
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12312087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAab/D0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgH0PqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgH0PqE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:46:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D4C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so2831939pjb.4
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j00PBW8/sj1jQwd+ZwXvDPb4U2F+1mYOJi2Dqj5xEQw=;
        b=dAab/D0PzcxHxGLynKhHng7l9PE+i/c5J/n7YwzbsJj4Phvp2mDkkgSvZFIsPCANrI
         35ig+LzdM0uHeWHR433vNWlzAEMPAHvF5YuYCL/4N839NxE/YTsyMwNnHqCC4RrL+Lh+
         5jBCmnVPmsrvV9F5NxHm2xlR51/ZNYZQ+dWtTmo6qLWgl3LRCUq/1mPWoNgzJkUYOAMv
         wyTTnxtw4zhI119WOrDJpeFBsOoGo/bvzMO+be1a7DSNT/sLFHV/u7F7gKqO4xqdpcNO
         Y+xHt4vGO9UpODHjAdsSAL88OmgBCJJ0HyrMT9KOgrWlBDtmGLiUX/USLbs+p6SaZG6N
         0J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j00PBW8/sj1jQwd+ZwXvDPb4U2F+1mYOJi2Dqj5xEQw=;
        b=GSwMpnUXdBJRgWcPYF+SGJUuUoqnkk9NZLDOlP/hG3mPhKi+H0t9jpbBJgJqayxDLx
         7lZpQf7wDs76PDjMwn2D5ImU/cHtGvOE3O78/A1lh8W8T4Q2+NesPcPvSqvuhb1aG5xD
         6uD0TBCPvcl0o7zeuo3j4spG1lIgiDsVhuEEuRISjx+QgKp65n3Q1TzV3aLmJJstK4RP
         CS+ZTnQ4V+EUJnMwvoJta27sU9BGKwoopWPUylJdLQe4jL4odJrYlKSoYxVDhEPi9ufZ
         hTYHvilmL6GHdEu4vJlU4NwmlEFUj02p1qk8WwUOi8dbZSWIATrHEh9F04kQQGK16h7s
         EqZg==
X-Gm-Message-State: AOAM532YV9ckDoDLZOwQQ187P6E9b/pnSRgm0/9BZX/PSC0R5VuJYVA+
        ip0BzmFRhBgeOB/NMUXw5OjUlJEARJIWeA==
X-Google-Smtp-Source: ABdhPJyOLljFXGCc5ZjL0mxLnKabSpxgPcOnA+b45scgzdtyb/VDpY9pDxyQLpJVOqP+Ox3KgapKyA==
X-Received: by 2002:a17:90a:b103:: with SMTP id z3mr11479602pjq.78.1598543163973;
        Thu, 27 Aug 2020 08:46:03 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x5sm3129218pfj.1.2020.08.27.08.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:46:03 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v19 08/10] t5411: test updates of remote-tracking branches
Date:   Thu, 27 Aug 2020 11:45:49 -0400
Message-Id: <20200827154551.5966-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200824174202.11710-1-worldhello.net@gmail.com>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In order to test update of remote-tracking branches for special refs,
add new "remote.origin.fetch" settings and test cases.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 27d58edd14..8eec3a1ed8 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -1,3 +1,18 @@
+test_expect_success "setup git config for remote-tracking of special refs" '
+	(
+		cd workbench &&
+		if ! git config --get-all remote.origin.fetch | grep refs/for/
+		then
+			git config --add remote.origin.fetch \
+				"+refs/for/*:refs/t/for/*" &&
+			git config --add remote.origin.fetch \
+				"+refs/pull/*:refs/t/pull/*" &&
+			git config --add remote.origin.fetch \
+				"+refs/changes/*:refs/t/changes/*"
+		fi
+	)
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -58,6 +73,17 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	test_cmp expect actual
 '
 
+test_expect_success "proc-receive: check remote-tracking #1 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -120,6 +146,17 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	test_cmp expect actual
 '
 
+test_expect_success "proc-receive: check remote-tracking #2 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -167,3 +204,14 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	EOF
 	test_cmp expect actual
 '
+
+test_expect_success "proc-receive: check remote-tracking #3 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
-- 
2.26.2.543.g44b58e439b

