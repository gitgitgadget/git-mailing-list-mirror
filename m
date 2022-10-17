Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38AC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJQNR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiJQNRw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7274D25B
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id iv17so8618943wmb.4
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4XqjxzKj5QYArEQIi/wuOmUM5Rr9PThx002U33744k=;
        b=FBVxU/j5YGzJqLv36blL3U2iJMxevvbeNvdBvpir+7by20PFEs0RVY/7KwER+oIMQx
         B62XC0y6HdGdizj+2Wq5bM16iE/fAkvCpk+bfUkOdIX+dicW48m/7tCE70pGrURH3DzV
         02P2qIizugSiDCxSaw+Q9bWs6slOwAf+ddMXHtvQuO2LGX+JDJGh+5Z0CEFI1paaHyrj
         RUVZsjsDDmFuftAI//FDI5Z4NzcnzOJQgD0AzqUlcZKIgwrw03YAVZGRsJkQjmdpHVNF
         VCH7h/zcz8ylr9VGDaamfBJwkrvR0o1XLysUIpCPmeJUPx6OHjlDGWd+X9Mp0WGtDhHP
         eE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4XqjxzKj5QYArEQIi/wuOmUM5Rr9PThx002U33744k=;
        b=zXvHLAsrrPblcxODOaXF8dOYe/wczmvgoG3mbX7Aqr4RtW/0AHpkb2mzNYq36UBrFI
         u4MkMN3C4/bfWuRfPl0fKzkTiEkWlPFKjoF3RXBXbzdV2OSuf41Rzg+Ph6RPmlbmU0Uj
         jLNlV8lvhCvWInHRWR4wgN9jJg8ml0aalGGtYfNfOXSVW7UdhfTYF/6ckpLGhb8vuI6o
         qJhZgo4bHyKTez3TyG/RK7/K4cht/gXPvf3n73ObUukGtFW4ycXEkFpQ5dIW92N8S4Hw
         oIbINAsygA5IZE9SDLHxqawO2ieHD7hKE4TiBcdSwy7bANtuCLD/GE9XF+bWG8sfvlhY
         hcYg==
X-Gm-Message-State: ACrzQf2JrMkk+U0xDu0Ikh5A/xLv9C8FnmUS4BGK3k8eKlOEdFI0F4Bm
        c/TeJVGeb5nu2Xre3SPlocdLXODlH14=
X-Google-Smtp-Source: AMsMyM5LgEVcqgdAvnAM+6hhe7MbmSLIxEWx46pCzRpvAK9RpGvC+CIyyVuWxIQZvYUvSravLUYtNw==
X-Received: by 2002:a05:600c:220a:b0:3c5:df6:2f3b with SMTP id z10-20020a05600c220a00b003c50df62f3bmr18716317wml.63.1666012669284;
        Mon, 17 Oct 2022 06:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a1c2606000000b003c452678025sm15539087wmm.4.2022.10.17.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:48 -0700 (PDT)
Message-Id: <1d5e0419c45087c474f33d5ea6b3bcdacd072fa5.1666012665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:40 +0000
Subject: [PATCH v4 3/8] rebase: be stricter when reading state files
 containing oids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The state files for 'onto' and 'orig_head' should contain a full hex
oid, change the reading functions from get_oid() to get_oid_hex() to
reflect this. They should also name commits and not tags so add and use
a function that looks up a commit from an oid like
lookup_commit_reference() but without dereferencing tags.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c |  8 ++++----
 commit.c         |  8 ++++++++
 commit.h         | 13 +++++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 56e4214b441..06903eb6d4d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -431,9 +431,9 @@ static int read_basic_state(struct rebase_options *opts)
 	opts->head_name = starts_with(head_name.buf, "refs/") ?
 		xstrdup(head_name.buf) : NULL;
 	strbuf_release(&head_name);
-	if (get_oid(buf.buf, &oid))
-		return error(_("could not get 'onto': '%s'"), buf.buf);
-	opts->onto = lookup_commit_or_die(&oid, buf.buf);
+	if (get_oid_hex(buf.buf, &oid) ||
+	    !(opts->onto = lookup_commit_object(the_repository, &oid)))
+		return error(_("invalid onto: '%s'"), buf.buf);
 
 	/*
 	 * We always write to orig-head, but interactive rebase used to write to
@@ -448,7 +448,7 @@ static int read_basic_state(struct rebase_options *opts)
 	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
 				  READ_ONELINER_WARN_MISSING))
 		return -1;
-	if (get_oid(buf.buf, &opts->orig_head))
+	if (get_oid_hex(buf.buf, &opts->orig_head))
 		return error(_("invalid orig-head: '%s'"), buf.buf);
 
 	if (file_exists(state_dir_path("quiet", opts)))
diff --git a/commit.c b/commit.c
index 0db461f9735..de30b098dd3 100644
--- a/commit.c
+++ b/commit.c
@@ -59,6 +59,14 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
+struct commit *lookup_commit_object (struct repository *r,
+				     const struct object_id *oid)
+{
+	struct object *obj = parse_object(r, oid);
+	return obj ? object_as_type(obj, OBJ_COMMIT, 0) : NULL;
+
+}
+
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
diff --git a/commit.h b/commit.h
index 21e4d25ce78..fa39202fa6b 100644
--- a/commit.h
+++ b/commit.h
@@ -64,6 +64,19 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
+/*
+ * Look up commit named by "oid" respecting replacement objects.
+ * Returns NULL if "oid" is not a commit or does not exist.
+ */
+struct commit *lookup_commit_object(struct repository *r, const struct object_id *oid);
+
+/*
+ * Look up commit named by "oid" without replacement objects or
+ * checking for object existence. Returns the requested commit if it
+ * is found in the object cache, NULL if "oid" is in the object cache
+ * but is not a commit and a newly allocated unparsed commit object if
+ * "oid" is not in the object cache.
+ */
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 struct commit *lookup_commit_reference(struct repository *r,
 				       const struct object_id *oid);
-- 
gitgitgadget

