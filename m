From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v11 00/15] *** Interactive git-clean ***
Date: Fri, 17 May 2013 17:20:04 +0800
Message-ID: <cover.1368782129.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 11:20:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGq5-0005yL-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 11:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab3EQJUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 05:20:34 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:63967 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab3EQJUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 05:20:33 -0400
Received: by mail-pd0-f176.google.com with SMTP id x10so3156993pdj.35
        for <git@vger.kernel.org>; Fri, 17 May 2013 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=B21BigPaEYOthGGc7JyIvbE2TzD6s8n7hMgkDi71Ukk=;
        b=NZqGNWux/Y5tMl1PGpb08+dlRdCd2cAxv24KcYi9SFd9ytQWr7/hO3A6oIOQKE/VkY
         KNOs9J8djxZqYiRb+LqlxJgHXbVcGE0zsP5joBHl8Jks4J6GVSntx32EdyLxpOX0GSsx
         3NlWfNWFvCFMA9w83o/tDWAajM8DGfYaDDpIt1848XT4K0WjqOSu2/vFx8hOEcl8xl9d
         wfAMZ0WqAva0U5l21hnAg5LBpn4WlUOyqri/m8lu1RxRgaIWPR1p/+6qpjpGkAlgiTsz
         R1hNbjWBxv3Pyk4jeAXNKtB5O8EY8YxUybeqv9xFFNf9j1eEQgdjg2ekgwtRf6YjzjMF
         /tAA==
X-Received: by 10.68.217.135 with SMTP id oy7mr47797042pbc.133.1368782432678;
        Fri, 17 May 2013 02:20:32 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id 10sm10531002pbm.0.2013.05.17.02.20.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 02:20:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.380.g956c2b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224664>

Update since v10:

* Patch 2/15: add test cases for relative_test() in t0060
  and test-path-utils.

* Rewrite if...else... to switch...case...

* Fixed typo in commit logs.

Jiang Xin (15):
  path.c: refactor relative_path(), not only strip prefix
  test: test relative_path through test-path-utils
  quote.c: remove path_relative, use relative_path instead
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

 Documentation/config.txt     |  21 +-
 Documentation/git-clean.txt  |  71 +++-
 builtin/clean.c              | 778 +++++++++++++++++++++++++++++++++++++++++--
 builtin/grep.c               |   5 +-
 builtin/ls-files.c           |  16 +-
 cache.h                      |   2 +-
 path.c                       | 112 +++++--
 quote.c                      |  65 +---
 quote.h                      |   7 +-
 setup.c                      |   5 +-
 t/t0060-path-utils.sh        |  23 ++
 t/t7301-clean-interactive.sh | 439 ++++++++++++++++++++++++
 test-path-utils.c            |  24 ++
 wt-status.c                  |  17 +-
 14 files changed, 1434 insertions(+), 151 deletions(-)
 create mode 100755 t/t7301-clean-interactive.sh

-- 
1.8.3.rc2.380.g956c2b2
