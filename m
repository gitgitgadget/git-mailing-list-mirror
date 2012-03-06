From: Brian Gernhardt <benji@silverinsanity.com>
Subject: t5704: problem with OS X sed
Date: Tue, 6 Mar 2012 13:10:24 -0500
Message-ID: <E40E6E02-8960-4A10-9E71-28F9CDB120F8@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 19:10:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4yqW-0006vN-TW
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 19:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066Ab2CFSKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 13:10:43 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:49630 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756413Ab2CFSKm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 13:10:42 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 1DB941FFC008; Tue,  6 Mar 2012 18:10:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.89] (unknown [64.134.102.20])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 90E371FFC006
	for <git@vger.kernel.org>; Tue,  6 Mar 2012 18:10:35 +0000 (UTC)
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192368>

t5704's newest test has always failed for my on OS X.  It's taken a little while for me to find the time to try to fix it.  Unfortunately, my sed-fu has proven not up to the task:

sed: 1: "/^-/{p;q}": extra characters at the end of q command
not ok - 7 ridiculously long subject in boundary
#	
#		: >file4 &&
#		test_tick &&
#		git add file4 &&
#		printf "%01200d
#	" 0 | git commit -F - &&
#		test_commit fifth &&
#		git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
#		git bundle list-heads long-subject-bundle.bdl >heads &&
#		test -s heads &&
#		git fetch long-subject-bundle.bdl &&
#		sed -n "/^-/{p;q}" long-subject-bundle.bdl >boundary &&
#		grep "^-$_x40 " boundary
#	

I've tried various bits of whitespace or splitting the commands in two, but haven't hit on the proper combination of commands.

Of course, if I remove the sed invocation, I get the following error from grep: "Regular expression too big"

It seems to me that using sed to find a single line and then grepping for it is somewhat redundant.

If someone else has suggestions on how to make this test work on OS X, I'm happy to help test them.

~~ Brian Gernhardt
