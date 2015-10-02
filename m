From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v9 0/5] worktree: list functions and command
Date: Fri,  2 Oct 2015 07:55:30 -0400
Message-ID: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Oct 02 13:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhyx0-0002Ou-CZ
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 13:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbJBL4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 07:56:08 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33266 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbbJBLzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 07:55:44 -0400
Received: by ykft14 with SMTP id t14so107991161ykf.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=t8HnnYyJqnVx6bk6DUaZkjjGvDp5kBSXtAs8qhyTKog=;
        b=kxUI73IsnRqekwipMVrwh3z4laiMguB38IK5YWjD7rWCVJEwNOxtxtg5NsZe6cA4VG
         ZYo6X2RsHzCBdzBgr5KidtYYDAp92jF2vFh0OYxiFSKXQQsTM+0a4rznEJVCSH/vuFmm
         02ebwcpsDgejHVukRBKgwuCsP9TzsLN7kTYLpO0J23CaJ5+Q3KMBfp97qoFx5J+v8JeJ
         L5L1ykooiyP4dqbLcsmaa8mNYwkoLJXKSg5JNCpi3pAHjXO0X/t/6rRlrmaiRdxHSBcM
         LgAXtQLYrnnI6i+pM0Tm2DNJmx+5kZg4K3OzGCJw+8hKolgpeCNjB4j+Ua/r4HtD7e+A
         YSgw==
X-Received: by 10.129.104.196 with SMTP id d187mr7539849ywc.94.1443786943739;
        Fri, 02 Oct 2015 04:55:43 -0700 (PDT)
Received: from localhost.localdomain (113.sub-70-208-69.myvzw.com. [70.208.69.113])
        by smtp.gmail.com with ESMTPSA id v4sm7550431ywf.5.2015.10.02.04.55.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 04:55:43 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278918>

Notable changes since v8[1]:
 - Rework the commit history to try to better maintain blame
 - Use ALLOC_GROW instead of pre-allocating when building the worktree array
 - Refine the `--porcelain` format and describe it in the documentation
 - Remove whitespace from expected and actual test output

[1]: http://thread.gmane.org/gmane.comp.version-control.git/278190

Michael Rappazzo (5):
  worktree: add top-level worktree.c
  worktree: refactor find_linked_symref function
  worktree: add a function to get worktree details
  worktree: add details to the worktree struct
  worktree: add 'list' command

 Documentation/git-worktree.txt |  49 +++++++++-
 Makefile                       |   1 +
 branch.c                       |  79 +--------------
 branch.h                       |   8 --
 builtin/notes.c                |   2 +-
 builtin/worktree.c             |  82 ++++++++++++++++
 t/t2027-worktree-list.sh       |  89 +++++++++++++++++
 worktree.c                     | 216 +++++++++++++++++++++++++++++++++++++++++
 worktree.h                     |  38 ++++++++
 9 files changed, 476 insertions(+), 88 deletions(-)
 create mode 100755 t/t2027-worktree-list.sh
 create mode 100644 worktree.c
 create mode 100644 worktree.h

-- 
2.6.0
