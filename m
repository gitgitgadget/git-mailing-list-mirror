From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: help needed: Splitting a git repository after subversion migration
Date: Mon, 8 Dec 2008 18:34:20 +0100
Organization: Intra2net AG
Message-ID: <200812081834.26688.thomas.jarosch@intra2net.com>
References: <493C0AAD.1040208@intra2net.com> <493D2174.80500@drmicha.warpmail.net> <20081208142447.GA20186@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 18:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9k1j-0007JY-H1
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 18:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbYLHReb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 12:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbYLHRea
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 12:34:30 -0500
Received: from re01.intra2net.com ([82.165.28.202]:34023 "EHLO
	re01.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbYLHRea (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 12:34:30 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re01.intra2net.com (Postfix) with ESMTP id 6069051C0;
	Mon,  8 Dec 2008 18:34:28 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 009C32AC4B;
	Mon,  8 Dec 2008 18:34:28 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 033B22AC4A;
	Mon,  8 Dec 2008 18:34:27 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <20081208142447.GA20186@atjola.homenet>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-08_12)
X-Spam-Status: hits=-2.9 tests=[ALL_TRUSTED=-1.8,BAYES_05=-1.11]
X-Spam-Level: 971
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102568>

On Monday, 8. December 2008 15:24:47 you wrote:
> If it's about huge objects, and not just lots of small objects, you can
> use this:

Thanks, those two commands have been really helpful. I've found some objects
that shouldn't be there and now I have two more questions:

1. When I run "git rev-list --all --objects", I can see file names that look 
like "SVN-branchname/directory/filename". Is it normal that "git svn"
creates a directory with the name of the branch and puts files below it?

"git rev-list --all --objects |grep 5-0-3-hotfix":
5fe3265b6941c2fa74c12da799ea23e2801efa8a 5-0-3-hotfix/source
...

The branch in question existed for a limited time in branches/xyz
on the SVN tree and was deleted later on. Guessing the version number
from the filename, it looks like a copy of the files when I started the branch
as it's an old version number before I committed changes to it.
(f.e. upgraded libpng). When I just grep for "libpng" on the whole index,
I see all the various updates I made over the years.

2. Something goes wrong after the filter branch:

Output from the full 11GB tree:
git rev-list --all --objects |grep 5-0-3-hotfix |grep xyz
-> No match

Output from the filtered tree:
git rev-list --all --objects |grep 5-0-3-hotfix |grep xyz

3a13f87bc116aee96e031441eaafc416652ba4bd 5-0-3-hotfix/update_pkg/xyz
ebebb84ccff26c949fb1f803c60034074e6603fe 5-0-3-hotfix/update_pkg/xyz
5529ef51de887cc905fe460e4c4f6cd34b93b5a6 5-0-3-hotfix/update_pkg/xyz
c264a9d5db30ebb131c96c4f93192bfe9a5c0a7b 5-0-3-hotfix/update_pkg/xyz

I have no idea how those objects suddenly appeared there.
It feels like something was stitched together wrongly.

When I converted the SVN tag to a git tag, I tagged the branches
with a "branch-" prefix. Might that be a problem, is "branch-" reserved?

Cheers,
Thomas
