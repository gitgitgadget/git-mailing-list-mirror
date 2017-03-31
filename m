Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5231FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933137AbdCaOLe (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:11:34 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47853 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933111AbdCaOLd (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:33 -0400
X-AuditID: 12074411-4d7ff700000005a9-b1-58de63929d3f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C4.C9.01449.2936ED85; Fri, 31 Mar 2017 10:11:30 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBf010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:28 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/20] Separate `ref_cache` into a separate module
Date:   Fri, 31 Mar 2017 16:10:58 +0200
Message-Id: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1J2cfC/C4PBNNou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGigkX2AqOilbcOLiPuYFxvWAXIyeHhICJ
        xOO7n9m6GLk4hAR2MEkcavrJCOGcZJKYuuoTE0gVm4CuxKKeZjBbREBNYmLbIRaQImaBN0wS
        B7b8YgFJCAu4SpyfP5UVxGYRUJVY8PkNM4jNK2AusfDQLlaIdfISu9ouskLEBSVOznwC1MsB
        NEhdYv08IZAwM1BJ89bZzBMYeWchqZqFUDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmp
        RbqmermZJXqpKaWbGCGBLLiDccZJuUOMAhyMSjy8J7zvRQixJpYVV+YeYpTkYFIS5fUNBwrx
        JeWnVGYkFmfEF5XmpBYfYpTgYFYS4WWKA8rxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGan
        phakFsFkZTg4lCR4K5KAGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGLwCp4S0uSMwtzkyHyJ9i1OX4
        1XPsDZMQS15+XqqUOC8rSJEASFFGaR7cHFgCesUoDvSWMC8fSBUPMHnBTXoFtIQJaInF17sg
        S0oSEVJSDYxznv2YpRT56ZmNZfCh9zFHW1aHfZDpyavwOF+beLzpnpuraOW7x6csG8VDJB8H
        rZ75iVs4/0yh9Xp3jVWicyrP7+D0kyjrUE5tWcYhJHWidZujHcea65fqj8nPf3T8EddRXqeu
        SdzpGtd2H78/oSbx1O0pdvOnzLm8haHzVnqtIdvtyTm51W+VWIozEg21mIuKEwEbRHcxGwMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of this patch series. Thanks to Peff, Junio, Stefan and
Ævar for their comments about v1 [1].

This version literally only contains a few commit message changes and
one minor comment changes relative to v1. The code is identical. I
wasn't sure whether it is even worth sending this patch series to the
ML again; Junio, if you'd prefer I just send a link to a published
branch in such cases, please let me know.

* I picked up the "area:" prefixes that Junio added to a couple of
  commit subject lines.

* I clarified the justification for keeping a pointer to the
  `ref_store` in `ref_dir`.

* I added a long blurb about the removal of an internal consistency
  check in the commit message for

      [18/20] commit_packed_refs(): use reference iteration

* I changed "loose refs cache" to "loose ref cache" in a comment in

      [19/20] files_pack_refs(): use reference iteration

This patch series is also available from my GitHub fork [2] as branch
"separate-ref-cache". These patches depend on Duy's
nd/files-backend-git-dir branch.

[1] http://public-inbox.org/git/cover.1490026594.git.mhagger@alum.mit.edu/
[2] https://github.com/mhagger/git

Michael Haggerty (20):
  get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
  refs_read_raw_ref(): new function
  refs_ref_iterator_begin(): new function
  refs_verify_refname_available(): implement once for all backends
  refs_verify_refname_available(): use function in more places
  ref-cache: rename `add_ref()` to `add_ref_entry()`
  ref-cache: rename `find_ref()` to `find_ref_entry()`
  ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
  refs: split `ref_cache` code into separate files
  ref-cache: introduce a new type, ref_cache
  refs: record the ref_store in ref_cache, not ref_dir
  ref-cache: use a callback function to fill the cache
  refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
  do_for_each_entry_in_dir(): eliminate `offset` argument
  get_loose_ref_dir(): function renamed from get_loose_refs()
  get_loose_ref_cache(): new function
  cache_ref_iterator_begin(): make function smarter
  commit_packed_refs(): use reference iteration
  files_pack_refs(): use reference iteration
  do_for_each_entry_in_dir(): delete function

 Makefile             |    1 +
 refs.c               |  111 ++++-
 refs.h               |    2 +-
 refs/files-backend.c | 1229 +++++++-------------------------------------------
 refs/ref-cache.c     |  523 +++++++++++++++++++++
 refs/ref-cache.h     |  267 +++++++++++
 refs/refs-internal.h |   22 +-
 7 files changed, 1066 insertions(+), 1089 deletions(-)
 create mode 100644 refs/ref-cache.c
 create mode 100644 refs/ref-cache.h

-- 
2.11.0

