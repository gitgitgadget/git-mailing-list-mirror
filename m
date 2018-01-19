Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3731F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeASRel (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:34:41 -0500
Received: from sonic309.consmr.mail.bf2.yahoo.com ([74.6.129.253]:44157 "EHLO
        sonic309-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932543AbeASReZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 12:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516383264; bh=KNSsBMmN5wZUzrwYmuXrjDHcnqQ9al+Hz2kOor8Sh38=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Kh3kd1bMZCL45kfARlXBufHUnhTX9Als5eKd7muEa4RXAoDR7HcIq/2p/Enabtd0XvYxZKD2BRhzI1EKkFeyrXljYkgmBU77VbYDqC0gdPOd+ncuKwUwNXgbQmMkJp5XVfBCEqdo3tN25BQIKXnlzdll/XUbD1ylrvOdYKZOmiVyzgWbsJ+eDfBEwcYM1Tz4DyTS8IiktyhcisdoevEkvkJ7IhBm2iyL7I3dqTJQppwWQGCSrOwvAFnIhBCFOstsC6+6tVnRiwpzUEf9npmizqFt5BrUG4rkeO3TYuhdQtLX4v0EqkoPg971laGVC85a1k25dgoim9VbtaSzh2sbww==
X-YMail-OSG: a1CvbG8VM1myuwf8s5anpTalmRleQwm6Ht80W984dKytzToJ7uEVkPPi68a.Jjp
 5EEXlZ3QyyaZcY7OityB90k0t7R7hUXq_TbygD3Ykkoc6ruU1uNK8bgZ1dzMvbSjiwOfPDPf4Z8Q
 5naS.RxQenzc1z8RvFJnznnK2ZCLgCa4JSiDAwQ5QC2WjFKnFrixDOvS_Ppnw.SuwcJ060iQXB3B
 k9dlLJBN9T9QYRsYMxWOldxV7so3avb0LP_QS7OH7WrKpiwkX9sJZNcWb2KfaramLhvqOeMDMot.
 HPzw5hc77_O_I4V2agLg6l4uGBurS8a1_V8uEfxu9duz0pvQqMCdlddWNKgnQCBq57Xwge816K4R
 EAd10KiOCBp9piBUz5kLs.Ml2wFQkD2aNtioAo4cVLdjsEpuOsZ34ZsMNkE7RWrk_2NGWuvmw4PB
 1cgqIlDbdXz0_Q07Zqgvs2SyOcZ7FVTf9L0l7vbtAH0Qiqn7hsR033LqPFfZroto69uB8oR8nPNw
 cD5C9HnTtffBOERHPMjs4jDahWwUlJeGZIYoG0Gy9YFGL2Ix2zQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jan 2018 17:34:24 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp406.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID e78d06b6c08cf8709c5b5470ad5cf24d;
          Fri, 19 Jan 2018 17:34:20 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 6/6] Add intptr_t and uintptr_t to regcomp.c for NonStop platform.
Date:   Fri, 19 Jan 2018 12:34:06 -0500
Message-Id: <20180119173406.13324-8-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* compat/regex/regcomp.c: fix missing intptr_t on NonStop. This is
  done because git-compat-util.h cannot be cleanly included into
  this file without additional compile errors.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 compat/regex/regcomp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 51cd60baa..8bb4c966d 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -17,6 +17,14 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#if defined __TANDEM
+/* This is currently duplicated from git-compat-utils.h */
+#ifdef NO_INTPTR_T
+typedef long intptr_t;
+typedef unsigned long uintptr_t;
+#endif
+#endif
+
 static reg_errcode_t re_compile_internal (regex_t *preg, const char * pattern,
 					  size_t length, reg_syntax_t syntax);
 static void re_compile_fastmap_iter (regex_t *bufp,
-- 
2.16.0.31.gf1a482c

