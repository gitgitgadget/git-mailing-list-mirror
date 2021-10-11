Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B164C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BC460EB1
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 11:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhJKLa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 07:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhJKLaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 07:30:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60BEC06176F
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 04:28:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa4so12340555pjb.2
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNHWyLceu8UFqFIwHfPysqZP0DmcOQv6VyHd56qUZL4=;
        b=blOsSN5n2166xzAMHYRRSkKmLm+9cf9OKLVtXCwC9mf4kabE3lp1uQEX1JvUEpu7Qr
         droMV37d4b3B2eGdnoY+MNM5B0dnCgzceUFN5gUoS7qHvsUXSNJBpRW3y+c94knk+fGX
         XKXRCJeIFwSW828/Cxtp/jgUZ9+W6LVvEMiygiYsoXTm71GKhna6Xq0SBueGv1oR/QPG
         1o95x6z1T1FRgDCASnunqnxRJq4KJ+9EVOSCg/6+k1xnGVo1zjKmPNnLbAy8KBsm5M7b
         IsJA7fV4Je+a0Iy9TUatDrYVSSzx3TNy4lNrjnPwVYAu+IMU28OxgyaV78V8Mkc6jvEl
         CJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNHWyLceu8UFqFIwHfPysqZP0DmcOQv6VyHd56qUZL4=;
        b=aeSF0FJ2R8DcdbIX5ZO7fOhpkFjDafVBoHJq/yn9juAe+eWc3p1Ar02bSthHmG4b0r
         VroFN8VzGWcDNr+oyMPBmMShYMibkYbf+6qB9xMAEv6JtL9juMyanzyxDbR7nPHpj1C1
         bzpYcx3RCk7SFE0im/foysI/srT5HNjYgxKBNTERRXuOe194gfcLyIyJk+eTIazpEbrQ
         zw3tOfMwh8fxqqq5v+8CPOGafiyGpexJ4MPTvKQ2briTRuztd+DY33qtxs7vmBHg+93r
         pq6gMYwa6xBEheUBaNBRzuxupw2JXyvK7wgiGjUhIL9pCEJmIsgHMorEICbGitREmBZY
         2r8A==
X-Gm-Message-State: AOAM533D6g73fvgDCwAuSBCfW+Rc6JFO7jsgyMuGD/BlrZAH9N74tdFT
        JD9FCfRo67V7+thwQxEiPAgEMr1pgUl4FGSA
X-Google-Smtp-Source: ABdhPJwpmpUf/ShBAONr70vbTObhwwOZ7Znzn4gBLYPuZuauH6jNPiHw5LlLMhWjPzhLvdssx1dZZg==
X-Received: by 2002:a17:902:8d8b:b0:138:e09d:d901 with SMTP id v11-20020a1709028d8b00b00138e09dd901mr24349449plo.34.1633951696045;
        Mon, 11 Oct 2021 04:28:16 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-3.three.co.id. [180.214.233.3])
        by smtp.gmail.com with ESMTPSA id c8sm7223990pjr.38.2021.10.11.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 04:28:15 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] archive: add test testing MIME for created archive through compression filter
Date:   Mon, 11 Oct 2021 18:27:13 +0700
Message-Id: <20211011112712.475306-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The common use of `tar.<format>.command` config is to specify
compression program filter for creating compressed tar archive.

Add a test that tests MIME type of archives created through the filter.
The generated archives must not be `application/x-tar` (POSIX tar
archive) type, so that these can be decompressed with the corresponding
decompression program (such as gunzip, bunzip2, and unxz).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 t/t5000-tar-tree.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 2c88d1c159..04cdad5bff 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -38,6 +38,8 @@ test_lazy_prereq TAR_NEEDS_PAX_FALLBACK '
 '
 
 test_lazy_prereq GZIP 'gzip --version'
+test_lazy_prereq BZIP2 'bzip2 --version'
+test_lazy_prereq XZ 'xz --version'
 
 get_pax_header() {
 	file=$1
@@ -374,6 +376,21 @@ test_expect_success GZIP 'remote tar.gz can be disabled' '
 		>remote.tar.gz
 '
 
+test_expect_success GZIP,BZIP2,XZ 'git archive with gzip, bzip2, and xz filters creates compressed tar archive with proper MIME type' '
+	git config tar.tar.bz2.command "bzip2 -c" &&
+	git config tar.tar.xz.command "xz -c" &&
+	git archive --output HEAD.tar.gz --prefix=src/ HEAD &&
+	git archive --output HEAD.tar.bz2 --prefix=src/ HEAD &&
+	git archive --output HEAD.tar.xz --prefix=src/ HEAD &&
+	cat >expect <<EOF &&
+HEAD.tar.bz2: application/x-bzip2; charset=binary
+HEAD.tar.gz:  application/gzip; charset=binary
+HEAD.tar.xz:  application/x-xz; charset=binary
+EOF
+	file -i HEAD.tar.bz2 HEAD.tar.gz HEAD.tar.xz 2>/dev/null >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'archive and :(glob)' '
 	git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
 	cat >expect <<EOF &&

base-commit: 106298f7f9cca4158a980de149ef217751e1f943
-- 
An old man doll... just what I always wanted! - Clara

