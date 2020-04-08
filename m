Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D95DC2BA1A
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021E52075E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtXttnq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgDHSwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:52:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37572 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgDHSwi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 14:52:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so10052860edb.4
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YJPaZaK2isoM8myO3HITM2GBCk367B62lF908o1zfqo=;
        b=VtXttnq/pxpOK3wlLJU+9yi+KFzu/0FlSCFrZO/FoJDA5VDDAHoqhEy9DK6GntOWWw
         hfROMTpKfVmCzAN8OT5vaWJQ8NPGBBlwTylDDO+21hzd6EhQJ38pSR/uK715sl4kN7yR
         MEOijmnTz0Fh6UKZEbBhQB0h6rmhirGvDTvk+ivJi9Z1En+1TDWzAUH7CXtFWDzyD/Fx
         oi36aLEMg7T0HFQLIvP3fJ9xHb/DnidAI7unrxFrksLlKpENUmiMkX6GZvK90DoHjtt8
         //ZC2Cll0MVhhe5haZv8SK/WmRH+vg7+CRLLKVsdv6qzst3oe8JVzb1gi938OHGk6eHj
         yQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YJPaZaK2isoM8myO3HITM2GBCk367B62lF908o1zfqo=;
        b=shsbCwcHAVdn1VNAk7+qtwKIwWGMl1Vb4ww2hvhFzn1ZBpqpVrcyWt4yPhF6rkC4Q9
         jmUidsmTaE2iDsTRqT+AsURFtGrycU8eBdMM88nmI5bMQPLPndjKJBVncvTiU/1pyrBu
         0YUZ8iASIyyKvCET34CJL+COKQRe4uyOAATm71CdQr+DMfbG5vdkJjTW0AERTSiRIDdy
         Y+iVodXRw8YaVjZAVcUUMgiK5jtyzL7JOgIS5e00GZyPyPKlIYzZw1XWS9+naNJOgTaZ
         dJ2dt6hKRutN6wJVr/37chFu57m+pUXUhxeNOH/5ajEFJsCo/PeLMgppXuPy6PH+ROry
         VaEw==
X-Gm-Message-State: AGi0PuZoPDH2CarWZ/Wkc64yhaKRP0CEc/XFBZHnNvGbsuO0R1Cws4d1
        UvUv6ha2UB5qh7+NhAobOHCAW832
X-Google-Smtp-Source: APiQypJWKpMiQlEEyIP4DdRyxOQ0tuMc7dEeFXxnrhvlNT5C8bFa11CxW3aLQ1NswMSoXtn+Wp3TSg==
X-Received: by 2002:a17:906:c7c3:: with SMTP id dc3mr7578788ejb.128.1586371956199;
        Wed, 08 Apr 2020 11:52:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm2956279edb.90.2020.04.08.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:52:35 -0700 (PDT)
Message-Id: <461fc76ed71fe79b61f3623b5ab094796723569b.1586371954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.602.git.1586371954.gitgitgadget@gmail.com>
References: <pull.602.git.1586371954.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 18:52:33 +0000
Subject: [PATCH 1/2] t3904: fix incorrect demonstration of a bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 7e9e048661 (stash -p: demonstrate failure of split with mixed y/n,
2015-04-16), a regression test for a known breakage that was added to
the test script `t3904-stash-patch.sh` that demonstrated that splitting
a hunk and trying to stash only part of that split hunk fails (but
shouldn't).

As expected, it still fails, but for the wrong reason: once the bug is
fixed, we would expect stderr to show nothing, yet the regression test
expects stderr to show something.

Let's fix that by telling that regression test case to expect nothing to
be printed to stderr.

While at it, also drop the obvious left-over from debugging where the
regression test did not mind `git stash -p` to return a non-zero exit
status.

Of course, the regression test still fails, but this time for the
correct reason.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3904-stash-patch.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 9546b6f8a4e..ab7d7aa6de1 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -106,8 +106,8 @@ test_expect_failure 'stash -p with split hunk' '
 	ccc
 	EOF
 	printf "%s\n" s n y q |
-	test_might_fail git stash -p 2>error &&
-	! test_must_be_empty error &&
+	git stash -p 2>error &&
+	test_must_be_empty error &&
 	grep "added line 1" test &&
 	! grep "added line 2" test
 '
-- 
gitgitgadget

