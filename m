From: Oliver Hookins <oliver.hookins@nokia.com>
Subject: Fatal error writing file of mode 120000 when rebasing
Date: Wed, 31 Mar 2010 16:43:38 +0200
Message-ID: <20100331144338.GE2794@spacemoose.devbln.europe.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 16:43:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwz94-00054a-RC
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 16:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326Ab0CaOnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 10:43:43 -0400
Received: from smtp.nokia.com ([192.100.105.134]:56292 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab0CaOnn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 10:43:43 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2VEhanS014196
	for <git@vger.kernel.org>; Wed, 31 Mar 2010 09:43:41 -0500
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 31 Mar 2010 17:43:36 +0300
Received: from spacemoose.devbln.europe.nokia.com ([172.25.239.83]) by esebh102.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 31 Mar 2010 17:43:35 +0300
Received: by spacemoose.devbln.europe.nokia.com (Postfix, from userid 1000)
	id B5DC646D9E; Wed, 31 Mar 2010 16:43:38 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 31 Mar 2010 14:43:35.0698 (UTC) FILETIME=[8B034720:01CAD0E0]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143677>

Hi,

I'm trying to migrate a git repository to svn (reasons for which are not
relevant to the problem at hand) using the instructions I've seen posted in
various places but specifically here:
http://code.google.com/p/support/wiki/ImportingFromGit

All is well until the step 3 where I am directed to perform
"git rebase master tmp". The first few patches seem to be applied ok but it
fails with the following error:

fatal: unable to write file foo/bar/baz mode 120000
Patch failed at 0003 remove some files

What appears to be happening in this patch is that a directory is deleted and
then a symlink was put in its place. In the reapply patch it seems that the
symlink creation is first and the deletions come afterwards so I am guessing the
fatal error refers to attempting and failing to create this symlink with the
original directory still in place.

I can't seem to find any other mentions of this problem occurring for others on
the interwebs, perhaps someone on this list can shed some light on why this
could be happening (and a possible solution which isn't too painful).
