Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A47C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5941C206D6
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGUSZn1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgD1KxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726348AbgD1KxM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 06:53:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF5C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:53:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so1021632pjo.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMnq80ir0pmXq55o9vdOaKi28e7FzsW0VG0+CIoKZMk=;
        b=GGUSZn1ZmcKOB3GUH0d6ObeiNpWmMI+wmn3a6N6ldEH7SJlIf4A4PSpfRdI1xpsWWX
         2MPIH5grIxlYibp6IMXLw9+okI+ViLllR46aGTOKGf6I+RbAi94pAOVgSrESx4B89k8y
         8g/u+sY8A0qqOIiBMR6/Nnea8U/Qu7FDAAGVrpBOeuBekUvPNVjmcrtMqadg/vbLi8Hd
         GhZijOb45JU5kVw7qc66899gIt0yYSlBBzryReDnx1YX75QY9ltPKuzlTyVRNaIDU/Z2
         GgDTSHuWlmhrvzpJlz69UDAC5yh3Jd71itCEA3beIOK1NnhCrpFq/KFB3GrzJgCt4SWU
         x1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMnq80ir0pmXq55o9vdOaKi28e7FzsW0VG0+CIoKZMk=;
        b=A11MMC9diogc54BGbXfsZ8aURrMTtTJqFaUbjDZQoRxsfCppg/+tNlhQEGav9KVx2s
         nCkAGegMCL1FE3wXAVDQp9SKmi2ZC4bV9vXWy+asqAJ+ox0aulpzir6bFt6Ej2wuzQVV
         wkXFeME2zNLy0CycKgs9G3R4suyQuA16dcxm/2bGqowvaloCXEeocvyTwSr41vbPz+iY
         LwPowXqejl/98A/y8jWuSa2yZ3LImZC5a51B35n4qqtJQb3DIKKCvYxF55mYSB4MWzkY
         xYZZzJYGb3dJw5s3Ph5pe5EfPKFs0h9dHDQubLpWO4EPRT0ZK7tGN4ZjTFsJuP9gXKV3
         ZTgw==
X-Gm-Message-State: AGi0PuZceZ4P5EeV8WFy5Uh4PqS8GJ7gBeVzBIAekFS4LhX5ZvO3TqGr
        WMW193RBBZfuHNM8mmcSV3hIyKXOtsg=
X-Google-Smtp-Source: APiQypJLjO9qM4zOKqJw+YKA2R8xg0Kpm8QWZNiA0S58dHofHx07+0fLFaByolixJbwT4GXwOn7eiw==
X-Received: by 2002:a17:90a:498a:: with SMTP id d10mr4581518pjh.194.1588071190944;
        Tue, 28 Apr 2020 03:53:10 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e11sm12513436pfl.85.2020.04.28.03.53.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 03:53:10 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com
Subject: [PATCH v4 1/4] credential-store: document the file format a bit more
Date:   Tue, 28 Apr 2020 03:52:51 -0700
Message-Id: <20200428105254.28658-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200428104858.28573-1-carenas@gmail.com>
References: <20200428104858.28573-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Reading a malformed credential URL line and silently ignoring it
does not mean that we promise to torelate and/or keep empty lines
and "# commented" lines forever.

Some people seem to take anything that is not explicitly forbidden
as allowed, but the world does not work that way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-credential-store.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 693dd9d9d7..76b0798856 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -94,6 +94,10 @@ stored on its own line as a URL like:
 https://user:pass@example.com
 ------------------------------
 
+No other kinds of lines (e.g. empty lines or comment lines) are
+allowed in the file, even though some may be silently ignored. Do
+not view or edit the file with editors.
+
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
 each entry in the credentials file.  If the protocol, hostname, and
-- 
2.26.2.569.g1d74ac4d14

