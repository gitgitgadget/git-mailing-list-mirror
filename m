Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93152C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhLHMiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhLHMiD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:38:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8783FC061A32
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:34:31 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u17so3863277wrt.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KanFhJYJgnSiPm0LhzXvt+tSGW3FBlu5niqsG7uqiKU=;
        b=i5xeU58T6SZiBWwNe0mSdiUcy8qaFetXDwDg8RY8JC2MEKDUvOBVtb0QHNhc2rcrs4
         yHUlFZwVqxPXhvVp+BlMM7ZHTCAtQzZ64uF1AO+GeHCqYbWg1nnNmtF7s2Wa47gcKW3F
         v8gzhBERQiDv2S2wGHgzqKGMJzKMxSzsUClEKRrwsam0QIqRp4iVawPGMqf7Y5fXQCjE
         SL8NM94cQgbVzimu1rhWbiDCCrsUJo1UUCBZWZ6ZTAO1N8wN6eS6IYUW1q07gryO7+WW
         ViEoEK64t0/eDX41b/narYy1+pNkIEXIIu8UfFL0ocNrgNUmEAl3SfqAOTJS9J7NRKfw
         IcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KanFhJYJgnSiPm0LhzXvt+tSGW3FBlu5niqsG7uqiKU=;
        b=ixjZkNs/2yK9TNkQIWopraGg46ukHv+OE3R39N3IZLAhiiK4E131ChYH1eX88MOmSJ
         c1aZhswygxnBnbew3hyyFSdpJ8gxPR3SgrdQ6Vu+1ri+dNBeWbPv29tv2Dg0JlF2eQed
         zo8z8RGc7Nnb+4Xit8G+D7wDLfF8HElnI9+e4lpZLh4OGfDoC56XnbxXzkRGKmtqGg0k
         UoBms7AZcXHHDiLUnredLA3NvRRbRCcwxBUl7nCQYwnSLWiavr7QEcM0C0XQ9UQOIcvw
         pR+8hRAmuXH6+0g+kKw7HmoK3Jl65ikQpimSt3hSx9/BQvszwT0nDdrEkQEXtf7Ify+i
         p2IQ==
X-Gm-Message-State: AOAM531MT6ckarBVpwUsGdQWyMdz9lLqrUh8siuMCNkO9StV/vZK+JT6
        sOUPQWNlgTbRuOxznYufMR1Hzk2CvDYjfQ==
X-Google-Smtp-Source: ABdhPJwAx2FOXNa6mhHloMXfzk7i4tnMBCfJuS+9cKZ3Z/uqrupUqSz/mLgKqdUPuBS3xKdB1zh5/w==
X-Received: by 2002:adf:fb47:: with SMTP id c7mr59085657wrs.602.1638966869846;
        Wed, 08 Dec 2021 04:34:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2540692wrm.76.2021.12.08.04.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:34:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/10] cat-file docs: fix SYNOPSIS and "-h" output
Date:   Wed,  8 Dec 2021 13:34:17 +0100
Message-Id: <patch-v4-04.10-aa384803fef-20211208T123151Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.926.g895e15e0c0c
In-Reply-To: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
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
2.34.1.926.g895e15e0c0c

