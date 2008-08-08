From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Enable parallelized tests
Date: Fri, 8 Aug 2008 07:59:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 08 07:55:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRKws-0000Fg-LU
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 07:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbYHHFyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 01:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbYHHFyf
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 01:54:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:54045 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752139AbYHHFyf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 01:54:35 -0400
Received: (qmail invoked by alias); 08 Aug 2008 05:54:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 08 Aug 2008 07:54:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ie1QdDJsiI5YMOxzNeIzwIS9eTeg2khR7V2UjKN
	OY4ZtwQnimaXTB
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91621>


This patch pair enables parallel tests.  On a pretty beefy machine,

	$ /usr/bin/time make -j50

shows this:

	69.33user 92.33system 0:59.26elapsed 272%CPU (0avgtext+0avgdata
	0maxresident)k 0inputs+0outputs (0major+33007360minor)pagefaults 0swaps

vs.

	$ /usr/bin/time make

showing this:

	61.25user 75.10system 3:57.68elapsed 57%CPU (0avgtext+0avgdata
	0maxresident)k 0inputs+0outputs (0major+32897071minor)pagefaults 0swaps

Note: the machine was used for other tasks during the test, too.

These results are with SVN/CVS tests enabled.  I am pretty sure that the
results would be even more impressive without them (the SVN/CVS tests come
all at the end, and seem to idle the CPU mostly, and the last few seconds
are only spent on 2 tests).

Johannes Schindelin (3):
  t9700: remove useless check
  tests: Clarify dependencies between tests, 'aggregate-results' and
    'clean'
  Enable parallel tests

 t/Makefile      |   15 ++++++++++++---
 t/t9700/test.pl |    3 ---
 t/test-lib.sh   |   11 ++++++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)
