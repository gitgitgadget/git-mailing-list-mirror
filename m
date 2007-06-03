From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT RFC PATCH 0/2] Fixing the rebase safeguard
Date: Sun, 03 Jun 2007 15:41:46 +0200
Message-ID: <20070603133006.1681.1742.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 15:41:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuqLG-0006Sf-8T
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbXFCNls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbXFCNls
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:41:48 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:47627 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbXFCNlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:41:47 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DD0895A22C;
	Sun,  3 Jun 2007 15:41:46 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 7C8591F019;
	Sun,  3 Jun 2007 15:41:47 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48994>

This is an attempt at using a reachability test to replace the use of
orig-base, to decide when it is safe to accept a rebase.

This implementation passes the testcase posted earlier by Karl (resent
here as 2nd patch in this series), BUT fails the 4th test of t2100.
That is, it fails to deal with the case of a rewinding commit occuring
in the upstream branch, and being first git-fetch'd before being
stg-pull'd in fetch-rebase mode.  In this case, the former upstream
commit will really be lost.

In this case, however, it is exactly what we want, but I'm still
undecided about how to deal with this best.  Possibly insane ideas for
now include:

- parsing the remote.*.fetch lines to detect the leading + (just
  kidding ;)
- using ORIG_HEAD, but then, how do we decide when it is valid to do
  so ?

I'll now switch to some real-life activity to see if that helps to
find a better solution.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
