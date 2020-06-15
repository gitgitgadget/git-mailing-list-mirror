Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DA7C433E1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B828920707
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMOadPlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgFOLxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgFOLxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 07:53:32 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7BC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:53:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g18so12255221qtu.13
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jvEjT3LS5Xhx83JzZ7mwoZFRCzRRBgIZ95nhIq4PitI=;
        b=qMOadPlMop3O1PJ2F0nPkVAfhGQRYM08ErGMq8AdOoM05v2YKscws7m5+fimT4Przp
         Xv2erkNYYZH4M1oysV6Iuz6oh829J6bRGj2XMQTU9asTR6EJYxJrlz6nxJ716AIWep4d
         E/QaxJ9/WD76L9Jf/PJByFHWnHkSz7dqIytdxtXifOhd9hqy+B74V0+h5mhmGeKG7M0i
         yG3OHaRZ8dniQ37RPqcVly3T3iHDVEoN1PJd1zqQpNStflILoDN3CDhRpR1nQo4yvjFA
         d8oaAxfMxz9tq0t3X+Nz28siHncpSOkEvepr8KLH/iu/dEzRfiakhF82U+PzkMvC30oD
         +Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvEjT3LS5Xhx83JzZ7mwoZFRCzRRBgIZ95nhIq4PitI=;
        b=cklXCsFRySIe18YHnMtVSpHqNZzWF5lEok62QBUKtGkeDPMCjEeSVhJLLSFK1GgLVC
         hcfUPKB/ERc1V4C4u4iFcJskXnTGGDcuP7TVp1Vi6F0jqNPyQG+oDDx/Ej8mrAyFcIfX
         vC+Ahxl7axGXMYxZIv/qvx1QW7o9MCxdzCx2oQhAvC7R9j4K9bEfk6d6w3VIaI1vtcLn
         vQmYGQUWVIyArSziGawQowKlKvC5vYfsUO5mrdL2eQE8pOuIDDxRIhJUOExKhARrbjjA
         EB3ZUVtPNDCPmDFhNK0osBV4tygH37s9MGjsMhtnMiSy5f9yk76IBTc40sONgUgEYXdr
         skzw==
X-Gm-Message-State: AOAM532HM6WVyCgzuufhNMloPmPq+CwV/xSN9CLCs1JvIzevWj/+c2G9
        +vBnSiY2MHpR+uBHwYBAIy17mMsYTMk=
X-Google-Smtp-Source: ABdhPJzR2r+RLfMOCbUCzVqFmzXHYzuMuFTnRdHDv8TpQfeQSF8Er22e3AGmZcX9epK6QmzNqSXF2Q==
X-Received: by 2002:ac8:4e2f:: with SMTP id d15mr15469906qtw.196.1592222010640;
        Mon, 15 Jun 2020 04:53:30 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f43sm12543781qte.58.2020.06.15.04.53.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:53:30 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] branch: don't mix --edit-description
Date:   Mon, 15 Jun 2020 07:53:20 -0400
Message-Id: <1d0eebd1ecf24db0241801af31d904a19ad391a8.1592221875.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592221875.git.liu.denton@gmail.com>
References: <cover.1592221875.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git branch` accepts `--edit-description` in conjunction with other
arguments. However, `--edit-description` is its own mode, similar to
`--set-upstream-to`, which is also made mutually exclusive with other
modes. Prevent `--edit-description` from being mixed with other modes.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index accb61b1aa..99633ad004 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -693,7 +693,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		list = 1;
 
 	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
-	    list + unset_upstream > 1)
+	    list + edit_description + unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (filter.abbrev == -1)
-- 
2.27.0.132.g321788e831

