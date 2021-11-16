Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D1C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 11:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2EB61BE5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 11:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhKPLDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhKPLDt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 06:03:49 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F92C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 03:00:53 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id p4so11688058qkm.7
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 03:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aztOQD4OYuZnXnzCmp8Ft68HuJ5kwJ24LsSs4ZenEUw=;
        b=dOxQKOCJHNOf8c70stlwlX6aWrcdSumf6BGb9BVPz+e4LVlK+n9EH4du0urDuarMIW
         dZ8D4ACLc3lZZ8WwphCAIjZy7zrobukMNvaxPgImv6AmCurPS7MvGWmLugMFkN2HctiN
         sk6AzZsYOlm5nCk8+cC7qHMJYWJ5vb2H8Kf0yfuEOWXbIgVqAj7gzxAJ8GE+EbtisYPG
         F228OVSsRxsLgetg8XixJDn4u7gdMH1i86Cmk+OoWhVTRYHhw/LZZQDN4MzGxUDkfPtd
         8SU6iXFQutRNcHWWpaPjX66JQncp910aBiyBxwgo+UFl10SQwZd7E6Lco0iBK8oP1emL
         9weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aztOQD4OYuZnXnzCmp8Ft68HuJ5kwJ24LsSs4ZenEUw=;
        b=UPwgxagS+TG9g4rcVuQ2Fl+bnLghMI9ldI4eHFWoPICxgonIgrZttxBnvCG0EzI4Oe
         V/FpdyxJkRFXXxMxMxGfkfKzbBELo6ik49EfYniXtN06i7a8E29RW3fuCY/zDGPYVETq
         hOH5/p/JwXV0UxsI2SyRHqGv9ozRUXbNYRrrIuCpovuGrv1gpoSxOvwr4lTJ2/A37DXS
         8fLLYn2qqhsbk3W2X9G1W/QNrTNkpmAT3zi6YBEI94yXxKXP3kO2m1viu5Xm9jobO3LV
         c9Dyloj5OU9EwQcOV2PcVTyKqX22KEzW74/54jCT4jWhXQcfn2IhqaKt92puPAPVLGhQ
         c5rA==
X-Gm-Message-State: AOAM531tnCOWJIewyquxKNZgZH/t5Lpx8wh2n6lG0c1VmSVT7uvJSnBT
        RHF5BeLa9c6P7QoQguRcE/jXqZ0FD5c=
X-Google-Smtp-Source: ABdhPJyw1au5w0JTLsXmiz07Tc4mOoo+1T1aWNmgt7aimlFCLw3oyxTljNHqYOQ9coWkHeL9QRK6ZQ==
X-Received: by 2002:a05:620a:4081:: with SMTP id f1mr5390720qko.165.1637060452164;
        Tue, 16 Nov 2021 03:00:52 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id n13sm1482181qkp.19.2021.11.16.03.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:00:51 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, someguy@effective-light.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] grep: avoid setting UTF mode when not needed
Date:   Tue, 16 Nov 2021 03:00:35 -0800
Message-Id: <20211116110035.22140-1-carenas@gmail.com>
X-Mailer: git-send-email 2.34.0.352.g07dee3c5e1
In-Reply-To: <87bl2kv309.fsf@igel.home>
References: <87bl2kv309.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since ae39ba431a (grep/pcre2: fix an edge case concerning ascii patterns
and UTF-8 data, 2021-10-15), PCRE_UTF mode is enabled in cases where it
will fail because of UTF-8 validation, which is needed for versions of
PCRE2 older than 10.34.

Revert the change on logic to avoid failures that were reported from the
test cases, but that should also reflect in normal use when JIT is enabled
and could result in crashes (or worse), as UTF-8 validation is skipped.

Keeping the tests, as they pass even without the fix as replicated locally
in Debian 10 and the CI.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index f6e113e9f0..fe847a0111 100644
--- a/grep.c
+++ b/grep.c
@@ -382,10 +382,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
-	    (!opt->ignore_locale && is_utf8_locale() &&
-	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
-					    (p->fixed || p->is_fixed))))
+	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
+	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
 		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
 
 #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
-- 
2.34.0.352.g07dee3c5e1

