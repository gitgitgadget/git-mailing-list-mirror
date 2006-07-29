From: Russell King <rmk@arm.linux.org.uk>
Subject: git prune pig slow
Date: Sat, 29 Jul 2006 10:02:50 +0100
Message-ID: <20060729090250.GC26956@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 29 11:03:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6kj1-0001r8-SB
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 11:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWG2JC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 05:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWG2JC4
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 05:02:56 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:12554 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750784AbWG2JCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 05:02:55 -0400
Received: from flint.arm.linux.org.uk ([2002:d993:5cf9:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1G6kii-0004pP-CN
	for git@vger.kernel.org; Sat, 29 Jul 2006 10:02:52 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1G6kig-0007hm-Ol
	for git@vger.kernel.org; Sat, 29 Jul 2006 10:02:50 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24419>

Hi,

git 1.4.0, P4 2.6GHz, 1GB.

I'm trying to use "git prune" to remove some unreachable objects from
my git tree.  However, it appears to be _extremely_ expensive:

rmk      13376 91.3 15.7 165980 161556 pts/0   R+   09:50   5:14 git-fsck-object

stracing it shows that it's doing lots and lots of brk() calls.

I killed it after 10 minutes and decided to do the job manually -
git-fsck-objects --unreachable and deleting the objects one by one is
_much_ quicker than git-fsck-objects --full --cache --unreachable.

-- 
Russell King
