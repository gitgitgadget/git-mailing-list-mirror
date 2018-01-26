Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9EA1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeAZTny (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:43:54 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:34824
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752218AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=6cQBhe3FB1nJQh9layrAAcjrsCmGhgSXogsjZ2S8ucc=;
        b=chBLYq9E7ELL0bnHUetcVJ9MnznqEDvpL9zf30I096OstobBkskAkIExd71fz2N3
        /NlBaiZ80zW4vdkuRkpfKypNSxs7pgjULlMKAtnhaZukezpp3aY2qLyOrQ+R27WSnv+
        +i5eRHkryEEYHX41oKjfAyNTbH/0tZrUJp1CnFlA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b4c-a68ff848-85c3-40e0-acf1-3539e263bcd2-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 19/24] ref-filter: make populate_value internal again
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove populate_value from header file. We needed that
for interim step, now it could be returned back.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 ref-filter.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4d0d4f081227d..c3a5c3897295f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1476,7 +1476,7 @@ static int check_and_fill_for_cat(struct ref_array_item *ref)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-int populate_value(struct ref_array_item *ref)
+static int populate_value(struct ref_array_item *ref)
 {
 	int i;
 
diff --git a/ref-filter.h b/ref-filter.h
index d8064086f36a9..285a2311f6cc9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -172,9 +172,6 @@ void setup_ref_filter_porcelain_msg(void);
 void pretty_print_ref(const char *name, const unsigned char *sha1,
 		      const struct ref_format *format);
 
-/* Fill the values of request and prepare all data for final string creation */
-int populate_value(struct ref_array_item *ref);
-
 /* Search for atom "rest" in given format. */
 int is_rest_atom_used(const struct ref_format *format);
 

--
https://github.com/git/git/pull/452
