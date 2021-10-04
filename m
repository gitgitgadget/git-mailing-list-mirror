Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D7EC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5629361216
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhJDBq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhJDBon (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:44:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D1C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:42:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so22312366wrb.0
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Sd6K4IiKJA488Pl8hJJ/c77P1995kVeHzEploi0FBM=;
        b=QOdfSXUIABtldE0zpJVtMTR5M8BOWz8ZYTpuuFktJCMf0Y1decUoe2QOqFariic740
         YGz7HQm77BTkG+OQDL8tuhREnSg9Wi7FwWVK+Sd1tRXD4q/ydnuIJneN8g93sAmaJNYI
         iBy2OSoq8fK52LEDxGSlP3fLZsbviihVH59+T9gkyTeeLC6JHPUZvoAeBd97H36AwbJu
         namX1w/KbIPoouU9Z3waXu9az5qRbCW97uck8XvbcQj0IfY7EqHQvcuHnI7ve6Ob1e3B
         BEBhsHaELfk+mdsXcbaU/mL6Tnfht8O2sRcQp5XOb8MFbzWC8oKso3fyZDyzjCeI32hW
         B6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Sd6K4IiKJA488Pl8hJJ/c77P1995kVeHzEploi0FBM=;
        b=BaRVctVA3tGGrpTU5djks6eUX51pqdpHr8ltbvSMGZhCGvlFnoV/18JIiTujLbcaxz
         rXg2m1EmNmmv5AztRcNJstkITuch+EvnWGazwsQ0I0TdntV/LHpqS6/4CH1YKrYFOUev
         UXRRaq3ZQmSAFqq5PltGEXSAjDn2nPiU3bysamTz6Gt2LFEQJMdzxiC+RJ7DzLObi8Dj
         g1zqUMve9hs96P8mPi8OpZYMxdIyeBEYBHq4Ib54jNMirZlHv38ycpxSPvmAa25kyfkX
         uWUSxImxdoyLDH9T1kMCniYQuoDFovn7kBTslJblqN++H2asyB82dzyuE9RG/epyA/cj
         ECew==
X-Gm-Message-State: AOAM532aqjVJKQvj5odchzJ+1RaFBy4bz7kiuSQTmzkDt6UVT3BEp+cz
        IrIiUI99e7Y7n6ylXOTKgiuys90noKTJZA==
X-Google-Smtp-Source: ABdhPJyos0VKGya5dbgkMcKTjaQBc74iXrznzBqq5gfzrBNsIw64T29g3xQ22a9e/Bn+4xtqE6+zkw==
X-Received: by 2002:adf:b348:: with SMTP id k8mr10036626wrd.435.1633311773447;
        Sun, 03 Oct 2021 18:42:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e14sm3308193wrw.33.2021.10.03.18.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:42:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] object-name: make ambiguous object output translatable
Date:   Mon,  4 Oct 2021 03:42:49 +0200
Message-Id: <patch-2.2-b6136380c28-20211004T013611Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
In-Reply-To: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output of show_ambiguous_object() added in [1] and last
tweaked in [2] to be more friendly to translators. By being able to
customize the sprintf formats we're even ready for RTL languages.

1. ef9b0370da6 (sha1-name.c: store and use repo in struct
   disambiguate_state, 2019-04-16)
2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 53 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..7e7f671e337 100644
--- a/object-name.c
+++ b/object-name.c
@@ -351,9 +351,16 @@ static int init_object_disambiguation(struct repository *r,
 	return 0;
 }
 
+struct show_ambiguous_state {
+	const struct disambiguate_state *ds;
+	struct strbuf *advice;
+};
+
 static int show_ambiguous_object(const struct object_id *oid, void *data)
 {
-	const struct disambiguate_state *ds = data;
+	struct show_ambiguous_state *state = data;
+	const struct disambiguate_state *ds = state->ds;
+	struct strbuf *advice = state->advice;
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
@@ -366,18 +373,34 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
-			format_commit_message(commit, " %ad - %s", &desc, &pp);
+			format_commit_message(commit, _(" %ad - %s"), &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(ds->repo, oid);
 		if (!parse_tag(tag) && tag->tag)
-			strbuf_addf(&desc, " %s", tag->tag);
+			strbuf_addf(&desc, _(" %s"), tag->tag);
 	}
 
-	advise("  %s %s%s",
-	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
-	       type_name(type) ? type_name(type) : "unknown type",
-	       desc.buf);
+	strbuf_addf(advice,
+		    /*
+		     * TRANSLATORS: This is a line of ambiguous object
+		     * output. E.g.:
+		     *
+		     *    "deadbeef commit 2021-01-01 - Some Commit Message\n"
+		     *    "deadbeef tag Some Tag Message\n"
+		     *    "deadbeef tree\n"
+		     *
+		     * I.e. the first argument is a short OID, the
+		     * second is the type name of the object, and the
+		     * third a description of the object, if it's a
+		     * commit or tag. In that case the " %ad - %s" and
+		     * " %s" formats above will be used for the third
+		     * argument.
+		     */
+		    _("  %s %s%s\n"),
+		    repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
+		    type_name(type) ? type_name(type) : "unknown type",
+		    desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
@@ -475,7 +498,12 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	}
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
+		struct strbuf sb = STRBUF_INIT;
 		struct oid_array collect = OID_ARRAY_INIT;
+		struct show_ambiguous_state as = {
+			.ds = &ds,
+			.advice = &sb,
+		};
 
 		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
 
@@ -488,12 +516,19 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		if (!ds.ambiguous)
 			ds.fn = NULL;
 
-		advise(_("The candidates are:"));
 		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
 		sort_ambiguous_oid_array(r, &collect);
 
-		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
+		if (oid_array_for_each(&collect, show_ambiguous_object, &as))
 			BUG("show_ambiguous_object shouldn't return non-zero");
+
+		/*
+		 * TRANSLATORS: The argument is the list of ambiguous
+		 * objects composed in show_ambiguous_object(). See
+		 * its "TRANSLATORS" comment for details.
+		 */
+		advise(_("The candidates are:\n\n%s"), sb.buf);
+
 		oid_array_clear(&collect);
 	}
 
-- 
2.33.0.1404.g7bcfc82b295

