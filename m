From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebase/cherry-picking idea
Date: Wed, 28 Nov 2007 00:06:41 -0800
Message-ID: <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	<Pine.LNX.4.64.0711261340470.27959@racer.site>
	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:25:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKv8-0004Ah-Rn
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:34 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxI2m-00039z-Ll
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:13:16 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxI1f-0006xT-Mz
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbXK1IGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 03:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbXK1IGv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 03:06:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36474 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbXK1IGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 03:06:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BE13D2F0;
	Wed, 28 Nov 2007 03:07:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EC99899797;
	Wed, 28 Nov 2007 03:07:04 -0500 (EST)
In-Reply-To: <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com> (Wincent
	Colaiuta's message of "Mon, 26 Nov 2007 14:55:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, AWL=1.995,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 16498089400F62B7B433A27A77563662591AA04E
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -49 maxlevel 200 minaction 2 bait 0 mail/h: 29 total 724100 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66324>

> Once I get a clear idea of what kind of change is likely to actually  
> get accepted I'll submit a proper patch.

Too often, people disappear with a patch that is basically good but has
room for improvements this way.  I really do not have time nor bandwidth
to keep bugging them for updates, and often end up cleaning up on my own
instead.

This is such a patch, and without acks or comments, it is also very
likely to be lost.

-- >8 --
revert/cherry-pick: Allow overriding the help text by the calling Porcelain

A Porcelain command that uses cherry-pick or revert may make a commit
out of resolved index itself, in which case telling the user to commit
the result is not appropriate at all.  This allows GIT_CHERRY_PICK_HELP
environment variable to be set by the calling Porcelain in order to
override the built-in help text.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I suspect that "git rebase --continue" can do "git add -u" itself,
   just like recent "git rebase --skip" would do "git reset --hard".

   The overriding help text in this patch can lose its second line that
   tells the user to use "git add <paths>" if we decide to do so.

 builtin-revert.c           |   33 +++++++++++++++++++++++----------
 git-rebase--interactive.sh |    5 +++++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index a0586f9..4f86178 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -224,6 +224,27 @@ static int merge_recursive(const char *base_sha1,
 	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
 }
 
+static char *help_msg(const unsigned char *sha1)
+{
+	static char helpbuf[1024];
+	char *msg = getenv("GIT_CHERRY_PICK_HELP");
+
+	if (msg)
+		return msg;
+
+	strcpy(helpbuf, "  After resolving the conflicts,\n"
+	       "mark the corrected paths with 'git add <paths>' "
+	       "and commit the result.");
+
+	if (action == CHERRY_PICK) {
+		sprintf(helpbuf + strlen(helpbuf),
+			"\nWhen commiting, use the option "
+			"'-c %s' to retain authorship and message.",
+			find_unique_abbrev(sha1, DEFAULT_ABBREV));
+	}
+	return helpbuf;
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
@@ -352,16 +373,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
 			die ("Error wrapping up %s", defmsg);
-		fprintf(stderr, "Automatic %s failed.  "
-			"After resolving the conflicts,\n"
-			"mark the corrected paths with 'git add <paths>' "
-			"and commit the result.\n", me);
-		if (action == CHERRY_PICK) {
-			fprintf(stderr, "When commiting, use the option "
-				"'-c %s' to retain authorship and message.\n",
-				find_unique_abbrev(commit->object.sha1,
-					DEFAULT_ABBREV));
-		}
+		fprintf(stderr, "Automatic %s failed.%s\n",
+			me, help_msg(commit->object.sha1));
 		exit(1);
 	}
 	if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bf44b6a..33a5d4b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -30,6 +30,11 @@ test -d "$REWRITTEN" && PRESERVE_MERGES=t
 test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=t
 
+GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
+mark the corrected paths with 'git add <paths>', and
+run 'git rebase --continue'"
+export GIT_CHERRY_PICK_HELP
+
 warn () {
 	echo "$*" >&2
 }
