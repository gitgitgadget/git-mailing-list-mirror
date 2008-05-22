From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Forwarding Sverre's "merge --ff=<allow,only,never>"
 series
Date: Wed, 21 May 2008 18:16:43 -0700
Message-ID: <1211419009-9741-1-git-send-email-gitster@pobox.com>
Cc: Sverre Hvammen Johansen <hvammen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 03:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyzRJ-0002Gi-Be
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 03:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762372AbYEVBQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 21:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762338AbYEVBQ6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 21:16:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334AbYEVBQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 21:16:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F4436845
	for <git@vger.kernel.org>; Wed, 21 May 2008 21:16:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B2FC16843 for <git@vger.kernel.org>; Wed, 21 May 2008 21:16:53 -0400
 (EDT)
X-Mailer: git-send-email 1.5.5.1.499.g878b8
X-Pobox-Relay-ID: C47AA80C-279C-11DD-B8C8-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82592>

A few weeks ago Sverre's "merge --ff=<allow,only,never>" series was
re-sent to the list but as 6 attachments to a single mail.  The format was
unfortunate and nobody seems to have bothered to read nor comment on.

I think the early patches in the series are at least worth keeping and the
overall series deserves some attention from the list, so I am re-injecting
them in format that can hopefully be commented on and tried out as a
public service ;-) I am tempted to apply up to [3/6] after another round
of reading myself.

A few minor nits I already have:

 [2/6]

"diff -u" in verify_diff() should be "test_cmp":

@@ -254,7 +254,7 @@
 +}
 +
 +verify_diff() {
-+      if ! diff -u "$1" "$2"
++      if ! test_cmp "$1" "$2"
 +      then
 +              echo "$3"
 +              false

 [3/6] 

The argument to --ff is optional (log message):

---ff now takes an argument allowing --ff to be written
-as --ff=allow and -no-ff to be written as --ff=never.
-This change allow other fast forward options to be
-introduced later.
-
-See the documentation for a further explanation of these options.
+The --ff flag now takes an optional argument, allowing --ff to be
+written as --ff=allow and -no-ff to be written as --ff=never. This
+allows other fast forward options to be introduced later.

Also, you usually should not say 'see doc for details' in commit log, as
it does not help anybody.  Either you convince others that your patch is
worth reading by your commit log message alone, or you don't.

Grammar.

 +The first merge of topicA or the only merge of topicB would have
-+resulted in a fast forward without '--ff=never'.  Topic A consist of
++resulted in a fast forward without '--ff=never'.  Topic A consists of
 +those commits that can be reached from master^2 without passing

 [4/6]

Grammar.

 +# Find reduced parents
-+# The following variables are set as follow:
++# The following variables are set as follows:
 +#   reduced_parents: The reduced parents of those specified on the
 command line.

 [6/6]

Commit log:

 instead of a real merge.  This option can then be used to
 avoid an accidental merge.
 
-See the documentation for further details.
-
