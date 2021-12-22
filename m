Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC3DC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhLVENP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242205AbhLVENM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:12 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2CBC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g132so718708wmg.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVsN6t+NG01Cid8zVoPG3N7LWzIKIm13EchOPgDGL0Y=;
        b=aXnx7vzh0l9tJi6cLls4/1sA5ErEwUL05+DMzDwGY9LnE3FYdnx9MgtwEbSrQJIu81
         cpBSVVYABa/pO7eZIl3i1O3deyXNb1J/1pTBG/0cd1UNIdUDDb4CFhyj/c0piD+d8y1d
         hL4us5KhIrWvbvX9fq2IF9zVuphMGJw9emfOG6xcb/BqfAIbJmd+8gQLK7aWjOVvr/Zp
         Xy1DNXINW6BnLB1HFShC32ia3MSRTgdvEcKwpOZyHbVDDZ+Bhsard3GG3/GLx0ILig6V
         1wMTe15PStgXomgZL/QTO0c5bWSJ8UXD5zUfxdjekaB0xDolwTqX/0+sX06uBpm12NEB
         miuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVsN6t+NG01Cid8zVoPG3N7LWzIKIm13EchOPgDGL0Y=;
        b=1x4ztniEwVLMd9Cx7geHHnhC1rHoWIoX+LP6VfhKNKgO6JIy3SI75fKnXVEodhoUN3
         iZqNJJRdJ+C3yCE5HoTFVeLl89FdukN5qtMqAd7A/0SjKNctFblEumvED/cId3wOaosT
         +5cnj+zUy2uf9veXs6MiYQqL43Yhu1/0rSDIKnPEp5FfYmchFk0KKiS3r0RQyssQ8hN8
         g+XAPfBxKMk0HYVuIqYXF/HRfkIkS9XgHgOFx7+zGDhhrCLVKbNdiKGo4Snfz8qsCbuU
         E6Dy7F+NtjbIDnHirOlvxqpXD9+ktMBV7N0T/SDvrShiDvCbYB3E+K8i0vOc4JVa/QER
         c0Wg==
X-Gm-Message-State: AOAM533ksNR8B++Czq8slwgXt2go1KI4UT+2WSPPfRrGC+KdG4QJPEgD
        3hjelkNV4Hu2Kooi8BinaQnidOb5qE8eYw==
X-Google-Smtp-Source: ABdhPJzjRldPEKtwa8CL+ktayWgk8/kzqul+ulJ8YXj8tLB1aw30+fy7jupeQ9HHIKBYKDmEd93Gbw==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr929080wmb.28.1640146390053;
        Tue, 21 Dec 2021 20:13:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/10] cat-file docs: fix SYNOPSIS and "-h" output
Date:   Wed, 22 Dec 2021 05:12:57 +0100
Message-Id: <patch-v5-04.10-2a28b39430e-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were various inaccuracies in the previous SYNOPSIS output,
e.g. "--path" is not something that can optionally go with any options
except --textconv or --filters, as the output implied.

The opening line of the DESCRIPTION section is also "In its first
form[...]", which refers to "git cat-file <type> <object>", but the
SYNOPSIS section wasn't showing that as the first form!

That part of the documentation made sense in
d83a42f34a6 (Documentation: minor grammatical fixes in
git-cat-file.txt, 2009-03-22) when it was introduced, but since then
various options that were added have made that intro make no sense in
the context it was in. Now the two will match again.

The usage output here is not properly aligned on "master" currently,
but will be with my in-flight 4631cfc20bd (parse-options: properly
align continued usage output, 2021-09-21), so let's indent things
correctly in the C code in anticipation of that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-cat-file.txt | 10 ++++++++--
 builtin/cat-file.c             | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 27b27e2b300..73ebbc70ee2 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,8 +9,14 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--path=<path>] <object>
-'git cat-file' (--batch[=<format>] | --batch-check[=<format>]) [ --textconv | --filters ] [--follow-symlinks]
+'git cat-file' <type> <object>
+'git cat-file' (-e | -p) <object>
+'git cat-file' ( -t | -s ) [--allow-unknown-type] <object>
+'git cat-file' (--batch | --batch-check) [--batch-all-objects]
+	     [--buffer] [--follow-symlinks] [--unordered]
+	     [--textconv | --filters]
+'git cat-file' (--textconv | --filters )
+	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 86fc03242b8..1df7f797cb6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -619,8 +619,14 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -p | <type> | --textconv | --filters) [--path=<path>] <object>"),
-	N_("git cat-file (--batch[=<format>] | --batch-check[=<format>]) [--follow-symlinks] [--textconv | --filters]"),
+	N_("git cat-file <type> <object>"),
+	N_("git cat-file (-e | -p) <object>"),
+	N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
+	N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
+	   "             [--buffer] [--follow-symlinks] [--unordered]\n"
+	   "             [--textconv | --filters]"),
+	N_("git cat-file (--textconv | --filters )\n"
+	   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 	NULL
 };
 
-- 
2.34.1.1146.gb52885e7c44

