Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD6C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 11:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B023261A55
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 11:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353823AbhJALt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353688AbhJALtx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 07:49:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AFDC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 04:48:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p1so1617581pfh.8
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pS/0limH1hJ1oCtuxxQsFxiGr5fkDS1Mc8WAsulZkO4=;
        b=fnvxReLdDNOZt0cHt7/ZaAC+wk6zZltxy2T9hKZYPajSmxBh03CFST7ClLo3Mji3Mb
         fdM3TJl2wpDI2Wmu+y0BTN55ZZhzOYUcUfrAsBjeDOgBJd6/f9B6314gV4eED/uF1qMs
         YMnkQz5zrV+sSPUzvIYiJqvrAxRowZDdcIYA7nmM5y1VBF3PvnoqcFauECekc4rPRTA6
         /nZ6gy3+wv09o67nZ8hf0L+qaOaDJ/Y7B1WD0aWnqaVmK4sl/7v0Aj6RoBzy4RL6PG10
         zt75POErQT6dv3H62zjJ8sY4E12MEWzqH/rOwkgUhb112b0Uv4X30SXERy5Vs2pil2GR
         LJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pS/0limH1hJ1oCtuxxQsFxiGr5fkDS1Mc8WAsulZkO4=;
        b=Oc0KX4lbdVsLN83ndlN/o5khfzCzVdUUgX9VpCnXp1+rWLb28zwD6eCCvgn+bI8DMY
         Q4MNv5Pi4DzIMJrQ/SrPibDdu0yT0UfgX7QehNCjyoCFyQMClMV/ws4969ddZ/5JxWvZ
         /d02XPuXdm/1BlMEvBR9TJHBCj54gpbeKJtBfLN0R/1y/tICG8kjHbMHAOkMMiGCosZ/
         x5GWo1elNp1qzQMX5QJPay4XPuWYkAbH5cR3spyhd6YhT4FOKk2SnNILaVc83nrgbI/W
         j2ONaJcuqXUIeDF0kmieTSZH8NlybrW+H9sS3b54bMsLf7T2XZpdmNQnnT099uX0pR6T
         M+Mw==
X-Gm-Message-State: AOAM530d9WvTYbYxiK0GZXSbot7ZsRHFyv60WJsY4YMGqjMux9cJKaqH
        vl0+fj/HlH9AKfDIYLt8czO+UyOSdwKn0w==
X-Google-Smtp-Source: ABdhPJwBr1J4eM4uyBUinf3IiVcpLbqajiW44gSMy9vuuZq94W7IEDanG6z6M4vk1IBihCC0E1W5Iw==
X-Received: by 2002:a62:79c9:0:b0:44c:2150:90e7 with SMTP id u192-20020a6279c9000000b0044c215090e7mr730119pfc.57.1633088889061;
        Fri, 01 Oct 2021 04:48:09 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-87.three.co.id. [180.214.232.87])
        by smtp.gmail.com with ESMTPSA id v2sm5521555pje.15.2021.10.01.04.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:48:08 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND] bisect--helper: add space between colon and following sentence
Date:   Fri,  1 Oct 2021 18:47:45 +0700
Message-Id: <20211001114744.14190-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing space between colon sentence (`bisect-run failed:`) and the
following sentence (`git bisect--helper --bisect-state`).

Fixes: d1bbbe45df (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13)
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index bc210b23c8..28a2e6a575 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1157,7 +1157,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			printf(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed:'git bisect--helper --bisect-state"
+			error(_("bisect run failed: 'git bisect--helper --bisect-state"
 			" %s' exited with error code %d"), args.v[0], res);
 		} else {
 			continue;

base-commit: cefe983a320c03d7843ac78e73bd513a27806845
-- 
An old man doll... just what I always wanted! - Clara

