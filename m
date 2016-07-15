Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3169203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 20:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbcGOUoR (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 16:44:17 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37588 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbcGOUoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 16:44:16 -0400
Received: by mail-it0-f44.google.com with SMTP id f6so28846838ith.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 13:44:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jVXKDXRxwH6FsQqA2IUo7tPh0xGWJDdwAXoYzAmlm1E=;
        b=eKOvqMmpFOrwsB2QN1rAJhez+qRYuqmSEIOVQFl4wcQopeaMAruGx0QBUGIRv08Nx4
         cFxlHvhkGKAG94RqIQkVJ4Kgp08Dfohzlzr0kSROIgFvj5h4C/FJJRqP6M9mNrA/oKy+
         aN98dWLyWD0fz/rrDLVs2MfTmAqjEFw8H4KXVj4RzU2KAjMOrn6AULSE1iNi7WLgcInv
         wULfIP1Dlw6AByExPmteI+JExcfY495Pr5RD9d4D9O7vuva6epiqPKYS6jKt7DUDnyvX
         jtdBOViOv1X07Ng0oXxLC3TV6Hb2A4eJIvAdOnumQiKlW5xOmDmYA/XTEAUk17iARtFf
         4/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jVXKDXRxwH6FsQqA2IUo7tPh0xGWJDdwAXoYzAmlm1E=;
        b=RmDt28h4aOA9Qv0f237KbOLGlbxoOxmvzMoYvu53T2Xu+mNh4XPgpHNY6phbTkFPF5
         0IdVMNqb2eXQyM8mKligmyQ1F4A+KBt7jrq66aT5D8uO3hGke2fXwwMjwIQwIkY+LwS0
         imMS8OhIPe+Rvu51ilkfnD3grh/lB2ziyKdD4Nb+TcpcIYL8KF06keGREZFT63QGtBCk
         z8AeLKem+299imKjE47GyQk86S/rjXH0a2a0rDl08MDWVcfzaFWk780IvwnMLIhX5Dc3
         rGQgacACARhof09njO1HsR2juULGml1s+qXArput22o0Mq7sHM+ezJ+J5Q50ZxFxXVFA
         T6Cg==
X-Gm-Message-State: ALyK8tKUE3jgHMZgrHUg328eOj1y7SXCuKPbcyNYQkHwYtKvJOGJ7S2xMkmys7VWJzED1wMEG6FYE+Bghb09tA==
X-Received: by 10.36.206.129 with SMTP id v123mr37877264itg.11.1468615455350;
 Fri, 15 Jul 2016 13:44:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Fri, 15 Jul 2016 13:44:14 -0700 (PDT)
From:	Parker Moore <parkrmoore@gmail.com>
Date:	Fri, 15 Jul 2016 13:44:14 -0700
Message-ID: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
Subject: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
To:	git@vger.kernel.org
Cc:	cranger@google.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Parker Moore <parkrmoore@gmail.com>

This fixes contrib/persistent-https builds for Go v1.7+ and is
compatible with Go v1.5+.

Running `make all` in `contrib/persistent-https` results in a failure
on Go 1.7 and above.

Specifically, the error is:

    go build -o git-remote-persistent-https \
   -ldflags "-X main._BUILD_EMBED_LABEL 1468613136"
    # _/Users/parkr/github/git/contrib/persistent-https
    /usr/local/Cellar/go/1.7rc1/libexec/pkg/tool/darwin_amd64/link: -X
flag requires argument of the form importpath.name=value
    make: *** [git-remote-persistent-https] Error 2

This `name=value` syntax for the -X flag was introduced in Go v1.5
(released Aug 19, 2015):

- release notes: https://golang.org/doc/go1.5#link
- commit: https://github.com/golang/go/commit/12795c02f3d6fc54ece09a86e70aaa40a94d5131

In Go v1.7, support for the old syntax was removed:

- release notes: https://tip.golang.org/doc/go1.7#compiler
- commit: https://github.com/golang/go/commit/51b624e6a29b135ce0fadb22b678acf4998ff16f

This patch includes the `=` to fix builds with Go v1.7+.
---
 contrib/persistent-https/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/persistent-https/Makefile
b/contrib/persistent-https/Makefile
index 92baa3be..033140b 100644
--- a/contrib/persistent-https/Makefile
+++ b/contrib/persistent-https/Makefile
@@ -26,7 +26,7 @@ git-remote-persistent-http: git-remote-persistent-https

 git-remote-persistent-https:
  go build -o git-remote-persistent-https \
- -ldflags "-X main._BUILD_EMBED_LABEL $(BUILD_LABEL)"
+ -ldflags "-X main._BUILD_EMBED_LABEL=$(BUILD_LABEL)"

 clean:
  rm -f git-remote-persistent-http* *.tar.gz
