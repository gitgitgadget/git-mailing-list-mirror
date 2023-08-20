Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7566EE49A4
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 09:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHTI75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHTI74 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 04:59:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFAAEC
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3feddbb670cso11111495e9.3
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521695; x=1693126495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjONEozaizDuIj7r8Z8I6bm4as5NrbCS2U96FB17dbk=;
        b=VXLElxbeIqd9xyUULlXHyU6mc0yseyzY3De9o9A01RG+aIIfCU6m8Z/rMVb2jrNS/8
         zsciPVZmDID0LZ6nVjZMHndMCdxVuxJ9dlkLR6DRK9Lh8C4Zl6y2/PG5qlAHrCp0nvv8
         pMkplI16ovS3oT3mybaLaOhZSd5s5IzGBN5WHX2ypxoi8CUDAdtclTMaZj/2XlgDmHPS
         AOX+HFraBC3DBAJG5nZFsn0aZe7eHRfPsrswNh0JHBRBYtgcbLYiWGzSds7PtKShNVyB
         bdWbQU1gm096HFi6st87dJxM7viAicsvpKqNhkZW++hl2YPNKjPr+qRC/JmYks4NRi+T
         nHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521695; x=1693126495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjONEozaizDuIj7r8Z8I6bm4as5NrbCS2U96FB17dbk=;
        b=dHcLabH9Bz8jZUm83Y6zW+7pa4t/1ioDZnxzEXM+LD9lJgNLFRBPzp8Z1Qmx3cKl5E
         4Btv8efr6XEy0gHi178veB2XwrYdzqlzTKL2V8tNJvSDwQygHKK01K9qV2sKeP3NYP7o
         UW7ay6hekiDcZASsX9BWrHV0q71ykYDa2/iKFKQhHljlNfAkT2laQXFyIhcwwF1CP4tN
         oVvcQAkdJYMWP44Py5F3LDF3N2VpIv8xCIMOt9Fittf0TmSWTh5Dy7tIFA3rwyspnNTd
         hedGdP2b2nEZ0Y2E2BlFq3UTluQ8Bx6tSUynT/Re2xPwVsoZ9jYlB6zOVHoOV5foI9Iw
         4zGQ==
X-Gm-Message-State: AOJu0YyqQCJ4bAR7QJeHDby1o0TjU1+233agoNrhYsBM5Cma/voN9eat
        jBQAqGV/Rx5np2KPg6rimNOrA23erWHoTHEu
X-Google-Smtp-Source: AGHT+IFE0nV4xPJ9fRyxAPmGAj7OyUGM900fia8ux0Nl824Evsod914KqrlQIv3eJl7ybjE01ogbmw==
X-Received: by 2002:a7b:c051:0:b0:3fc:a49:4c05 with SMTP id u17-20020a7bc051000000b003fc0a494c05mr2495925wmc.40.1692521694397;
        Sun, 20 Aug 2023 01:54:54 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:54 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 2/8] pretty-formats: enclose options in angle brackets
Date:   Sun, 20 Aug 2023 09:53:30 +0100
Message-ID: <20230820085336.8615-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
 <20230820085336.8615-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enclose the 'options' placeholders in the %(describe) and %(trailers)
format specifiers in angle brackets to clarify that they are
placeholders rather than keywords.

Also remove the indentation from their descriptions, instead of
increasing it to account for the extra two angle bracket in the
headings. The indentation isn't required by asciidoc, it doesn't reflect
how the output text is formatted, and it's inconsistent with the
following bullet points that are at the same level in the output.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/pretty-formats.txt | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 5e1432951b..851a9878e6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -224,13 +224,11 @@ The placeholders are:
 	linkgit:git-rev-list[1])
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
-'%(describe[:options])':: human-readable name, like
-			  linkgit:git-describe[1]; empty string for
-			  undescribable commits.  The `describe` string
-			  may be followed by a colon and zero or more
-			  comma-separated options.  Descriptions can be
-			  inconsistent when tags are added or removed at
-			  the same time.
+'%(describe[:<options>])'::
+human-readable name, like linkgit:git-describe[1]; empty string for
+undescribable commits.  The `describe` string may be followed by a colon and
+zero or more comma-separated options.  Descriptions can be inconsistent when
+tags are added or removed at the same time.
 +
 ** 'tags[=<bool-value>]': Instead of only considering annotated tags,
    consider lightweight tags as well.
@@ -283,13 +281,11 @@ endif::git-rev-list[]
 '%gE':: reflog identity email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%gs':: reflog subject
-'%(trailers[:options])':: display the trailers of the body as
-			  interpreted by
-			  linkgit:git-interpret-trailers[1]. The
-			  `trailers` string may be followed by a colon
-			  and zero or more comma-separated options.
-			  If any option is provided multiple times the
-			  last occurrence wins.
+'%(trailers[:<options>])'::
+display the trailers of the body as interpreted by
+linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
+a colon and zero or more comma-separated options. If any option is provided
+multiple times, the last occurrence wins.
 +
 ** 'key=<key>': only show trailers with specified <key>. Matching is done
    case-insensitively and trailing colon is optional. If option is
-- 
2.42.0-rc2

