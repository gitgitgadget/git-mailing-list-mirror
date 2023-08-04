Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E8C001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 04:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjHDEIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 00:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjHDEIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 00:08:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853131BD
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 21:08:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so189635e9.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 21:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691122126; x=1691726926;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap1MM7SH0nAcizow+cdIe3UsmsTi3G/1lBsnss43fRM=;
        b=T3jjf3Dqt0X5DCPpPOdzh+n+FjHf/uTcZPhVlTABFcO/z3lxrtqJfYJxMetc0dyEfe
         1EAaCvnxInGFMi4c2h8rkO/jaPPfWM7EYgu2VQ21wV7Zh1EGH1MPEYttZwhWnimQ2lx1
         eoe2KHBAD6LN/2YP6JLsw6KQW7JpXkt6iu3yaBPCCGezy/gqZ3cQY5/43KWzraLSTjp+
         fHTbquNryWb93xtnTKgiGi2t6QJymTg08pCsc4hTVP34G0S0uXWVVYbebme7TWk4X/fy
         BhznxCqnRNsjhGWDX/pcDcW5KpHJDXQy/WrKlRGGRiQSFYDT+0ZjyWacYhVU5adBu20f
         UpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691122126; x=1691726926;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap1MM7SH0nAcizow+cdIe3UsmsTi3G/1lBsnss43fRM=;
        b=jP+0U03OHMtPz0aErz1HDT9J1t32+VjQexCqzXMaPPmZpcWJrJLOr9hHJtm8ZPNp/d
         FZDwavnTxAFksDzWIASYdTBLHOTv7t4pD1ocdqbB3ttKYDD5JMXtkMmaLvZrW5BScCCX
         qOB4tEffec32KuF5M0cxlBZ+1Z1hkwImR17Onc1kfs+yaqviOq5Pl0hbPxughxLYKGlz
         95xubZvKS5jOsPcCvsatzC0Z+hgLO+rqJK1uJ8Tl+/Qd2uenKHDNlwlwKJOciHo7Nau5
         MkJNrWZu2WC28HWt2C7Bm992Kv3VumLjlw9mYq3YY0ORb9MAmIWuxJg6Tn/89f5KhNzO
         1hcg==
X-Gm-Message-State: AOJu0YxKPmXpLThov1Jv8N7KAap5AffJSCNBeDe+gZfXrFdrNK8ufnAj
        Lweim6DTgFAICK2ksgtOaieyLeaby24=
X-Google-Smtp-Source: AGHT+IH8wykpMSJX0Fu1IFb4o6ep4iI4BsAQzAS0Py0yqsLVlxRCEoTTljDrlHEebgcrwUnQGGl58Q==
X-Received: by 2002:a05:600c:212:b0:3fb:ef86:e30 with SMTP id 18-20020a05600c021200b003fbef860e30mr494270wmi.10.1691122126364;
        Thu, 03 Aug 2023 21:08:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17-20020a05600010d100b003141e9e2f81sm1402245wrx.4.2023.08.03.21.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 21:08:46 -0700 (PDT)
Message-ID: <dc9c0812d203a4eb777659bb54fda60022bf9650.1691122124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 04 Aug 2023 04:08:42 +0000
Subject: [PATCH v2 1/3] run-command: conditionally define locate_in_PATH()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

This commit doesn't change any behaviour by itself, but allows us to easily
define compat replacements for locate_in_PATH(). It prepares us for the next
commit that adds a native Windows implementation of locate_in_PATH().

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index 60c94198664..85fc1507288 100644
--- a/run-command.c
+++ b/run-command.c
@@ -170,6 +170,7 @@ int is_executable(const char *name)
 	return st.st_mode & S_IXUSR;
 }
 
+#ifndef locate_in_PATH
 /*
  * Search $PATH for a command.  This emulates the path search that
  * execvp would perform, without actually executing the command so it
@@ -218,6 +219,7 @@ static char *locate_in_PATH(const char *file)
 	strbuf_release(&buf);
 	return NULL;
 }
+#endif
 
 int exists_in_PATH(const char *command)
 {
-- 
gitgitgadget

