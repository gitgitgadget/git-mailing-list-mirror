From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv3 2/5] tag --points-at option wrapper
Date: Tue, 21 Feb 2012 17:28:47 -0800
Message-ID: <1329874130-16818-3-git-send-email-tmgrennan@gmail.com>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:29:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S011G-0004IQ-W7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab2BVB3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:29:08 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49052 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2BVB3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 20:29:05 -0500
Received: by mail-qw0-f46.google.com with SMTP id c10so4979488qad.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 17:29:05 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.137.21 as permitted sender) client-ip=10.229.137.21;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.137.21 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.137.21])
        by 10.229.137.21 with SMTP id u21mr554567qct.115.1329874145119 (num_hops = 1);
        Tue, 21 Feb 2012 17:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=qi8AP8asT9QFBJkTZawmvnlP1DkIdJhq0V7+YHf7ex4=;
        b=WCKgLYLJabVP1D5Am/9OMXBIwbcsFp39W4I62TGoqATPWNcClPUXQuGMnhWuV2/tYL
         IF9BlCIoDitilsmRkORmeuwtsQjL1kJOkPxCaRA9L0/i0tOWdYPS+Vs8UJHh3pkk+o0q
         MQn4UFw1EvD0uskvx7+TxiVqIn2xY+/FY/Sao=
Received: by 10.229.137.21 with SMTP id u21mr475924qct.115.1329874144790;
        Tue, 21 Feb 2012 17:29:04 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n8sm2148026qan.12.2012.02.21.17.29.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 17:29:03 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120211190856.GB4903@tgrennan-laptop>
References: <20120211190856.GB4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191215>

Use the OPT_CALLBACK wrapper with "--points-at" instead of an
OPTION_CALLBACK block.

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 builtin/tag.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 9dcd7d2..4a016d5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -456,10 +456,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
-		{
-			OPTION_CALLBACK, 0, "points-at", NULL, "object",
-			"print only tags of the object", 0, parse_opt_points_at
-		},
+		OPT_CALLBACK(0, "points-at", NULL, "object",
+			     "print only tags of the object",
+			     parse_opt_points_at),
 		OPT_END()
 	};
 
-- 
1.7.8
