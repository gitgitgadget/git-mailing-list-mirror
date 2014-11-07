From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Support updating working trees when pushing into non-bare
 repos
Date: Fri, 7 Nov 2014 14:58:12 +0100 (CET)
Message-ID: <cover.1415368490.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 14:58:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmk3h-0000Ot-60
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 14:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbaKGN6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 08:58:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:64439 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbaKGN6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 08:58:22 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MZCQ8-1XRlG51yE0-00L25p;
 Fri, 07 Nov 2014 14:58:13 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:xW2LMPt7stXLHjhxz1nyHQOhxL05nOC0DM15Nowikjsxz2I70Y1
 4Pziil6J+84Ycgh3671jNITiwbu6v3i3UFl6Fl/dEuvkHAE9sqyQE4Gseaw9C42UaTPtfUG
 15Kmf6+Alpx06UgELcRn/WohokLFb1133rHgogFpcs9mwGYaMW8D/Ztk2OWG6tthDyizdTz
 Di18O7UckyfRyf313B4Hw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few years ago, this developer was convinced that it was a bad idea to
auto-update working directories when pushing into the current branch, and
that an excellent way to prove this was to implement that feature. To his
surprise, it turned out to be the one thing he misses most in upstream Git.

So here goes: this patch series adds support for two new
receive.denyCurrentBranch settings: one to update the working directory
(which must be clean, i.e. there must not be any uncommitted changes) when
pushing into the current branch, the other setting detaches the HEAD
instead.

The scenario in which in particular the 'updateInstead' setting became a
boon in this developer's daily work is a multi-laptop one, where working
directories need to be updated between computers without a hassle.

Johannes Schindelin (2):
  Add a few more values for receive.denyCurrentBranch
  Let deny.currentBranch=updateInstead ignore submodules

 Documentation/config.txt |  5 +++++
 builtin/receive-pack.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t5516-fetch-push.sh    | 36 ++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.0.0.rc3.9669.g840d1f9
