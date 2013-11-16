From: Dmitry Neverov <dmitry.neverov@jetbrains.com>
Subject: submodule update and core.askpass
Date: Sun, 17 Nov 2013 01:24:30 +0400
Message-ID: <m28uwoxcoh.fsf@nds-macbook-air.labs.intellij.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 16 22:31:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhnSX-000327-OY
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 22:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab3KPVbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 16:31:12 -0500
Received: from mail1.intellij.net ([46.137.178.215]:39963 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab3KPVbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 16:31:10 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Nov 2013 16:31:10 EST
Received: (qmail 18741 invoked by uid 89); 16 Nov 2013 21:24:28 -0000
Received: from unknown (HELO nds-macbook-air.labs.intellij.net) (Dmitry.Neverov@jetbrains.com@81.3.129.2)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 16 Nov 2013 21:24:28 -0000
User-Agent: Notmuch/0.16 (http://notmuchmail.org) Emacs/24.2.92.1 (x86_64-apple-darwin12.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237940>

Hi,

it seems like "git submodule update" command doesn't respect the
core.askpass option specified in a command line. I have a repository
with a submodule, I serve it over http which requires an authorization
and both main repository and submodule require the same credentials. I
run the following commands (pass.sh is a script which prints a password
to stdout):

git -c core.askpass=pass.sh clone main-repo
cd main-repo
git submodule init
git submodule sync
git -c core.askpass=pass.sh submodule update

The last command asks for a password interactively. 

I've run bisect, it seems like it started failing from commit
be8779f7ac9a3be9aa783df008d59082f4054f67. I've checked: submodule update
works fine in 1.8.5.rc2 with removed call to clear_local_git_env.

Is there any way to make git submodule update respect core.askpass
option, so one can use it in scripts?

-- 
Dmitry Neverov
