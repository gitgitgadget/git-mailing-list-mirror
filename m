Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EC742022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbcKHUMf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:35 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36402 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933145AbcKHUMb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:31 -0500
Received: by mail-pf0-f194.google.com with SMTP id n85so20692729pfi.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z19Y2XUmwtyP/XuEvrwG2bbstO4gs51i9jzfvLTIDJo=;
        b=H8CzmKS01fgjkWQqHYEd9q1Z33QHdAZT/u8Q473E8IpD0F2kv0o1hG4uaIJePVjorb
         LEMcucES9ZmvalWSNFgEgR5OcQzlHvCT4jVXrmDkmxtWIHEEEEqERMd/rpB84nlvqg5N
         XJwYN5h3qe/3qSe83cz8W29ERPLmGa8qqmOGwXiuDjJYVWjs2timqt/18PtVd+N6zPSB
         MNsj4ltHXZa+k4PPMQf4N6spQpmBmtL3wA6Qazy+DR0unv/LQ6ZIb2kNIoJvUfr73x1z
         Xprw8pNpBvtayeSY61CPtyAKA7NdJDflYnfoRwFhdPJ6VLnB1wszLsVITbI5PooR7RkX
         x+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z19Y2XUmwtyP/XuEvrwG2bbstO4gs51i9jzfvLTIDJo=;
        b=J0xAbX+UTCcddXwwqvJ9tpc8dfhnJ8473XYPbrV6Cti6Rd/6H0OtNlo3OiztRCjrMi
         JqdAQrYZ7kOxWntMHpjJp5vns/ua2akK+WVl1829/Jqa1AN0Z9oeZo1Mq1cqyPMJ7iNm
         3k7Ek7WTGVyU/8ATqCko0WikOXpu8UXVwp4DbSWZZguP7yUH2EKxvGahR1cYyY533Wcn
         EyY5YS/JA09jd17TE11AmyIQdvn4oQL0j/QjC5IzDQRdcgd3Eu9VRIXRK/UZ4sJbgBRF
         zDKOCj0GoCOhkEBoq8XK1HHVRzc0OqwrC8pYPOarH6j1+DeR2r/OD2uZExwioFcC9w7E
         naaA==
X-Gm-Message-State: ABUngvfoPbkCzcS+4gKhaBeO0JXSL1fKKZM4PCW8OMt2YF/khwtPmJX76/9z5+wktsNrjw==
X-Received: by 10.98.18.6 with SMTP id a6mr26637536pfj.184.1478635949933;
        Tue, 08 Nov 2016 12:12:29 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:29 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v7 09/17] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date:   Wed,  9 Nov 2016 01:42:03 +0530
Message-Id: <20161108201211.25213-10-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

The "%(symref)" atom doesn't work when used with the ':short' modifier
because we strictly match only 'symref' for setting the 'need_symref'
indicator. Fix this by using comparing with valid_atom rather than used_atom.

Add tests for %(symref) and %(symref:short) while we're here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4d7e414..5666814 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -338,7 +338,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at].name, "symref"))
+	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2c5f177..b06ea1c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -38,6 +38,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
@@ -565,4 +566,27 @@ test_expect_success 'Verify sort with multiple keys' '
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
 '
+
+test_expect_success 'Add symbolic ref for the following tests' '
+	git symbolic-ref refs/heads/sym refs/heads/master
+'
+
+cat >expected <<EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref) atom' '
+	git for-each-ref --format="%(symref)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref:short) atom' '
+	git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.10.2

