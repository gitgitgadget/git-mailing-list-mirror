From: John Fultz <jfultz@wolfram.com>
Subject: git filter-branch not removing commits when it should in 2.7.0
Date: Tue, 19 Jan 2016 14:48:40 -0600
Message-ID: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 21:54:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLdI8-0004LS-9l
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 21:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722AbcASUyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 15:54:11 -0500
Received: from relay.wolfram.com ([140.177.205.37]:54211 "EHLO
	relay-int.wolfram.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757717AbcASUyI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2016 15:54:08 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2016 15:54:08 EST
Received: from [10.99.98.214] (unknown [10.99.98.214])
	by relay-int.wolfram.com (Postfix) with ESMTPSA id 9A54DD1703
	for <git@vger.kernel.org>; Tue, 19 Jan 2016 14:48:40 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 relay-int.wolfram.com 9A54DD1703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1453236520; bh=XrDx/ADuHT8DZx6BrTSVcfs0sLPxFq2a1YYHYzasjbk=;
	h=From:Subject:Date:To:From;
	b=zlcM3Bcy5IjVy2qEnd5NeELM/gIhRod1gLGJH0BV3YaZiesg3fs/weLn5DOUdrWfx
	 AplwtSRs+OOSTswQ1DRZWuDrtpNrz3AySHAdxHatHrI2dYP2GiLepS++xCgTJkEZa+
	 CIF6MLsFHF3SXswYQwKV3RqZATaLXYqjh1wQH3b8=
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284376>

This seems to be a 2.7.0 regression in filter-branch.  The bug is reproducible on Mac/Windows (haven't tried Linux) in the 2.7.0 production releases.

Make an empty repo and put an empty commit in the history.  E.g.,

echo > foo && git add . && git commit -m "commit 1" && git commit --allow-empty -m "commit 2"

Now try to use filter-branch to remove the empty commit.  Both of the following methods leave master unchanged, but both worked in 2.6.4:

git filter-branch --prune-empty
git filter-branch --commit-filter 'git_commit_non_empty_tree "$@"'

Let me know if you need any more information.  Thanks.

Sincerely,

John Fultz
jfultz@wolfram.com
User Interface Group
Wolfram Research, Inc.
