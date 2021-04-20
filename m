Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA9C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE6E613AF
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhDTNhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhDTNhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85367C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so10025170wmf.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72wMm2mPufVEBlwp9ukij0QhsDbVibOnFSqed0Pqp+M=;
        b=gXGLFLzqc/LSiBYx4WIABUMS56pegY4wZmQaEjHroQfSuLIB9oR++aPKYXqcCaIwON
         awtRKWI3OlQLZ7PdI+xUd4DKYN2Z6i23kjMdSQSIANmEniuFSrAJsF4qQG+1Pd0gCwPR
         n8rwyI/SZkHQIOtHC6g6+2OHZsvOGlPzC+dKvKaLDUfAjKIzPbdD7G7CObOJEaHpIMeJ
         oaOlxiERn0EWvU6vRDanw4i1shXTCc0tVVBmBGO9Vsanc9bNzmpINGw9O5f042A3Yg7q
         IIIvvhyuJTjjyj2wn1kg/wXlw5HzLDzb3TKH00ZcGKMi4QW+BF5YwQkd7I0RnPSm1tQj
         sm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72wMm2mPufVEBlwp9ukij0QhsDbVibOnFSqed0Pqp+M=;
        b=Rs3kz5V9ocWAZ0T3z8c71SSl0rXbZRPlGw7rDOQOYnS9GPoKC7mhODOjiDHJhmp+mY
         VulGztM5/qxG2TbpGcn+qWTgP02KDy1PyXD8d/1KQbn4pDdASKYyp4PWHmohyl0HYkxa
         3wmIfiA37XRaYQyhKd1Ng0W2TAenHEcgQIcNWu234f+LYog2ZqDYBAoRocnO0jMAIHED
         Dt+6tshCQvhDaRLr/MlysXto4yCdlEHMlZtlnDgvkilVPu5dElSy/qusGUKGpOOi4TzM
         +7wqaVATgg7NydLjBGZCc9i8N8Tih6MNm/ZDSZc4jpfAuXtY4MSh9wMheGUqUKVPqPPg
         AWFA==
X-Gm-Message-State: AOAM531RvsVPh+KVPPMT5NHko9nIZbcQD+jhdZq8wgR1O1f9y2dXaRPV
        5Z4ZAsbS+sy6y1YkqI61/qg2MUVsBgZu9w==
X-Google-Smtp-Source: ABdhPJzX5qcV02iNrZ2REYZ+fAmB2253xRS1gVpel8ygeJ15zIbk7svl+/9xMuZNhUWkQvBeMIHulg==
X-Received: by 2002:a1c:64c6:: with SMTP id y189mr4700762wmb.36.1618925826009;
        Tue, 20 Apr 2021 06:37:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] object.c: add and use oid_is_type_or_die_msg() function
Date:   Tue, 20 Apr 2021 15:36:55 +0200
Message-Id: <patch-3.8-22e7d9a3db-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com> <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a oid_is_type_or_die_msg() function to go with the "error" and
"die" forms for emitting "expected type X, got Y" messages. This is
useful for callers that want the message itself as a char *.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-recursive.c |  6 ++++--
 object.c          | 12 ++++++++++++
 object.h          |  3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b952106203..c74239544f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2999,9 +2999,11 @@ static int read_oid_strbuf(struct merge_options *opt,
 	if (!buf)
 		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
-		const char* msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
+		char *msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
+		int ret = err(opt, msg);
 		free(buf);
-		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
+		free(msg);
+		return ret;
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
diff --git a/object.c b/object.c
index 9e06c0ee92..0f07f976fb 100644
--- a/object.c
+++ b/object.c
@@ -176,6 +176,18 @@ int oid_is_type_or_error(const struct object_id *oid,
 		     type_name(want));
 }
 
+char* oid_is_type_or_die_msg(const struct object_id *oid,
+				   enum object_type want,
+				   enum object_type *type)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (want == *type)
+		BUG("call this just to get the message!");
+	strbuf_addf(&sb, _(object_type_mismatch_msg), oid_to_hex(oid),
+		    type_name(*type), type_name(want));
+	return strbuf_detach(&sb, NULL);
+}
+
 void *object_as_type(struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
diff --git a/object.h b/object.h
index f8609a8518..7ae6407598 100644
--- a/object.h
+++ b/object.h
@@ -127,6 +127,9 @@ void oid_is_type_or_die(const struct object_id *oid, enum object_type want,
 			enum object_type *type);
 int oid_is_type_or_error(const struct object_id *oid, enum object_type want,
 			 enum object_type *type);
+char* oid_is_type_or_die_msg(const struct object_id *oid,
+			     enum object_type want,
+			     enum object_type *type);
 
 /*
  * Returns the object, having parsed it to find out what it is.
-- 
2.31.1.723.ga5d7868e4a

