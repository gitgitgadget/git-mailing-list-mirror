Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56909C2BBC7
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD252082D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5hlD+UK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDKCod (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:44:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33631 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDKCoc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 22:44:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id v8so5920645wma.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 19:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uKuuHJEYmJLprzJwDK7aADJABshMqhpuzDAb3cVwbSs=;
        b=o5hlD+UKg/jSuYQXDZ3bX004C9/3CGqc0sRUkaoAlqtfzuodswwUlKYBHbXgjILVUs
         THrzXPYp4XGt0RTOEEUJ6Ed9OYsH2XpHvWWWARdOFWd5h4T0AdZ3NOpjB/7hxdp1QohV
         towf/wptzHYhrN7mACCY1g1KSmHknlOHHtQhageWU0F+b85mEUozZeXpmLHptXDpJtzi
         ID6roK/5M5hkOI3HFVAYPmwttNraZH1ZsTWoEfn6TdTByeEy43064GDwPXzhvPgKIJxa
         K4vAzo1ut9a161tpz9aIIpiZapx2AuSRFT93h1IzX2P0TgV1THN0mADR4n9yw6v5bYAt
         ijtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uKuuHJEYmJLprzJwDK7aADJABshMqhpuzDAb3cVwbSs=;
        b=D4SoS6B5aQPu4DV4HM05eR1u7LsVydv6WSlZ2iuQixyix0dVLx9sVqXcK9QE4sVeg9
         hCUrjM5O5EZaqhVEC1mEpFCkMtFg+lzpzx8xvEWe56r/mPZ/esFD3FXcP5//7WSRB+z2
         5rk22Gti42litZhCxkovD3d8Y58a6fK68BYaCZtXtnwGIZxdpilzrUmWvmE2WwQHApJS
         YxWNxuKAOrmVJ6x5xSsuXfsmib3ptsP8fs+U2wt5tQTbyiLfhzxv2hBSnr3W4Hy71+f2
         GcewZH7GR7wK+uR7/AicBHBPVY0D4aSc7j0hfnU1y4V1ZgEvZm3JsI5IoOQ5/yoaRs0f
         rzng==
X-Gm-Message-State: AGi0PuZsxK5KFKXuIItheInHZbfKlHmLrlg+57wpMA1NuYzVBLYJti8l
        tmb6FLhzWPyBkyCgCJZVtREp9Pk9
X-Google-Smtp-Source: APiQypK7L35lpVi++YKioHDUQ+AObu9Q6nDU30OPaL9zUZcR7px1cR+i64CfmB1w646FI/iKLJW1eA==
X-Received: by 2002:a05:600c:c8:: with SMTP id u8mr8097463wmm.142.1586573071572;
        Fri, 10 Apr 2020 19:44:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t81sm5631888wmb.15.2020.04.10.19.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 19:44:31 -0700 (PDT)
Message-Id: <5c8863b9d349f1ea43ae397715ca39d263ee816d.1586573068.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
References: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 02:44:26 +0000
Subject: [PATCH v3 3/4] rebase: fix an incompatible-options error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the user specifies the apply backend with options that only work
with the merge backend, such as

    git rebase --apply --exec /bin/true HEAD~3

the error message has always been

    fatal: --exec requires an interactive rebase

This error message is misleading and was one of the reasons we renamed
the interactive backend to the merge backend.  Update the error message
to state that these options merely require use of the merge backend.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 022aa2589a5..0e223a96d46 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -561,7 +561,7 @@ static void imply_merge(struct rebase_options *opts, const char *option)
 {
 	switch (opts->type) {
 	case REBASE_APPLY:
-		die(_("%s requires an interactive rebase"), option);
+		die(_("%s requires the merge backend"), option);
 		break;
 	case REBASE_MERGE:
 	case REBASE_PRESERVE_MERGES:
-- 
gitgitgadget

