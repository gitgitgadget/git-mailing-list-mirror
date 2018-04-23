Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935A21F424
	for <e@80x24.org>; Mon, 23 Apr 2018 22:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbeDWWqg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 18:46:36 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:53718 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWWqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 18:46:34 -0400
Received: by mail-it0-f73.google.com with SMTP id o66-v6so9933766ita.3
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=V6D+A/RAlWJNVyRGCojTXLyNvpQMiAc2lO9+VmmrJ/o=;
        b=q5dL9o/NOx8zZWCoR2rHwyBkPq98ZYNd+SJF2B3vJJJ+1zBR7OoBYsi7Ws7c+IWgie
         Sarzr9sCav/39BqVUnR6iNT1iHzuOUksEfVUXXy5xZFvVVajz3TIF7RBj3ov+aBNtBCP
         BIXez0zJmS9Nrdd/MEw6XFWh6hqPC9QYInzpU8ml5BlfKTWGqK1YSMveAQQm2/QrV/yr
         EA5Cpjd6xDctpbfJSFZ14ZQ0RE4Wk0e6b5owxTXstxmE105wi6CsTcTOeaW17jHTep65
         rm1mTwVIod/Z5tbqc3SqnL46S8QbP2v7STdRUiMZkyiBOZn5pSrfiTsICrW4712Mudz5
         uD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=V6D+A/RAlWJNVyRGCojTXLyNvpQMiAc2lO9+VmmrJ/o=;
        b=RNQNvruThBfLtihwyNvM2TnhL7lb0MHAc2bKZfHjZRUiVBzpju2EKcDuOlXXSV1Cmh
         m0CV9+RGtnGLuGgEAW2SkfJ8e5+ku6KuvQzzU2GZYd5ph7Rpn7T8corx9QwXDmIjUyV4
         zRZzhGUwDGJ+wIG/TWkPcexPfbVhOI2WJY/1vglpINUtvZ9Sm5fU/AOVompxZg5fOGYa
         9Gg6KBEm+UN3FCqL09KDMdR1z5nMrsfCzuD3+PvKzzi1iAW8h+4aCY1/EEJGfXfVNsDJ
         PoUXOzytZtPSg37EEyZ8sIRPIHMTXcxfVPzT8hXQNqiKgjo9PyfZG6BTXibCkp6zkAM0
         qq0g==
X-Gm-Message-State: ALQs6tBITW5bznc5nz4U+PX8bXqS9hzEYjqdrLSpfoQJrdyE8WMMdbvT
        sQBP7TNMQvQbDpx4Qgxz6930818Mi2BPq3rfpRB4hAMJMqAqLSVnhE76ZuOYt8eGRodaBuWXbgq
        396QpGsfEadep28iD+/agEJkccP7JtB67y0bxtphUW4ZxJPd9N9JrznsaZA==
X-Google-Smtp-Source: AB8JxZqLSTzkUj8zwkOl/4bZo9s5n5bbcv+HoZzSrSuvcrj9UJIy09kJMoHL6XN30CCabizGZ3XijanghjI=
MIME-Version: 1.0
X-Received: by 2002:a24:f342:: with SMTP id t2-v6mr8483122iti.49.1524523593715;
 Mon, 23 Apr 2018 15:46:33 -0700 (PDT)
Date:   Mon, 23 Apr 2018 15:46:22 -0700
In-Reply-To: <20180423224624.213341-1-bmwill@google.com>
Message-Id: <20180423224624.213341-2-bmwill@google.com>
References: <20180423224624.213341-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 1/3] serve: introduce the server-option capability
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the "server-option" capability to protocol version 2.  This
enables future clients the ability to send server specific options in
command requests when using protocol version 2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt | 10 ++++++++++
 serve.c                                 |  1 +
 t/t5701-git-serve.sh                    | 21 +++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 136179d7d..d7b6f38e0 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -393,3 +393,13 @@ header.
 		1 - pack data
 		2 - progress messages
 		3 - fatal error message just before stream aborts
+
+ server-option
+~~~~~~~~~~~~~~~
+
+If advertised, indicates that any number of server specific options can be
+included in a request.  This is done by sending each option as a
+"server-option=<option>" capability line in the capability-list section of
+a request.
+
+The provided options must not contain a NUL or LF character.
diff --git a/serve.c b/serve.c
index a5a7b2f7d..bda085f09 100644
--- a/serve.c
+++ b/serve.c
@@ -56,6 +56,7 @@ static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
 	{ "ls-refs", always_advertise, ls_refs },
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
+	{ "server-option", always_advertise, NULL },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 72d7bc562..011a5796d 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -10,6 +10,7 @@ test_expect_success 'test capability advertisement' '
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs
 	fetch=shallow
+	server-option
 	0000
 	EOF
 
@@ -173,4 +174,24 @@ test_expect_success 'symrefs parameter' '
 	test_cmp actual expect
 '
 
+test_expect_success 'sending server-options' '
+	test-pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	server-option=hello
+	server-option=world
+	0001
+	ref-prefix HEAD
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) HEAD
+	0000
+	EOF
+
+	git serve --stateless-rpc <in >out &&
+	test-pkt-line unpack <out >actual &&
+	test_cmp actual expect
+'
+
 test_done
-- 
2.17.0.484.g0c8726318c-goog

