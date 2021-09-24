Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE84C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C3460EE9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbhIXPlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbhIXPkw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FD9C06173F
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w29so28657163wra.8
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RBzcbjRmUFju4/2SfeXbRU/+F75G5LRmbXMUpPAFelo=;
        b=adm/5uXookwNtOKC6xNU6gRZXZoW2bFPuW/qo8jSjBTvVkJe2ULm19+h877BMKt5Td
         03a18uiaK9olD64tv3ezLdfvBnB9Jk5shtJ+FH8Djnevjd3H7XRH95jbGfkX6LLJaVZ3
         oQc7dCZsiFzV4Gh7OJmOldFbkvNTYbPFfcok8gMHBE54Ho1PaqlCSdW2COc7PlqsePZn
         VkRuE4zXQCZGQnTb24o0Vvco2ysP3ieEca+QRKmw8HUk/y+rQwD2JlutvckesPK3qP4D
         MGc+GIulL8azz6UzxRAsLBRhw0sUvUgz51jUxvz9JKGedE0pqGZ4FORqy4vBr5oL5qu4
         gvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RBzcbjRmUFju4/2SfeXbRU/+F75G5LRmbXMUpPAFelo=;
        b=rk0SOn98/ipkxvdZE4isspCSzSb0LIHpEtTEK9zTmHmDYmGwbu6/6bfwUfzEAIRNsL
         W1U4cVESh6qIHktsTW/UExzZhJxx+9i0E7gGzP3n9Lfety/7Sj74P4sHSKAn4RuP41U4
         5HpMw+DSBVT28XcS1yDJtydU4WCXQxhjcMALeNOBvYxxn8Gf5+j/ULz+Ew2bFJAgCb6F
         iBj2SGaah5NPvYc/BjHRxWlODzR+lZlTOC0FvV17gOm6I/YZ+NYgMnPdhzsV9vCspics
         jAlP6cZKRRpfYvPDrDAZjIpxcnsUNwnnSLfXeHzfZINwzbjVAzV59p8JnchxbWU31WPT
         A1VQ==
X-Gm-Message-State: AOAM532dQxG6d9O4RWwM7tCzg9qOD5lkbJ3ZfParvwfhGtWsGRiq3H4h
        mg44PM+7O3DknyNWlTkmUHBgt9r7sIA=
X-Google-Smtp-Source: ABdhPJzGHiVUdaE8Y2lZ1/Fex8Q0kiD2D+/n1/1uzk2PfTB7l0A64NnMEglkq7bPBneRgxfyzg2BUA==
X-Received: by 2002:a5d:6a8f:: with SMTP id s15mr12121166wru.15.1632497957971;
        Fri, 24 Sep 2021 08:39:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b187sm13000582wmd.33.2021.09.24.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:17 -0700 (PDT)
Message-Id: <24bffdab139435173712101aaf72f7277298c99d.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:05 +0000
Subject: [PATCH v4 04/13] dir: fix pattern matching on dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Within match_pathname(), one successful matching category happens when
the pattern is equal to its non-wildcard prefix. At this point, we have
checked that the input 'pathname' matches the pattern up to the prefix
length, and then we subtraced that length from both 'patternlen' and
'namelen'.

In the case of a directory match, this prefix match should be
sufficient. However, the success condition only cared about _exact_
equality here. Instead, we should allow any path that agrees on this
prefix in the case of PATTERN_FLAG_MUSTBEDIR.

This case was not tested before because of the way unpack_trees() would
match a parent directory before visiting the contained paths. This
approach is changing, so we must change this comparison.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 9ea6cfe61cb..174d336c30e 100644
--- a/dir.c
+++ b/dir.c
@@ -1294,7 +1294,7 @@ int match_pathname(const char *pathname, int pathlen,
 		 * then our prefix match is all we need; we
 		 * do not need to call fnmatch at all.
 		 */
-		if (!patternlen && !namelen)
+		if (!patternlen && (!namelen || (flags & PATTERN_FLAG_MUSTBEDIR)))
 			return 1;
 	}
 
-- 
gitgitgadget

