Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101D2C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B2664DEC
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhBRMVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBRJ6i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 04:58:38 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F64C06178A
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 01:57:55 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id d2so3478236edq.10
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 01:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HiTSrleYSgItZdiHOKWXVUbq57C9SHpQMYY78PvCXYc=;
        b=YBroZGFJiyZJGyKslu0TQ5K1YIdYP6fMA/EFKzdqtLAao7s0ffbz/eOSdCmwSd/hig
         9VAzFj94WCugCpwmKpVvCTipPaBtwcvC5KVD+B3UR4ansW9+mNISuWDHZa+H43rO6HWE
         pGg3Kw4KBuWLCTGhepjOGTID5L0bIbxLApnWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HiTSrleYSgItZdiHOKWXVUbq57C9SHpQMYY78PvCXYc=;
        b=BHXv4zn3VYJqe2FkDu2o7w+N5PeGDAvCqqDucspR1R3SEQXzKbu3Bg8IE91UqaK3JX
         On23otV1v+3SJ0lO75yy+8K9Z5CKrmlIxxRCFFaLlbHBta5rw/ENsKNL6Py3zTFnP974
         t1YKNCQuT+6ZewOP/GLtIkrTbe6vb0tKIogIRGkzY6rSDIoCZ8XZls5RurOIAMrtTCMI
         BA+4cQUn7C5eQedkuiGLFO+9HQcN8r/8U/GK8UXoLmTrNpmoSw1lqtAwbShE0gx/kImX
         AERQSf+YKwHaEY7l0QP61mX9cW9lQkNDe6I9uGHhU0/eTMKaDEhyL+mWR7D3ExmLSXH+
         xAFg==
X-Gm-Message-State: AOAM531bg+pLyh97kV/YdKkRUzByuFXmWIykwVPsJ3IDToW9pDJPOiPN
        YTbr9KpVUjSwwL+bHTleX+4+W/uySfLE9w==
X-Google-Smtp-Source: ABdhPJzD15M0Gd8DxY89Duwv18+ipnTQxJq1jK/5s/BGvzQ/CPI05BabQ3owXFV96EYlADXgHYyLng==
X-Received: by 2002:aa7:d34e:: with SMTP id m14mr3338121edr.223.1613642272780;
        Thu, 18 Feb 2021 01:57:52 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id f2sm2405570edm.95.2021.02.18.01.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 01:57:52 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] test-lib-functions.sh: update comment on generate_zero_bytes()
Date:   Thu, 18 Feb 2021 10:57:50 +0100
Message-Id: <20210218095750.939746-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d5cfd142ec (tests: teach the test-tool to generate NUL bytes
and use it) changed the implementation of this helper, but didn't
preserve the magic meaning of the word 'infinity' - in fact, since
strtol() returns 0 when presented with that string, it ends up
producing no output at all. Instead, the C implementation interprets
lack of optional argument to mean infinity.

Since the last and only user that actually passed 'infinity' vanished
with d99194822b (Revert "t5562: replace /dev/zero with a pipe from
generate_zero_bytes"), just update the comment to match the
implementation, and while there, short-circuit "forever or X" to just
X.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
I wasn't actually sure what "$@" would expand to if a shell function
is passed no positional arguments (i.e., whether it would end up
passing a single empty string as argument), but at least the bash man
page says

    When there are no positional parameters, "$@" and $@ expand to
    nothing (i.e., they are removed).

 t/test-lib-functions.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 07976af81c..0a1e008767 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -117,8 +117,7 @@ remove_cr () {
 }
 
 # Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
-# If $1 is 'infinity', output forever or until the receiving pipe stops reading,
-# whichever comes first.
+# With no argument, output until the receiving pipe stops reading.
 generate_zero_bytes () {
 	test-tool genzeros "$@"
 }
-- 
2.29.2

