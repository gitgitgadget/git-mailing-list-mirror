From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git automatic stashing?
Date: Tue, 09 Nov 2010 08:49:24 +0100
Message-ID: <vpqlj53j5rv.fsf@bauges.imag.fr>
References: <AANLkTim3MacQK6EtTPNJsYbqb=5bOM3W3BXC6p=hT+PU@mail.gmail.com>
	<AANLkTinwftXiZxbs_=PeM-MxQmMF4VaBCPEufH=OG6iU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Casey McGinty <casey.mcginty@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 08:49:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFixU-0000e4-2s
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 08:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998Ab0KIHtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 02:49:31 -0500
Received: from mx2.imag.fr ([129.88.30.17]:56027 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708Ab0KIHta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 02:49:30 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA97gaGl022844
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 9 Nov 2010 08:42:37 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PFixI-0004WO-Qu; Tue, 09 Nov 2010 08:49:24 +0100
In-Reply-To: <AANLkTinwftXiZxbs_=PeM-MxQmMF4VaBCPEufH=OG6iU@mail.gmail.com> (Casey McGinty's message of "Mon\, 8 Nov 2010 19\:37\:53 -1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Nov 2010 08:42:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA97gaGl022844
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289893360.81061@kRIXYf79nWLxn+8PsTpzXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161021>

Casey McGinty <casey.mcginty@gmail.com> writes:

> Is there any feature in git to perform and auto stash apply/pop when
> trying to do a merge/rebase in a dirty working dir? This would save
> some keystrokes from time-to-time, and make it easier for new users
> unfamiliar with git.

I agree with the keystrokes part, but not with the fact that it would
make it easier in general. In the sequence

git stash
git merge
git stash pop

conflicts can occur in 2 distinct places. One can easily forsee this
senario occuring:

git stash
git merge
# fix conflicts
# git commit
# forget to do the action needed to get the "git stash pop"

and voila, you've just lost data.

Actually, what I'd like to see would be this feature, but limited to
the case where the merge is a fast-forward, because then, only the
last action of the sequence could possibly leave conflict, so Git
could finish with a message like "please fix conflicts and continue
working". Actually, this is not far from what "git checout -m" is
doing.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
