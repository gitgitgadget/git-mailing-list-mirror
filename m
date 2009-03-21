From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] Clean up interpret_nth_last_branch feature
Date: Sat, 21 Mar 2009 15:13:32 -0700
Message-ID: <1237673619-12608-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 23:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9TF-0007RU-LJ
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbZCUWNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbZCUWNn
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:13:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZCUWNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:13:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 10BAC8390
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A2046838E for
 <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:40 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.299.gda643a
X-Pobox-Relay-ID: 88D0DB42-1665-11DE-A5CA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114076>

Dscho and Pasky seem to want to introduce %name and there were a few
discussions around this area, mostly on the syntax.

I am not personally interested in the implementation of this new feature
itself, but I would want to solidify the codepath that they will be
building on before accepting any patch for it, because I have a stake at
the overall health of the resulting code we need to maintain.

The first one is what I already sent.  The last one is a bit iffy.

Junio C Hamano (7):
  check_ref_format(): tighten refname rules
  Rename interpret/substitute nth_last_branch functions
  check-ref-format --branch: give Porcelain a way to grok branch
    shorthand
  strbuf_branchname(): a wrapper for branch name shorthands
  Fix branch -m @{-1} newname
  strbuf_check_branch_ref(): a helper to check a refname for a branch
  checkout -: make "-" to mean "previous branch" everywhere

 branch.c                   |   10 +---------
 builtin-branch.c           |   20 ++++++--------------
 builtin-check-ref-format.c |    9 +++++++++
 builtin-checkout.c         |   26 +++++++++++---------------
 builtin-merge.c            |    5 ++---
 cache.h                    |    2 +-
 refs.c                     |   12 ++++++++----
 sha1_name.c                |   33 +++++++++++++++++++--------------
 strbuf.c                   |   17 +++++++++++++++++
 strbuf.h                   |    3 +++
 10 files changed, 77 insertions(+), 60 deletions(-)
