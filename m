From: Ron Garret <ron@flownet.com>
Subject: Stepping through a single file's history
Date: Thu, 28 Jan 2010 17:28:04 -0800
Message-ID: <5699F80A-4B27-4BAB-BEE8-5C48938A970B@flownet.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 02:49:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NafzO-0001hE-Sn
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 02:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0A2Btd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 20:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260Ab0A2Btd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 20:49:33 -0500
Received: from genesisgroup.info ([67.201.56.75]:59672 "EHLO
	vm01.awun.ml.zerolag.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab0A2Btc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 20:49:32 -0500
X-Greylist: delayed 1284 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2010 20:49:32 EST
Received: from [192.168.1.2] (68-190-211-184.dhcp.gldl.ca.charter.com [68.190.211.184])
	(Authenticated sender: ron@genesisgroup.info)
	by vm01.awun.ml.zerolag.com (Postfix) with ESMTP id 74FC54CA9AC
	for <git@vger.kernel.org>; Thu, 28 Jan 2010 17:26:05 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138292>

Hello,

Is there an easy way to step through the history of a single file?  To be more specific:

Suppose I have a repository with a bunch of files and bunch of commits in a simple linear sequence, but with changes to various files interleaved within that sequence of commits.  I want to be able to step through the history of ONE of the files in the repository without disturbing the other files in the working directory, and without changing the index.  (The use case here is remembering that back in the day there was some useful code in this file that I want to retrieve, but not remembering exactly when it was deleted.  So I want to step back through this file's history and do diffs against HEAD.)

So I want to be able to do something like...

git rollback [filename]

and have the copy of the file in the working directory roll back one version.  Then I want to be able to do a 'git diff' and see what was different between that rolled-back version and the most recent one (which I want to then be able to return to somehow, preferably in a more elegant way than git checkout HEAD, but I'll settle for that).

It seems that this should be possible, but I can't figure out how to do it.  The closest I've been able to come is doing:

git rev-list HEAD -- [filename]

and then manually going back through the list of commits and doing a git checkout on each one in turn.  There are two problems with this.  First, I have to manually keep track of where I am in the list, which is a PITA if the list is long.  And second, because I've checked the file out, it not only appears in my working directory, but it also gets placed in the index, which is not what I want (because I want to be able to do a git diff against the HEAD to see the code that changed between the old and new versions).

Git does everything, so surely there's a way to do this.  Can anyone offer me a hint as to how?

Thanks,
rg
