From: "Yann Dirson" <ydirson@altern.org>
Subject: [UI issue + BUG] recovering from rebase aborting due to untracked 
 files
Date: Fri, 15 Jan 2010 11:44:22 +0100
Message-ID: <ea70c5e3e02a9e9a39384ea417bfa59a.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 11:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVjp3-0000ll-EI
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 11:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0AOKy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 05:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319Ab0AOKy2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 05:54:28 -0500
Received: from alderaan.linagora.com ([84.14.148.74]:39781 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab0AOKy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 05:54:27 -0500
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2010 05:54:27 EST
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 8F18110B7E3
	for <git@vger.kernel.org>; Fri, 15 Jan 2010 11:44:10 +0100 (CET)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Fri, 15 Jan 2010 11:44:22 +0100
User-Agent: SquirrelMail/1.4.18
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137062>

During an interactive rebase, it happened that some testing operations on
one commit created files that were normally added by a later commit,
leading to the following conflict:

$ git rebase --continue
error: Untracked working tree file 'xxxx' would be overwritten by merge. 
Aborting
Could not apply 8a2ea0a... L10n of photo and games.
$

No clue is given about what to do next.  It would be nice if one could
just removes the faulty files, and use "rebase --continue". 
Unfortunately, doing the following results in the rebase being prematurely
finished with success, with all patches starting with the one causing the
problem being silently dropped.

Now it is not so hard for an experienced user to rewind and avoid doing
the mistake a second time, but some safeguards would be nice.

Does anyone with knowledge of rebase internals see what goes wrong and how
to fix it best ?
