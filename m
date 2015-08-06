From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] builtin/mv: remove get_pathspec()
Date: Thu,  6 Aug 2015 11:27:11 -0700
Message-ID: <1438885632-26470-2-git-send-email-sbeller@google.com>
References: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
 <1438885632-26470-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 06 20:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNPtF-0001ti-C0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 20:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbbHFS1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 14:27:21 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34862 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbbHFS1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 14:27:18 -0400
Received: by pabxd6 with SMTP id xd6so50399571pab.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 11:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Qa6IsR+npB/sU6u6gCguifmd7cvrmCcUWY9/43S/MI=;
        b=N0TK71lll7P9OfbgImD17gNgvYmuOaHhyLUOg9RuPPzy0nKHpgh8sqVzgO+tDIPx54
         pnjKvi5PRSlhrrQKZDHi7ay+4o3afMXMdWu1odFYJ+EDduYutpzfrPkM6JS0QukghxO2
         +NzCu+7Vj2Gk8XX0/xMb8LIcI/tlgYp/3wQwZMzHg+pESwkz/f2+B/7BKDRlaBgDeDjQ
         5swCY+oF3gzn2mtDNx0+ZQgTbc3U0jqSnjfPjEG0u0wQWht3KronIY/krr/3gRmJ3I58
         BpD9N8REDmCVeu7iuNb55SdeYycBViiR2oHqjqRcrIQ3slAckIEi8EO+If2/Zkq5LFLm
         /P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Qa6IsR+npB/sU6u6gCguifmd7cvrmCcUWY9/43S/MI=;
        b=bw/1m3nrTjZDH0YEBL4b4r8iJg9urqgqxME8d+aU+W6gA6PEhuV7Ngu/bjNz21qwkF
         D5W2pjPnd1E3slnp/26KWWmapL/7LDkL1YOhFIpLK7lT5gDcgjuzJ3/2Bl0t/vXcXrfC
         dILqD3obafr2wKNkF8L08Dl1O6OWUeaNTGi4uRsSA3uuVztU0foPvIiXgWQYO96XbFOg
         45XIjaSPdDzXXIbpQsoiBQyzPJNLIt8t98qLaP4sc7MbOZIEFihPkuX9BKrqO9l949lM
         GmPKPQjm2AMR3pcbbf0BBLg+jejEV1FkfmEAhTrYgyQ5JgXg4wCGpKKp2X6EoRtjDKW1
         cdTg==
X-Gm-Message-State: ALoCoQnVRz3kO0A3ud+6LpDYDEGQxpetWBiKPhXS+e6VgskEx5gOreIJia9wjMQ3g8uedmes5Hbk
X-Received: by 10.68.211.42 with SMTP id mz10mr6063092pbc.118.1438885638392;
        Thu, 06 Aug 2015 11:27:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8060:d893:ee2c:36a5])
        by smtp.gmail.com with ESMTPSA id bx13sm7369687pac.7.2015.08.06.11.27.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 11:27:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.239.g9728e1d.dirty
In-Reply-To: <1438885632-26470-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275435>

`get_pathspec` is deprecated and builtin/mv.c is its last caller, so
reimplement `get_pathspec` literally in builtin/mv.c

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/mv.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index d1d4316..99e9b3c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "pathspec.h"
 
 static const char * const builtin_mv_usage[] = {
 	N_("git mv [<options>] <source>... <destination>"),
@@ -20,13 +21,16 @@ static const char * const builtin_mv_usage[] = {
 #define KEEP_TRAILING_SLASH 2
 
 static const char **internal_copy_pathspec(const char *prefix,
-					   const char **pathspec,
+					   const char **argv,
 					   int count, unsigned flags)
 {
 	int i;
+	struct pathspec ps;
 	const char **result = xmalloc((count + 1) * sizeof(const char *));
-	memcpy(result, pathspec, count * sizeof(const char *));
+	memcpy(result, argv, count * sizeof(const char *));
 	result[count] = NULL;
+
+	/* NEEDSWORK: Move these preprocessing steps into parse_pathspec */
 	for (i = 0; i < count; i++) {
 		int length = strlen(result[i]);
 		int to_copy = length;
@@ -42,7 +46,13 @@ static const char **internal_copy_pathspec(const char *prefix,
 				result[i] = it;
 		}
 	}
-	return get_pathspec(prefix, result);
+
+	parse_pathspec(&ps,
+		       PATHSPEC_ALL_MAGIC &
+		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
+		       PATHSPEC_PREFER_CWD,
+		       prefix, result);
+	return ps._raw;
 }
 
 static const char *add_slash(const char *path)
-- 
2.5.0.239.g9728e1d.dirty
