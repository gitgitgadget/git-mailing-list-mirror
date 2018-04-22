Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A49E1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 18:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeDVSNF (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 14:13:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38797 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeDVSNE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 14:13:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id h3-v6so35231930wrh.5
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8XVqkXhw+OSXK/916mSFFYBzQ2iSLvRo4Ox//ma02o=;
        b=lz1IJnwoGdw4VRhmVYWUa8tSEP/OIFTfY4dANJZDeICgVBY/pGtPS1/X0b+KBs3pb0
         9tFmdjmVxiLsaY0dhCgcwcOVOh3xXMc4GAyNB8mrTp0AYwsDp8VJZq5iudlBtaFKZJxo
         E8PamsqY8DdRArN2uxS837OOdxkg6d9R36TIVfjZV+wOW+SPnB0k6xiW8wk+YHauW2vj
         VMcGI1LCrFTOsUZBg74ipYyv0tbQQBXw8xONWXyGRHPaycMtMER0NmZnqTxu07qhQfUm
         dIKpoEOK6q30zT4W2f0EuDpd3cgyYP9RpDdWCmxHEzrLbrYHG1Ww8q1oVLBHbCl9p69s
         n8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8XVqkXhw+OSXK/916mSFFYBzQ2iSLvRo4Ox//ma02o=;
        b=dQZaCRtq9AzOjcVtWybs4y0kiSX61r3F9PIdNTfAMzhBF9p/3PWvLCak1xZB2DeNZQ
         aXFltrbRbYpMkm+lnEdpGnTl/F4W0jyQ06TlrxaPwnL/AQnAb5rTD05/008T91VehwP4
         whmb7UV/SnOwUPhjyFrAe7PVTZp7F1cwmT1v3mTdnyikUe0Wr22wIEmHL4alOtMlcW6S
         L0v+CcMWpo4GOoBCpAN7lB2+wpS+CPcjCUg0s2FuP8HbadrWSqjdQ8IzzVL5VhQ1gmFF
         O+E5BbGGj0OInpB0xsNpfKVFJnAyHM8JoeZJxbyxXmqKcu9+8gI5bn7QYAtcFG5uqpy/
         gRYQ==
X-Gm-Message-State: ALQs6tCMJ/HvtqlArvVuMmZVVgyi2woDQpsfbjuMztbWwTZG+O2YyK+H
        BAolDJycxZ1zadmcVmzD1X2mFjoF
X-Google-Smtp-Source: AIpwx4/7pgshV/ZYsnWE+3CPCIzvK8DZVIG+YGYBcyp7HsVGHuFXHezR52WOHYkJvfio6Q/pctZQlw==
X-Received: by 10.28.27.194 with SMTP id b185mr8108588wmb.57.1524420782745;
        Sun, 22 Apr 2018 11:13:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id f2-v6sm8354450wre.76.2018.04.22.11.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Apr 2018 11:13:01 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Walton <bwalton@artsci.utoronto.ca>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] http-fetch: make `-a` standard behaviour
Date:   Sun, 22 Apr 2018 20:12:49 +0200
Message-Id: <367243f0c8215f702fd38152952f47121ab337b1.1524420451.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to a6c786fce8 (Mark http-fetch without -a as
deprecated, 2011-08-23). For more than six years, we have been warning
when `-a` is not provided, and the documentation has been saying that
`-a` will become the default.

It is a bit unclear what "default" means here. There is no such thing as
`http-fetch --no-a`. But according to my searches, no-one has been
asking on the mailing list how they should silence the warning and
prepare for overriding the flipped default. So let's assume that
everybody is happy with `-a`. They should be, since not using it may
break the repo in such a way that Git itself is unable to fix it.

Always behave as if `-a` was given. Since `-a` implies `-c` (get commit
objects) and `-t` (get trees), all three options are now unnecessary.
Document all of these as historical artefacts that have no effect.

Leave no-op code for handling these options in http-fetch.c. The
options-handling is currently rather loose. If someone tightens it, we
will not want these ignored options to accidentally turn into hard
errors.

Since `-a` was the only safe and sane usage and we have been pushing
people towards it for a long time, refrain from warning when it is used
"unnecessarily" now. Similarly, do not add anything scary-looking to the
man-page about how it will be removed in the future. We can always do so
later. (It is not like we are in desperate need of freeing up
one-letter arguments.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-http-fetch.txt | 13 +++++--------
 t/t5550-http-fetch-dumb.sh       | 11 +++++++++++
 http-fetch.c                     | 18 +++---------------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 21a33d2c41..666b042679 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -15,8 +15,9 @@ DESCRIPTION
 -----------
 Downloads a remote Git repository via HTTP.
 
-*NOTE*: use of this command without -a is deprecated.  The -a
-behaviour will become the default in a future release.
+This command always gets all objects. Historically, there were three options
+`-a`, `-c` and `-t` for choosing which objects to download. They are now
+silently ignored.
 
 OPTIONS
 -------
@@ -24,12 +25,8 @@ commit-id::
         Either the hash or the filename under [URL]/refs/ to
         pull.
 
--c::
-	Get the commit objects.
--t::
-	Get trees associated with the commit objects.
--a::
-	Get all the objects.
+-a, -c, -t::
+	These options are ignored for historical reasons.
 -v::
 	Report what is downloaded.
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 8552184e74..6d7d88ccc9 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -169,6 +169,17 @@ test_expect_success 'fetch changes via manual http-fetch' '
 	test_cmp file clone2/file
 '
 
+test_expect_success 'manual http-fetch without -a works just as well' '
+	cp -R clone-tmpl clone3 &&
+
+	HEAD=$(git rev-parse --verify HEAD) &&
+	(cd clone3 &&
+	 git http-fetch -w heads/master-new $HEAD $(git config remote.origin.url) &&
+	 git checkout master-new &&
+	 test $HEAD = $(git rev-parse --verify HEAD)) &&
+	test_cmp file clone3/file
+'
+
 test_expect_success 'http remote detects correct HEAD' '
 	git push public master:other &&
 	(cd clone &&
diff --git a/http-fetch.c b/http-fetch.c
index 8af380050c..a1564f5a41 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -17,21 +17,13 @@ int cmd_main(int argc, const char **argv)
 	char *url = NULL;
 	int arg = 1;
 	int rc = 0;
-	int get_tree = 0;
-	int get_history = 0;
-	int get_all = 0;
 	int get_verbosely = 0;
 	int get_recover = 0;
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
-			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
-			get_history = 1;
 		} else if (argv[arg][1] == 'a') {
-			get_all = 1;
-			get_tree = 1;
-			get_history = 1;
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
 		} else if (argv[arg][1] == 'w') {
@@ -55,10 +47,6 @@ int cmd_main(int argc, const char **argv)
 		commits = 1;
 	}
 
-	if (get_all == 0)
-		warning("http-fetch: use without -a is deprecated.\n"
-			"In a future release, -a will become the default.");
-
 	if (argv[arg])
 		str_end_url_with_slash(argv[arg], &url);
 
@@ -68,9 +56,9 @@ int cmd_main(int argc, const char **argv)
 
 	http_init(NULL, url, 0);
 	walker = get_http_walker(url);
-	walker->get_tree = get_tree;
-	walker->get_history = get_history;
-	walker->get_all = get_all;
+	walker->get_tree = 1;
+	walker->get_history = 1;
+	walker->get_all = 1;
 	walker->get_verbosely = get_verbosely;
 	walker->get_recover = get_recover;
 
-- 
2.17.0

