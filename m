Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC5BC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245489AbiC1TNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC1TNf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:13:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED766AFD
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:11:53 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r11-20020a63440b000000b0038068f34b0cso7379293pga.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zODZQjxc0KTlnGF7R5lE+G3y2toI8Hx/er5T5WWzE78=;
        b=XoCoLFFIP5s1TDerIFZm5BFM+nv23X6nkgZwLbTekFb7WZODxVLvHnGk4HL8XUpVhY
         DtXhKU53YmvahZjkS8ncoHV4VBdhoL3tZs16rdYVROIXLbUELYnoPWHk4PcaUv+7E1VK
         d5jPXG52FmIZS9GjD0VCQ5SROR4OYciyf+m3IUDsCun7Mx0a8pTpN6l8uUt2VAG1LlGz
         LM/lWMuz1fvwJpb/R0fxI1GQLYvkMMbnEtcpSW7sJ6v8naFVo+Wf62r45CO1+qGqAMON
         vWpR7oHgooFbAcXeZocPRnmIKwwLOCQKtY6snhCP32mvNTDjYGpNK/p5EwAh7ONOwXNN
         q+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zODZQjxc0KTlnGF7R5lE+G3y2toI8Hx/er5T5WWzE78=;
        b=rWUfhpnMxVhaGaIHxvJFg1lnj+tWA8byniO8r1bB8QWjVCX9ny9t1PBB0lU5i/qzfM
         7AzU+iCY0Gdq6iFNdUI0WtIWn2RbIUnLk5SBBqcukCbbJM+8MYY6SuxFVCDGFWufvEZ5
         OLAlAB5auoEQm4dwDu/S6j5+pLcDCa43qYM39m0BRHAFgfeOpfFVOh7vsNuZ/bkk84yQ
         RubUW2lAeAfQWyQN75OK5zIJCXDZZJuX/kkSoZf9L5/JCWxqlYb5332sYRk+jIQPcZDu
         6gKHQF50sIQ0NmRMVTjZcuj+qGSfZ+tGWPJ6C+9lv4vasL6ahI+5N0bhxB3+aW8spGk/
         omEA==
X-Gm-Message-State: AOAM532ZBqeKxDKhpKFzkWm/2dsyNP00qbGPZ7xRs0unn5j2v4Envpyx
        7n154fUNA21jA5DQNh99p8poXJcoSasmLUs3EzcPxuDxztuaoZ/fqaxLoqQH1kUkcNzRHPNhwiw
        Vm61Dx8jV9ByZZHMBiENuQspbAItpljGh1EUQTxY9yBcV50n666JSXXWwL+pJPHnB1w==
X-Google-Smtp-Source: ABdhPJxu7thJJsQ29CsG3NAHjCOJOhQQCPTNtajZu5YRrC3SQhkrO6pumi8DF2aCZGiffTheRmN6iDqgD5zlBII=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:5407:b0:1bf:43ce:f11b with SMTP
 id z7-20020a17090a540700b001bf43cef11bmr625941pjh.31.1648494713269; Mon, 28
 Mar 2022 12:11:53 -0700 (PDT)
Date:   Mon, 28 Mar 2022 19:11:11 +0000
In-Reply-To: <20220328191112.3092139-1-calvinwan@google.com>
Message-Id: <20220328191112.3092139-3-calvinwan@google.com>
Mime-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com> <20220328191112.3092139-1-calvinwan@google.com>
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: [PATCH v3 2/3] transfer.advertiseObjectInfo: add object-info config
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, object-info is always advertised by the server. Add a
config option to optionally advertise it. A subsequent patch uses this
option for testing.

---
 Documentation/config/transfer.txt |  4 ++++
 protocol-caps.c                   | 11 +++++++++++
 protocol-caps.h                   |  6 ++++++
 serve.c                           |  2 +-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index b49429eb4d..14892a3155 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -77,3 +77,7 @@ transfer.unpackLimit::
 transfer.advertiseSID::
 	Boolean. When true, client and server processes will advertise their
 	unique session IDs to their remote counterpart. Defaults to false.
+
+transfer.advertiseObjectInfo::
+	Boolean. When true or not set, server processes will advertise its
+	ability to accept `object-info` command requests
\ No newline at end of file
diff --git a/protocol-caps.c b/protocol-caps.c
index bbde91810a..f290e3cca2 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -8,6 +8,9 @@
 #include "object-store.h"
 #include "string-list.h"
 #include "strbuf.h"
+#include "config.h"
+
+static int advertise_object_info = -1;
 
 struct requested_info {
 	unsigned size : 1;
@@ -111,3 +114,11 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
 
 	return 0;
 }
+
+int object_info_advertise(struct repository *r, struct strbuf *value)
+{
+	if (advertise_object_info == -1 &&
+		git_config_get_bool("transfer.advertiseObjectInfo", &advertise_object_info))
+		advertise_object_info = 0;
+	return advertise_object_info;
+}
diff --git a/protocol-caps.h b/protocol-caps.h
index 15c4550360..36f7a46b37 100644
--- a/protocol-caps.h
+++ b/protocol-caps.h
@@ -5,4 +5,10 @@ struct repository;
 struct packet_reader;
 int cap_object_info(struct repository *r, struct packet_reader *request);
 
+/*
+ * Advertises object-info capability if "objectinfo.advertise" is either
+ * set to true or not set
+ */
+int object_info_advertise(struct repository *r, struct strbuf *value);
+
 #endif /* PROTOCOL_CAPS_H */
diff --git a/serve.c b/serve.c
index b3fe9b5126..fb4ad367a7 100644
--- a/serve.c
+++ b/serve.c
@@ -133,7 +133,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "object-info",
-		.advertise = always_advertise,
+		.advertise = object_info_advertise,
 		.command = cap_object_info,
 	},
 };
-- 
2.33.0.664.g0785eb7698

