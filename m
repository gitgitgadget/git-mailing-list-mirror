Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD0C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149C42075E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/xAWUip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgDHSGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:06:53 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44475 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDHSGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 14:06:52 -0400
Received: by mail-ed1-f54.google.com with SMTP id i16so9817762edy.11
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lmVC2vVIObTOD6U7yw6eX8CQULTILsHJfAvrXkpX/ZU=;
        b=T/xAWUipbsixQAig+HpNW3kiJRfMdJ3QzEn/Hs6gcIe2hIsDJokXJNq3NzNxD00zND
         4ZmY2xKhu5e3UWrPO/6q1oF3wVuNLj8CNuCF8mds9kTbC9D1HunUlWemE42ING811cNk
         DJGcljUiua17fpYYRlRL7g0IiN1Anr+VhqAoRkPngA/HQOM5WTyaGZpQLjOv/tc5Bwcl
         BN84/lEP4yGdvxzI91MrH4vcYnyjxXr3YfjErjASzXe5eGmfU2852mEj/bhEEAaQH+gN
         x7/dD3kbNJzzevhhTWVkUylIxa1H8mc8mCjCbNyWGGY1a3sasKmixEaIxpKQO24vJm+f
         jVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lmVC2vVIObTOD6U7yw6eX8CQULTILsHJfAvrXkpX/ZU=;
        b=WH+ouktWVmGKb3/BjQAaz+dj6zdEBzRDvCubbFTZhdIy91FS+cIcZpHwMew79tktHU
         m80Iht0sZtLXjkI8OoB7BvZBMJKiL9+3qnNJxDq8aqrkYj0U01JCT0p+rrYbxMGSUwc7
         dm4Z/tXnY+gvacNwg+pLPxtMfR+oaocUMCi69rRoibXP8SsZg+7JVhji3wQHvF435+AW
         KURhXmf7e7rbdAHd2GzDJy6h2JUSn8Wkglfa4R5ch6iDmTUMqKlGDi7xq+1AKF8NAXxy
         uDXPK+EuLzJ+ryVX77uzCP48+0ghQgF7SepqORL/vckmYbmo6965VwX+HU8t9MScn/3m
         WYkA==
X-Gm-Message-State: AGi0PubVwuiha/a1l/TjOHV/T6OkKI3ZXF8xyiJU4NIR7LhJ2A3NkvC1
        YKDhiY8bFFdrTFMbSb2sVv2f4USc
X-Google-Smtp-Source: APiQypKevJExzfplocDlR6p0XRHrYDyNoKA5l66JUyXQGwHv/txnrCbjoIXh9VC4chjcQ/i6WSuTxA==
X-Received: by 2002:a17:907:6fc:: with SMTP id yh28mr3570440ejb.326.1586369210392;
        Wed, 08 Apr 2020 11:06:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ga1sm206135ejb.65.2020.04.08.11.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:06:49 -0700 (PDT)
Message-Id: <pull.754.git.git.1586369209374.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 18:06:49 +0000
Subject: [PATCH] mingw: do not treat `COM0` as a reserved file name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 4dc42c6c186 (mingw: refuse paths containing reserved names,
2019-12-21), we started disallowing file names that are reserved, e.g.
`NUL`, `CONOUT$`, etc.

This included `COM<n>` where `<n>` is a digit. Unfortunately, this
includes `COM0` but only `COM1`, ..., `COM9` are reserved, according to
the official documentation, `COM0` is mentioned in the "NT Namespaces"
section but it is explicitly _omitted_ from the list of reserved names:
https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file#naming-conventions

Tests corroborate this: it is totally possible to write a file called
`com0.c` on Windows 10, but not `com1.c`.

So let's tighten the code to disallow only the reserved `COM<n>` file
names, but to allow `COM0` again.

This fixes https://github.com/git-for-windows/git/issues/2470.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: handle COM0 correctly
    
    The code to prevent the reserved COM<n> file names erred on the side of
    simple code, and sadly sacrificed correctness while at it. This fixes
    it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-754%2Fdscho%2Fcom0-is-not-a-reserved-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-754/dscho/com0-is-not-a-reserved-name-v1
Pull-Request: https://github.com/git/git/pull/754

 compat/mingw.c        | 8 +++++---
 t/t0060-path-utils.sh | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d14065d60ec..835a340211e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2581,12 +2581,14 @@ int is_valid_win32_path(const char *path, int allow_literal_nul)
 					continue;
 				}
 				break;
-			case 'c': case 'C': /* COM<N>, CON, CONIN$, CONOUT$ */
+			case 'c': case 'C':
+				/* COM1 ... COM9, CON, CONIN$, CONOUT$ */
 				if ((c = path[++i]) != 'o' && c != 'O')
 					goto not_a_reserved_name;
 				c = path[++i];
-				if (c == 'm' || c == 'M') { /* COM<N> */
-					if (!isdigit(path[++i]))
+				if (c == 'm' || c == 'M') { /* COM1 ... COM9 */
+					c = path[++i];
+					if (c < '1' || c > '9')
 						goto not_a_reserved_name;
 				} else if (c == 'n' || c == 'N') { /* CON */
 					c = path[i + 1];
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 2ea2d00c39a..56db5c8abab 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -476,6 +476,7 @@ test_expect_success MINGW 'is_valid_path() on Windows' '
 		C:\\git \
 		comm \
 		conout.c \
+		com0.c \
 		lptN \
 		\
 		--not \
@@ -488,6 +489,7 @@ test_expect_success MINGW 'is_valid_path() on Windows' '
 		"AUX.c" \
 		"abc/conOut\$  .xyz/test" \
 		lpt8 \
+		com9.c \
 		"lpt*" \
 		Nul \
 		"PRN./abc"

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
