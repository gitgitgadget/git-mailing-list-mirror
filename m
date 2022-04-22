Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC48EC433FE
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446271AbiDVJ4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445903AbiDVJ4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:56:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FD053731
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:53:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m14so10276769wrb.6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=At6w/IA2rFkhrrj02Qps1WpUlVdI50RCda4mxwgq5Ug=;
        b=ngqwjOcd1sHOR2ulm+WLBlrGX2VEHdrPs63EuJKWWET2cErYYn9bd+14TGbZplvREP
         QiyjFVBwKLuyu3MAbRsP29buqWvb2tjLKvGsuGlyrIk/wvsXHr38h4SS7W1eowoMdkyY
         Ko23FTXzbf+Vcu9gBGc/5/clvMnx9Hcj+DlbUj4DrmYpxIojcN1RcO6MctS8iMsgviIV
         oIx6Z58FOV9JXPNiv8uCQ75fRtnteYPRXiXaEka3voVSmGNgZGaQUMT7SA4UmXAwYery
         1cxpQhbSg72ZbEs3WN138XZloCZYEqfie2V46QOw60PwI5UDwGurJ46EIzGTNWOWDKUy
         yBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=At6w/IA2rFkhrrj02Qps1WpUlVdI50RCda4mxwgq5Ug=;
        b=pas37v+zaq9QKOMI4noze3qeLKW20CTH8aP18K60zZ+6Mbye/CThMfGQyQwWAbKMKp
         upE/rjU+bbeAeOI13KUpPX7WZ6CKQVIjF+KkZooCCdFay4yU0R48hJXV8acc6+m43qcT
         WcSVketi7O8Xpgvnk/mYiqgt7yUncgjCi4eOH27PLL03QQ5chzQHJ0upVNmGFVf6j6bX
         yZAq5yCL4LM667tNLS5z8Hy7UbPUuQidIPbOUMmbu5XmKV6IZ45x/DQPNMKT3UObNAHX
         KESFqw+QOpmtmETlzkm96l9VUj23KckEWKxVWC3XnRje5K63s2YhcURFoO7sndhOJgom
         ob8Q==
X-Gm-Message-State: AOAM530MY1OvpzqyzIhXT1KuSx6YEe7lynW5Dcg+Lde16fAoO3CtcuBC
        866lQTFht6TnFFEFg6IQiDb0F5a3ju+z5Q==
X-Google-Smtp-Source: ABdhPJy0LXsW4xPaYnI8XRxKew8k4dr7Nn8zJtj42gOJzIli1ds3v1z39IYw/KhRI0ifcyAzjgNXYw==
X-Received: by 2002:adf:8b90:0:b0:207:87ef:2720 with SMTP id o16-20020adf8b90000000b0020787ef2720mr2973523wra.567.1650621202247;
        Fri, 22 Apr 2022 02:53:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6-20020adfa506000000b0020ac34ec647sm1365561wrb.110.2022.04.22.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:53:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Arenas <carenas@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] core: update our SHA-1 docs, use sha1collisiondetection on OSX too
Date:   Fri, 22 Apr 2022 11:53:11 +0200
Message-Id: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wasn't able to find any on-list references to it being intentional,
but it appears that while we made the sha1collisiondetection variant
of SHA-1 the default in early 2017 we've never updated the OSX builds
to do likewise.

I don't know what various git packages for OSX to, but our vanilla OSX
distribution definitely uses Apple Common Crypto, and won't detect the
https://shattered.io attack.

This series changes that, and while doing so in 2/5 updates our
documentation and Makefile interface for the SHA-1 selection. Our
INSTALL file was still claiming we used OpenSSL's SHA-1 by default.

Then since we'd made sha1collisiondetection the default we hadn't
changed the code's default fallback to be that, it was still
block-sha1. Now our fallback behavior is "error" instead, which makes
it less likely that we'll get some foot-gun like the "OSX not using
sha1collisiondetection" again.

The 4/5 and 5/5 then remove the PPC_SHA1 implementation. I submitted
this before as [1], and the range-diff is to that submission (it
wasn't picked up). I think it makes sense as part of this general
SHA-1 cleanup.

1. https://lore.kernel.org/git/patch-1.1-05dcdca3877-20220319T005952Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  Makefile: create and use sections for "define" flag listing
  Makefile: really use and document sha1collisiondetection by default
  Makefile: rephrase the discussion of *_SHA1 knobs
  Makefile + hash.h: remove PPC_SHA1 implementation
  Makefile: use $(OBJECTS) instead of $(C_OBJ)

 INSTALL                             |  11 +-
 Makefile                            | 301 ++++++++++++++++------------
 configure.ac                        |   3 -
 contrib/buildsystems/CMakeLists.txt |   3 +-
 hash.h                              |  12 +-
 ppc/sha1.c                          |  72 -------
 ppc/sha1.h                          |  25 ---
 ppc/sha1ppc.S                       | 224 ---------------------
 t/t0013-sha1dc.sh                   |   4 +-
 9 files changed, 191 insertions(+), 464 deletions(-)
 delete mode 100644 ppc/sha1.c
 delete mode 100644 ppc/sha1.h
 delete mode 100644 ppc/sha1ppc.S

Range-diff:
-:  ----------- > 1:  f799d30e82e Makefile: create and use sections for "define" flag listing
-:  ----------- > 2:  5ffb68dc77b Makefile: really use and document sha1collisiondetection by default
-:  ----------- > 3:  d559e5212bc Makefile: rephrase the discussion of *_SHA1 knobs
1:  3a8caf62137 ! 4:  4b2d0b7b51a ppc: remove custom SHA-1 implementation
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    ppc: remove custom SHA-1 implementation
    +    Makefile + hash.h: remove PPC_SHA1 implementation
     
         Remove the PPC_SHA1 implementation added in a6ef3518f9a ([PATCH] PPC
         assembly implementation of SHA1, 2005-04-22). When this was added
         Apple consumer hardware used the PPC architecture, and the
         implementation was intended to improve SHA-1 speed there.
     
    -    Since it was added we've moved to DC_SHA1 by default, and anyone
    -    wanting hard-rolled non-DC SHA-1 implementation can use OpenSSL's via
    -    the OPENSSL_SHA1 knob.
    +    Since it was added we've moved to using sha1collisiondetection by
    +    default, and anyone wanting hard-rolled non-DC SHA-1 implementation
    +    can use OpenSSL's via the OPENSSL_SHA1 knob.
     
    -    I'm unsure if this was ever supposed to work on 64-bit PPC. It clearly
    -    originally targeted 32 bit PPC, but there's some mailing list
    -    references to this being tried on G5 (PPC 970). I can't get it to do
    -    anything but segfault on the BE POWER8 machine in the GCC compile
    -    farm. Anyone caring about speed on PPC these days is likely to be
    -    using IBM's POWER, not PPC 970.
    +    Furthermore this doesn't run on the modern PPC processors which anyone
    +    who's concerned about performance on PPC is likely to be using these
    +    days, i.e. the IBM POWER series. It originally originally targeted 32
    +    bit PPC, but there's some mailing list references to this being tried
    +    on G5 (PPC 970).
     
    -    There have been proposals to entirely remove non-DC_SHA1
    +    I can't get it to do anything but segfault on both the BE and LE POWER
    +    machines in the GCC compile farm.
    +
    +    There have been proposals to entirely remove non-sha1collisiondetection
         implementations from the tree[1]. I think per [2] that would be a bit
         overzealous. I.e. there are various set-ups git's speed is going to be
         more important than the relatively implausible SHA-1 collision attack,
         or where such attacks are entirely mitigated by other means (e.g. by
         incoming objects being checked with DC_SHA1).
     
    -    The main reason for doing so at this point is to simplify follow-up
    -    Makefile change. Since PPC_SHA1 included the only in-tree *.S assembly
    -    file we needed to keep around special support for building objects
    -    from it. By getting rid of it we know we'll always build *.o from *.c
    -    files, which makes the build process simpler.
    +    But that really doesn't apply to PPC_SHA1 in particular, which seems
    +    to have outlived its usefulness.
    +
    +    As this gets rid of the only in-tree *.S assembly file we can remove
    +    the small bits of logic from the Makefile needed to build objects
    +    from *.S (as opposed to *.c)
     
    -    As an aside the code being removed here was also throwing warnings
    -    with the "-pedantic" flag, but let's remove it instead of fixing it,
    -    as 544d93bc3b4 (block-sha1: remove use of obsolete x86 assembly,
    -    2022-03-10) did for block-sha1/*.
    +    The code being removed here was also throwing warnings with the
    +    "-pedantic" flag, it could have been fixed as 544d93bc3b4 (block-sha1:
    +    remove use of obsolete x86 assembly, 2022-03-10) did for block-sha1/*,
    +    but as noted above let's remove it instead.
     
         1. https://lore.kernel.org/git/20200223223758.120941-1-mh@glandium.org/
         2. https://lore.kernel.org/git/20200224044732.GK1018190@coredump.intra.peff.net/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## INSTALL ##
    -@@ INSTALL: Issues of note:
    - 
    - 	  By default, git uses OpenSSL for SHA1 but it will use its own
    - 	  library (inspired by Mozilla's) with either NO_OPENSSL or
    --	  BLK_SHA1.  Also included is a version optimized for PowerPC
    --	  (PPC_SHA1).
    -+	  BLK_SHA1.
    - 
    - 	- "libcurl" library is used for fetching and pushing
    - 	  repositories over http:// or https://, as well as by
    -
      ## Makefile ##
     @@ Makefile: include shared.mak
    - # Define BLK_SHA1 environment variable to make use of the bundled
    - # optimized C SHA1 routine.
    + # Define OPENSSL_SHA1 to link to the the SHA-1 routines from
    + # the OpenSSL library.
      #
    --# Define PPC_SHA1 environment variable when running make to make use of
    --# a bundled SHA1 routine optimized for PowerPC.
    +-# Define PPC_SHA1 to make use of optimized (in assembly)
    +-# PowerPC SHA-1 routines.
     -#
    - # Define DC_SHA1 to unconditionally enable the collision-detecting sha1
    - # algorithm. This is slower, but may detect attempted collision attacks.
    - # Takes priority over other *_SHA1 knobs.
    -@@ Makefile: ifdef OPENSSL_SHA1
    - 	EXTLIBS += $(LIB_4_CRYPTO)
    - 	BASIC_CFLAGS += -DSHA1_OPENSSL
    - else
    + # Define APPLE_SHA1 to use Apple's CommonCrypto SHA-1 routines on
    + # Darwin/Mac OS X.
    + #
    +@@ Makefile: endif
    + ifdef DC_SHA1
    + $(error the DC_SHA1 flag is no longer used, and has become the default. Adjust your build scripts accordingly)
    + endif
     +ifdef PPC_SHA1
    -+$(error PPC_SHA1 has been removed! Use DC_SHA1 instead, which is the default)
    ++$(error the PPC_SHA1 flag has been removed along with the PowerPC-specific SHA-1 implementation.)
     +endif
    - ifdef BLK_SHA1
    + ifndef NO_DC_SHA1
    +-	ifneq ($(OPENSSL_SHA1)$(BLK_SHA1)$(PPC_SHA1)$(APPLE_SHA1),)
    ++	ifneq ($(OPENSSL_SHA1)$(BLK_SHA1)$(APPLE_SHA1),)
    + $(error no other *_SHA1 option can be defined unless NO_DC_SHA1 is defined)
    + 	endif
    + 	LIB_OBJS += sha1dc_git.o
    +@@ Makefile: ifdef BLK_SHA1
      	LIB_OBJS += block-sha1/sha1.o
      	BASIC_CFLAGS += -DSHA1_BLK
      else
    @@ Makefile: ifdef OPENSSL_SHA1
     -	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
     -	BASIC_CFLAGS += -DSHA1_PPC
     -else
    - ifdef APPLE_COMMON_CRYPTO
    + ifdef APPLE_SHA1
      	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
      	BASIC_CFLAGS += -DSHA1_APPLE
     @@ Makefile: endif
    @@ configure.ac: AC_MSG_NOTICE([CHECKS for site configuration])
     
      ## hash.h ##
     @@
    - #include "git-compat-util.h"
    - #include "repository.h"
      
    --#if defined(SHA1_PPC)
    + #if !defined(NO_SHA1_DC)
    + #include "sha1dc_git.h"
    +-#elif defined(SHA1_PPC)
     -#include "ppc/sha1.h"
    --#elif defined(SHA1_APPLE)
    -+#if defined(SHA1_APPLE)
    + #elif defined(SHA1_APPLE)
      #include <CommonCrypto/CommonDigest.h>
      #elif defined(SHA1_OPENSSL)
    - #include <openssl/sha.h>
     @@
       * platform's underlying implementation of SHA-1; could be OpenSSL,
       * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
-:  ----------- > 5:  0575faebc30 Makefile: use $(OBJECTS) instead of $(C_OBJ)
-- 
2.36.0.879.g56a83971f3f

