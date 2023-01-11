Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A179BC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbjAKWOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjAKWNW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768A3E0E1
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w1so16417895wrt.8
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czUORvxUFPS2+/W3hB2lr7qcIFurTGIuT+ES164BjhI=;
        b=CMPPLJPTmulIcXy8rsmod2NA9oUsnWH1uTigQJqV64TbA8NkiKfDxtJ+3T+UVAOWDf
         10pNCy8zWmQui+AhvQk7ofnc9zxMB1O3UnnqjRtmRhWizfIfHFZrrIA5wBfgNYIwnCYA
         ZyvuwjqiVpv1zU8JbBXXwjxNr0Agc085HZPX2AV3a6x7u+dYqmGeI5FlkkNneCR2/7AG
         V3bQhWSrOhJSWPBU4/IwKi0g3HPCbGjbjRE6A+TNJnAAtv1lOzqggMr+8+nRSczaoeyv
         3LDLmlCS0KP6L9OsCLPyenSD8LmbqY0DFTztV5YZZl69NUl2EQt/2/bcndxoYd/puPLA
         ra5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czUORvxUFPS2+/W3hB2lr7qcIFurTGIuT+ES164BjhI=;
        b=35SqvUN79WaWr7npyIEa4s5+g3Em4cGKBbhuDBcHRD40HAyd4v3uNn1lM9oddDrw6k
         u5oxMSCrQZB7kw19mzcEYPT1mA1vQxORFixE2WRoesoIXH3sKE7nlzy7+vNiEsLgCObd
         DHzmBMl0AZGR0td1NU6p8p7V/fzrbxuucCPciqWBzHJ1EcnB2i/Xh7d06gFKxXzX1tYl
         8qpVR0bqvFYQJSNKa9goa1Js9EciWnrlAEK0Y0e1UfPssVgYOu59ahY9hKNGbW0jCEfm
         +QiEbwENHDSttRyWQDr02UgN3ZH1qgf6wo0g075PE9hkhqOF9F2FP+OEp2A7OGLKDbHG
         +SpQ==
X-Gm-Message-State: AFqh2kpQaoIVhHddAq2FLqB5GsREejIzbLk2BmLGxX0noaHWA8urwWiI
        0TkYIRLTd6e8BFa+e3mh27dJaj9M57Y=
X-Google-Smtp-Source: AMrXdXvsammvzVNmae9HMd1PJfoWNBE6Eq83n0hYX6ga586uP90UHBEEejOzZTlW5F0u2KG3FgXK+g==
X-Received: by 2002:adf:ec4f:0:b0:27b:a73e:33ae with SMTP id w15-20020adfec4f000000b0027ba73e33aemr38816611wrn.8.1673475200125;
        Wed, 11 Jan 2023 14:13:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020adffa4f000000b002bbec19c8acsm9456893wrr.64.2023.01.11.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:19 -0800 (PST)
Message-Id: <65a620b08ef359e29d678497f1b529e3ce6477b1.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:08 +0000
Subject: [PATCH v5 08/10] strvec: expose strvec_push_nodup for external use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Remove the static modifier from the existing `strvec_push_nodup`
function and define the function is `strvec.h` to make it available for
other callers, making it now possible to append to a `struct strvec`
array without duplication.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 strvec.c | 2 +-
 strvec.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/strvec.c b/strvec.c
index 61a76ce6cb9..26e8751cae0 100644
--- a/strvec.c
+++ b/strvec.c
@@ -10,7 +10,7 @@ void strvec_init(struct strvec *array)
 	memcpy(array, &blank, sizeof(*array));
 }
 
-static void strvec_push_nodup(struct strvec *array, const char *value)
+void strvec_push_nodup(struct strvec *array, const char *value)
 {
 	if (array->v == empty_strvec)
 		array->v = NULL;
diff --git a/strvec.h b/strvec.h
index 9f55c8766ba..5d61dd73680 100644
--- a/strvec.h
+++ b/strvec.h
@@ -43,6 +43,9 @@ struct strvec {
  */
 void strvec_init(struct strvec *);
 
+/* Push a string onto the end of the array without copying. */
+void strvec_push_nodup(struct strvec *array, const char *value);
+
 /* Push a copy of a string onto the end of the array. */
 const char *strvec_push(struct strvec *, const char *);
 
-- 
gitgitgadget

