Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD723C77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjEVT3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjEVT3O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:29:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20C1189
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso11913765e9.2
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684783745; x=1687375745;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv5GVNJqU+6rxTRqJ9TojswlL7JqWqUrtTAfC1RIvWM=;
        b=EC86Ek1VxoazXWCALkKhyJSXFuziJzScAfgBQuyRi2GrgLVWtgfreYDcPrgTuouuzK
         5tSA0RafaUL+CHZzbwKDIxUz0CjRBRMeG6ecWkxEppiNV4QvllsmmQUvoez0CWLwAGgS
         iZSVYgve/xl38fHDYNGpwkS+9vopBqBYluuN9egoI5ogV9g0ft83Ae52DsXqQTd9Mqb+
         AsAvZVa7yXPSQFxHIL/zHxicKZf9oWXXfE0XYFOu7s6q3NI2lcLNPBchVpB7So2X4VMr
         HYple2o1b81A2gZeIxMpg4AymBW9GVscXQtyy5Uj+YtLWr3WtoiUE/tVaoOMfKOrfNo0
         JH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783745; x=1687375745;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv5GVNJqU+6rxTRqJ9TojswlL7JqWqUrtTAfC1RIvWM=;
        b=Jqz3lwszVpM33KI9Z/7VfTihASe53ddmm3ueK9buchVuxI+6qJgt5p2q88unMln+ph
         Pf/ka5o9CAH9bVH+YrR19rbhZKfgCNXwWb9mR4AqPSJjdYDpqMHT6YN68dp08AwExIKD
         gv0fsCfDcDyHOY2uVU58/ddd1xyB3gl+nQJgj0ikDG9j/OpDn2Rt9W5e1S2z2J9uJvB9
         XpOlxyhS8GPGFb/f7g9UBnPZ/D9BRF2cgit4CnnDKPu37ZITqg0KgWGb4pLp4q19cQhu
         ncg4pwrsqLjKwO/5/FvynI3tCemVkz39E0atVECugZzka+KRLncLvsbmt07jINVoMX1z
         seXQ==
X-Gm-Message-State: AC+VfDxJSUr+fqIAm8YGkPe2FwDIEGjEPreIGfH+DM4g41M+mMq1H03N
        Rzj3gu1mmPzwCYjlG4gusjVMpDc2F90=
X-Google-Smtp-Source: ACHHUZ6oODQVROEdzjj8nZY6WT7d0BN1iHsOjTtCD1RzfcFu7JU+JSbc2qqiCIWHwMHBJhWYtHOh+Q==
X-Received: by 2002:a05:600c:2216:b0:3f6:41f:5a68 with SMTP id z22-20020a05600c221600b003f6041f5a68mr3379245wml.29.1684783744732;
        Mon, 22 May 2023 12:29:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b00309257ad16csm8674183wrd.29.2023.05.22.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:29:04 -0700 (PDT)
Message-Id: <3e3240a78f81d7886fa47bc26b859a4d7d238aff.1684783741.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 May 2023 19:28:57 +0000
Subject: [PATCH v2 2/6] revisions.txt: document more special refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Some special refs, namely HEAD, FETCH_HEAD, ORIG_HEAD, MERGE_HEAD and
CHERRY_PICK_HEAD, are mentioned and described in 'gitrevisions', but some
others, namely REBASE_HEAD, REVERT_HEAD, and BISECT_HEAD, are not.

Add a small description of these special refs.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/revisions.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index ab5b8cf880b..b34f981622b 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -32,8 +32,8 @@ characters and to avoid word splitting.
   first match in the following rules:
 +
   . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
-    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
-    and `CHERRY_PICK_HEAD`);
+    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`,
+    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD` and `BISECT_HEAD`);
 
   . otherwise, 'refs/<refname>' if it exists;
 
@@ -59,9 +59,18 @@ characters and to avoid word splitting.
   `MERGE_HEAD`:::
     records the commit(s) which you are merging into your branch when you
     run `git merge`.
+  `REBASE_HEAD`:::
+    during a rebase, records the commit at which the operation is
+    currently stopped, either because of conflicts or an `edit` command in
+    an interactive rebase.
+  `REVERT_HEAD`:::
+    records the commit which you are reverting when you run `git revert`.
   `CHERRY_PICK_HEAD`:::
     records the commit which you are cherry-picking when you run `git
     cherry-pick`.
+  `BISECT_HEAD`:::
+    records the current commit to be tested when you run `git bisect
+    --no-checkout`.
 
 +
 Note that any of the 'refs/*' cases above may come either from
-- 
gitgitgadget

