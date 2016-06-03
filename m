From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/13] Reference iterators
Date: Fri,  3 Jun 2016 14:33:40 +0200
Message-ID: <cover.1464957077.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oIt-0005Ac-5O
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbcFCMeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:09 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57645 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932232AbcFCMeF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:05 -0400
X-AuditID: 1207440c-c53ff70000000b85-fe-57517937ff33
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 31.57.02949.83971575; Fri,  3 Jun 2016 08:34:00 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtik005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:33:57 -0400
X-Mailer: git-send-email 2.8.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqGtRGRhu8GkWp8X8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDP2Tz7PXDBJuGLf3zbmBsYG/i5G
	Tg4JAROJHcvPMXYxcnEICWxllDh1qosZJCEkcJxJ4tqeQBCbTUBXYlFPMxOILSIQIdHwqgWs
	gVlgDpPE7YedYA3CIEXTf7CD2CwCqhJLOr8CFXFw8AqYS/R8VINYJidxefoDNhCbV0BQ4uTM
	JywgJcwC6hLr5wmBhJkF5CWat85mnsDIOwtJ1SyEqllIqhYwMq9ilEvMKc3VzU3MzClOTdYt
	Tk7My0st0jXUy80s0UtNKd3ECAlnnh2M39bJHGIU4GBU4uFdsSAgXIg1say4MvcQoyQHk5Io
	7/mzQCG+pPyUyozE4oz4otKc1OJDjBIczEoivH8KAsOFeFMSK6tSi/JhUtIcLErivKpL1P2E
	BNITS1KzU1MLUotgsjIcHEoSvD/KgRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLi
	QdEVXwyML5AUD9DezyDtvMUFiblAUYjWU4yKUuK8DCAJAZBERmke3FhYknrFKA70pTCvTwVQ
	FQ8wwcF1vwIazAQ0uOCRP8jgkkSElFQDY+ZkHcGrmZs4E0TaeJaWSnzMfFZyszHmvanDh4cc
	dQZ3Pk8+GCTwqfDeJe9rtz71mZ3awMF9jcVBY6lq31GbqN5rk9s8tdgELnsukLR5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296322>

This is v2 of a patch series to implement iteration over references
via iterators. Thanks to Ramsay, Eric, Junio, and David for their
feedback about v1 [1]. I think I have addressed all of the points that
were raised.

Changes from v1 -> v2:

* In "refs: introduce an iterator interface":

  * Fix some comments.

  * Remove a redundant call to `sort_ref_dir()`.

  * Rename the parameters to `overlay_ref_iterator` from `iter0` and
    `iter1` to `front` and `back`, and reverse their order.

  * Add a comment explaining why merge_ref_iterator_begin() can't do
    an is_empty_ref_iterator() optimization.

* In "dir_iterator: new API for iterating over a directory tree":

  * Fix some comments.

  * Add a warning if `lstat()` fails for a reason other than `ENOENT`.

This patch series applies on top of mh/split-under-lock. It can also
be obtained from my GitHub repo [2] as branch "ref-iterators".

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/295860
[2] https://github.com/mhagger/git

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
 dir-iterator.c       | 185 +++++++++++++++
 dir-iterator.h       |  86 +++++++
 iterator.h           |  81 +++++++
 refs.c               |  20 ++
 refs.h               | 139 +++++++-----
 refs/files-backend.c | 629 +++++++++++++++++++++++++++++++--------------------
 refs/iterator.c      | 384 +++++++++++++++++++++++++++++++
 refs/refs-internal.h | 226 +++++++++++++++++-
 11 files changed, 1440 insertions(+), 322 deletions(-)
 create mode 100644 dir-iterator.c
 create mode 100644 dir-iterator.h
 create mode 100644 iterator.h
 create mode 100644 refs/iterator.c

-- 
2.8.1
