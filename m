From: Roland Schulz <roland@rschulz.eu>
Subject: [PATCH] Add no-git-links option to ls-files
Date: Wed, 11 Jun 2014 19:37:27 -0400
Message-ID: <5398E837.6060309@rschulz.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 01:37:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wus5H-0004Mr-3a
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 01:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbaFKXhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 19:37:31 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43439 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbaFKXha (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 19:37:30 -0400
Received: by mail-ig0-f182.google.com with SMTP id a13so1406010igq.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 16:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rschulz.eu; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=MXyoQXSYzM0vQvVXhr9VaceKxSzbTneEviwIUjFq2hE=;
        b=GhXY3lwDMINF0iu49eHsrSvD7hwahkX1hQ+DbSMT81jAy6wN7UuRANgyIpY94SIPw0
         B/2SpdFmalUeUgJySoTKThZ56JKdsKzV/nKT7r6rbhW4J5Ho6JztqjWgClHeQG2XP/Hs
         BLuWzoHraUyMr4m0jvWtH3GfmxlnG0ScONNco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=MXyoQXSYzM0vQvVXhr9VaceKxSzbTneEviwIUjFq2hE=;
        b=NNj/uhf+ZvgmIIm0MJYM6RCKb/YTi5ZwJgzGHvYv11/OZLtI+trzAF5LCnVgVTrZRM
         X9vemp1htJMsVq6RoV8zCXADRXrB4YLT3acBBgrNsbh3w2Ylds8y2bydLVaBGJK0JqC3
         dYZ2BxjcnS7kWT0G7+JUTWNviESqmBenFOSOXSoOifhaDTpdkiHDcuyL7pfUKMckq6nV
         0lnKqRKKVnWXMyvx/AUn8Se7UA0Z4Dqz6lQaFl+UQOkYYqNDf/dsLJCFeFs6mFfFHLDJ
         nTW+LaBdtTexro27Xcw8bwK282r2BUArxE96vQUIElVkfAY9xsWU+d/C/3rr5rsvBw5R
         SKJA==
X-Gm-Message-State: ALoCoQlHxnJo51iNUTXQ5EFxSxzMRGTjCp4VsZJ6ML/QOxbIt0nsNb9Mg2pEKlTgHIa5XX7Xur/Z
X-Received: by 10.43.151.7 with SMTP id kq7mr31030377icc.78.1402529849732;
        Wed, 11 Jun 2014 16:37:29 -0700 (PDT)
Received: from ?IPv6:2602:306:37fc:4adf:17f:912a:8ed8:3877? ([2602:306:37fc:4adf:17f:912a:8ed8:3877])
        by mx.google.com with ESMTPSA id g2sm111606685igc.12.2014.06.11.16.37.28
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 16:37:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251391>

Setting the option allows to list files in submodules.

Signed-off-by: Roland Schulz <roland@utk.edu>
---
 Documentation/git-ls-files.txt | 4 ++++
 builtin/ls-files.c             | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index e26f01f..71284de 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -64,6 +64,10 @@ OPTIONS
 --no-empty-directory::
        Do not list empty directories. Has no effect without --directory.
 
+--no-git-links::
+       If a directory looks like a repository, then show its whole
+       contents not just its name.
+
 -u::
 --unmerged::
        Show unmerged files in the output (forces --stage)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 47c3880..47352e0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -479,6 +479,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
                OPT_NEGBIT(0, "empty-directory", &dir.flags,
                        N_("don't show empty directories"),
                        DIR_HIDE_EMPTY_DIRECTORIES),
+               OPT_NEGBIT(0, "git-links", &dir.flags,
+                       N_("show content for directories containing repositories"),
+                       DIR_NO_GITLINKS),
                OPT_BOOL('u', "unmerged", &show_unmerged,
                        N_("show unmerged files in the output")),
                OPT_BOOL(0, "resolve-undo", &show_resolve_undo,
-- 
2.0.0.239.g0953113.dirty
