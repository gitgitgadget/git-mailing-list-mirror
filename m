Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF92C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbjEKVUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbjEKVTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA530C2
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307664010fdso8450824f8f.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839982; x=1686431982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HxxF6Jn5d97srhMye+JDTpTFGjXfZNv0Ucvbw9dv0o=;
        b=nvXvSISr2oDqvc8dMxGzE8BTCXbBMxvIUj8OA3YMtZ4XGQjUElhez5TjdAGQeAc4zW
         ukBBT+kQGdjO4QPFGa8LDzECmRUQ5n+kzLpzSE/SorZiZ/8GIZdODFsmB+ptmw46cVUQ
         WqoHAtLp5QkHK1h8aVuXpmSiYHdgA26RNPZkX05KtRt1fHqlUb2uKSj7A+XLiIW5LEZt
         WMkRpJvwzFjgrM1ewk0AegUnVmQ6Fvr+23DBGmBMEDm3Y5ExUxVRNBW7VfPMXnK4EnWi
         V/4nldv7qCYctb2kaRSGZy1pLrlWF4urRdZ0IHTJfelufA5hCCjfHKhAbwlX6sKLUWMZ
         AS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839982; x=1686431982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HxxF6Jn5d97srhMye+JDTpTFGjXfZNv0Ucvbw9dv0o=;
        b=A94GUd+8NFIJZsMy00wIOBdlfHb6vGfnY6NXaWLuKTzNWQy2f3rJDb1xs5FM/m9GgZ
         oc8HItQ8Hu+SuktNCxdJOjfQfIuhnXRC014taPFNMQkboFR4cz98tslM/lVTxtMqSNK7
         /zfmy2Zf7WM6wkRb332zNREI+A8RalSK0NZ9zthaOnBzDezlXVMxLhXNGsMQiTyAPpFg
         ViKjYS3P57VSpuJpZTcJcZ1Xp2086H1dGmRtn/t+mr82/0QFp4HJHEmEqogsxz4sXk9u
         TsqXeRuvjzn+VakTvlBUoqUUOZHKzdla+g4miBQOnxjy/jgy2cFen9SMngJjZO4ZGwsA
         kjSg==
X-Gm-Message-State: AC+VfDxBTRWAAd+OnestXH70exxPn/DHnNGogZ1ndAvwoudlqgLFlkpR
        M95JkvF70PCoi44DgMbxlfhXI6j/a1U=
X-Google-Smtp-Source: ACHHUZ6jqNw0jtKcMcfsPZ7H+VSLHml2KrYbdCV+Pb38AAtwOH6LdsHi/GUZyEF85gdQIw3xNqOB6Q==
X-Received: by 2002:a05:6000:10d2:b0:307:8e1b:6ce2 with SMTP id b18-20020a05600010d200b003078e1b6ce2mr11457988wrx.16.1683839982794;
        Thu, 11 May 2023 14:19:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d4104000000b00304832cd960sm21342543wrp.10.2023.05.11.14.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:42 -0700 (PDT)
Message-Id: <7e95198894b7de9b3d16dfa7d686b5fe3bced5b4.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:35 +0000
Subject: [PATCH v2 9/9] doc: trailer: add more examples in DESCRIPTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
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
index 245a66a7a85..e13a5ec6943 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -16,7 +16,18 @@ DESCRIPTION
 -----------
 Add or parse 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
-message.
+message. For example, in the following commit message
+
+------------------------------------------------
+subject
+
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
+
+Signed-off-by: Alice <alice@example.com>
+Signed-off-by: Bob <bob@example.com>
+------------------------------------------------
+
+the last two lines starting with "Signed-off-by" are trailers.
 
 This command reads commit messages from either the
 <file> arguments or the standard input if no <file> is specified.
@@ -71,7 +82,12 @@ When reading trailers, there can be no whitespace before or inside the
 between the <token> and the separator. There can be whitespaces before,
 inside or after the <value>. The <value> may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
-the "folding" in RFC 822.
+the "folding" in RFC 822. Example:
+
+------------------------------------------------
+token: This is a very long value, with spaces and
+  newlines in it.
+------------------------------------------------
 
 Note that trailers do not follow (nor are they intended to follow) many of the
 rules for RFC 822 headers. For example they do not follow the encoding rule.
-- 
gitgitgadget
