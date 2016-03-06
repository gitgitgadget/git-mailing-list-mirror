From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 13/15] branch, tag: use porcelain output
Date: Sun,  6 Mar 2016 17:35:00 +0530
Message-ID: <1457265902-7949-14-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRZ-0002Bg-Hk
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbcCFMFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:47 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35601 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbcCFMFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:36 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj10so62311367pad.2
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bmj1gDYxbrn6kTO7yClK44VkxcAWYtsWHq00CnsjOgc=;
        b=av2vq9/HYkH0JpKtEhqulc2Jl34fwkEh3nyVSoUn+Ugsu+gucWxU/wTHrT4V3hrTSa
         I4trO4zwWuDvUO3n183lDvTDhvsQQJKvIDdBWtr8PMG+KgoucauiOSX9D4NgiBiLXZEx
         8Xz/7+W7oUBSCRQZR8knl/Ntz7f54ebSgBxUsdTHIUsbmITn4ece4najQNfNNAedvvq3
         tOA4x0vFaQCy+AJKHE3hxZg3m443KJGKFxRNX5mR5NDYAyQXSN4gSQqS5Lq1uB/5fWaa
         Gz1iHHNJjc+yQbhYenvkl/+REoV4G8ZLhEyNuq0TW2EzGuMsoQuhVzaX12WvBnuApTSx
         nCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bmj1gDYxbrn6kTO7yClK44VkxcAWYtsWHq00CnsjOgc=;
        b=hKXYkZy/vvFUIK0mOWUPd0dvy6seZb/6z90R8x84gFkCD1TeS4VseIgefA0e2p4Js7
         gcoy71SB7FCDXhu6jG6WxXZCls2akQlick9uf5wvDXiWv79BHL5VpiJzaEUSoqN8pmpU
         j64jG7Fxs5JWgCYXBa7pM8e+gPqfJEow3P0Qx9Rsl+ubhmCsQEhCvenLs4PZjjuFugvh
         bD+LlV/S/jchnkjiy9fMvDrJYQY6jEmbyKz5M+PsXWQwddxRPQbU9GjfCAMIwF3UaINH
         ftYfeEpzkgsy5ugpu7ub3XZPz9JBh4lIPDSmkOHXqDoL2MN/u7kZ1UlaFjK9n+RSD7/k
         JgMw==
X-Gm-Message-State: AD7BkJIUdKnx3qgqzV7apG4PNWIIG/KW42HTdyLF3p0Gf3P0VKCMs5aWogu6FH0PvSR5Ig==
X-Received: by 10.66.122.135 with SMTP id ls7mr25960232pab.59.1457265936053;
        Sun, 06 Mar 2016 04:05:36 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:35 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288354>

Call ref-filter's setup_ref_filter_porcelain_msg() to enable
translated messages for the %(upstream:tack) atom. Although branch.c
doesn't currently use ref-filter's printing API's, this will ensure
that when it does in the future patches, we do not need to worry about
translation.

Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 2 ++
 builtin/tag.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 460f32f..8747d82 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -622,6 +622,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..82a04ed 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -373,6 +373,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));
-- 
2.7.2
