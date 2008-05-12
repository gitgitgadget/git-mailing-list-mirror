From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 12 May 2008 15:03:51 -0700
Message-ID: <7vr6c7xjqw.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue May 13 00:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvg8d-00046V-Ew
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 00:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbYELWEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 18:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbYELWEE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 18:04:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbYELWEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 18:04:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 910201BB7;
	Mon, 12 May 2008 18:04:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 439FB1BB5; Mon, 12 May 2008 18:03:54 -0400 (EDT)
In-Reply-To: <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 05 May 2008 23:38:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 53874DF0-206F-11DD-843B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81957>

Junio C Hamano <gitster@pobox.com> writes:

> [Dropped]
>
> * ap/svn (Tue Apr 15 21:04:18 2008 -0400) 3 commits
>  . git-svn: add documentation for --add-author-from option.
>  . git-svn: Add --add-author-from option.
>  . git-svn: add documentation for --use-log-author option.
>
> Eric requested a new set of tests for this series which never came.  I am
> still holding onto the tip of the topic in case we can resurrect it, but
> it is not merged to 'pu'.

I usually try hard not to do this kind of thing as it would encourage a
misconception that I'll tie any and all loose ends (which I obviously do
not have infinite amount of time and energy that is necessary), but I've
decided to add a skeleton for necessary tests to get the ball rolling.

Here is a sample output from the test sequence (the log message from the
last one):

    commit 0bc699cbd72810f85a0200c7197022b50e8298ed
    Author: A U Thor <author@example.com>
    Date:   Mon May 12 21:28:26 2008 +0000

        fourth

        From: A U Thor <author@example.com>


        git-svn-id: file:///git.git/t/trash directory/svnrepo@4 23bf1e2a-19bf-478a-b023-e66a9e40421e

I am not sure if adding the "From: " line as a trailer, with two blank
line after it before the git-svn-id line, is the intended format for the
final log message.  Maybe it is meant to go before the commit log message
with a blank line after it.  Maybe it is meant to be a trailer, one blank
line before and after it and then git-svn-id line (in whcih case we have
one blank after it too many).  I genuinely do not know what is intended.

If this is the intended output, please say so.  Otherwise please fix it as
needed, and add tests for the final format specification as well, so that
later changes will not break it.

Thanks.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 12 May 2008 14:53:40 -0700
Subject: [PATCH] git-svn: add test for --add-author-from and --use-log-author

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9122-git-svn-author.sh |   73 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100755 t/t9122-git-svn-author.sh

diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
new file mode 100755
index 0000000..d9a784b
--- /dev/null
+++ b/t/t9122-git-svn-author.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description='git svn authorship'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svn repository' '
+	svn checkout "$svnrepo" work.svn &&
+	(
+		cd work.svn &&
+		echo >file
+		svn add file
+		svn commit -m "first commit" file
+	)
+
+'
+
+test_expect_success 'interact with it via git-svn' '
+
+	mkdir work.git &&
+	(
+		cd work.git &&
+		git svn init "$svnrepo"
+		git svn fetch &&
+
+		echo modification >file &&
+		test_tick &&
+		git commit -a -m second &&
+
+		test_tick &&
+		git svn dcommit &&
+
+		echo "further modification" >file &&
+		test_tick &&
+		git commit -a -m third &&
+
+		test_tick &&
+		git svn --add-author-from dcommit &&
+
+		echo "yet further modification" >file &&
+		test_tick &&
+		git commit -a -m fourth &&
+
+		test_tick &&
+		git svn --add-author-from --use-log-author dcommit &&
+
+		git log &&
+
+		git show -s HEAD^^ >../actual.2 &&
+		git show -s HEAD^  >../actual.3 &&
+		git show -s HEAD   >../actual.4
+
+	) &&
+
+	# Make sure that --add-author-from without --use-log-author
+	# did not affect the authorship information
+	myself=$(grep "^Author: " actual.2) &&
+	unaffected=$(grep "^Author: " actual.3) &&
+	test "z$myself" = "z$unaffected" &&
+
+	# Make sure lack of --add-author-from did not add cruft
+	! grep "^    From: A U Thor " actual.2 &&
+
+	# Make sure --add-author-from added cruft
+	grep "^    From: A U Thor " actual.3 &&
+	grep "^    From: A U Thor " actual.4 &&
+
+	# Make sure --add-author-from with --use-log-author affected
+	# the authorship information
+	grep "^Author: A U Thor " actual.4
+
+'
+
+test_done
-- 
1.5.5.1.328.g8abfd
