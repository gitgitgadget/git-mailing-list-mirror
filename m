Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871BFC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D132072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYhSX0q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgAQUo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:44:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42186 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgAQUo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 15:44:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so10317139plk.9
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 12:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=982Oj3qGp6Tym15pxaUXvMYy00rUqC7Uj+32S6Kz9fI=;
        b=EYhSX0q1//S55XpPob1j3PhCRMy0INYJCc/QmNoFH/dgVRHPqDMnxQ/igeNgFhlJBP
         LGUxmmCb34rRpDE3yx4TdpvDKQn00f4m0WIgqj5tyfUqcvVe+AL0x3CeJwBvCVlJfQV6
         te43A9UxfBFZZq3VjhojXYLEEKIk/lSpN8XCx3swtLmPNro75/pNQhNhEn3RaltZwJVP
         LZCxeJttZ/5TV9+rwiEjNst4HreYo20q6e8IDBkl8aWX8UcdlYxZUF8UrOHJAoXljpDq
         Rdnp4+4mNuRa/pxumj8s2ntY0PKYNUBVx7lme4bp95vzqen2GiMG6XpN4ObKoTA21SLo
         ho7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=982Oj3qGp6Tym15pxaUXvMYy00rUqC7Uj+32S6Kz9fI=;
        b=jLrfK24s64IKL5khJKVi3mkJ/GtfZOip90hy5iCO4Jx3/ACOfWlAifWPt3I1jCcjUX
         oqVwoEVDdFmDCjRpymplLCXbjuSEfqL6j4p7NNeosbzKNSa6nrsXcNXpCbb+W1rN17tC
         Kmihi+CRby9O4q01k9piym+nnMGq2UdLXmCWW9tPvImSyqk8JWngLQYvw1EIlS5GT6Bx
         Ig3elzRbrhqNqlzdwHzMhhaTiYthTmE404AyYQGzrvsm1h3dwcU8shkFPNa2ZQz2p4Ja
         pJjeivjamhmhYnQN2OS5cR7lHbmHlw46U9O/oAQd2E1J18a1orMJadugzy4QWKVcBjmP
         i5JA==
X-Gm-Message-State: APjAAAX541XyXi3JmVtfxmNKD2rKAG7qQ1oAZzTCJBEAI4wBnUyZAlUu
        LV7bxR9TztcTf5ZesF5e9v3CXS2Kmqra0w==
X-Google-Smtp-Source: APXvYqzMp7OybnsMKa+H1ojTUBn7PE6iplr/ooyZRnFXdA1hPWx1Sc17l+r3eVnac5PbBY6DacDorA==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr1040056plz.295.1579293896262;
        Fri, 17 Jan 2020 12:44:56 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id u20sm28844190pgf.29.2020.01.17.12.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 12:44:55 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH 2/3] t6025: replace pipe with redirection operator
Date:   Sat, 18 Jan 2020 02:14:25 +0530
Message-Id: <20200117204426.9347-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117204426.9347-1-shouryashukla.oo@gmail.com>
References: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com>
 <20200117204426.9347-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of pipes(|) are always ignored, which will create
errors in subsequent statements. Let's handle it by redirecting
its output to a file and capturing return values. Replace pipe
with redirect(>) operator.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t6025-merge-symlinks.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 7a19ba8520..5136bf1e13 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -17,14 +17,13 @@ test_expect_success 'setup' '
 	git commit -m initial &&
 	git branch b-symlink &&
 	git branch b-file &&
-	l=$(printf file | git hash-object -t blob -w --stdin) &&
-	echo "120000 $l	symlink" |
-	git update-index --index-info &&
+	printf file >file &&
+	l=$(git hash-object -t blob -w --stdin) &&
+	echo "120000 $l	symlink" | git update-index --index-info &&
 	git commit -m master &&
 	git checkout b-symlink &&
 	l=$(printf file-different | git hash-object -t blob -w --stdin) &&
-	echo "120000 $l	symlink" |
-	git update-index --index-info &&
+	echo "120000 $l	symlink" | git update-index --index-info &&
 	git commit -m b-symlink &&
 	git checkout b-file &&
 	echo plain-file >symlink &&
-- 
2.20.1

