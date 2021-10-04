Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E181C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4159C61264
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhJDO3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhJDO25 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:28:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11EAC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:27:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so31211486wri.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Wdq70nnke78EyJJaguHdsmnLN3TB+hJkcoKf9qRri4=;
        b=o7Y/WQ0M65V7xptZba2VkCY9VsCZKo6s02PwLqkJgfDgucjMwE72WcdTyMtbv+ddrA
         j54A07welLw2ql4wHk9VdCJ8WlBKGwodI3uMK3QFe1xLAJ+N4D90NfiVLYBEKEOst3I7
         CfS17Q4pu8X9ImVo3G9cjBiZ43pDoOJ93uS9AvqLUbR8/+/mhFVGT4P3+/RzfHvu3evl
         nKpH0q78T49C+QltFqOWVSUPWCg2kWPylaDj+NYVs3fuIwoGkqqDhr0fIZTM0/k6Ha4T
         k2WOexJ/xCocqnnZm27VSlB0qCud7ZCP3SX9f6CmgVSHlkZMwzhrbClt4Rh4OGhjdZLx
         VanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Wdq70nnke78EyJJaguHdsmnLN3TB+hJkcoKf9qRri4=;
        b=30sl4ACLNKiQbiXbnkH4BzvJC/dZ8FXpTEXdCsv3g9Mkd4LY69VNpFDmUcVDHH3BF/
         qlg+j1u0whoLgp27HNqUXMD3MVZzPvfS4jVi0bAjsi1kmGB5cuXE8HO7aExBdarzZtHx
         gkPhvcLHg38/Yvhak4IgtswMKM12cA38lYAPXOAxG9wKM8Jt5TPQ2Vs7/hd7i4bQzazs
         TruE8rvAYDLtc6ERN6HovQ6Z3ZD9DrtLsUKZjhQWddd//yZyehkC015qKyhhcASsFLlJ
         E+3bOAnf/wxzv9RfJuoIzS8iArXfOrMUBJw3saXqA7Pfv4D0XUkGeAbizskCd/btiX4S
         1ncg==
X-Gm-Message-State: AOAM532fhbafQznt/n/chcE0XWs9SARNIWPYTgy0kLWrgGm3S5KzJQhp
        jk2KNIsYmq2FLUTTazcIY73darorT8cduQ==
X-Google-Smtp-Source: ABdhPJy5UMEU1CuO93cpxOu1a03cU/3pZ6TtF3baDMUQ0DoLqni2zBGNGTb/JdtU7Pi/fX407WFTSQ==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr14806205wrs.404.1633357626070;
        Mon, 04 Oct 2021 07:27:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f9sm17368315wmf.3.2021.10.04.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:27:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] object-name: make ambiguous object output translatable
Date:   Mon,  4 Oct 2021 16:27:02 +0200
Message-Id: <patch-v2-2.2-c0e873543f5-20211004T142523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1409.ge73c1ecc5b4
In-Reply-To: <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output of show_ambiguous_object() added in [1] and last
tweaked in [2] to be more friendly to translators. By being able to
customize the sprintf formats we're even ready for RTL languages.

The "unknown type" message here is unreachable, and has been since
[1], i.e. that code has never worked. If we craft an object of a bogus
type with a conflicting prefix we'll just die:

    $ git rev-parse 8315
    error: short object ID 8315 is ambiguous
    hint: The candidates are:
    fatal: invalid object type

But let's continue to pretend that this works, we can eventually use
the API improvements in my ab/fsck-unexpected-type (once it lands) to
inspect these objects and emit the actual type here, or at least not
die as we emit "unknown type".

1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
   2016-09-26)
2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..73c946f1117 100644
--- a/object-name.c
+++ b/object-name.c
@@ -355,7 +355,11 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 {
 	const struct disambiguate_state *ds = data;
 	struct strbuf desc = STRBUF_INIT;
+	struct strbuf ci_ad = STRBUF_INIT;
+	struct strbuf ci_s = STRBUF_INIT;
 	int type;
+	const char *tag_desc = NULL;
+	const char *abbrev;
 
 	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
@@ -366,20 +370,76 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
-			format_commit_message(commit, " %ad - %s", &desc, &pp);
+			format_commit_message(commit, "%ad", &ci_ad, &pp);
+			format_commit_message(commit, "%s", &ci_s, &pp);
 		}
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(ds->repo, oid);
 		if (!parse_tag(tag) && tag->tag)
-			strbuf_addf(&desc, " %s", tag->tag);
+			tag_desc = tag->tag;
 	}
 
-	advise("  %s %s%s",
-	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
-	       type_name(type) ? type_name(type) : "unknown type",
-	       desc.buf);
+	abbrev = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
+	if (type == OBJ_COMMIT) {
+		/*
+		 * TRANSLATORS: This is a line of ambiguous commit
+		 * object output. E.g.:
+		 *
+		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
+		 *
+		 * The second argument is the "commit" string from
+		 * object.c, it should (hopefully) already be
+		 * translated.
+		 */
+		strbuf_addf(&desc, _("%s %s %s - %s"), abbrev, ci_ad.buf,
+			    _(type_name(type)), ci_s.buf);
+	} else if (tag_desc) {
+		/*
+		 * TRANSLATORS: This is a line of
+		 * ambiguous tag object output. E.g.:
+		 *
+		 *    "deadbeef tag Some Tag Message"
+		 *
+		 * The second argument is the "tag" string from
+		 * object.c, it should (hopefully) already be
+		 * translated.
+		 */
+		strbuf_addf(&desc, _("%s %s %s"), abbrev, _(type_name(type)),
+			    tag_desc);
+	} else {
+		const char *tname = type_name(type) ? _(type_name(type)) :
+			_(unknown_type);
+		/*
+		 * TRANSLATORS: This is a line of ambiguous <type>
+		 * object output. Where <type> is one of the object
+		 * types of "tree", "blob", "tag" ("commit" is handled
+		 * above).
+		 *
+		 *    "deadbeef tree"
+		 *    "deadbeef blob"
+		 *    "deadbeef tag"
+		 *    "deadbeef unknown type"
+		 *
+		 * Note that annotated tags use a separate format
+		 * outlined above.
+		 *
+		 * The second argument is the "tree", "blob" or "tag"
+		 * string from object.c, or the "unknown type" string
+		 * in the case of an unknown type. All of them should
+		 * (hopefully) already be translated.
+		 */
+		strbuf_addf(&desc, _("%s %s"), abbrev, tname);
+	}
+
+	/*
+	 * TRANSLATORS: This is line item of ambiguous object output,
+	 * translated above.
+	 */
+	advise(_("  %s\n"), desc.buf);
 
 	strbuf_release(&desc);
+	strbuf_release(&ci_ad);
+	strbuf_release(&ci_s);
 	return 0;
 }
 
-- 
2.33.0.1409.ge73c1ecc5b4

