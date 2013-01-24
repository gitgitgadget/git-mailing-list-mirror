From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/4] Fix "git difftool --tool-help"
Date: Thu, 24 Jan 2013 19:55:12 +0000
Message-ID: <cover.1359057056.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 20:55:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySty-000771-D0
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab3AXTzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:55:37 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55489 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab3AXTzg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:55:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 04043231DC;
	Thu, 24 Jan 2013 19:55:36 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BdxFXbGd1q-B; Thu, 24 Jan 2013 19:55:35 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id B6C7823100;
	Thu, 24 Jan 2013 19:55:28 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1.364.gbbf604e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214445>

The "--tool-help" option to git-difftool currently displays incorrect
output since it uses the names of the files in
"$GIT_EXEC_PATH/mergetools/" rather than the list of command names in
git-mergetool--lib.

This series fixes this by changing it to simply delegate to a function
in git-mergetool--lib.

The first three patches are just refactorings to move the show_tool_help
function from git-mergetool to git-mergetool--lib and make it usable by
git-difftool.  The final patch switches git-difftool to use this
function.


John Keeping (4):
  git-mergetool: move show_tool_help to mergetool--lib
  git-mergetool: remove redundant assignment
  git-mergetool: don't hardcode 'mergetool' in show_tool_help
  git-difftool: use git-mergetool--lib for "--tool-help"

 git-difftool.perl     | 57 ++++++++-------------------------------------------
 git-mergetool--lib.sh | 38 ++++++++++++++++++++++++++++++++++
 git-mergetool.sh      | 37 ---------------------------------
 3 files changed, 46 insertions(+), 86 deletions(-)

-- 
1.8.1
