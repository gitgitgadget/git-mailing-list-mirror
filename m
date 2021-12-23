Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FFAC433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhLWVy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 16:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhLWVy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 16:54:56 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC73C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 13:54:56 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i8-20020a639d08000000b00340a257c531so3835064pgd.16
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CP0oPmJctNoGIxPfI6Rss7+UwnYgPkmxO4bHfkquPJE=;
        b=e1lnWBcIkLCG9GLAknqqcfcdHly0YKkgzvVHzcrMQhKBkmJjSRkEi5cK0p+1xxtKHk
         OOopCGVtIk88pyOG6TPg0ntj+Ng/QKY9xmXpA+CvB3/KmttgOtQu6BBUjuo8nmTzCbDh
         UlqQ1OhaqQkL6l3cRbdEZ2sGqwraKaABYEy1fSDC1DWqSdUQyD78xCUhM66lH1BGP6gR
         IEySm/a2NUBtWiC2nC7IwaB9YE15HmZeamXEHW9dFFOuWU5cb6eDp+eSvjBYd+useZY6
         2FwAOjnmhgZpDQbZGWuMDPnr24xlj5x2r8VA12F3+2m190zC8OLvRKvnlUoeaSm/HEMp
         aXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CP0oPmJctNoGIxPfI6Rss7+UwnYgPkmxO4bHfkquPJE=;
        b=AOjOoqwolGMDTiyaUlcErQgtCfxO9uU69/fkupZzjczdkPK2rAYqx/KHD9zM7/Jd7W
         HmUzTEbgye6fXqVvNAnME0c67lXTzbfQHYL6MoU+AhALQFQJR7tOLSjLsPmscf1Dmf3c
         Lew9IViK+cXntvyKs1jud5o6oxFRb7lR++QiOHdWLyO1n4cU8T0lJISbbYzCD3fNQCnB
         h6w8TOPJF6GdLOdnaXCzfyaVkg+a/gzRrOxQqCn5IJ0+rAn1LPlMVktxARh6TfTvSu6U
         teVjZ/Jq4HsQYbVfwrWVrk7lcLPoO4bk+1EZZ1lhE2J6wvKp2ZJNe9EuqkBYvStIPFyq
         XxeQ==
X-Gm-Message-State: AOAM532+UaJ/TFEiMk+K31Cq3heaxPxlPdSxsxrD6/ZmaXgSuCVFRaDt
        myeHMJJEFSxth4h3TpNNXOBpLcIrhHzBUX7AaqkplkdX7fc5oH0ZuUYHSGl6BCZbSbjRCcFu28R
        dJcsePQR2T3yehHPqL4lr6qZAIAFcrulmQLDPQTOReTY7pEp6/X/PIHq0DqZiKBI=
X-Google-Smtp-Source: ABdhPJzvGSibjIiksGvDSoQKovOw7rZeTaTq5UE3zvBsFEuFkUsKjevdAbVTrYiwv70b6ntb3YQ3Ow2lruURQA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:3d09:6204:5070:ab7a])
 (user=steadmon job=sendgmr) by 2002:aa7:86c8:0:b0:4b1:7b0:56aa with SMTP id
 h8-20020aa786c8000000b004b107b056aamr4055371pfo.49.1640296496105; Thu, 23 Dec
 2021 13:54:56 -0800 (PST)
Date:   Thu, 23 Dec 2021 13:54:53 -0800
In-Reply-To: <patch-v5-3.6-b79964483e8-20211125T215529Z-avarab@gmail.com>
Message-Id: <ec6a20a3d694d1d7e3db14f6bab42aff3e82c135.1640295389.git.steadmon@google.com>
Mime-Version: 1.0
References: <patch-v5-3.6-b79964483e8-20211125T215529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH] fixup! object-name: make ambiguous object output translatable
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A nitpick, but the "ad" and "s" strbuf names here are not very friendly
for readers who don't know offhand what the format_commit_message fields
expand to. This makes them more self-descriptive.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 object-name.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/object-name.c b/object-name.c
index 1dcbba7fa7..dcf3ab9999 100644
--- a/object-name.c
+++ b/object-name.c
@@ -378,15 +378,15 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	       type == OBJ_BLOB || type == OBJ_TAG);
 
 	if (type == OBJ_COMMIT) {
-		struct strbuf ad = STRBUF_INIT;
-		struct strbuf s = STRBUF_INIT;
+		struct strbuf date = STRBUF_INIT;
+		struct strbuf msg = STRBUF_INIT;
 		struct commit *commit = lookup_commit(ds->repo, oid);
 
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
-			format_commit_message(commit, "%ad", &ad, &pp);
-			format_commit_message(commit, "%s", &s, &pp);
+			format_commit_message(commit, "%ad", &date, &pp);
+			format_commit_message(commit, "%s", &msg, &pp);
 		}
 
 		/*
@@ -395,10 +395,11 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 *
 		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
 		 */
-		strbuf_addf(&desc, _("%s commit %s - %s"), hash, ad.buf, s.buf);
+		strbuf_addf(&desc, _("%s commit %s - %s"),
+			    hash, date.buf, msg.buf);
 
-		strbuf_release(&ad);
-		strbuf_release(&s);
+		strbuf_release(&date);
+		strbuf_release(&msg);
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(ds->repo, oid);
 		const char *tag_tag = "";

base-commit: ea5019ecd7a405d7d5f6527054d0aaca2d3b4bcd
-- 
2.34.1.448.ga2b2bfdf31-goog

