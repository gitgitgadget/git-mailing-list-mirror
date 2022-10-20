Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDA9C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJTX0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJTXZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:25:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9A12B37D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:57 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id p1-20020aa78601000000b00565a29d32e5so418014pfn.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+YOhlbdI4P6WDMl9yaFzGuIV/YOZxL10ETZHK3KJbk=;
        b=Exau4LnAqchT++8zN4FO4R3k0JuCHtmCYbTXZSZVneJr69lAPVXCpzr7oyb3pmt9KU
         sNmW4O3fRyxMmpIlUNYaIK5GIDDL+SLfLpgc2rZj3i2D7oFHB1+K43Fyh0+9wibAzSkY
         exmnm/n6ph4YoPGQIKUCOth9JjyaP1fj0Zf/YGIMNlalv5FHqiEdclSHsi61Of1YeNTf
         lqyktYFvykOHlOCtKxZm9hHsOO2Ju4s8ArfkKoo1rma/vrjNO9QsNlHD12y7Wt/CjiGe
         cNeBbdK961xxoRdoEu3fsWVRZ9sJc+2M9/jurd6roQ0MBkfRygsw/qYNFWqs5L/lyDzz
         Jr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+YOhlbdI4P6WDMl9yaFzGuIV/YOZxL10ETZHK3KJbk=;
        b=aCDk9yjuNyMicrejTsPBRpB9mYboYo14xQa89p6A2i+91XgqVkvMzQpmGgO6PDUNwk
         n/jYGj4J7fQ5cZnmAifZ3v24BIok+s2juF4CiK893mw+nT4KK4Z1vH0P53gvCmoyui3h
         +a9PFg+Hb3rWdel/fYAqDxVdX5w8988ku4zyClN10O/t8IiiG7+1+xaxG+Kz9TIJzBl+
         GmYhrvG4FdyyT90XhAH5WPH59d+hmiWvDCOoZ5yMhkNv8IxyN8AtIFhmmqo+Fai//n0J
         GTUIpCVuT7OGuU72+Cw1+wYgPjjpJjMKquPucmgkTfftHa5ldZm2pEkU/KWlPnb9rr+r
         nKkw==
X-Gm-Message-State: ACrzQf1Xk/J5rJ3NULZ1Oc/p8c7Wglf1qUGdjn2Ok3YephMtsgYEAXcq
        lHPptLD716YYcOcfXpR1aV8R7gLAQtrIUIiQHHOMD3fIovh3W3AoIrFRGTz3ZYmmBchkwUBG8RU
        TLGSFkjYqx50gWS9+KGe9HoobAI6kIq6aR0OHWXc28oR/Jx9gBa+Hc46WLKA+wwpFEw==
X-Google-Smtp-Source: AMsMyM4CkvtdeD0MaDJMnPg2be6vnQA4x5Fre5RSFir5LgOmLthnJbdbFp2GJlc1Ll5ozZexJisKZJwKjmDSq5o=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:aa7:979a:0:b0:563:a69:96c7 with SMTP id
 o26-20020aa7979a000000b005630a6996c7mr16021346pfp.29.1666308356797; Thu, 20
 Oct 2022 16:25:56 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:25:31 +0000
In-Reply-To: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020232532.1128326-6-calvinwan@google.com>
Subject: [PATCH v3 5/6] diff-lib: refactor match_stat_with_submodule
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Flatten out the if statements in match_stat_with_submodule so the
logic is more readable and easier for future patches to add to.
orig_flags didn't need to be set if the cache entry wasn't a
GITLINK so defer setting it.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 diff-lib.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 2edea41a23..f5257c0c71 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,18 +73,25 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     unsigned *dirty_submodule)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
-	if (S_ISGITLINK(ce->ce_mode)) {
-		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.override_submodule_config)
-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (diffopt->flags.ignore_submodules)
-			changed = 0;
-		else if (!diffopt->flags.ignore_dirty_submodules &&
-			 (!changed || diffopt->flags.dirty_submodules))
-			*dirty_submodule = is_submodule_modified(ce->name,
-								 diffopt->flags.ignore_untracked_in_submodules);
-		diffopt->flags = orig_flags;
+	struct diff_flags orig_flags;
+
+	if (!S_ISGITLINK(ce->ce_mode))
+		goto ret;
+
+	orig_flags = diffopt->flags;
+	if (!diffopt->flags.override_submodule_config)
+		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
+	if (diffopt->flags.ignore_submodules) {
+		changed = 0;
+		goto cleanup;
 	}
+	if (!diffopt->flags.ignore_dirty_submodules &&
+	    (!changed || diffopt->flags.dirty_submodules))
+		*dirty_submodule = is_submodule_modified(ce->name,
+					 diffopt->flags.ignore_untracked_in_submodules);
+cleanup:
+	diffopt->flags = orig_flags;
+ret:
 	return changed;
 }
 
-- 
2.38.0.135.g90850a2211-goog

