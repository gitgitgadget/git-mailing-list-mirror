Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE11207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967183AbdDZUTU (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:19:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:51043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967179AbdDZUTS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:19:18 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcnRD-1dn1ZW1O9X-00k5sB; Wed, 26
 Apr 2017 22:19:13 +0200
Date:   Wed, 26 Apr 2017 22:19:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/26] Address a couple of issues identified by Coverity
Message-ID: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1055501654-1493237953=:3480"
X-Provags-ID: V03:K0:AFsJL5belBmk/thJWtAsr3yE3c+RM8P8ez6zB2Ko2KweDUZBL01
 pP8yMS/mT9fdfdxMSyoLymiJHTwzlOI63xi7fET8ocBvgVREnYl3Wi9GGJKL2G6J8aM2x1J
 2WNoGLw0Qa6XIYlDnl+SUpWhEeEfxIVDVkK2iOKO80au4HuHab/xu6gAafW96+3g5Eg5S0m
 BHUaNM96eAZkS5rn8YLhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aPdIsAe1rQw=:6ELU0Sw/ryAX2isWhcnfH0
 7gIzVjLMFoadFnPdE3vvDsiA+rGYP5CkZnvSSextLUe+GwwKLlDguqyQ0BoppFt3I7XJS7dP4
 RGQIFiwlNRX9ShzUFK1WZxS34oFNTzus61EE0bqKeiOYVcmWJxymtagJXPIF+ickWqpPYeoVq
 pde7xGhm8kz15T9G1WEYjkBJwixzt7/YSajAXkcVZ/KWW+uiAyjyEX2lU3XPqPfajJkSS5Xiq
 W7H1NU5Tt+Iak255VBG+0wr+E/UAZamDzGQNZ3DTXPolT6bwRIrqjZzPYqgp3SJp8gcXqukrx
 4sv2CAJUEd0pipPBm7tegJoc1a9bU3xoOUH+Eq1ucFt6DzfgmCwM9FiwpjnzEDojM6aq0FScY
 KMSUCGaSKS0ZfPWj6K7TdLbZAsc9QYBYl/EXyML+TGnaShPo9rI1O++pPb7BtY2hex3pesRA9
 NwdMZ8qjkNH4e3NxTgbacnzOUL4MYEiUNYvb4xn24mAxcse2CQKC/UyHpZILgju5TGNg+YHf0
 ojGaFlXckxK4rb2cCit0RTyhmEAHMS3CdcINCAVKtlHuA5HRFinSJz7ONa5D487RWmZ6DR8wI
 LuyIvYieK5xF/yPwXfd5Ir889KjhUqcBZ1Jq8MErqKqBw172FVW6zgsqMGFDPGLAJHYmEs21P
 SSBqh7ni+WfE6dRf78tyPxTkA/fDm8STgrMDgEu/NUPg6NAJLIFAahSmhuhj2Uas1xakLHbpX
 oYIo4phKS7RguYarAnNMqYVtvNLJEaKpE3WLl3mvPMOzOZ6JS8EHcRUqGL63kT1d0UXmfy0zG
 3LXpwtr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1055501654-1493237953=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

I recently registered the git-for-windows fork with Coverity to ensure
that even the Windows-specific patches get some static analysis love.

While at it, I squashed a couple of obvious issues in the part that is
not Windows-specific.

Note: while this patch series squashes some of those issues, the
remaining issues are not necessarily all false positives (e.g. Coverity
getting fooled by our FLEX_ARRAY trick into believing that the last
member of the struct is indeed a 0 or 1 size array) or intentional (e.g.
builtins not releasing memory because exit() is called right after
returning from the function that leaks memory).

Notable examples of the remaining issues are:

- a couple of callers of shorten_unambiguous_ref() assume that they do
  not have to release the memory returned from that function, often
  assigning the pointer to a `const` variable that typically does not
  hold a pointer that needs to be free()d. My hunch is that we will want
  to convert that function to have a fixed number of static buffers and
  use those in a round robin fashion =C3=A0 la sha1_to_hex().

- pack-redundant.c seems to have hard-to-reason-about code paths that
  may eventually leak memory. Essentially, the custody of the allocated
  memory is not clear at all.

- fast-import.c calls strbuf_detach() on the command_buf without any
  obvious rationale. Turns out that *some* code paths assign
  command_buf.buf to a `recent_command` which releases the buffer later.
  However, from a cursory look it appears to me as if there are some
  other code paths that skip that assignment, effectively causing a memory
  leak once strbuf_detach() is called.

Sadly, I lack the time to pursue those remaining issues further.


Johannes Schindelin (26):
  mingw: avoid memory leak when splitting PATH
  winansi: avoid use of uninitialized value
  winansi: avoid buffer overrun
  add_commit_patch_id(): avoid allocating memory unnecessarily
  git_config_rename_section_in_file(): avoid resource leak
  get_mail_commit_oid(): avoid resource leak
  http-backend: avoid memory leaks
  difftool: close file descriptors after reading
  status: close file descriptor after reading git-rebase-todo
  Check for EOF while parsing mails
  cat-file: fix memory leak
  checkout: fix memory leak
  split_commit_in_progress(): fix memory leak
  setup_bare_git_dir(): fix memory leak
  setup_discovered_git_dir(): fix memory leak
  pack-redundant: plug memory leak
  mktree: plug memory leaks reported by Coverity
  fast-export: avoid leaking memory in handle_tag()
  receive-pack: plug memory leak in update()
  line-log: avoid memory leak
  shallow: avoid memory leak
  add_reflog_for_walk: avoid memory leak
  remote: plug memory leak in match_explicit()
  name-rev: avoid leaking memory in the `deref` case
  show_worktree(): plug memory leak
  submodule_uses_worktrees(): plug memory leak

 builtin/am.c             | 11 ++++++-----
 builtin/cat-file.c       |  1 +
 builtin/checkout.c       |  1 +
 builtin/difftool.c       |  2 ++
 builtin/fast-export.c    |  1 +
 builtin/mailsplit.c      |  2 +-
 builtin/mktree.c         |  5 +++--
 builtin/name-rev.c       |  7 +++++--
 builtin/pack-redundant.c |  1 +
 builtin/receive-pack.c   |  4 +++-
 builtin/worktree.c       |  8 +++++---
 compat/mingw.c           |  4 +++-
 compat/winansi.c         |  7 +++++++
 config.c                 |  5 ++++-
 http-backend.c           |  6 +++++-
 line-log.c               |  1 +
 mailinfo.c               |  2 +-
 patch-ids.c              |  3 ++-
 reflog-walk.c            |  6 +++++-
 remote.c                 |  5 +++--
 setup.c                  | 11 ++++++++---
 shallow.c                |  8 ++++++--
 worktree.c               |  2 +-
 wt-status.c              |  8 +++++++-
 24 files changed, 82 insertions(+), 29 deletions(-)


base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
Published-As: https://github.com/dscho/git/releases/tag/coverity-v1
Fetch-It-Via: git fetch https://github.com/dscho/git coverity-v1

--=20
2.12.2.windows.2.800.gede8f145e06

--8323329-1055501654-1493237953=:3480--
