From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 00/86] replace prefixcmp() with starts_with()
Date: Sun, 17 Nov 2013 23:05:52 +0100
Message-ID: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:05:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VisUR-0002aL-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab3KSVFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:05:33 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36247 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939Ab3KSVFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:05:31 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id C8DC33A;
	Tue, 19 Nov 2013 22:05:29 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238044>

Here is a resend of a big patch series to replace prefixcmp()
with a new starts_with() function.

The changes since the previous version are the following

	- the function to replace prefixcmp() is now
	  starts_with()
	- the mispelling of prefixcmp() in the titles
	  of the patches and emails is fixed

The first patch of this series introduces starts_with() and
the last patch removes prefixcmp().

Except a few patches, it's possible to generate the patches
in between using a script like the following: 

===
#!/bin/bash

perl -pi -e 's/!prefixcmp\(/starts_with\(/g' "$1"
perl -pi -e 's/prefixcmp\(/!starts_with\(/g' "$1"

git commit -m "$1: replace prefixcmp() with starts_with()" "$1"
===

The few special cases are the following ones:

        - remote*: replace prefixcmp() with starts_with()
        - transport*: replace prefixcmp() with starts_with()
        - environment: replace prefixcmp() with starts_with()

In first 2 cases above, I processed a few files at the same
time instead of just one.

In the case of "environment", I removed " != 0" after
"!starts_with(...)" as it is not necessary and makes it
more difficult to understand the logic.

Of course it's possible to squash many of the commits
together if it is prefered.


Christian Couder (86):
  strbuf: add starts_with() to be used instead of prefixcmp()
  diff: replace prefixcmp() with starts_with()
  fast-import: replace prefixcmp() with starts_with()
  remote*: replace prefixcmp() with starts_with()
  daemon: replace prefixcmp() with starts_with()
  pretty: replace prefixcmp() with starts_with()
  revision: replace prefixcmp() with starts_with()
  transport*: replace prefixcmp() with starts_with()
  config: replace prefixcmp() with starts_with()
  sha1_name: replace prefixcmp() with starts_with()
  wt-status: replace prefixcmp() with starts_with()
  upload-pack: replace prefixcmp() with starts_with()
  test-line-buffer: replace prefixcmp() with starts_with()
  parse-options: replace prefixcmp() with starts_with()
  fetch-pack: replace prefixcmp() with starts_with()
  git: replace prefixcmp() with starts_with()
  tag: replace prefixcmp() with starts_with()
  sequencer: replace prefixcmp() with starts_with()
  commit: replace prefixcmp() with starts_with()
  http: replace prefixcmp() with starts_with()
  imap-send: replace prefixcmp() with starts_with()
  help: replace prefixcmp() with starts_with()
  log-tree: replace prefixcmp() with starts_with()
  merge-recursive: replace prefixcmp() with starts_with()
  notes: replace prefixcmp() with starts_with()
  refs: replace prefixcmp() with starts_with()
  setup: replace prefixcmp() with starts_with()
  bisect: replace prefixcmp() with starts_with()
  branch: replace prefixcmp() with starts_with()
  http-push: replace prefixcmp() with starts_with()
  send-pack: replace prefixcmp() with starts_with()
  http-backend: replace prefixcmp() with starts_with()
  notes-utils: replace prefixcmp() with starts_with()
  pkt-line: replace prefixcmp() with starts_with()
  alias: replace prefixcmp() with starts_with()
  attr: replace prefixcmp() with starts_with()
  connect: replace prefixcmp() with starts_with()
  pager: replace prefixcmp() with starts_with()
  convert: replace prefixcmp() with starts_with()
  environment: replace prefixcmp() with starts_with()
  shell: replace prefixcmp() with starts_with()
  pathspec: replace prefixcmp() with starts_with()
  submodule: replace prefixcmp() with starts_with()
  test-string-list: replace prefixcmp() with starts_with()
  builtin/apply: replace prefixcmp() with starts_with()
  builtin/archive: replace prefixcmp() with starts_with()
  builtin/branch: replace prefixcmp() with starts_with()
  builtin/checkout: replace prefixcmp() with starts_with()
  builtin/clean: replace prefixcmp() with starts_with()
  builtin/clone: replace prefixcmp() with starts_with()
  builtin/column: replace prefixcmp() with starts_with()
  builtin/commit: replace prefixcmp() with starts_with()
  builtin/describe: replace prefixcmp() with starts_with()
  builtin/fast-export: replace prefixcmp() with starts_with()
  builtin/fetch-pack: replace prefixcmp() with starts_with()
  builtin/fetch: replace prefixcmp() with starts_with()
  builtin/fmt-merge-msg: replace prefixcmp() with starts_with()
  builtin/for-each-ref: replace prefixcmp() with starts_with()
  builtin/fsck: replace prefixcmp() with starts_with()
  builtin/help: replace prefixcmp() with starts_with()
  builtin/index-pack: replace prefixcmp() with starts_with()
  builtin/init-db: replace prefixcmp() with starts_with()
  builtin/log: replace prefixcmp() with starts_with()
  builtin/ls-remote: replace prefixcmp() with starts_with()
  builtin/mailinfo: replace prefixcmp() with starts_with()
  builtin/merge-recursive: replace prefixcmp() with starts_with()
  builtin/merge: replace prefixcmp() with starts_with()
  builtin/name-rev: replace prefixcmp() with starts_with()
  builtin/notes: replace prefixcmp() with starts_with()
  builtin/pack-objects: replace prefixcmp() with starts_with()
  builtin/prune: replace prefixcmp() with starts_with()
  builtin/receive-pack: replace prefixcmp() with starts_with()
  builtin/reflog: replace prefixcmp() with starts_with()
  builtin/remote: replace prefixcmp() with starts_with()
  builtin/rev-parse: replace prefixcmp() with starts_with()
  builtin/send-pack: replace prefixcmp() with starts_with()
  builtin/shortlog: replace prefixcmp() with starts_with()
  builtin/show-branch: replace prefixcmp() with starts_with()
  builtin/show-ref: replace prefixcmp() with starts_with()
  builtin/symbolic-ref: replace prefixcmp() with starts_with()
  builtin/tag: replace prefixcmp() with starts_with()
  builtin/tar-tree: replace prefixcmp() with starts_with()
  builtin/unpack-objects: replace prefixcmp() with starts_with()
  builtin/update-ref: replace prefixcmp() with starts_with()
  builtin/upload-archive: replace prefixcmp() with starts_with()
  strbuf: remove prefixcmp() as it has been replaced with starts_with()

 alias.c                   |  2 +-
 attr.c                    |  2 +-
 bisect.c                  |  4 +--
 branch.c                  |  4 +--
 builtin/apply.c           | 12 +++----
 builtin/archive.c         |  4 +--
 builtin/branch.c          |  6 ++--
 builtin/checkout.c        |  8 ++---
 builtin/clean.c           |  4 +--
 builtin/clone.c           |  6 ++--
 builtin/column.c          |  2 +-
 builtin/commit.c          | 10 +++---
 builtin/describe.c        |  2 +-
 builtin/fast-export.c     |  2 +-
 builtin/fetch-pack.c      |  6 ++--
 builtin/fetch.c           | 16 +++++-----
 builtin/fmt-merge-msg.c   | 10 +++---
 builtin/for-each-ref.c    | 14 ++++-----
 builtin/fsck.c            |  6 ++--
 builtin/help.c            |  8 ++---
 builtin/index-pack.c      |  8 ++---
 builtin/init-db.c         |  2 +-
 builtin/log.c             |  8 ++---
 builtin/ls-remote.c       |  4 +--
 builtin/mailinfo.c        | 16 +++++-----
 builtin/merge-recursive.c |  2 +-
 builtin/merge.c           | 12 +++----
 builtin/name-rev.c        |  6 ++--
 builtin/notes.c           |  2 +-
 builtin/pack-objects.c    |  2 +-
 builtin/prune.c           |  4 +--
 builtin/receive-pack.c    |  6 ++--
 builtin/reflog.c          |  4 +--
 builtin/remote.c          |  8 ++---
 builtin/rev-parse.c       | 24 +++++++-------
 builtin/send-pack.c       |  8 ++---
 builtin/shortlog.c        |  6 ++--
 builtin/show-branch.c     | 20 ++++++------
 builtin/show-ref.c        |  6 ++--
 builtin/symbolic-ref.c    |  2 +-
 builtin/tag.c             |  2 +-
 builtin/tar-tree.c        |  2 +-
 builtin/unpack-objects.c  |  2 +-
 builtin/update-ref.c      | 10 +++---
 builtin/upload-archive.c  |  2 +-
 commit.c                  |  6 ++--
 config.c                  | 16 +++++-----
 connect.c                 |  2 +-
 convert.c                 |  2 +-
 daemon.c                  | 40 ++++++++++++------------
 diff.c                    | 56 ++++++++++++++++-----------------
 environment.c             |  2 +-
 fast-import.c             | 80 +++++++++++++++++++++++------------------------
 fetch-pack.c              | 12 +++----
 git-compat-util.h         |  2 +-
 git.c                     | 12 +++----
 help.c                    |  8 ++---
 http-backend.c            |  4 +--
 http-push.c               |  4 +--
 http.c                    |  8 ++---
 imap-send.c               | 10 +++---
 log-tree.c                |  8 ++---
 merge-recursive.c         |  6 ++--
 notes-utils.c             |  4 +--
 notes.c                   |  8 ++---
 pager.c                   |  2 +-
 parse-options.c           | 12 +++----
 pathspec.c                |  2 +-
 pkt-line.c                |  4 +--
 pretty.c                  | 36 ++++++++++-----------
 refs.c                    | 30 +++++++++---------
 remote-curl.c             | 14 ++++-----
 remote-testsvn.c          | 10 +++---
 remote.c                  | 46 +++++++++++++--------------
 revision.c                | 38 +++++++++++-----------
 send-pack.c               |  4 +--
 sequencer.c               |  8 ++---
 setup.c                   |  4 +--
 sha1_name.c               | 16 +++++-----
 shell.c                   |  2 +-
 strbuf.c                  |  6 ++--
 submodule.c               |  2 +-
 tag.c                     | 10 +++---
 test-line-buffer.c        |  6 ++--
 test-string-list.c        |  2 +-
 transport-helper.c        | 16 +++++-----
 transport.c               | 28 ++++++++---------
 upload-pack.c             | 10 +++---
 wt-status.c               | 16 +++++-----
 89 files changed, 455 insertions(+), 455 deletions(-)

-- 
1.8.4.1.561.g12affca
