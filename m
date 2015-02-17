From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/13] Allow reference values to be checked in a transaction
Date: Tue, 17 Feb 2015 18:00:10 +0100
Message-ID: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlWF-0003v4-Un
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbBQRAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:00:50 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:42117 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752245AbbBQRAo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:44 -0500
X-AuditID: 1207440d-f79976d000005643-71-54e373b03ac7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BF.CC.22083.0B373E45; Tue, 17 Feb 2015 12:00:32 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXV000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:31 -0500
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqLuh+HGIwZq92hZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgz3r9dxFLwQaDiQs9NtgbGOzxdjJwcEgImErMbJrNA2GISF+6tZwOx
	hQQuM0p0tQPFuYDs40wSl7a8YwdJsAnoSizqaWYCsUUE1CQmth0Ca2YWWM0ksfUuWLOwgL/E
	s+WHwOpZBFQl3n/7yAhi8wq4SMxp7GeCWCYncf74T+YJjNwLGBlWMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuka6eVmluilppRuYoQEDe8Oxv/rZA4xCnAwKvHwWkx4FCLEmlhWXJl7iFGSg0lJ
	lDe86HGIEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeoBSgHG9KYmVValE+TEqag0VJnFdtibqf
	kEB6YklqdmpqQWoRTFaGg0NJgtcUZKhgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8
	KNDji4GhDpLiAdqrB9LOW1yQmAsUhWg9xagoJc6rAZIQAElklObBjYWlgleM4kBfCvN+KQSq
	4gGmEbjuV0CDmYAGz//zCGRwSSJCSqqBMXPxnOs/8599myAmsTl79jaPF3PrH8QuSX02P7rU
	5btd+86UPrvJj66GllVdm95clnftx5wVjUbrz21oY59ySVlo2e38Bf8kv0exq0dkCk/mOPr+
	3tLzm26ynb/S/XnzpAuL0p9NW5rq1p/bdG2G6S3fLTt384peUMrdYsO4yv1bwdcd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263964>

This is v3 of the patch series; I think I have addressed all of the
feedback raised about v1 [1] and v2 [2]. Thanks to Stefan Beller and
Junio for their feedback about v2.

There are only two significant changes since v2:

* Add a new patch [03/13] that changes a lot of "flags" variables from
  "int" to "unsigned int".

* Rework t7516:
  * Remove unneeded "test_tick".
  * Don't pass "-q" to "grep".
  * Use different tokens for the two tests to remove ambiguity.

This branch is also available in my GitHub account [3] as branch
"refs-have-new".

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/263522
[2] http://thread.gmane.org/gmane.comp.version-control.git/263718
[3] https://github.com/mhagger/git

Michael Haggerty (13):
  refs: move REF_DELETING to refs.c
  refs: remove the gap in the REF_* constant values
  refs.c: Change some "flags" to "unsigned int"
  struct ref_update: move "have_old" into "flags"
  ref_transaction_update(): remove "have_old" parameter
  ref_transaction_delete(): remove "have_old" parameter
  commit: add tests of commit races
  commit: avoid race when creating orphan commits
  ref_transaction_create(): check that new_sha1 is valid
  ref_transaction_delete(): check that old_sha1 is not null_sha1
  ref_transaction_verify(): new function to check a reference's value
  update_ref(): improve documentation
  refs.h: Remove duplication in function docstrings

 branch.c                |   5 +-
 builtin/commit.c        |   4 +-
 builtin/fetch.c         |   6 ++-
 builtin/receive-pack.c  |   5 +-
 builtin/replace.c       |   2 +-
 builtin/tag.c           |   2 +-
 builtin/update-ref.c    |  20 +++----
 cache.h                 |   2 +-
 fast-import.c           |   6 +--
 refs.c                  | 140 +++++++++++++++++++++++++++++++++---------------
 refs.h                  | 113 ++++++++++++++++++++++++++------------
 sequencer.c             |   2 +-
 t/t7516-commit-races.sh |  30 +++++++++++
 walker.c                |   2 +-
 14 files changed, 233 insertions(+), 106 deletions(-)
 create mode 100755 t/t7516-commit-races.sh

-- 
2.1.4
