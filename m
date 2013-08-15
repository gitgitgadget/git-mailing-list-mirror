From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: Bug? ignored files overwritten by checkout
Date: Thu, 15 Aug 2013 06:33:11 +0000 (UTC)
Message-ID: <kuhsn7$84r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 08:33:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9r7n-0006qG-Ok
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 08:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760394Ab3HOGdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 02:33:31 -0400
Received: from plane.gmane.org ([80.91.229.3]:40815 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab3HOGdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 02:33:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V9r7i-0006lk-3X
	for git@vger.kernel.org; Thu, 15 Aug 2013 08:33:30 +0200
Received: from phare.normalesup.org ([129.199.129.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 08:33:30 +0200
Received: from damien.olivier.robert+gmane by phare.normalesup.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 08:33:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: phare.normalesup.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Wed, 14 Aug 2013 23:24:05 -0700 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232332>


git init
git commit --allow-empty -m "init"
git checkout -b test
echo foo > foo
git add foo
git commit -am 'add foo'
git checkout master
echo 'Important data' > foo #[1]
echo foo > .gitignore
git checkout test

If I tried a `git checkout test` after [1], I would get the error message 
    error: The following untracked working tree files would be overwritten by checkout: foo
But after adding foo to .gitignore, I am able to checkout to branch test
without warning. Of course this overwrites foo to the version in test.

I tested this in version 1.8.3.4 and 1.7.10.4.
