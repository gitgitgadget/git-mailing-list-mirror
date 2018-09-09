Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7051F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeIINnf (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:35 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:41958 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIINne (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:34 -0400
Received: by mail-lj1-f175.google.com with SMTP id y17-v6so15384797ljy.8
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LlcnVYvluW6oU0NzmwKOAMwd2+XpzJ0lygMtZINsPec=;
        b=qFBTFbSIkz3rTquHeKXmigzQZTZSOo2nIMGcSdlR7tdHKbj6yKJhT2/R5ai+Ssj0HY
         ob8Tl8jWkenyXb8Ne9FbiYIvQY8enupPLMVovjSaiXINLBj7jawCF2ohsjsZAImsxaeo
         uwt8ulDfYcs8oTXtEpLydFk4P3HxfXYQh89yFp9cwqa6INZbI7T/EOYhlWyV+NjkhewL
         Ix47FxZB9prMHrjYkUHePJGitEY/BVpHqdf1K80I1E0f+/0qvbQOE/9X6PbQBe5IdpZk
         2jklzl3kDTPwXy/zW8ofzS3jXEU/lNXxBe9b72kZj0h/uqtLJEAL1N1tgNpfliexXBGX
         4XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LlcnVYvluW6oU0NzmwKOAMwd2+XpzJ0lygMtZINsPec=;
        b=EYKDxgKaQyVGCy7cfaBkgau40MqwDh2f7GcEcTezTkUkYLEm8BroX0r6DK41zuUJxU
         841XcDaaB8wawDERRfFX8RWVNcar64QFde/BRI+/nuaIvTFDx+9Z9z1gb8a4Jc+wDVh9
         q9po+UlIZcarRMvvGygZE2BbIufEtaNBWtJAn+svGA5QIAJq5UhHHCioaVF6gyqHMLUe
         tz6oNvkHo7j/yXO1FL6USXyQ2mqpXP7Rjv7CQER5Ew1r0pIdm6rqrdofGgi3/xpyXttf
         gb+dV7y6ygnmL/m29R3iJHrFl4snSXZRA/MtagRJZ3uKTECAxRDOTrbefLnLigZCip2E
         wGCg==
X-Gm-Message-State: APzg51AyJ+4zY/M/ko/tcEEsMWtxB9IyL4rsEFWebW5k6MbxrHHgGHRb
        Aj/8Bs0EkhGOv05ZTqzCHkU=
X-Google-Smtp-Source: ANB0VdZDgYN6kCzvFiQtzliAc1P6NtmhKyBbhpYUFglOSCJvLm3+B+4mM1MRrRQrQZ07e+5srYY4/Q==
X-Received: by 2002:a2e:9c0f:: with SMTP id s15-v6mr9882586lji.97.1536483276073;
        Sun, 09 Sep 2018 01:54:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/23] combine-diff.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:53:59 +0200
Message-Id: <20180909085418.31531-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 combine-diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index de7695e728..4fa7707b57 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1054,7 +1054,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(&the_index, elem->path, result, len, &buf, global_conv_flags_eol)) {
+				if (convert_to_git(rev->diffopt.repo->index,
+						   elem->path, result, len, &buf, global_conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
-- 
2.19.0.rc0.337.ge906d732e7

