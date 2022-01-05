Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BEC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 08:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiAEITG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 03:19:06 -0500
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:60004 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238467AbiAEIS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 03:18:59 -0500
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:d7a9:f807:da56:3cee])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id AE6F158F30B;
        Wed,  5 Jan 2022 09:18:52 +0100 (CET)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1641370732; bh=0aYoilTQaXLi64f4+EWmJEibUQiAUwbbh2shryAUwKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oRMGPWlgKUKzhows7rQ84RlNR6h0RKg+plPiQfOKMLVMis/lZGSEUFiUOJQPQfzXt
         WqyP6POeojWxsLdDCku3TXXBhjfAozkFK+XAWyk5EsZR2KZn9EIiwDXfJop+XoI1sv
         MBZWe6XYC7XPe2gIaBy++GgHSKAbz8ef93w0ITJw=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v2 1/1] grep: align default colors with GNU grep ones
Date:   Wed,  5 Jan 2022 09:18:35 +0100
Message-Id: <20220105081835.4949-2-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105081835.4949-1-lenaic@lhuard.fr>
References: <20211216115622.85506-1-lenaic@lhuard.fr>
 <20220105081835.4949-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep shares a lot of options with the standard grep tool.
Like GNU grep, it has coloring options to highlight the matching text.
And like it, it has options to customize the various colored parts.

This patch updates the default git-grep colors to make them match the
GNU grep default ones [1].

It was possible to get the same result by setting the various `color.grep.<slot>`
options, but this patch makes `git grep --color` share the same color scheme as
`grep --color` by default without any user configuration.

[1] https://www.man7.org/linux/man-pages/man1/grep.1.html#ENVIRONMENT

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 grep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index fe847a0111..ca4f321cb3 100644
--- a/grep.c
+++ b/grep.c
@@ -26,10 +26,10 @@ static struct grep_opt grep_defaults = {
 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED,
 	.colors = {
 		[GREP_COLOR_CONTEXT] = "",
-		[GREP_COLOR_FILENAME] = "",
+		[GREP_COLOR_FILENAME] = GIT_COLOR_MAGENTA,
 		[GREP_COLOR_FUNCTION] = "",
-		[GREP_COLOR_LINENO] = "",
-		[GREP_COLOR_COLUMNNO] = "",
+		[GREP_COLOR_LINENO] = GIT_COLOR_GREEN,
+		[GREP_COLOR_COLUMNNO] = GIT_COLOR_GREEN,
 		[GREP_COLOR_MATCH_CONTEXT] = GIT_COLOR_BOLD_RED,
 		[GREP_COLOR_MATCH_SELECTED] = GIT_COLOR_BOLD_RED,
 		[GREP_COLOR_SELECTED] = "",
-- 
2.34.1

