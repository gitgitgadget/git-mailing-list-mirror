From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v5 0/4] Detection of directory renames
Date: Sat,  9 Oct 2010 23:31:31 +0200
Message-ID: <1286659895-1813-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 23:21:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4grB-0007q4-22
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 23:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab0JIVVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 17:21:16 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from smtp5-g21.free.fr ([212.27.42.5]:50651 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab0JIVVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 17:21:15 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id DEBAFD4809C;
	Sat,  9 Oct 2010 23:21:09 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P4h0z-0000Tr-L3; Sat, 09 Oct 2010 23:31:37 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158623>

Evolutions from v4 to v5:

(Jonathan Nieder) use memcpy, not strncpy overkill
(Jonathan Nieder) split 2 funcs out of diffcore_bulk_renames
(Jonathan Nieder) more comments
(Jonathan Nieder) avoid allocating often-useless filespec too early
(Jonathan Nieder) split into new func
(=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) convert C99 comments intended =
to stay to C89 ones

(Jonathan Nieder, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) reworked styl=
e of test script
(Jonathan Nieder, Sverre Rabbelier) use compare_diff_raw, not compare_d=
iff_patch;
	anonymize hashes and scores
(Jonathan Nieder) use "git commit" in test instead of only plumbing, an=
d use test_tick

listed a number of additional FIXME's
changed wording "factorization" -> "bulk move"
changed --detect-dir-renames to --detect-bulk-moves and
	--hide-dir-rename-details to --hide-bulk-move-details
first attempt at showing the "/*" suffix in bulk moves, for comment
stop maintaining testcases for --hide-bulk-move-details, I'm just keepi=
ng
	the patch adding the flag in sync with other code changes anyway.


Yann Dirson (4):
  Introduce bulk-move detection in diffcore.
  Add testcases for the --detect-bulk-moves diffcore flag.
  [RFC] Only show bulkmoves in output.
  [RFC] Allow hiding renames of individual files involved in a
    directory rename.

 diff-lib.c                       |    6 +-
 diff.c                           |   12 ++
 diff.h                           |    6 +
 diffcore-rename.c                |  349 ++++++++++++++++++++++++++++++=
+++++++-
 diffcore.h                       |    1 +
 t/t4046-diff-rename-factorize.sh |  251 +++++++++++++++++++++++++++
 tree-diff.c                      |    4 +-
 7 files changed, 617 insertions(+), 12 deletions(-)
 create mode 100755 t/t4046-diff-rename-factorize.sh

--=20
1.7.2.3
