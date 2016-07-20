Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20C62202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbcGTRZI (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 13:25:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33572 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbcGTRZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 13:25:00 -0400
Received: by mail-lf0-f65.google.com with SMTP id f93so4003630lfi.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 10:24:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeRo4RZPyqfuY/vObNGAg/1VeQoHtfvA+JrTz9oNSFw=;
        b=ymp7gtYjoVbFm+pXPGrCPPiJBWOJTqzWFB66h0Pn2fDr6YwP7kiPaEmmgUP1HuOwEk
         5QsvvS5nisF9FpAROJX6wXKr8wS503mor3qOFKzlycX26IZKLby5hVLWmOtus4z0OfNF
         mCkivaUoRd+4+5YCH99ED3JwW3sX9fmgQT97h7KxP06DtN+4mrtEnoaogsiBV1AvM9lO
         XcCEIwGxzCB/bHDEPGyh4y+7diUYvMYOjP5vYM4MpUGiTeZjmR2TKS+K1g2mmgwyLqV9
         +U7o5chsLZHnHb6we9F2rqIa4Jn9QEAdq3WNdIvf0TchEwzCFjB3dMx3dsDPqdEJKa+X
         378w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeRo4RZPyqfuY/vObNGAg/1VeQoHtfvA+JrTz9oNSFw=;
        b=Z8DD3crK/nR2RxVWnfUO+ni1dzd+xeBmXGkjrY+08Ps8Vg+V/xXBS5XSg7NxtcaXxd
         5BWTGP/ZpWb2iAoZLj+9X78B3VfVXF3Hxtl/q1hvfGCx3KCsRBZgwyKJgfsISx2kihxE
         SXPSvOJqUdOQOzyeXhcJP7S8a6CrHnJcv6OcxZA/GIiytwJYMB6HpO+reBw5dJGuDS7R
         WddanAZfZaRBzG/23OJa/IlRSdv/Ep1dvZhir5Cumna5oTWK1nekVxm8y0FCm1SFUQVu
         wZnfDfSpoaQJbCGzf2tGMTw0pnS3P7sVl6tjMBYPePzbZyl7e6Uz9jXztuq/dPAG6rjK
         CsEw==
X-Gm-Message-State: ALyK8tKTSwzH/+mKAivLBP6ILyrLczoPDIVPKZd6HqQFCY82+NY3RkI88rkyFXZ27IZ3Zw==
X-Received: by 10.25.210.80 with SMTP id j77mr11735389lfg.139.1469035498122;
        Wed, 20 Jul 2016 10:24:58 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g74sm777884ljg.24.2016.07.20.10.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 10:24:57 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	max@max630.net, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	larsxschneider@gmail.com, sbeller@google.com, mhagger@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/4] t2029: some really basic tests for submodules in multi worktree
Date:	Wed, 20 Jul 2016 19:24:19 +0200
Message-Id: <20160720172419.25473-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160720172419.25473-1-pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2029-worktree-submodule.sh (new +x) | 166 +++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100755 t/t2029-worktree-submodule.sh

diff --git a/t/t2029-worktree-submodule.sh b/t/t2029-worktree-submodule.sh
new file mode 100755
index 0000000..f96fa50
--- /dev/null
+++ b/t/t2029-worktree-submodule.sh
@@ -0,0 +1,166 @@
+#!/bin/sh
+
+test_description='submodule with multiple worktrees'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git config extensions.worktreeConfig true &&
+	>t &&
+	git add t &&
+	git commit -m initial &&
+	git branch initial
+'
+
+test_expect_success 'setup - repository in init subdirectory' '
+	mkdir init &&
+	(
+		cd init &&
+		git init &&
+		git config extensions.worktreeConfig true &&
+		echo a >a &&
+		git add a &&
+		git commit -m "submodule commit 1" &&
+		git tag -a -m "rev-1" rev-1
+	)
+'
+
+test_expect_success 'setup - commit with gitlink' '
+	echo a >a &&
+	echo z >z &&
+	git add a init z &&
+	git commit -m "super commit 1"
+'
+
+test_expect_success 'setup - hide init subdirectory' '
+	mv init .subrepo
+'
+
+test_expect_success 'setup - repository to add submodules to' '
+	git init addtest &&
+	git -C addtest config extensions.worktreeConfig true &&
+	git init addtest-ignore &&
+	git -C addtest-ignore config extensions.worktreeConfig true
+'
+
+# The 'submodule add' tests need some repository to add as a submodule.
+# The trash directory is a good one as any. We need to canonicalize
+# the name, though, as some tests compare it to the absolute path git
+# generates, which will expand symbolic links.
+submodurl=$(pwd -P)
+
+listbranches() {
+	git for-each-ref --format='%(refname)' 'refs/heads/*'
+}
+
+inspect() {
+	dir=$1 &&
+	dotdot="${2:-..}" &&
+
+	(
+		cd "$dir" &&
+		listbranches >"$dotdot/heads" &&
+		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
+		git rev-parse HEAD >"$dotdot/head-sha1" &&
+		git update-index --refresh &&
+		git diff-files --exit-code &&
+		git clean -n -d -x >"$dotdot/untracked"
+	)
+}
+
+test_expect_success 'submodule add' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
+	(
+		cd addtest &&
+		git submodule add -q "$submodurl" submod >actual &&
+		test_must_be_empty actual &&
+		echo "gitdir: ../.git/modules/submod" >expect &&
+		test_cmp expect submod/.git &&
+		(
+			cd submod &&
+			git config core.worktree >actual &&
+			echo "../../../submod" >expect &&
+			test_cmp expect actual &&
+			rm -f actual expect
+		) &&
+		git submodule init
+	) &&
+
+	rm -f heads head untracked &&
+	inspect addtest/submod ../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
+'
+
+test_expect_success 'submodule.* in supermodule is per-worktree' '
+	(
+		cd addtest &&
+		git config -f .git/config.worktree submodule.submod.url >actual &&
+		echo "$submodurl" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'turn submodule to multiworktree' '
+	(
+		cd addtest/.git/modules/submod &&
+		CORE_WT="$(git config core.worktree)" &&
+		git config -f config.worktree core.worktree "$CORE_WT" &&
+		git config --unset core.worktree &&
+		git config extensions.worktreeConfig true &&
+		git config core.worktree >actual &&
+		echo "$CORE_WT" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'new worktree in submodule' '
+	(
+		cd addtest/submod &&
+		git worktree add submod-elsewhere &&
+		cd submod-elsewhere &&
+		test_must_fail git config core.worktree
+	)
+'
+
+test_expect_success 'new worktree in supermodule' '
+	(
+		cd addtest &&
+		git commit -m initial &&
+		git worktree add super-elsewhere &&
+		cd super-elsewhere &&
+		test_must_fail git config submodule.submode
+	)
+'
+
+test_expect_success 'submodule add in the second worktree' '
+	(
+		cd addtest/super-elsewhere &&
+		git submodule add -q "$submodurl" submod2 >actual &&
+		test_must_be_empty actual &&
+		echo "gitdir: ../../.git/worktrees/super-elsewhere/modules/submod2" >expect &&
+		test_cmp expect submod2/.git &&
+		(
+			cd submod2 &&
+			git config core.worktree >actual &&
+			echo "../../../../../super-elsewhere/submod2" >expect &&
+			test_cmp expect actual &&
+			rm -f actual expect
+		) &&
+		git submodule init
+	)
+'
+
+test_expect_success 'submodule.* in supermodule is per-worktree' '
+	(
+		cd addtest/super-elsewhere &&
+		git config -f ../.git/worktrees/super-elsewhere/config.worktree submodule.submod2.url >actual &&
+		echo "$submodurl" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.9.1.566.gbd532d4

