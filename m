From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] Clean up interpret_nth_last_branch feature
Date: Mon, 23 Mar 2009 00:58:33 -0700
Message-ID: <cover.1237791716.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 09:01:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llf5q-0003W2-Ac
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688AbZCWH6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 03:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756369AbZCWH6r
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 03:58:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599AbZCWH6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 03:58:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B869867E
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:58:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CCECC867D for
 <git@vger.kernel.org>; Mon, 23 Mar 2009 03:58:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.349.ga64c
X-Pobox-Relay-ID: 6D28E972-1780-11DE-9EC6-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114257>

The changes since the previous round are:

 - Tightening of the refname rule comes very late in the series, so that
   we can optionally drop it;

 - In addition to allowing "git branch -d bad@{name}ref.", we also allow
   "git branch -d bad@{name}ref. good-one" as another escape hatch;

 - Update documentation to git-check-ref-format to describe the tightened
   rules.

Junio C Hamano (7):
  Rename interpret/substitute nth_last_branch functions
  strbuf_branchname(): a wrapper for branch name shorthands
  check-ref-format --branch: give Porcelain a way to grok branch
    shorthand
  Fix branch -m @{-1} newname
  strbuf_check_branch_ref(): a helper to check a refname for a branch
  check_ref_format(): tighten refname rules
  checkout -: make "-" to mean "previous branch" everywhere

 Documentation/git-check-ref-format.txt |   18 ++++++++++++++++-
 branch.c                               |   10 +--------
 builtin-branch.c                       |   32 +++++++++++++++++-------------
 builtin-check-ref-format.c             |    9 ++++++++
 builtin-checkout.c                     |   26 ++++++++++--------------
 builtin-merge.c                        |    5 +--
 cache.h                                |    2 +-
 refs.c                                 |   16 +++++++++++---
 sha1_name.c                            |   33 ++++++++++++++++++-------------
 strbuf.c                               |   17 ++++++++++++++++
 strbuf.h                               |    3 ++
 11 files changed, 110 insertions(+), 61 deletions(-)
