From: Daniel Hagerty <hag@linnaean.org>
Subject: git merge a b when a == b but neither == o is always a successful merge?
Date: Mon, 17 Nov 2014 13:39:43 -0500
Message-ID: <21610.16623.746985.383838@perdition.linnaean.org>
Reply-To: Daniel Hagerty <hag@linnaean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 19:45:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqRIr-0002gS-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 19:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbaKQSpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 13:45:30 -0500
Received: from perdition.linnaean.org ([173.166.106.33]:51351 "EHLO
	perdition.linnaean.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbaKQSp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 13:45:29 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Nov 2014 13:45:29 EST
Received: by perdition.linnaean.org (Postfix, from userid 31013)
	id C2E2F8A2; Mon, 17 Nov 2014 13:39:43 -0500 (EST)
X-Mailer: VM 7.19 under Emacs 23.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

    Given a repository setup thusly:

$ git --version
git version 2.2.0.rc2

git init .

echo '0.0' > version
git add version
git commit -m "master"
for i in a b ; do
  git checkout -b $i master

  echo '0.1' > version
  git commit -a -m "leg $i"
done

git checkout -b c master
echo '0.2' > version
git commit -a -m "leg c"

git checkout --detach a


"git merge c" produces the expected edit conflict.

"git merge b" produces a successful merge, as both branches perform
the "same" work.

For the body of content in question, this is a merge conflict.  Git
seems to have the hard-coded assumption otherwise.  I had to change
three source files to get the result I expected, and wasn't seeing
any indications of parameterization.

Am I missing some means of getting the results I need?  Thanks!
