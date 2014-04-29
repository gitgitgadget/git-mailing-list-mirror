From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] config: avoid yoda conditions
Date: Tue, 29 Apr 2014 16:49:36 -0500
Message-ID: <1398808178-3703-2-git-send-email-felipe.contreras@gmail.com>
References: <1398808178-3703-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:00:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfG4i-00072E-Ba
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbaD2WAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:00:21 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:59776 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783AbaD2WAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:00:20 -0400
Received: by mail-yk0-f178.google.com with SMTP id 200so764336ykr.37
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y2/yU/gI+BXGVO6ED63Km/NXWluwCDq58bQ+1tdCWOI=;
        b=lVT293jR7+vI1lw50XioRJEsvs2DQMWedy60CYWezLNUDR2ThA8jave7jEf6VQ84MD
         OpBbfmTQQ4IqcKpiBzQGuyw2uP+DlsG5r5Naypnr0OkqZkgEaB6uXlprBGK6jsoRfBgg
         sTiRGk3nroWQPQxHF+BCGpfhenlHT0aVkwfy7PZvMAbXS7p49ac8MdGCEu9l+GehlD+L
         vfAZwlRiRIFDxgJyAPKmV3PhFKXrPxr0dwwtC80VvgzO8KYkG1+B6t7ARIv5OQyjg36P
         vqS4zY5V1rTGCrH0Aq+utc7xn9vldxVoYVkoiqd1D0udlnoNKcHYLzA8PS3dLsYKSV+R
         VjoQ==
X-Received: by 10.236.76.105 with SMTP id a69mr803985yhe.8.1398808819792;
        Tue, 29 Apr 2014 15:00:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m26sm39110275yha.5.2014.04.29.15.00.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 15:00:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398808178-3703-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247619>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index a30cb5c..bd69ad7 100644
--- a/config.c
+++ b/config.c
@@ -616,7 +616,7 @@ static int git_config_maybe_bool_text(const char *name, const char *value)
 int git_config_maybe_bool(const char *name, const char *value)
 {
 	int v = git_config_maybe_bool_text(name, value);
-	if (0 <= v)
+	if (v >= 0)
 		return v;
 	if (git_parse_int(value, &v))
 		return !!v;
@@ -626,7 +626,7 @@ int git_config_maybe_bool(const char *name, const char *value)
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int v = git_config_maybe_bool_text(name, value);
-	if (0 <= v) {
+	if (v >= 0) {
 		*is_bool = 1;
 		return v;
 	}
-- 
1.9.2+fc1.3.gade8541
