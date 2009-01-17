From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v4 0/5] N-th last checked out branch
Date: Sat, 17 Jan 2009 17:09:52 +0100
Message-ID: <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODlY-0001Pe-49
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761348AbZAQQJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757135AbZAQQJx
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:09:53 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:39223 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755207AbZAQQJw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:09:52 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:51 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:51 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 17 Jan 2009 16:09:51.0113 (UTC) FILETIME=[06DE6F90:01C978BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106072>

Johannes Schindelin wrote:
> 
> Instead of traversing them twice, we just build a list of branch switches,
> pick the one we're interested in, and free the list again.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> On Sat, 17 Jan 2009, Thomas Rast wrote:
> 
> > Johannes Schindelin wrote:
> > 
> > > I really have to ask: why did you not work on top of Junio's 
> > > patch, just adding docs, tests, and checkout -?  And then -- maybe -- 
> > > the string_list...
> 
> Of course, I meant the patch as-is, with Junio as author.  But 
> hey, if he does not care...

*shrug*

For one thing there was no commit message.

I made up a message, split the changes I made into smaller patches,
and added a fixed up version of your patch on top, since it had some
context that is not in any version I have.


Johannes Schindelin (1):
  interpret_nth_last_branch(): avoid traversing the reflogs twice

Junio C Hamano (1):
  checkout: implement "@{-N}" shortcut name for N-th last branch

Thomas Rast (3):
  sha1_name: tweak @{-N} lookup
  sha1_name: support @{-N} syntax in get_sha1()
  checkout: implement "-" abbreviation, add docs and tests

 Documentation/git-checkout.txt  |    4 ++
 Documentation/git-rev-parse.txt |    3 +
 builtin-checkout.c              |   15 ++++++-
 cache.h                         |    1 +
 sha1_name.c                     |   88 +++++++++++++++++++++++++++++++++++++-
 t/t1505-rev-parse-last.sh       |   71 +++++++++++++++++++++++++++++++
 t/t2012-checkout-last.sh        |   50 ++++++++++++++++++++++
 7 files changed, 227 insertions(+), 5 deletions(-)
 create mode 100755 t/t1505-rev-parse-last.sh
 create mode 100755 t/t2012-checkout-last.sh
