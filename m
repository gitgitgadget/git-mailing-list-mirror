Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D29BC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 11:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiGHLYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiGHLYM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 07:24:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA9E88F38
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 04:24:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h17so16966007wrx.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rlsOMpLev0XMZAT18z41ffZrHp6du2dh/mz6X+38sTQ=;
        b=F5Va389dX6obarLTWlOcQiNdYoubEnU6BPxsHPSjon/HVtUinIrg8L8afDJdAqm8rd
         0fYJ5TeaPSIz3hU0OGqSV3DQRvu8FU0ng3LwGsU2sr2nGAv1dVFPizsAJmozt/Lmz2QG
         8maZPUKsuvNLp7ivVurwk/9sQOMr16XbybZjN2WODvnfMjo3rpwGDcwuxsmmtibwu2oi
         F+WnB9DqgfzgkpDIfmRHUk0kVW1TqmZYoBd8o4LtqTbfQz5ZdTMLHlkDQ0pUv3ieJjuS
         P3vj6UC4B0aOJJ/x8VsGJ1Y078NR7TKfeNAe3khZ4OxnUovsqCC+7p5S8mju3M1GfEPu
         b5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rlsOMpLev0XMZAT18z41ffZrHp6du2dh/mz6X+38sTQ=;
        b=p2tUd+hrzf22o6X6uUb1hjMcLKhLjaibubNB0KmSt52femB9/F79Nt6mwq2tkM/zn1
         R4l8+5IngCLgBexYJE7xtVdyjKGR+gaRpuorzPl8KZ9eESpiTQMQWrKEry43qlkXaI3f
         WISlPbC4NUqklMzhxcUqVB017G6BjcysjWsDGwccOcYK8WGByk8uxyyevUIKWerG1abI
         rdF0C1IdVf91Vg4wF4/68jhM7kTz1Dcd81M5lPYWn88ipNhKwhOZdeZH35Jm/9UKHUtc
         QSmLYltOIJOFh0V2593ACl7NiOSW/f2F0Id3+DFk9PeCeyYFdNjkD0IXCOxSzJ6TpmHJ
         KeUw==
X-Gm-Message-State: AJIora90rgJXINy/3EH8K3HPKH/4oOhGCMOj7gLZT5y8w04xEfrokT5N
        SVD235PXHbYDXeZ8ijJUUCvknB4GWmY=
X-Google-Smtp-Source: AGRyM1uMlNNJXp4f+dsG6i7RXdrX11ReVUWAZxPT1lAtqknJTzSQbIEYj6g6fhezgIlY5D7o7I7y7A==
X-Received: by 2002:adf:ed45:0:b0:21d:6764:6fbc with SMTP id u5-20020adfed45000000b0021d67646fbcmr2782259wro.155.1657279448922;
        Fri, 08 Jul 2022 04:24:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002185d79dc7fsm17656753wrm.75.2022.07.08.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:24:08 -0700 (PDT)
Message-Id: <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
In-Reply-To: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
From:   "Jaydeep Das via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jul 2022 11:24:07 +0000
Subject: [PATCH v2] gpg-interface: add function for converting trust level to
 string
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jaydeep Das <jaydeepjd.8914@gmail.com>

Add new helper function `gpg_trust_level_to_str()` which will
convert a given member of `enum signature_trust_level` to its
corresponding string(in lowercase). For example, `TRUST_ULTIMATE`
will yield the string "ultimate".

This will abstract out some code in `pretty.c` relating to gpg
signature trust levels.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
---
    gpg-interface: add function for converting trust level to string
    
    Add new helper function gpg_trust_level_to_str() which will convert a
    given member of enum signature_trust_level to its corresponding string
    in lowercase. For example, TRUST_ULTIMATE will yield the string
    "ultimate".
    
    This will abstract out some code in pretty.c relating to gpg signature
    trust levels.
    
    Changes since v1:
    
     * gpg_trust_level_to_str() now returns the string in lowercase
    
    Mentored-by: Christian Couder chriscool@tuxfamily.org Mentored-by:
    Hariom Verma hariom18599@gmail.com Signed-off-by: Jaydeep Das
    jaydeepjd.8914@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1281%2FJDeepD%2Fgpg-wrap-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1281/JDeepD/gpg-wrap-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1281

Range-diff vs v1:

 1:  fbbad9cc26a ! 1:  640decc2afe gpg-interface: add function for converting trust level to string
     @@
       ## Metadata ##
     -Author: Jaydeep P Das <jaydeepjd.8914@gmail.com>
     +Author: Jaydeep Das <jaydeepjd.8914@gmail.com>
      
       ## Commit message ##
          gpg-interface: add function for converting trust level to string
      
          Add new helper function `gpg_trust_level_to_str()` which will
          convert a given member of `enum signature_trust_level` to its
     -    corresponding string. For example, `TRUST_ULTIMATE`
     -    will yield the string "ULTIMATE".
     +    corresponding string(in lowercase). For example, `TRUST_ULTIMATE`
     +    will yield the string "ultimate".
      
          This will abstract out some code in `pretty.c` relating to gpg
          signature trust levels.
     @@ gpg-interface.c: const char *get_signing_key(void)
       	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
       }
       
     -+const char *gpg_trust_level_to_str(enum signature_trust_level level){
     ++char *gpg_trust_level_to_str(enum signature_trust_level level){
      +	if (level < TRUST_UNDEFINED || level > TRUST_ULTIMATE)
      +		return NULL;
     -+	return sigcheck_gpg_trust_level[level].key;
     ++	return xstrdup_tolower(sigcheck_gpg_trust_level[level].key);
      +}
      +
       int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
     @@ gpg-interface.h: size_t parse_signed_buffer(const char *buf, size_t size);
       
      +
      +/*
     -+ * Returns corresponding string for a given member of
     ++ * Returns corresponding string in lowercase for a given member of
      + * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
     -+ * return "ULTIMATE".
     ++ * return "ultimate".
      + */
     -+const char *gpg_trust_level_to_str(enum signature_trust_level level);
     ++char *gpg_trust_level_to_str(enum signature_trust_level level);
      +
       int git_gpg_config(const char *, const char *, void *);
       void set_signing_key(const char *);
     @@ gpg-interface.h: size_t parse_signed_buffer(const char *buf, size_t size);
      
       ## pretty.c ##
      @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     - 	const struct commit *commit = c->commit;
       	const char *msg = c->message;
       	struct commit_list *p;
     --	const char *arg, *eol;
     -+	const char *arg, *eol, *sig_str;
     + 	const char *arg, *eol;
     ++	char *sig_str;
       	size_t res;
       	char **slot;
       
     @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
      -			case TRUST_ULTIMATE:
      -				strbuf_addstr(sb, "ultimate");
      -				break;
     +-			}
      +			sig_str = gpg_trust_level_to_str(c->signature_check.trust_level);
     -+			if (sig_str){
     -+				const char *sig_str_lower = xstrdup_tolower(sig_str);
     -+				strbuf_addstr(sb, sig_str_lower);
     -+				free((char *)sig_str_lower);
     - 			}
     ++			if (sig_str)
     ++				strbuf_addstr(sb, sig_str);
     ++			free(sig_str);
       			break;
       		default:
     + 			return 0;


 gpg-interface.c |  7 +++++++
 gpg-interface.h |  8 ++++++++
 pretty.c        | 22 +++++-----------------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 947b58ad4da..4ef660a09fc 100644
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
 
+char *gpg_trust_level_to_str(enum signature_trust_level level){
+	if (level < TRUST_UNDEFINED || level > TRUST_ULTIMATE)
+		return NULL;
+	return xstrdup_tolower(sigcheck_gpg_trust_level[level].key);
+}
+
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	return use_format->sign_buffer(buffer, signature, signing_key);
diff --git a/gpg-interface.h b/gpg-interface.h
index b30cbdcd3da..ce2db6f3780 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -71,6 +71,14 @@ size_t parse_signed_buffer(const char *buf, size_t size);
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 		const char *signing_key);
 
+
+/*
+ * Returns corresponding string in lowercase for a given member of
+ * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
+ * return "ultimate".
+ */
+char *gpg_trust_level_to_str(enum signature_trust_level level);
+
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
diff --git a/pretty.c b/pretty.c
index ee6114e3f0a..5ee03d6fe09 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1348,6 +1348,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const char *msg = c->message;
 	struct commit_list *p;
 	const char *arg, *eol;
+	char *sig_str;
 	size_t res;
 	char **slot;
 
@@ -1575,23 +1576,10 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
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
-			}
+			sig_str = gpg_trust_level_to_str(c->signature_check.trust_level);
+			if (sig_str)
+				strbuf_addstr(sb, sig_str);
+			free(sig_str);
 			break;
 		default:
 			return 0;

base-commit: 30cc8d0f147546d4dd77bf497f4dec51e7265bd8
-- 
gitgitgadget
