From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-repack to optionally run git-prune-packed.
Date: Tue, 7 Mar 2006 22:29:18 +0100
Message-ID: <20060307212918.GA9474@steel.home>
References: <11417445722524-git-send-email-matlads@dsmagic.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 21:31:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGiq3-0001wX-E9
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 21:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWCGUbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWCGUbU
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 15:31:20 -0500
Received: from devrace.com ([198.63.210.113]:63236 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932073AbWCGUbT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 15:31:19 -0500
Received: from tigra.home (p54A051F3.dip.t-dialin.net [84.160.81.243])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k27KTJ0s053848;
	Tue, 7 Mar 2006 14:29:22 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FGio1-0002TQ-00; Tue, 07 Mar 2006 21:29:17 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FGjk6-0007kV-Qd; Tue, 07 Mar 2006 22:29:18 +0100
To: Martin Atukunda <matlads@dsmagic.com>
Content-Disposition: inline
In-Reply-To: <11417445722524-git-send-email-matlads@dsmagic.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL 
	autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17350>

Martin Atukunda, Tue, Mar 07, 2006 16:16:12 +0100:
> +-p::
> +	Run `git-prune-packed` after packing, see
> +	gitlink:git-prune-packed[1]
> +

Maybe just make "-d" work? I.e. "git repack -a -d" repacks and prunes
everything, and "git repack -d" prunes just what was packed
incrementally.
Something like this:

diff --git a/git-repack.sh b/git-repack.sh
index 3d6fec1..be6c7ab 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -74,6 +74,8 @@ then
 			esac
 		  done
 		)
+	else
+		git-prune-packed
 	fi
 fi
 
