Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC8C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDDC2053B
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhUvZ+Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgFKMFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgFKMFi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65149C08C5C2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y20so4794118wmi.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+Ejt/ZZl2KjNXrDFDrT2nFLvrKfgYWMA5ePRMfK+Ig=;
        b=OhUvZ+DwCgI3e2WqlkGHpMX31SyvgnFjlMC3ZPRTzJikuLKsYhA0lqBHl5vKnfnVjM
         dN2zOFvUW0GX6CAZhfACqN6Agz2SpWyJegbWAERTjpvQT3ziRb0n3dKET2JzzcqDdzWY
         ZdzQLNon8eeRIyYETA20JxKZkAkJq0uNQb7p0WO/Qlh1K7NrLQhpHuN8Qz9WAvjluGni
         DPjsn8gGBJEJNGGsz16I6/FPXwY0Ten1jS2sBijMusyfeqLxX98KRABdEeKHE1iWPkjf
         5TtmTEieS1XzzMh9WJq6Twpv5wGg3UIhGreRBP4/JkZI55RTLDZbeYTl1Qi6XQ21r/ee
         SR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+Ejt/ZZl2KjNXrDFDrT2nFLvrKfgYWMA5ePRMfK+Ig=;
        b=Bsn4Szh20NVaZpk732HihiUC72zTFHnQsFzavdLh0JqKC2O0+kR1oKnNwuT7X/09BA
         JAu1it3OFVrJN/1LXCzSEXcjMIcAZYOOjcCGKTSvftfEG6VgpuxxvD0NvwCcHHSC7vaP
         +/iQt6s452SGfRZUGoXGzCyI8GQ/3bGdbAT0p7s3tsdNkW70FbTg8/asmh7jkipBe200
         yjTRZzVnMmyztbTusuW8OGjSodsG7GvdpliI4KRFNSEWlYGCZplFwD+Ul7aDoRiwMuwU
         KmxOqyD5Fm3rzrbPFh/UVF+LUyrUcm9pu/plCpfFQvj0Tn8PBp4uCZ6zaa+7CaHqugId
         RkAA==
X-Gm-Message-State: AOAM532gMMfNJC303s/wWz43APtfH7BR7rSlCB5Ua/6bTaS2GUHLhTDb
        HnAIX+yhSPC9D7nPhlxixAj3hp7tMlY=
X-Google-Smtp-Source: ABdhPJwbDQDqjVh8AsoJ9LQLH5kJNQyYhO/WE1uWzfixFSGQC9Y4peBMh0nIqbhPySMsuavkKIUyQQ==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr7841963wmi.30.1591877136650;
        Thu, 11 Jun 2020 05:05:36 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:36 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/14] upload-pack: pass upload_pack_data to deepen_by_rev_list()
Date:   Thu, 11 Jun 2020 14:05:07 +0200
Message-Id: <20200611120518.10771-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200611120518.10771-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200611120518.10771-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's pass that struct to deepen_by_rev_list(),
so that this function can use all the fields of the struct.

This will be used in followup commits to move static variables
into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3f15828fd2..aa8cde6dbf 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -792,18 +792,17 @@ static void deepen(struct upload_pack_data *data, int depth)
 	send_unshallow(&data->writer, &data->shallows, &data->want_obj);
 }
 
-static void deepen_by_rev_list(struct packet_writer *writer, int ac,
-			       const char **av,
-			       struct object_array *shallows,
-			       struct object_array *want_obj)
+static void deepen_by_rev_list(struct upload_pack_data *data,
+			       int ac,
+			       const char **av)
 {
 	struct commit_list *result;
 
 	disable_commit_graph(the_repository);
 	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
-	send_shallow(writer, result);
+	send_shallow(&data->writer, result);
 	free_commit_list(result);
-	send_unshallow(writer, shallows, want_obj);
+	send_unshallow(&data->writer, &data->shallows, &data->want_obj);
 }
 
 /* Returns 1 if a shallow list is sent or 0 otherwise */
@@ -835,8 +834,7 @@ static int send_shallow_list(struct upload_pack_data *data)
 			struct object *o = data->want_obj.objects[i].item;
 			argv_array_push(&av, oid_to_hex(&o->oid));
 		}
-		deepen_by_rev_list(&data->writer, av.argc, av.argv,
-				   &data->shallows, &data->want_obj);
+		deepen_by_rev_list(data, av.argc, av.argv);
 		argv_array_clear(&av);
 		ret = 1;
 	} else {
-- 
2.27.0.90.gabb59f83a2

