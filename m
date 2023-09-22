Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2E4E6FE35
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjIVOOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIVOOC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:14:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598CA192
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40535597f01so19736175e9.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695392033; x=1695996833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUHSYOoPFSbyUaRKuPQLgWy1sY+NGtGDYD0BxHLPJvg=;
        b=Gs02DEw0SVS0/g+e/1VLzyV9F9lWkIU36tgeYnogCPdPCa+J5kMax/qw9uTv/nftOz
         EBVX+t/gNWQFYCor0rLzHOaaKbAYJeHoVaRBLuwPJ0mu8bOOfmh/wqpUiKCoB88Fi8PN
         EEX7KvpWlAO9mwJ8LXJNA+n/8lzBxoYudeq0n4yyNDh+Z+jPrZ4HkEydbXRGe5kDq5Ee
         aXWACMuZR6gU42srhlea5WQsXQ6EJGzKT4Wzk2ddoHOG/kWsLTMRtvhJPE30vL2T0s1I
         y1OIoDivWqtCFWQRq78QSMpavVL04bB4chSSmBiRK74rvUxcJVRQ1Cflezaqj5gBI/4g
         rPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695392033; x=1695996833;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUHSYOoPFSbyUaRKuPQLgWy1sY+NGtGDYD0BxHLPJvg=;
        b=IoiroeHBuUYsszvwUxL18I0N5gN5jvmPIsHJAVwE8ZQK2Ve/0g07tSo30SW07Qy3K3
         UoVPlh+JTSG+EmV3dv4NCro5BZJBoJ9drPD28+4ujPC3XRM/jlebom6/3Rhiy4vasmQK
         LPrunZ6K2G24bz4MGhjhHAlSGwsdBTO5ecZ2WeflcdL81e81Subhi/97oEi6CL69a1uN
         kyjTR+pe8bFgqglLTnSZzuaWT1wrhWBXYpqgEBShI0T394c3iqnP//ilzvCr9bI/UelD
         qnCCB7FoRs41x9XbHletJMtnLo9iAFJnt5VWeciu/1EEN4hUNAt589we6MdD4sqilS+3
         Xd4w==
X-Gm-Message-State: AOJu0YwZNlT/KCJNfGKbagJeeD/dW3JDX+SD8gd+jRIUWNNxzyjL53U6
        KX/bzW7p0IGT+z8ozsEX4+lYiIU3oUk=
X-Google-Smtp-Source: AGHT+IEgowwoMvw5u+stKPaDF0L7mMpPFnLs9nGHQ75+mRXR8dLoOgjsG14JjJmRmjEc3H2iDmswlA==
X-Received: by 2002:a1c:6a04:0:b0:405:1baf:cedd with SMTP id f4-20020a1c6a04000000b004051bafceddmr7355797wmc.1.1695392033233;
        Fri, 22 Sep 2023 07:13:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15-20020adfde0f000000b0031c6cc74882sm4580744wrm.107.2023.09.22.07.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:13:53 -0700 (PDT)
Message-ID: <db71330d1ca20aa55dab66328b89cc7676e481c5.1695392028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 14:13:47 +0000
Subject: [PATCH 4/4] doc: refer to internet archive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 compat/nedmalloc/malloc.c.h | 2 +-
 gitweb/gitweb.perl          | 4 ++--
 sha1dc/sha1.c               | 2 +-
 t/lib-gpg.sh                | 2 +-
 t/t9816-git-p4-locked.sh    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 4b711c6b9ca..d8c5cd552e2 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1359,7 +1359,7 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
   /* --[ start GCC compatibility ]----------------------------------------------
    * Compatibility <intrin_x86.h> header for GCC -- GCC equivalents of intrinsic
    * Microsoft Visual C++ functions. Originally developed for the ReactOS
-   * (<https://reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
+   * (<https://reactos.org/>) and TinyKrnl (<https://web.archive.org/web/20060409205924/http://www.tinykrnl.org/>)
    * projects.
    *
    * Copyright (c) 2006 KJK::Hyperion <hackbunny@reactos.com>
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b6659410ef1..f12bed87db9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8192,8 +8192,8 @@ sub git_feed {
 	my $format = shift || 'atom';
 	my $have_blame = gitweb_check_feature('blame');
 
-	# Atom: http://www.atomenabled.org/developers/syndication/
-	# RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
+	# Atom: https://web.archive.org/web/20230815171113/https://www.atomenabled.org/developers/syndication/
+	# RSS:  https://web.archive.org/web/20030729001534/http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
 	if ($format ne 'rss' && $format ne 'atom') {
 		die_error(400, "Unknown web feed format");
 	}
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index dede2cbddf9..f993ef9c690 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -88,7 +88,7 @@
 /*
  * Should define Big Endian for a whitelist of known processors. See
  * https://sourceforge.net/p/predef/wiki/Endianness/ and
- * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
+ * https://web.archive.org/web/20140421151132/http://www.perforce.com/perforce/doc.current/manuals/p4sag/chapter.superuser.html
  */
 #define SHA1DC_BIGENDIAN
 
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 83b83c9abb5..add11e88fc0 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -13,7 +13,7 @@ test_lazy_prereq GPG '
 	gpg_version=$(gpg --version 2>&1)
 	test $? != 127 || exit 1
 
-	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
+	# As said here: https://web.archive.org/web/20130212022238/https://www.gnupg.org/faq/gnupg-faq.html#why-does-gnupg-1.0.6-bail-out-on-keyrings-used-with-1.0.7
 	# the gpg version 1.0.6 did not parse trust packets correctly, so for
 	# that version, creation of signed tags using the generated key fails.
 	case "$gpg_version" in
diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index 932841003cf..5e904ac80d8 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -9,7 +9,7 @@ test_expect_success 'start p4d' '
 '
 
 # See
-# http://www.perforce.com/perforce/doc.current/manuals/p4sag/03_superuser.html#1088563
+# https://web.archive.org/web/20150602090517/http://www.perforce.com/perforce/doc.current/manuals/p4sag/chapter.superuser.html#superuser.basic.typemap_locking
 # for suggestions on how to configure "sitewide pessimistic locking"
 # where only one person can have a file open for edit at a time.
 test_expect_success 'init depot' '
-- 
gitgitgadget
