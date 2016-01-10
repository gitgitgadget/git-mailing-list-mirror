From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] Implicitly use --no-index if git grep is used outside of repo
Date: Sun, 10 Jan 2016 15:19:54 +0100
Message-ID: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 15:19:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIGqY-0004PP-0Z
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 15:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613AbcAJOTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 09:19:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32981 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbcAJOTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 09:19:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id u188so22603427wmu.0
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZTrtH3KeigT6Re0z1mStx8Q/j6YIhShmX712t7cPGTo=;
        b=UMj7sCTxnfYKW8ggO3uXo71/Jx9xyqUxYGrQ5BsyurJM416ge59BPxAsiEULi8LieK
         ImZIy8rXfMACxovemZF+hQbKQkuRtv9r4csIeLE2ArtONCpNf1RSSyXmE8YzmKMqVn59
         HAY8IyQJZBJu3SnXIxjLajcEbXfBGddJYBmKrDLxYXg9xkzitPn1SYr1X0xVgaGV3Rb6
         uzY3MvYLRJSuKPBIKXCjkQThwtOr8Pd2dSsApdatV/HzlI5Q/VmqUi9HxRgIn92lA2oF
         qmtTFKzvHl44v81mrSw/drHzMJtylAb5zhlrHEzRE53bXcqYx//u+sdMhtfrRlcVlxrk
         f2QA==
X-Received: by 10.194.161.166 with SMTP id xt6mr91970618wjb.98.1452435581412;
        Sun, 10 Jan 2016 06:19:41 -0800 (PST)
Received: from localhost (host251-54-dynamic.20-79-r.retail.telecomitalia.it. [79.20.54.251])
        by smtp.gmail.com with ESMTPSA id 198sm8440583wml.22.2016.01.10.06.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2016 06:19:39 -0800 (PST)
X-Mailer: git-send-email 2.6.3.387.g749a69c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283619>

Often when looking for something in a downloaded source archive I find
myself using git grep --no-index after forgetting to use --no-index
the first time and git unhelpfully dies.

This patch series makes git grep implicitly run git grep --no-index
when run outside of a repository, analogous to how git diff works when
run outside of a repository.

Thomas Gummerer (3):
  t7810: correct --no-index test
  builtin/grep: rename use_index to no_index
  builtin/grep: allow implicit --no-index

 builtin/grep.c  | 40 ++++++++++++++++++++++++++++------------
 t/t7810-grep.sh | 45 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 17 deletions(-)

-- 
2.6.3.387.g749a69c.dirty
