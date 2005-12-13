From: Carl Baldwin <cnb@fc.hp.com>
Subject: git-merge fails when trying to merge from a tag
Date: Tue, 13 Dec 2005 10:55:16 -0700
Organization: Hewlett Packard
Message-ID: <20051213175516.GA3695@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 13 18:58:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmEN0-0006Md-7i
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 18:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVLMRzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 12:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVLMRzT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 12:55:19 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:5282 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750987AbVLMRzR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 12:55:17 -0500
Received: from smtp2.fc.hp.com (smtp2b.fc.hp.com [15.15.136.253])
	by atlrel8.hp.com (Postfix) with ESMTP id C9F0D3572D
	for <git@vger.kernel.org>; Tue, 13 Dec 2005 12:55:16 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 9C7F141E479
	for <git@vger.kernel.org>; Tue, 13 Dec 2005 17:55:16 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 7E7144095; Tue, 13 Dec 2005 10:55:16 -0700 (MST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13582>

Greetings,

I just tried to merge using a tag object.  I expected this to work just fine
since the tag refers to a commit object and is therefore committish.  The very
same merge command except with '^{}' appended to the tag name to select the
commit object worked just fine.  Below you'll find some interesting output.

Cheers,
Carl

PS  I used git-bisect for the first time this morning.  I was VERY impressed.
Anyway, on to the output...

% git --version
git version 0.99.9m

% git merge "Merging release-0.3.1" HEAD refs/tags/release-0.3.1
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with refs/tags/release-0.3.1
Merging:
df17837d378c5ee07a26c97ac1bfc3fb3f7bacbb Fix test of  string
f2aa1e01ae0f1b0ea9354f2ea2c7444b5efc8ac5 Merging release-0.2.1
found 1 common ancestor(s):
43c6310a463aee1c2cbd882b81a596e429bc7f6c Commit msg
Auto-merging scripts/config.sh

fatal: 4c29c70d1d290807c2757eabaefb607b8fd7b595 is not a valid 'commit' object

% git-cat-file tag 4c29c70d1d290807c2757eabaefb607b8fd7b595
object f2aa1e01ae0f1b0ea9354f2ea2c7444b5efc8ac5
type commit
tag release-0.3.1
tagger Carl N. Baldwin <carl@ecbaldwin.net> 1134493064 -0700
... (The rest of the tag object looks just as you'd expect)

% git checkout -f # To reset changes done by failed merge
% git merge "Merging release-0.3.1" HEAD refs/tags/release-0.3.1^{}
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with refs/tags/release-0.3.1^{}
Merging:
df17837d378c5ee07a26c97ac1bfc3fb3f7bacbb Fix test of  string
f2aa1e01ae0f1b0ea9354f2ea2c7444b5efc8ac5 Merging release-0.2.1
found 1 common ancestor(s):
43c6310a463aee1c2cbd882b81a596e429bc7f6c Commit msg
Auto-merging scripts/config.sh

Merge 5612809ea11c9709e3a5282f8002c1f993e127d6, made by recursive.
 scripts/config.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
