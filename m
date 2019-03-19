Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C7A20248
	for <e@80x24.org>; Tue, 19 Mar 2019 23:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfCSXPG (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 19:15:06 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46758 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSXPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 19:15:05 -0400
Received: by mail-ot1-f46.google.com with SMTP id c18so379597otl.13
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 16:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=W85cQ7/ov1+Di9wfS92F/C3JhL4sY9NSMnWV4MY8rVg=;
        b=I3TOcBGw069z8YvLBn1JF0BJbGsAd+SUlwYBbO4Bc2a0B52pUFy8viG4GVlMuG87nj
         6gTYfLYgYF1AH4sCCC4HxxlbCeA2zgh1BjKzamQlS/o4t3Pv4WYExvJPRoFmzWVeOgvy
         hMrlGOVf5K1FmwJ3tlpeSRElBhHKTTU7Z+CD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W85cQ7/ov1+Di9wfS92F/C3JhL4sY9NSMnWV4MY8rVg=;
        b=GbH//FDm8ULq/Y+eXfkGXvJNnhFrBINIJtaPFOsOs086XthYkrBfs6b2o2778oA1bm
         Olw+IYmsaQuXv5zpzng/gQwJ2QboA2goELK+VKjcDkPJDjC2FPw74Fmum1LOPPXxK8NN
         ZOdbTtesGOGv9TzGi/rMGbPcCYxFu9xiFy7vt9AuUevJO/FGQC/UmzVGq17Yb61MzOo0
         Y/Lk4ONvUMo8vy5CYdUore10ZDjHb21QjSFddJD8KExXQlyZQ0X4xi77Y9lATj8vux5E
         Gi0MVrx5uhDdX9b3NrR+7JWrrJ2aG6grBXtX70/exWFMwbJnxU4IQvATOxHMPoi0xG2b
         6e9A==
X-Gm-Message-State: APjAAAUQ9PiD2AqqWuKRbY8GjN2Hht3W3a5ofgu/a50wLYuQPr/AIVsE
        BNj1cm7b0xbbRwrTYxISD+4Xy1TOH8A=
X-Google-Smtp-Source: APXvYqwi1whDCjq5knLpL/NnVdfOUHiUkmRd8BPz4vFJ+U2EIsgJHZNb8EKV2f4dLFSDIDjwEHwYFA==
X-Received: by 2002:a9d:64d2:: with SMTP id n18mr3536170otl.183.1553037304654;
        Tue, 19 Mar 2019 16:15:04 -0700 (PDT)
Received: from localhost (172-126-240-27.lightspeed.irvnca.sbcglobal.net. [172.126.240.27])
        by smtp.gmail.com with ESMTPSA id h68sm169451otb.1.2019.03.19.16.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 16:15:03 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:15:01 -0700
From:   Dave Huseby <dhuseby@linuxfoundation.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 1/1] t/lib-gpg.sh: fix GPG keyring import options
Message-ID: <20190319231501.2dh4j3asns3e7gqz@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the way GPG keyrings are imported during testing to prevent GPG from 
prompting for approval to change the default config. This appears to have no
adverse affects on GPG users with "normal" configurations but fixes the
always-interactive prompting I see with my multi-keyring setup.

Signed-off-by: Dave Huseby <dhuseby@linuxfoundation.org>
---
 t/lib-gpg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 8d28652b72..4f3675f410 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -32,8 +32,8 @@ then
 		GNUPGHOME="$(pwd)/gpghome" &&
 		export GNUPGHOME &&
 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
-			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
+		gpg --import-options merge-only --homedir "${GNUPGHOME}" 2>/dev/null \
+      --import "$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
 		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
-- 
2.11.0

