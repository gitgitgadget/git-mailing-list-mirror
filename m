Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A743C64E8A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB802075A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdhzXhj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbgKZB3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKZB3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:09 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638EC061A52
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:09 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so480249wmd.4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jceSisEQ0O8uzujaoHHu5uF2kPINXx1cZjvV2eLizw=;
        b=PdhzXhj5qifScRYm34c075x1vj8bJlxbSHzAHnK7eFpsArGegAbhdIa91URk5v5139
         f12TpMD4xApSVj7s+0Wu2Tl5IVM7RT1RCUgjQ8u3lzcAT3K6TarmWogTneGW18gwr/Vi
         k8xKhJ5Hizjinm2wIAPE20dvPAwNRppRZWdbXMTMPC638VwckLDlMCJzLypf5BDX/nyg
         wP7VrAGJVWxqjoTvO3tUjbjJjuX5FO3id2SkyxUAu4Yd+tZFBfRkHJduKFjxMKo/23HL
         ed0lR1GR9nNgOTECwoOd5BaqL8OiDEom6m8+w5V3sWIV13yuvSk86ywFnXpgZJsQJJzZ
         c6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jceSisEQ0O8uzujaoHHu5uF2kPINXx1cZjvV2eLizw=;
        b=m4Ll/oEEJKw5Zo9P0kUMNt1mYQ5LDJEBAXMaVT2nQAcl+hd8auuMjJtzMbeoB2h34C
         MyETiXVOJicow2Wcb4DYBL6sUeITXxxeA74PvSG+UD2HBjc1kTi6AoeoSolvnCDJqsh1
         bXsT15L4PgQJjsZB6o1cjXk6thTwHZ2bmGozGoYa5NtSuUh5GZBbdm2ZZQfElceCpxIZ
         WCwBXkix2xuWu3TtujUbTqEhqb6LvFs0U3RTwIHFf/TMVbIACO30ssiv58fSY9eVywlT
         rQdEazBlaRHk+17CeMem2UCq7eIRKVLioWKYXiBixnmJO9tiOKyo8kDAwneXXV8PGNlt
         4OWw==
X-Gm-Message-State: AOAM533pjeBa7k1n3zGngVYZaYZ/7b/FXFZc7Va/cwZ8eVQ+F6dQaSVs
        Xi/JK3ipNMuCq+56og0MVTkLJfjXhzqIPw==
X-Google-Smtp-Source: ABdhPJwZSZIFhcR2146QxkXAvPRPYLlZx/jkjzA5Uj1dwSXFCvwTeLAGz9rIgR4knyPFJcJPyKzUWA==
X-Received: by 2002:a05:600c:2949:: with SMTP id n9mr454463wmd.29.1606354147618;
        Wed, 25 Nov 2020 17:29:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 07/12] fsck: add new "extra" checks for "mktag"
Date:   Thu, 26 Nov 2020 02:28:49 +0100
Message-Id: <20201126012854.399-8-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add optional "extra" checks to fsck, these are needed to eventually
replace the custom not-quite-fsck code in mktag.c.

The mktag checks differ from fsck_tag() in several ways, one of those
is that fsck doesn't know how to refuse an object with custom headers,
and isn't strict about header and body newline separation.

Teach it how to optionally report these. I thought the best way to do
that given the current structure of the code was to add a new "extra"
category in addition to error/warn/info. Under --strict the "info"
becomes a "warn" and "warn" becomes "error". Existing users of
fsck's (and others, e.g. index-pack) --strict option rely on this.

By adding an "extra" category and only reporting it based on a flag in
fsck_options callers can opt-in to these "extra" messages, which
they'll then need to deal with in their own "error_func".

No tests are being added for this new functionality, they're added in
a subsequent commit where we teach "mktag" to use this new validation
mode.

I'm not changing fsck_commit() to validate commit objects like this
either, we could do that, but unlike in the tag case that code
wouldn't be used anywhere. If someone wants to write a "mkcommit" they
which behaves like "mktag" they can borrow or refactor this logic for
use in fsck_commit().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 32 +++++++++++++++++++++++++++++++-
 fsck.h |  2 ++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index f82e2fe9e3..3c25df2244 100644
--- a/fsck.c
+++ b/fsck.c
@@ -80,7 +80,10 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
-	FUNC(MISSING_TAGGER_ENTRY, INFO)
+	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	/* extra (only reported when requested) */ \
+	FUNC(EXTRA_HEADER_ENTRY, EXTRA) \
+	FUNC(EXTRA_HEADER_BODY_NEWLINE, EXTRA)
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
 enum fsck_msg_id {
@@ -975,6 +978,33 @@ static int fsck_tag(const struct object_id *oid, const char *buffer,
 	else
 		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
 
+	if (options->extra && *buffer) {
+		if (!starts_with(buffer, "\n")) {
+			/*
+			 * The verify_headers() check will allow
+			 * e.g. "[...]tagger <tagger>\nsome
+			 * garbage\n\nmessage" to pass, thinking "some
+			 * garbage" could be a custom
+			 * header. E.g. "mktag" doesn't want any
+			 * unknown headers.
+			 */
+			ret = report(options, oid, OBJ_TAG, FSCK_MSG_EXTRA_HEADER_ENTRY, "invalid format - extra header(s) after 'tagger'");
+			if (ret)
+				goto done;
+		}
+		if (starts_with(buffer, "\n\n")) {
+			/*
+			 * Some callers such as "mktag" want to
+			 * disallow "[...]tagger
+			 * <tagger>\n\n\nmessage", only allowing a
+			 * single newline for separation.
+			 */
+			ret = report(options, oid, OBJ_TAG, FSCK_MSG_EXTRA_HEADER_BODY_NEWLINE, "invalid format - headers separated body by more than one newline");
+			if (ret)
+				goto done;
+		}
+	}
+
 done:
 	strbuf_release(&sb);
 	return ret;
diff --git a/fsck.h b/fsck.h
index 69cf715e79..110efc65fd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -6,6 +6,7 @@
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
 #define FSCK_IGNORE 3
+#define FSCK_EXTRA 4
 
 struct fsck_options;
 struct object;
@@ -40,6 +41,7 @@ struct fsck_options {
 	unsigned strict:1;
 	int *msg_type;
 	struct oidset skiplist;
+	unsigned extra:1;
 	kh_oid_map_t *object_names;
 };
 
-- 
2.29.2.222.g5d2a92d10f8

