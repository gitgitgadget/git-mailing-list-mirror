Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE3B1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 23:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbcLOXX3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 18:23:29 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35094 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbcLOXX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 18:23:28 -0500
Received: by mail-pf0-f196.google.com with SMTP id i88so3403599pfk.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 15:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qj0m8lHg5GDipXEVk4aiykBYKrqdukXmJrZWcRGOKF4=;
        b=rxDTxBCXH/AgiiBq7aOShUCoTe0Tc4zFkpJspKZQ7kAS77zXE0ZNvZ2hmNVZAUfXQf
         lZJ0cIPLoEpPbl5fn3kC0GVL9T086b63pgLr9V8CBqM5Fbgof4EOmvBbXzZozwgvMUYu
         wowb5M1V+6CvWSiiUgQf1FiRdxmpeZREsQXiQIYNw5JE/q29U6p5IWa175widlcJXNzb
         m4af+wYbWy11ZLREX03X9vlzzRTxG2BXDUzWFyPOIr845YG2KiJwYvlPE4VsiuotW/35
         SuqShA1Cnb7vTtj/Jsc6J81awr6AHmfCjv3KTRlk/Yv7bN87WmJcw7uL+Z2Pgxgo0/Ci
         b2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qj0m8lHg5GDipXEVk4aiykBYKrqdukXmJrZWcRGOKF4=;
        b=WwUvgZI3k3GHzILZ5GYV2go9x31BEgA5kgbl821MuRkcmUShiokbSRwMDP9NLuyiHz
         N78tLz6hmo0wHM7vWILmBgqOvSr1NLAoTJNYwy0OrGzwfse//u+QduKfgt/5acE51pqM
         WygjebZa91j+d4dt7rf/0oTiB4rGLnD/dPsOhnxIJIOvM3gI9J3P9PMmJuMdu+14SnAT
         II0VSFfHCvITZcEucypJFF0Ri1P4FPPnuV9e2Elh7rp0ErIA/U2LNF7ymgXUsDkXxoMs
         WIwmw5zkOk/KI4ozXDtm4id6dt+t+paM+yNi1/Ezaj1jeI0271k45wiMp5DuLSliCUTT
         iQlA==
X-Gm-Message-State: AKaTC00vK/HVhDNrzT/yoxqJ+/L/tSPpgNCUIXS6jS0EOevdH4+uYBq/thT8yf6j5kMB9w==
X-Received: by 10.99.241.21 with SMTP id f21mr45800pgi.110.1481844173066;
        Thu, 15 Dec 2016 15:22:53 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:7813:421d:54a0:9bca])
        by smtp.gmail.com with ESMTPSA id 186sm6842506pfv.61.2016.12.15.15.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Dec 2016 15:22:52 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, stefan.naewe@atlas-elektronik.com,
        gitter.spiros@gmail.com, Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCH] Makefile: suppress some cppcheck false-positives
Date:   Fri, 16 Dec 2016 12:22:40 +1300
Message-Id: <20161215232240.19427-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0.24.ge6920cf
In-Reply-To: <20161214112401.mq3n5kui5eeebdtk@sigill.intra.peff.net>
References: <20161214112401.mq3n5kui5eeebdtk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass a list of suppressions to cppcheck so that legitimate errors are
more obvious.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

On Thu, Dec 15, 2016 at 12:24 AM, Jeff King <peff@peff.net> wrote:
> The patch itself is OK to me, I guess. The interesting part will be
> whether people start actually _using_ cppcheck and squelching the false
> positives. I'm not sure how I feel about the in-code annotations. I'd
> have to see a patch first.

So here's a patch that adds supression files. It would work well for
things in contrib/compat that don't change that often. It would be a
nightmare to maintain for high-touch code.

 Makefile       | 7 ++++++-
 nedmalloc.supp | 4 ++++
 regcomp.supp   | 8 ++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 nedmalloc.supp
 create mode 100644 regcomp.supp

diff --git a/Makefile b/Makefile
index e5c86decf..bb335ca0f 100644
--- a/Makefile
+++ b/Makefile
@@ -2637,7 +2637,12 @@ cover_db_html: cover_db
 
 .PHONY: cppcheck
 
-CPPCHECK_FLAGS = --force --quiet --inline-suppr $(if $(CPPCHECK_ADD),--enable=$(CPPCHECK_ADD))
+CPPCHECK_SUPP = --suppressions-list=nedmalloc.supp \
+	--suppressions-list=regcomp.supp
+
+CPPCHECK_FLAGS = --force --quiet --inline-suppr \
+	$(if $(CPPCHECK_ADD),--enable=$(CPPCHECK_ADD)) \
+	$(CPPCHECK_SUPP)
 
 cppcheck:
 	@cppcheck --version
diff --git a/nedmalloc.supp b/nedmalloc.supp
new file mode 100644
index 000000000..37bd54def
--- /dev/null
+++ b/nedmalloc.supp
@@ -0,0 +1,4 @@
+nullPointer:compat/nedmalloc/malloc.c.h:4093
+nullPointer:compat/nedmalloc/malloc.c.h:4106
+memleak:compat/nedmalloc/malloc.c.h:4646
+
diff --git a/regcomp.supp b/regcomp.supp
new file mode 100644
index 000000000..3ae023c26
--- /dev/null
+++ b/regcomp.supp
@@ -0,0 +1,8 @@
+memleak:compat/regex/regcomp.c:3086
+memleak:compat/regex/regcomp.c:3634
+memleak:compat/regex/regcomp.c:3086
+memleak:compat/regex/regcomp.c:3634
+uninitvar:compat/regex/regcomp.c:2802
+uninitvar:compat/regex/regcomp.c:2805
+memleak:compat/regex/regcomp.c:532
+
-- 
2.11.0.24.ge6920cf

