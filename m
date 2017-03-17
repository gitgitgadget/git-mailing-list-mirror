Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A84B20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdCQRmM (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:42:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62781 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751307AbdCQRl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:41:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 370EA756DF;
        Fri, 17 Mar 2017 13:41:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iXu2ZMVPlDmSD01NlBhoPL3qM8s=; b=yPOFiu
        RN+qxqq+w3r+WOOV9gM5kRElJX96LYzvzYv4EZQSwDlenVWFKLYlGt4M/0g1wYVS
        W6SUj1o4MA12v+nL68xi9DTv+b/vwNJkQJLmOraaIt0rdshBmQmIiArRC1r5ZeE7
        LC1jO8bm35r3RaW130FtIxP+WT9w3KYZYQxtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o6gW11rRXf5LMYKq3NDA37MGZIAgQQa5
        hsV5fV04Qmm4c24q41Ccsc4Zv4cLrutGHLZ17KOcmZU+90pxEmNi+AJ5oactYy4J
        yeId76/rRF6y1ojBnoqPf48tWOifErwgO4GX7ZOmLB5eHeFTSrNfuGVUKhoJSpKI
        MOpEpWdp3Mk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30DFD756DE;
        Fri, 17 Mar 2017 13:41:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98DB1756DD;
        Fri, 17 Mar 2017 13:41:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] Git integration update for DC-SHA1
References: <20170317111814.tkzeqfyr3aiyxsxr@sigill.intra.peff.net>
        <20170317170938.20593-1-gitster@pobox.com>
Date:   Fri, 17 Mar 2017 10:41:54 -0700
In-Reply-To: <20170317170938.20593-1-gitster@pobox.com> (Junio C. Hamano's
        message of "Fri, 17 Mar 2017 10:09:35 -0700")
Message-ID: <xmqq4lyr94wt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03695B74-0B39-11E7-9BD4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Here are three patches to replace the last two patches from your
> series.
>
>  - The Makefile knob is named DC_SHA1, not USE_SHA1DC; this is to
>    keep it consistent with existing BLK_SHA1 and PPC_SHA1.
>
>  - The CPP macro is called SHA1_DC, not SHA1_SHA1DC; again this is
>    for consistency with SHA1_BLK and SHA1_PPC.
>
>  - Switch the default from OpenSSL's implementation to DC_SHA1.
>    Those who want OpenSSL's one can ask with OPENSSL_SHA1.
>
> Jeff King (2):
>   Makefile: add DC_SHA1 knob
>   t0013: add a basic sha1 collision detection test
>
> Junio C Hamano (1):
>   Makefile: make DC_SHA1 the default
>
>  Makefile                |  19 +++++++++++++++++--
>  hash.h                  |   2 ++
>  sha1dc/sha1.c           |  20 ++++++++++++++++++++
>  sha1dc/sha1.h           |  15 +++++++++++++++
>  t/t0013-sha1dc.sh       |  19 +++++++++++++++++++
>  t/t0013/shattered-1.pdf | Bin 0 -> 422435 bytes
>  6 files changed, 73 insertions(+), 2 deletions(-)
>  create mode 100755 t/t0013-sha1dc.sh
>  create mode 100644 t/t0013/shattered-1.pdf

For a rather obvious reason, patch 2/3 cannot be seen on the list.
The "interdiff" between jk/sha1dc topic and applying patches 1 and 2
(but not 3) looks like this.

diff --git a/Makefile b/Makefile
index b01111c581..fc9d89498b 100644
--- a/Makefile
+++ b/Makefile
@@ -142,7 +142,7 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
-# Define USE_SHA1DC to unconditionally enable the collision-detecting sha1
+# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
 # algorithm. This is slower, but may detect attempted collision attacks.
 # Takes priority over other *_SHA1 knobs.
 #
@@ -1390,10 +1390,10 @@ ifdef APPLE_COMMON_CRYPTO
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
 
-ifdef USE_SHA1DC
+ifdef DC_SHA1
 	LIB_OBJS += sha1dc/sha1.o
 	LIB_OBJS += sha1dc/ubc_check.o
-	BASIC_CFLAGS += -DSHA1_SHA1DC
+	BASIC_CFLAGS += -DSHA1_DC
 else
 ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
@@ -2236,7 +2236,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
-	@echo USE_SHA1DC=\''$(subst ','\'',$(subst ','\'',$(USE_SHA1DC)))'\' >>$@+
+	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/hash.h b/hash.h
index 3760f436ec..a11fc9233f 100644
--- a/hash.h
+++ b/hash.h
@@ -7,7 +7,7 @@
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
-#elif defined(SHA1_SHA1DC)
+#elif defined(SHA1_DC)
 #include "sha1dc/sha1.h"
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 4d43f7bf64..6d655cb161 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -4,9 +4,9 @@ test_description='test sha1 collision detection'
 . ./test-lib.sh
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
-if test -z "$USE_SHA1DC"
+if test -z "$DC_SHA1"
 then
-	skip_all='skipping sha1 collision tests, USE_SHA1DC not set'
+	skip_all='skipping sha1 collision tests, DC_SHA1 not set'
 	test_done
 fi
 



