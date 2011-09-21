From: Alexander Pepper <pepper@inf.fu-berlin.de>
Subject: Bug: git log --numstat counts wrong
Date: Wed, 21 Sep 2011 11:03:30 +0200
Message-ID: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 11:21:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Izi-0006BE-5Q
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 11:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab1IUJVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 05:21:25 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:40862 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752216Ab1IUJVZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 05:21:25 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R6Izc-0007pw-Fv>; Wed, 21 Sep 2011 11:21:24 +0200
Received: from 91-66-162-110-dynip.superkabel.de ([91.66.162.110] helo=[10.1.17.174])
          by inpost2.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtpsa
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R6Izc-0001u4-DJ>; Wed, 21 Sep 2011 11:21:24 +0200
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: 91.66.162.110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181829>

Hello there.

I already reported some similar bug with git log --numstat to this mailinglist (see http://www.spinics.net/lists/git/msg163358.html ). Back then empty lines seems to be the issue, but the bug was never fixed.

I found another case, where git log --numstat counts wrong. This time git log --numstat yields bigger numbers than diffstat.

Minimal example:
$ git clone https://github.com/voldemort/voldemort.git
$ cd voldemort/
$ git show 48a07e7e533f507228e8d1c99d4d48e175e14260 -- src/java/voldemort/server/storage/StorageService.java | diffstat
 StorageService.java |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)
$ git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
[...]
11      10      src/java/voldemort/server/storage/StorageService.java


So git log --numstat claimes that 11 lines where added, where diffstat only counts 10! A closer look inside the StorageService.java reveals no empty lines.

My system:
* Mac osx 10.6.8
* git 1.7.5.4 (but also check with a self compiled 1.7.6.1)

Can you confirm that this is a bug? If so, are there plans to fix it in the future?

Greetings from Berlin
Alex