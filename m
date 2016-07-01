Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A218B20FD1
	for <e@80x24.org>; Fri,  1 Jul 2016 16:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbcGAQD6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 12:03:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33175 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbcGAQD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 12:03:56 -0400
Received: by mail-lf0-f66.google.com with SMTP id l188so11784489lfe.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 09:03:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVFv/2xAs8zfliLSc7wYm05AVGYyerb6emMbMqQB/s4=;
        b=covjtZZrXP/MIHeAWuo1Us3nS9aLS+n+Dtpx5OOpIMsboe9HwqVBsiGlWJbcdvXNf3
         vy0zkRxJBKYK7GiuV5q+se7ROmJybteCxEVciqi9sSrLbkZ3Nwn8Fa3z6CLvb4XDvaKR
         bM2ChvCH9PFXWSOgRAqRIXIhYIY7jzcj4v/3m1hOuqggXWchP0We0rxnpZPLsIbI3itb
         GJ9mo+cQpDi19Zrw3gHAFhu9m3gFI29kxo02M1eNKwOiXjLc03/eBnJtgMh5Hbh7Cfi8
         Qs98bqv53DFK/nmBJs+r+dVho08OcdGHWRZH5OIMcoAL9+WEopDK94H27ZgTRObLSrNB
         +OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVFv/2xAs8zfliLSc7wYm05AVGYyerb6emMbMqQB/s4=;
        b=OokSntyXa+XUXjYKjFYFyhdcYMsdmH5D3fXbY0KZfI9vu/JHIt+rIPd1h3gpMi2D+J
         DFg5KTlK1WKYjjXYi23r8s50ywb/+jUulcOsgacbzRVwZTTq5SBmilrM5IMYWouDn9M3
         g5EAALF0tepNl9yGXZ29vSYjC/4UUqwdhAbfbbE2Id1Ao5WMAEgdA3+iWau5FbXGQ9ju
         CSGDgB32XbsdDyduhaffl2mWtf5NsH4ixv7bVHgANJlMim1HCFvrtChC4y+k8bdagfjN
         9BqeyL5wSIEkpLFR+i0TelEWNglXxlkEXNf4Hzejv+xEQJch+1jsf/C9PWfgCWGDHNQ7
         +b9Q==
X-Gm-Message-State: ALyK8tI2i8Zww41jE/kUDR11lHo0WKpj5Omz7nXFLZjBacOAAs9C2HHUtqS4E0zJnS55gQ==
X-Received: by 10.25.21.169 with SMTP id 41mr6053584lfv.124.1467389030060;
        Fri, 01 Jul 2016 09:03:50 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id k18sm884102lfg.47.2016.07.01.09.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 09:03:49 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 3/5] fetch: change flag code for displaying tag update and deleted ref
Date:	Fri,  1 Jul 2016 18:03:29 +0200
Message-Id: <20160701160331.29252-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160701160331.29252-1-pclouds@gmail.com>
References: <20160626055810.26960-1-pclouds@gmail.com>
 <20160701160331.29252-1-pclouds@gmail.com>
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
2.8.2.531.gd073806

