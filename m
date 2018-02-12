Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1026E1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 00:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeBLAUL (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 19:20:11 -0500
Received: from avasout01.plus.net ([84.93.230.227]:45826 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeBLAUK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 19:20:10 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id l1qqeISmeykf2l1qre7504; Mon, 12 Feb 2018 00:20:09 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B8mXLtlM c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=6bRe-lvh3U50NsJiwoIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] config.mak.uname: remove SPARSE_FLAGS setting for cygwin
Message-ID: <bdae2d8f-7c9f-8a2f-810e-e2a93a5ccc3d@ramsayjones.plus.com>
Date:   Mon, 12 Feb 2018 00:20:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEuOcRMTynUDE8pB/FbMzCZJ5fTf9n/ko3U2E5C6ewcHYdq+Gp+aGPuBZddPciEjIvbWm6UV9ccJRDDrQN9UvtmlRutco4iycvAPn60vc+zKJsOp4x/r
 Y3ovoAhUkEMZzZfURXu8anvDJPl+JxD1hwAabj3eFO6+hppGLdVMSYXH+QrZDmXYUxrHUVh8WyC7gA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Since commit f66450ae9 ("cygwin: Remove the Win32 l/stat() implementation",
2013-06-22), the cygwin build has not used the WIN32 API/header files.
This means that the '-isystem /usr/include/w32api' option to sparse is
no longer necessary (to allow sparse to find the WIN32 header files).
In addition, the '-Wno-one-bit-signed-bitfield' option can be removed,
since the warning suppressed by that option was only provoked by a WIN32
header file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 685a80d13..6a1d0de0c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -182,7 +182,6 @@ ifeq ($(uname_O),Cygwin)
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	X = .exe
 	UNRELIABLE_FSTAT = UnfortunatelyYes
-	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
 	COMPAT_OBJS += compat/cygwin.o
-- 
2.16.0
