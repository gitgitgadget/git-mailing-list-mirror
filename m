Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A691A1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 17:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeA2RRh (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 12:17:37 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36506 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbeA2RR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 12:17:29 -0500
Received: by mail-wm0-f48.google.com with SMTP id f3so35212733wmc.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 09:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wt98KyHUvkPk9ErybjDJIjUUBdcf9moEWFbXSEmhSCY=;
        b=TmaordX3y1YgLJs0yZoj+G1TjfRetkrLfI/u55FMa8xkqMMcGW5XtjWByq/8WwB7CN
         Swzk0WetFFyKbIQixo1bRMrPSi4ipCNE/O5zN0Qmd+1dwV57OLMe4Oy9EQWmnWfsaM4L
         DIxLhZDTKVW+c2JNeew0TcQs9/gzvFpygjh2yL2PEfZV7guZZtDdboACh7Ly9MluLSP3
         1OknQdx9LJp2iDNg4R1ZD/wE7vzMyBKOFVEpv3T7sYbBFkmRaiXcmQkJNSv2nxYHyI89
         1L0cATWQ4wmJk0/RDgnk6UH1+fF+NwNJM4/9cKeR+vZdUzFCRpAAGeLq3eyvV2rd66qX
         6E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wt98KyHUvkPk9ErybjDJIjUUBdcf9moEWFbXSEmhSCY=;
        b=rtoV85Hiz8hQYZCKUjGzI9Ew/E+VSHVTeLXCtv3NL7hOJ/XjpqKH9N1Xyr1Nr1tZC8
         QZABI1NCFj7zV3aV3xcDnYKOeK2qgk1EDRMv6bdNVeMggVuc3F2Fu7+3DMnL1SuuoRkr
         qPa2t8XvDfRKMBqqoBRlrFuGmM2ax8PAEGpyy2eTtLpgSQlQnJOAlU/Q8fVy+XGYPMDh
         5z4dm7cvhhwWwV8Ur+TzTg8TIC+n9ZaETvc8hAHpGzwkYvup7t72jXY5bhmlOfxGlEsZ
         OWEheJearkidgoDAIhh6U/wHPtTjZ27yxk5tLukVVmuuVuAG6PVwAnliJ0bgbD4cj6J5
         +AGQ==
X-Gm-Message-State: AKwxytc5DfccerCra5nKKlbLvHN6wA2+sb2tAySNTNouiLOjeN5OEgnH
        TM1B+6I8pL76VnX6lmWW4No=
X-Google-Smtp-Source: AH8x225O7hd5/LBx7z0OO7KvVKGdFlh3bquTv8uwQf8PTC0NxdXs43VfGosRx5tHMDo7iMeSo8lE3A==
X-Received: by 10.28.66.198 with SMTP id k67mr17063626wmi.74.1517246248262;
        Mon, 29 Jan 2018 09:17:28 -0800 (PST)
Received: from localhost.localdomain (x590c5617.dyn.telefonica.de. [89.12.86.23])
        by smtp.gmail.com with ESMTPSA id p21sm4050876wmc.28.2018.01.29.09.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jan 2018 09:17:27 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 4/5] travis-ci: don't run the test suite as root in the 32 bit Linux build
Date:   Mon, 29 Jan 2018 18:17:12 +0100
Message-Id: <20180129171713.17471-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180129171713.17471-1-szeder.dev@gmail.com>
References: <20180129171713.17471-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI runs the 32 bit Linux build job in a Docker container, where
all commands are executed as root by default.  Therefore, ever since
we added this build job in 88dedd5e7 (Travis: also test on 32-bit
Linux, 2017-03-05), we have a bit of code to create a user in the
container matching the ID of the host user and then to run the test
suite as this user.  Matching the host user ID is important, because
otherwise the host user would have no access to any files written by
processes running in the container, notably the logs of failed tests
couldn't be included in the build job's trace log.

Alas, this piece of code never worked, because it sets the variable
holding the user name ($CI_USER) in a subshell, meaning it doesn't
have any effect by the time we get to the point to actually use the
variable to switch users with 'su'.  So all this time we were running
the test suite as root.

Reorganize that piece of code in 'ci/run-linux32-build.sh' a bit to
avoid that problematic subshell and to ensure that we switch to the
right user.  Furthermore, make the script's optional host user ID
option mandatory, so running the build accidentally as root will
become harder when debugging locally.  If someone really wants to run
the test suite as root, whatever the reasons might be, it'll still be
possible to do so by explicitly passing '0' as host user ID.

Finally, one last catch: since commit 7e72cfcee (travis-ci: save prove
state for the 32 bit Linux build, 2017-12-27) the 'prove' test harness
has been writing its state to the Travis CI cache directory from
within the Docker container while running as root.  After this patch
'prove' will run as a regular user, so in future build jobs it won't
be able overwrite a previously written, still root-owned state file,
resulting in build job failures.  To resolve this we should manually
delete caches containing such root-owned files, but that would be a
hassle.  Instead, work this around by changing the owner of the whole
contents of the cache directory to the host user ID.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh  | 30 +++++++++++++++++++++++++-----
 ci/run-linux32-docker.sh |  2 +-
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index d020b762c..8c1b500e6 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -3,11 +3,17 @@
 # Build and test Git in a 32-bit environment
 #
 # Usage:
-#   run-linux32-build.sh [host-user-id]
+#   run-linux32-build.sh <host-user-id>
 #
 
 set -ex
 
+if test $# -ne 1 || test -z "$1"
+then
+	echo >&2 "usage: run-linux32-build.sh <host-user-id>"
+	exit 1
+fi
+
 # Update packages to the latest available versions
 linux32 --32bit i386 sh -c '
     apt update >/dev/null &&
@@ -18,11 +24,25 @@ linux32 --32bit i386 sh -c '
 # If this script runs inside a docker container, then all commands are
 # usually executed as root. Consequently, the host user might not be
 # able to access the test output files.
-# If a host user id is given, then create a user "ci" with the host user
-# id to make everything accessible to the host user.
+# If a non 0 host user id is given, then create a user "ci" with that
+# user id to make everything accessible to the host user.
 HOST_UID=$1
-CI_USER=$USER
-test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
+if test $HOST_UID -eq 0
+then
+	# Just in case someone does want to run the test suite as root.
+	CI_USER=root
+else
+	CI_USER=ci
+	useradd -u $HOST_UID $CI_USER
+	# Due to a bug the test suite was run as root in the past, so
+	# a prove state file created back then is only accessible by
+	# root.  Now that bug is fixed, the test suite is run as a
+	# regular user, but the prove state file coming from Travis
+	# CI's cache might still be owned by root.
+	# Make sure that this user has rights to any cached files,
+	# including an existing prove state file.
+	test -n "$cache_dir" && chown -R $HOST_UID:$HOST_UID "$cache_dir"
+fi
 
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 15288ea2c..21637903c 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -9,7 +9,7 @@ docker pull daald/ubuntu32:xenial
 
 # Use the following command to debug the docker build locally:
 # $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
-# root@container:/# /usr/src/git/ci/run-linux32-build.sh
+# root@container:/# /usr/src/git/ci/run-linux32-build.sh <host-user-id>
 
 container_cache_dir=/tmp/travis-cache
 
-- 
2.16.1.158.ge6451079d

