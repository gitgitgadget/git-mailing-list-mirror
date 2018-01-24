Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46541F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932822AbeAXJjI (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:39:08 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45819 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbeAXJjG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:39:06 -0500
Received: by mail-pg0-f67.google.com with SMTP id m136so2302274pga.12
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJAvfCQTfIMGqv86ovdqbO5KAYvlSwQbXX6uTfYV3ak=;
        b=IzwgXbkmCGiBquH7ke2g8IPpy61w6u12vlIK8n8W1xPwLyefDyjSLuBx7SiFsCbDwL
         tUQ/v7y34+bJbvUOh6N9nkK1j/Ip7spwp2+MCnRo6kLBcrnBok2kvWymtsdHGVc0P35Q
         o+kVzc/tGtslGB/MCoIKuB9IKdqMqFrXbUinFajjfxcfbWbD0w2ABv+Y+jKC/d8ZKRp6
         OO+AYsrpu610BEgnOEDBmQrpMiT5/F8o/wNqfEPsI7Jo/o/ZKhMiQHxHC/7dKFe9mRLR
         OeUHsUTEtN1vpRznH2WoEtJibubNjgqJHYIb+JdeQwYe1Lumf5KjAiJllPnihcjLMz1M
         B99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJAvfCQTfIMGqv86ovdqbO5KAYvlSwQbXX6uTfYV3ak=;
        b=RGfF/ZsQz7th2E//IpCN96VdeT2dNS9piF9FzBriPqq3+ehw3iA5AHIkKTdjwGyftS
         9kY7KTveYNJuOoedJDE6rCmD6bfb5/cNCebPXRa4fdQUBTb00dqQQadatpg/0V4r+Toy
         Wb1tSO+prN4+kNR7WXcqdmG8T2YW3Wh/Puazdi5EdPp/Reit2/krhWNycYI+utKFUuK9
         4YOD6oX4QX1MlsBKVykidxu68Y23HGjaFBNe8IhxKqJ72In/uYAFQX0APJQVmRbrR3Ip
         SCqrMi2Z8FhelAGjo0U1syheaXMzwZLoApoLG56A2VdOq11sCjBsW97w+s9b6ZFOjJrN
         mdAQ==
X-Gm-Message-State: AKwxytfTd6UVtnK4KUSqrpokzDlxm4e3iqQuAXWCw6MtHamq4wZyIjSB
        A93Qz6R1geQs3g7Noj/PvGJpxg==
X-Google-Smtp-Source: AH8x224ee2s/f9yHg/pVo18kmXbOmQcsELWVZ7LLAcYf3A6lHY3I4S9SXJj5hFe4AxTRoE5Bgq26Pg==
X-Received: by 10.101.82.134 with SMTP id y6mr10791747pgp.101.1516786745104;
        Wed, 24 Jan 2018 01:39:05 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id p64sm2291721pga.55.2018.01.24.01.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:39:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:39:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] read-cache.c: change type of "temp" in write_shared_index()
Date:   Wed, 24 Jan 2018 16:38:27 +0700
Message-Id: <20180124093829.12966-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124093829.12966-1-pclouds@gmail.com>
References: <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
 <20180124093829.12966-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This local variable 'temp' will be passed in from the caller in the next
patch. To reduce patch noise, let's change its type now while it's still
a local variable and get all the trival conversion out of the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..536086e1fe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2474,30 +2474,32 @@ static int clean_shared_index_files(const char *current_hex)
 static int write_shared_index(struct index_state *istate,
 			      struct lock_file *lock, unsigned flags)
 {
-	struct tempfile *temp;
+	struct tempfile *real_temp;
+	struct tempfile **temp = &real_temp;
 	struct split_index *si = istate->split_index;
 	int ret;
 
-	temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
-	if (!temp) {
+	real_temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
+	if (!real_temp) {
 		hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
 	}
+	temp = &real_temp;
 	move_cache_to_base_index(istate);
-	ret = do_write_index(si->base, temp, 1);
+	ret = do_write_index(si->base, *temp, 1);
 	if (ret) {
-		delete_tempfile(&temp);
+		delete_tempfile(temp);
 		return ret;
 	}
-	ret = adjust_shared_perm(get_tempfile_path(temp));
+	ret = adjust_shared_perm(get_tempfile_path(*temp));
 	if (ret) {
 		int save_errno = errno;
-		error("cannot fix permission bits on %s", get_tempfile_path(temp));
-		delete_tempfile(&temp);
+		error("cannot fix permission bits on %s", get_tempfile_path(*temp));
+		delete_tempfile(temp);
 		errno = save_errno;
 		return ret;
 	}
-	ret = rename_tempfile(&temp,
+	ret = rename_tempfile(temp,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret) {
 		hashcpy(si->base_sha1, si->base->sha1);
-- 
2.16.0.47.g3d9b0fac3a

