From: Olaf Hering <olaf@aepfle.de>
Subject: history damage in linux.git
Date: Thu, 21 Apr 2016 13:30:04 +0200
Message-ID: <20160421113004.GA3140@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 13:30:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atCoT-0000cF-KQ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 13:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbcDULaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 07:30:13 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:61466 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbcDULaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 07:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1461238210; l=1140;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=QVksaUGi+vCHEMd1c9jIyuhoBKk2BR8S+CDJaEvXVXk=;
	b=vFvByz/yAM0O17B1XS0WudU3J4FCETh1ExeKWcuM+CjcXzVQtPeVbor4f2fl083VSYC
	sKWhVQyDH8L64Q3lx311i0p+7qbMIPvQGDH9ghVoKKaCroO4v8Wpwrx6tdut8Tw3Dnmqb
	FP7iF2Qw0E/jFTUK6KKGusforiLoiDmlPuQ=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWtrWFmrD4pjkQ2b4qvS
X-RZG-CLASS-ID: mo00
Received: from aepfle.de (charybdis-ext.suse.de [195.135.221.2])
	by post.strato.de (RZmta 37.24 AUTH)
	with ESMTPA id j047d3s3LBU9F31
	for <git@vger.kernel.org>;
	Thu, 21 Apr 2016 13:30:09 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (6623)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292105>

To track the changes in hyperv related files I created some scripts
years ago to automate the process of finding relevant commits in
linux.git. Part of that process is to record the tag when a commit
appeared in mainline. This worked fine, until very recently.

Suddenly years-old commits are declared as having-just-arrived in
linux.git. Look at this example:

  $ git log --oneline -- drivers/input/serio/hyperv-keyboard.c
  2048157 Drivers: hv: vmbus: fix the building warning with hyperv-keyboard
  62238f3 Input: hyperv-keyboard - register as a wakeup source
  c3c4d99 Input: hyperv-keyboard - pass through 0xE1 prefix
  aed06b9 Input: add a driver to support Hyper-V synthetic keyboard
  $ git describe --contains aed06b9
  v4.6-rc1~9^2~792
  $ git show aed06b9 | head
  commit aed06b9cfcabf8644ac5f6f108c0b3d01522f88b
  Author: K. Y. Srinivasan <kys@microsoft.com>
  Date:   Wed Sep 18 12:50:42 2013 -0700

Obviously that and other commits are in the tree since a very long time.

How can I find out whats going on? Is my git(1) 2.8.1 broken, or did
Linus just pull some junk tree (and does he continue to do so)?

Olaf
