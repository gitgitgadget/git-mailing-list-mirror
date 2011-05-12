From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: git cherry-pick --strategy=resolve segfaults if picking a root commit
Date: Thu, 12 May 2011 12:15:24 +0200
Message-ID: <iqgbvs$pm5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 12:16:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKSwj-0004Eq-VC
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 12:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab1ELKPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 06:15:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:44967 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1ELKPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 06:15:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QKSvf-0003Ta-QS
	for git@vger.kernel.org; Thu, 12 May 2011 12:15:35 +0200
Received: from berry.zib.de ([130.73.68.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 May 2011 12:15:35 +0200
Received: from sschuberth by berry.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 May 2011 12:15:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: berry.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173454>

Hi,

I just noticed that (under both Linux and Windows) Git 1.7.5 segfaults 
for me if cherry-picking a root commit from one repo into another one 
with "--strategy=resolve". It does not segfault if "--strategy=resolve" 
is omitted. Here's what I did:

# Create a repository with only a root commit.
mkdir repo1
cd repo1
git init

echo "test1" > test1
git add test1
git commit -m "test1"

# Create another repository with only a root commit.
mkdir ../repo2
cd ../repo2
git init

echo "test2" > test2
git add test2
git commit -m "test2"

git remote add repo1 ../repo1
git fetch repo1

# Cherry-pick with "--strategy=resolve" -> segfaults.
git cherry-pick --strategy=resolve repo1/master

Is this already a known issue?

-- 
Sebastian Schuberth
