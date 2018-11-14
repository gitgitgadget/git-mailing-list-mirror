Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3CF1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 10:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeKNUtT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 15:49:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeKNUtR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 15:49:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so16724383wre.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 02:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaeKeveKWAiwprLiz6zwZYaOpmVo3rpociR52Husvgo=;
        b=D9SfNj0N4+y1UgHt4crgolF+lOjbyf6bxdd4xwyL3/BG7RblauWllOGQbKBAgGrO86
         tcjdQDBeku28X4t7MEPCHUQkKMShnNxG9kb0r/vsh8fV3cI028G655b3cwjxxDqT2+ZC
         US809W+AWabeWvU791DIVh2ieUSoW/aPQzuC0LS2UGXeDSZNrqv2aNUe+x9C1yb2D2QA
         fdBrNlv3fK4Jd8H98Uoi5tF/F6Jk8yWQGWSedH+gpMzRPFU3ZuKOW1FzU3pY0olW/kWd
         N98O04SideX5lJAv/9z2+kvG9SxKrf+IGa12Ec+QiLLyobN1aasUj8CppRDe97iYmNof
         LXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaeKeveKWAiwprLiz6zwZYaOpmVo3rpociR52Husvgo=;
        b=daktZp6Q3Zz6t97RzsUX7xo3jU0Ah6uvwvpqswJoovPxsVAO0Zcy/VvIHj37OI5Fxg
         NIGZgzBhxlFtyVPWkj+H5se6rnRPU17iZfrgi9iej8ojphJl0z7FYjx1FskxF0SSwihP
         UxFpd983uhyAIN3KEgLE6R9iv4TchX2sTO2r0Hsls4HTIVIZyXmaxnHODuFYpbaEcfr3
         q9UjKrlBp+v19f15xzbxyJ92tZkk8iooECOitkTWi7iIT+YsILPeA6Xo7EtI71AVjdWv
         BJMNa078Zl9U5sUrXK7+wSGprhCs/G8uuyN4FziMswFFZkTOw3r9rIKW3FVQV8+zKk2z
         Fpvg==
X-Gm-Message-State: AGRZ1gJklrgdaoioP2lh1NERkAynXfWhXDh23sSw0k3iFAqUZrQr8yv2
        kOt3+8KXLdP07UNBVrBYFj8=
X-Google-Smtp-Source: AJdET5cHyicMPMjyXAq5xNgvunBxGA9amWEV0rZUrSvoWF72eT4qsz19Q1moOfUnsblBHoB/j8HxDA==
X-Received: by 2002:adf:dc87:: with SMTP id r7-v6mr1482993wrj.143.1542192393502;
        Wed, 14 Nov 2018 02:46:33 -0800 (PST)
Received: from localhost.localdomain (x4db1d05b.dyn.telefonica.de. [77.177.208.91])
        by smtp.gmail.com with ESMTPSA id p188-v6sm11274079wmp.31.2018.11.14.02.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 02:46:32 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] clone: use a more appropriate variable name for the default refspec
Date:   Wed, 14 Nov 2018 11:46:18 +0100
Message-Id: <20181114104620.32478-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.gbfcc7ed3e6
In-Reply-To: <20181114104620.32478-1-szeder.dev@gmail.com>
References: <20181114104620.32478-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_clone() declares two strbufs 'key' and 'value' on the same line,
suggesting that they are used to contruct a config variable's name and
value.  However, this is not the case: 'key' is used to construct the
names of multiple config variables, while 'value' is never used as a
value for any of those config variables, or for any other config
variable for that matter, but only to contruct the default fetch
refspec.

Let's rename 'value' to 'default_refspec' to make the intent clearer.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 15b142d646..ae1bf242c6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -890,7 +890,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
+	struct strbuf default_refspec = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
@@ -1067,7 +1068,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -1081,9 +1081,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	refspec_append(&rs, value.buf);
-
-	strbuf_reset(&value);
+	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
+		    branch_top.buf);
+	refspec_append(&rs, default_refspec.buf);
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
@@ -1240,7 +1240,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-	strbuf_release(&value);
+	strbuf_release(&default_refspec);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	refspec_clear(&rs);
-- 
2.19.1.1182.gbfcc7ed3e6

