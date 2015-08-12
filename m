From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] cleanup submodule_config a bit.
Date: Wed, 12 Aug 2015 12:13:58 -0700
Message-ID: <1439406838-6290-3-git-send-email-sbeller@google.com>
References: <1439406838-6290-1-git-send-email-sbeller@google.com>
Cc: hvoigt@hvoigt.net, git@vger.kernel.org, jens.lehmann@web.de,
	jrnieder@gmail.com, peff@peff.net, wking@tremily.us,
	sunshine@sunshineco.com, karsten.blees@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 12 21:14:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbTe-0001vy-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbbHLTOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:14:12 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36825 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbbHLTOG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:14:06 -0400
Received: by pacrr5 with SMTP id rr5so20379507pac.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZGPJ0Q+ZyogCNBXbIzgpDheXAgTnaOdz5D/vMuHU3c=;
        b=Sl9nM6uO2aMUx3GbVxV/dna5PStRtJAmg9kjs6Hw2VENi4KR/OqWmgq16uBAtqjVm5
         ZEkY5o35lCnXqDy6hUOzl7DgY0m2gcW4mhAFl+hBxDxmR9dKYJFRqiSp8U0959wy8+E2
         7IwiMgL5FF2ffqlOjSc1SiuC9k6fICAOkRA8wK/xVRG5rwY1iE4G84X4fHHga14GN49b
         MpPhy9D9Fl/3USOqacMSZ/0cmK9aft7zplHVyscUqhafUpdvseWNN0reKvgjHbxgGT0D
         5TbYo5hGPmtK1ahr1P6B3ZlGuKXMCi1S/mnm3TR+nRZKhVcMK3I6yLMeOdtvLtZHlV30
         h+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZGPJ0Q+ZyogCNBXbIzgpDheXAgTnaOdz5D/vMuHU3c=;
        b=fnNkRIuHTkPc1TXySSPvxNLvLdTpuoViOIshk7ooa2CnIuZNJJvl9dqCpBYyeOy0Qn
         2aq+OXq4T4MFIMm4MW56Sgm2kG3MVI2OI6S7hYub+nC551f0WIJEvsWCTGx2UKdzWYqx
         LJNh0SPObgxTyqy3Tvw9lIuyNq5IfuhonwVPze0duNLp7kW/VYfxJgq6nc2KptVXJODQ
         UkabdFxGi/mfu07meXJgNSMSU8o6+CEiO8GOxdFOfulTFu5gC891ZZWceBYMKnydoB8x
         E8qXXs5RPSHJct0QHhpgC9DwqwWarh0t4Ln1tCqO2L8w5EaB74amHesF4K5JWVP/7eWn
         2Bxw==
X-Gm-Message-State: ALoCoQkVxC7RYJt4UKM6AkiVjgDawqjZATbgCv1n833c21QzVZAFdqQphzcavFF/+DcAAS4fkHag
X-Received: by 10.66.222.103 with SMTP id ql7mr69219825pac.144.1439406845724;
        Wed, 12 Aug 2015 12:14:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:d1d0:bd1:5138:d709])
        by smtp.gmail.com with ESMTPSA id i10sm7369801pdl.8.2015.08.12.12.14.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 12:14:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.234.gefc8a62
In-Reply-To: <1439406838-6290-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275801>

In the first hunk, `submodule` is NULL all the time, so we can make it clearer
by directly returning NULL.

In the second hunk, we can directly return the lookup values as it also makes
the coder clearer.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 199692b..08e93cc 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -387,7 +387,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	}
 
 	if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
-		return submodule;
+		return NULL;
 
 	switch (lookup_type) {
 	case lookup_name:
@@ -420,14 +420,12 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	switch (lookup_type) {
 	case lookup_name:
-		submodule = cache_lookup_name(cache, sha1, key);
-		break;
+		return cache_lookup_name(cache, sha1, key);
 	case lookup_path:
-		submodule = cache_lookup_path(cache, sha1, key);
-		break;
+		return cache_lookup_path(cache, sha1, key);
+	default:
+		return NULL;
 	}
-
-	return submodule;
 }
 
 static const struct submodule *config_from_path(struct submodule_cache *cache,
-- 
2.5.0.234.gefc8a62
