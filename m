Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BFFC4727D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FB3206CD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 14:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U/SV9pxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbgJBOCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:02:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:59201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBOCD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 10:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601647312;
        bh=9+7W3TeGYFnl8WH6sbPBOKI9T1boBZjXTsdHqdw3bJE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U/SV9pxM1ku6Y8ULgXSakVa9gh7G3t0B7c8dcU3wOjhXHWE4uBmWC/NZZbukk2/ra
         U772oWe5BlSSZy4LMowDlDtYQz3xWkR+N3ZAZmCLqOwItg8kZaFLUY6KYlwGDbSI/L
         5LzpNC+3xsVEsCHZgQi1OwJjmTv1KzEUGLHVa6GE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.114]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1k8CSC46Dj-00Kf7C; Fri, 02
 Oct 2020 16:01:52 +0200
Date:   Fri, 2 Oct 2020 16:01:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>, gitster@pobox.com
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Oq1EVcMOEbTC27UkBb1frp/kDFJK2qtkn8bfk86W+FovtACL0XF
 OkOqqUSlaaXr6o20Lgnsezb967NR9xVmnRljiHL/OxLIhBgPwHIc4I2ijydBl1Ba6a1qzFj
 GSWtp7HiSEabsvMbNwdS3MBL0AsAwKVWVktBFKKfRGccT16v8hiq8PYjkdF2q8TvajoSu64
 Sx0fKv/mjSbh/Qc02tCFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XULRhu7AVqY=:dUAVlF2wvIh/UbdSHkIqig
 Z9x23mvETQANA1ztGorytZDi/6F63hZIls6te/2NgJ/J55KC52RDebbV9SqkyNIG2gG33OxsF
 ycsg6T94qI9SzdtY3dqd1UMK/91upEDZ9+dvMny5zuaLUP1lwe9nZkrQFVTHBbslQWZg/CrYd
 zy6OtkOTBYc7HkKWH4HoU+N1K3Np67B2LLx3hwJLOg2PbSFxTMJW+ECLZFtRmk8Ynv1BWLCr5
 7MmWLyEa43kwSZwJPpbMTys1ddtmbNtNtgnf4i1R6doMfYLwBqu4QOrMZMlvd2PQ+QsNpWJEM
 X5NGZkNaMYDU8zWhjYzhtQRKxBZcJ11Qbslm8XE4lR4QblzzoeMxxNlTshf2uwAkmkM55V9RE
 l8WrJoWVObxmn9fUCKkRxFeGiNsY6Uz57lSLoUxP8JmKY1zxbrSKnJMOELERjCsiOPL+ROrbd
 /9nm/2uiwuWTOArWSQ7cIP3n6lO5nmj5bo5U98T05epzlWYn2S3QgClvC4VqLB2UsfZkA7Inf
 8ge+G+WXElRkyu0QuLVw8V8A3DYn3MNKkVo6aYdWp6Oc4TmpSfBVaewbt0ucA7j+PzilBuqgu
 +50Cs/YUXwv1vYWj9Gac9WPMP9CdLwIr8NLWk+fDRvW9WiOOyi+QkqxBes3gcrfPi0LNQE/57
 dHYgjdMM/+gNFqZXoqHPGxD1lkGQobl0tN+BYs+chgFSClVm5rEj71ML1ehvGm3yKKB4YY5Li
 Wy/cP2AYWWjIEz24dvruEuoUt3wqqDjFBWx/ngeMrWRwVE1wqjOxDvSWiCiDs+mAa4RFgTamF
 2MaN8jflUbY9GA5+SeoB2mXv9v06MR7Mf3ByDCW3xeUmXSXalhiaU3u4xptCNJf9mr6Ifh9/3
 KH/U5IjcPLJw95+GPaeTgmrxOIxmykJJO8Ur/NU35DNdrjuZuy1z8sn+hy+cVPKPwS4upt+L0
 rIxRWp2DhKBseaFO5xpto4C3PkN5Qy8pPBLomPaAtA7rq9uWMii+xVPRotHlvCTr6XFQjVJHl
 gjFMS9dngyhPbTc2OActC6st+SB2yyBra7WhRl0+8njChYdMim7UPRfPcfwP4+IHNCfe+QeQH
 xslcDUWpceTHF46BajvzhbGxcCW7Bptf5bg7c/Tpl6cgRuLWTmldsaHHgBipg9UTyOmJ/MiZs
 Iq2bq9/AIf4P84XvjjxjTdxbeF0wiYsFQ2vJokZvjN0BuuFaCH4EHfwh1jmMC52gJvGJDRPfL
 5HQgyQYzvt+i3VTAXupAqDjxfC+fCboxAFEZaXg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Thu, 1 Oct 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This commit provides basic utility classes for the reftable library.
>
> Since the reftable library must compile standalone, there may be some ov=
erlap
> with git-core utility functions.

My position on this idea to duplicate functionality in order to somehow
pretend that the reftable code is independent of Git's source code has not
changed.

Be that as it may, the CI build failures impacted my notifications'
signal/noise ratio too much, so here goes (Junio, I would be delighted if
you could apply this on top of your branch):

=2D- snipsnap --
=46rom 1698c3450b5e47927c2e8fe35cad2634963bad89 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 30 Sep 2020 16:53:53 +0200
Subject: [PATCH] fixup??? reftable: utility functions

Let's not forget our CMake configuration.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CM=
akeLists.txt
index 1bd53c4ad51..284bf4402d7 100644
=2D-- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -591,6 +591,12 @@ parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OB=
JS")
 list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(xdiff STATIC ${libxdiff_SOURCES})

+#reftable
+parse_makefile_for_sources(reftable_SOURCES "REFTABLE_OBJS")
+
+list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+add_library(reftable STATIC ${reftable_SOURCES})
+
 if(WIN32)
 	if(NOT MSVC)#use windres when compiling with gcc and clang
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
@@ -613,7 +619,7 @@ endif()
 #link all required libraries to common-main
 add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)

-target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
+target_link_libraries(common-main libgit xdiff reftable ${ZLIB_LIBRARIES}=
)
 if(Intl_FOUND)
 	target_link_libraries(common-main ${Intl_LIBRARIES})
 endif()
@@ -848,11 +854,15 @@ if(BUILD_TESTING)
 add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c=
)
 target_link_libraries(test-fake-ssh common-main)

+#reftable-tests
+parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
+list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+
 #test-tool
 parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")

 list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
-add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-=
tool_SOURCES})
+add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-=
tool_SOURCES} ${test-reftable_SOURCES})
 target_link_libraries(test-tool common-main)

 set_target_properties(test-fake-ssh test-tool
=2D-
2.28.0.windows.1.18.g5300e52e185

