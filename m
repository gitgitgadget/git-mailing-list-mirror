From: Paul Mackerras <paulus@samba.org>
Subject: lstat() call in rev-parse.c
Date: Sun, 23 Apr 2006 22:03:46 +1000
Message-ID: <17483.27938.890830.375324@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 23 14:04:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXdJu-0002ua-2l
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 14:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWDWMD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 08:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWDWMD7
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 08:03:59 -0400
Received: from ozlabs.org ([203.10.76.45]:36770 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751385AbWDWMD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Apr 2006 08:03:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4A680679E9; Sun, 23 Apr 2006 22:03:57 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19068>

Why does git-rev-parse do an lstat on some of its arguments, at line
345 of rev-parse.c, and die if the lstat fails?  It doesn't seem to do
anything with the result.

The effect is that if you do "gitk a b", it works as long as a and b
exist (as files or directories), but fails if they don't, and some
users have found this confusing.  Yes they should put in a --, but
it's not obvious to users why this should make it work in the case
when a or b doesn't exist.

(And yes I just took out the git-rev-parse call from gitk, but I'm
going to need to do git-rev-parse --no-refs --no-flags for some
changes I'm doing at the moment.)

Paul.
