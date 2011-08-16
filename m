From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v5 0/2] submodule: move gitdir into superproject
Date: Tue, 16 Aug 2011 21:32:17 +0200
Message-ID: <1313523139-23244-1-git-send-email-iveqy@iveqy.com>
Cc: jens.lehmann@web.de, iveqy@iveqy.com, hvoigt@hvoigt.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 21:32:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtPNA-0008LV-0n
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 21:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab1HPTcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 15:32:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44112 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab1HPTcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 15:32:16 -0400
Received: by bke11 with SMTP id 11so178010bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=BCjTDn7ctUdmwlzMGma++4/XUo5R8IEKMw4QPktAR9w=;
        b=sLWIAQVkfd0esDaqHtD1xvRMa3p09Pm9aGXa4IjN5L3XTDZ2eOFHaOX5nF/dgo/J2h
         ViwLtXUEy1vh1HXve2ta3Vz5/BWtccxOPu4kTGgNy6GWX3wWmACHt9DkCpXdH/0KfTkh
         vtU0wvvn6Ph2trFsWqWHbKXb6UvKFal7rG7QA=
Received: by 10.204.173.2 with SMTP id n2mr47323bkz.13.1313523134918;
        Tue, 16 Aug 2011 12:32:14 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id y8sm127460bks.21.2011.08.16.12.32.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 12:32:11 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QtPN6-000643-Cl; Tue, 16 Aug 2011 21:32:20 +0200
X-Mailer: git-send-email 1.7.6.398.g43b167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179470>

Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
the superproject. This is a step towards being able to delete submodule
directories without loosing the information from their .git directory
as that is now stored outside the submodules work tree.

This is done relying on the already existent .git-file functionality.
Tests that rely on .git being a directory have been fixed.

This is the forth iteration of this patchseries. The only change since last
iteration is the removal of a test of the return value of module_name in
git-submodule.sh, as suggested by Junio.

The first can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/177582

The second can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/178970/focus=179153

The third can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179243/focus=179244

The fourth can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179388/focus=179390

Fredrik Gustafsson (2):
  rev-parse: add option --resolve-git-dir <path>
  Move git-dir for submodules

 Documentation/git-rev-parse.txt |    4 ++
 builtin/rev-parse.c             |    8 +++
 cache.h                         |    1 +
 git-submodule.sh                |   45 ++++++++++++++--
 setup.c                         |    7 +++
 t/t7400-submodule-basic.sh      |    4 +-
 t/t7403-submodule-sync.sh       |    5 +-
 t/t7406-submodule-update.sh     |  107 +++++++++++++++++++++++++++++++++++++++
 t/t7407-submodule-foreach.sh    |  103 +++++++++++++++++++------------------
 t/t7408-submodule-reference.sh  |    4 +-
 10 files changed, 227 insertions(+), 61 deletions(-)

-- 
1.7.6.398.g43b167
