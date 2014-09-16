From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 00/35] Lockfile correctness and refactoring
Date: Tue, 16 Sep 2014 21:33:21 +0200
Message-ID: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:41:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyct-0003GN-OU
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbaIPTlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2014 15:41:17 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47039 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754708AbaIPTlQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:16 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Sep 2014 15:41:16 EDT
X-AuditID: 1207440c-f79036d000005e77-f7-541890b63d51
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E7.8C.24183.6B098145; Tue, 16 Sep 2014 15:34:14 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBc4001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:12 -0400
X-Mailer: git-send-email 2.1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqLttgkSIwYIb+hZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdseBFA3PBfcWK93P+Mjcw/pDsYuTkkBAwkdh7Yh4j
	hC0mceHeerYuRi4OIYHLjBLblneyQzgnmCQuNu0Bq2IT0JVY1NPMBJIQEWhjlNh1cTMriMMs
	0M0o8f7EaSaQKmEBO4kLcy4CzeLgYBFQlZi4JBIkzCvgInF5zS1miHVyEht2/2eEiAtKnJz5
	hAWknFlAXWL9PCGQMLOAvETz1tnMExj5ZiGpmoVQNQtJ1QJG5lWMcok5pbm6uYmZOcWpybrF
	yYl5ealFuoZ6uZkleqkppZsYIWHNs4Px2zqZQ4wCHIxKPLwf7ouHCLEmlhVX5h5ilORgUhLl
	/dctESLEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPeHL1CONyWxsiq1KB8mJc3BoiTOq7pE3U9I
	ID2xJDU7NbUgtQgmK8PBoSTBO68fqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMe
	FHnxxcDYA0nxAO39CNLOW1yQmAsUhWg9xWjM8W/5h14mjnWd3/qZhFjy8vNSpcR5bUBKBUBK
	M0rz4BbBEtorRnGgv4V5t4BU8QCTIdy8V0CrmIBWne0RA1lVkoiQkmpg1MoUWVm7cklu/57W
	9p8FsQ/kVP+VH5X3cQ6J+6mXt2PGCn/t+Vt/iKUd//u5uOX8oob4rp+H/v9ikj5l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257159>

Next iteration of my lockfile fixes and refactoring. Thanks to
Torsten B=C3=B6gershausen, Junio, Peff, Ronnie Sahlberg, and Johannes S=
ixt
for their comments about v4.

I believe that this series addresses all of the comments from v1 [1],
v2 [2], v3 [3], and v4 [4].

Changes since v4:

* Rebase to current master.

* Explain lock_file ownership and the point of its pid field.

* Correct the log message for

    "delete_ref_loose(): don't muck around in the lock_file's filename"

* Replace an assert() with a die("BUG:").

* Add a sanity check that lk->filename is empty before reusing a
  lock_file object.

* Initialize the length of lk->filename more intelligently.

* Rename trim_last_path_elm() to trim_last_path_component().

* Make some die() messages more informative.

* Add some sanity checks to commit_lock_file().

* Rename REF_NODEREF to REF_NO_DEREF.

* Rename some static functions:
  * remove_lock_file() -> remove_lock_files()
  * remove_lock_file_on_signal() -> remove_lock_files_on_signal()

* Add a function get_locked_file_path(), to isolate callers a bit more
  from the innards of lock_file.

There are some conflicts with branch rs/ref-transaction; I pushed my
proposed merge of these two branches to

    https://github.com/mhagger/git.git lock-correctness-v5-rs-ref-trans=
action

[1] http://thread.gmane.org/gmane.comp.version-control.git/245609
[2] http://thread.gmane.org/gmane.comp.version-control.git/245801
[3] http://thread.gmane.org/gmane.comp.version-control.git/246222
[4] http://thread.gmane.org/gmane.comp.version-control.git/256564

Michael Haggerty (35):
  unable_to_lock_die(): rename function from unable_to_lock_index_die()
  api-lockfile: expand the documentation
  rollback_lock_file(): do not clear filename redundantly
  rollback_lock_file(): exit early if lock is not active
  rollback_lock_file(): set fd to -1
  lockfile: unlock file if lockfile permissions cannot be adjusted
  hold_lock_file_for_append(): release lock on errors
  lock_file(): always add lock_file object to lock_file_list
  lockfile.c: document the various states of lock_file objects
  cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
  delete_ref_loose(): don't muck around in the lock_file's filename
  prepare_index(): declare return value to be (const char *)
  write_packed_entry_fn(): convert cb_data into a (const int *)
  lock_file(): exit early if lockfile cannot be opened
  remove_lock_file(): call rollback_lock_file()
  commit_lock_file(): inline temporary variable
  commit_lock_file(): die() if called for unlocked lockfile object
  commit_lock_file(): if close fails, roll back
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

 Documentation/technical/api-lockfile.txt |  72 +++++--
 builtin/commit.c                         |  16 +-
 builtin/merge.c                          |  15 +-
 builtin/reflog.c                         |   2 +-
 builtin/update-index.c                   |   2 +-
 cache.h                                  |  19 +-
 config.c                                 |  28 +--
 fast-import.c                            |   4 +-
 lockfile.c                               | 334 +++++++++++++++++++----=
--------
 read-cache.c                             |  12 +-
 refs.c                                   |  29 +--
 shallow.c                                |   6 +-
 12 files changed, 334 insertions(+), 205 deletions(-)

--=20
2.1.0
