From: worley@alum.mit.edu (Dale R. Worley)
Subject: "git rebase" loses the additional changes in "evil" merges
Date: Mon, 4 Mar 2013 15:58:58 -0500
Message-ID: <201303042058.r24KwwEx012408@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 04 21:59:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCcTo-0000Tv-34
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 21:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455Ab3CDU7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 15:59:03 -0500
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:39255
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932218Ab3CDU7B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Mar 2013 15:59:01 -0500
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id 7R891l0060xGWP855Yz0b4; Mon, 04 Mar 2013 20:59:00 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id 7Yyz1l00w1KKtkw3YYyzne; Mon, 04 Mar 2013 20:59:00 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r24Kwxpg012409
	for <git@vger.kernel.org>; Mon, 4 Mar 2013 15:58:59 -0500
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r24KwwEx012408;
	Mon, 4 Mar 2013 15:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1362430740;
	bh=obfbYP2p2GnwJM9FFwO7wRGWFCYzGR6n1N/s33b/Wmg=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=lfzQ1nDGVQhy7wgri2nc9sApM+lSi8MaQN1QC/yXJtiVFAJbohCq0rG9gGDEGqgYy
	 DjMs5bpdcOPMvHeXAYPKQt0sOg+RLDry14Vjw8J/Q6BwQB13+MKJRZ3rc0wL31ttw8
	 y8pXtuU2WT3I2Tj+bbfzhc2s4OFgOxBf4F26X1MrlnOknkBaoabS7jcNe32RVjIigP
	 8T3cU/yajEcu07BT6ZJPb7VfwFpFVwdQyzO4Q+YPCpzjQqdpsKd66jmijKNprFfvbA
	 H5lZIzFvKwrPFh6bm4Shg7QUOIe1px6XX9GbNaUc0qrBWgRs98l7Z4PwIUR/G92OVv
	 DCklmqvLqvvzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217408>

(git version 1.7.7.6)

I've been learning how to use Git.  While exploring "git rebase", I've
discovered that if the branch being rebased contains an "evil" merge,
that is, a merge which contains changes that are in addition to the
changes in any of the parent commits, the rebase operation will
silenty lose those additional changes.

I believe that this is a serious bug.

The problem is not that Git does not propagate the additional changes
(although I'd like it to do so), the problem is that the rebase
*silently loses* changes in the code.  It would be acceptable if Git
detected the evil merge, notified me of it, and forced me to manually
re-do it in order to finish the rebase.

Throughout the Git design (as in other SCMs), care has been taken to
not lose changes that the user has introduced.  In this situation,
that principle is violated.

I have a script that demonstrates this failure, if that would be
useful for testing purposes.

Dale
