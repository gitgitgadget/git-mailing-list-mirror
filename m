Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822701F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756394AbdLPM6K (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:58:10 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38290 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754229AbdLPM6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:58:09 -0500
Received: by mail-wr0-f196.google.com with SMTP id o2so10235908wro.5
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hJT8BZm41+kXKjchMZtQyoH4nQBJWRtyUEO4xRN9gI=;
        b=eHsEoSuf55nkABhutEhkUUfBTpIN9chr8dDLSSyZ7bm+rk1BaoeEoSIPOWqdENZsGb
         sSJqFHQN2wnKMIMO62FF2L6oFmuGcMT+UHoslZ4+UCMjo5M8vCakO9SJE9mCqym1jgnL
         Rr/ZlRoZPGQ88H4UUxwNCL4VUxpAkI1C679sKp3/izy7nTRYChnkil7gYCEbWlRjg0Uw
         Gciw3+sAf0wWCb+kOm0s+LP7z4w8dwSA0vdaPVhAC0NwbJi6IagQbEhQ/XFZmyS9jCZS
         q7ESPYjoM6+3zKrRiCrGK4XmF0hIGZVV6DpiqkX53ZtfuyD0uIwXclr3qQfciPRVw5fU
         DspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hJT8BZm41+kXKjchMZtQyoH4nQBJWRtyUEO4xRN9gI=;
        b=DZaqSNGrJldu3Uf3QpVlrGrqAJNmldmIYbr8LF64zyXiG4KMXMSPWeVhTD4GSVqx0R
         At42/VlOSjh7HrXZ+iB0jqnPuEXd95ZxaZgvCVRH+UqGM0KHtnkJ1ND9jlKd2cNvqexQ
         XnMHBBaijCncfYxlbuN9njV3rMLdxZulC+ZMWoT89LZN3T6+qGHd7xwCLnOyZNcjNl1N
         hR2Ipwr2NIGzoJHzT6famg7Y6AIRclrMo3ZNUGyeCSMN6Yyzfai0s77jCeM34HjKD/qD
         OOGA/IHNdiPYrHaBa1VC4uz03DJfeGuymQOvTXuPcPulQmk25k7nM24aTw/+AZBJ6orP
         6vbg==
X-Gm-Message-State: AKGB3mJyhzANiqJB83NzTKZ6UsmVV1GcmFwo1040D3glhNRqJYb4FEb7
        v+vX3fbUTl+QL4rGUrZuBlM=
X-Google-Smtp-Source: ACJfBov5aPXk5G5B9N1YzoGf8sNl8Vsmfgl8YLgzzY+a69OSk003l2UKUW1x52uDzH8mWrMEePrl7g==
X-Received: by 10.223.156.146 with SMTP id d18mr12342932wre.161.1513429088660;
        Sat, 16 Dec 2017 04:58:08 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id e4sm7797156wmi.14.2017.12.16.04.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:58:08 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 7/8] travis-ci: save prove state for the 32 bit Linux build
Date:   Sat, 16 Dec 2017 13:58:06 +0100
Message-Id: <20171216125806.11193-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change follows suit of 6272ed319 (travis-ci: run previously
failed tests first, then slowest to fastest, 2016-01-26), which did
this for the Linux and OSX build jobs.  Travis CI build jobs run the
tests parallel, which is sligtly faster when tests are run in slowest
to fastest order, shortening the overall runtime of this build job by
about a minute / 10%.

Note, that the 32 bit Linux build job runs the tests suite in a Docker
container and we have to share the Travis CI cache directory with the
container as a second volume.  Otherwise we couldn't use a symlink
pointing to the prove state file in the cache directory, because
that's outside of the directory hierarchy accessible from within the
container.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh  | 1 +
 ci/run-linux32-docker.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index a8518eddf..c19c50c1c 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -27,6 +27,7 @@ test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
     cd /usr/src/git &&
+    ln -s /tmp/travis-cache/.prove t/.prove &&
     make --jobs=2 &&
     make --quiet test
 '
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 0edf63acf..3a8b2ba42 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -19,5 +19,6 @@ docker run \
 	--env GIT_TEST_OPTS \
 	--env GIT_TEST_CLONE_2GB \
 	--volume "${PWD}:/usr/src/git" \
+	--volume "${HOME}/travis-cache:/tmp/travis-cache" \
 	daald/ubuntu32:xenial \
 	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
-- 
2.15.1.429.ga000dd9c7

