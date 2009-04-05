From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Sun,  5 Apr 2009 02:46:57 +0200
Message-ID: <1238892420-721-1-git-send-email-drizzd@aon.at>
References: <20090401180627.GA14716@localhost>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Michael Johnson <redbeard@mdjohnson.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 02:49:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqGXy-0004qB-QR
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 02:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbZDEArO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 20:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbZDEArM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 20:47:12 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:51887 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbZDEArJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 20:47:09 -0400
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 5 Apr 2009 02:46:57 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LqGVo-0000CT-Bl; Sun, 05 Apr 2009 02:47:00 +0200
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <20090401180627.GA14716@localhost>
X-OriginalArrivalTime: 05 Apr 2009 00:46:57.0886 (UTC) FILETIME=[061307E0:01C9B588]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115615>

Hi,

The segmentation fault is caused by a null pointer dereference which happens
during recursive merge with a submodule conflict between two merge bases. This
is fixed by the following patches.

However, there are other problems with merging submodules. For example, git
diff aborts with "fatal: read error 'sub'" for conflicting submodules. I have
also added a test for this.

Dscho has already started working on related issues. I have therefore skipped
t7404, which is already used in Dscho's work.

Clemens

 merge-recursive.c          |   16 ++-------
 t/t7405-submodule-merge.sh |   74 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 12 deletions(-)

[PATCH 1/3] add tests for merging with submodules
[PATCH 2/3] update cache for conflicting submodule entries
[PATCH 3/3] simplify output of conflicting merge
