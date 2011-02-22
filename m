From: Michael Meeks <michael.meeks@novell.com>
Subject: libreoffice merge(tool?) issue #3 ...
Date: Tue, 22 Feb 2011 15:34:37 +0000
Organization: Novell, Inc.
Message-ID: <1298388877.32648.171.camel@lenovo-w500>
Reply-To: michael.meeks@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: kendy@novell.com, Norbert Thiebaud <nthiebaud@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 16:35:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PruGs-0006xk-8M
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab1BVPfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 10:35:21 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:51282 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754212Ab1BVPfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 10:35:21 -0500
Received: from [192.168.1.4] (host81-145-110-95.range81-145.btcentralplus.com [81.145.110.95])
	by nat.nue.novell.com with ESMTP; Tue, 22 Feb 2011 16:35:19 +0100
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167554>

Hi there,

        So - yet again, I'm still a completely clueless git user :-)
basically the same setup and reproduction issue as last time, still
using a stable git: version 1.7.3.4

Setup:
        git clone git://anongit.freedesktop.org/libreoffice/libs-core
        git checkout integration/dev300_m98
        git remote add stage git://anongit.freedesktop.org/libreoffice/staging/libs-core
        git fetch stage

Reproduce:
	rm -Rf *
	git reset --hard # ie. totally clean tree.
        git merge stage/dev300

	I get this output from the merge:

error: refusing to lose untracked file at 'ucb/source/ucp/ext/makefile.mk'

	Then when I run:

$ git mergetool ucb/source/ucp/ext/makefile.mk
..

Deleted merge conflict for 'ucb/source/ucp/ext/makefile.mk':
  {local}: created
  {remote}: deleted
Use (c)reated or (d)eleted file, or (a)bort?

	It seems to suggest that the file is deleted somewhere (in the branch I
am trying to merge in) it seems.

	Interestingly, though - the file is present in both
integration/dev300_m98:

	git log -n1 ucb/source/ucp/ext/makefile.mk | tee
commit 80b61d9c6762b4f195edd1246b903b11ad3f2252
Author: Thomas Arnhold <thomas@arnhold.org>
Date:   Fri Jan 21 14:11:55 2011 +0100

    Remove old RCS lines.

	And also present in the branch I'm merging: stage/dev300:

commit 0c87cb97cf3790fa98bcbb0eef9d174140a4e847
Author: sb <sb@openoffice.org>
Date:   Fri Sep 10 13:10:07 2010 +0200

    sb129: #i113189# change UNO components to use passive registration


	Which makes me wonder - why the deleted / untracked file message ?
probably something obvious, but I found it rather confusing, and again
I've seen a number of examples of this.

	Thanks,

		Michael.

PS. of course, perhaps this is 'just me' - for space / time /
simplicty / certainty reasons, I do a lot of "cp -lR foo/.git baa/" to
duplicate trees - but AFAIK all git operations are atomic and use
renames rather than in-place re-writing: right ?
-- 
 michael.meeks@novell.com  <><, Pseudo Engineer, itinerant idiot
