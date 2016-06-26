Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8727A1F744
	for <e@80x24.org>; Sun, 26 Jun 2016 05:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbcFZF63 (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 01:58:29 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36652 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcFZF61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 01:58:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id a2so25669787lfe.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 22:58:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VNi8Es4K6kdGjqC4y0v+CJDyXiKVygpoxk/ZrsY+HJM=;
        b=ypL+L10XC8WaShXmBOD7oJvfoCgquMRhFbbBzhu8CN0O8JBqDaV2YH1zn531pAoTAH
         7twq4s/QPD8HT4RRkR6LrLn06iD5bEyUFI01TIBvI6skA3ty3j0ZBwJDa/MTla3QqwSW
         Rj3MvOCA5+NQ8vCuKsxIYTn6bO7pLj4OsgslEQSnFRqw5TQZjhf7Vw/JJLFOmXHTVkWJ
         uPj/wDmksV/WvMjDyptjX9b/NpZ3aIAErztimNGJmnhHnCIjTgG/whThNIgzfJ1iZVwd
         diBkT/XHdo0XmQJxXzeum8v/LpYA4L9W2dPu7idCantoj7+G/PiSQHIY8IDeACWt4mxu
         nv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNi8Es4K6kdGjqC4y0v+CJDyXiKVygpoxk/ZrsY+HJM=;
        b=eupZ9H4c2uhshgylrjdk/pjJkSQ5s/9ZyeOjUIMCfaICw73InAN0rr2NHuM7IA0xrP
         u1XPkGUnLEWtCGM+J5jR3ufbRdAVm3q2ox8QHEC51pT1JHvvb1WgGD7hrVypGVF2xvGV
         /FAPZIFRSiLw6LTVM/BuauyK6mSPkQ+QucULySdspSgSxs7ywSBLUvho9a0k36bG6XAB
         ceRqZidYUNlcMbe7gGZleoAhIX3shDy69luYCvXFDEo89XVvDSJI4TNISz0EntUWkEbd
         kpNdYmNWUc58jBkpsekAEX+2rkChXWhyNUauIAGL/8ZMbORD7K6pBs7+9SO21oYGD/21
         3L7A==
X-Gm-Message-State: ALyK8tJff6DmPVypEhaqRsVVm+4u/7xmSdqddy7jV/egz2UisruqfkOHQQnxKp63rCApAA==
X-Received: by 10.25.144.148 with SMTP id s142mr3919547lfd.191.1466920705739;
        Sat, 25 Jun 2016 22:58:25 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g24sm2123775ljg.20.2016.06.25.22.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 22:58:25 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/5] fetch: change flag code for displaying tag update and deleted ref
Date:	Sun, 26 Jun 2016 07:58:08 +0200
Message-Id: <20160626055810.26960-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160626055810.26960-1-pclouds@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This makes the fetch flag code consistent with push, where '-' means
deleted ref.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-fetch.txt | 4 ++--
 builtin/fetch.c             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index cbf441f..771dde5 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -120,8 +120,8 @@ flag::
 	A single character indicating the status of the ref:
 (space);; for a successfully fetched fast-forward;
 `+`;; for a successful forced update;
-`x`;; for a successfully pruned ref;
-`-`;; for a successful tag update;
+`-`;; for a successfully pruned ref;
+`t`;; for a successful tag update;
 `*`;; for a successfully fetched new ref;
 `!`;; for a ref that was rejected or failed to update; and
 `=`;; for a ref that was up to date and did not need fetching.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a7f152a..8177f90 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -500,7 +500,7 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		int r;
 		r = s_update_ref("updating tag", ref, 0);
-		format_display(display, r ? '!' : '-', _("[tag update]"),
+		format_display(display, r ? '!' : 't', _("[tag update]"),
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref);
 		return r;
@@ -814,7 +814,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 				fprintf(stderr, _("From %.*s\n"), url_len, url);
 				shown_url = 1;
 			}
-			format_display(&sb, 'x', _("[deleted]"), NULL,
+			format_display(&sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), prettify_refname(ref->name));
 			fprintf(stderr, " %s\n",sb.buf);
 			strbuf_release(&sb);
-- 
2.8.2.526.g02eed6d

