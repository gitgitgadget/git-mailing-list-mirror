From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v7 0/3] worktree: worktree.c functions and list builtin command
Date: Fri,  4 Sep 2015 17:39:26 -0400
Message-ID: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 04 23:39:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXyi4-0000FJ-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 23:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933881AbbIDVjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 17:39:42 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36400 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933877AbbIDVjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 17:39:41 -0400
Received: by ioii196 with SMTP id i196so38100654ioi.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FlxqfiYLQ/1T6zwww1o0dNQhK5q11rcZm0703O4vS1o=;
        b=S9kekHzEOC9DAqfyhaeGjXX+VFX/fj9d7j2m6jdgnVLRLmuapbbXH00bo5rtmAYOfA
         Zfz24ZykcZKMdECae+k0Mi/bb/ggHgw1kYmnu1rZuLV0y6CfyF5Qu2J8noby4X5ogx5S
         8glasrkipfkpFnyv6Fdi6SvZTZaZGzHzg50248ZCs1ouLz4GfzCZY+E0nehyvn4VdLKG
         WPC2r6k8K8mlVjh3Vun48efEgW17GxffrDPNggVFV4HBIAZ2ZWCink30syh2InNfbIf/
         czLZLTn2l/zix1nn21yD1EF3UJc7ma34gGh2TZlK+elfeZS9awQm6E9HxeuBpBihXMtK
         ssPQ==
X-Received: by 10.107.159.199 with SMTP id i190mr10154815ioe.68.1441402780434;
        Fri, 04 Sep 2015 14:39:40 -0700 (PDT)
Received: from localhost.localdomain (155.sub-70-208-71.myvzw.com. [70.208.71.155])
        by smtp.gmail.com with ESMTPSA id vk8sm2325936igb.4.2015.09.04.14.39.38
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Sep 2015 14:39:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277335>

This series represents a major rewrite of the previous series.  It introduces
a top-level worktree.c which includes `get_worktree_list` and `get_worktree`
functions, and it also moves the `find_shared_symref` from branch.c to 
worktree.c

Michael Rappazzo (3):
  worktree: add top-level worktree.c
  worktree: move/refactor find_shared_symref from branch.c
  worktree: add 'list' command

 Documentation/git-worktree.txt |  10 ++-
 Makefile                       |   1 +
 branch.c                       |  79 +----------------
 branch.h                       |   8 --
 builtin/notes.c                |   1 +
 builtin/worktree.c             |  63 +++++++++++++
 t/t2027-worktree-list.sh       | 122 +++++++++++++++++++++++++
 worktree.c                     | 197 +++++++++++++++++++++++++++++++++++++++++
 worktree.h                     |  55 ++++++++++++
 9 files changed, 449 insertions(+), 87 deletions(-)
 create mode 100755 t/t2027-worktree-list.sh
 create mode 100644 worktree.c
 create mode 100644 worktree.h

-- 
2.5.0
