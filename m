From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Valgrind support
Date: Mon, 26 Jan 2009 00:18:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260014470.14855@racer>
References: <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
 <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
 <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:19:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREG3-00078R-Pd
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbZAYXRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbZAYXRm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:17:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:59852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750789AbZAYXRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:17:41 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:17:39 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp049) with SMTP; 26 Jan 2009 00:17:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kb1l/TvgkjwSq5ENUPfYOZzg0SdEfKlWCGfl3Xq
	S+oPsU86RwMpng
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107121>


I finally decided to give in on both the lock (let's see how many races
we encounter in reality...) and the searching the PATH and handling .sh
and .perl scripts, too.  The latter issue is handled by 3/3, which is up
for discussion.

Oh, and BTW, this is vs 'next', and according to my tests, valgrind finds
at least one issue.

Jeff King (1):
  valgrind: ignore ldso and more libz errors

Johannes Schindelin (2):
  Add valgrind support in test scripts
  Valgrind support: check for more than just programming errors

 t/README                |    8 +++++-
 t/test-lib.sh           |   66 +++++++++++++++++++++++++++++++++++++++++++++-
 t/valgrind/.gitignore   |    1 +
 t/valgrind/default.supp |   45 ++++++++++++++++++++++++++++++++
 t/valgrind/valgrind.sh  |   12 ++++++++
 5 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 t/valgrind/.gitignore
 create mode 100644 t/valgrind/default.supp
 create mode 100755 t/valgrind/valgrind.sh
