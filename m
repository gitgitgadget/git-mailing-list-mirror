From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Sat, 01 Mar 2014 12:38:39 +0100
Message-ID: <vpqioryrvwg.fsf@anie.imag.fr>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com> <857g8f1ugu.fsf@stephe-leake.org>
	<87fvn335sm.fsf@fencepost.gnu.org> <858usvz5nj.fsf@stephe-leake.org>
	<87txbj1fnw.fsf@fencepost.gnu.org> <85zjlb1740.fsf@stephe-leake.org>
	<87eh2n16sw.fsf@fencepost.gnu.org> <85vbvyxl8i.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 12:39:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiGK-0007pT-Iy
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 12:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbaCALiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 06:38:54 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48322 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbaCALix (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 06:38:53 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s21Bccff025052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Mar 2014 12:38:38 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s21Bcdpr031219;
	Sat, 1 Mar 2014 12:38:39 +0100
In-Reply-To: <85vbvyxl8i.fsf@stephe-leake.org> (Stephen Leake's message of
	"Sat, 01 Mar 2014 04:32:29 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 01 Mar 2014 12:38:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s21Bccff025052
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394278722.77073@7tlf/Tvdmudygwvt37SAVQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243063>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> So as I understand it, this does _not_ lose your conflict resolutions.

Well, then maybe it's time to try the command before continuing
commenting on its behavior ;-).

$ git status
[...]
        both modified:      foo.txt
[...]
$ git diff
diff --cc foo.txt
index 595f399,996c0e1..0000000
--- a/foo.txt
+++ b/foo.txt
@@@ -1,1 -1,1 +1,1 @@@
- content1
 -content2
++resolved
$ git reset --merge
$ git status
On branch master
nothing to commit, working directory clean
$

> In fact, it now seems that 'git reset --mixed' is always the same as
> 'git reset --merge'. So I must be missing something!

"git reset --merge" is an alias for "git merge --abort" (IIRC, it's
actually the other way around). Essentially, it reverts, or tries to
revert everything (worktree and index) as it was before the merge. That
includes throwing away conflict resolution.

Now, I do agree that the documentation of "git reset" is terrible, and I
actually think that the command does too many different things (putting
"git reset" and "git reset --hard" so close to each other is not a good
idead IMHO: the first is a harmless command I use very often, and the
second is one of the most destructive operation Git has).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
