From: Don Zickus <dzickus@redhat.com>
Subject: how to rewalk the commit list after rename detection
Date: Mon, 23 Jun 2008 11:38:14 -0400
Message-ID: <20080623153814.GD15773@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 17:39:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAo8R-0002q5-03
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbYFWPiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbYFWPiS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:38:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54825 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbYFWPiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:38:17 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5NFcGSA028379
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 11:38:16 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5NFcFbe027678
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 11:38:16 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5NFcEW1006752
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 11:38:14 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5NFcEDW019381
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 11:38:14 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5NFcESv019380
	for git@vger.kernel.org; Mon, 23 Jun 2008 11:38:14 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85874>

I am trying to find a way to handle a situation where I am looking for a
change in a particular file, but the filename is old and has since been
renamed.

Processing the commit list internally (using init_revisions,
setup_revisions, get_revision), I can easily find the rename of the file,
but that is usually the start of the walk for that file (as it was just
deleted for the rename).  I do not know how to re-walk the commits list
armed with the new file name.

I tried rerunning the same commands as above (init_revisions,
setup_revisions, get_revision) but that commit list is empty for some
reason (I assume the UNINTERESTING flag is never un-set??).

For example, if I have a backported patch for the upstream kernel in say
the arch/i386 directory.  I want to check to see if it is upstream.  I
wouldn't be able to do that because arch/i386 was renamed to arch/x86.
Unless of course the patch matches identically upstream (in which case
git-cherry works fine), but that isn't always the case (usually it is a
combination of a couple of patches).

Anyone have some thoughts if this is possible?

Cheers,
Don
