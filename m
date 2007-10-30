From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge: inconsistent manual page.
Date: Tue, 30 Oct 2007 11:54:11 -0700
Message-ID: <7vk5p4l9gs.fsf@gitster.siamese.dyndns.org>
References: <fg7b6o$k1f$1@ger.gmane.org>
	<7vsl3sla5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwET-0000Fq-0d
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbXJ3SyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbXJ3SyT
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:54:19 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:40842 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbXJ3SyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:54:18 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 87CB62FB;
	Tue, 30 Oct 2007 14:54:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E552C90495;
	Tue, 30 Oct 2007 14:54:34 -0400 (EDT)
In-Reply-To: <7vsl3sla5q.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 30 Oct 2007 11:39:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62729>

Subject: git-merge: document but discourage the historical syntax

Historically "git merge" took its command line arguments in a
rather strange order.  Document the historical syntax, and also
document clearly that it is not encouraged in new scripts.

There is no reason to deprecate the historical syntax, as the
current code can sanely tell which syntax the caller is using,
and existing scripts by people do use the historical syntax.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Junio C Hamano <gitster@pobox.com> writes:

  > See above.  We do not want to advertise the crazy syntax.

  By the way, I kept saying "crazy" above, but the thing is that
  when Linus did that "crazy" syntax, it was not crazy at all.
  Simply it did not matter, as nobody was supposed to use "git
  merge" from the command line.

  Instead, when merging a local branch, you would just have said:

          $ git pull . $my_other_branch

  It became a "crazy historical syntax" only after people started
  talking about using it from the command line, giving it other
  command line options.  And at that point, we introduced -m flag
  and stopped requiring the second token 'HEAD'.

  With that in mind, this might be a better alternative.

 Documentation/git-merge.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index bca4212..a056b40 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git-merge' [-n] [--summary] [--no-commit] [--squash] [-s <strategy>]...
 	[-m <msg>] <remote> <remote>...
+'git-merge' <msg> HEAD <remote>...
 
 DESCRIPTION
 -----------
@@ -43,6 +44,11 @@ If you tried a merge which resulted in a complex conflicts and
 would want to start over, you can recover with
 gitlink:git-reset[1].
 
+The second syntax (<msg> `HEAD` <remote>) is supported for
+historical reasons.  Do not use it from the command line or in
+new scripts.
+
+
 CONFIGURATION
 -------------
 
