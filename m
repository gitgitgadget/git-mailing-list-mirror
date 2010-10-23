From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v7 0/3] Detection of directory renames
Date: Sat, 23 Oct 2010 23:06:59 +0200
Message-ID: <1287868022-24872-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 23 23:07:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9lJH-0007Au-Fr
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 23:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab0JWVHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 17:07:20 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38755 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934Ab0JWVHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 17:07:19 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id CEFE3D480DA;
	Sat, 23 Oct 2010 23:07:12 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P9lIx-00010G-S7; Sat, 23 Oct 2010 23:07:08 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159825>

Changes since v6.1:
* now using a sorted list for bulkmove_candidates, improved lookup code
* added a bit of doc
* fixed decl-after-stmt and code style issues (Junio)
* fixed signedness of i_am_not_single bitfield (sparse)
* removed useless filtering of debug messages in tests
* avoid using "git update-index" where "git mv" and friends are more readable
* added a testcase for move of a subdir, fixed the code
* more naming normalisation
* added short note in commit message about implementation
* added Thanks-to's to commit messages (hope I did not forget anyone)
* added more possible future uses to commit message
* moved list of optimisation opportunities from FIXME's to commit message,
  leaving only a handful of things as real FIXME tags (purposely kept as C99
  comments)


Yann Dirson (3):
  Introduce bulk-move detection in diffcore.
  Add testcases for the --detect-bulk-moves diffcore flag.
  [WIP] Allow hiding renames of individual files involved in a
    directory rename.

 Documentation/diff-options.txt   |    4 +
 Documentation/gitdiffcore.txt    |   12 +
 diff-lib.c                       |    6 +-
 diff.c                           |   21 ++-
 diff.h                           |    6 +
 diffcore-rename.c                |  418 ++++++++++++++++++++++++++++++++++++-
 diffcore.h                       |    2 +
 t/t4046-diff-rename-factorize.sh |  296 +++++++++++++++++++++++++++
 tree-diff.c                      |    4 +-
 9 files changed, 753 insertions(+), 16 deletions(-)
 create mode 100755 t/t4046-diff-rename-factorize.sh

-- 
1.7.2.3
