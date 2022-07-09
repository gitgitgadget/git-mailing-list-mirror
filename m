Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB62C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 04:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGIEnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 00:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGIEno (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 00:43:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E1A3139E
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 21:43:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o4so727437wrh.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 21:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s01/5l71Mzv9N4DXLcMoWcHbo+PHiwqiE6fTyFtjoig=;
        b=eWOlm+BOYmKbVNbRbayOxpQlGjVBdjrKhj/uplJ7c2BDMTXjoDEF3eOxRcKV/XCeFL
         nWMvfjOF46bEg9sHUGn4GRdTxASLDyO3Tah0P22MDBuLfBzS/KiEHHudIwtO0g0LuAy9
         un6g/ALSPXhlv8+b+pqrEvaWtTLiyMrOwQRAGzY5kLLNl4DNNGhUlZV40k4J6VGmmQKL
         2CJS/SMt1dvNzxFGl6l0dR+IgpYP6dfzwcgPuQBY9zZ5oV882GEmXfQgVH9uf2taRewa
         TodbI2X9XR4HU+9FMIEsSwJbO6xVeRueoBFQf09oUgF3CD6x/F8NnAGQJOth7F4ENYPQ
         cWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s01/5l71Mzv9N4DXLcMoWcHbo+PHiwqiE6fTyFtjoig=;
        b=Fl+AoofsYmw2BSUbBHMGjtYFXiR4+QofKFcBpMK+rjAhR3Sp+IgdRdc98BQxZsXnnc
         3YTPnKyN4K8hl3ZuMuUbpJXrlVaaEmVfbGVkjS7QvM62BEzcMk0NGqCfW/XP+mnIwK6U
         iKiny+WoQQ/c12k6/CQX/RiPYcb7XSEC9M1AKq45tsQsYVP5HyKLXKuWeqS2KuVM1J4C
         aIMpVm9917HdemBpbP0LENRkTQ3ZoKiu2CrHUzsYqJmPw0LKhbWsNDdPUmtZBT0100Wp
         yR2y9oZbP1tdpEeah0puT8xIGDXUQiSHetIeGdilR9sDfHz5mfZ8kfkEXb3dAnvum6KJ
         Xavw==
X-Gm-Message-State: AJIora+O8Gs4rtSpXczzVlnq9HXXKQ/8K7uZ36Dnhq9yv0ich0PuTMeb
        re5UInWjYEADFA737ww1vG2NBgRoyfM=
X-Google-Smtp-Source: AGRyM1sQlni0MOW5IlEZW6gnanQvKeSiLZV6pF9PfANypFZ7UZ5I8aRF69rwDs+2rO6hoIIKw/O4qg==
X-Received: by 2002:a5d:6c63:0:b0:21d:3fb7:e112 with SMTP id r3-20020a5d6c63000000b0021d3fb7e112mr6419133wrz.256.1657341818933;
        Fri, 08 Jul 2022 21:43:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020adff58c000000b0021004d7d75asm503358wro.84.2022.07.08.21.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 21:43:38 -0700 (PDT)
Message-Id: <pull.1281.v3.git.1657341817595.gitgitgadget@gmail.com>
In-Reply-To: <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
References: <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
From:   "Jaydeep Das via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 04:43:37 +0000
Subject: [PATCH v3] gpg-interface: add function for converting trust level to
 string
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jaydeep Das <jaydeepjd.8914@gmail.com>

Add new helper function `gpg_trust_level_to_str()` which will
convert a given member of `enum signature_trust_level` to its
corresponding string (in lowercase). For example, `TRUST_ULTIMATE`
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
    
     * gpg_trust_level_to_str() now returns the string in lowercase.
    
    Changes since v2:
    
     * Updated docs.
    
    Mentored-by: Christian Couder chriscool@tuxfamily.org Mentored-by:
    Hariom Verma hariom18599@gmail.com Signed-off-by: Jaydeep Das
    jaydeepjd.8914@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1281%2FJDeepD%2Fgpg-wrap-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1281/JDeepD/gpg-wrap-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1281

Range-diff vs v2:

 1:  640decc2afe ! 1:  933d6caa916 gpg-interface: add function for converting trust level to string
     @@ Commit message
      
          Add new helper function `gpg_trust_level_to_str()` which will
          convert a given member of `enum signature_trust_level` to its
     -    corresponding string(in lowercase). For example, `TRUST_ULTIMATE`
     +    corresponding string (in lowercase). For example, `TRUST_ULTIMATE`
          will yield the string "ultimate".
      
          This will abstract out some code in `pretty.c` relating to gpg
     @@ gpg-interface.h: size_t parse_signed_buffer(const char *buf, size_t size);
      +/*
      + * Returns corresponding string in lowercase for a given member of
      + * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
     -+ * return "ultimate".
     ++ * return "ultimate". Since it uses xstrdup_tolower(), which uses
     ++ * xmallocz(), the caller has to free up the memory for returned string
     ++ * after usage.
      + */
      +char *gpg_trust_level_to_str(enum signature_trust_level level);
      +


 gpg-interface.c |  7 +++++++
 gpg-interface.h | 10 ++++++++++
 pretty.c        | 22 +++++-----------------
 3 files changed, 22 insertions(+), 17 deletions(-)

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
index b30cbdcd3da..eda8b32015c 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -71,6 +71,16 @@ size_t parse_signed_buffer(const char *buf, size_t size);
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 		const char *signing_key);
 
+
+/*
+ * Returns corresponding string in lowercase for a given member of
+ * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
+ * return "ultimate". Since it uses xstrdup_tolower(), which uses
+ * xmallocz(), the caller has to free up the memory for returned string
+ * after usage.
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
