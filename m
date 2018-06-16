Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9681F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756831AbeFPFmM (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:12 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:45487 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756326AbeFPFmG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:06 -0400
Received: by mail-lf0-f43.google.com with SMTP id n3-v6so17481747lfe.12
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ji3Getwn5GhbiT7F4EVtahOMDO0s1UoMyvi19u+ZfJ8=;
        b=kJWBm40l7ShnXyuLuam39zqrTJ9hg+6I2Mt3UD2RXtI9SNYZAVLZQUFenliBSI1+/q
         aHBOC73J28ViLhPu/o7MqAjm5sPnVt09+ayJL7SV8P/8+38EfxjxCVPdz8EYEdn3g/Cr
         wI6+xGHBaBmJAOhc7i1KlzYi5aOBAMSzqGOcEIsfg5+LKsosaVZbcwdSe5BdmzskF57/
         Uvnkpqk5XIJbLbQv7dDi1TW75N0gDRtpvA0jCEhT40/j4ALNI2p4TXGW4OZab05ypHQW
         EnFGL9LlOt1bJv2RurM8jQcn2D0kFRn6/V6s/O9eVawRBQ4D337e7ekrShkp6q4oHhWQ
         oOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ji3Getwn5GhbiT7F4EVtahOMDO0s1UoMyvi19u+ZfJ8=;
        b=ROIbxNJMJTvumUw1KxJXgtXSnSOL+6JQi8FmO2A7FHHvOqnMKoxLNfkLxvaSbE3+9B
         Fwy7y22tdBeVZH4x63U5NdmuldT3U+1eFRQTqe919TNRdv0zKW9jy0GrjJPHXYE0UCvX
         9KZ3FhCgTC+39R8F/lZsXv/oM0H6GMXjQj8MmBgUhRGx0974QA+TgYgkMqMtdGuhHF4K
         FoEXjRa/QK9s/pzC8pasl0N7a7MtxX8hq53/ddB2QSgyjjk9PryzSLZstilPsL9pB0mt
         4x68TvlzLyiU3YUO+GCCyqKGkVu18rfkYgA6ZfwayinzKq7xrS1dMRH/4j49uEe1MqW3
         awqQ==
X-Gm-Message-State: APt69E2/hp9IGBWrMkywOKPMecrVqC++mMe05a5lKBdgXhfBdeARsU4f
        1pLZaxRXIHN6pPedFXCaBa1AkA==
X-Google-Smtp-Source: ADUXVKJwYLU4vwn5lr9IDzI1aTyRlqeXuZYsHZIiQJS/aP+KP2tSXvNBgXeOF9t5FK6TeogP9DmP9Q==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24-v6mr3137905ljj.141.1529127724871;
        Fri, 15 Jun 2018 22:42:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/15] check-racy.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:46 +0200
Message-Id: <20180616054157.32433-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 check-racy.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/check-racy.c b/check-racy.c
index 24b6542352..485d7ab8f8 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -6,9 +6,9 @@ int main(int ac, char **av)
 	int dirty, clean, racy;
 
 	dirty = clean = racy = 0;
-	read_cache();
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	read_index(&the_index);
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		struct stat st;
 
 		if (lstat(ce->name, &st)) {
@@ -16,9 +16,9 @@ int main(int ac, char **av)
 			continue;
 		}
 
-		if (ce_match_stat(ce, &st, 0))
+		if (ie_match_stat(&the_index, ce, &st, 0))
 			dirty++;
-		else if (ce_match_stat(ce, &st, CE_MATCH_RACY_IS_DIRTY))
+		else if (ie_match_stat(&the_index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
 			racy++;
 		else
 			clean++;
-- 
2.18.0.rc0.333.g22e6ee6cdf

