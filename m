From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/7] config: avoid yoda conditions
Date: Sat,  7 Dec 2013 23:56:54 -0600
Message-ID: <1386482220-18558-2-git-send-email-felipe.contreras@gmail.com>
References: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 07:05:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpXUy-0004b3-Op
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 07:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102Ab3LHGFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 01:05:45 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:61234 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab3LHGEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 01:04:34 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so2591510oag.9
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 22:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLYvLyDJycCnVYoOoqhrKz0X+KrzHq3K/xD8RdSRFNg=;
        b=ZU44U51llyv2y5aFzjhnm4a/GanJAr2mhl9aI4E5fXUxlQzWBs9UiAE6iN+lVNeYkV
         TKQrA1gk1jSNnTaJ6WQACQFWbwpc+Y1M/DYLObbGOZrd4g+aE+YWBerJ+CITjgoqRFDV
         Ec7WG1NJZeuRD6U5k/87IjXRj0YglwSxJ7t+XRU9cB1Sf4BqGRRIh2LcSKw5bhIDo3lz
         NCLDecbWiI9ftMGHtfLKgqkMO+gDXihZvgaYuzmrTo8fYpQojXmckJyG80AKF5oS5Ls7
         B5gKy7tGXKbdX/Sey83rKgrHUs7RXs027NamRWa/UZ7VLLBmkNpc7z0hnULW20e1cZHo
         HF0w==
X-Received: by 10.182.221.230 with SMTP id qh6mr8526904obc.7.1386482674521;
        Sat, 07 Dec 2013 22:04:34 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ii8sm8171340obb.11.2013.12.07.22.04.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 22:04:33 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1.2.gebd1fb1
In-Reply-To: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239035>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index e1d66a1..7a44414 100644
--- a/config.c
+++ b/config.c
@@ -610,7 +610,7 @@ static int git_config_maybe_bool_text(const char *name, const char *value)
 int git_config_maybe_bool(const char *name, const char *value)
 {
 	int v = git_config_maybe_bool_text(name, value);
-	if (0 <= v)
+	if (v >= 0)
 		return v;
 	if (git_parse_int(value, &v))
 		return !!v;
@@ -620,7 +620,7 @@ int git_config_maybe_bool(const char *name, const char *value)
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int v = git_config_maybe_bool_text(name, value);
-	if (0 <= v) {
+	if (v >= 0) {
 		*is_bool = 1;
 		return v;
 	}
-- 
1.8.5.1+fc1.2.gebd1fb1
