From: der Mouse <mouse@Rodents-Montreal.ORG>
Subject: git's use of mkdir(2)
Date: Wed, 8 Sep 2010 15:36:43 -0400 (EDT)
Message-ID: <201009081936.PAA07078@Sparkle.Rodents-Montreal.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 21:54:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtQip-0007FJ-9X
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 21:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab0IHTxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 15:53:55 -0400
Received: from Sparkle.Rodents-Montreal.ORG ([216.46.5.7]:57127 "EHLO
	Sparkle.Rodents-Montreal.ORG" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753917Ab0IHTxz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 15:53:55 -0400
X-Greylist: delayed 1030 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2010 15:53:54 EDT
Received: (from mouse@localhost)
	by Sparkle.Rodents-Montreal.ORG (8.8.8/8.8.8) id PAA07078;
	Wed, 8 Sep 2010 15:36:43 -0400 (EDT)
X-Erik-Conspiracy: There is no Conspiracy - and if there were I wouldn't be part of it anyway.
X-Message-Flag: Microsoft: the company who gave us the botnet zombies.
X-Composition-Start-Date: Wed, 8 Sep 2010 15:16:20 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155812>

I've been trying to convince git to run on some of the systems I use.
Of particular relevance at the moment are two BSD systems which have an
important behavioural difference.

Specifically, if /foo/bar does not exist but /foo does,
mkdir("/foo/bar/",...) works on one and fails showing ENOENT on the
other.  (Without the trailing slash, it works on both.)

git (at least in the version I've got here, which appears to be
1.6.4.1) depends on this working, and breaks as a result on the second
of the above two systems.

I've been doing a little digging and I think I might be able to fix
this - but, before I charged ahead with it, I thought I'd float a query
here to ask (a) if this is a known issue and fixed in something more
recent (I had a look at 1.7.2 and a quick read of the code makes me
think it still does this, but I could have missed something) and (b) if
there would be any interest in such fixes if I do come up with them.

Thoughts?

/~\ The ASCII				  Mouse
\ / Ribbon Campaign
 X  Against HTML		mouse@rodents-montreal.org
/ \ Email!	     7D C8 61 52 5D E7 2D 39  4E F1 31 3E E8 B3 27 4B
