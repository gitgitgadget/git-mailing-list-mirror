From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 00/10] refs backend pre-vtable
Date: Tue, 10 Nov 2015 12:42:30 +0100
Message-ID: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7KQ-0000Mo-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbbKJLm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:42:58 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55608 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663AbbKJLmy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:42:54 -0500
X-AuditID: 12074411-f797e6d000007df3-09-5641d83b19bb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 36.2D.32243.B38D1465; Tue, 10 Nov 2015 06:42:51 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABglj4014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:42:49 -0500
X-Mailer: git-send-email 2.6.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqGt9wzHM4MMeRYv5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG2mHnV2qK37xOrA4fH3/cfmDx2zrrL7nH2YKbHs949jB4X
	Lyl77F+6jc1jwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGecmRpZ8IG/omuDVwNjL08XIyeH
	hICJxOe3V1khbDGJC/fWs3UxcnEICVxmlJh/9SYzhHOCSeLNkUYWkCo2AV2JRT3NTCC2iICa
	xMS2Q2BxZoFlTBKz9tqC2MIChhK3W/axg9gsAqoSDR87wep5Bcwl7n39wwaxTU5iyv12pgmM
	3AsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihASW4A7GGSflDjEKcDAq
	8fBafHEIE2JNLCuuzD3EKMnBpCTKu/+UY5gQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV77F0Dl
	vCmJlVWpRfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJXvfrQEMFi1LTUyvSMnNK
	ENJMHJwgw7mkRIpT81JSixJLSzLiQWEeXwwMdJAUD9BeJZB23uKCxFygKETrKUZdjifzL+1h
	EmLJy89LlRLn1QIpEgApyijNg1sBSyOvGMWBPhbmZQOp4gGmILhJr4CWMAEtWeoP8lxxSSJC
	SqqBMfPljuelu5+w/WCalu3dd7zMw7T2wTSedXOflXEoH+1oVexN+mTT9KRhSwl/wtkpq+Z+
	Np8u5xKe7y5qv7J18lmrs2tSvzSLPU6/omrMJKV1YUMTp9Prme+Z54TJum38VvLy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281108>

Another re-roll of this patch series, to address the comments of
Ramsay Jones (thanks!) about v7 [1].

This version has the following changes compared to v7:

* Drop "refs: make is_branch public" patch. This was already done
  quite a while ago:

      e7e0f26 refs.c: add a public is_branch function (2014-07-15)

* Instead of having refs-internal.h include refs.h, have the "*.c"
  files include both header files.

* Remove some unneeded includes from refs/files-backend.c.

Since patch 01/11 of v7 was omitted, the patches in this version are
numbered differently. In particular, it is now patches 01 through 07
that form the core of this patch series. The last three patches can
easily be postponed if that will speed the progress of the first
seven.

These patches are also available from my GitHub fork [2] as branch
"refs-backend-pre-vtable".

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/281057
[2] https://github.com/mhagger/git

David Turner (4):
  copy_msg(): rename to copy_reflog_msg()
  initdb: make safe_create_dir public
  files_log_ref_write: new function
  refs: break out ref conflict checks

Michael Haggerty (4):
  pack_if_possible_fn(): use ref_type() instead of is_per_worktree_ref()
  refname_is_safe(): improve docstring
  refs/refs-internal.h: new header file
  refs: split filesystem-based refs code into a new file

Ronnie Sahlberg (2):
  verify_refname_available(): rename function
  verify_refname_available(): new function

 Makefile                       |    3 +-
 builtin/init-db.c              |   12 -
 cache.h                        |    8 +
 path.c                         |   12 +
 refs.c                         | 3709 +---------------------------------------
 refs.c => refs/files-backend.c | 1286 +-------------
 refs/refs-internal.h           |  200 +++
 7 files changed, 311 insertions(+), 4919 deletions(-)
 copy refs.c => refs/files-backend.c (75%)
 create mode 100644 refs/refs-internal.h

-- 
2.6.2
