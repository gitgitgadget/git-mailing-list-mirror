From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu,  5 May 2016 15:31:37 -0700
Message-ID: <1462487497-28394-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 06 00:31:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayRo9-0005rs-9i
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbcEEWbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 18:31:41 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34561 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbcEEWbl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 18:31:41 -0400
Received: by mail-pf0-f171.google.com with SMTP id y69so41917506pfb.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DKHZi4c6adicl+k4o0w/erQ7jzf6uYqyke8ox6gJXOg=;
        b=aGsfN8XKOeseO7Pwcyw8wMcO6AS1JtcuQmqlPXKej3wDPODO5nTylFBZsKa6PSaoiF
         VfSN8e4pA4VopCDHJiIwpstG07A8cIQ43txQKmC1icVNpzkjQdU4A6bQJoGlVhgUhIA0
         RPkI6QY1T/xX9nZ0Jo2TkgDXi0qstLYCaXcjFqg2JCUN9duS8IjWFYjmnfJztDgaAx4a
         kNHUO9EKYswY1d68T2YscWRa84YrMmc9cy6tt/l1nvXj0tbJPLeujdNsVKlS6lbRXJv0
         xIz9r385t/avsaKnvFAEozuMwpSGkRmlMY1olvjJnrkrTk09IC5XRnbUaNMiVsCM4/u6
         4Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DKHZi4c6adicl+k4o0w/erQ7jzf6uYqyke8ox6gJXOg=;
        b=lERk5yNYSiUJnLLJfAAVb5ma3w8sojXc1RSDru9QK/zK1aJDTe4W4OjQxxAGYzCVkS
         dJlhRBbtOu02PsY7k6uofQxrfkK6AztZOjggCTzV1PcM3iCeyof50i1Wg9Gl8qxjZFAq
         oQBcgTsElVn/XRACg9OAWvJ9r6S0bhTri4V5xGDiuUIZwd+ssYePwx6Z+7fHSu0bpXdJ
         ne5DBDttuYvXqeZF3YUQP7c6e3b16/5gpH72XLnTNaQoX5NdnsQ/h/r9QkA4vUVBQO+1
         Mpf8suSHZYBxloYiQCkiMCjMEoG9QV4XdSRVsd+3sXJjclkGvHv3G1bA6Tj1pydgeJrl
         bAIA==
X-Gm-Message-State: AOPr4FXr92rDmlpSFwMDYTSEZb3kSXMeIfd4tooHotPTq548fUJI5tahDiSUwBHsSxlQOzcn
X-Received: by 10.98.79.213 with SMTP id f82mr23970164pfj.65.1462487500427;
        Thu, 05 May 2016 15:31:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:35ed:c390:3d1b:b3bd])
        by smtp.gmail.com with ESMTPSA id xd14sm16048572pac.6.2016.05.05.15.31.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 May 2016 15:31:39 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.1.g3af9c03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293713>

`check_path_for_gitlink` was introduced in 9d67b61f739a (2013-01-06,
add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse)
but the implementation was removed in 5a76aff1a6 (2013-07-14, add:
convert to use parse_pathspec).

Remove the declaration from the header as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 pathspec.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/pathspec.h b/pathspec.h
index 0c11262..b596aed 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -96,7 +96,6 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 
 extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec);
 extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
-extern const char *check_path_for_gitlink(const char *path);
 extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
 
 #endif /* PATHSPEC_H */
-- 
2.8.0.1.g3af9c03
