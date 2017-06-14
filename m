Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7749820401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdFNJHt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:07:49 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50900 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751768AbdFNJHj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Jun 2017 05:07:39 -0400
X-AuditID: 1207440e-20fff70000000c7e-47-5940fcd9bdd5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.A6.03198.9DCF0495; Wed, 14 Jun 2017 05:07:37 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCBFA.dip0.t-ipconnect.de [87.188.203.250])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5E97WEP022456
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 14 Jun 2017 05:07:34 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98yvind=20Holm?= <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Fix a refname trimming problem in `log --bisect`
Date:   Wed, 14 Jun 2017 11:07:25 +0200
Message-Id: <cover.1497430232.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
References: <5a3f6af6-f936-50e7-5fca-c41b3aeefdce@alum.mit.edu>
In-Reply-To: <5a3f6af6-f936-50e7-5fca-c41b3aeefdce@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHvzj0OkweNWG4u1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3FYsKRFSwWj/resjvw
        ePx9/4HJY+esu+weCzaVejx81cXucWLGbxaPrvYjbB7Pevcwely8pOxxd0IPi8fnTXIBXFFc
        NimpOZllqUX6dglcGUsOT2UvmM5X8fD5HsYGxkncXYycHBICJhJ3H/xi7WLk4hAS2MEksfZL
        F5Rzikmi4f0+ZpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAstYJLrO/GIESQgLuEo8W3iLBcRm
        EVCV6DsxG6yBV8BcYtGMBewQ6+QldrVdBNrAAbTBXuLem3iQMKeAg0TnonUsExh5FjAyrGKU
        S8wpzdXNTczMKU5N1i1OTszLSy3SNdbLzSzRS00p3cQICVi+HYzt62UOMQpwMCrx8Ha8tY8U
        Yk0sK67MPcQoycGkJMpbv9khUogvKT+lMiOxOCO+qDQntfgQowQHs5IIr8R5oBxvSmJlVWpR
        PkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJX4TdQo2BRanpqRVpmTglCmomDE2Q4
        D9Dw7J8gw4sLEnOLM9Mh8qcYFaXEeZtBmgVAEhmleXC9sITyilEc6BVh3r0gVTzAZATX/Qpo
        MBPQ4KALYINLEhFSUg2MidYFH8ubtlQ6fG4SWZa97TeHkurVZteLlrqr3qQHcNxf2P3spUBd
        dNpyzfCoJY17/3+2qpM4mqctsiHs2Pn6ZaqHHvhniYjt/jXR+clRcZEVWmZZb2dOMLcIr2Lb
        s4DhxBfxbX/TxaKTMpy38LxhmsgplLPKTNbdavp0faMPn+0XOURGs8orsRRnJBpqMRcVJwIA
        ODr7nAMDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for `git log --bisect` was calling
`for_each_ref_in_submodule()` with prefix set to "refs/bisect/bad",
which is the actual name of the reference that it wants. This resulted
in the refname being trimmed completely away and the empty string
being passed to the callback. That became impermissible after

    b9c8e7f2fb prefix_ref_iterator: don't trim too much, 2017-05-22

, so the command was failing.

Fix the problem in two orthogonal ways:

1. Add a new function, `for_each_fullref_in_submodule()`, that doesn't
   trim the refnames that it passes to callbacks, and us that instead.
   I *think* that this is a strict improvement, though I don't know
   the `git log` code well enough to be sure that it won't have bad
   side-effects.

2. Relax the "trimming too many characters" check to allow the full
   length of the refname to be trimmed away (though not more than
   that).

In an ideal world the second patch shouldn't be necessary, because
this calling pattern is questionable and it might be better that we
learn about any other offenders. But if we'd rather be conservative
and not break any other code that might rely on the old behavior,
patch 2 is my suggestion for how to do it.

This patch series can be applied on top of branch
`mh/packed-ref-store-prep`, but it also applies cleanly to master. It
is also available as branch `fix-bisect-trim-check` from my GitHub
fork [1].

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (2):
  for_each_bisect_ref(): don't trim refnames
  prefix_ref_iterator_advance(): relax the check of trim length

 refs.c          | 12 ++++++++++++
 refs.h          |  5 ++++-
 refs/iterator.c |  8 ++++----
 revision.c      |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.11.0

