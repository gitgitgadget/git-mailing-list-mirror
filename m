Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801032022D
	for <e@80x24.org>; Mon, 21 Nov 2016 14:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbcKUOSR (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 09:18:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:57537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753852AbcKUOSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 09:18:14 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlUZz-1ciRUD1CMB-00bHDp; Mon, 21
 Nov 2016 15:18:02 +0100
Date:   Mon, 21 Nov 2016 15:18:01 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: [PATCH 0/3] Fix problems with rebase -i when core.commentchar is
 defined
Message-ID: <cover.1479737858.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zZY3LBBQjHf88Qo3R6BGc3I3P2uSuJmz/wcXYsibwtwZuxps5+J
 s0K0VkIYt8fsPwqgXKf4y4PVN2++LXIPBCXn6wgqgOwJa8L28hrbfiYLrMn4d/bMgjn6Cnb
 ieKsV6M2xpoLhygKDn2ZFJ1cJnKlagFXSna87PfOFXp2xQXvEAelDZ3jwLK/nRntVcFhjr0
 mYIxMjmTd2Eej+BhGtpQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ptRJH+3NwIg=:w1aft4rYkser/jh1+m7IaC
 EPSjynFPc6uU+Op4bvOoaLHg6G3SIxCr4AaY67wtjLgZLBHNAstE0xqW2rxep3icokFUNnF6i
 G6qHjqL7f/5vTcE2a8bpBzgvuu5RYCoi1UE96I1Y9Sh80NfrwGHWmbdC/9giy6Sxf4CFk5553
 uPKEefktgDtP4r18jKjOr6BVkFyVvfYb6wS21TpmMTxUUpKEoZBv3O6Ca8TzYEq8L3R9nf2OX
 R/mqwn2cNecgeDJgapBw9HyygyT0+Gzl1yQE9p5Tu0M6R7pouOojlcIfFQL7JUOG5P3K+i+HQ
 2toUxac75VDWalwhHYwSdfyWFp6fMvLOQ8uXLoKIkd8w2y20uk/8b3pkAIkS72fJUIIYqIX3f
 /wwqcL8dHn7i3Yx0H3U44DyxdxhqVcfRt8OWRkIBZ9WQmX2HcU1tAx+W8bM80AdHQdd8x7qNy
 jqgA71Yl5GvkzSNT43paD1wigMNbKDfhJ3aSzGKzn+jp0kbEvBUH0aZjGPWDxiLhyusuoZ4Om
 HBXB1grLxeK9oZvZHuC7ZNpMsd48l3LEn8ih4gry8H+RiwUqv/NJAxgQQNLxrnJwim1TVdDk9
 jPPMIy+NW3Ex7lRsl0DHv1kH+8nEAhIbib4Xv69SKUpRquiULfJF9Z7HXLJOUhPc/18+9q6v1
 8G+1To+q+QnqhIrAdw0Cwz8/GmtkbpLi2uomoX1s4KHYgl7VLULSLSev2awIO3fvw+zrkYU+c
 0S2G0ZoveNT+63OnVieQXcfGLzCjV9JAgrfCGT3CiOqIWYG72RBAtifnev6UZQB0uiO9zXbXV
 vzsGgB+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git for Windows project recently got a bug report that detailed how
`git rebase -i` fails when core.commentchar=auto:

	https://groups.google.com/forum/#!topic/git-for-windows/eOZKjkgyX1Q

This patch series fixes rebase -i's handling of core.commentchar.


Johannes Schindelin (3):
  rebase -i: identify problems with core.commentchar
  stripspace: respect repository config
  rebase -i: handle core.commentChar=auto

 builtin/stripspace.c          |  4 +++-
 git-rebase--interactive.sh    | 13 +++++++++++--
 t/t0030-stripspace.sh         |  7 +++++++
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)


base-commit: 1310affe024fba407bff55dbe65cd6d670c8a32d
Published-As: https://github.com/dscho/git/releases/tag/rebase-i-commentchar-v1
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-commentchar-v1

-- 
2.10.1.583.g721a9e0

