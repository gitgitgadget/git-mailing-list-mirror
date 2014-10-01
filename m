From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 00/38] Lockfile correctness and refactoring
Date: Wed,  1 Oct 2014 12:28:04 +0200
Message-ID: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH9m-0002VI-Qe
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbaJAK3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:09 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42552 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246AbaJAK3A (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:00 -0400
X-AuditID: 12074414-f79446d000001f1d-59-542bd762a2b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D2.61.07965.267DB245; Wed,  1 Oct 2014 06:28:50 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk5x026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:28:47 -0400
X-Mailer: git-send-email 2.1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqJt0XTvE4PxBAYuuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDO+zPrFXPBGo2Lbb6kGxnXSXYyc
	HBICJhKHnz9ghbDFJC7cW8/WxcjFISRwmVHi27vT7BDOcSaJv5M/MINUsQnoSizqaWYCsUUE
	1CQmth1iASliFljMJDHh0Cagdg4OYQE7iftvwaayCKhKTD1yBKyXV8BZ4tGnjewQ2+QkNuz+
	zwgRF5Q4OfMJC0grs4C6xPp5QiBhZgF5ieats5knMPLNQlI1C6FqFpKqBYzMqxjlEnNKc3Vz
	EzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzFCwlxkB+ORk3KHGAU4GJV4eBUStEOEWBPLiitz
	DzFKcjApifIuugQU4kvKT6nMSCzOiC8qzUktPsQowcGsJMKbfQAox5uSWFmVWpQPk5LmYFES
	5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwctwDahRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8l
	tSixtCQjHhR18cXAuANJ8QDtdQZp5y0uSMwFikK0nmLU5VjX+a2fSYglLz8vVUqcNxOkSACk
	KKM0D24FLKm9YhQH+liYNxykigeYEOEmvQJawgS0JHkN2JKSRIQUMLEsuKQ8JSOkTOFsj6jS
	OyfvpLdrn3auTb47T+ReeO2z+u0Rp7VOmt2fp9P0qz9p5+as/pAN86RczyUbbLJ9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257705>

Yet another iteration of my lockfile fixes and refactoring. Thanks to
Junio for his comments about v6.

I believe that this series addresses all of the comments from v1 [1],
v2 [2], v3 [3], v4 [4], v5 [5], and v6 [6].

Changes since v6:

* Rebased on current master to resolve conflicts with
  jk/write-packed-refs-via-stdio. Changes made in that branch removed
  the need for the following patch from v6:

      [13/39] prepare_index(): declare return value to be (const char *)

* More improvements to the API documentation.

I will separately submit patches to support stdio-based access to
lockfiles.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/245609
[2] http://thread.gmane.org/gmane.comp.version-control.git/245801
[3] http://thread.gmane.org/gmane.comp.version-control.git/246222
[4] http://thread.gmane.org/gmane.comp.version-control.git/256564
[5] http://thread.gmane.org/gmane.comp.version-control.git/257159
[6] http://thread.gmane.org/gmane.comp.version-control.git/257504

Michael Haggerty (38):
  unable_to_lock_die(): rename function from unable_to_lock_index_die()
  api-lockfile: revise and expand the documentation
  close_lock_file(): exit (successfully) if file is already closed
  rollback_lock_file(): do not clear filename redundantly
  rollback_lock_file(): exit early if lock is not active
  rollback_lock_file(): set fd to -1
  lockfile: unlock file if lockfile permissions cannot be adjusted
  hold_lock_file_for_append(): release lock on errors
  lock_file(): always initialize and register lock_file object
  lockfile.c: document the various states of lock_file objects
  cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
  delete_ref_loose(): don't muck around in the lock_file's filename
  prepare_index(): declare return value to be (const char *)
  lock_file(): exit early if lockfile cannot be opened
  remove_lock_file(): call rollback_lock_file()
  commit_lock_file(): inline temporary variable
  commit_lock_file(): die() if called for unlocked lockfile object
  close_lock_file(): if close fails, roll back
  commit_lock_file(): rollback lock file on failure to rename
  api-lockfile: document edge cases
  dump_marks(): remove a redundant call to rollback_lock_file()
  git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
  lockfile: avoid transitory invalid states
  struct lock_file: declare some fields volatile
  try_merge_strategy(): remove redundant lock_file allocation
  try_merge_strategy(): use a statically-allocated lock_file object
  commit_lock_file(): use a strbuf to manage temporary space
  Change lock_file::filename into a strbuf
  resolve_symlink(): use a strbuf for internal scratch space
  resolve_symlink(): take a strbuf parameter
  trim_last_path_component(): replace last_path_elm()
  Extract a function commit_lock_file_to()
  Rename LOCK_NODEREF to LOCK_NO_DEREF
  lockfile.c: rename static functions
  get_locked_file_path(): new function
  hold_lock_file_for_append(): restore errno before returning
  Move read_index() definition to read-cache.c
  lockfile.h: extract new header file for the functions in lockfile.c

 Documentation/technical/api-lockfile.txt | 242 ++++++++++++++++++++------
 builtin/add.c                            |   1 +
 builtin/apply.c                          |   1 +
 builtin/checkout-index.c                 |   2 +-
 builtin/checkout.c                       |   2 +-
 builtin/clone.c                          |   1 +
 builtin/commit.c                         |  17 +-
 builtin/describe.c                       |   1 +
 builtin/diff.c                           |   1 +
 builtin/gc.c                             |   2 +-
 builtin/merge.c                          |  16 +-
 builtin/mv.c                             |   2 +-
 builtin/read-tree.c                      |   1 +
 builtin/receive-pack.c                   |   1 +
 builtin/reflog.c                         |   4 +-
 builtin/reset.c                          |   1 +
 builtin/rm.c                             |   2 +-
 builtin/update-index.c                   |   3 +-
 bundle.c                                 |   1 +
 cache-tree.c                             |   1 +
 cache.h                                  |  20 +--
 config.c                                 |  16 +-
 credential-store.c                       |   1 +
 fast-import.c                            |   5 +-
 fetch-pack.c                             |   1 +
 lockfile.c                               | 284 +++++++++++++++++--------------
 lockfile.h                               |  84 +++++++++
 merge-recursive.c                        |   1 +
 merge.c                                  |   1 +
 read-cache.c                             |  21 ++-
 refs.c                                   |  23 +--
 rerere.c                                 |   1 +
 sequencer.c                              |   1 +
 sha1_file.c                              |   1 +
 shallow.c                                |   7 +-
 test-scrap-cache-tree.c                  |   1 +
 36 files changed, 510 insertions(+), 260 deletions(-)
 create mode 100644 lockfile.h

-- 
2.1.0
