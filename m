Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92531F461
	for <e@80x24.org>; Sun,  7 Jul 2019 05:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfGGFvh (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jul 2019 01:51:37 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35492 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGGFvh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jul 2019 01:51:37 -0400
Received: by mail-pf1-f202.google.com with SMTP id r142so8066223pfc.2
        for <git@vger.kernel.org>; Sat, 06 Jul 2019 22:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cl+HIBp1IRJ9czZhK8I5Ki4EQ1RNmKb48ilvIJTLcW4=;
        b=Cj/xA0boIKpWdc38BZhAAKPHVuauX9FlM226LOCl85XtyfpPrnT25q2Y2UzcxSgYCu
         vxJizM+GkJ6Zv85YidDSaZLzBhi82liLegLqX7CBSyOv3Mf04irmSlO/rMPb5tM7iyAo
         LonM+kOiHW8nWDLn+uSCVUNOO3qxJAn0elAFjp7QOr4GFnV39LZdIGmyECZqXVSbXw+A
         7z1/vkloUHYpgqH2FhToiyMeo1ZyCyM6QmTcsWh9cWC33hZ3Pls/xXI5qKejhaIn1tsK
         Y10FSvs98fDu/+Qo/aDJajopuXBWZoVzfP+fURRlo/63rk5yadZymdL/x4g2jcOt1lqJ
         HKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cl+HIBp1IRJ9czZhK8I5Ki4EQ1RNmKb48ilvIJTLcW4=;
        b=WXM1E/CUkmgCODquR4y7UHN/5zxtZvq3LoMYQaUpPft4bNk1Kme+NhsOXXpgUWhdSC
         zGBm2oCxYypK9UPsIwQUiPjZsRrNqpfUhK4puT/bpdqL/LmTl7BpK06WxacoI0X6F9jt
         7/LHIAZDBxk1a5XtF7oPkFQ2crgKTMNlAz11inlIbZeXSLg6UzcRe8IyNrmLAv/xyTBV
         /h89IrLL/Lme9ut+45ewPUzyU+yVnj+0JugN+Uk5CrA6k7WBkmt9lJFG+sD1K56UYW79
         h2g5byh8Ucsp85k53vASu+VZ6hffy03LCRyqzilJdeqV6cCNQ2s1rhT8IlHVn+4RzOpy
         yE2w==
X-Gm-Message-State: APjAAAWOSQnsxfGTjer3n/KiQnbhd/TPOPdUNduU03h+2Bu9Kl3hw3kU
        79Q50EykQDZ9OCbzLvjV2H6iClea6B5zxPJqnq31QYNSx0cDFYOhmr66XpEhx/+KHgEj1TWimKl
        a+FgAl0HYL53HMFRFr//us4RaWRCEOGi7v2Gz7XToj9/F6XF3u7PCrWqobuqIhU5r1yQFzQTs1g
        ==
X-Google-Smtp-Source: APXvYqxAE6lHW2MnbRWbB91Jy/o9AT6NvaPCskC65vBZh7Yu083bLTQ9S5vEhZaLXZd+5jX9ocCIrEvv37p7UQMvmmI=
X-Received: by 2002:a63:5765:: with SMTP id h37mr14153720pgm.183.1562478695861;
 Sat, 06 Jul 2019 22:51:35 -0700 (PDT)
Date:   Sat,  6 Jul 2019 22:51:32 -0700
Message-Id: <20190707055132.103736-1-masayasuzuki@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] credential: add nocache option to the credentials API
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The credentials API calls credentials helpers in order. If a
username/password pair is returned the helpers and if it's used for
authentication successfully, it's announced to the helpers and they can
store it for later use.

Some credentials are valid only for the limited time and should not be
cached. In this case, because the credential is announced to all helpers
and they can independently decide whether they will cache it or not,
those short-lived credentials can be cached.

This change adds an option that a credential helper can specify that the
credential returned by the helper should not be cached. If this is
specified, even after the credential is used successfully, it won't be
announced to other helpers for store.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 Documentation/technical/api-credentials.txt | 4 +++-
 credential.c                                | 4 +++-
 credential.h                                | 3 ++-
 t/t0300-credentials.sh                      | 9 +++++++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 75368f26ca..3db5841b40 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -251,7 +251,9 @@ even no values at all if it has nothing useful to provide. Any provided
 attributes will overwrite those already known about by Git.  If a helper
 outputs a `quit` attribute with a value of `true` or `1`, no further
 helpers will be consulted, nor will the user be prompted (if no
-credential has been provided, the operation will then fail).
+credential has been provided, the operation will then fail). If a helper outputs
+a `nocache` attribute with a value of `true` or `1`, `credential_approve` will
+not be called even after the credential is used for authentication sucessfully.
 
 For a `store` or `erase` operation, the helper's output is ignored.
 If it fails to perform the requested operation, it may complain to
diff --git a/credential.c b/credential.c
index 62be651b03..db7b351447 100644
--- a/credential.c
+++ b/credential.c
@@ -179,6 +179,8 @@ int credential_read(struct credential *c, FILE *fp)
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
 			c->quit = !!git_config_bool("quit", value);
+		} else if (!strcmp(key, "nocache")) {
+			c->no_cache= !!git_config_bool("nocache", value);
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
@@ -296,7 +298,7 @@ void credential_approve(struct credential *c)
 {
 	int i;
 
-	if (c->approved)
+	if (c->approved || c->no_cache)
 		return;
 	if (!c->username || !c->password)
 		return;
diff --git a/credential.h b/credential.h
index 6b0cd16be2..be0f35d841 100644
--- a/credential.h
+++ b/credential.h
@@ -8,7 +8,8 @@ struct credential {
 	unsigned approved:1,
 		 configured:1,
 		 quit:1,
-		 use_http_path:1;
+		 use_http_path:1,
+		 no_cache:1;
 
 	char *username;
 	char *password;
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 82eaaea0f4..ad06f6fe11 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -118,6 +118,15 @@ test_expect_success 'do not bother storing password-less credential' '
 	EOF
 '
 
+test_expect_success 'credential_approve does not call helpers for nocache' '
+	check approve useless <<-\EOF
+	username=foo
+	password=bar
+	nocache=1
+	--
+	--
+	EOF
+'
 
 test_expect_success 'credential_reject calls all helpers' '
 	check reject useless "verbatim one two" <<-\EOF
-- 
2.22.0.410.gd8fdbe21b5-goog

