From: "Jan Hudec" <bulb@ucw.cz>
Subject: [BUG?] git checkout -b removes MERGE_HEAD
Date: Thu, 18 Nov 2010 08:15:23 +0100 (CET)
Message-ID: <456aec650e66bba518b8a5ec88c88a6b.squirrel@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 08:40:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIz6z-0005gJ-ER
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 08:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab0KRHks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 02:40:48 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:40976 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab0KRHks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 02:40:48 -0500
Received: from artax.karlin.mff.cuni.cz (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id DEFB89809B
	for <git@vger.kernel.org>; Thu, 18 Nov 2010 08:15:23 +0100 (CET)
Received: from 62.24.65.159
        (SquirrelMail authenticated user jhud7196)
        by artax.karlin.mff.cuni.cz with HTTP;
        Thu, 18 Nov 2010 08:15:23 +0100 (CET)
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161654>

Hello all,

I am not sure whether it is a bug or not, but it definitely did
surprise me a lot. The use-case was as follows:

 - I checked out master and ran a merge from branch (let's call
   it "branch"). It had a lot of conflicts, so I needed to test
   the result well.
 - During the testing I found a problem, but it may have already
   existed on master before the merge.
 - Therefore I needed to return to clean master, test it and return
   to the merge. So I thought I'd commit the merge to a temporary
   branch, test master again and merge the temporary to master if
   the problem is not from the merge. So I did:

   $ git checkout -b temp
   $ git commit

   OOPS! It forgot it was a merge.

Yes, I could have simply commited to master and reset --hard it
back. But I didn't expect it to forget it was a merge in the first
place. After all, it does NOT touch the index nor the working tree,
so why should it clear the MERGE_HEAD and MERGE_MSG?

So should this behaviour be changed?

Thanks,
Jan

-- 
                                        - Jan Hudec <bulb@ucw.cz>
