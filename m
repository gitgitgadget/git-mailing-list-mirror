Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 752D11F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756856AbeFPFmu (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37343 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbeFPFmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:09 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so17535901lfb.4
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COha7o08qgX0xZgndaSKRTUejiFWUJviwrhVT46bWWs=;
        b=gzExsTtiVFQmxtxWWgP3Yl7n0v+o9/IaeN61Wzgwq3gSx0uvxkZ8x8E2Z5DaAhz5bI
         h3Wo30aY/FAY+Q2odUviGeNoUd1BsCGZfyLCtKX4bohEg/m2PdF0A4MVG+XTRmeGYaUI
         5J7/3RjjG99zh4ne2lrKQHsX67yD2bRuinZiSm5DXHJmoBbWPrA5b8CUjYxUSgTpiR5y
         CFewfzugyXaTtwPh1RHobgaCb3gSFZC8xIlEqitG5FmQGYmo0EnRQi9dz/J4poBA+oLz
         DwKrv0cOWYpoXwFkkgdnGxQJoxHHgwDAT/Iq/CEUfRO5V6JEoX4JVWsya4OC7G5UdJLs
         ljQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COha7o08qgX0xZgndaSKRTUejiFWUJviwrhVT46bWWs=;
        b=TP9sdyrXrqsO7TJzcd960nmqGNbhHVhLcgW2KWHVem0hRbQRQUUgptHgfkpbpMxDjl
         IHc7UMdmrIfD/fSFdXcqMbKm21chITgjShrqh4bzX9EpoT612gacnF7qdJ1xSNB9W5zu
         6owTSEBkljJvujyp764MQDqLRSiSb46sJ2bqmObXflO/YyRZ2a7RtJA84Pi46UqS77jx
         bi3tt6/MHSi6CaU/ZIgR0W46a4emcH50QD4SgL05vIkTVHg5XwvOb6/I7MSImNGjuwij
         up+6L2mrHXtnKbPNR9w50T5uYaCJoVaIZZxAR+pZpL7iKIKet//bCdN68ORnhSinQdCk
         PsKw==
X-Gm-Message-State: APt69E3NbZ0Nt5A5NbenRvE/qjwV524VCK5OG6SD3MiUOwCIemJxE2Td
        /SGeO5w+30PXKAtXcB6HKlK2lA==
X-Google-Smtp-Source: ADUXVKKsseTPJI+JDDvPdkI+nPFXk5pbI80vDScnTPcWclg4UQNwJhiSp0+oeSGr1Bkx0FpAV8CS2Q==
X-Received: by 2002:a2e:4811:: with SMTP id v17-v6mr2908871lja.39.1529127727367;
        Fri, 15 Jun 2018 22:42:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/15] diff.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:48 +0200
Message-Id: <20180616054157.32433-7-pclouds@gmail.com>
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
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 136d44b455..975e095ed2 100644
--- a/diff.c
+++ b/diff.c
@@ -3460,7 +3460,7 @@ static int reuse_worktree_file(const char *name, const struct object_id *oid, in
 	 * by diff-cache --cached, which does read the cache before
 	 * calling us.
 	 */
-	if (!active_cache)
+	if (!the_index.cache)
 		return 0;
 
 	/* We want to avoid the working directory if our caller
@@ -3483,10 +3483,10 @@ static int reuse_worktree_file(const char *name, const struct object_id *oid, in
 		return 0;
 
 	len = strlen(name);
-	pos = cache_name_pos(name, len);
+	pos = index_name_pos(&the_index, name, len);
 	if (pos < 0)
 		return 0;
-	ce = active_cache[pos];
+	ce = the_index.cache[pos];
 
 	/*
 	 * This is not the sha1 we are looking for, or
@@ -3506,7 +3506,7 @@ static int reuse_worktree_file(const char *name, const struct object_id *oid, in
 	 * If ce matches the file in the work tree, we can reuse it.
 	 */
 	if (ce_uptodate(ce) ||
-	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
+	    (!lstat(name, &st) && !ie_match_stat(&the_index, ce, &st, 0)))
 		return 1;
 
 	return 0;
@@ -4216,14 +4216,14 @@ void diff_setup_done(struct diff_options *options)
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
 	if (options->setup & DIFF_SETUP_USE_CACHE) {
-		if (!active_cache)
+		if (!the_index.cache)
 			/* read-cache does not die even when it fails
 			 * so it is safe for us to do this here.  Also
 			 * it does not smudge active_cache or active_nr
 			 * when it fails, so we do not have to worry about
 			 * cleaning it up ourselves either.
 			 */
-			read_cache();
+			read_index(&the_index);
 	}
 	if (hexsz < options->abbrev)
 		options->abbrev = hexsz; /* full */
-- 
2.18.0.rc0.333.g22e6ee6cdf

