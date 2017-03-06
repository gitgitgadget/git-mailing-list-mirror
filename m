Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C51B1FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbdCFJvh (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:37 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36061 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbdCFJvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:14 -0500
Received: by mail-wr0-f193.google.com with SMTP id l37so20946102wrc.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l3YjOsO0guzaestW33zEwKXUgB52tYrcJYUhMiNK4lk=;
        b=XWPyS+REHLSWa+AblHlPCqW1kDo1n1G8RzY5ptzA31vLVwKYv+PSywx3mRyJ15Rfdf
         5s5CAwBKJI3UQrpidsdrf2uSvxcZoj83njEIYZjz4f6H/aEIcKriNC3qSrndbVBzrntQ
         hLvV0cQyPcS1O/dCn62eiNh7RJH5K4hND0/hcZFCcmQFumiB7SEeDYbjTZ2tneeSdTid
         zSZ2TLz8gwTzBfm2UTLhzjdzwIRxMrWkjQktJCE3VU/OdYMmp+NIr6cxPTc+n/gPlLns
         hwEE4soT/bQuyp9i4yrNKXKsjoP8p2f0fZ50/wBDq5aqZD6LVpuaMZrsgB8yUIfjkCLi
         NH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l3YjOsO0guzaestW33zEwKXUgB52tYrcJYUhMiNK4lk=;
        b=K3uuel3G4ZCuQLa49meXH0RTaqgqME6NSyYJN74ZnVQ6dIIs1tgs0iFkuLQKYZE4Fm
         E7orRa6OZ06anIJ6pfCuD6hdYLinBgSsHB2urJwl1SCH0cAaS9Xp5tpnUkh+0Db4Hmc3
         aR9th84Sq9sleQ+0953exIniIKaRiEDPgrd3R+9+D/2Vq1fDFWHU06M1ZeFN0xhKbl6p
         B6ztYmFUAHBbbuEPDuLn8ePmykrk/MPwMUjKIaWtxg1eUy5rSZnUfXENrTV+0jijZQ0j
         DZ7wseCSPPcQJGnajW09fla6rmGEtrw9Jb7no/uZHfXCxcZ/AF6OgJcztJzpnVx7pbee
         tWcg==
X-Gm-Message-State: AMke39mldKFK1LTM58k8VnJK9Fy2+FpiFuAeTYpu+b43NcOZzvMKD09O4UaGrZRHMdWABQ==
X-Received: by 10.223.154.50 with SMTP id z47mr13283392wrb.76.1488793351585;
        Mon, 06 Mar 2017 01:42:31 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:30 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 10/22] config: add git_config_get_max_percent_split_change()
Date:   Mon,  6 Mar 2017 10:41:51 +0100
Message-Id: <20170306094203.28250-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function will be used in a following commit to get the
value of the "splitIndex.maxPercentChange" config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |  1 +
 config.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index 03de80daae..0bb9adcd31 100644
--- a/cache.h
+++ b/cache.h
@@ -1927,6 +1927,7 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
+extern int git_config_get_max_percent_split_change(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index 2a97696be7..35b6f02960 100644
--- a/config.c
+++ b/config.c
@@ -1746,6 +1746,21 @@ int git_config_get_split_index(void)
 	return -1; /* default value */
 }
 
+int git_config_get_max_percent_split_change(void)
+{
+	int val = -1;
+
+	if (!git_config_get_int("splitindex.maxpercentchange", &val)) {
+		if (0 <= val && val <= 100)
+			return val;
+
+		return error(_("splitIndex.maxPercentChange value '%d' "
+			       "should be between 0 and 100"), val);
+	}
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-- 
2.12.0.206.g74921e51d6.dirty

