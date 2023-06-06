Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B13C77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjFFCIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjFFCIb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C936D11C
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so4010772f8f.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017309; x=1688609309;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAzdVs31j9ocwgc2w0Elu7l4swsEpKP736YN05aDSR8=;
        b=D32R4pAyP6ocjwgJJ1r5C+1LHU5Il3NVpDjjMplL5GMd5Z3OdrBAHj3QL2ZIRKLXPz
         dEzugOXm6JjbmUQ3k4LK7FU0myKhWV5+x2vAId7Pc3/WTrSnYzhr7XU6VCv85vQ32rGi
         NMgOOpmX6ynMAdngbmO/jk7a5mJV7yV+l65qLuKb4RiBTRWEiSnxYKI38mb7QLxkrEb1
         MWbL2hXqNyz6ZO674ElonLK82v/H0lO6JSxo5cDEwUP9iBzG+8AgUnBM3ZmKF1nJXn5e
         xMh36NME/Lt1hyHIyAUH/URxtg0pSM9NDaDpOBD5BE3IFLUITbaRHCBtrCUJo+Av+gBE
         p+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017309; x=1688609309;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAzdVs31j9ocwgc2w0Elu7l4swsEpKP736YN05aDSR8=;
        b=FCCsQM1wltPkLtrvRrHejj88nTTOxlzCsdgi+84lrH0jeiIoR60FZR0jngeT2PlVEE
         de+RUBGzufUktVGDjGGPpJUKjG0Q3stRyrMCyzQ8YYo4qFeAqE57nEYkY55aBEcj52d2
         b30FxQWVFEmzdEgMoSdI+fqhqfD28H83DfcrdUKVeLojQDz5D15BBFYS4+NGWbvQMszD
         4jDj1H/Vt/H8wjiBCAUhlzGGCpVfGxWR3vuJ2EXE+xtt1azhWlSPdqzrfEBHfQGn9sqX
         9/eYQAMHxePBuox2CTrgR2oggImM6p1cTOu9aZYbnyjA6uIPwmf3ys5uefOFXqauYJuG
         pRNg==
X-Gm-Message-State: AC+VfDyTPgge9ejDasuXDzRVbBOSLc9PureZKGP/eWW8uyZRL/fr0sRb
        zfXfRTP4eYKpdR4lYVF6IV7W2ptqUgg=
X-Google-Smtp-Source: ACHHUZ7NkMuFGCsPcNovARjist0RFSbWPy+2txOZflFUKo4GZOOnPTqm7hxqu+rPgZbA+kiRn6tC7w==
X-Received: by 2002:adf:f54a:0:b0:309:31ac:6663 with SMTP id j10-20020adff54a000000b0030931ac6663mr442159wrp.16.1686017309016;
        Mon, 05 Jun 2023 19:08:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d6841000000b003079c402762sm11159692wrw.19.2023.06.05.19.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:28 -0700 (PDT)
Message-Id: <f99545409dc66187ae7995238958cc10ae508c03.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:21 +0000
Subject: [PATCH v3 6/9] doc: trailer: use angle brackets for <token> and
 <value>
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

We already use angle brackets elsewhere, so this makes things more
consistent.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index d1d3e50bde7..d69851dd367 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -65,9 +65,9 @@ non-whitespace lines before a line that starts with '---' (followed by a
 space or the end of the line).
 
 When reading trailers, there can be no whitespace before or inside the
-token, but any number of regular space and tab characters are allowed
-between the token and the separator. There can be whitespaces before,
-inside or after the value. The value may be split over multiple lines
+<token>, but any number of regular space and tab characters are allowed
+between the <token> and the separator. There can be whitespaces before,
+inside or after the <value>. The <value> may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
 the "folding" in RFC 822.
 
@@ -240,7 +240,7 @@ trailer.<token>.command::
 	This option behaves in the same way as 'trailer.<token>.cmd', except
 	that it doesn't pass anything as argument to the specified command.
 	Instead the first occurrence of substring $ARG is replaced by the
-	value that would be passed as argument.
+	<value> that would be passed as argument.
 +
 The 'trailer.<token>.command' option has been deprecated in favor of
 'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
-- 
gitgitgadget

