From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v3 0/2] submodule: move gitdir into superproject
Date: Fri, 12 Aug 2011 21:55:11 +0200
Message-ID: <1313178913-25617-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 21:55:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrxp1-0007s6-Rw
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 21:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab1HLTzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 15:55:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59417 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1HLTzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 15:55:05 -0400
Received: by fxh19 with SMTP id 19so2518427fxh.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 12:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=X7UNGqvWyhSYJZA2LyJ9v4J3LDecTE1kGAizJOAr9n0=;
        b=CaCtlrmZgqFq6kVyeErwsBbQEgCMzzaJhwhHENn4YmVPZDxiiapq8GStUWJ3Fpu78L
         NSP52JwvAvvHRc28nczRZRwtbwU70ZnnR5q5Q+0MD2OII60JvI4TGlXnRifo7g4fWR1V
         nKwy7Nm6A/0X9Kv6j362ivb8tQ39PrtGn+5jM=
Received: by 10.223.159.207 with SMTP id k15mr1770859fax.82.1313178903891;
        Fri, 12 Aug 2011 12:55:03 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id 6sm2684532fas.26.2011.08.12.12.55.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 12:55:03 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qrxp5-0006fl-JY; Fri, 12 Aug 2011 21:55:15 +0200
X-Mailer: git-send-email 1.7.6.403.g1fd2f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179243>

Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
the superproject. This is a step towards being able to delete submodule
directories without loosing the information from their .git directory
as that is now stored outside the submodules work tree.

This is done relying on the already existent .git-file functionality.
Tests that rely on .git being a directory have been fixed.

This is the third iteration of this patchseries. In this iteration the
commit message of the second patch is updated and the fixup-patch from
Junio squashed with the first commit.

The first can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/177582

The second can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/178970/focus=179154


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
1.7.6.403.g1fd2f.dirty
