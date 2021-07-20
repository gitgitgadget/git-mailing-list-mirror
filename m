Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C2C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E300E6101E
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhGTJvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhGTJqS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE25C0612FC
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso1727291wmm.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCvY7+A3Pc8OMQ+NkfKOGjSFEZyvhHn+BLOkIHSuvE4=;
        b=sWm5kfvrCJSU9NN8qSFWT9sl3A9RkNc3dSmEdfjYQw1TJEoKmvCnEyPKvi6i0mxYv/
         UMPuHBLlOUwUCAQnABsmQbi4Ooklg7+PlHAE6mw0VfKLVCLj8ieA6cIi5ZsJ26og3s3h
         Hr6ZO1l0074QL5OVp91NSU8wDGz/KFeJR5q3uk2kdcSTYOGy4j0qzeaeP3Mwq7F3bg4f
         Zpe4AC8Rds+2ZwvW0cPlEkF1msmFEPz1JOE4lRzoC7ItlgisJU6Ga4jGYox44pStCr/9
         mOyrz51a0BbuJhy0eGOycBbeghPQDPyQ72riGZ/x5yndyIPTb130O6PyWjle0CrKh3Tc
         qE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCvY7+A3Pc8OMQ+NkfKOGjSFEZyvhHn+BLOkIHSuvE4=;
        b=Rp7d85aK3PZL7TGWW+UcSj/qpTc+yIz7VnIs5ws0MbKa/MBifGrjRbQk4OtrpCaA4c
         +IxEN9Z22d37Vgt7cVtLyxmtJkEY1zjnVKCsDf/C+DkIbDOQrM3elq+hBi9dy7jVlb+U
         BXG1SmTG+WpWdMCOUt81y+ftSwOjpZ0dr59byGbQp/PF9ScKcLdBZC/tetjgecGJL9Tv
         PTz29aFF1hdnl0i9YW1NW7E1+yo9CiNtb9HYaQFf9CkdgZ6QAVgVY/apzst2uYu90xrn
         MuAIq06yxj/LNNcXcH2eIiKK9C6ratMWodvyzYAaQFNHpF5/Kdg6kR97eZJv2VE+WuEJ
         de9A==
X-Gm-Message-State: AOAM5316eEEqq/dJxsqaOuNqhmf3d2eCw7f7F6CG2U+eRD+6D8HtqbR1
        n6FUUAMpqLwdOZUdHZ2GbZhWoxAjA191WQ==
X-Google-Smtp-Source: ABdhPJw/YgncUZ4ElBlYwTP/ZnX37HS8IVZZLSVD5GnUMvjOwD5FJhH5Raa2DpmK8XXEDCICi5moPA==
X-Received: by 2002:a7b:cb53:: with SMTP id v19mr29786013wmj.127.1626776672762;
        Tue, 20 Jul 2021 03:24:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/12] refs/files: remove unused "errno != ENOTDIR" condition
Date:   Tue, 20 Jul 2021 12:24:17 +0200
Message-Id: <patch-12.12-452253d597d-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to the preceding commit where we removed the adjacent
"errno == EISDIR" condition in the same function, remove the
"last_errno != ENOTDIR" condition here.

It's not possible for us to hit this condition added in
5b2d8d6f218 (lock_ref_sha1_basic(): improve diagnostics for ref D/F
conflicts, 2015-05-11). Since a1c1d8170db (refs_resolve_ref_unsafe:
handle d/f conflicts for writes, 2017-10-06) we've explicitly caught
these in refs_resolve_ref_unsafe() before returning NULL:

	if (errno != ENOENT &&
	    errno != EISDIR &&
	    errno != ENOTDIR)
		return NULL;

We'd then always return the refname from refs_resolve_ref_unsafe()
even if we were in a broken state as explained in the preceding
commit. The elided context here is a call to refs_resolve_ref_unsafe().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f83aa1063f4..443182da102 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -894,8 +894,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 				     RESOLVE_REF_NO_RECURSE,
 				     &lock->old_oid, type)) {
 		last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    !refs_verify_refname_available(&refs->base, refname,
+		if (!refs_verify_refname_available(&refs->base, refname,
 						   NULL, NULL, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
-- 
2.32.0.874.ge7a9d58bfcf

