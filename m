From: lists@haller-berlin.de (Stefan Haller)
Subject: Confused about "degenerate" combined diff for merge commits
Date: Sun, 15 Aug 2010 19:51:35 +0200
Message-ID: <1jna5yt.1pm42a3uw2yquM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 15 20:21:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okhpu-0002a9-Pm
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 20:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789Ab0HOSV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 14:21:28 -0400
Received: from mail.ableton.net ([62.96.12.115]:46419 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab0HOSV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 14:21:27 -0400
X-Greylist: delayed 1785 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Aug 2010 14:21:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:To; bh=QQFf7iGxI9PaLbHb90TLu1cNwoKfqQhHG4Prrh0X6JM=;
	b=MvVdsbeSew3dz7AqtuWzvGbqgThyrUyGl2MvQMIOeM+AVfDaAfTcwg6Ld/w1MsoEMoMxxgrZCmOGx0kzTeW1mQGQelW7v0kaPxy1lO6BAppDq3RHta90Fk/cpKzM0SxK7/G40HFgyeOzgTKE/y3rTNDoWH1uOKVdr4+fIELT+Hw=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OkhMu-0002t7-3I
	for git@vger.kernel.org; Sun, 15 Aug 2010 19:51:36 +0200
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153615>

(Git newbie alert. Please be patient with me if I'm missing obvious
things...)

I'm converting a moderately large repository from Subversion to git.  As
part of the process, I'm experimenting with correctly representing
merges in the resulting git repository. In Subversion, we used commit
logs such as "Merged r1234:1279 from branch_xyz", so in most cases it
should be possible to use this information to create the proper parents
in git. I'm currently trying how well this works by using grafts; but
that's not the question.

Now, I'm using "gitk --all --merges" to look at my synthesized merge
commits; and I assume that I manufactured them correctly if the
resulting combined diff is empty.  I only expect diff output for merge
conflicts with a non-trivial resolution, i.e. neither ours nor theirs
was used to resolve the conflict. Is this assumption correct so far?

However, for some of these merge commits I see diff output such as this:

diff --cc Src/ClipBoard.cpp
index 4357ea0,4357ea0..3fad79a
--- a/Src/ClipBoard.cpp
+++ b/Src/ClipBoard.cpp
@@@ -71,7 -71,7 +71,7 @@@ AClipBoard* AClipBoard::SNew(
  
  AClipBoard* AClipBoard::SClipBoard()
  {
--  static AClipBoard* spClipBoard = SNew();
++  static TPtr<AClipBoard> spClipBoard = SNew();
    return spClipBoard;
  }
  
It looks like both merge parents had an identical diff here, so this is
not a conflict; why does diff --cc even show this to me?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
