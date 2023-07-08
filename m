Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C4BC001B0
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 01:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjGHBGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 21:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjGHBGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 21:06:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67242211F
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 18:06:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313f1085ac2so2505974f8f.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688778365; x=1691370365;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3tcYGWRrZtBYKlxazEkyD18OsVucbvfLwSwQMVbCPs=;
        b=A/tKLlMVuSen5XKghydLrgH5YOYjxpfOnmJM/VXlbbmY86kT9VwTDHIS1oRvNEDH7O
         v7kB2yB2ba+xmko6qfqdi0ffkoATb3NElnxpi7i/khNV2UYxQOe9kmT3iMtLQC9GEPFR
         3Jj45sYWjCfNYY8y3eCWG+u+IqgmiHdwqKlod8jRRWIpPH9tKVMUygi2NAB25RHZ1Ez3
         xOOE0SlYzGTnmnWOUDa4BjcSWVc8C/DAdVrPzNt1IpXlp3xDu6uKY+sLSMpurecic8Zr
         SYi5Gob7jG2TCyT+rZ47UPEC2/szeHp0yrOQDfbhMXtyedLWGVaazpR+G1QfAsLPrbFM
         Ov+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778365; x=1691370365;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3tcYGWRrZtBYKlxazEkyD18OsVucbvfLwSwQMVbCPs=;
        b=JBKrS2YmKhQAZ9wrMgEFBPg0+/UPFDUe4kFUQUCEAEEQBPayzQk7yHUWRTLr545Ivl
         uMZdMihjGO9ojO0OXoCizJ4939T6bqS4Y7UJFfGgBLNKKOHfkpBrADUCOwnn06hmGrP8
         bMlh8BYTjCbKj2ttnWdcJ+kdgVHlzMpqnExNNx0A6mk03VdCWGqxg2YGCxnRKtCkdgTM
         Un0KgeIslRI0boNeX1+WwugjFMczZhVALyoqTVeQ4LQ70e273dQ8O2PvFFRCqq8I4mYA
         3EwQrZRkfZxb7a69hfRN9pyIytNGsYXmdubNcRBjSlNnxdUJK0prs0SvXwhwFvYmLnb1
         r4Gw==
X-Gm-Message-State: ABy/qLalmxrJ6hbGip6FaRGMgG0XoJlF+M1bw/I4/1poK37sgecEp0xZ
        YHb67HyDiDwFJ0JsJapnEGOmLD43mRw=
X-Google-Smtp-Source: APBJJlGflnYYJuNy6tHhtA9QssZsMwFRuUWtmKCpQwnnTiL0qwIHlP3uHH0g1zK3ZTmA/YkF7MZr6A==
X-Received: by 2002:a5d:54d2:0:b0:313:f5f8:a331 with SMTP id x18-20020a5d54d2000000b00313f5f8a331mr4714529wrv.34.1688778365612;
        Fri, 07 Jul 2023 18:06:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18-20020adfe312000000b0031455482d1fsm4459156wrj.47.2023.07.07.18.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:06:05 -0700 (PDT)
Message-Id: <55bed55cb8859ac7b5b4f464232258f410b4d202.1688778359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Jul 2023 01:05:58 +0000
Subject: [PATCH 4/5] SubmittingPatches: remove confusing guidance about base
 branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The guidance to "base your work on the oldest branch that your change is
relevant to" was added in d0c26f0f56 (SubmittingPatches: Add new section
about what to base work on, 2010-04-19). That commit also added the
bullet points which describe the scenarios where one would use one of
"maint", "master", "next", and "seen" ("pu" in the original as that was
the name of this branch before it was renamed, per 828197de8f (docs:
adjust for the recent rename of `pu` to `seen`, 2020-06-25)).

The underlying principle of this guidance was probably something like
"base your work on the earlier-in-history branch so your change can be
merged forward". However, this principle is already concretely explained
in the accompanying bullet points. This principle should only come into
play if none of the scenarios described in the bullet points apply ---
and such a situation would be exceedingly rare.

Also, the guidance's wording of using the "oldest" branch is confusing
when read together with the rest of this section, because three of the
four named branches discussed ("master", "next", and "seen") move
frequently enough to not be considered "old" at all.

For these reasons, remove the guidance _without_ preserving the meaning
of the underlying principle, and instead add an overview of the four
named branches.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 48918181f49..ef39808f568 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -10,8 +10,15 @@ available which covers many of these same guidelines.
 [[base-branch]]
 === Decide which branch to base your work on.
 
-In general, always base your work on the oldest branch that your
-change is relevant to.
+The following branches are the typical starting points for new work:
+
+* maint
+* master
+* next
+* seen
+
+These branches are explained in detail in linkgit:gitworkflows[7].
+Choose the appropriate branch depending on the following scenarios:
 
 * A bugfix should be based on `maint` in general. If the bug is not
   present in `maint`, base it on `master`. For a bug that's not yet
-- 
gitgitgadget

