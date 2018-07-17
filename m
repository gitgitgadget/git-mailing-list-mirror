Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0F61F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbeGQMjN (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 08:39:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35059 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731719AbeGQMjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id y22-v6so1275401wma.0
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=rRaakYk0ybfpsoNkTpDlP92Z0RzXF7Ubh55NU1nApEU=;
        b=fzIbxzg5PZt7sXo1vDWazvVDBv8OgwEGWfaYpgnHwWp0BzaaTw1PCCfO0jeXcvgLy7
         HWC18TByCqaXDxFT69IwACMvtECwpSOblEWPk1tKGLjJUopiLEGs/TPVX2IH8iMj4ZuY
         uoB/yXNMfPkCltNc6qJrkpBCWNmkXLBIrMdmnvTOSpeErc1gvrPeC/1h84N4VJPR+tIO
         K/XyYEmjb+XAFf8gedFAXtbCErtyqxtVrkn4SE5kdnF1x2jXcGr7N2ESC6IFCBi2vG4U
         HuIF1tC9qX1jm4ioYVoaqu4fJuEeJC5HDLFGS5zX+imUwZFXbBdbprymjIsk4q3+3N7H
         B8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=rRaakYk0ybfpsoNkTpDlP92Z0RzXF7Ubh55NU1nApEU=;
        b=jv+U5gioRW8+YDYvFk88mNciJEm1IMckdndqC4gfwyqHhd3qODPlZAm5ExYDmUXRyq
         +MQTMZquYbEXSGmcvBJgqjyczFRjcWFtP4m+P86o2XOcMSSqa0xB+XEpb47/YrOIfsu2
         Ws4Qhsr6ytP5bFMt7ACJMjI/DkZfZ+TaCOWYVb4mr03OzFfAg2RLFtJf/a1ckgyhF/bY
         av8cnrsWXB2buwNLpVsGkLdLsFg4rCxAhRHDkOFCXs0OLVNDzIJNywhWX+5tmd5tIFGS
         9CuHMRN/HIMlK9DE9DeCLB84N9jiPxOl0Utx/fE4pFN/PomB5UySlu1yY5BzyCoLoSVI
         U9nw==
X-Gm-Message-State: AOUpUlFM55Zmgl7tI+FcteDQ+ko6KpGIm37ij5Mf9XwbfL9zai+4anQv
        RZc73SMoSMn8d3TfC9wINGN8GA==
X-Google-Smtp-Source: AAOMgpcfx/hbhEjJgO23i+TzIxcQe/+KxBYLGiC2QbiX5l0AfWMWelgpr18i8gjKIEPMhkJH+mfmGw==
X-Received: by 2002:a1c:6d1c:: with SMTP id i28-v6mr1248026wmc.97.1531829211381;
        Tue, 17 Jul 2018 05:06:51 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-157-218.residential.rdsnet.ro. [5.13.157.218])
        by smtp.gmail.com with ESMTPSA id d4-v6sm542099wrp.51.2018.07.17.05.06.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 05:06:50 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 6/6] sha1-name: Add gentle alternative for `get_oid()`
Date:   Tue, 17 Jul 2018 15:06:36 +0300
Message-Id: <046f5f7a3495acbbb53ee2b7007d5c058f18cc0b.1531778417.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.184.ga79db55c2.dirty
In-Reply-To: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add `get_oid_gently()` to be a gentle alternative to `get_oid()`.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 cache.h     | 1 +
 sha1-name.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/cache.h b/cache.h
index cb8803e2f..36e196202 100644
--- a/cache.h
+++ b/cache.h
@@ -1321,6 +1321,7 @@ struct object_context {
 	GET_OID_TREE | GET_OID_TREEISH | \
 	GET_OID_BLOB)
 
+extern int get_oid_gently(const char *str, struct object_id *oid);
 extern int get_oid(const char *str, struct object_id *oid);
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index a5d4e0dc7..6ee48fdf7 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1474,6 +1474,12 @@ int get_oid(const char *name, struct object_id *oid)
 	return get_oid_with_context(name, 0, oid, &unused);
 }
 
+int get_oid_gently(const char *name, struct object_id *oid)
+{
+	struct object_context unused;
+	return get_oid_with_context(name, GET_OID_GENTLY, oid, &unused);
+}
+
 
 /*
  * Many callers know that the user meant to name a commit-ish by
-- 
2.18.0.rc2.184.ga79db55c2.dirty

