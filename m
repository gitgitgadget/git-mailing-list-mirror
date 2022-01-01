Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2013C433FE
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 13:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiAANu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 08:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiAANu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 08:50:58 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C8C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 05:50:58 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i8so17563164pgt.13
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 05:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZU9dzE64Trn4rpDSIxZOxbqL+E8GnnkMdG00HpP21A=;
        b=qNUQnVml7wX/7iWhU2kV8MfTdPCxfYq2K2vivrbFjedRbKyGpgtdhofhE3WfIfbXnH
         WmLbHA5Kz07+fGxCJKc9RRR6fgdTKH4czVnWZAyxp2/8LsENEXuFcGtukTcANxel3XW3
         J2vEKpi0LHophGgdqjMcly6EXkcDeA3QrRG2/sZl8+zK6LVarOTpVolremnzhBzqrXbW
         DEgMHrB4PRSvz6l4iia6MaIjzjxASimWhEtEORYHIIL9XpbQY/1F5rpP0j6IYAXfZCnU
         +HiwL46mR587Pq/Enn2pqizVoW6WoXbG4YvpxxdZJlCvWxzLiKHoZddfSqJUDr/jqWmO
         lXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZU9dzE64Trn4rpDSIxZOxbqL+E8GnnkMdG00HpP21A=;
        b=pSFfS/si2U5H7SzBsmS+xO1zQ6KNr/f9eyKvUjvGneHQuezxpkdyXMd0cwYNGCEkur
         pSmtxG4OJU2mRQPTgH3stGwyG1T3HzO9+g0NBpEcWHO7H9PDFtBCWYFgdHywdLvPbYoC
         FooSHC+j/wzDsQzp5if0eGiw4z/ky28oXtuaODRNFRF2eskvbWbkyHc83SQ+Qw+jo7QG
         C2TM4vjXw+cHHy9nCnIBPq/XrTY2ZHIdf/ZApoh1Hn+Z2G7qC9zT4ouVmyo09G0Vd3Jt
         6q4/XFcDNs5C3YI43fwffmrRRpFvLFCMusPqE8nMduH0PDI+kEtsvdjgag3V/sbjH+0K
         C4jQ==
X-Gm-Message-State: AOAM533OL9p7Wcpwq1AB8YG90AQuE5kWle/MFu2fpQeWugSH2IXLvwfk
        uL6knnOxe7vL7D+oUbVCpF4=
X-Google-Smtp-Source: ABdhPJwdXQx312i9IWRiwYMnY0DbRTXloWTyI1P2YWj5sxx6XPSg0VPVz5K/koNb/wl9lJHRqo72Tg==
X-Received: by 2002:a63:5920:: with SMTP id n32mr34562568pgb.226.1641045058277;
        Sat, 01 Jan 2022 05:50:58 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id o11sm34022039pfu.150.2022.01.01.05.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 05:50:57 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 1/8] ls-tree: remove commented-out code
Date:   Sat,  1 Jan 2022 21:50:24 +0800
Message-Id: <2fcff7e0d40255e0be9496647787352dd0aeb784.1641043500.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1802.gbb1c3936fb.dirty
In-Reply-To: <cover.1641043500.git.dyroneteng@gmail.com>
References: <cover.1641043500.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Remove code added in f35a6d3bce7 (Teach core object handling functions
about gitlinks, 2007-04-09), later patched in 7d0b18a4da1 (Add output
flushing before fork(), 2008-08-04), and then finally ending up in its
current form in d3bee161fef (tree.c: allow read_tree_recursive() to
traverse gitlink entries, 2009-01-25). All while being commented-out!

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c7..5f7c84950c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -69,15 +69,6 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	const char *type = blob_type;
 
 	if (S_ISGITLINK(mode)) {
-		/*
-		 * Maybe we want to have some recursive version here?
-		 *
-		 * Something similar to this incomplete example:
-		 *
-		if (show_subprojects(base, baselen, pathname))
-			retval = READ_TREE_RECURSIVE;
-		 *
-		 */
 		type = commit_type;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-- 
2.33.0.rc1.1802.gbb1c3936fb.dirty

