From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Rename ONE_FILESYSTEM to DISCOVERY_ACROSS_FILESYSTEM
Date: Sun, 04 Apr 2010 15:30:24 -0700
Message-ID: <7vzl1iyhof.fsf_-_@alter.siamese.dyndns.org>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
 <20100328092253.GA17563@coredump.intra.peff.net>
 <7vr5n44crq.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
 <20100330230211.GC608@coredump.intra.peff.net>
 <alpine.LFD.2.00.1003301610151.3707@i5.linux-foundation.org>
 <40aa078e1003301754u3a1e5e9je7bb2aa2dc04f6a1@mail.gmail.com>
 <7v4ojr85ee.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: "Lars R. Damerow" <lars@pixar.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 00:30:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyYL6-0006Ep-JW
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab0DDWal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 18:30:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0DDWaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:30:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28085A8AA7;
	Sun,  4 Apr 2010 18:30:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dqv6iBJbqTfs89HVmTnlNMBMubI=; b=lNGVqQ
	gGl/uC111s5VQt41o5RIPyST2LMFYpa3t/CPCJoBhmbolRtF3WcLPqHUxjpKAUpd
	5Xj90HFKnSp4CXorR1G1j9napqLHXTDOSSKo47319/a1iOCtUUPuDPuA0nf3J9a0
	1Mmh1pVDjJcXxXVP4bav5hU70bTAa1cg3VMgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DexIuXRitZzfYg0e4nd1CRyLr7N4SuJA
	9hljHf0G3/VqOT9Dz3FHXXXIq8opWvbVxkkOQXdv6AWzAWYXHsjee0TNUCFNxGH8
	Dw4SPtK4ioyj7TSI0M7EKlCnh+R1HTsfjr1bRFYzuTcZYwsdZPSKvco2hCzVIr4B
	arzd2/DmMP0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79EEBA8AA2;
	Sun,  4 Apr 2010 18:30:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C5A8A8AA0; Sun,  4 Apr
 2010 18:30:25 -0400 (EDT)
In-Reply-To: <7v4ojr85ee.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 04 Apr 2010 11\:00\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD9C9D5E-4039-11DF-9908-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143956>

If a missing ONE_FILESYSTEM defaults to true, the only users who set this
variable set it to false to tell git not to limit the discovery to one
filesystem; there are too many negations in one sentence to make a simple
panda brain dizzy.

Use the variable GIT_DISCOVERY_ACROSS_FILESYSTEM that changes the
behaviour from the default "limit to one filesystem" to "cross the
boundary as I ask you to"; makes the semantics much more straight
forward.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/git.txt |   10 +++++-----
 setup.c               |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index aa62083..eb78a2b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -530,15 +530,15 @@ git so take care if using Cogito etc.
 	a GIT_DIR set on the command line or in the environment.
 	(Useful for excluding slow-loading network directories.)
 
-'GIT_ONE_FILESYSTEM'::
+'GIT_DISCOVERY_ACROSS_FILESYSTEM'::
 	When run in a directory that does not have ".git" repository
 	directory, git tries to find such a directory in the parent
 	directories to find the top of the working tree, but by default it
 	does not cross filesystem boundaries.  This environment variable
-	can be set to false value ("false" or zero) to tell git not to
-	stop at filesystem boundaries.  Like 'GIT_CEILING_DIRECTORIES',
-	this will not affect an explicit respository directory set via
-	'GIT_DIR' or on the command line.
+	can be set to true to tell git not to stop at filesystem
+	boundaries.  Like 'GIT_CEILING_DIRECTORIES', this will not affect
+	an explicit respository directory set via 'GIT_DIR' or on the
+	command line.
 
 git Commits
 ~~~~~~~~~~~
diff --git a/setup.c b/setup.c
index d290633..5a26b5b 100644
--- a/setup.c
+++ b/setup.c
@@ -392,7 +392,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 *   etc.
 	 */
 	offset = len = strlen(cwd);
-	one_filesystem = git_env_bool("GIT_ONE_FILESYSTEM", 0);
+	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
 	if (one_filesystem) {
 		if (stat(".", &buf))
 			die_errno("failed to stat '.'");
-- 
1.7.0.4.552.gc303c1
