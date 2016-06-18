Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDBB1FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbcFREP3 (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:29 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52495 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738AbcFREP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:29 -0400
X-AuditID: 12074414-62bff700000008e6-bf-5764cadd1d88
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 7F.A9.02278.DDAC4675; Sat, 18 Jun 2016 00:15:25 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJb029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:23 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/13] Reference iterators
Date:	Sat, 18 Jun 2016 06:15:06 +0200
Message-Id: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqHvvVEq4wQw+i/mbTjBadF3pZrJo
	6L3CbHF7xXxmi+4pbxktfrT0MFvMvGptceZNI6MDh8ff9x+YPHbOusvu8ax3D6PHxUvKHvuX
	bmPzWPzAy2PB8/vsHp83yQVwRHHbJCWWlAVnpufp2yVwZ7x5tIe94IpIxdn3B1kbGJcLdDFy
	ckgImEjM+becpYuRi0NIYCujxN+fk6Cck0wSvWsuMoJUsQnoSizqaWYCsUUEIiQaXrUwghQx
	C8xhkrj9sJMZJCEMVPRuwVmwBhYBVYl39xcBTeLg4BUwlzi4zxRim5zE5ekP2EBsXgFBiZMz
	n4CVMAuoS6yfJwQSZhaQl2jeOpt5AiPvLCRVsxCqZiGpWsDIvIpRLjGnNFc3NzEzpzg1Wbc4
	OTEvL7VI10IvN7NELzWldBMjJJxFdjAeOSl3iFGAg1GJhzfAPiVciDWxrLgy9xCjJAeTkijv
	lUqgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeLSeAcrwpiZVVqUX5MClpDhYlcd5vi9X9hATS
	E0tSs1NTC1KLYLIyHBxKErxLTwI1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPi
	K74YGGEgKR6gvZtA2nmLCxJzgaIQracYFaXEeReAHCQAksgozYMbC0tSrxjFgb4U5n0B0s4D
	THBw3a+ABjMBDdaclwwyuCQRISXVwDjbjre4z3btTabD0qoHflhvbFlXtt60+rqj1torJzRP
	Gc3p+qehmnWx64nTR96SqIaKmIcfm9YxpLzzY8hdutxEZUXuk53y/ws3c7wM498z6+YU+4ZD
	Cuum9Ptvucq0p8pr7dFXTOzn1f76hwQek5/hdIej1z865c77NaVmC08GHetg2pBoGKHEUpyR
	aKjFXFScCAD40XUULQMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the reroll of branch mh/ref-iterators promised and discussed
earlier [1]. There are no showstoppers here, but it would be
preferable to merge this version rather than v2.

This version squashes in Ramsay's patch [2], addresses Eric's
comments, and incorporates the whitespace fix that you made when
incorporating v2.

List of changes relative to v2:

* In "refs: introduce an iterator interface":

  * Make two vtables private.

  * Add a whitespace fix from Junio's mh/ref-iterators.

* In "dir_iterator: new API for iterating over a directory tree":

  * Add and improve some comments and docstrings.

  * Fix some formatting problems.

  * Use a for rather than a while loop in `dir_iterator_abort()` to
    improve the clarity.

  * Warn on failures of `opendir()`, `readdir()`, and `closedir()`
    that can't be explained as a simple race.

* In "for_each_reflog(): reimplement using iterators", make the vtable
  private.

These changes are also available from my GitHub fork [3] as branch
"ref-iterators".

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/296883
[2] http://thread.gmane.org/gmane.comp.version-control.git/296801
[3] https://github.com/mhagger/git

Michael Haggerty (13):
  refs: remove unnecessary "extern" keywords
  do_for_each_ref(): move docstring to the header file
  refs: use name "prefix" consistently
  delete_refs(): add a flags argument
  remote rm: handle symbolic refs correctly
  get_ref_cache(): only create an instance if there is a submodule
  entry_resolves_to_object(): rename function from
    ref_resolves_to_object()
  ref_resolves_to_object(): new function
  refs: introduce an iterator interface
  do_for_each_ref(): reimplement using reference iteration
  for_each_reflog(): don't abort for bad references
  dir_iterator: new API for iterating over a directory tree
  for_each_reflog(): reimplement using iterators

 Makefile             |   2 +
 builtin/fetch.c      |   2 +-
 builtin/remote.c     |   8 +-
 dir-iterator.c       | 202 +++++++++++++++++
 dir-iterator.h       |  87 +++++++
 iterator.h           |  81 +++++++
 refs.c               |  20 ++
 refs.h               | 139 +++++++-----
 refs/files-backend.c | 629 +++++++++++++++++++++++++++++++--------------------
 refs/iterator.c      | 384 +++++++++++++++++++++++++++++++
 refs/refs-internal.h | 226 +++++++++++++++++-
 11 files changed, 1458 insertions(+), 322 deletions(-)
 create mode 100644 dir-iterator.c
 create mode 100644 dir-iterator.h
 create mode 100644 iterator.h
 create mode 100644 refs/iterator.c

-- 
2.8.1

