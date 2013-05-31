From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] submodule: remove unnecessary check
Date: Fri, 31 May 2013 03:27:36 -0500
Message-ID: <1369988856-4304-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 10:29:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKiF-0001rg-4d
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab3EaI3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 04:29:23 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:58331 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab3EaI3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 04:29:20 -0400
Received: by mail-ye0-f174.google.com with SMTP id r9so299252yen.19
        for <git@vger.kernel.org>; Fri, 31 May 2013 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=iiTYX0bwBFgQ3PX+ymiggJpuqiFTWGFwgTahhK6rZu0=;
        b=TSETebFXh97NaECllSVTgZZqItvA6ZY8VfS8QZEh1PenuduASPirAzguaCK4X8Xdkp
         AXoYOCDyPWdXIpzzS2DGuih13PFXHwIeV2SHITzAhhprDet69IkcUNZygZE19WB3R2S7
         0r8B3U6s0OzthTO/LJfQE16cCBWX2PkXxntg2lnsWPX1hLr2LDtq5oHcFZln35dF9NEF
         B6R7gT9YwHxdjitAHcmmVQdTxWUr0QRfRCk4W//7WsCf5XScvqk4K3pw9oJ+xEEcl010
         EGOlHhKGR3Z3HoyUaRlwds4856v2G/ZqG/nL5oICFGBg1AIHmMY3E1VP9GxHj7svH98A
         7kxQ==
X-Received: by 10.236.230.40 with SMTP id i38mr6297125yhq.170.1369988960008;
        Fri, 31 May 2013 01:29:20 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j20sm18637587yhi.1.2013.05.31.01.29.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 01:29:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226080>

read_cache() already does that check.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 submodule.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index e728025..1821a5b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -603,9 +603,8 @@ int fetch_populated_submodules(const struct argv_array *options,
 	if (!work_tree)
 		goto out;
 
-	if (!the_index.initialized)
-		if (read_cache() < 0)
-			die("index file corrupt");
+	if (read_cache() < 0)
+		die("index file corrupt");
 
 	argv_array_push(&argv, "fetch");
 	for (i = 0; i < options->argc; i++)
-- 
1.8.3.358.g5a91d05
