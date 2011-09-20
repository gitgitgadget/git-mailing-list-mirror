From: Frederic Heitzmann <frederic.heitzmann@gmail.com>
Subject: [Bug report] git fetch/push fails from sub-directory
Date: Tue, 20 Sep 2011 23:50:04 +0200
Message-ID: <j5b1qa$pki$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 23:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R68Cw-0000FT-3n
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 23:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab1ITVuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 17:50:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:53223 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab1ITVuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 17:50:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R68Cj-0000AY-Q8
	for git@vger.kernel.org; Tue, 20 Sep 2011 23:50:13 +0200
Received: from dra38-7-88-179-84-80.fbx.proxad.net ([88.179.84.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 23:50:13 +0200
Received: from frederic.heitzmann by dra38-7-88-179-84-80.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 23:50:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dra38-7-88-179-84-80.fbx.proxad.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181797>

Hi,

I found a bug in git fetch, with local repositories.
git fetch works fine from the root directory, but it fails when called 
from deeper into the file tree of the repository.

git push fails the same way.

The bug is on 1.7.7.rc2 and on master.

mkdir repo1
cd repo1
git init .
mkdir d
touch d/f
git add d/f
git commit -m'initial commit'
cd ..
git clone repo1 repo2
cd repo2
git fetch ../repo1	# OK
cd d
git fetch ../../repo1	# failed

fatal: '../../repo1' does not appear to be a git repository
fatal: The remote end hung up unexpectedly

--
Fred
