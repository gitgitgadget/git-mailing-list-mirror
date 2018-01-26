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
	by dcvr.yhbt.net (Postfix) with ESMTP id 233D11F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeAZTnu (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:43:50 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:43868
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752221AbeAZTnm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=aE8VBoyzD7fjxyBwXalkpKesOLFz6R7+vSYxbZKfToU=;
        b=iDHAsls8lEB6yt0SOxv3n/cHUOUjcLN+HttmTwuGEuGta5DutWEa2eHqFiI5Ih/v
        1sCvY7G2GH8x0QiLgkhSRE/KL7M/3X49R8aKRc7I9Qi+4fWrfLtA+M3FxI98fy+24Kn
        Y/Hpvr63CmJNl9Pij9/LbZEixNAgogiopOvHKFQk=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b05-802b1468-13cf-453f-801f-d5530f2f94ac-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 10/24] ref-filter: make populate_value global
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make function global for further using in cat-file.
In the end of patch series this function becomes internal again,
so this is a part of middle step. cat-file would use more general
functions further.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 ref-filter.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 95c85009f1f58..e69dd1ff5091f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1454,7 +1454,7 @@ static void need_object(struct ref_array_item *ref) {
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static int populate_value(struct ref_array_item *ref)
+int populate_value(struct ref_array_item *ref)
 {
 	int i;
 
diff --git a/ref-filter.h b/ref-filter.h
index 7aaf82799ec2d..6373167aaacd7 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -176,4 +176,7 @@ void setup_ref_filter_porcelain_msg(void);
 void pretty_print_ref(const char *name, const unsigned char *sha1,
 		      const struct ref_format *format);
 
+/* Fill the values of request and prepare all data for final string creation */
+int populate_value(struct ref_array_item *ref);
+
 #endif /*  REF_FILTER_H  */

--
https://github.com/git/git/pull/452
