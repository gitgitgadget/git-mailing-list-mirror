Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F3C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF792068E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTGJh7vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgHYLbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgHYLax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 07:30:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E45C061755
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:30:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so6640185pgf.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMV5QKFhnPr4rnfdTmWVCktqKgOz003QeE55g4bMuiI=;
        b=NTGJh7vHKCOTGRnBR0diZzMk5vKyDvQTWuOiMvkdH7Zc/oSqd/H30i7LpPfhs9BfUI
         88Tg4ONtJ0I9KvLocAX48xZStjtmLVoC30alYAL3Lx1Tes1FY/xBt0gLZkMr8i5+Bskv
         jJMrw92QWIWWxiO21QWGZbYETY3+shQJ98nc1qIVm9MUKoLXXyO/v1qabQ9FViwGRg9N
         /Nn/uCK8/SjbcPEhd0ycXTlQ0zALpysAtL+32WK+rbByvPwtTwpmyQpr1aGWR3FaXGmK
         T9C7vqP7dkwOpXAlwcACT4BBBJHdUvZPs5ZgqW++PfACe9WsDOdlnS1cLg7/WLmzvOQZ
         0Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMV5QKFhnPr4rnfdTmWVCktqKgOz003QeE55g4bMuiI=;
        b=ERGOQZdToItpz69FeW5wTpQg5kimoFGbstRTopPa+Ait6sFD3wxecFqWTmVq2McEFs
         cevMZ2YDdf6hHyYmK3yVP9HWx//6hLYxyBnOTcRxpXUG/qbF7sTvspIc+mGeJwv4vMGH
         Y/5fCN7zhnQpRW2s97KuenQ4ZSvk722FQ93fYuTQD3jY+0+CkvYIFKLmn1OpSG6Y/ADo
         N1VaUoNoj3Nt0qaIwOM1yliMTWuhbqFhCQunc0O5QgBzEwFkZPh3pq7UOwTKN+FinfEb
         0oQ6HKA3BbONCdYFqAoMBIzztfwZcJAs7fCwlk2zBzCmptWzPyAmJCVTq7pPu5xL3WPw
         N56A==
X-Gm-Message-State: AOAM531wlRtJfj+lSgjlyAMD3sgj2sS4pBPmSa/WADDPamKDX3G/zlrm
        IZjONPg65ENhEPCK0Lo6m2w4RMM2ry0XZQ==
X-Google-Smtp-Source: ABdhPJw454k2A+jAYCw6nzazoRTjT2+qwg8d9+IJ5H1nBfzG9b0uSvXv2rkztdXhHefoXJi0xv8HoA==
X-Received: by 2002:a62:1616:: with SMTP id 22mr7607331pfw.207.1598355045932;
        Tue, 25 Aug 2020 04:30:45 -0700 (PDT)
Received: from localhost.localdomain ([115.97.133.243])
        by smtp.gmail.com with ESMTPSA id y3sm2821518pjg.8.2020.08.25.04.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 04:30:45 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, liu.denton@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] submodule: eliminate unused parameters from print_submodule_summary()
Date:   Tue, 25 Aug 2020 17:00:18 +0530
Message-Id: <20200825113020.71801-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
References: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eliminate the parameters 'missing_{src,dst}' from the
'print_submodule_summary()' function call since they are not used
anywhere in the function.

Reported-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 63ea39025d..b83f840251 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -982,7 +982,6 @@ static char* verify_submodule_committish(const char *sm_path,
 static void print_submodule_summary(struct summary_cb *info, char* errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
-				    int missing_src, int missing_dst,
 				    struct module_cb *p)
 {
 	if (p->status == 'T') {
@@ -1154,8 +1153,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 
 	print_submodule_summary(info, errmsg, total_commits,
 				displaypath, src_abbrev,
-				dst_abbrev, missing_src,
-				missing_dst, p);
+				dst_abbrev, p);
 
 	free(displaypath);
 	free(src_abbrev);
-- 
2.28.0

