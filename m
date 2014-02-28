From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Fri, 28 Feb 2014 20:45:15 +0100
Message-ID: <vpqppm7t41g.fsf@anie.imag.fr>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
	<851tynz2yg.fsf@stephe-leake.org> <vpq38j3z1jj.fsf@anie.imag.fr>
	<85vbvz171p.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 20:45:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJTNH-0001v7-Hq
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 20:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbaB1Tpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 14:45:31 -0500
Received: from mx2.imag.fr ([129.88.30.17]:56119 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbaB1Tpa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 14:45:30 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s1SJjD9t006685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Feb 2014 20:45:13 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1SJjFAk024104;
	Fri, 28 Feb 2014 20:45:15 +0100
In-Reply-To: <85vbvz171p.fsf@stephe-leake.org> (Stephen Leake's message of
	"Fri, 28 Feb 2014 11:27:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 28 Feb 2014 20:45:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1SJjD9t006685
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394221516.45863@OUIWirsnKPO3Ui+Anbp57w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243010>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> So a message "merge complete; you can drop the stash" would be the most
> git should do.

>From the user experience point of view, that would be good. It could
bother some users, but we have advice.* to silent this kind of warnings.

>From the implementation point of view, it's much harder than it seems
because as other pointed out, Git does not know that the merge conflicts
comes from, so as it is, the best it could say is "merge complete; you
can now proceed". Thas is a solvable problem (git stash could leave a
file like .git/conflicted-stash, and git add could look for this file
and remove it), but I can't think of an implementation that would not be
really awful. For example, "git reset" should also remove the file, and in
general a substancial subset of Git's command would need to be aware of
the status of git stash.

So, I wouldn't object, but I don't think the implementation cost is
worth the benefit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
