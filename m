Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6076C77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjFFCIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjFFCIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029F8114
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so24175755e9.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017307; x=1688609307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZW35HIxv10pZ96o/zdDJ1Hk3Aud6H5+AqOJW53iUPo=;
        b=XllSTker4bdOdrLbQWARvC1Y+eH7fdx9jzG9kPr1sSK3qSGmd83EaiDsqh0QEyxGeX
         JCy6BU8WgD7ze8uBzRgaPxUD8LmCibrCTV8Y4LdKbgpgMrhg1Vlc/aT0Tb2AAUz09+su
         rSmPI43Hj9QSSudhgyCqG1I/irPfWpM5+uRczjVhCK2Gv366kYmpOKqgNBFx/9txV8rt
         GfxvfNncV714/ROhn9/XqiacvNl1GZfAU+7FUJUC8lm4z4N1UTI133BVy5r65EvteAz3
         i/0ka2DmaCeeGHmmXR7r4jdkExqsk6GbbLZ+lUP6F2BuV4zbhNjlbJbPTsPDZL7idAdg
         jyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017307; x=1688609307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZW35HIxv10pZ96o/zdDJ1Hk3Aud6H5+AqOJW53iUPo=;
        b=MpOEaAvmefIqDXOpKc/3gMQSjzPvHVBOZuP0j0189rQ3rikO9Fmz8PAyyLOrvnpDGF
         9ekcqIVRqgCzr0PajePwhlksTCCbr6q4J+ZjbYVTrSHmBerTjvQkxmh9F2yYPvCVdf43
         KW5koGoHoW9qUkN0m2V1UR/ZrzfpUqrg15DLVq09eIA3C4y8ejx4a3IJVIQSZDbv2BuI
         nhS6ZxNVuHkZh+lrHgVQZLuTRGj3E3PQ+qQrGy1ZxHMLCQWYMvXktB9ipDPaLbkYPOD4
         /toT6+iTHTwSU5PsUUQrJLCERavl3d+Ci6U51rZGJhF96ki/mj+90AxeBfCovE/O+xsU
         nJXg==
X-Gm-Message-State: AC+VfDy3rRbpo5elLwSdu/0QcFv2RMQ5ag4XdRq/bkA5IvEeIYsFtd/Y
        vC063ZwhxyPPFJaaxY/Fq12cPrBbz04=
X-Google-Smtp-Source: ACHHUZ51NtrOcEaOgPRtH9jli+2r1EOATUkKUzJe26ZTBqbDbkvFxjlEG8NiGSvAHSoYLGjdPfDCUA==
X-Received: by 2002:a05:600c:3783:b0:3f5:fb98:729e with SMTP id o3-20020a05600c378300b003f5fb98729emr721299wmr.22.1686017307056;
        Mon, 05 Jun 2023 19:08:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d458c000000b00307acec258esm11177674wrq.3.2023.06.05.19.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:26 -0700 (PDT)
Message-Id: <e0a56c8e61d80ef345885bf266e9844de289695f.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:18 +0000
Subject: [PATCH v3 3/9] doc: trailer: drop "commit message part" phrasing
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

The command can take inputs that are either just a commit message, or
an email-like output such as git-format-patch which includes a commit
message, "---" divider, and patch part. The existing explanation blends
these two inputs together in the first sentence

    This command reads some patches or commit messages

which then necessitates using the "commit message part" phrasing (as
opposed to just "commit message") because the input is ambiguous per the
above definition.

This change separates the two input types and explains them separately,
and so there is no longer a need to use the "commit message part"
phrase.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 35 +++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index da8fec7d5fe..ffde97a6c3d 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -18,17 +18,22 @@ Add or parse 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
-This command reads some patches or commit messages from either the
-<file> arguments or the standard input if no <file> is specified. If
-`--parse` is specified, the output consists of the parsed trailers.
-
+This command reads commit messages from either the
+<file> arguments or the standard input if no <file> is specified.
+If `--parse` is specified, the output consists of the parsed trailers.
 Otherwise, this command applies the arguments passed using the
-`--trailer` option, if any, to the commit message part of each input
-file. The result is emitted on the standard output.
+`--trailer` option, if any, to each input file. The result is emitted on the
+standard output.
+
+This command can also operate on the output of linkgit:git-format-patch[1],
+which is more elaborate than a plain commit message. Namely, such output
+includes a commit message (as above), a "---" divider line, and a patch part.
+For these inputs, the divider and patch parts are ignored, unless `--no-divider`
+is specified.
 
 Some configuration variables control the way the `--trailer` arguments
-are applied to each commit message and the way any existing trailer in
-the commit message is changed. They also make it possible to
+are applied to each input and the way any existing trailer in
+the input is changed. They also make it possible to
 automatically add some trailers.
 
 By default, a '<token>=<value>' or '<token>:<value>' argument given
@@ -36,7 +41,7 @@ using `--trailer` will be appended after the existing trailers only if
 the last trailer has a different (<token>, <value>) pair (or if there
 is no existing trailer). The <token> and <value> parts will be trimmed
 to remove starting and trailing whitespace, and the resulting trimmed
-<token> and <value> will appear in the message like this:
+<token> and <value> will appear in the output like this:
 
 ------------------------------------------------
 token: value
@@ -47,19 +52,17 @@ This means that the trimmed <token> and <value> will be separated by
 
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
-after the commit message part of the output, and, if there is no line
-with only spaces at the end of the commit message part, one blank line
-will be added before the new trailer.
+at the end of the input. A blank line will be added before the new
+trailer if there isn't one already.
 
-Existing trailers are extracted from the input message by looking for
+Existing trailers are extracted from the input by looking for
 a group of one or more lines that (i) is all trailers, or (ii) contains at
 least one Git-generated or user-configured trailer and consists of at
 least 25% trailers.
 The group must be preceded by one or more empty (or whitespace-only) lines.
-The group must either be at the end of the message or be the last
+The group must either be at the end of the input or be the last
 non-whitespace lines before a line that starts with '---' (followed by a
-space or the end of the line). Such three minus signs start the patch
-part of the message. See also `--no-divider` below.
+space or the end of the line).
 
 When reading trailers, there can be no whitespace before or inside the
 token, but any number of regular space and tab characters are allowed
-- 
gitgitgadget

