Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78150201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 11:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdB0L1H (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 06:27:07 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33118 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbdB0L1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 06:27:05 -0500
Received: by mail-wr0-f195.google.com with SMTP id g10so9733446wrg.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 03:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VXMzcmS8pvqBGelyjAw4hT2Yhx/uDLEFI27B77DUxac=;
        b=qunz5zW2CwY08UboG6rOyVI5y5q/ZnY3Rto1MNT/hx8K34COYc0Cf4cDg5ZdoDi6Q7
         XhpU9hWc4RvZ8khjL5M9NYSiEwQGrYCnR+IjG8p3PV1MYokN1KOfi0mkWLl7sLJyb9Z9
         sAekBEU1tMfMgnhU4nREKem+SkSjSN0xjjBdErNP7Cr112PdVCkcBJFqi3amD0NGF6pG
         j0HL+EfOqno5ypY0vt7LxGzBVpH3RRTYsbdx9SWLAJqWKX7aTRf+WV7SttuKt3m2Cwnt
         IFZRoLw4+TtYwS9BvoIPwZO+Shxbc5sFsEPtuK5O7okwG7mdgchBgurUmdLijzvXmIZD
         avFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VXMzcmS8pvqBGelyjAw4hT2Yhx/uDLEFI27B77DUxac=;
        b=IjajKTJ0ZzLRgTnsJc3IV4/szVKefCt7WLdjgYXE2ddchVeYyHIVdAtCZi7rieHOMw
         R53egtT8g8GDSAsy3kYse0nh63EELO+nOAWax2hG+vCff+mY7HzM5Nx2nRLwP90wLo3c
         mhizsAEtEbwMhtfAV2izDEm4MBi+W1xaT98gZLxXYA6vtZxifvVNLxOxifp6ePg6LfSp
         fuYrrnPy6mObc0D5GGF6sCYyXMWm+Fl2mWEAwGZHWvFbK2gUp4N++QzjiiIziILlG/i2
         pTFurgtPb7Rz1736efZJ+Xr9Mc1jZPrlQhgiDiEq/cSUay/V+mJp/JATfyb1Zov3lGZj
         lcdw==
X-Gm-Message-State: AMke39ka8/YnvwQLTLRyRVG2QB9IBZOoKE6Ywocm5j9K+7hZ3WrXPLHc/cA+mx3aPu2swQ==
X-Received: by 10.223.134.218 with SMTP id 26mr13772459wry.104.1488194801148;
        Mon, 27 Feb 2017 03:26:41 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g23sm13940567wme.27.2017.02.27.03.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 03:26:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Robin Rosenberg <robin.rosenberg@dewire.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] cvs tests: When root, skip tests that call "cvs commit"
Date:   Mon, 27 Feb 2017 11:26:28 +0000
Message-Id: <20170227112628.10410-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tests that fail to when we run the test suite as root, due
to calling "cvs commit".

The GNU cvs package has an optional compile-time CVS_BADROOT
flag. When compiled with this flag "cvs commit" will refuse to commit
anything as root. On my Debian box this isn't compiled in[1] in, but
on CentOS it is.

I've run all the t/t*cvs*.sh tests, and these are the only two that
fail. For some reason e.g. t9402-git-cvsserver-refs.sh still works as
root despite doing "cvs commit", I haven't dug into why.

This commit is technically being overzealous, we could do better by
making a mock cvs commit as root and run the tests if that works, but
I don't see any compelling reason to bend over backwards to run these
tests in all cases, just skipping them as root seems good enough.

1. Per: strings /usr/bin/cvs|grep 'is not allowed to commit'
   Using cvs 1.11.23 on CentOS, 1.12.13-MirDebian-18 on Debian.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9200-git-cvsexportcommit.sh | 5 +++++
 t/t9600-cvsimport.sh           | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index bb879a527d..1319415ba8 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -18,6 +18,11 @@ then
     test_done
 fi
 
+if ! test_have_prereq NOT_ROOT; then
+	skip_all='When cvs is compiled with CVS_BADROOT commits as root fail'
+	test_done
+fi
+
 CVSROOT=$PWD/tmpcvsroot
 CVSWORK=$PWD/cvswork
 GIT_DIR=$PWD/.git
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 4c384ff023..804ce3850f 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,6 +3,11 @@
 test_description='git cvsimport basic tests'
 . ./lib-cvs.sh
 
+if ! test_have_prereq NOT_ROOT; then
+	skip_all='When cvs is compiled with CVS_BADROOT commits as root fail'
+	test_done
+fi
+
 test_expect_success PERL 'setup cvsroot environment' '
 	CVSROOT=$(pwd)/cvsroot &&
 	export CVSROOT
-- 
2.11.0

