From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/31] nd/parse-pathspec
Date: Sun, 13 Jan 2013 19:35:08 +0700
Message-ID: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMmy-0005Sn-DI
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab3AMMf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:35:28 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:52176 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab3AMMf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:35:27 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so1427639dak.28
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=pTE8TtrrVy4Jfjlo/gRgCJMYNj54kIgUu90wO6GK3M4=;
        b=jxRQvQwSHCpye/5AvgvLx169uJyDlu9LYNulb2ErBK98zmvlo4hbRZ1rJnxZMIUk5D
         XobYGZgb5L5KenztlA1Jjg1y6VsgvBFVbGVVrRZ1O220hVavqFbL03BXWk7HrTG6GHUS
         4coFNySq+B1imrWfmIOuhF8vl6G/9H3rFbjRijfe01Sz5DJLGiNY+yeZPKq4aR1RX6yG
         FJm1xWcjwLpIgJOCUp68BtB7C4gmxSKEYOLz203LReJ3PAFAWyi70EjohqRnhoG/C8GA
         UH6iktF9OrNdpwKyW5FAynNkto9R+lRGw1WgWGxv0l/TLqEsXl3h5LZRDO3D301FgLp+
         GsSQ==
X-Received: by 10.66.76.97 with SMTP id j1mr4317589paw.70.1358080526826;
        Sun, 13 Jan 2013 04:35:26 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id i1sm6744497pav.35.2013.01.13.04.35.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:35:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:35:41 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213340>

Changes from v2 (it's hard to keep track of after the rebase, so I may
be missing something here):

 - rebased on top of recent master, incorporate changes in
   init_pathspec from jk/pathspec-literal and nd/pathspec-wildcard to
   parse_pathspec

 - kill strip_trailing_slash_from_submodules and treat_gitlinks
   (pretty sure it'll cause conflicts with as/check-ignore)

 - kill init_pathspec, match_pathspec, diff_tree_setup_paths and
   diff_tree_release_paths
=20
 - check points for future pathspec development

As far as I understand the "pathspec unification", I'd say we are
there, with a few exceptions like "mv", external commands.. But those
are pretty much isolated.

I'll send another WIP series implementing :(icase) and :(glob), mainly
to show (me) how future pathspec feature development looks like after
this.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (31):
  clean: remove unused variable "seen"
  Add copy_pathspec
  Add parse_pathspec() that converts cmdline args to struct pathspec
  parse_pathspec: save original pathspec for reporting
  Export parse_pathspec() and convert some get_pathspec() calls
  Guard against new pathspec magic in pathspec matching code
  clean: convert to use parse_pathspec
  parse_pathspec: add PATHSPEC_EMPTY_MATCH_ALL
  commit: convert to use parse_pathspec
  status: convert to use parse_pathspec
  rerere: convert to use parse_pathspec
  checkout: convert to use parse_pathspec
  rm: convert to use parse_pathspec
  parse_pathspec: support stripping submodule trailing slashes
  ls-files: convert to use parse_pathspec
  archive: convert to use parse_pathspec
  parse_pathspec: support stripping/checking submodule paths
  add: convert to use parse_pathspec
  Convert read_cache_preload() to take struct pathspec
  Convert unmerge_cache to take struct pathspec
  checkout: convert read_tree_some to take struct pathspec
  Convert report_path_error to take struct pathspec
  Convert refresh_index to take struct pathspec
  Convert {read,fill}_directory to take struct pathspec
  Convert add_files_to_cache to take struct pathspec
  Convert common_prefix() to use struct pathspec
  Remove diff_tree_{setup,release}_paths
  Remove init_pathspec() in favor of parse_pathspec()
  Remove match_pathspec() in favor of match_pathspec_depth()
  tree-diff: remove the use of pathspec's raw[] in follow-rename codepa=
th
  Rename field "raw" to "_raw" in struct pathspec

 archive.c              |  18 +++--
 archive.h              |   2 +-
 builtin/add.c          | 155 +++++++++++++++----------------------
 builtin/blame.c        |  12 +--
 builtin/checkout.c     |  44 ++++++-----
 builtin/clean.c        |  21 ++---
 builtin/commit.c       |  37 +++++----
 builtin/diff-files.c   |   2 +-
 builtin/diff-index.c   |   2 +-
 builtin/diff.c         |   6 +-
 builtin/grep.c         |   6 +-
 builtin/log.c          |   2 +-
 builtin/ls-files.c     |  72 +++++++-----------
 builtin/ls-tree.c      |  10 ++-
 builtin/mv.c           |  13 ++--
 builtin/rerere.c       |   6 +-
 builtin/reset.c        |   4 +-
 builtin/rm.c           |  23 +++---
 builtin/update-index.c |   3 +-
 cache.h                |  36 +++++++--
 diff-lib.c             |   2 +-
 diff.h                 |   2 -
 dir.c                  | 202 ++++++++---------------------------------=
--------
 dir.h                  |   9 ++-
 merge-recursive.c      |   2 +-
 notes-merge.c          |   4 +-
 preload-index.c        |  20 ++---
 read-cache.c           |   5 +-
 rerere.c               |   6 +-
 rerere.h               |   4 +-
 resolve-undo.c         |   4 +-
 resolve-undo.h         |   2 +-
 revision.c             |  11 +--
 setup.c                | 149 ++++++++++++++++++++++++++++++------
 tree-diff.c            |  47 +++++++-----
 tree-walk.c            |   2 +
 tree.c                 |   4 +-
 tree.h                 |   2 +-
 wt-status.c            |  17 ++---
 wt-status.h            |   2 +-
 40 files changed, 460 insertions(+), 510 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
