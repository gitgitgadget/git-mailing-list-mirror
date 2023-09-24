Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF07CE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 10:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjIXK5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjIXK5m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 06:57:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C86109
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:57:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so44712295e9.2
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695553049; x=1696157849; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UGm13++6srE+hqHNZTjBwTl5nkioGEq4k1JJ40cDCs=;
        b=VSFKdbgiktg1rn/HvwyWIyk+EfT54MOsJ8zK0NxLzAX/ysQfeYhuzmPoTko4Z4xHvf
         9o1t5STRgvYwYYUq9GjK8P4I1UsWrfYq7y3pJzp0q1pSMas4DNilQIcifuGZuc18IOFQ
         ifMGu0F1BDcby13ImFliJbjJ18xVWr1oyoWjmFyubdFw2K5Sr2zeqS7lqVFWxjNYdnoK
         ICG6L81XKZVRaOWxKx3WQx6JImRwnFzB0XSXDt1CBtt2arPbaJtGD9TnpaUZtKJ0n8Bq
         FPZOMVxzXnKy+VBr1tsKGbnR7E5Re6ZiNOMttplAc73L+mY2EPYCtwcSWZqS2AaSaqeW
         ga1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553049; x=1696157849;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UGm13++6srE+hqHNZTjBwTl5nkioGEq4k1JJ40cDCs=;
        b=MhV+nvJ15WMuezGhL5ShQvJPWRAjKT36E6SCostuQZ52eJ800/rWtkSeLH3ruSfThn
         xxxmKrdth8EXe/KKYjHrJgLK4EzKcBJbbFLklDP6FioC+Aok2dyG/3DkjyTqSVQ1Hla+
         /3vhFupuQ2CDpykRpNTD2VmnR0Tm17SmFUMeW5jbeifVYwMw1FPefnhRAYk2gFixLohQ
         e2y49QO2KjGCkSQPFktkNe4dN3gCoy0JGSEnlVruWEJEBVtkXYI90Zl73we4nZsK510C
         1vouelE7dMuLxt4J6QW/cpsmZcNdO9sBUq7YEjTA6GPbF3V0x4K/U1E3o8/MHRYVNisl
         BXjw==
X-Gm-Message-State: AOJu0YwpTXBqeJZ04vifrOCq9QiiGfv8r/TipbvzhSeY/jvNKL2jUDYu
        VLZg8WW0ZTyukti8aGFcLY+bs6y0k7A=
X-Google-Smtp-Source: AGHT+IEptNdnIzn7iAzAdJUDubTqgXCbxrZpAkzmfwz7N246sarPl+z1+1goI/7nnDLyypvKE5T+gA==
X-Received: by 2002:a05:600c:254:b0:405:3955:5881 with SMTP id 20-20020a05600c025400b0040539555881mr3517395wmj.36.1695553048907;
        Sun, 24 Sep 2023 03:57:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c204900b0040303a9965asm3670233wmg.40.2023.09.24.03.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 03:57:28 -0700 (PDT)
Message-ID: <9f0bba69492b345fe7b0c7f9529b025ed98c7e29.1695553043.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
        <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Sep 2023 10:57:21 +0000
Subject: [PATCH v2 4/4] doc: refer to internet archive
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

These pages are no longer reachable from their original locations,
which makes things difficult for readers. Instead, switch to linking to
the Internet Archive for the content.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 gitweb/gitweb.perl       | 4 ++--
 sha1dc/sha1.c            | 2 +-
 t/lib-gpg.sh             | 2 +-
 t/t9816-git-p4-locked.sh | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

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
