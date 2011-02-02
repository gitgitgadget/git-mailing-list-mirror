From: Yann Dirson <dirson@bertin.fr>
Subject: [BUG] "git apply --index" with missing --directory option silently
 does nothing
Date: Wed, 02 Feb 2011 10:24:45 +0100
Organization: Bertin Technologies
Message-ID: <20110202102445.6ff6c8e4@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 10:46:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkZI0-0008DN-B5
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 10:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab1BBJqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 04:46:10 -0500
Received: from blois.bertin.fr ([195.68.26.9]:55727 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab1BBJqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 04:46:09 -0500
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Feb 2011 04:46:08 EST
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 6244154313
	for <git@vger.kernel.org>; Wed,  2 Feb 2011 10:38:29 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 400225430D
	for <git@vger.kernel.org>; Wed,  2 Feb 2011 10:38:29 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LFZ00GPUHG5TMB0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 02 Feb 2011 10:38:29 +0100 (CET)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.5.0.1024-17930.003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165899>


When applying a patch file for a subtree of a git repo, where was
required is "git apply --index --directory=...", if the user forgets
to add the --directory flag, then git should bomb out saying it cannot
apply the patch.

But what happens is that nothing happens, and git stays silent about
having done nothing:

~/softs/tmp/linux-2.6.32$ git rev-parse --git-dir
/home/localadm/softs/tmp/.git
~/softs/tmp/linux-2.6.32$ bzcat /home/localadm/Downloads/patch-2.6.32.28.bz2 | git apply --index --whitespace=nowarn
~/softs/tmp/linux-2.6.32$ echo $?
0
~/softs/tmp/linux-2.6.32$ git status
# On branch master
nothing to commit (working directory clean)

-- 
Yann Dirson - Bertin Technologies
