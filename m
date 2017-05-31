Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FE71FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdEaVol (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:41 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35860 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdEaVok (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:40 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so18545581pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fUg1la7Glvqb3km30vN/mCc/Uen16qLR5oLzu6em53U=;
        b=qdXr36bcco6X4H9opTFI7jclm8IEyS1p4V0ItLw4j0p6TWz6Cu7bewsdDzQ18SAiO7
         yR2VKiRP3kBZR2FwtFpr3oea+shn66hA1P248s2ah8F7oMaUDxHPPdJZQqTGE4o8KjFS
         Ojd1R/XEX4EsujF+HRf9bGylIQP5BTMzPk8CTxlY2WcbU4KXIRNWYYHuQYINz+9AEuMO
         000hBLHVJ70c1ebT5ACXAdCOja+CLdKZk1tNgalx6gAFA9clQPY1ZhrbJSv74XBBIPDQ
         JEdgB6z9kLo92tXJHEiuvDjrtXp/9nAGZ3YG7M3LSJ0TLkhwhYC8EN1dfrqW7sgIWozJ
         oRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fUg1la7Glvqb3km30vN/mCc/Uen16qLR5oLzu6em53U=;
        b=r0YLwDfDvxE7jAJps2iFrfmzaVH7sSQMFwluUQpj6Yjyk9XkfV2DhsGtaAmalM3BaC
         GW/ohsK22kR7vLTxHNYY86sAMdmPYpF7L4ewkoIW2oIrVvk9h7nLqdIsbhaywCHg9jg8
         P/ULK6qdOXVAbuquVDSk3khDVtvE4X0xUCN/1N7rBXrKEYPs2kFNZyBXE0EV+xAdzaJQ
         NO9aiM7EvfvgT9oJkoYA07tHQ5o/QPT0W0R+LL5joVnhcOURF58aulNMXBpQG/IlTBZU
         CEdB2nQX5C/4iTek0TX4zeEWPF6JEr+3dgbVuogWN4kpthjkq6TheaZEZJGhn+r6ga8d
         sdqw==
X-Gm-Message-State: AODbwcCm/TIxw18i7osAYdfDYXochFlUaKB5F/lLuYCZzUFm79ZqImSc
        XoIes5HEEaxVxr4VNxI+0w==
X-Received: by 10.98.149.68 with SMTP id p65mr32793609pfd.206.1496267079468;
        Wed, 31 May 2017 14:44:39 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:38 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/31] environment: remove namespace_len variable
Date:   Wed, 31 May 2017 14:43:51 -0700
Message-Id: <20170531214417.38857-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use 'skip_prefix' instead of 'starts_with' so that we can drop the need
to keep around 'namespace_len'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 environment.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index a73b08f5d..e035f6372 100644
--- a/environment.c
+++ b/environment.c
@@ -98,7 +98,6 @@ char *git_work_tree_cfg;
 static char *work_tree;
 
 static const char *namespace;
-static size_t namespace_len;
 
 static const char *super_prefix;
 
@@ -190,7 +189,6 @@ void setup_git_env(void)
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
-	namespace_len = strlen(namespace);
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
 		set_alternate_shallow_file(shallow_file, 0);
@@ -231,9 +229,10 @@ const char *get_git_namespace(void)
 
 const char *strip_namespace(const char *namespaced_ref)
 {
-	if (!starts_with(namespaced_ref, get_git_namespace()))
-		return NULL;
-	return namespaced_ref + namespace_len;
+	const char *out;
+	if (skip_prefix(namespaced_ref, get_git_namespace(), &out))
+		return out;
+	return NULL;
 }
 
 const char *get_super_prefix(void)
-- 
2.13.0.506.g27d5fe0cd-goog

