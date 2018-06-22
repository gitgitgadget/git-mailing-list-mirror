Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E9F1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 01:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934301AbeFVB5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 21:57:49 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:35237 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934292AbeFVB5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 21:57:47 -0400
Received: by mail-qt0-f201.google.com with SMTP id a10-v6so4159043qtp.2
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=aX2YjQAUMJWtsIq3wxcRuhPspVKkByoIgFlyDjDsKHg=;
        b=v4HNEG5okU1fQcZAPhuAAq5HnA1dd74VD1+4iCB6zGEj8BVvIasFwx4EO+QIwQfgkT
         5iXqnE8wxjPoYny44PR378c8Jy97DF9LAqw91ow5EovssZ12fquNODaG4Hy4OmvwOQod
         lBwj5tgOdjGSmqTrUTvbKkZYvkmitK9yr+RbDQpsvR1oCnzn6s6XxvNVBKrLlQJOcgAY
         Gkzs+R+ZGdraAQ/h4EnXhDsQbXAtTTYHh5CtfrxO/7LYWSG8FD7y2Jxp4yPQnrr7T/bC
         vV4HlYJB5JFb1rntrIUDuyrg6GPeRPDTwk8ZgGAX419cmOAMZD+jFN1QalkOHdeoZCsI
         x6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=aX2YjQAUMJWtsIq3wxcRuhPspVKkByoIgFlyDjDsKHg=;
        b=DHEtmsdj94mt7a1+wBqQU+zjyts8BMcNL33gFO1Uy362Y4PW6UYT1T92EN8S8C/BEx
         gh8h9Fx6NnX7mUrO/0Zr2ctZIgN14Uhbj+m5eFpx2xkgm01jMbnIQKLCqPDgqhKHGa2Y
         rol3sAmKfJZOJx8GisAbeEUm62Ma+CThuJVWs/OmCcqoOt2g9R6QeQBK51hRC+l00udD
         h60n4LyZ4NLLTRT8D3vhgvb475zDb/QWmyBIB5FA4a+KgDJzhByItoYqWUG/UzY9WDgM
         Hp94FhPtBFSfz3W4pM5X+vWk17AuirT6crnfp703oPVizHEV25xfn9PM89iUZy7kkFdX
         acfQ==
X-Gm-Message-State: APt69E3DnNDtHU83SSdAROFOaQTMEKrCDCh5roTjOfzpLNsyQL7fd3QW
        szwwV4Ruovi36kFMOD97VmntfNv98OWF
X-Google-Smtp-Source: AAOMgpdvzDm0quAk9hynmK5kAPGcjUExyo2+J8+nLcbIqqubymMpV588odVIkF/udq6yjP8cu7zyhVMNEwX4
MIME-Version: 1.0
X-Received: by 2002:a0c:e984:: with SMTP id z4-v6mr153305qvn.21.1529632667246;
 Thu, 21 Jun 2018 18:57:47 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:57:21 -0700
In-Reply-To: <20180622015725.219575-1-sbeller@google.com>
Message-Id: <20180622015725.219575-5-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3 4/8] diff.c: adjust hash function signature to match
 hashmap expectation
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the follow up patch easier.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 112e6af2cc8..2a1a21d3b7a 100644
--- a/diff.c
+++ b/diff.c
@@ -707,11 +707,15 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
-static int moved_entry_cmp(const struct diff_options *diffopt,
-			   const struct moved_entry *a,
-			   const struct moved_entry *b,
+static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *keydata)
 {
+	const struct diff_options *diffopt = hashmap_cmp_fn_data;
+	const struct moved_entry *a = entry;
+	const struct moved_entry *b = entry_or_key;
+
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
 				    diffopt->xdl_opts);
@@ -5541,10 +5545,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
-			hashmap_init(&del_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
-			hashmap_init(&add_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
+			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
+			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
-- 
2.18.0.rc2.346.g013aa6912e-goog

