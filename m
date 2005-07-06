From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: cvsimport: rewritten in Perl
Date: Wed, 6 Jul 2005 08:37:12 +0200
Message-ID: <20050706063712.GV18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <20050705230226.0F9F4353A69@atlas.denx.de> <Pine.LNX.4.58.0507051936350.3570@g5.osdl.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wolfgang Denk <wd@denx.de>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 08:56:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq3ov-0006vU-O9
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 08:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVGFGzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 02:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVGFGzS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 02:55:18 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:64394 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262149AbVGFGyv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 02:54:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 8C50D33ED4
	for <git@vger.kernel.org>; Wed,  6 Jul 2005 08:54:43 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 53A1933F1F
	for <git@vger.kernel.org>; Wed,  6 Jul 2005 08:54:38 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 336974C2C5
	for <git@vger.kernel.org>; Wed,  6 Jul 2005 08:54:38 +0200 (CEST)
Received: (qmail 24574 invoked by uid 500); 6 Jul 2005 06:37:12 -0000
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Wolfgang Denk <wd@denx.de>, Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507051936350.3570@g5.osdl.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2005 at 07:41:30PM -0700, Linus Torvalds wrote:
> If you make it print out its <pid> and then pause, you can use 
> 
> 	ls -l /proc/<pid>/fd/
> 
> to get an idea of what the files may be. Looks like the new perl version 
> is leaking file descriptors..
> 
> Matthias?

That was my mistake, actually.
Thanks for spotting this.

skimo
--
git-cvsimport-script: close temporary file.

---
commit 6b6fdaa290f7dfd178a518fcafb9e14e652eb8ac
tree 725e7c6ecc75a0e90a6bc002ce540bd74dca999e
parent f4b3a4c30b5ea3a5de2a2597a3c53266017d02ba
author Sven Verdoolaege <skimo@kotnet.org> Wed, 06 Jul 2005 08:01:47 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Wed, 06 Jul 2005 08:01:47 +0200

 git-cvsimport-script |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -317,6 +317,7 @@ sub file {
 	    $res = $self->_line($fh);
 	    die "No input: $fn $rev\n" unless defined $res;
 	}
+	close ($fh);
 
 	return ($name, $res);
 }
