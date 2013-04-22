From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/16] remote-hg: second round of improvements
Date: Mon, 22 Apr 2013 16:55:08 -0500
Message-ID: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:57:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOjN-0000Mt-HE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3DVV4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:56:51 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:37367 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3DVV4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:56:50 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so6430619oag.18
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ksaX7GBvLpR+WSxSWdJRvxyMrZSCa2TLLxjsHAZB+GQ=;
        b=KHH5v9b00iyrh7JVV0BuIc10hOERkpND0KNpZ+yah6mrqRCQeL+YTG/9eaqHrOUyvK
         daPvdkWFddAjehaf/wbYS1vjq+mYvS6UgCiGDBqu8BxQUCs3XWUeGrdXzI2+f4axqxha
         068w8sALFNOHJqB6mxHnY5h/iARpB1YIt1/5pcVajRDpCULsxOl8aaL/2BXLsRlGCQde
         9+u+E30mkJ+2HtXjhcr0XAq13hFoXcPqQCTcTS26Tv7ES2rIjHZgf4uYP8Ke4OIw73tB
         Cfua/nJjSg1b72D2noFbgfa9XLv3X5P7k2jB60uwgH2kgFuG5nCZzrpGUo5IyePuG0Go
         QlUQ==
X-Received: by 10.60.162.102 with SMTP id xz6mr16046558oeb.69.1366667809323;
        Mon, 22 Apr 2013 14:56:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id dt3sm19780218obb.12.2013.04.22.14.56.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:56:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222097>

Hi,

Now that the safter first round is merged to master, it's time for the second
round which is a little tricker. Most of the patches should be safe, but the
later ones might be not. All the tests pass, even gitifyhg ones, so everything
seems to be fine, but we shall see.

Among the important changes are:

 * Proper support for tags (they are global, and we can push them)
 * Improved e-mail sanitaztion (a bit similar to gitifyhg, but better)
 * Support for hg schemes (like bb://felipec/repo)
 * Support for tags, bookmarks and branches with spaces
 * Performance improvements

Good stuff we should probably merge to master if there are no issues.

Cheers.

Dusty Phillips (1):
  remote-helpers: avoid has_key

Felipe Contreras (15):
  remote-hg: safer bookmark pushing
  remote-hg: use python urlparse
  remote-hg: properly mark branches up-to-date
  remote-hg: add branch_tip() helper
  remote-hg: add support for tag objects
  remote-hg: custom method to write tags
  remote-hg: write tags in the appropriate branch
  remote-hg: add custom local tag write code
  remote-hg: improve email sanitation
  remote-hg: add support for schemes extension
  remote-hg: don't update bookmarks unnecessarily
  remote-hg: allow refs with spaces
  remote-hg: small performance improvement
  remote-hg: use marks instead of inlined files
  remote-hg: strip extra newline

 contrib/remote-helpers/git-remote-bzr |   2 +-
 contrib/remote-helpers/git-remote-hg  | 167 +++++++++++++++++++++++++++-------
 contrib/remote-helpers/test-hg.sh     |   8 +-
 3 files changed, 141 insertions(+), 36 deletions(-)

-- 
1.8.2.1.790.g4588561
