Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545471F406
	for <e@80x24.org>; Mon, 14 May 2018 20:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeENU6D (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 16:58:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38533 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeENU6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 16:58:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so13747181wrf.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MQmGpyknQlGbmDxAVzxGCHKxejrgXVRctat9odz3WWY=;
        b=jpUO+tCjSlOUXBy2JOfL9143Dv35JPzbdo8OG3oWxIgToMGAui2zdM1ZplVgK1OSoh
         Z6Ebb/YIUw3ipdJoXIr8AugIPPtNYUhAl8LxjiVPej1yOmayfE5yH+WFnlYft0NF2u6G
         qAMl4DwY8QX8P+7wNILPpN1ecHGMvsBOBD3fIsq9Qvw7EsA9K3Bkn6nR4cG2yILVJb0N
         IgqliHCBdIGEPEI7yj9oKt9qi9UBz0qN3xC97kOZm21O4+EqNQsqhDQfyNrcIhWkcLiL
         haKcKKoIg2+bVeyBF8u5kmYgiGrAM6EB33/HNzjHMVG88gGChO8Jegu8RYH+lYCPDI87
         Ux5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MQmGpyknQlGbmDxAVzxGCHKxejrgXVRctat9odz3WWY=;
        b=EGIdSuOAa02ZftqbTYTMQphMQX3LBPsizlzg3I8RmouegftBslGpj82S8oAmu3fPoA
         2AI9b9MYCKR+0x6Kqn3L05k72CWddU0xUpmeUXYFrkiUXdXGRGwPpQs9jxzlwc5qNjPt
         XzFWOmr1x2rjhNK6o6GkUrzbtZHNWNjjC6U+5gA7P2nit9y4lBk11rNp1EdWknNw1Vuw
         8xXl3NsZWTl4qhXTqC8L+hJDJuJWBlGC9tJzn1KMRvixtWQy3PtefnPhWbohaCVtkFUu
         lGcij7MK8zS3gl9xHcarUvJSZ0AvVGgy09gf4Lwg+NL3zC5gXmljicUEObeTswXR+Lzg
         LeHg==
X-Gm-Message-State: ALKqPwc4ur2h3NJcvvsaND54ugRztrb0C+bW6Hg5M4piI0J87cQ7IpIZ
        4VsA89o3xChBwmwB56MJoKx57cXo
X-Google-Smtp-Source: AB8JxZosG4heIUC2vqIDUe7yMJ3oy3JBLn9tsQUqmWpdGIaSYUsYpd48jcxHo32FhkMjbE2Aiqosmw==
X-Received: by 2002:adf:a075:: with SMTP id l50-v6mr8997512wrl.227.1526331480854;
        Mon, 14 May 2018 13:58:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:756b:35b0:cc92:6805])
        by smtp.gmail.com with ESMTPSA id k23-v6sm14121181wrc.59.2018.05.14.13.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 13:58:00 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH 1/1] Inform about fast-forwarding of submodules during merge
Date:   Mon, 14 May 2018 22:57:37 +0200
Message-Id: <20180514205737.21313-2-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180514205737.21313-1-leif.middelschulte@gmail.com>
References: <CAGZ79kaiFkq20Com7gOLin371D2KhTPG7cqn1mQ6OaFU12kKPQ@mail.gmail.com>
 <20180514205737.21313-1-leif.middelschulte@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Inform the user about an automatically fast-forwarded submodule. The silent merge
behavior was introduced by commit 68d03e4a6e44 ("Implement automatic fast-forward
merge for submodules", 2010-07-07)).

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 merge-recursive.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index a4b91d17f..4a03044d1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1093,10 +1093,14 @@ static int merge_submodule(struct merge_options *o,
 	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, commit_b)) {
 		oidcpy(result, b);
+		output(o, 1, _("Note: Fast-forwarding submodule %s to the following commit"), path);
+		output_commit_title(o, commit_b);
 		return 1;
 	}
 	if (in_merge_bases(commit_b, commit_a)) {
 		oidcpy(result, a);
+		output(o, 1, _("Note: Fast-forwarding submodule %s to the following commit:"), path);
+		output_commit_title(o, commit_a);
 		return 1;
 	}
 
-- 
2.15.1 (Apple Git-101)

