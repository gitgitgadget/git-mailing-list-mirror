Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C45CC2D0C9
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A03214AF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icUCWJNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfLLOgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38204 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfLLOgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2762848wmi.3
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=icUCWJNle40dcoUN6JkCUt96pxjzJaJaDgc41hEka0sJzKJuRJCkmS5kXbd/bprq09
         MLbyE7yoOxCYLNGBv6O9Xa7LjeDAor5dmd6091IKJTplPt6FO9rpwJmKPEqYDqAUdtpK
         T74k07tSaVe3pEFWIH8pmtFbpSm/fMU9t2RuA1i/hMUWHBnLiYKlh7+7/G7TOPnB0RMT
         fiMrmInz0qxIgCriDku6mymrpydr6rSuDf3KNJL8243OTxF46iY9kHdqmA9lfhVYxhEb
         TPuAncUw6opZV2DIiZyMydZrr5mmOBe0gdEczq00aQzcqOYETZhUKLzMnIvgJlszybrz
         nKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=J84kB9gnoRSa1J4ytJSwLoBtYGFHZe2xyMH2bKSPu3XtihcewRM6MwgG4sLNWUpFyt
         t37CV2+9S27F4nlyZP64e04xCjjurOtYFUd/70AVMTWcXN5cJHzbqLMwwYxyOF7QiOG5
         1I+K+7+wWYQeSJ7ahulUm9eRzglX57sRrDw+51h49UpCHErO9DClsxgTDDuGLHQu9BEP
         2EA+Sxiq06+4gj/q0yBuIHSmZrhxONCZnzpGioMU9gwWDtpBgemzHx+2oRKsfjwHLRNn
         h2bNOIV4fmVUj9jprVMJC8z5iesHP7GX55HcL0fAbhH9G+dhBTpNkmXN5DQohE/8HkZp
         7QTQ==
X-Gm-Message-State: APjAAAURjvAYI9kQg0W3PPf4y7sP5TwKTyeEyPbSRIrEepsZBvVDOoTA
        r+DIK6WQj0cCSwdpLMMTqHTi90N6
X-Google-Smtp-Source: APXvYqw6uMToCIw7zEKwCkvaXoYcLx8e5TsT5rl81gzT4ONZWDqGLv1bl7COqXe5SpcnY9yMlHdoJw==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr6842194wma.84.1576161392813;
        Thu, 12 Dec 2019 06:36:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm6339225wrq.22.2019.12.12.06.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:32 -0800 (PST)
Message-Id: <891d1b91cf8f2b5fc8af6f26061bb7967ee6f664.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:18 +0000
Subject: [PATCH 09/16] parse_branchname_arg(): extract part as new function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This is done for the next commit to avoid crazy 7x tab code padding.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3634a3dac1..e1b9df1543 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1113,6 +1113,22 @@ static void setup_new_branch_info_and_source_tree(
 	}
 }
 
+static const char *parse_remote_branch(const char *arg,
+				       struct object_id *rev,
+				       int could_be_checkout_paths,
+				       int *dwim_remotes_matched)
+{
+	const char *remote = unique_tracking_name(arg, rev, dwim_remotes_matched);
+	
+	if (remote && could_be_checkout_paths) {
+		die(_("'%s' could be both a local file and a tracking branch.\n"
+			"Please use -- (and optionally --no-guess) to disambiguate"),
+		    arg);
+	}
+
+	return remote;
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
@@ -1223,13 +1239,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
-			const char *remote = unique_tracking_name(arg, rev,
-								  dwim_remotes_matched);
+			const char *remote = parse_remote_branch(arg, rev,
+								 could_be_checkout_paths,
+								 dwim_remotes_matched);
 			if (remote) {
-				if (could_be_checkout_paths)
-					die(_("'%s' could be both a local file and a tracking branch.\n"
-					      "Please use -- (and optionally --no-guess) to disambiguate"),
-					    arg);
 				*new_branch = arg;
 				arg = remote;
 				/* DWIMmed to create local branch, case (3).(b) */
-- 
gitgitgadget

