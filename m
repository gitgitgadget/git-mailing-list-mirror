Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EDC20248
	for <e@80x24.org>; Thu, 28 Feb 2019 15:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbfB1P1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 10:27:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40377 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbfB1P1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 10:27:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so17308110eds.7
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qeKfQwcLlkFWz4gPjlZ2UmNVoHDBzu39T3HJbs1zShg=;
        b=mnP5ZO9uOGJUdt//pAs/Hh6mzjo49y2h5idaPmQVIA6/j8NcU3GCIS/RTQx/Q4sne3
         E/V3p8R3jGnu6z7zM4yy8FVvFAdLtOzyth6Un1DJnw+x+DciQ5qzTnYBtUGcCiGezihW
         NB4anAOcWzkRjBSGC9NudIICeLGGM+31/5dVs1n/zMgsB9jJLvwwSYHPkjx4RU9fAMUg
         +4Zas+T0MYFfVFQq7JZF4sYXvB1N1IvB+x95RopGe2n1nTb9NoBmCxi9L/Vxqxbi6eQL
         jpBr0kZ0aCiJWBAtgJ9khEOpcDbMYrdH49DzpAF5DiSIc3os0L/9VSlhViDIoDrE6QbC
         QMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qeKfQwcLlkFWz4gPjlZ2UmNVoHDBzu39T3HJbs1zShg=;
        b=K8BQqHeUpAOWNhgeXnV0ArEal6KO+4VEd8rUfQyK+QD2IcTdbXJSuGrzSOBaqog57l
         VVMbi57BoEC5EGLgCA39kV6hRBcfe4wRxnrBDBQBaLQ8ZR6tfZLBhGeUK95+Gh+zTwKu
         +t4dF0JHrUR9JpLzEKnHdrQGK7tOJDvhfBu9NvrpbOJG9EX2X5Qiv4MYOXUJa5DqoWYQ
         YAgNwqqA0e1FVaQ16AsfmLmnlZaSFBmQx/fNwIwpGkHpA3fNOKgOFZF8gqbtEPTp1CCA
         3QoOToLhbKLA+UBoqYL4aVyDQKElwzhg0PtrpjeyQXS1petv/eQTJfr2lyg6+jP8pEua
         swbQ==
X-Gm-Message-State: APjAAAVjDtffZ6CYX0ZOW3rHH59HpBvgP1OowWD6HT0MLPku+x/HmtDK
        s0AdmtCd3iXkfRPTapspEDcluMMj
X-Google-Smtp-Source: APXvYqzK0VDIfYGX/fBwH02bwotpw93leW7c86g6fMfPVnOPK6AnfCekTZXdDS+vrO8XfV8XxWxxWw==
X-Received: by 2002:a50:b1cd:: with SMTP id n13mr137674edd.224.1551367666905;
        Thu, 28 Feb 2019 07:27:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h27sm3205289eja.73.2019.02.28.07.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:27:46 -0800 (PST)
Date:   Thu, 28 Feb 2019 07:27:46 -0800 (PST)
X-Google-Original-Date: Thu, 28 Feb 2019 15:27:42 GMT
Message-Id: <b92d76065d92cb7003dd9d69525a1ed790a93921.1551367664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/4] built-in rebase: use the correct reflog when switching
 branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By mistake, we used the reflog intended for ORIG_HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 813ec284ca..aa469ec964 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -475,7 +475,7 @@ static int reset_head(struct object_id *oid, const char *action,
 				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = update_ref(reflog_orig_head, switch_to_branch, oid,
+		ret = update_ref(reflog_head, switch_to_branch, oid,
 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
 			ret = create_symref("HEAD", switch_to_branch,
-- 
gitgitgadget

