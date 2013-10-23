From: worley@alum.mit.edu (Dale R. Worley)
Subject: Working patterns
Date: Wed, 23 Oct 2013 16:23:53 -0400
Message-ID: <201310232023.r9NKNr5v012288@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 23 22:24:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ4yS-0002Rf-7m
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 22:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab3JWUX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 16:23:56 -0400
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:54353
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751513Ab3JWUXz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 16:23:55 -0400
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id giYo1m0040vyq2s5FkPuec; Wed, 23 Oct 2013 20:23:54 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id gkPu1m00Q1KKtkw3RkPutn; Wed, 23 Oct 2013 20:23:54 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r9NKNrlg012289
	for <git@vger.kernel.org>; Wed, 23 Oct 2013 16:23:53 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r9NKNr5v012288;
	Wed, 23 Oct 2013 16:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1382559834;
	bh=vfuf8WU338n0x10KXNqyznQCbjE0zqQYDYgxfXY9QHM=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=XpNmDyvInctrm5me5BYH3/eRLBZuFI9oU7M3P8PA9Y+DeNBs4QbxlEYGhZTyOWS6D
	 rECJTZS83SPZFwVZCftoaepfwBvSbFNh/4BV4frr2EjnVe6K1lMxUeOrPFaCqSnR9P
	 4Y4NukIsgG2qvbPzKDYebslC50IWgRFoRs25NHeFiZ8BIFgQVmWKq6tON3n2OmbqdN
	 /t8EnySI1e4SxseOsg1bD6nNDW7B4/9I52q3bc1Ma/GVw2KtoXJv/dlzFeQM4Qk9RI
	 SjLvyJ47uYdBG5sOzVYvjsUHXRU0QRHDanGwBDjw78j3JLwCgwqXe8R092wp7yqME9
	 Qr4uo0VNHfr/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236552>

> The pattern I use is to have this:
> 
>         /repository/.git
> 		with core.worktree = /working
>         /working/...
> 
> then
> 
>         cd /repository
>         git add /working/x/y
>         git ...

The point I'm trying to make is that it appears that all of the Git
commands implemented as programs use the same code at the beginning to
determine the location of the Git repository and the root directory of
the work tree -- to determine GIT_DIR and GIT_WORK_TREE effectively.
And the code works with my work pattern, which seems intuitively
correct to me.

It seems to me that this code should implement the design, and the
design should match what the code does.

However, the parallel code in the Git commands that are scripts, which
seems to be in git-sh-setup, does not implement the same design as the
C code does.

It seems to me that the two sets of Git commands should be invokable
under the same circumstances, that there is a design specification as
to how Git can be invoked, and both implementations should match that.

Dale
