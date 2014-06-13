From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/32] Split index resend
Date: Fri, 13 Jun 2014 19:19:19 +0700
Message-ID: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:20:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQSt-0002Hx-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbaFMMUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:20:08 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38364 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaFMMUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:20:07 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so2071666pbb.36
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=qnpTxlncno8a0m3/gXqREq/x4nw0+cSwAQPfxUxu/08=;
        b=FQFkWS+0YTHSqsQxORAt9U7Z2Tj5cRvVyc3/C43SAz1nUJsA++u51xt7q6dX/37eeu
         fO2Guhv9hJXDLfUqjsTb60wqge8/ok7kVOmsjuzPx6FhB8GvR+XfVqL3texpaqX9VGas
         GaMu+iR/3fyDb670MdDXo6nW6N2dl/V/zis7GxE/rP1s0eKCoVfQjcxLeRZwwAeHlSkW
         1xs2kKNWUem5Malf0c2nUOdQqj/KCBTRYe5fykD+z0ax0QXg9x4at1woAFIVskNhlGlC
         jsxWtaAOq83XGGlVuZ6BKGQbKvmZxg/KILGOPMkDDLRJfU1uNo6siBChKPVdDhDoPHvT
         sGYw==
X-Received: by 10.66.180.34 with SMTP id dl2mr2923129pac.124.1402662006094;
        Fri, 13 Jun 2014 05:20:06 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id ys1sm20776046pab.7.2014.06.13.05.20.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:20:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:20:05 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251556>

This is basically what's in 'pu' with fixup patches squashed in (also
resend is a good way to get people's eyes on it one more time).
There's also another minor change that SOMETHING_CHANGED now has value
1.  This is the usual value of cache_changed before this series. So if
another in-flight series update cache_changed the old way, nothing's
subtly broken.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (32):
  ewah: fix constness of ewah_read_mmap
  ewah: delete unused ewah_read_mmap_native declaration
  sequencer: do not update/refresh index if the lock cannot be held
  read-cache: new API write_locked_index instead of write_index/write_c=
ache
  read-cache: relocate and unexport commit_locked_index()
  read-cache: store in-memory flags in the first 12 bits of ce_flags
  read-cache: be strict about "changed" in remove_marked_cache_entries(=
)
  read-cache: be specific what part of the index has changed
  update-index: be specific what part of the index has changed
  resolve-undo: be specific what part of the index has changed
  unpack-trees: be specific what part of the index has changed
  cache-tree: mark istate->cache_changed on cache tree invalidation
  cache-tree: mark istate->cache_changed on cache tree update
  cache-tree: mark istate->cache_changed on prime_cache_tree()
  entry.c: update cache_changed if refresh_cache is set in checkout_ent=
ry()
  read-cache: save index SHA-1 after reading
  read-cache: split-index mode
  read-cache: mark new entries for split index
  read-cache: save deleted entries in split index
  read-cache: mark updated entries for split index
  split-index: the writing part
  split-index: the reading part
  split-index: do not invalidate cache-tree at read time
  split-index: strip pathname of on-disk replaced entries
  update-index: new options to enable/disable split index mode
  update-index --split-index: do not split if $GIT_DIR is read only
  rev-parse: add --shared-index-path to get shared index path
  read-tree: force split-index mode off on --index-output
  read-tree: note about dropping split-index mode or index version
  read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
  t2104: make sure split index mode is off for the version test
  t1700: new tests for split-index mode

 .gitignore                               |   1 +
 Documentation/git-rev-parse.txt          |   4 +
 Documentation/git-update-index.txt       |  11 ++
 Documentation/gitrepository-layout.txt   |   4 +
 Documentation/technical/index-format.txt |  35 ++++
 Makefile                                 |   2 +
 builtin/add.c                            |   6 +-
 builtin/apply.c                          |  17 +-
 builtin/blame.c                          |   2 +-
 builtin/checkout-index.c                 |   4 +-
 builtin/checkout.c                       |  12 +-
 builtin/clone.c                          |   7 +-
 builtin/commit.c                         |  33 ++--
 builtin/merge.c                          |  12 +-
 builtin/mv.c                             |   7 +-
 builtin/read-tree.c                      |  18 +-
 builtin/reset.c                          |   7 +-
 builtin/rev-parse.c                      |  10 +
 builtin/rm.c                             |   7 +-
 builtin/update-index.c                   |  33 +++-
 cache-tree.c                             |  52 ++---
 cache-tree.h                             |   6 +-
 cache.h                                  |  28 ++-
 entry.c                                  |   3 +
 ewah/ewah_io.c                           |   4 +-
 ewah/ewok.h                              |   3 +-
 lockfile.c                               |  20 --
 merge-recursive.c                        |  11 +-
 merge.c                                  |   7 +-
 read-cache.c                             | 270 ++++++++++++++++++++++-=
--
 rerere.c                                 |   3 +-
 resolve-undo.c                           |   2 +-
 sequencer.c                              |  16 +-
 split-index.c (new)                      | 328 +++++++++++++++++++++++=
++++++++
 split-index.h (new)                      |  35 ++++
 t/t1700-split-index.sh (new +x)          | 194 ++++++++++++++++++
 t/t2104-update-index-skip-worktree.sh    |   2 +
 test-dump-cache-tree.c                   |   7 +-
 test-dump-split-index.c (new)            |  34 ++++
 test-scrap-cache-tree.c                  |   5 +-
 unpack-trees.c                           |  18 +-
 41 files changed, 1088 insertions(+), 192 deletions(-)
 create mode 100644 split-index.c
 create mode 100644 split-index.h
 create mode 100755 t/t1700-split-index.sh
 create mode 100644 test-dump-split-index.c

--=20
1.9.1.346.ga2b5940
