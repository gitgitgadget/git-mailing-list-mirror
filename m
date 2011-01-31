From: Thomas Rast <trast@student.ethz.ch>
Subject: [1.8.0] forbid full fetchspecs in git-pull
Date: Mon, 31 Jan 2011 22:55:59 +0100
Message-ID: <201101312255.59841.trast@student.ethz.ch>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Sean Estabrooks <seanlkml@sympatico.ca>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:56:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk1jG-0008Ij-H5
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab1AaV4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:56:04 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:38095 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab1AaV4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:56:02 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 31 Jan
 2011 22:55:56 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 31 Jan
 2011 22:55:59 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165760>

Proposal:

git-pull inherits the full fetchspec invocation syntax from git-fetch,
so that you can do e.g.

  git pull origin master:master

usually shooting yourself in the foot in the process.  See e.g.

  http://thread.gmane.org/gmane.comp.version-control.git/130819/focus=130879 [item 1]

Prohibit this invocation, i.e., disallow any second argument to
git-pull that contains ':'.


History:

I submitted a patch ages ago:

  http://article.gmane.org/gmane.comp.version-control.git/130822

Sean seemed to be the only one in favour of the old behaviour, but I
was too lazy to push it past him.  (There were some issues with the
test as well.)

I honestly still don't see a valid use-case for the full syntax, let
alone having seen one in the wild; in cases where you are inclined to
do

  git pull origin foo:bar

you probably don't need 'bar' to begin with if you can use
'origin/foo' instead, assuming the previous proposal on remote-branch
updating is also included.


Risks:

It's an incompatibility, so scripts may break.


Migration plan:

None; disallow it at the 1.8.0 boundary.

If someone makes a good case why his hands are trained that way, we
might introduce a config variable instead.


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
