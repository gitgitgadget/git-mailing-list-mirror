Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E2C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjEHR20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjEHR2H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:28:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900436A7C
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:28:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f193ca059bso30717475e9.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566880; x=1686158880;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os4sRIRmYmcV41FMax7IRzuuBHIiAQQgzQ5x4lTYH2s=;
        b=kWpF6xEevSzkYx5+cLcLXCyOvYRNfT27ikeUxlLu9qRe7UErF5gGQEUF8xWjyhxLa6
         rk5DAd9WA0NW9rITAoN0y8T9gG0Kr3lK99J0JLLA8eA9seddJ/SvsVIilK7GzXx9x1Tf
         MMvyKTKdw9VE0qcTvftsRjwyOxsP3T9bvb10sWMNnJ1VZU+qyrn2AziBz+DJPdYa7VZ/
         JDhcYS+mwngSughi7/X2y02hrrnkOWq+5lV6Om5ZO+gvDSV1e8IY7HeCx25mApD9zxBL
         JAHNVi/W0VxqmWt5If2DCL8Lr5h4ldCJifwOkNBIRzf+O0IoJIr4vhrPohpLFrOa09Zk
         ImKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566880; x=1686158880;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os4sRIRmYmcV41FMax7IRzuuBHIiAQQgzQ5x4lTYH2s=;
        b=F3gUQYLvm0G0C3mZV2jxKwViAIO3wxuIoanAySOc+E5F3D39GflFpibCESuGMpp2hp
         Hqnm5l4/A4R6iIHK3y5ArwESAhNTQb7EuPaNS5FsPL5kSkvoZvwLaHSfDtRXXG7JOWWx
         2OXo6A5Tqj7HemrrY+K/EsoqzZKwHlW2vK41NOr23pM8tRvcD5BQjP30sj9TnLvImYmd
         VSAIbx1CzJ5NEi+OAk3bVwXxx1YFox+IAh3GkVCm74wSfPWal9aYbquZPrl/L+TZKSBB
         w35HTbqFWs+u5lK71vCZ7dGWPckrG+GdhGSEcjAE6W3dP1/OGpEwDkGckqRIsM6EoAuf
         16IA==
X-Gm-Message-State: AC+VfDx01/jvCNJfCgJcUrpBevRp2sBZmmRt92Th0p99EZK0tKspUm/1
        kh5GsYyvXY/Mcj/ifeEvUV7sWPlghkk=
X-Google-Smtp-Source: ACHHUZ7J3UDT4bWxO7TfaJgY8RRk+Et57bomb2jefDH/tYZK7BP0wo0Jjo5Zj2nZ68yjPSL2qhng3A==
X-Received: by 2002:a1c:7519:0:b0:3f4:2452:9666 with SMTP id o25-20020a1c7519000000b003f424529666mr2901852wmc.40.1683566879521;
        Mon, 08 May 2023 10:27:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b003f318be9442sm17569273wmj.40.2023.05.08.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:59 -0700 (PDT)
Message-Id: <ea483b364b460819c727da5c65497de6ecd4b04f.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:50 +0000
Subject: [PATCH 11/11] doc: trailer: add more examples in DESCRIPTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Be more up-front about what trailers are in practice with examples, to
give the reader a visual cue while they go on to read the rest of the
description.

Also add an example for multiline values.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 119dcd64f34..f31b94a6823 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -16,7 +16,18 @@ DESCRIPTION
 -----------
 Add or parse 'trailer' lines, that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
-message.
+message. For example, in the following commit message
+
+------------------------------------------------
+subject
+
+message
+
+Signed-off-by: Alice <alice@example.com>
+Signed-off-by: Bob <bob@example.com>
+------------------------------------------------
+
+the last two lines starting with "Signed-off-by" are trailers.
 
 This command reads some patches or commit messages from either the
 <file> arguments or the standard input if no <file> is specified. If
@@ -68,7 +79,12 @@ When reading trailers, there can be no whitespace before or inside the
 between the <token> and the separator. There can be whitespaces before,
 inside or after the <value>. The <value> may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
-the "folding" in RFC 822.
+the "folding" in RFC 822. Example:
+
+------------------------------------------------
+token: Lorem ipsum dolor sit amet, consectetur
+  adipiscing elit.
+------------------------------------------------
 
 Note that trailers do not follow (nor are they intended to follow) many of the
 rules for RFC 822 headers. For example they do not follow the encoding rule.
-- 
gitgitgadget
