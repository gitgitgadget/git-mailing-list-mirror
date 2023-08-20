Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD9EE49A6
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjHTSz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjHTSz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:55:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD1E6
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3feddbb670cso14255315e9.3
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557454; x=1693162254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lYFoyOUm0uyLgBBlBq5zA6dXDXi78CA769sfDWRkz0=;
        b=OvO+JR9na5Z3AMgsf4Bm+kOeWu53Ykb+l0pQ4APeCv+Io1o4BGNO8dvrUQlboPsruz
         Xx+cqikGmQekTYfh8AwWD68NfL48Xf425a0dxxTgGDzI1aAnQPuJcWxREgZFLrnx3e74
         qFCdA5twuVlrJu8iJAT/fTE/8vGIuVbvJgZ29q007Lt7tHjbbhY4PmQAL4EAa9EwGfg1
         qOEBLHc71HUb+1olF7+DQ8yg7kShlOulMMD0094kmTOZbz6YBPflfJD8cVNWpt+A6yEC
         E4nhLzAQr35z4HkCYLiu6/9qkrB/K2kslN9W4el3zNQax6O6oxTkwMsw7KMTHmeqGyoY
         0VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557454; x=1693162254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lYFoyOUm0uyLgBBlBq5zA6dXDXi78CA769sfDWRkz0=;
        b=Bp9XxRTcJgaEtyEU4pSIIdt+Z1ZEW5L83MNVFxwE0pAFMqtZ+HwIERPZFH5W4gzTof
         /G35UGlzXquZ3OOGqYVY+hCAEIFbKyCpi9GDUAZRlcH+bCk7hKFchXDBePUlAkt5ewlX
         CU9YUelJ0mS/jHLVCJXBIdttL5v//C+quWUnIobNVv6oqU3gifYmMPIZ3uQ/1SwfKKSH
         ANcLnSDD5oIUpSPFQmdghyW4zbZsu6K33ODujt8GD0HWFWOkE7SbPtz8N+m0Io143kad
         cPItFCBMo9d+nyHImSmgtyxTlDVhEJr6q20H/ylAgj8+AgNQUqjICUBcojkHB6kRHv2F
         Rb+w==
X-Gm-Message-State: AOJu0YxYsRHYEtSrI/qjy97KfEVdDp6TUKuPrQE0hHxJa61hmKZQpMjF
        YtEFLljfK3lanX2+rxJx2P8tKgSBs/FmfXBn
X-Google-Smtp-Source: AGHT+IEH2i2UKZ4lp0TEac/+8JgvqbS+Otrknkck1lO68s8GLMNeDVrLCFpEaKGhh4blI5dghUaQwg==
X-Received: by 2002:a05:600c:2218:b0:3fe:2b8c:9f07 with SMTP id z24-20020a05600c221800b003fe2b8c9f07mr3426152wml.1.1692557453689;
        Sun, 20 Aug 2023 11:50:53 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:53 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 2/8] pretty-formats: enclose options in angle brackets
Date:   Sun, 20 Aug 2023 19:50:03 +0100
Message-ID: <20230820185009.20095-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enclose the 'options' placeholders in the documentation of the
%(describe) and %(trailers) format specifiers in angle brackets to
clarify that they are placeholders rather than keywords.

Also remove the indentation from their descriptions, instead of
increasing it to account for the extra two angle brackets in the
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

