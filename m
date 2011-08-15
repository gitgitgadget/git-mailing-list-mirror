From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v4 0/2] submodule: move gitdir into superproject
Date: Mon, 15 Aug 2011 23:17:45 +0200
Message-ID: <1313443067-2642-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	iveqy@iveqy.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 23:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt4Xd-0004xy-6R
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 23:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab1HOVRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 17:17:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45463 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1HOVRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 17:17:40 -0400
Received: by bke11 with SMTP id 11so3270146bke.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=RWgRdUwuj6ZVPes8YvL9QeBykg6dy+7GspcihpX5TVU=;
        b=Ku7q+hQXBCJnL68YkchGPZn5rtlkCPT7yaLf2m9DpR9zprIwwlMh44TkrPTVmg+Huh
         5rbgZiGdpUSJHHGtrx9XYQyUmEd0nGon4txrWp0ureMFT9UKdM9tFlxOhvNuG9OTrtmo
         QLxozSAoIdOlc3yaBa/9ZuvlOxmdwgCbdEVS8=
Received: by 10.205.64.207 with SMTP id xj15mr608063bkb.346.1313443058072;
        Mon, 15 Aug 2011 14:17:38 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id n9sm1664621bkd.7.2011.08.15.14.17.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 14:17:37 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qt4Xd-0000hI-92; Mon, 15 Aug 2011 23:17:49 +0200
X-Mailer: git-send-email 1.7.6.399.gb7922a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179388>

Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
the superproject. This is a step towards being able to delete submodule
directories without loosing the information from their .git directory
as that is now stored outside the submodules work tree.

This is done relying on the already existent .git-file functionality.
Tests that rely on .git being a directory have been fixed.

This is the forth iteration of this patchseries.

The first can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/177582

The second can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/178970/focus=179153

The third can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179243/focus=179244


Fredrik Gustafsson (2):
  rev-parse: add option --resolve-git-dir <path>
  Move git-dir for submodules

 Documentation/git-rev-parse.txt |    4 ++
 builtin/rev-parse.c             |    8 +++
 cache.h                         |    1 +
 git-submodule.sh                |   49 ++++++++++++++++--
 setup.c                         |    7 +++
 t/t7400-submodule-basic.sh      |    4 +-
 t/t7403-submodule-sync.sh       |    5 +-
 t/t7406-submodule-update.sh     |  107 +++++++++++++++++++++++++++++++++++++++
 t/t7407-submodule-foreach.sh    |  103 +++++++++++++++++++------------------
 t/t7408-submodule-reference.sh  |    4 +-
 10 files changed, 231 insertions(+), 61 deletions(-)

-- 
1.7.6.398.gb3f84
