Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C8DC43215
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0F32073F
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owSpvFPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfK0QnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:43:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45377 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0QnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:43:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so1624671wrj.12
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 08:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=owSpvFPiTS+qzdAyqMjkpzMKQDrNy5jYap9JgHCmKgM14Hnpltpak2tj7S/uQbIiK2
         jnKosqozSozvX4GP4Ksh50YOd04Sr9iLuVmak/+MYpEz0AOaYpyxmxqjV8+vQlDw0nA6
         RXLxty/OWeopKleFVhZ/T3Pqt8kfwfyelQ8CwHUg6UtiT8BzIsq0U/Z9c+em+HivT29q
         cDfLWvDCqalXE1kcyL5VSG0vajf3quLkLoRsm90URlbl7phvd+bzWo2umPHVHuySGZdy
         yOYBfeKKvpVdz36Hh5Y/JdtKZWEL3/K4g+188AXJpQ9kRWKviB3Eqv5NvPYz7PKFC/C6
         qXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=SWLXf9Qn2YGh8xxmxF6sZY2LRX9ez/26jqOcntUXEtLqFLFr6zur0Rf/87YMGvtM2i
         0xUR8QEVmITJv9SgZ73LGpSGHCoWwQl1Y5m3Mq6okfnKOMgofAr8nd5fJHhV6p1Mo0Vc
         vo9a20LGVfIgH8KLcgfvOuKuz1719ebUhJqkkHAbn8IExWprNUqg2bLDX2woKN5CVsdX
         1rnJZJJhXldsdf31l6HQtArDi2PAxjG/oCo3+g1BMGy5mjCw3whPZTtrf51AiggozkNL
         71R+QVtA+GcxuMIkAQNzath0luwppSmBygcuhOIihW8AsF5600EVaq/AEjcjXDGlOvJi
         3fNg==
X-Gm-Message-State: APjAAAVIWUKtw5yGKehKPCWZsrVK0vQ1DPr6BjE/IXbBfa2bgaOfNGVL
        9izxHQy02zxS/SVPVP1gnsaXYO6Q
X-Google-Smtp-Source: APXvYqzTM/fCGkuNHco/wQVGBgYX2XoCfvcLMVBbNkVVBEXPd5anqer504unKBHjZqmmHLGPeLczKg==
X-Received: by 2002:adf:b193:: with SMTP id q19mr42685318wra.78.1574872992811;
        Wed, 27 Nov 2019 08:43:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm20051682wrr.15.2019.11.27.08.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 08:43:12 -0800 (PST)
Message-Id: <1e40cc485b5a25189310053cedfd3a335b225552.1574872991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.477.v2.git.1574872991.gitgitgadget@gmail.com>
References: <pull.477.git.1574848137.gitgitgadget@gmail.com>
        <pull.477.v2.git.1574872991.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Nov 2019 16:43:09 +0000
Subject: [PATCH v2 1/2] parse_branchname_arg(): extract part as new function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
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

