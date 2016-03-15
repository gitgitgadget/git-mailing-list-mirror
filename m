From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] submodule-config: use hashmap_iter_first()
Date: Wed, 16 Mar 2016 01:13:15 +0600
Message-ID: <1458069195-20888-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:13:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuPK-0004Ap-PK
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965774AbcCOTN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:13:27 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36263 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965711AbcCOTN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:13:26 -0400
Received: by mail-lb0-f180.google.com with SMTP id x1so33545271lbj.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yg92s6tBjysXCyNXKqgP6zy1N2WoSTpLbeoeW3eHrM8=;
        b=D0GE75Wyhm7MHJwkpzZ5ft2kitDP6g0+i8wcYKNpTu4Nff+8eTgy9YP+G1VAOeFwKt
         QWW7JzlT0UNjMlMnSqdeHQ/sQ8pvVgr8S6nkh3aAMTZXepedyu0XHoBuzj7CoRKq3HS7
         zYKVkZC50Ai68Mf+euIbiXOeO0wHzNVSDbm6CSvsv8y8CfFQFSFE97uRHBD1YiGmRQk5
         OsuhZwkHotUYGXGKRvOvQeDiQqwbXAUqFm23GxyWzKNCkijOhClIwVUM+TrjvQ5mn37E
         hlbN0HgBMVqaaGIpTAhnB2PIwYxsdmKyGsxsiUNBtTpAfZW0lu+3FX1o/0h3enWYz+3V
         1BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yg92s6tBjysXCyNXKqgP6zy1N2WoSTpLbeoeW3eHrM8=;
        b=S7R0bY3RWh0NgHsLdG3S+TXr5Bpjr2DlYhFnShEbnPLz1aF6+pIwhS5Vg6/wRjProp
         w9qJhY2Ue8c2WdJEtgROYZxFTgwMgByzxY5EiiNvprXpNNznlgegdJVK3jTTUbNZOuQZ
         7DfzYSuhPAS0ddOMJXWvVhteTFqyQ+mcMIPAkw5YHnoX/Idy8+vRwcG79vy7r5Fihszz
         SBISmETXicFJIyqwJ4HeQM4O1Ie/9Q6uTD6UVqwFVzvrPdfc+yFNJEdmSnpEZoZuttel
         BUy/NUozLOPMqyT6CEyIhtu1QaR364W+Vd2WAg4W4hE/MBZiF+c91/939dWE6lks6VnH
         lDHA==
X-Gm-Message-State: AD7BkJKlmJdzKlEY2jgJ3y1XesUFao9V1aN+LEiG+KQwISyhYoqoZ/444KsRS4gbuHFX5g==
X-Received: by 10.112.61.233 with SMTP id t9mr10637274lbr.47.1458069204476;
        Tue, 15 Mar 2016 12:13:24 -0700 (PDT)
Received: from localhost.localhost ([2.135.251.45])
        by smtp.gmail.com with ESMTPSA id rd3sm4433414lbb.2.2016.03.15.12.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2016 12:13:23 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc2.216.g1477fb2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288894>

from the <hashmap.h> for simplification.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
Changelog: added missed Signof-off-by and function name fixed
in the commit message.

 submodule-config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index b82d1fb..8ac5031 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -405,8 +405,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		struct hashmap_iter iter;
 		struct submodule_entry *entry;
 
-		hashmap_iter_init(&cache->for_name, &iter);
-		entry = hashmap_iter_next(&iter);
+		entry = hashmap_iter_first(&cache->for_name, &iter);
 		if (!entry)
 			return NULL;
 		return entry->config;
-- 
2.8.0.rc2.216.g1477fb2.dirty
