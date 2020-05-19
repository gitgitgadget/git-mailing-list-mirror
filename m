Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C83C433E1
	for <git@archiver.kernel.org>; Tue, 19 May 2020 01:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B6620715
	for <git@archiver.kernel.org>; Tue, 19 May 2020 01:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=iskunk.org header.i=@iskunk.org header.b="3PiLiT1T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sGedVKNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgESBQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 21:16:46 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37117 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbgESBQq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 May 2020 21:16:46 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 54247AE1
        for <git@vger.kernel.org>; Mon, 18 May 2020 21:16:45 -0400 (EDT)
Received: from imap36 ([10.202.2.86])
  by compute7.internal (MEProxy); Mon, 18 May 2020 21:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iskunk.org; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm3; bh=4LOx78+vlcQ8aevcN8zjOL/HTw
        r5bSP2czhG4yp22E0=; b=3PiLiT1TfxVji4widxjAg7COj5tjDxs/JTOhoE46vk
        Ghp7Vcaih9hvM4Tkyk9kAyDR4AuW/EtLkevJdn0E+wKe4FZ2iSAf123QtHhdr04Y
        le0etHviGoKiHqvVOYvbK8tqjigDb9yF/1WuudZo21vRHGmGkH9bWM/QfndasC8Z
        Y54KZ062D7NBEagmrIPoa9bVWZ2IXfdme+cp5/DcjSaQEvC34X8tZbfskLIJ/ocX
        OePb7OtYSGVVOwtPRBZOWaGTCG///zTpLKLK8MDUdpGtYwuO3B+/p2wZX7GDvLga
        fB0muo+8Iy8x8xA1hxPMHE3Ydn9xUcbUW6H2Xk1h4mxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4LOx78
        +vlcQ8aevcN8zjOL/HTwr5bSP2czhG4yp22E0=; b=sGedVKNJ1712r/uJDtuUNQ
        /On07tQDizUO29laCwNvRiaDwI50igfpQUVu6b0XYPVPSb47855wo7+uSlpJf1gi
        Yjmy30qCSLavEhXGAE+193/JPYETGq9X7kXqDR0zKJVO0TVuDFdWz63DY8jPvHfT
        tePY+DUfo8/1s7a7p07cUcDifgDBqn803HWg6vJstjB4/rGTbUBOsmVqzEhhnicB
        llQJYFRJPmhoK406Y5Mis5oXeINVnneiyHYzvpnEvM0vaqGUykzEgalTKDgNMc/F
        p9JuHGCKu2oV5+6qRn3pXMT+stC7Psi5r5gVyl5zTsCAlyuiLNYdh1CCBs4y+jTw
        ==
X-ME-Sender: <xms:fDPDXhCRSEvdjD5zvD6l4XiuR7mZTYVHh5nhl9ULUOH5QGszLdgEPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtiedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreertdenucfhrhhomhepfdffrghnihgvlhcutfhitghhrghrugcuifdrfdcuoehskhhu
    nhhksehiuffmfgfpmfdrqfftifeqnecuggftrfgrthhtvghrnhepgeffleduteelveehie
    dtudffudejgeeggeeiffejtdehteekieejhfduieeufedvnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhkuhhnkhesihfumfgfpffmrdfqtf
    fi
X-ME-Proxy: <xmx:fDPDXvg_8CIY8rsxQ9tyAaiGE-S-O4YStoyI2xtLix9O4UsvTWigWQ>
    <xmx:fDPDXslkxLml0qUOjds9gHqSSajzfOZs2ehZeQTu7-2OipEnrCrB6Q>
    <xmx:fDPDXrzrWgcAKZoAhHhHHIZ9wn7bvXX9mRKFjXlqQKZ8Ffqrmz8Xvw>
    <xmx:fDPDXkAWAS51EC9p0FM6nMfVxTGUtKfABosCTQ4ryte4rR-XGPfvyA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 879751880067; Mon, 18 May 2020 21:16:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-464-g810d66a-fmstable-20200518v1
Mime-Version: 1.0
Message-Id: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
Date:   Mon, 18 May 2020 21:15:58 -0400
From:   "Daniel Richard G." <skunk@iSKUNK.ORG>
To:     git@vger.kernel.org
Subject: Minor portability issues + fixes
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello list,

I am building Git 2.26.2 on AIX. A few compilation errors arose, but
they are resolvable with a few minor changes that will improve overall
portability.

There were a few errors of this form:

    sha1-file.c: In function 'mmap_limit_check':
    sha1-file.c:940:12: error: 'SIZE_MAX' undeclared (first use in this =
function)
    sha1-file.c:940:12: note: each undeclared identifier is reported onl=
y once for each function it appears in

SIZE_MAX is defined in stdint.h, and adding that #include fixes this. It=

is likely that this header is being pulled in on other platforms due to
transitive dependencies, but that does not occur on AIX.

The following files need #include<stdint.h>:

    sha1-file.c
    utf8.c
    vcs-svn/svndiff.c
    wrapper.c

(I am not sure of the correct place to add a header like this; I
have only verified that adding it to the .c file directly solves
the problem.)

Then, at link time, I saw this:

    rm -f xdiff/lib.a && ar rcs xdiff/lib.a xdiff/xdiffi.o xdiff/xprepar=
e.o xdiff/xutils.o xdiff/xemit.o xdiff/xmerge.o xdiff/xpatience.o xdiff/=
xhistogram.o
    gcc  -D_ALL_SOURCE -D_THREAD_SAFE   -I. -D_LARGE_FILES -DGIT_HOST_CP=
U=3D"\"00XXXXXXXXXX\"" -I/nfs/freeport/arch/aix32/include -DNO_CURL -I/n=
fs/freeport/arch/aix32/include -DNO_OPENSSL -DNO_D_TYPE_IN_DIRENT -DNO_N=
SEC -Dsockaddr_storage=3Dsockaddr_in6 -DNO_ICONV -DOLD_ICONV -DSHA1_DC -=
DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1D=
C_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHEC=
K_C=3D"\"git-compat-util.h\"" -DSHA256_BLK -DNO_PTHREADS -DHAVE_PATHS_H =
-DHAVE_STRINGS_H -DHAVE_CLOCK_GETTIME  -DSNPRINTF_RETURNS_BOGUS -DFREAD_=
READS_DIRECTORIES -DNO_STRCASESTR -DNO_STRLCPY -DNO_STRTOUMAX -DNO_SETEN=
V -DNO_MKDTEMP -DNO_UNSETENV -DNO_PREAD -DNO_MEMMEM -DINTERNAL_QSORT -Ic=
ompat/regex -DFILENO_IS_A_MACRO -DNEED_ACCESS_ROOT_HANDLER -DDEFAULT_EDI=
TOR=3D'"nano"' -DDEFAULT_PAGER=3D'"more"' -DSHELL_PATH=3D'"/bin/sh"' -DP=
AGER_ENV=3D'"LESS=3DFRX LV=3D-c"' -o git-credential-store   credential-s=
tore.o common-main.o libgit.a xdiff/lib.a  -L/nfs/freeport/arch/aix32/li=
b /nfs/freeport/arch/aix32/lib -L/nfs/freeport/arch/aix32/lib /nfs/freep=
ort/arch/aix32/lib -lz -lintl
    ld: 0711-168 SEVERE ERROR: Input file: /nfs/freeport/arch/aix32/lib
            Input files must be regular files.
    collect2: error: ld returned 12 exit status
    Makefile:2456: recipe for target 'git-credential-store' failed
    gmake: *** [git-credential-store] Error 1

After some investigation, I found that this resulted from the following
configure-time determination:

    configure:4774: WARNING: linker does not support runtime path to dyn=
amic libraries
    (from line 488 of configure.ac)

The problem is, in this case, CC_LD_DYNPATH is set to an empty value---
which is incorrect, in light of how it is used in the Makefile. Here is
a typical example:

    ifdef ZLIB_PATH
            BASIC_CFLAGS +=3D -I$(ZLIB_PATH)/include
            EXTLIBS +=3D -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PA=
TH)/$(lib)
    endif
    EXTLIBS +=3D -lz

Setting that variable to an empty value causes a bare directory to be
passed to the linker, which of course then errors out. I would suggest
setting it to "-L" instead.

(The libraries I am using are all static archives, so I am not hampered
by a lack of runtime library paths.)


--Daniel


--=20
Daniel Richard G. || skunk@iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
