Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FFD20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754622AbdFWHCD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:03 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47121 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754571AbdFWHCB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:01 -0400
X-AuditID: 1207440c-c4dff70000001e54-09-594cbce38cd9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.6D.07764.3ECBC495; Fri, 23 Jun 2017 03:01:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5j001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:01:52 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/29] Create a reference backend for packed refs
Date:   Fri, 23 Jun 2017 09:01:18 +0200
Message-Id: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqPt4j0+kwfQ+FYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJ6nl9lLLghXdH3/jFzA+NTsS5G
        Tg4JAROJj3P3M3UxcnEICexgkmg//4YVwjnFJNE2dS8rSBWbgK7Eop5mJhBbREBNYmLbIRaQ
        ImaBScwSb68tBEsIC7hI7P72iAXEZhFQlWj5c4AdxOYVMJeY8PcgM8Q6eYldbRdZJzByLWBk
        WMUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokREkY8Oxi/rZM5xCjAwajEw5tw
        1jtSiDWxrLgy9xCjJAeTkiivZqRPpBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXp1VQDnelMTK
        qtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvy26gRsGi1PTUirTMnBKENBMH
        J8hwHqDhHptBhhcXJOYWZ6ZD5E8xKkqJ824AaRYASWSU5sH1wuL8FaM40CvCvIkgVTzAFAHX
        /QpoMBPQ4BlrwAaXJCKkpBoY6xcpbvDd/6efd/vmwwVprVm2VlYdk5Jkvr5zjHeuLnTMnybl
        Zr1TaEfeqXbWs93l2jtUn7esu6kjFsVwe/Oi7vK6fTNnGgYELJx+5Py87fome1i/RO4OmLci
        yffPhhsRxQ7ruaL2iHnN2ZN8eYaPPYOaaeI6phSBJsdPGwR3fw3I33TKqWKjEktxRqKhFnNR
        cSIAI6wEGs4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of a patch series creating a `packed_ref_store`
reference backend. Thanks to Stefan, Junio, and Peff for their
comments about v1 [1].

Changes since v1:

* Picked up some whitespace fixes that Junio applied when importing v1.

* A new patch 01 adds a test (written by Junio) that a broken packed
  ref doesn't cause a problem if it is overwritten by a corresponding
  loose ref. This test was broken by v1 of this patch series but it
  passes throughout v2.

* Change patch 17 "packed_ref_store: support iteration" to always
  iterate over the packed refs using `DO_FOR_EACH_INCLUDE_BROKEN`.
  This switches off the check in the packed-ref iterator of whether a
  reference is broken. This is now checked only in
  `files_ref_iterator_advance()`, after the packed and loose
  references have been merged together. It also saves some work.

* Rebased the patch series onto mh/packed-ref-store-prep, which is
  where Junio applied v1 of this patch series.

This patch series can also be obtained from my GitHub fork [2] as
branch packed-ref-store.

[1] http://public-inbox.org/git/cover.1497534157.git.mhagger@alum.mit.edu/
[2] https://github.com/mhagger/git

Junio C Hamano (1):
  t1408: add a test of stale packed refs covered by loose refs

Michael Haggerty (28):
  add_packed_ref(): teach function to overwrite existing refs
  packed_ref_store: new struct
  packed_ref_store: move `packed_refs_path` here
  packed_ref_store: move `packed_refs_lock` member here
  clear_packed_ref_cache(): take a `packed_ref_store *` parameter
  validate_packed_ref_cache(): take a `packed_ref_store *` parameter
  get_packed_ref_cache(): take a `packed_ref_store *` parameter
  get_packed_refs(): take a `packed_ref_store *` parameter
  add_packed_ref(): take a `packed_ref_store *` parameter
  lock_packed_refs(): take a `packed_ref_store *` parameter
  commit_packed_refs(): take a `packed_ref_store *` parameter
  rollback_packed_refs(): take a `packed_ref_store *` parameter
  get_packed_ref(): take a `packed_ref_store *` parameter
  repack_without_refs(): take a `packed_ref_store *` parameter
  packed_peel_ref(): new function, extracted from `files_peel_ref()`
  packed_ref_store: support iteration
  packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
  packed-backend: new module for handling packed references
  packed_ref_store: make class into a subclass of `ref_store`
  commit_packed_refs(): report errors rather than dying
  commit_packed_refs(): use a staging file separate from the lockfile
  packed_refs_lock(): function renamed from lock_packed_refs()
  packed_refs_lock(): report errors via a `struct strbuf *err`
  packed_refs_unlock(), packed_refs_is_locked(): new functions
  clear_packed_ref_cache(): don't protest if the lock is held
  commit_packed_refs(): remove call to `packed_refs_unlock()`
  repack_without_refs(): don't lock or unlock the packed refs
  read_packed_refs(): die if `packed-refs` contains bogus data

 Makefile               |   1 +
 refs.c                 |  18 +
 refs/files-backend.c   | 631 ++++-------------------------------
 refs/packed-backend.c  | 868 +++++++++++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.h  |  25 ++
 refs/refs-internal.h   |  10 +
 t/t1408-packed-refs.sh |  46 +++
 7 files changed, 1039 insertions(+), 560 deletions(-)
 create mode 100644 refs/packed-backend.c
 create mode 100644 refs/packed-backend.h
 create mode 100755 t/t1408-packed-refs.sh

-- 
2.11.0

