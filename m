From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] t3513: do not compress backup tar file
Date: Fri,  6 May 2016 11:37:05 -0700
Message-ID: <20160506183705.8214-1-sbeller@google.com>
Cc: git@vger.kernel.org, peff@peff.net, megabreit@googlemail.com,
	Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 06 20:37:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aykcm-0004NS-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 20:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463AbcEFShL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 14:37:11 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33712 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758152AbcEFShK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 14:37:10 -0400
Received: by mail-pa0-f52.google.com with SMTP id xk12so50393128pac.0
        for <git@vger.kernel.org>; Fri, 06 May 2016 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=L8mL86IQDB8RaYr2ju5KNKefDrLGl8L6u+kTiZpGacA=;
        b=X2weeNa6Cu0Wqxk6faNQU0nilVfKVXIuB3BFLE1i/JOd+Epni0uuTvBVMB6YDrrbxc
         Jq2HX/uTmpP7hvOZVrBJd0wn3lbxshU1CzaBz7JKfZSS4T5Mj4fVRXizjVefY/q59M1i
         toAon/gJQwEujMcvFj/Ymq3K3bJnaCZZrzLBAG7jE2cqDyMZMkQZn0K4kjXpJ7/5fzEr
         WDa/xFrw/DdkSG9aF3wOYQPxfOy/za67DCxvPFLCjYnzz4Er3khZLxK/q9wxg9nBGrB3
         1I+RziMeWsB0JTp/nOdO3LHq518c6HvWCu2YFo9PqLMknP200G1j+mNQTv/QnHLC/nyD
         zNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L8mL86IQDB8RaYr2ju5KNKefDrLGl8L6u+kTiZpGacA=;
        b=S9x0BRtS8ht09XFa+FiLtHLjk4JmOd627SK4SnN9bGfJA3yRPUXhLGzVdIFIRv3vZD
         QgO12I/srpmY2FcJG+O2OEBah+yCNTVoxEqWjD+B07XbVCwp9X38ebayYzJTndozX96B
         dE8Ty9jHn5HFsIGu9WSsNrxUNTS++5T+RjXNukEZJmK09A4E3xs23n7gT30L1gKdVea7
         8tTTkAv8Nvf7yuXy3uPDFIET1ziTHGUJBQLajiN51L0etdNE+o9bM5uI5+inECnbGpsG
         XXPBvNtJ+u7/rhvP6/55iUux/1g7+vSr1DlNqP417u7q8ESCQLBGBYMeZizX09vAGOdq
         Hnlw==
X-Gm-Message-State: AOPr4FViJOd3O2oxzmy/FEAgn3gqy6aI6c93n2GQl2cgxBgIcBDAHBHzYDz1Dy3qmMscnQm9
X-Received: by 10.66.145.35 with SMTP id sr3mr30718285pab.82.1462559829136;
        Fri, 06 May 2016 11:37:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3c48:9bf6:3477:be87])
        by smtp.gmail.com with ESMTPSA id qb1sm22726500pac.44.2016.05.06.11.37.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 May 2016 11:37:08 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.335.g4bb51ae.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293846>

Armin Kunaschik <megabreit@googlemail.com> wrote:
> I'm trying to compile/test/use git 2.8.2 on AIX 6.1 with
> no bash available.
...
> make test does not make it through t3513-revert-submodule.sh anymore.
> The test is not portable since it uses the z-flags of GNU-tar. When -z
> is removed, (and extension is changed back to tar) everything runs and
> tests smoothly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t3513-revert-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index a1c4e02..db93781 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -14,11 +14,11 @@ test_description='revert can handle submodules'
 git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
+	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	git checkout "$1" &&
 	git revert HEAD &&
 	rm -rf * &&
-	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
+	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
-- 
2.8.2.335.g4bb51ae.dirty
