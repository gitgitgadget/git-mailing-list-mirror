From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2012, #03; Mon, 5)
Date: Mon, 05 Mar 2012 23:15:12 -0800
Message-ID: <7vmx7uurnj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 08:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4ocj-0000w2-0i
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 08:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab2CFHPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 02:15:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755353Ab2CFHPQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 02:15:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58F8D3302;
	Tue,  6 Mar 2012 02:15:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ChUcU9aXpDdoo+y0FDE7dK8wW
	VU=; b=h598J8HCzMmKUpJKRn+9s8GRTwKEMJpcmsE/TH8NGfSaiL3vdgdRH1rfk
	G9q5wM8bMP6R757vuO1IApaVPa0ZPNinY7i9D24Ltx8lOfDXuMvPpE3jGqO4h4Lb
	gXMqdscy+yYPoK/Fep0UQ/Y6h4m1/qaTi9xUpUdlVRR6PvZtRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=xSxE8vcTRJcobMYL2fl
	fACH3X3D5YTtL/Hczwhw/Xw/OaflU9Vv3kLIeQ0rKvHVCyit/yg4VTtm9hsC0rFe
	5STMp5nVi7hIIxqGy/lhx6NBuaavxBYFDJ2UiMIPa3H2LQ8v6b0GwrwyBJs9dcpl
	UrKeu8joEsUkrARWNAve5dA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DA923301;
	Tue,  6 Mar 2012 02:15:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD06132FF; Tue,  6 Mar 2012
 02:15:13 -0500 (EST)
X-master-at: 2980b0de1b387e4f9a63c50ca741271990c849d5
X-next-at: 38de349d595af3563cafab5297cbad2f3e920499
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E157F74-675C-11E1-B622-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192306>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

The tip of 'next' as of tonight is more or less how 1.7.10-rc0 will
look like in a few days.  I do not have enough confidence on other
large-ish topics that are not yet in 'next' to include in them in
the upcoming release.

Small, trivially correct topics that have high value/damage ratio
however may have enough time to go in 1.7.10 final even if they are
still in 'pu', if the owners put enough effort in them.  Otherwise
let's throw them into Stalled category and leave them to the next
cycle.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/fmt-merge-msg-people (2012-03-05) 1 commit
  (merged to 'next' on 2012-03-05 at 38de349)
 + fmt-merge-msg: show those involved in a merged series

The "fmt-merge-msg" command learns to list the primary contributors
involved in the side topic you are merging.

* nl/http-proxy-more (2012-03-05) 3 commits
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not se=
t
 (this branch uses nl/http-proxy-auth.)

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.

* nd/stream-more (2012-03-05) 6 commits
 - fsck: use streaming API for writing lost-found blobs
 - show: use streaming API for showing blobs
 - parse_object: avoid putting whole blob in core
 - cat-file: use streaming API to print blobs
 - Add more large blob test cases
 - streaming: make streaming-write-entry to be more reusable

As I do not think changes in the original larger series that touch
index-pack and unpack-objects will be ready for the upcoming 1.7.10,
I've picked up only bits that deal with "use streaming API instead
of reading things in core" and minimally fixed them up.  These we
should be able to polish in time.

The "test cases" patch needs to be trimmed to cover only these, I
would think.

--------------------------------------------------
[Stalled]

* nd/optim-connected (2012-02-29) 1 commit
 - Perform cheaper connectivity check when pack is used as medium

Cheats the local connectivity check performed by "git fetch"
slightly to gain some performance. This is a bit iffy.

* jc/diff-ignore-mode (2012-03-01) 1 commit
 - diff --ignore-mode-change
 (this branch uses jc/maint-diff-patch-header.)

Will discard.

* nd/columns (2012-02-28) 10 commits
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add column.ui for default column output settings
 - column: add dense layout support
 - column: add columnar layout
 - Stop starting pager recursively
 - Add git-column for columnar display

Rerolled; the configuration handling looked iffy, but otherwise well
explained.

* jc/diff-ignore-case (2012-02-28) 6 commits
 - diff: -i is "--ignore-case" but means a bit more in "log"
 - diff: --ignore-case
 - xdiff: introduce XDF_IGNORE_CASE
 - xdiff: introduce XDF_INEXACT_MATCH
 - xdiff: PATIENCE/HISTOGRAM are not independent option bits
 - xdiff: remove XDL_PATCH_* macros

"git diff" learns "--ignore-case" option.
Will discard, as nobody seems to need this.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so
that somebody new can try to dip his or her toes in the
development. Any takers?

* jh/trace-use-startup-info (2012-03-02) 1 commit
 - Use startup_info->prefix rather than prefix.

I tend to agree with the doubt of the author of this patch expressed.

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments
from =C3=86var. The second one needs more work, both in perl/Git.pm and
prompt.c, to give precedence to tty over SSH_ASKPASS when terminal
is available.

* jc/split-blob (2012-02-23) 7 commits
 - fixup?
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* cn/pull-rebase-message (2012-03-04) 1 commit
  (merged to 'next' on 2012-03-04 at 5a6cd58)
 + Make git-{pull,rebase} message without tracking information friendli=
er

The advise message given when the user didn't give enough clue on what
to merge was overly long.
Will merge to 'master'.

* dg/test-from-elsewhere (2012-03-04) 2 commits
 - Support out-of-tree Valgrind tests
 - Allow overriding GIT_BUILD_DIR

Better support for out-of-tree test scripts.

* jh/threadable-symlink-check (2012-03-02) 1 commit
  (merged to 'next' on 2012-03-05 at fdd667c)
 + Add threaded versions of functions in symlinks.c.

It probably is "threadble" not "threaded" but in any case this
should not regress the current callers.

* jn/maint-do-not-match-with-unsanitized-searchtext (2012-03-04) 1 comm=
it
 - gitweb: Fix fixed string (non-regexp) project search

"gitweb" did use quotemeta() to prepare search string when asked to
do a fixed-string project search, but did not use it by mistake and
used the user-supplied string instead.

I would love to see this in 1.7.10; what I queued for 'maint' (that
does not have the lazy fill-info stuff), and my conflict resolution
into 'pu' to adjust for lazy fill-info, are both correct, I think,
but please double check.

* nl/http-proxy-auth (2012-03-02) 1 commit
  (merged to 'next' on 2012-03-04 at f368669)
 + http: support proxies that require authentication
 (this branch is used by nl/http-proxy-more.)

Allow curl-based transport to use proxies that require authentication.
Will merge to 'master'.

* sl/modern-t0000 (2012-03-02) 1 commit
  (merged to 'next' on 2012-03-04 at 2cd1508)
 + t0000: modernise style

Will merge to 'master'.

* th/mergetools-deltawalker (2012-03-05) 1 commit
  (merged to 'next' on 2012-03-05 at 167c74f)
 + mergetools: add a plug-in to support DeltaWalker

Add plug-in to support DeltaWalker in difftool/mergetool. =20
Will merge to 'master'.

* jl/maint-submodule-relative (2012-03-04) 4 commits
 - submodules: fix ambiguous absolute paths under Windows
 - submodules: refactor computation of relative gitdir path
 - submodules: always use a relative path from gitdir to work tree
 - submodules: always use a relative path to gitdir

Rerolled and resurrected from Stalled category.

I would love to have this in 1.7.10; a couple of Acks from different
platforms and success reports would be very helpful.

* nd/threaded-index-pack (2012-03-02) 2 commits
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function

Rerolled to fix a bug that was discovered with a trivial test, and
resurrected from Stalled category, but I am reluctant to advance a
topic that can easily break many people's repositories at this late
in the cycle.

* jc/maint-diff-patch-header (2012-03-01) 3 commits
  (merged to 'next' on 2012-03-02 at 2cd2059)
 + diff -p: squelch "diff --git" header for stat-dirty paths
 + t4011: illustrate "diff-index -p" on stat-dirty paths
 + t4011: modernise style
 (this branch is used by jc/diff-ignore-mode.)

"diff-index" and friends showed "diff --git" header and nothing else
for a path that is only stat-dirty.

Should be safe, but is not urgent.

* tr/maint-bundle-boundary (2012-03-01) 3 commits
  (merged to 'next' on 2012-03-02 at c25692f)
 + bundle: keep around names passed to add_pending_object()
 + t5510: ensure we stay in the toplevel test dir
 + t5510: refactor bundle->pack conversion

"git bundle" did not record boundary commits correctly when there
are many of them.

Will merge to 'master'.

* jc/pickaxe-ignore-case (2012-03-04) 3 commits
  (merged to 'next' on 2012-03-04 at 1ad3a39)
 + ctype.c: Fix a sparse warning
  (merged to 'next' on 2012-03-02 at 73a632b)
 + pickaxe: allow -i to search in patch case-insensitively
 + grep: use static trans-case table

"git log -G/-S" pays attention to the "-i" option.

Will merge to 'master'.

* zj/diff-stat-dyncol (2012-03-01) 10 commits
  (merged to 'next' on 2012-03-01 at 79b4152)
 + diff --stat: add config option to limit graph width
 + diff --stat: enable limiting of the graph part
 + diff --stat: add a test for output with COLUMNS=3D40
 + diff --stat: use a maximum of 5/8 for the filename part
 + merge --stat: use the full terminal width
 + log --stat: use the full terminal width
 + show --stat: use the full terminal width
 + diff --stat: use the full terminal width
 + diff --stat: tests for long filenames and big change counts
 + Merge branches zj/decimal-width, zj/term-columns and jc/diff-stat-sc=
aler

Rerolled again and looking good.
Will merge to 'master'.
