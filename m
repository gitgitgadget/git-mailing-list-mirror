Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4D0C2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE23320716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwhcxJ2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLSSCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45194 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfLSSCK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so5747335edw.12
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=LwhcxJ2sVe3+/SOpzPilFdqkRlfjx1KKJCjCGkveoRw94iwOCt1tJkuTmaSN1jCLmH
         n8GMNqEawUBA0ixoRenUdxtpQNm2Ga9qflJAj9sKqLhEKGbHu0r4GGydc9bI4eW2Aobl
         cf5C6R1lUuzc/BxEFLhQ9owHSWrYnWqOkwAHY/35/xECE3DizkWbSH4c0zXxTtrGhAMa
         Rk+lE3Kr9mKS1m5JzlIUXsirRgXIe9qG9VRvVZj/J8HTb8eKbDmf9dp6yVUJOf9Pf5gf
         +JptwQmoC22qfWIasZyzP97h3m9VYKttyMJCt4jOVDTKOG22nuPmYEwyUuTjTplwO1bf
         ub9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2pdu4w9L5gn7kiCH/6G8ZLbD2+biJruLwAPyx7b5tiA=;
        b=cZoW2miIJWvv8ZbzkowSD/aYSjLk1ODHqpbDDtpdNHfy6FJylolYrSR4odWc2Bk1td
         Gouz9bNWzjacnJfZAIOWqKBCXHdOkFvaM/RWSmQ0CJXGHqk3rBk/vtVHGdf9mVQ+rdNw
         RIWNCW9EWFOikAZj4/3XIyEVtQ2O46l2i+AuDUDEnSmKCtI+WEm3YYorOr0ffSXw1HeD
         9C3eK75a2dAFvSV7KLvmhbhx1y1voJ8Xr2gifZ6YQclEHKqvpNdx2JZiBERfGbrXXubz
         ozPYmQ2I7EGUpwU1nsRcktPCnjdPX3UKQJ3W5s3Fi7ro57ZN0vDomaeQy/z+xMTrse9A
         WSMw==
X-Gm-Message-State: APjAAAUKG1WTBheX1+x5U0JEftLIligBH1998TPt9fLy7q55uKnqgPq1
        zEj7tZgOPArM+Xpurc7X1/rakjl9
X-Google-Smtp-Source: APXvYqz47PYqXFpGU65g/7zNRPwo3N5920BrzO6ymh2t3OvlVYpa23wjjiYNa0lg5gywPjYgkJ2Okw==
X-Received: by 2002:a50:d493:: with SMTP id s19mr10695452edi.77.1576778528859;
        Thu, 19 Dec 2019 10:02:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm638276ejd.2.2019.12.19.10.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:08 -0800 (PST)
Message-Id: <f53bb13e4328a74c37cf92df4a23364a427f2f27.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:48 +0000
Subject: [PATCH v3 11/18] parse_branchname_arg(): extract part as new function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
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

