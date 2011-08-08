From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2 0/2] submodule: move gitdir into superproject
Date: Mon,  8 Aug 2011 21:17:00 +0200
Message-ID: <1312831022-12868-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 21:17:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqVJt-0002R5-Jf
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 21:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab1HHTQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 15:16:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33875 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1HHTQz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 15:16:55 -0400
Received: by fxh19 with SMTP id 19so5667069fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=kawnnBWPXnsBYltoJW8MOLxEzRC/ihMS4IyXN2Xr9DM=;
        b=XIMWYqXt1Of61hIdAl8iClL0RS4oUIKhKjIFF68gfjQEvx9RWuldlzFgLm0fiB1dKj
         985d8Su31zimaVEUUCf5rlpEnGfwF97F0CD58NQr5Yo84vNyHMUl2YUjoMAdZJ5fl88J
         LyVYpbRggII/CfjEtqnpAwyb149LdgThsM/SA=
Received: by 10.204.131.214 with SMTP id y22mr1630395bks.202.1312831012753;
        Mon, 08 Aug 2011 12:16:52 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id f13sm1726643bku.51.2011.08.08.12.16.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 12:16:51 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QqVJw-0003M9-23; Mon, 08 Aug 2011 21:17:04 +0200
X-Mailer: git-send-email 1.7.6.398.g47bcd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178970>

Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
the superproject. This is a step towards being able to delete submodule
directories without loosing the information from their .git directory
as that is now stored outside the submodules work tree.

This is done relying on the already existent .git-file functionality.
Tests that rely on .git being a directory have been fixed.

This is the second iteration of this patchseries. The first can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/177582


Fredrik Gustafsson (2):
  rev-parse: add option --is-well-formed-git-dir [path]
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
1.7.6.398.g47bcd.dirty
