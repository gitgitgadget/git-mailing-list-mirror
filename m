Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB0C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39AA20684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc6W4+Gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLCOCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39231 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfLCOCW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so3585164wmh.4
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1MERttk1qWaqxfrCV4b8uDP13mKag0juDEFZYceBm7s=;
        b=Uc6W4+Gql301rxzoubSQ1kWtxvqqlVD9E3mbmU8GofimtqhMsGrszqWvC22/yR5bdD
         BWNzTy9rtze9YBpGJhdrOUhfvv+i53hpbsCMrruEN+QjHcoPDQhBtqOmCoqS2sc9bvU/
         tj4PmIA8dP7nCr9t2zAuawnbzbFyXW9Od2u141DM3ARTu89LtGofrGtsP6meJqbxIVvh
         lasSHLdApOJLuesvBuo/YNiiYq+aL/JH0rl+kjqQcA2R5Z0mCfnivATy6fBmRVl7+2Kl
         gFJp6A9x/TzMB/dtZWj/Gaem8MYiVqD5wWvIjU2BV4H8BKXb//RYUgMyPPa+zncPzwFn
         WdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1MERttk1qWaqxfrCV4b8uDP13mKag0juDEFZYceBm7s=;
        b=kv/QlK86xua+U6oJEMc8yTulsicWyNdcIipESlt9XroiM2T3x+EYN2o+zHgIypTbtb
         iQiRzD4RNSU99xxL5pUtlWuSz3TalcM+wUmOUPnlEMwzATZTUb8+Yk/tnroGaoZ46dov
         cSW2jgbruPOX2gbTy1QkgKGI8t+3E3YmEonPcBYEN/JT6fDvzSJL/g+Zg+AZg+c02drK
         bsadRHrI576fLfgrfW9GrlcpE62yjpLsttNB9Z72ywLVcoX0swIOLyugm8+hh41a8jyP
         aN3YVskmJFlqZWPwBB50r/PwXk69Bqg+QynXjuo5s6Q7cNG+XgGzjWW/JBZ/AJ6ZcZXu
         vYfA==
X-Gm-Message-State: APjAAAVjQurd3zXzML4cCOmDISCWoZm6cKmYO1xBNVi7c53TxPuNeHGp
        fTq/xWh40e4mRRdaUc0Fipa/AXs+
X-Google-Smtp-Source: APXvYqz1lp6/ov7+1cpcK/sdNPe1Fae+tidJxGnnRuG85PKW/yGqmacB6LX4cCQyBCBYJrPXpuUopg==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr34720328wmk.155.1575381741035;
        Tue, 03 Dec 2019 06:02:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g74sm3025682wme.5.2019.12.03.06.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:20 -0800 (PST)
Message-Id: <cca5aee39229d0d54d88c7dae18dafa956473559.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:06 +0000
Subject: [PATCH v4 01/13] parse-options.h: add new options
 `--pathspec-from-file`, `--pathspec-file-nul`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Support for various porcelain commands will arrive via additional
patches.

`--pathspec-from-file` solves the problem of commandline length limit
for UIs built on top of git. Plumbing commands are not always a good
fit, for two major reasons:
1) Some UIs show executed commands to user. In this case, porcelain
   commands are expected. One reason for that is letting user learn git
   commands by clicking UI buttons. The other reason is letting user
   study the history of commands in case of any unexpected results. Both
   of these will lose most of their value if UI uses combinations of
   arcane plumbing commands.
2) Some UIs have started and grown with porcelain commands. Replacing
   existing logic with plumbing commands could be cumbersome and prone
   to various new problems.

`--pathspec-from-file` will behave very close to pathspec passed in
commandline args, so that switching from one to another is simple.

`--pathspec-from-file` will read either a specified file or `stdin`
(when file is exactly "-"). Reading from file is a good way to avoid
competing for `stdin`, and also gives some extra flexibility.

`--pathspec-file-nul` switch mirrors `-z` already used in various
places. Some porcelain commands, such as `git commit`, already use
`-z`, therefore it needed a new unambiguous name.

New options do not have shorthands to avoid shorthand conflicts. It is
not expected that they will be typed in console.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 parse-options.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/parse-options.h b/parse-options.h
index 38a33a087e..c6cc01e715 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -330,5 +330,7 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 #define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 #define OPT_CLEANUP(v) OPT_STRING(0, "cleanup", v, N_("mode"), N_("how to strip spaces and #comments from message"))
+#define OPT_PATHSPEC_FROM_FILE(v) OPT_FILENAME(0, "pathspec-from-file", v, N_("read pathspec from file"))
+#define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
 
 #endif
-- 
gitgitgadget

