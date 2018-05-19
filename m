Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D791F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbeESF2n (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:28:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39902 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeESF2j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id j193-v6so16866660lfg.6
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o49Ih2nVqYdCQKlBPozDF9X5TAJyVCGAeNk2v3ChTII=;
        b=BohNKGQ3mZy+5uR3FdkJeAMImy+hE/QXawmGhdgpXC++1M3Av17ZhJQSHHZM5sntVp
         6z8IDK3xT7M78ddExdLx+L3iZDVjnCewAb89j/htpH48YcAl5APzrrChQ7goeSj+eH/b
         G18luOL+xdfHrNA7rBKxMpXHMvyLxpGglD5mrE/sQZX0RGk4tlk+eKe3wU0rx4jbEtn9
         g6veDXttv38xbPoWV+JaxmvbQSfuEZ+bTT9WagBNnfgIAhPzxyzKwKyrKWVW7whxCME2
         2MQa6KQS8jmXaQv6DH0HTU6wZdgaNJBUOuUsvEn3fo742vK3mU4DoDSW4vDmZ44T1rNe
         siDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o49Ih2nVqYdCQKlBPozDF9X5TAJyVCGAeNk2v3ChTII=;
        b=QpLHU492DTdY/7PalkVUYhBQ//DBrQrA6Wcgf6HS28DPxQiAlR0s/LkAsz/HW6kRZR
         MDYX35CV7zA+gK+qhMr9y0uKDTYUMFAnwQzjcy01c5CuxbMOZdiExEmoh7Az/nuUli9L
         6IOszJ2RHvbCuM2op8/Wsb5ORAvTvI1AsfwQqYMobk9u8ZRdgeqNUtwNGzkA1Ev0+GOP
         BJQk1dVHqV3BcNUr5+o0Od0zTXQICwQIpFsQOsgDWe3guodr+K4NrTNBMdKzh0huVG/L
         guXNzOVYgGxYxijPZryPaRb+yjmeCQENLEygLVAnV9L3wknOqsQ2XhVi409Z3GCv67lF
         MyjA==
X-Gm-Message-State: ALKqPwf60rS8WLe2+1cEdAI8D+Xdy/8sOEbytKIm5diyuNHzUAzZl1e8
        r+03a9sV0Oz79LuEmCcaWUE=
X-Google-Smtp-Source: AB8JxZofymkkfvdMNMvvhgm/+y6XEcGTlAxdsAo0kmUGdSFJyJlhzVpw7L0Y2Vf2c+fpc71AtsjGXA==
X-Received: by 2002:a2e:638f:: with SMTP id s15-v6mr7202998lje.78.1526707717538;
        Fri, 18 May 2018 22:28:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 02/15] commit-slab: support shared commit-slab
Date:   Sat, 19 May 2018 07:28:18 +0200
Message-Id: <20180519052831.12603-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

define_shared_commit_slab() could be used in a header file to define a
commit-slab. One of these C files must include commit-slab-impl.h and
"call" implement_shared_commit_slab().
---
 commit-slab-decl.h | 13 +++++++++++++
 commit-slab-impl.h | 22 ++++++++++++++--------
 commit-slab.h      |  2 +-
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/commit-slab-decl.h b/commit-slab-decl.h
index fb5220fb7d..adc7b46c83 100644
--- a/commit-slab-decl.h
+++ b/commit-slab-decl.h
@@ -27,4 +27,17 @@ struct slabname {							\
 	(stride), 0, NULL \
 }
 
+#define declare_commit_slab_prototypes(slabname, elemtype)		\
+									\
+void init_ ##slabname## _with_stride(struct slabname *s, unsigned stride); \
+void init_ ##slabname(struct slabname *s);				\
+void clear_ ##slabname(struct slabname *s);				\
+elemtype *slabname## _at_peek(struct slabname *s, const struct commit *c, int add_if_missing); \
+elemtype *slabname## _at(struct slabname *s, const struct commit *c);	\
+elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
+
+#define define_shared_commit_slab(slabname, elemtype) \
+	declare_commit_slab(slabname, elemtype); \
+	declare_commit_slab_prototypes(slabname, elemtype)
+
 #endif /* COMMIT_SLAB_HDR_H */
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 234d9ee5f0..87a9cadfcc 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -3,11 +3,17 @@
 
 #define MAYBE_UNUSED __attribute__((__unused__))
 
-#define implement_commit_slab(slabname, elemtype) 			\
+#define implement_static_commit_slab(slabname, elemtype) \
+	implement_commit_slab(slabname, elemtype, static MAYBE_UNUSED)
+
+#define implement_shared_commit_slab(slabname, elemtype) \
+	implement_commit_slab(slabname, elemtype, )
+
+#define implement_commit_slab(slabname, elemtype, scope)		\
 									\
 static int stat_ ##slabname## realloc;					\
 									\
-static MAYBE_UNUSED void init_ ##slabname## _with_stride(struct slabname *s, \
+scope void init_ ##slabname## _with_stride(struct slabname *s,		\
 						   unsigned stride)	\
 {									\
 	unsigned int elem_size;						\
@@ -20,12 +26,12 @@ static MAYBE_UNUSED void init_ ##slabname## _with_stride(struct slabname *s, \
 	s->slab = NULL;							\
 }									\
 									\
-static MAYBE_UNUSED void init_ ##slabname(struct slabname *s)		\
+scope void init_ ##slabname(struct slabname *s)				\
 {									\
 	init_ ##slabname## _with_stride(s, 1);				\
 }									\
 									\
-static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
+scope void clear_ ##slabname(struct slabname *s)			\
 {									\
 	unsigned int i;							\
 	for (i = 0; i < s->slab_count; i++)				\
@@ -34,7 +40,7 @@ static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
 	FREE_AND_NULL(s->slab);						\
 }									\
 									\
-static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
+scope elemtype *slabname## _at_peek(struct slabname *s,			\
 						  const struct commit *c, \
 						  int add_if_missing)   \
 {									\
@@ -62,13 +68,13 @@ static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
 	return &s->slab[nth_slab][nth_slot * s->stride];		\
 }									\
 									\
-static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
+scope elemtype *slabname## _at(struct slabname *s,			\
 					     const struct commit *c)	\
 {									\
 	return slabname##_at_peek(s, c, 1);				\
 }									\
 									\
-static MAYBE_UNUSED elemtype *slabname## _peek(struct slabname *s,	\
+scope elemtype *slabname## _peek(struct slabname *s,			\
 					     const struct commit *c)	\
 {									\
 	return slabname##_at_peek(s, c, 0);				\
@@ -81,7 +87,7 @@ struct slabname
  * to allow a terminating semicolon, which makes instantiations look
  * like function declarations.  I.e., the expansion of
  *
- *    implement_commit_slab(indegree, int);
+ *    implement_commit_slab(indegree, int, static);
  *
  * ends in 'struct indegree;'.  This would otherwise
  * be a syntax error according (at least) to ISO C.  It's hard to
diff --git a/commit-slab.h b/commit-slab.h
index 32aa2c0e46..69bf0c807c 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -46,6 +46,6 @@
 
 #define define_commit_slab(slabname, elemtype) \
 	declare_commit_slab(slabname, elemtype); \
-	implement_commit_slab(slabname, elemtype)
+	implement_static_commit_slab(slabname, elemtype)
 
 #endif /* COMMIT_SLAB_H */
-- 
2.17.0.705.g3525833791

