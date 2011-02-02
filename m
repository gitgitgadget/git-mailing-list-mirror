From: Thomas Rast <trast@student.ethz.ch>
Subject: [1.8.0] git-stash invocation changes
Date: Wed, 2 Feb 2011 18:23:19 +0100
Message-ID: <201102021823.19559.trast@student.ethz.ch>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 18:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkgQS-0005u7-0L
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 18:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab1BBRXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 12:23:22 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:59412 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab1BBRXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 12:23:21 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 2 Feb
 2011 18:23:12 +0100
Received: from pctrast.inf.ethz.ch (129.132.149.163) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 2 Feb
 2011 18:23:18 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.149.163]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165918>

Proposal:

1. Change 'git stash <not-a-stash-command>' to give a usage message
   instead of using <not-a-stash-command> as the stash message.

2. Change 'git stash -p <args>' to treat the <args> as filename
   arguments similar to add -p.  Possibly add a -m option that lets
   you specify a message anyway, if desired.


Rationale:

The first one has long been a pet peeve of others, too.  It makes the
stash command prone to typo accidents and such.

The second one was my own fault, and breaks the symmetry with the rest
of the -p family.


Risks:

Users trained to either usage will obviously have to retrain their
fingers.  Scripts may also have to be changed, but if anything they
probably use a 'git stash; do_something; git stash pop' pattern which
would not be affected.  (I also suspect most scripts using this
pattern forget to check whether there is anything to stash, and thus
are broken if there isn't.)


Migration plan:

In 1.7.5, give a loud warning for both syntaxes.

In 1.8.0, switch them as described.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
