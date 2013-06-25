From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 00/16] Interactive git clean
Date: Tue, 25 Jun 2013 23:53:41 +0800
Message-ID: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:54:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVa2-00045v-RM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab3FYPyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:54:40 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:46297 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab3FYPyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:54:12 -0400
Received: by mail-pd0-f170.google.com with SMTP id x11so1003730pdj.15
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+XsNtQPG/dqx2RvRQdmSH/hbTGDfoWRfHWG1RhXYABg=;
        b=V3SYQxwRTOtlb8LOwk36KecML5pKWzWI5KDGxfzB4+Zq+35LTH3dcJr9230hF+ZYxS
         UGIsyeRE6Eq2iCXdi1Jre/y20dCAtjs0sQ/+7rPYml7oUgZ7BVdt5HLmmgC83lGzzzcg
         YsFNFGiFaw1yQUfDNWx7KDslDgrC4AkKEvHyJyCMlimib/WF31tfDCRIW3LJ/a3erSaz
         7SC6+UsHf/1tytEc+XrsK6Ld5JPB7WKK36+ltf+UB36TEtzFBDwP77Fz/aPPEE1QeRHO
         +3xJSZPhDneJ6GdRSv1ubpyZX9N6iB+fGIRUR5PX3HZPNOQUoFdeHq9rh0PB/qUiX6T6
         MG6Q==
X-Received: by 10.66.171.231 with SMTP id ax7mr544061pac.32.1372175651725;
        Tue, 25 Jun 2013 08:54:11 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.54.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228968>

Update since v14:

 * Add more testcases for relative_path. See patch 01/16.

 * Refactor: change arguments name for relative_path (in path.c),
   i.e. abc -> in, base -> prefix. This is because the first
   argument is not restricted to absolute path any more.
   See patch 02/16.

 * Move git-ls-files fix from patch 05/16 to patch 03/16.
   See patch 03/16.

 * Remove NO_MINGW and related functions from t0060 script.
   See patch 16/16.

Jiang Xin (16):
  test: add test cases for relative_path
  path.c: refactor relative_path(), not only strip prefix
  quote.c: substitute path_relative with relative_path
  Refactor quote_path_relative, remove unused params
  Refactor write_name_quoted_relative, remove unused params
  git-clean: refactor git-clean into two phases
  git-clean: add support for -i/--interactive
  git-clean: show items of del_list in columns
  git-clean: add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: add filter by pattern interactive action
  git-clean: add select by numbers interactive action
  git-clean: add ask each interactive action
  git-clean: add documentation for interactive git-clean
  test: add t7301 for git-clean--interactive
  test: run testcases with POSIX absolute paths on Windows

 Documentation/config.txt     |  21 +-
 Documentation/git-clean.txt  |  71 +++-
 builtin/clean.c              | 778 +++++++++++++++++++++++++++++++++++++++++--
 builtin/grep.c               |   5 +-
 builtin/ls-files.c           |  17 +-
 cache.h                      |   2 +-
 path.c                       | 116 +++++--
 quote.c                      |  65 +---
 quote.h                      |   7 +-
 setup.c                      |   5 +-
 t/t0060-path-utils.sh        |  72 +++-
 t/t7301-clean-interactive.sh | 439 ++++++++++++++++++++++++
 test-path-utils.c            |  32 ++
 wt-status.c                  |  17 +-
 14 files changed, 1474 insertions(+), 173 deletions(-)
 create mode 100755 t/t7301-clean-interactive.sh

-- 
1.8.3.1.756.g2e9b71f
