From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: git + unison
Date: Sun, 02 Dec 2007 18:59:36 +0100
Message-ID: <vpqd4tpgepj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 19:00:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyt76-0007G7-CY
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 19:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbXLBR76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 12:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbXLBR76
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 12:59:58 -0500
Received: from imag.imag.fr ([129.88.30.1]:33198 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbXLBR75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 12:59:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lB2HxbCW001886
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 2 Dec 2007 18:59:37 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Iyt6O-0006ZC-U0; Sun, 02 Dec 2007 18:59:36 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Iyt6O-0005La-Ra; Sun, 02 Dec 2007 18:59:36 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 02 Dec 2007 18:59:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66802>

Hi,

I'm wondering how dangerous the interaction of git with the unison
file synchronizer[1] can be.

Another way of asking the question can be: what's the best way to
keep two machines with many git repositories in sync?

Unison is a userland application that does bi-directional
synchronization of two directories. Typically, to keep a laptop and a
desktop synchronized (modify a file on the desktop and another on the
laptop, unison will copy the files). I find it very usefull to keep
large directories containing unrelated projects (typically,
~/teaching/, ~/research, ..., my colleagues even synchronize $HOME on
their laptops) in sync between two machines.

Actually, git achives something similar (and lot more, of course):
modify a file here, commit, modify another there, commit, and then
push & pull can do the sync. I find git excellent to manage somehow
self-contained projects (~/teaching/2007-2008/whatever-course/), but
inappropriate for $HOME or such big containers (need to run more
commands, disk-space overhead, ...).

So, at the moment, I have both unison and git. My fear is that unison
touches the content of the .git/ directories. So, for example, if I
commit on one side, and commit something else on the other side, I'll
get unison conflicts at least on .git/refs/heads/master and
.git/index, and resolving the conflict in favor of either side leads
to dangling objects whith important content.

What I'm doing right now is that I try to make sure I don't run unison
when trees have diverged, which is not really satisfactory since 1) I
can be wrong, and a miss-synchronization could lead to data-loss, and
2) that means not really taking advantage of unison.


What about you? What do you use to synchronize your laptop and
desktop, or home and office? Anybody using unison and git on the same
filesystem?

Thanks for your hints,

-- 
Matthieu

[1] : http://www.cis.upenn.edu/~bcpierce/unison/
