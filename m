From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/27] Clean up update-refs --stdin and implement ref_transaction
Date: Mon,  7 Apr 2014 15:47:51 +0200
Message-ID: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:48:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9uY-0002Mc-1a
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbaDGNs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:26 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48337 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755208AbaDGNsY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:24 -0400
X-AuditID: 1207440d-f79d86d0000043db-9d-5342aca7e4d5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CB.0E.17371.7ACA2435; Mon,  7 Apr 2014 09:48:23 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJa7026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:21 -0400
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqLt8jVOwweJWE4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8aT9QsYCxZIVZzrm8bYwHhFuIuRk0NCwETi+o49
	zBC2mMSFe+vZuhi5OIQELjNK3Dz/khEkISRwjEni9oRKEJtNQFdiUU8zE4gtIqAmMbHtEAtI
	A7PAFUaJKx+3s4AkhAVCJN6ePs0GYrMIqEpcezeXFcTmFXCReHZkDivENjmJk8cms05g5F7A
	yLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIySUeHcw/l8nc4hRgINRiYd3
	5SHHYCHWxLLiytxDjJIcTEqivM+XOQUL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHlWg2U401J
	rKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8K4HaRQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHhXp8MTDYQVI8QHvngu0tLkjMBYpCtJ5iVJQS5y0BSQiAJDJK
	8+DGwhLEK0ZxoC+FeTeAVPEAkwtc9yugwUxAgw1dwQaXJCKkpBoYZzwxPTp30YRVZ85fUhP7
	s0iV47T4zJ8F1hpfZE08n/buFNTvehCw+LaR7++t31Ne/jXYlrbpive2MmVeNzeDuyrtJ/MD
	jFyil/R/2sNb9/lZ6F3VuqDiI2H/Jlqwc01tEhQwuDDldIuS64pXG7N7xd+KF17z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245835>

Here is v3.  It is also available on GitHub [1].

Thanks to Junio and Brad for their comments about v2.  I think I have
addressed all of your comments (except for Junio's regrets that the
series didn't include a transactional receive-pack).

See the mailing list threads about v1 [2] and v2 [3] and the
longer-term goals of this campaign [4].

Changes since v2:

* Rebased to current master (there were no conflicts)

* Don't allow ref_transation_create() with new_sha1 set to zeros.

* Don't allow ref_transation_delete() with old_sha1 set to zeros.

* Fixed subject lines to use lower-case after the colon.

* Expanded a few commit messages, fixed a comment, and removed some
  "squash" detritus in a commit message.

Cheers,
Michael

[1] https://github.com/mhagger/git, branch ref-transactions
[2] http://thread.gmane.org/gmane.comp.version-control.git/243731
[3] http://thread.gmane.org/gmane.comp.version-control.git/244857
[4] http://article.gmane.org/gmane.comp.version-control.git/243726

Michael Haggerty (27):
  t1400: fix name and expected result of one test
  t1400: provide more usual input to the command
  parse_arg(): really test that argument is properly terminated
  t1400: add some more tests involving quoted arguments
  refs.h: rename the action_on_err constants
  update_refs(): fix constness
  update-ref --stdin: read the whole input at once
  parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue>
    twice
  update-ref.c: extract a new function, parse_refname()
  update-ref --stdin: improve error messages for invalid values
  update-ref --stdin: make error messages more consistent
  update-ref --stdin: simplify error messages for missing oldvalues
  t1400: test that stdin -z update treats empty <newvalue> as zeros
  update-ref.c: extract a new function, parse_next_sha1()
  update-ref --stdin -z: deprecate interpreting the empty string as
    zeros
  t1400: test one mistake at a time
  update-ref --stdin: improve the error message for unexpected EOF
  update-ref --stdin: harmonize error messages
  refs: add a concept of a reference transaction
  update-ref --stdin: reimplement using reference transactions
  refs: remove API function update_refs()
  struct ref_update: rename field "ref_name" to "refname"
  struct ref_update: store refname as a FLEX_ARRAY
  ref_transaction_commit(): simplify code using temporary variables
  struct ref_update: add a lock field
  struct ref_update: add a type field
  ref_transaction_commit(): work with transaction->updates in place

 Documentation/git-update-ref.txt       |  18 +-
 builtin/checkout.c                     |   2 +-
 builtin/clone.c                        |   9 +-
 builtin/merge.c                        |   6 +-
 builtin/notes.c                        |   6 +-
 builtin/reset.c                        |   6 +-
 builtin/update-ref.c                   | 425 ++++++++++++++++++++-------------
 contrib/examples/builtin-fetch--tool.c |   3 +-
 notes-cache.c                          |   2 +-
 notes-utils.c                          |   3 +-
 refs.c                                 | 195 +++++++++++----
 refs.h                                 |  94 ++++++--
 t/t1400-update-ref.sh                  | 100 +++++---
 13 files changed, 585 insertions(+), 284 deletions(-)

-- 
1.9.1
