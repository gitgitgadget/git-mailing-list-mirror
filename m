Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE6C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0A860E9B
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhHKT7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:59:42 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:37828 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhHKT7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 15:59:41 -0400
Received: by mail-lj1-f178.google.com with SMTP id e11so1083728ljq.4
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 12:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgLPAlkiOPn8Bf4uoKMduhuc7SS3XMaplArMzroXk0Q=;
        b=QqCfC3CNTx8PGG1bzAsYq/c/seQlPLzrie1IBH1+tDvrvEQN9S4aVP9r3a4dUzL34d
         d0x3jAXt+5oa3qML5WR7jQiHNoOIS+NT/1QhoMRQ9rT0M/3W7GEP23Y1zE0N5YJ8h50P
         3nouUgdwzG3vJ36+jywrAakPsWieOXVs62EGImU+hXCU5eQrdzYjw5c0nkGUw8Fk5igU
         Bq+WXhexeLm+zRCJcNE7qMqLjg0yUyrNK7pZ8INSp9HVUwiBJ6SGMNDe0g4v7sIfOaCD
         PhmYLhKbP6xmmDe8cCaXGX6JU51waVhpjoH281oL103w38/rCGttgoud31uVX1j9PH/1
         Sohg==
X-Gm-Message-State: AOAM5324QJn1rBPdT/QWSeoXfWcWyTf9Sc3Bc3X7LXUN+m3db1qsAhsn
        Bpmk7GxF8AZzdUwi5XiOtuaYKBOcpLo=
X-Google-Smtp-Source: ABdhPJyC7cwwWz/OIBln8eILbWaFQzFnA9lssLzVj48oFw+dOKusC2g6s4ytKFkzMQZqPyUNAvLiHA==
X-Received: by 2002:a2e:9847:: with SMTP id e7mr263939ljj.234.1628711955795;
        Wed, 11 Aug 2021 12:59:15 -0700 (PDT)
Received: from localhost.localdomain (dyjfhjkqfhw33tvjwmy2t-4.rev.dnainternet.fi. [2001:14bb:1c8:63a1:a434:af78:44f2:502d])
        by smtp.gmail.com with ESMTPSA id n17sm30755lfu.201.2021.08.11.12.59.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:59:15 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] completion: complete more boolean/-like config values
Date:   Wed, 11 Aug 2021 22:59:13 +0300
Message-Id: <20210811195913.793880-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for completing the boolean or booleanlike config values for
`format.signOff`, `merge.ff`, `pull.ff`, `pull.rebase`, and
`submodule.recurse`.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27ddc8..fdeae5cc05 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2546,6 +2546,18 @@ __git_complete_config_variable_value ()
 		__gitcomp "false true merges preserve interactive" "" "$cur_"
 		return
 		;;
+	format.signOff)
+		__gitcomp "false true" "" "$cur_"
+		return
+		;;
+	merge.ff)
+		__gitcomp "false only" "" "$cur_"
+		return
+		;;
+	pull.ff|pull.rebase)
+		__gitcomp "false only" "" "$cur_"
+		return
+		;;
 	remote.pushdefault)
 		__gitcomp_nl "$(__git_remotes)" "" "$cur_"
 		return
@@ -2615,6 +2627,10 @@ __git_complete_config_variable_value ()
 		__gitcomp "7bit 8bit quoted-printable base64" "" "$cur_"
 		return
 		;;
+	submodule.recurse)
+		__gitcomp "false true" "" "$cur_"
+		return
+		;;
 	*.*)
 		return
 		;;
-- 
2.25.1

