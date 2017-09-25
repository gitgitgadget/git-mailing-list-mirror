Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09EA420A29
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbdIYIA3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:29 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49292 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933809AbdIYIA2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:28 -0400
X-AuditID: 1207440f-a43ff70000007960-4c-59c8b79ad7b6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 88.29.31072.A97B8C95; Mon, 25 Sep 2017 04:00:26 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6K027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:24 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/21] Read `packed-refs` using mmap()
Date:   Mon, 25 Sep 2017 09:59:57 +0200
Message-Id: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1J29/USkwalOOYu1z+4wWTxff4Ld
        outKN5NFQ+8VZov+5V1sFrdXzGe26J7yltHiR0sPs8Xmze0sDpwef99/YPLYOesuu8eHj3Ee
        CzaVejzr3cPocfGSssfnTXIB7FFcNimpOZllqUX6dglcGVvWqBccEa1Y+u4MWwPjGsEuRg4O
        CQETiT+neboYuTiEBHYwSfRdOsMI4Zxikri7YiVrFyMnB5uArsSinmYmEFtEQE1iYtshFpAi
        ZoGVzBKTtl4BKxIWsJR4smg7C4jNIqAqsfT3PrA4r4C5RMebO2BxCQF5iXMPbjNDxAUlTs58
        wgJyBbOAusT6eUIgYWagkuats5knMPLOQlI1C6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuT
        E/PyUot0TfRyM0v0UlNKNzFCgpl/B2PXeplDjAIcjEo8vBH/jkcKsSaWFVfmHmKU5GBSEuW9
        y3ciUogvKT+lMiOxOCO+qDQntfgQowQHs5II77HVQDnelMTKqtSifJiUNAeLkjiv+hJ1PyGB
        9MSS1OzU1ILUIpisDAeHkgSv6zagRsGi1PTUirTMnBKENBMHJ8hwHqDhy0FqeIsLEnOLM9Mh
        8qcYdTk6bt79wyTEkpeflyolzrsBpEgApCijNA9uDiwJvWIUB3pLmDcNpIoHmMDgJr0CWsIE
        tKR3KtiSkkSElFQDo8bB8590lks3Bf+S0k/YvDUsWWuridZ0F7nF8tVpnhXvdvQEvFvz0blr
        l0ylGW+J4P9bDXPfd4o/4lOZqu8Ts0HNcjcPT99H4aDVj21F/s1IM2o/mbl3xpOHqm8tX682
        3XrC+cX01YZPOPYxOV96F7N8z9R94Z6HWNeKLmcQSZDnFjf0aKnvVGIpzkg01GIuKk4EAIpN
        HeQdAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v3 of a patch series that changes the reading and caching of
the `packed-refs` file to use `mmap()`. Thanks to Stefan, Peff, Dscho,
and Junio for their comments about v2. I think I have addressed all of
the feedback from v1 [1] and v2 [2].

This version has only minor changes relative to v2:

* Fixed a trivial error in the commit message for patch 08.

* In patch 13:

  * In the commit message, explain the appearance of `MMAP_TEMPORARY`
    even though it is not yet treated differently than `MMAP_NONE`.

  * In `Makefile`, don't make `USE_WIN32_MMAP` imply
    `MMAP_PREVENTS_DELETE`.

  * Correct the type of a local variable from `size_t` to `ssize_t`.

This patch series is also available from my GitHub repo [3] as branch
`mmap-packed-refs`.

[1] http://public-inbox.org/git/cover.1505319366.git.mhagger@alum.mit.edu/
[2] https://public-inbox.org/git/cover.1505799700.git.mhagger@alum.mit.edu/
[3] https://github.com/mhagger/git/

Jeff King (1):
  prefix_ref_iterator: break when we leave the prefix

Michael Haggerty (20):
  ref_iterator: keep track of whether the iterator output is ordered
  packed_ref_cache: add a backlink to the associated `packed_ref_store`
  die_unterminated_line(), die_invalid_line(): new functions
  read_packed_refs(): use mmap to read the `packed-refs` file
  read_packed_refs(): only check for a header at the top of the file
  read_packed_refs(): make parsing of the header line more robust
  read_packed_refs(): read references with minimal copying
  packed_ref_cache: remember the file-wide peeling state
  mmapped_ref_iterator: add iterator over a packed-refs file
  mmapped_ref_iterator_advance(): no peeled value for broken refs
  packed-backend.c: reorder some definitions
  packed_ref_cache: keep the `packed-refs` file mmapped if possible
  read_packed_refs(): ensure that references are ordered when read
  packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
  packed_read_raw_ref(): read the reference from the mmapped buffer
  ref_store: implement `refs_peel_ref()` generically
  packed_ref_store: get rid of the `ref_cache` entirely
  ref_cache: remove support for storing peeled values
  mmapped_ref_iterator: inline into `packed_ref_iterator`
  packed-backend.c: rename a bunch of things and update comments

 Makefile              |   6 +
 config.mak.uname      |   3 +
 refs.c                |  22 +-
 refs/files-backend.c  |  54 +--
 refs/iterator.c       |  47 ++-
 refs/packed-backend.c | 979 ++++++++++++++++++++++++++++++++++++++------------
 refs/ref-cache.c      |  44 +--
 refs/ref-cache.h      |  35 +-
 refs/refs-internal.h  |  26 +-
 9 files changed, 847 insertions(+), 369 deletions(-)

-- 
2.14.1

