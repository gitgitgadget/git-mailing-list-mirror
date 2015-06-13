From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/12] Improve "refs" module encapsulation
Date: Sat, 13 Jun 2015 16:42:03 +0200
Message-ID: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3me3-0007iJ-0j
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbbFMOmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54948 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753505AbbFMOma (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:30 -0400
X-AuditID: 1207440c-f79df6d000000d2d-53-557c414b4715
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DD.BD.03373.B414C755; Sat, 13 Jun 2015 10:42:19 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpO026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:17 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqOvtWBNq8HEVu0XXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4Mw7f2cteMJGvYvOTZ+wNjA+5uhg5OSQETCQ6dpxlh7DFJC7cW88GYgsJXGaUONTl28XI
	BWSfYJK4vO0YWIJNQFdiUU8zE4gtIqAmMbHtEAtIEbNAB6PEheXbgCZxcAgL2EocXi4AUsMi
	oCrRsq0DbAGvgLlE8/bzrBDL5CTOH//JPIGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQi
	XUO93MwSvdSU0k2MkADh2cH4bZ3MIUYBDkYlHt6M2OpQIdbEsuLK3EOMkhxMSqK8kXuAQnxJ
	+SmVGYnFGfFFpTmpxYcYJTiYlUR4BbVrQoV4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNT
	UwtSi2CyMhwcShK80g5AjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgQI8vBoY6
	SIoHaK88SDtvcUFiLlAUovUUoy7HoenX1jIJseTl56VKifNKgBQJgBRllObBrYClg1eM4kAf
	C/N6gFTxAFMJ3KRXQEuYgJa091SBLClJREhJNTCGmnR3ybAa961e4RH7b0+3TUZnbsoOjn7b
	KQlLFHTW8SgwJ17MnBulqPdWJyP9chtr2iob4erTq+a07tHIM7euY5d3DRTNv3fwWbnhlYUH
	ipdOshOU4c+07z3B7aLp07E1rTfO+1PcykUv+FmlZ0yrDtsQcqu8O/+d9dZrz+y/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271552>

This is v2 of this patch series. I think I have addressed all of the
feedback from v1 [1]. Thanks to Stefan, Peff and Junio for their
feedback.

Changes since v1:

* Change docstring for delete_ref() and a comment within the function
  definition.

* Squash together two commits dealing with the error message in
  delete_refs().

These patches are also available from my GitHub account [2] as branch
"init-delete-refs-api".

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/271017
[2] https://github.com/mhagger/git

Michael Haggerty (12):
  delete_ref(): move declaration to refs.h
  remove_branches(): remove temporary
  delete_ref(): handle special case more explicitly
  delete_refs(): new function for the refs API
  delete_refs(): improve error message
  prune_remote(): use delete_refs()
  repack_without_refs(): make function private
  initial_ref_transaction_commit(): function for initial ref creation
  refs: remove some functions from the module's public interface
  initial_ref_transaction_commit(): check for duplicate refs
  initial_ref_transaction_commit(): check for ref D/F conflicts
  refs: move the remaining ref module declarations to refs.h

 archive.c               |   1 +
 builtin/blame.c         |   1 +
 builtin/clone.c         |  19 ++++-
 builtin/fast-export.c   |   1 +
 builtin/fmt-merge-msg.c |   1 +
 builtin/init-db.c       |   1 +
 builtin/log.c           |   1 +
 builtin/remote.c        |  33 +-------
 cache.h                 |  68 ----------------
 refs.c                  | 171 ++++++++++++++++++++++++++++++++++++---
 refs.h                  | 211 +++++++++++++++++++++++++++++++-----------------
 remote-testsvn.c        |   1 +
 12 files changed, 321 insertions(+), 188 deletions(-)

-- 
2.1.4
