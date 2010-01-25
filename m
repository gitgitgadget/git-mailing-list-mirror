From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2010, #08; Sun, 24)
Date: Sun, 24 Jan 2010 20:39:38 -0800
Message-ID: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 05:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZGjx-0002jc-Hx
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 05:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0AYEjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 23:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658Ab0AYEjo
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 23:39:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0AYEjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 23:39:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B550945AB;
	Sun, 24 Jan 2010 23:39:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=I810
	jwuTA6yecj3U+k7orH1wGBE=; b=MUlKkB2QG7+jQzie0T/H0gyjo87wqEgskb0T
	YCDD9vJW2kEPI4TOPylaE1A7LfQlMMRHKYFqMDV7Wsw4dJmhZaSZWvz31iCQUZF5
	0ylGpcBUdXV06xro16dY81T3jn8/uReTlMUvXgEhgFL/lYZTEcPUet+m37Kz3O52
	bp1FPkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=a5B
	esoxM+QfPLZVaI9Oxn0VkT6oSb0yT7fY7qb+WnjWELBRFwP7nDZwuM0Y284IPTO+
	Or/khPg4luV2+x3rpUKd/DHkzopEKhwTou+XEVF67W4AGdI6kfH/prsrSwoyjrZV
	6VVyzUTldNUSKgGfYmdsQ+pq+LX4b4A15EltgaiQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 790C9945AA;
	Sun, 24 Jan 2010 23:39:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEE62945A9; Sun, 24 Jan
 2010 23:39:39 -0500 (EST)
X-master-at: b2c2e4c22c6a4fe151f02380d247cf3d9a9d5d1e
X-next-at: ab82714c66789f07812b3c1c723004a10b67a882
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A723153E-096B-11DF-85F5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137936>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* jc/fix-tree-walk (2009-09-14) 7 commits
  (merged to 'next' on 2010-01-13 at 1c01b87)
 + read-tree --debug-unpack
 + unpack-trees.c: look ahead in the index
 + unpack-trees.c: prepare for looking ahead in the index
 + Aggressive three-way merge: fix D/F case
 + traverse_trees(): handle D/F conflict case sanely
 + more D/F conflict tests
 + tests: move convenience regexp to match object names to test-lib.sh

This is fix for a tricky codepath; I've been using this personally during
the whole cycle up to point, so hopefully it finally have nailed all the
corner cases?  Knock wood...

--------------------------------------------------
[New Topics]

* cc/reset-keep (2010-01-19) 5 commits
 - reset: disallow using --keep when there are unmerged entries
 - reset: disallow "reset --keep" outside a work tree
 - Documentation: reset: describe new "--keep" option
 - reset: add test cases for "--keep" option
 - reset: add option "--keep" to "git reset"

I do not think I'd ever use this, and I am not convinced I can sell this
to users as a great new feature without confusing them unnecessarily, but
perhaps queuing it to pu to give it wider visibility may help somebody
coming up with a better way to defend the feature and introduce it to
users without confusing them than Christan nor I managed to.

* jc/ce-uptodate (2010-01-24) 1 commit
 - Make ce_uptodate() trustworthy again

I think this and Jens Lehmann's follow-up patch to avoid calling
is_submodule_modified() are needed before 1.7.0

--------------------------------------------------
[Cooking]

* jh/notes (2010-01-17) 20 commits
 - builtin-gc: Teach the new --notes option to garbage-collect notes
 - Notes API: gc_notes(): Prune notes that belong to non-existing objects
 - t3305: Verify that removing notes triggers automatic fanout consolidation
 - builtin-notes: Teach -d option for deleting existing notes
 - Teach builtin-notes to remove empty notes
 - Teach notes code to properly preserve non-notes in the notes tree
 - t3305: Verify that adding many notes with git-notes triggers increased fanout
 - t3301: Verify successful annotation of non-commits
 - Builtin-ify git-notes
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: write_notes_tree(): Store the notes tree in the database
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: remove_note(): Remove note objects from the notes tree structure
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 - Minor non-functional fixes to notes.c

The changes to test vector this series makes to t3301 breaks tests that
are in 'master', so 'pu' doesn't pass it.

* jh/gitweb-cached (2010-01-13) 9 commits
 - gitweb: File based caching layer (from git.kernel.org)
 - gitweb: Convert output to using indirect file handle
 - gitweb: cleanup error message produced by undefined $site_header
 - gitweb: add a get function to compliment print_sort_th
 - gitweb: add a get function to compliment print_local_time
 - gitweb: Makefile improvements
 - gitweb: Add option to force version match
 - gitweb: change die_error to take "extra" argument for extended die information
 - gitweb: Load checking

I know there is a series to split the later ones into smaller chunks that
are being discussed on the list, but they don't appear here.  I'd prefer
to pick the series up after all the dust from the discussion settles.

* jc/grep-author-all-match-implicit (2010-01-17) 1 commit
 - "log --author=me --grep=it" should find intersection, not union
