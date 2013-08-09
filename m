From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Remove old forgotten command: whatchanged
Date: Fri, 09 Aug 2013 10:29:28 +0200
Message-ID: <vpqbo57clnb.fsf@anie.imag.fr>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr> <ku0lqj$qvs$1@ger.gmane.org>
	<vpqk3jwcb1q.fsf@anie.imag.fr>
	<7v1u649e5m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Damien Robert <damien.olivier.robert+gmane@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 10:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7i58-0002Hz-Db
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 10:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614Ab3HII3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 04:29:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36199 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030522Ab3HII3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 04:29:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r798TR4Y025379
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Aug 2013 10:29:28 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7i4e-0004e2-T2; Fri, 09 Aug 2013 10:29:28 +0200
In-Reply-To: <7v1u649e5m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Aug 2013 12:27:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 09 Aug 2013 10:29:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r798TR4Y025379
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376641774.13932@KHwHToMSXj+9uXOoNyqtUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231963>

Junio C Hamano <gitster@pobox.com> writes:

> It is meant to teach them "if you want to do your own 'git log', you
> can do so with 'rev-list' piped to 'diff-tree --stdin'".  Changing
> 'whatchanged' to 'log' in the latter statement is an improvement,
> but dropping 'can be done by combining rev-list and diff-tree' goes
> against the objective of the whole document.

Then, we can keep the "In fact, together with the 'git rev-list'
program ..." sentence, but drop "A trivial (but very useful)
script ...", which is both technically incorrect (whatchanged is not a
script anymore) and misleading because it advertises whatchanged.

That would look like this:

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3bdd56e..486a58b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -818,7 +818,7 @@ for further details.
 'GIT_FLUSH'::
        If this environment variable is set to "1", then commands such
        as 'git blame' (in incremental mode), 'git rev-list', 'git log',
-       'git check-attr', 'git check-ignore', and 'git whatchanged' will
+       'git check-attr', and 'git check-ignore' will
        force a flush of the output stream after each record have been
        flushed. If this
        variable is set to "0", the output of these commands will be done
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index f538a87..8e53560 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -534,9 +534,8 @@ all, but just show the actual commit message.
 
 In fact, together with the 'git rev-list' program (which generates a
 list of revisions), 'git diff-tree' ends up being a veritable fount of
-changes. A trivial (but very useful) script called 'git whatchanged' is
-included with Git which does exactly this, and shows a log of recent
-activities.
+changes. The porcelain command 'git log' can also be used to display
+changes introduced by some commits.
 
 To see the whole history of our pitiful little git-tutorial project, you
 can do
@@ -546,11 +545,10 @@ $ git log
 ----------------
 
 which shows just the log messages, or if we want to see the log together
-with the associated patches use the more complex (and much more
-powerful)
+with the associated patches, use the `--patch` option:
 
 ----------------
-$ git whatchanged -p
+$ git log -p
 ----------------
 
 and you will see exactly what has changed in the repository over its

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
