Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC8C2BA17
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8642074B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX4NqHuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDDBJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:09:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41414 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgDDBJC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:09:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id d24so3484868pll.8
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/05iEFWX5JXC5UQTYfzsFMJZ0Wb9bXyAbm9U1echHc=;
        b=mX4NqHuS6+FAOXYWMGw+GQRXEfxKt9m1yNSQMWWXF4rBjxrvHwnAUEoEdNrIQgdhJY
         esbklpcl5MsdvW0RSLVj1jiACPXocqRSOq9HG9rrNLTXhoc5QIkX20JvIZhOeVEyT8vP
         GXGwlKMSf8aPVCeQCYgmkeTohyGQx4W9TF+cuWlViQVMT8da5ebXMfQurY43XBC4nGop
         F7BoaZxirDSTQqlZKiyhHbGmtMLqj9kXQtOgzpaPN+b53OhQ3Q+zMVwmKoWhIO1MJo2p
         38o80e4mZfbyvmLbp0pW/754xhEVmL+AW1RqEDqwbU3bB5B/horh6VzHrNeONvKFTUdq
         KTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/05iEFWX5JXC5UQTYfzsFMJZ0Wb9bXyAbm9U1echHc=;
        b=Zf4VfCtJPQLcAPHJEOaJazyzrJoHqN/8VOMURejPZ41p4z8zmsloo3eBP3RKvGxdin
         19mZpX7k//lq61IPCSlnCd5+Dujd6GN1AxsmTqWIAFbdJeOezPc2WUBgpNeqxx/Kasaj
         /7/aNzSZH7/X869U4QEx2xw03wiqQEDY6SCRjry9IRT7tPQH++89dzWLSDLqO1uajyV5
         dRaf859kFKpwoGDlRrGP0G+WOrehN8xOI0MABU1KA4UgLkkYloj+WPL+HuHTYeXr/DwV
         HX5ZjxjqSWkg6iZT/dJegndl3v7CRaKpELacE6y3WcGgwFyKA3BYC1nfNHrf8DzKL5VW
         WXRg==
X-Gm-Message-State: AGi0PubRwbD8HvBlcvWZgsW8QNcBXLVw7kCeY1SFNipUkTFKGVmGK6Qg
        cbWtWajxPOm8ppgYp0A596PN+7w0
X-Google-Smtp-Source: APiQypJ4Ktk+GF+Cg7HKvISSmSNP8ffrxMzGfThv9AD59MWhgppNSr045j1voX8Gwu4CVAH450+uoA==
X-Received: by 2002:a17:902:a588:: with SMTP id az8mr10143285plb.338.1585962541002;
        Fri, 03 Apr 2020 18:09:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o12sm6664319pjt.16.2020.04.03.18.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:09:00 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 1/6] ci: make MAKEFLAGS available inside the Docker container in the Linux32 job
Date:   Sat,  4 Apr 2020 08:08:45 +0700
Message-Id: <2fdce60075935f8ff94bc117747f1768f41ed435.1585961568.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585961568.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com> <cover.1585961568.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Once upon a time we ran 'make --jobs=2 ...' to build Git, its
documentation, or to apply Coccinelle semantic patches.  Then commit
eaa62291ff (ci: inherit --jobs via MAKEFLAGS in run-build-and-tests,
2019-01-27) came along, and started using the MAKEFLAGS environment
variable to centralize setting the number of parallel jobs in
'ci/libs.sh'.  Alas, it forgot to update 'ci/run-linux32-docker.sh' to
make MAKEFLAGS available inside the Docker container running the 32
bit Linux job, and, consequently, since then that job builds Git
sequentially, and it ignores any Makefile knobs that we might set in
MAKEFLAGS (though we don't set any for the 32 bit Linux job at the
moment).

So update the 'docker run' invocation in 'ci/run-linux32-docker.sh' to
make MAKEFLAGS available inside the Docker container as well.  Set
CC=gcc for the 32 bit Linux job, because that's the compiler installed
in the 32 bit Linux Docker image that we use (Travis CI nowadays sets
CC=clang by default, but clang is not installed in this image).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh                | 3 +++
 ci/run-linux32-docker.sh | 1 +
 2 files changed, 4 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index c3a8cd2104..d637825222 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -198,6 +198,9 @@ osx-clang|osx-gcc)
 GIT_TEST_GETTEXT_POISON)
 	export GIT_TEST_GETTEXT_POISON=true
 	;;
+Linux32)
+	CC=gcc
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 751acfcf8a..ebb18fa747 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -20,6 +20,7 @@ docker run \
 	--env GIT_PROVE_OPTS \
 	--env GIT_TEST_OPTS \
 	--env GIT_TEST_CLONE_2GB \
+	--env MAKEFLAGS \
 	--env cache_dir="$container_cache_dir" \
 	--volume "${PWD}:/usr/src/git" \
 	--volume "$cache_dir:$container_cache_dir" \
-- 
2.26.0.334.g6536db25bb

