From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] document submodule sync --recursive
Date: Thu,  3 Dec 2015 12:41:02 -0800
Message-ID: <1449175262-3724-1-git-send-email-sbeller@google.com>
References: <CAGZ79kaX4ZM++jhPcpU0T8eYDobME=iNtbH3KceWbQOOavpHnA@mail.gmail.com>
Cc: cederp@opera.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 21:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4agi-0002GC-DI
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 21:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbbLCUlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 15:41:08 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35773 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbbLCUlG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 15:41:06 -0500
Received: by pfu207 with SMTP id 207so13885708pfu.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 12:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=15POLbgE0+vzlCVeL/PKq3cHgfoeMyudjzL6XNP7utQ=;
        b=RMbqgcV/otFU0xt8MWcqN6DiBNLHb3mcXMeIzv5VL090fUvVxqqxpafzgcFCluImvG
         Yohbyq/dxl1DAw5FGTPGJp9/ZD0O8/NlkPO4rj5IhUwPCSthsy7K9A7LP0XP+2maJDRE
         /uDlQTw0LTvs5WUKaXd9+ATGmvEQLzuQYU4lRBe+pmnI+j46QLTaPDO/5KniQdOHEKGK
         IM02lg9s6z6vj6P+F5u3vjleCy9YPZioewZLz0/09QmWPNqTVNMCCCRrLl9nSlFHyc7i
         t5sKfGKhamB6JGhLO+6QB3rKCl35ylgUnRy/gi/wWbFvd6rTaUvO1lj/XcXaceRy2ibu
         L2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=15POLbgE0+vzlCVeL/PKq3cHgfoeMyudjzL6XNP7utQ=;
        b=ftlhrBbDjeu6U/J4S+/m/3PdYn/Rq+pkWUq0DR1CqqX8foq0IIE9keqmxpB8GsaTP2
         R+rOXtdSkhK+tUkdFGCl2sK20zfBB6ZJpaoeTC4qgQLVVvs0W0BMbYxLU96tkF7m/xv0
         x1pS8+LrUqz91fjbMkza14ZoNSG+OdR1WcT+pw/7KRy43ZeOurYBs87fkDfX7ajEyrTR
         cHZmfSlJuZZnpgfBDdNlyQWpLuk0QbO8vywiLw/GrJJo4RhYIFctMuLH/0YEdlU+CAwN
         v1mplq4Y5VvO7VzLFp5NiyKwggtPSheI+AZgp1RT3B1chbFs30ZqPrVul9EwZ6azLw+s
         0KTw==
X-Gm-Message-State: ALoCoQm0e15ojUJ2H0a4A2OM3igjTQ23oD3p+7r5z0jqUBnNUPCfcsfXAz17ePoSUTTG2xNh/jKm
X-Received: by 10.98.18.130 with SMTP id 2mr15972465pfs.114.1449175266450;
        Thu, 03 Dec 2015 12:41:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:29b2:2f9f:f400:babe])
        by smtp.gmail.com with ESMTPSA id u76sm12457183pfa.88.2015.12.03.12.41.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Dec 2015 12:41:05 -0800 (PST)
X-Mailer: git-send-email 2.6.1.255.gcc3df29.dirty
In-Reply-To: <CAGZ79kaX4ZM++jhPcpU0T8eYDobME=iNtbH3KceWbQOOavpHnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281969>

The git-submodule(1) is inconsistent. In the synopsis, it says:

       git submodule [--quiet] sync [--recursive] [--] [<path>...]

The description of the sync does not mention --recursive, and the
description of --recursive says that it is only available for foreach,
update and status.

The option was introduced (82f49f294c, Teach --recursive to submodule
sync, 2012-10-26) a while ago, so let's document it, too.

Reported-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This applies on either origin/master or origin/maint.
 
 Thanks,
 Stefan
 
 Documentation/git-submodule.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index f17687e..1572f05 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -237,6 +237,9 @@ sync::
 +
 "git submodule sync" synchronizes all submodules while
 "git submodule sync \-- A" synchronizes submodule "A" only.
++
+If `--recursive` is specified, this command will recurse into the
+registered submodules, and sync any nested submodules within.
 
 OPTIONS
 -------
@@ -364,7 +367,7 @@ the submodule itself.
 for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 
 --recursive::
-	This option is only valid for foreach, update and status commands.
+	This option is only valid for foreach, update, status and sync commands.
 	Traverse submodules recursively. The operation is performed not
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
-- 
2.6.1.255.gcc3df29.dirty
