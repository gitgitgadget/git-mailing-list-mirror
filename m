Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACD2C2D0DE
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 02:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50B620848
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 02:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAc2iCal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgABCtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:49:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38198 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgABCtv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 21:49:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so38001770edr.5
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 18:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I2sD9nQkgwGIyzI9sHFp4+XDn1HdqkrMXmhzFWjttHs=;
        b=oAc2iCal0L+9vtB3uTKFZ9iiLoS798cOsGX7R9usItl29qJmpD6uJ+mcWIpif6WYUF
         xd13fpzEAG/7AUFO5FEz/yu0Pl0/8lVWikMjYXtwzdvHUzHJPaFB2GMH12OA/ezecClv
         1qaGIB1MFdlTxMJR2vq2JI8fP7RNTXnBzocHNq4R0Tg2XA2Jqn1epcBhp20EC21Z8xQM
         pPZcwoXhCbZ0IVr+ttjJ/p+5Yg0oRFd4cue6CFbZUcAyOaZ5c1LGl1eNNXRLuOU3XxpZ
         38ppGGtT6hIH2zJ+IUjIQHnliahaZm35ZWDntk2VrZJXWB/1iUc6j8bgDQ3jliG+Vs7o
         JFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I2sD9nQkgwGIyzI9sHFp4+XDn1HdqkrMXmhzFWjttHs=;
        b=QdT1jR/gcxJvcRh1AlkkJNSxReu70y3nYVaJBwn/IyO8V5HiS1rxbg2aIbPPWuUBCV
         Lf/IkV8ADUX8aTqvEQTtzrgdnZRkwiQDOl9Brk4qACeBY+BXonbn1GN8wF7XxXKV5bLk
         cCuObOJUiGFQiB0PrKUrTZojawGPp9rZAI9CwXTjpszec00MssmBLCnxjdo7kd7A0yVo
         X/bY12nw2HwZYhgSXY45LwZ/B+mMuK68ls9Hi7VbslR/UniRgUrSjMYddK09t2PcRsb5
         ZBhaV2ujiUgfvxBztbjnCJ4ON5rnH0M+G6o0GiXe2CnL+Ibt0+V74H0b9qK0mqHw6Iis
         K8tQ==
X-Gm-Message-State: APjAAAVfhZm12DLRDDxapBPy7StuU8JmWxoy/CYts/MT5pemnGGNu/UC
        csVt2J1r7Mxpr7XPkcrMDqQ7s6PA
X-Google-Smtp-Source: APXvYqwip7qmYravK9vKy2jzEAx+CPrItaBFyusn+cxKCe/N6eCpGIMQsiMJru0meuz3O4/etN7k0g==
X-Received: by 2002:a17:906:a394:: with SMTP id k20mr83166472ejz.216.1577933389694;
        Wed, 01 Jan 2020 18:49:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs4sm7080066ejb.39.2020.01.01.18.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 18:49:49 -0800 (PST)
Message-Id: <82bf24ce537ca9333d72c2b4698864817801f10f.1577933387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.507.git.1577933387.gitgitgadget@gmail.com>
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 02:49:47 +0000
Subject: [PATCH 1/1] branch: advise the user to checkout a different branch
 before deleting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Display a hint to the user when attempting to delete a checked out
branch saying "Checkout another branch before deleting this one:
git checkout <branch_name>".

Currently the user gets an error message saying: "error: Cannot delete
branch <branch_name> checked out at <path>". The hint will be displayed
after the error message.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 builtin/branch.c  | 2 ++
 t/t3200-branch.sh | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..799e967008 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -240,6 +240,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
 				      bname.buf, wt->path);
+				advise(_("Checkout another branch before deleting this "
+						 "one: git checkout <branch_name>"));
 				ret = 1;
 				continue;
 			}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 411a70b0ce..3b2812a8f4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -808,7 +808,8 @@ test_expect_success 'test deleting branch without config' '
 test_expect_success 'deleting currently checked out branch fails' '
 	git worktree add -b my7 my7 &&
 	test_must_fail git -C my7 branch -d my7 &&
-	test_must_fail git branch -d my7 &&
+	test_must_fail git branch -d my7 >actual.out 2>actual.err &&
+	test_i18ngrep "hint: Checkout another branch" actual.err &&
 	rm -r my7 &&
 	git worktree prune
 '
-- 
gitgitgadget
