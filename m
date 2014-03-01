From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 00/27] Support multiple checkouts
Date: Sat,  1 Mar 2014 19:12:36 +0700
Message-ID: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:20:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiuS-0001XN-Cp
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbaCAMUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:20:48 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:50313 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbaCAMUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:20:47 -0500
Received: by mail-pb0-f54.google.com with SMTP id ma3so1765936pbc.41
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q98KCIWMJt0bJiP0xVY50BESQuOjkWv1GrI5wD5B/gU=;
        b=L/2cq0pZEG8SYaU5W3tAV0lZ17E4/JCklh4pRvQJ5mRIp5rhk7eIjsHVkfs6oxAknD
         j7mzJ1/oO1uJx17HBm5UeRmxUUzj5NWIN1k/QaJZt0GILh3RJrEJ9u2U5GaeomD5Mmix
         FQY7oDJaBTXzVdQpNFXHQInfca68GrCiBWCAqUMeBJ2X8Rwjm/36UvZfv7lLc/TjaIMP
         /qw+xkuRT3umLqBM99GbQf6/Eohd6+r2i2sNUTPFdu81GWAvkR48yNgsTA25omiwMCv2
         1iDdLzgVe3TVuKAYIFVjea+daB18HymtDafMXwjrt9YJE8HP1neyD+AMH2hJpw3NHu8E
         GmIg==
X-Received: by 10.67.5.39 with SMTP id cj7mr9092551pad.7.1393676447085;
        Sat, 01 Mar 2014 04:20:47 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id gj9sm15918735pbc.7.2014.03.01.04.20.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:20:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:21:12 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243065>

Phew.. v4 changes are

- address all comments from Junio and Eric (I hope)
- fix "git checkout --to" not working from the linked checkouts
- report unused files (e.g. $GIT_DIR/repos/xx/config) in count-objects =
-v

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (27):
  path.c: make get_pathname() return strbuf instead of static buffer
  Convert git_snpath() to strbuf_git_path()
  path.c: rename vsnpath() to do_git_path()
  path.c: group git_path(), git_pathdup() and strbuf_git_path() togethe=
r
  Make git_path() aware of file relocation in $GIT_DIR
  *.sh: respect $GIT_INDEX_FILE
  reflog: avoid constructing .lock path with git_path
  fast-import: use git_path() for accessing .git dir instead of get_git=
_dir()
  commit: use SEQ_DIR instead of hardcoding "sequencer"
  Add new environment variable $GIT_COMMON_DIR
  git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
  *.sh: avoid hardcoding $GIT_DIR/hooks/...
  git-stash: avoid hardcoding $GIT_DIR/logs/....
  setup.c: convert is_git_directory() to use strbuf
  setup.c: detect $GIT_COMMON_DIR in is_git_directory()
  setup.c: convert check_repository_format_gently to use strbuf
  setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
  setup.c: support multi-checkout repo setup
  wrapper.c: wrapper to open a file, fprintf then close
  use new wrapper write_file() for simple file writing
  checkout: support checking out into a new working directory
  checkout: clean up half-prepared directories in --to mode
  checkout: detach if the branch is already checked out elsewhere
  prune: strategies for linked checkouts
  gc: style change -- no SP before closing bracket
  gc: support prune --repos
  count-objects: report unused files in $GIT_DIR/repos/...

 Documentation/config.txt               |   8 +
 Documentation/git-checkout.txt         |  34 ++++
 Documentation/git-prune.txt            |   3 +
 Documentation/git-rev-parse.txt        |   8 +
 Documentation/git.txt                  |   9 ++
 Documentation/gitrepository-layout.txt |  75 +++++++--
 builtin/branch.c                       |   4 +-
 builtin/checkout.c                     | 274 +++++++++++++++++++++++++=
++++++--
 builtin/commit.c                       |   2 +-
 builtin/count-objects.c                |  37 ++++-
 builtin/gc.c                           |  21 ++-
 builtin/init-db.c                      |   7 +-
 builtin/prune.c                        |  74 +++++++++
 builtin/reflog.c                       |   2 +-
 builtin/rev-parse.c                    |  11 ++
 cache.h                                |  10 +-
 compat/mingw.h                         |   1 +
 daemon.c                               |  11 +-
 environment.c                          |  24 ++-
 fast-import.c                          |   5 +-
 git-am.sh                              |  22 +--
 git-compat-util.h                      |   4 +
 git-pull.sh                            |   2 +-
 git-rebase--interactive.sh             |   6 +-
 git-rebase--merge.sh                   |   6 +-
 git-rebase.sh                          |   4 +-
 git-sh-setup.sh                        |   2 +-
 git-stash.sh                           |   6 +-
 path.c                                 | 206 ++++++++++++++++---------
 refs.c                                 |  66 +++++---
 refs.h                                 |   2 +-
 setup.c                                | 124 +++++++++++----
 submodule.c                            |   9 +-
 t/t0060-path-utils.sh                  |  34 ++++
 t/t1501-worktree.sh                    |  76 +++++++++
 t/t1510-repo-setup.sh                  |   1 +
 t/t2025-checkout-to.sh (new +x)        |  57 +++++++
 templates/hooks--applypatch-msg.sample |   4 +-
 templates/hooks--pre-applypatch.sample |   4 +-
 trace.c                                |   1 +
 transport.c                            |   8 +-
 wrapper.c                              |  31 ++++
 42 files changed, 1069 insertions(+), 226 deletions(-)

--=20
1.9.0.40.gaa8c3ea
