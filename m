Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64FFC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 13:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiGGN6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbiGGN5v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 09:57:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859BDBDE
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 06:57:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n185so10688723wmn.4
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Kj6CfhH/nTywA2q+KG8xY3D//ChcfP5jNfcbwNRszb0=;
        b=K/xt7XJOFUb9YFzHGVewTaVgQI0RH8ATb+fL3tWguOaOgK62CAYvn1JhXJI08PzMEu
         zYt40ZKU7SIHCzJMM7hDzjGHgEtY98oJU1VLUPHXBndRwRraYDvpYPKfsh7/0SpQ9XLs
         6JK50f+HIUFnQM2gGupm6FHNv25G6PBZsbnKSFNfY2X7n/IhJKQ3wIVwdE+kuBxkBMXH
         e5j2lQ7EFLQvtZ9Udx0Vj1YGxye0yMwmNCfHOAapZRXCjRhECKXBpypURkDL3X4oL+Q2
         ZzSSUQP47bVnFetLI18Pl6FAzk5ApHM2izA+uXDd6uWzDQL7rtXRp2IEXy8nzdpTZeFf
         NXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kj6CfhH/nTywA2q+KG8xY3D//ChcfP5jNfcbwNRszb0=;
        b=X//wyTsMh03o5jxum/AJrMcJjtBFiKRctyYD1Nk2sqO0RIajhgRNbzCU6TO1gOBdt5
         hpox5u1wPUt2nvgBdzlxsJYhfingorIU5VT44yeyqNQpXc9lldlf+w3ahm9RiUw1BX6j
         is4OTw7yEAfMN7m8SFhGKBLsUV45rk+tw+ekQ0aLMSu7GADLGvmgdiirv9Kc6OV2axbP
         2RFDwNaKOazrqHh/vUgYpJLC46+Q7rDYIGPEeiDmZ/13IOYjkiW0hGmA48/d41xxJtzT
         3gSNnVbdUUyDHjXwKrFmvte+/Hg+Qfa8Vh0G1tn73/YSkPw9Ts/aSfqTB2I899CVvFWB
         hxLg==
X-Gm-Message-State: AJIora9YqPhse4vZYagFFvIvZw6oxoT1f1pe6K+sJg3NiGtHh2EX79ym
        KYFiiYJQTbzGGJTUlL0TliF71cHXWZk=
X-Google-Smtp-Source: AGRyM1v1qQ/wjxC8Co+JcEBvgqNzYIYOj0JqtwCHFocwey2rp15xHF4FfB12h8lV+mxLSW8U0Bp+0Q==
X-Received: by 2002:a7b:c450:0:b0:3a0:32ec:efa9 with SMTP id l16-20020a7bc450000000b003a032ecefa9mr4795630wmi.12.1657202266550;
        Thu, 07 Jul 2022 06:57:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a056000018800b0021d7f032022sm4137551wrx.17.2022.07.07.06.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:57:45 -0700 (PDT)
Message-Id: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
From:   "Jaydeep Das via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 13:57:44 +0000
Subject: [PATCH] gpg-interface: add function for converting trust level to
 string
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Jaydeep P Das <jaydeepjd.8914@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jaydeep P Das <jaydeepjd.8914@gmail.com>

Add new helper function `gpg_trust_level_to_str()` which will
convert a given member of `enum signature_trust_level` to its
corresponding string. For example, `TRUST_ULTIMATE`
will yield the string "ULTIMATE".

This will abstract out some code in `pretty.c` relating to gpg
signature trust levels.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
---
    gpg-interface: add function for converting trust level to string
    
    Add new helper function gpg_trust_level_to_str() which will convert a
    given member of enum signature_trust_level to its corresponding string.
    For example, TRUST_ULTIMATE will yield the string "ULTIMATE".
    
    This will abstract out some code in pretty.c relating to gpg signature
    trust levels.
    
    Mentored-by: Christian Couder chriscool@tuxfamily.org Mentored-by:
    Hariom Verma hariom18599@gmail.com Signed-off-by: Jaydeep Das
    jaydeepjd.8914@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1281%2FJDeepD%2Fgpg-wrap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1281/JDeepD/gpg-wrap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1281

 gpg-interface.c |  7 +++++++
 gpg-interface.h |  8 ++++++++
 pretty.c        | 23 ++++++-----------------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 947b58ad4da..fe6e5ce5127 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -165,6 +165,7 @@ static struct {
 	{ 0, "TRUST_", GPG_STATUS_TRUST_LEVEL },
 };
 
+/* Keep the order same as enum signature_trust_level */
 static struct {
 	const char *key;
 	enum signature_trust_level value;
@@ -905,6 +906,12 @@ const char *get_signing_key(void)
 	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
 }
 
+const char *gpg_trust_level_to_str(enum signature_trust_level level){
+	if (level < TRUST_UNDEFINED || level > TRUST_ULTIMATE)
+		return NULL;
+	return sigcheck_gpg_trust_level[level].key;
+}
+
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	return use_format->sign_buffer(buffer, signature, signing_key);
diff --git a/gpg-interface.h b/gpg-interface.h
index b30cbdcd3da..48f7edd916b 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -71,6 +71,14 @@ size_t parse_signed_buffer(const char *buf, size_t size);
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 		const char *signing_key);
 
+
+/*
+ * Returns corresponding string for a given member of
+ * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
+ * return "ULTIMATE".
+ */
+const char *gpg_trust_level_to_str(enum signature_trust_level level);
+
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
diff --git a/pretty.c b/pretty.c
index ee6114e3f0a..f617dd601ac 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1347,7 +1347,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
 	struct commit_list *p;
-	const char *arg, *eol;
+	const char *arg, *eol, *sig_str;
 	size_t res;
 	char **slot;
 
@@ -1575,22 +1575,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				strbuf_addstr(sb, c->signature_check.primary_key_fingerprint);
 			break;
 		case 'T':
-			switch (c->signature_check.trust_level) {
-			case TRUST_UNDEFINED:
-				strbuf_addstr(sb, "undefined");
-				break;
-			case TRUST_NEVER:
-				strbuf_addstr(sb, "never");
-				break;
-			case TRUST_MARGINAL:
-				strbuf_addstr(sb, "marginal");
-				break;
-			case TRUST_FULLY:
-				strbuf_addstr(sb, "fully");
-				break;
-			case TRUST_ULTIMATE:
-				strbuf_addstr(sb, "ultimate");
-				break;
+			sig_str = gpg_trust_level_to_str(c->signature_check.trust_level);
+			if (sig_str){
+				const char *sig_str_lower = xstrdup_tolower(sig_str);
+				strbuf_addstr(sb, sig_str_lower);
+				free((char *)sig_str_lower);
 			}
 			break;
 		default:

base-commit: 30cc8d0f147546d4dd77bf497f4dec51e7265bd8
-- 
gitgitgadget
