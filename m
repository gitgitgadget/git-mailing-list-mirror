Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDAAD1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfJRWEK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:04:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36619 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfJRWEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so4083424pgk.3
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbf9inHo0I4t73aUKSW0KXTGxunKjYwC2acEh6a5lp8=;
        b=Oh8QtdWSzoc0KeXwXNnyEZl45WMsgukbU4dEuGEK7W25y66IO1XPDsodMqj3sUei4q
         Ul79xrAJhQmSUKdJI6Scx4tlFBRDML9hH0DWMiuakjDlW+s/7EHSjPydhBc504HT+Sn0
         OE6VhegbKJdIPzIvgfy+x6086dWUygQwWePfPkbGxQohPqwS8QF4WGiBbHrwBwK1CiDQ
         KsULsal/kZToErgvyN2uNhFg04mf0/3Q7e+31Vivmr1P969CB3cYnS0IgUzBeK7F60Px
         H2W69TgRupa7qgydg4qUV516TKWQx6DBomrO0YDPOZeufp+UcN1ldcza3Hf0Io0xZ0RB
         +L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbf9inHo0I4t73aUKSW0KXTGxunKjYwC2acEh6a5lp8=;
        b=rQRN8vA64LGxnI0KrRpj4wnb9U5M5OyrHAFr3wgDd3QKokOcne4TZzum8eBIR/h7Uk
         q3ro1svV9Z1Jefvsi17Tej5tSuL8fajjfzS4dYGUn2SmSAerViPT0MAPsJCu3hC8wsO3
         K5szcT3635tycHGa0PPj9356IXf33km/ugWK5u9EOXsPiMUhl8DquOn7jhP1VjLBGNJQ
         EbZCFwRq6tFpn4NvpE7JLfHI3eUsc74LR3OWwV/iPLwQaS52Bk5JHU2qybLHh+08BASR
         jvB+xHZT2cHvjir+IdkZIpe2MNna0PVhPR46f5jPe9iffH2d5XBJtEKuUy3Use4At5UY
         DshA==
X-Gm-Message-State: APjAAAW4siNXXyxrVfkYpNn+4fVrMPWpJgBCagKFIOCtQvoa9CzYR5Om
        mSq4kfKeKipfoJVQ6wBqtGb5QH2O
X-Google-Smtp-Source: APXvYqx6679xEnjABmYssjePQvtJmLOrVjOnGpuj9rUU0EQ2FpOrID1GEYHjGX3RycFCMQirv8YKPg==
X-Received: by 2002:a17:90a:23b0:: with SMTP id g45mr13073597pje.127.1571436248365;
        Fri, 18 Oct 2019 15:04:08 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 206sm6750715pge.80.2019.10.18.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:04:07 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:04:06 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/15] t7408: replace `test_must_fail test_path_is_file`
Message-ID: <987fee4652ae1bd8d3eb50ed51f7c9694d567dfc.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to t/README, test_must_fail() should only be used to test for
failure in git commands. Replace the only invocation of
`test_must_fail test_path_is_file` with `test_path_is_missing` since in
this test case, the path should not exist at all.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7408-submodule-reference.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 34ac28c056..9e62d43cac 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -123,7 +123,7 @@ test_expect_success 'missing submodule alternate fails clone and submodule updat
 		test_must_fail git submodule update --init &&
 		# and we have no alternates:
 		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&
-		test_must_fail test_path_is_file sub/file1
+		test_path_is_missing sub/file1
 	)
 '
 
-- 
2.23.0.897.g0a19638b1e

