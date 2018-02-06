Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8DD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeBFAag (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:30:36 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41592 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFAac (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:30:32 -0500
Received: by mail-pl0-f66.google.com with SMTP id k8so132931pli.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YU3p/UErd+lCGnqUKLZjAv5EFrOZJ3/jGB2L8qPtp7k=;
        b=hEsuhHd7kasZIot3vA7u6QTv2bcrth1aVKLQSBJhI1NPEe92lJlomHwtRj64ZB2CSZ
         kVxWviePCNNhjAQFCMOPDIhnCN15PoaAXVAn/RLxxbZfLXFpeG6XdPUdQCXqYrgn2GLF
         498ImuUkxX7VXwCbO4ouk/JZjL33NOMJwsOYL+ObtQnUlis200fHHa8zRsI9TY26IRBj
         SGIX0UZMfTzO+v04TREPFYMVQoak83/sLluj8Rm89nSMAbPx8MtLJ5fiynM747G1aUuF
         mGDDlDDZ6lk/V3PW60Gq7QaouLyaF9X37HTl1eAaUklPgt9wQJ4eY2Ysjmst9FfAd6wp
         ZWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YU3p/UErd+lCGnqUKLZjAv5EFrOZJ3/jGB2L8qPtp7k=;
        b=IZPEep4x/O6g8XhNPwgmBzEmJlcZ9NlRxdiSWVFiXk+Eae1bV5nli3Yqb8H5Ny8Q1U
         rOqIJgCp9FR9RP6dTk+BcVLWeJ9kz4I+IFirdmszYsxvVhpxdgpHBvBUsBfWUr5Am9D7
         0Ul8VmYToPkLnWe2S5UgN5SZc8tgtQcWWfeaSPkD2/YIOX/sMiuuaeRqSSWu2PAVg1PK
         PVoRugV8T3lDiKuDLDMi4Z6zllsPjPi4yJ7i0o0FoBLawBxY8GKJayncxpclmkAbInxs
         DtuU8l0BbavglVAYlD7Mry+Tx56jq7B5NLnC1y7X/t0iEQKkRqZtYxbWchTZMDJvlbDV
         KlKA==
X-Gm-Message-State: APf1xPDIUTrx0Wd7bFl+u5iWWLheUvGIT7OSGrj5gJisf93HAl3gTyuO
        HffNlw83yS8bHKd7CbvtuoESk/nKr9w=
X-Google-Smtp-Source: AH8x2279hxDHEyYq1snRjNQDZ5NraijiasxFkx2Y0trVu5wlCZlzhNnXFeirPhN2zbxmQJhH/5z8mA==
X-Received: by 2002:a17:902:68c5:: with SMTP id x5-v6mr598769plm.80.1517877031666;
        Mon, 05 Feb 2018 16:30:31 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n66sm18262048pfn.111.2018.02.05.16.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:30:31 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 179/194] tag: allow deref_tag to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:34 -0800
Message-Id: <20180206001749.218943-81-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tag.c | 5 ++---
 tag.h | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tag.c b/tag.c
index 96757f37dc..d2b2bbb79c 100644
--- a/tag.c
+++ b/tag.c
@@ -64,12 +64,11 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	return ret;
 }
 
-struct object *deref_tag_the_repository(struct object *o, const char *warn, int warnlen)
+struct object *deref_tag(struct repository *r, struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
-			o = parse_object(the_repository,
-					 &((struct tag *)o)->tagged->oid);
+			o = parse_object(r, &((struct tag *)o)->tagged->oid);
 		else
 			o = NULL;
 	if (!o && warn) {
diff --git a/tag.h b/tag.h
index 91208dd2d6..91bb163e26 100644
--- a/tag.h
+++ b/tag.h
@@ -14,8 +14,7 @@ struct tag {
 extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
 extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
-#define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
-extern struct object *deref_tag_the_repository(struct object *, const char *, int);
+extern struct object *deref_tag(struct repository *r, struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
 extern int gpg_verify_tag(const struct object_id *oid,
 		const char *name_to_report, unsigned flags);
-- 
2.15.1.433.g936d1b9894.dirty

