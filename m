Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263781F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeBWXka (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:30 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40021 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752386AbeBWXkT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id t82so7332583wmt.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0b81g7n5VPS6DSlLgXCiFYoNp2BPIRg6qXf/38Jv1uk=;
        b=OdR/yBC6HRMAB4BnQ91cXbEhYnuGBQiN584TBjqVFHDdWiZZWNjdX3Z3o2seqS/jLv
         9brsZ8785dhnFxELN9eTnnrQugsU5fBiZwMUwZD/++XbdAt1NgD6SYmCSNEIfBT8cafU
         +vLJ2Nt5rKKVDLpnyYECWLOWTj9gA76+IYbvEBumb+pejssa2M6LL7FS0sMJXe1n/Cum
         g8qb6syGJSXnzebHu9giVlyqdNfQg8Z78gLVu7at0jy+1b75tg7IGzmCIPH14Qn0klLg
         k4L5/SRmo68azLzj+Z8ZeW+4SJSS3wAmiDmhA49RCb+rX/SvrNMbLsOmMfHyUk8MZ3/B
         NbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0b81g7n5VPS6DSlLgXCiFYoNp2BPIRg6qXf/38Jv1uk=;
        b=JnrHs2Wvso6gkMj+lSr73q8KjD7ERqaQJx1Kv3kSvBfSduelBNOhCWqH7nmNW5giIg
         EY+UkDq1OhvH7OHRO3b+FHZrhr6IEobYtRVeQWvc5mDArK8UCSJgYVOOeGXLJ+bxQZCH
         XjvMSydcwidIhhvaha/XNeotk+qYXs50Kr8TVA8WS1IkPSFKQhjDDpwY3OtfNQh7Dt2E
         EtRCn7NpYDXJ8roJwJ6k6y7HsbPTrQfjrICKKxwD6zivat+39gvBJ67NBKYA2s2A++ea
         9Xels5pDakl9OdDFZxiN/Uy94MxQ1bXENyA/fzQiITVvDiHg0YvsdD9Me9KBhpF5lnU+
         eemA==
X-Gm-Message-State: APf1xPD76gxUBY6oYmvItwQ4yTDUPxxV/ubu6kGHefHKBVKasbHXZ/MC
        OxMSpwbZBeGv6eB2rXS5tg7WgA==
X-Google-Smtp-Source: AG47ELu85pA1k9t9rmnmlUE8y0+vv61SzYonsShnkzxCpzgrZH/Umi9+T7ZJAvV2Vq3x2M4bgx/ZIg==
X-Received: by 10.28.231.6 with SMTP id e6mr3223325wmh.51.1519429217795;
        Fri, 23 Feb 2018 15:40:17 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:17 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/11] t/README: add a note about don't saving stderr of compound commands
Date:   Sat, 24 Feb 2018 00:39:50 +0100
Message-Id: <20180223233951.11154-11-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explain in 't/README' why it is a bad idea to redirect and verify the
stderr of compound commands, in the hope that future contributions
will follow this advice and the test suite will keep working with '-x'
tracing and /bin/sh.

While at it, since we can now run the test suite with '-x' without
needing a Bash version supporting BASH_XTRACEFD, remove the now
outdated caution note about non-Bash shells from the description of
the '-x' option.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/README | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index c430e9c52c..615682263e 100644
--- a/t/README
+++ b/t/README
@@ -84,9 +84,7 @@ appropriately before running "make".
 
 -x::
 	Turn on shell tracing (i.e., `set -x`) during the tests
-	themselves. Implies `--verbose`. Note that in non-bash shells,
-	this can cause failures in some tests which redirect and test
-	the output of shell functions. Use with caution.
+	themselves. Implies `--verbose`.
 	Ignored in test scripts that set the variable 'test_untraceable'
 	to a non-empty value, unless it's run with a Bash version
 	supporting BASH_XTRACEFD, i.e. v4.1 or later.
@@ -455,6 +453,22 @@ Don't:
    causing the next test to start in an unexpected directory.  Do so
    inside a subshell if necessary.
 
+ - save and verify the standard error of compound commands, i.e. group
+   commands, subshells, and shell functions (except test helper
+   functions like 'test_must_fail') like this:
+
+     ( cd dir && git cmd ) 2>error &&
+     test_cmp expect error
+
+   When running the test with '-x' tracing, then the trace of commands
+   executed in the compound command will be included in standard error
+   as well, quite possibly throwing off the subsequent checks examining
+   the output.  Instead, save only the relevant git command's standard
+   error:
+
+     ( cd dir && git cmd 2>../error ) &&
+     test_cmp expect error
+
  - Break the TAP output
 
    The raw output from your test may be interpreted by a TAP harness. TAP
-- 
2.16.2.400.g911b7cc0da

