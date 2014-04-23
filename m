From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 0/3] New 'update-branch' hook
Date: Wed, 23 Apr 2014 14:42:37 -0500
Message-ID: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3EI-0006XM-KP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617AbaDWTxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:53:08 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:46998 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756920AbaDWTxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:53:07 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so1584186obc.6
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=t1XaptyCpdZy19SFz4LqtdG2H9AOpvDt9VjiLTWlT7c=;
        b=Sh15tegsRsUIJPQa7DKYsMGLiIHJHr7U9d2NYE7z/Hjqd7tQGGBRDvIoIIiG/YSkor
         eAuz7JfPog4vBzeJSrrr4Ht0zttSXwNynAK3cLmymZh4h+qdwJ1hO6HJ7wfn8uLXqUxX
         LnQQyQsjLPueWULNNcW44psiSfXeuZA+3TrfEWySRqEQcZYvGZPt9gLldiFC0czTQ/1j
         Hnc5pVG3Y3nGjaHUHkqgfT4PbrKMj+V6yj1DQj7NrBh65xDFxjP33ftxaKSyzwN6AZhG
         FIkcKJyTlpOc7iNVJWBnFysi3wvY393GYnt30Cpp2zbmFj5wb5AB/z0o5MP6H0CUTCOK
         ribw==
X-Received: by 10.60.42.194 with SMTP id q2mr3078043oel.66.1398282785837;
        Wed, 23 Apr 2014 12:53:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zc8sm3701509obc.1.2014.04.23.12.53.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 12:53:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246875>

Currently it's not possible to keep track of changes that happen to a branch,
specifically; when a branch is created and rebased. This patch series aims to fix that.

The last patch is the important one, but in the process of testing this I found
out that the GIT_DIR environment variable is not always set, so the hooks (all
of them) get confused.

Too many changes since v1 to list them all.


Felipe Contreras (3):
  sh-setup: export GIT_DIR
  run-command: make sure hooks have always GIT_DIR
  Add 'update-branch' hook

 Documentation/githooks.txt    | 15 +++++++++
 branch.c                      | 12 ++++++-
 builtin/clone.c               |  8 +++--
 builtin/reset.c               |  5 +++
 git-rebase--interactive.sh    |  4 +++
 git-rebase.sh                 |  4 +++
 git-sh-setup.sh               |  1 +
 run-command.c                 | 24 ++++++++++++--
 t/t5408-update-branch-hook.sh | 76 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 144 insertions(+), 5 deletions(-)
 create mode 100755 t/t5408-update-branch-hook.sh

-- 
1.9.2+fc1.1.g5c924db
