Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61EF208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdH3HBG (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:01:06 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37535 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdH3HBG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:01:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id t193so4473854pgc.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hkOQgENQJ/ZtQbvV3WRM3vk7uoPVXF0pwAQ2qD5zQPY=;
        b=A72gXnI7pbE8MeLuglsGe2zdLwNgQAKK2vD45F862hV84jv5UCLYinTpCjIs7rv2nW
         1W2L3YO3u8hKF8sEk/475fGO8iLOH3eeZ88vOroJ5Rlu/n8JkOAvq178V/AKW2aHj/Bb
         Ggmg2tq4xN+2J2LPJU8z7p1eeuGY8dArv1/qc3wPxGrk1q6JKXWlYQxuh7WT494LI+Fb
         oEOHPG5bIayohCsMQbtX0L/usAgtR4s+6/FVy0L7dBICU+DlRaETrOJd5IKhDMXxDYOG
         ueQmXQ8Nd8jaeZBzzQse52kELMuMRF6sDHMYhJUPgVjFU8xeS/YD894mmB8/dTzesQn7
         Co6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkOQgENQJ/ZtQbvV3WRM3vk7uoPVXF0pwAQ2qD5zQPY=;
        b=VHGX2wU3v7/kaXjPq4AZOHeV1Y0YZvMoxImNEn2kFpqeY3iSlEmQF1xnZnpyGspym2
         iQCjalvDtl6785kPtcWlWk5tElQEWsjfZ3DD/a3rLl2fQ+5cw6B4vbjdGTnqyM2XrWT/
         pz/Cl/PRZBC9g4+zmLJSfpzdOcPj+1OIc0aarUVyoHD1zNfsmJaBbyuvooXv8dT/DkKV
         x/Tz6tRzz+MbTJHAN/SX3LyAZ9W9YEj62HYlPsGXwQQxh9BLZGjYyHva95vktNfg6yd/
         mIiEQXiWu6SviFL45okAw/92A768l2jq3Pnob+eUc9BiF3uK40r5zwXWjiJMGc/g1RSe
         QqwQ==
X-Gm-Message-State: AHYfb5gu+i5YdEpG3uFjVsySWjvD36qoWlv1HjG6QTlm+f91R2qGs5/5
        Q1mmcWcTHMGJpLYii6M=
X-Received: by 10.84.224.197 with SMTP id k5mr728217pln.430.1504076465303;
        Wed, 30 Aug 2017 00:01:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id o10sm7528569pgq.68.2017.08.30.00.01.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:01:04 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:01:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 14/39] sha1_file: add repository argument to
 sha1_loose_object_info
Message-ID: <20170830070103.GO153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the sha1_loose_object_info caller
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3adae104c6..d1c8dbcfa5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1092,9 +1092,10 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1,
-				  struct object_info *oi,
-				  int flags)
+#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
+static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
+						 struct object_info *oi,
+						 int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1200,7 +1201,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
+		if (!sha1_loose_object_info(the_repository, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-- 
2.14.1.581.gf28d330327

