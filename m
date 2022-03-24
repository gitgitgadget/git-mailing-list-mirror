Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86E1C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 13:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350548AbiCXNrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350546AbiCXNq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 09:46:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19689081
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 06:45:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so5654573edu.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1e7Usbc2JpB/EtiX4jVxB/ckEfOrx427p6UAIPrMQBY=;
        b=bbGdlegYPlJ24J93DFboH/cCRjeKeOuKioBijMdRFLW6WeZGBw1RE2OfdSrEyyM/i2
         XGacNvkGOct87soshlh1V1inye1WIGI/OzISs/QGWjifQEFDoBYbtF9+fDJIV5+Cryrx
         12byW0CEP3EQ6Sk8Duvugpkrg98mVD88fIFr2n0qEsearF8uGZJNTiKEiTRmSxS5Eq+5
         IqY2PsiLcciDaw53IhC1nqjkJ8OgMg3Sl+YpYv2slPQuZOjnmNucr+WzxxVx9Nki/QnS
         AnKmXtpv4j5yL5DFUjdBRUoGOSrlx9dFjLKSm+wt0H3i4VBUAr2RNKh6arBtNtskz+tW
         hB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1e7Usbc2JpB/EtiX4jVxB/ckEfOrx427p6UAIPrMQBY=;
        b=aU9asMDWOG/uOtH0/Fppu16uoWkU6CU7bH47shTiDIN2zi0uiRRKHveMI5rmHnKe7A
         415U9NJgcED85ZgnxVtwu0xDkber5veAglSNW0ORgv4Zx5pc0EQAQPn/+mQMQMPBBdwl
         qyY8FFEg22evC+W32EZquVFUxkUrT5KdccvtSdlMk3Zho/G4SBFI27pXR3Pc/RcueehW
         V6z9SilhKrzW1UwjdnVuhdbx/GqWUkytMuGdjMxNpLPog2itAUJdGMHZOlgR2LTTzKuE
         +fzI+6SgfeEoR7cKXo9V/XhtkEC/RjlcxGmWUvY/mQi1H/7AwQSBXO8PdAlmm6+CNtXH
         GJxg==
X-Gm-Message-State: AOAM530hOBGR3M57vq+0xxEPOOHS0wgvwFOHlo3b+Tiln/TKmAk6emhx
        WlNSLHYR6zsuN3/lwmBGvgI1XuXpmmzfuA==
X-Google-Smtp-Source: ABdhPJyie4VjkIcv4Z4NRilHktXTDv4p/6+EIcw2L7LsLgnHFkJrmhreLBwM1xUOLaGLgMKPjIwagQ==
X-Received: by 2002:a05:6402:5202:b0:419:2b9f:7dd3 with SMTP id s2-20020a056402520200b004192b9f7dd3mr6808415edd.224.1648129524193;
        Thu, 24 Mar 2022 06:45:24 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm1121936eje.183.2022.03.24.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 06:45:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXNmE-001cBO-M9;
        Thu, 24 Mar 2022 14:45:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, derrickstolee@github.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 0/3] trace2 output for bitmap decision path
Date:   Thu, 24 Mar 2022 14:22:17 +0100
References: <cover.1648119652.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <cover.1648119652.git.dyroneteng@gmail.com>
Message-ID: <220324.867d8jo45p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Teng Long wrote:

> A Git repo can be chosen to use the normal bitmap (before MIDX) and MIDX bitmap.
>
> I recently tried to understand this part of the MIDX implementation because I found
> a bug which has been discovered and repaired in community [1].
>
> I am grateful to Taylor Blau for his help and for introducing me to the testing
> method according to the `git rev-list --test-bitmap <rev>`.
>
> In the process of understanding and troubleshooting by using this command, I found
> when the execution is failed it will output a single line of
> "fatal: failed to load bitmap indexes", sometimes will be more informations like
> if the bitmap file is broken, the outputs maybe contain
> "error: Corrupted bitmap index file (wrong header)".), but most of time are single
> line output I mentioned above. So, this brings a little obstacle for debugging and
> troubleshooting I think, because "failed to load bitmap indexes" can represent
> to much informations (many causes like: midx config turn off, bitmap inexistence, etc.)
>
> Therefore, as a git repo can be chosen to use the normal bitmap (before MIDX) or
> MIDX bitmap, or they can both exist and let git make the decision. I think why not add
> some extra informations based on TRACE2 to help for showing the bitmap decision path
> clearer and more plentiful, so when the failure occurs the user can use it to debug
> around bitmap in a quicker way.
>
> Thanks.
>
> Links:
> 	1. https://public-inbox.org/git/cover.1638991570.git.me@ttaylorr.com/)
>
> Teng Long (3):
>   pack-bitmap.c: use "ret" in "open_midx_bitmap()"
>   pack-bitmap.c: add "break" statement in "open_pack_bitmap()"
>   bitmap: add trace outputs during open "bitmap" file
>
>  midx.c        |  2 ++
>  pack-bitmap.c | 17 +++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> Range-diff against v0:
> -:  ---------- > 1:  3048b4dd29 pack-bitmap.c: use "ret" in "open_midx_bitmap()"
> -:  ---------- > 2:  70500b6343 pack-bitmap.c: add "break" statement in "open_pack_bitmap()"
> -:  ---------- > 3:  9912450fc1 bitmap: add trace outputs during open "bitmap" file

Was there an on-list v0 (RFC?) or is this a range-diff against nothing?
Best not to include it until a v2 then.

Comments:

Sometimes it's better to split up patches, but I think these 3x should
really be squashed together. We make incremental progress to nowhere in
1/3 and 2/3, and it all comes together in 3/3. The 1-2/3 are trivial
enough that we can squash them in.

We then end up with this, with my comments added:
	
	 midx.c        |  2 ++
	 pack-bitmap.c | 17 +++++++++++++----
	 2 files changed, 15 insertions(+), 4 deletions(-)
	
	diff --git a/midx.c b/midx.c
	index 865170bad05..fda96440287 100644
	--- a/midx.c
	+++ b/midx.c
	@@ -392,6 +392,8 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
	 	struct multi_pack_index *m_search;
	 
	 	prepare_repo_settings(r);
	+	trace2_data_string("midx", r, "core.multipackIndex",
	+					   r->settings.core_multi_pack_index ? "true" : "false");

Weird indentation here.

Also, if we think it's a good idea to log these shouldn't it be in
repo_cfg_bool() in repo-settings.c, why is core.multipackIndex out of
all in r->settings special?

	 	if (!r->settings.core_multi_pack_index)
	 		return 0;
	 
	diff --git a/pack-bitmap.c b/pack-bitmap.c
	index 97909d48da3..cac8d4a978f 100644
	--- a/pack-bitmap.c
	+++ b/pack-bitmap.c
	@@ -484,25 +484,34 @@ static int open_pack_bitmap(struct repository *r,
	 	assert(!bitmap_git->map);
	 
	 	for (p = get_all_packs(r); p; p = p->next) {
	-		if (open_pack_bitmap_1(bitmap_git, p) == 0)
	+		if (open_pack_bitmap_1(bitmap_git, p) == 0) {

Aside: If we end up changing this line anyway, it's OK to just change it
to "if (!open...".


	 			ret = 0;
	+			break;
	+		}
	 	}
	 
	+	trace2_data_string("bitmap", the_repository, "open bitmap (non-midx)",
	+					   ret ? "failed" : "ok");
	 	return ret;
	 }
	 
	 static int open_midx_bitmap(struct repository *r,
	 			    struct bitmap_index *bitmap_git)
	 {
	+	int ret = -1;
	 	struct multi_pack_index *midx;
	 
	 	assert(!bitmap_git->map);
	 
	 	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
	-		if (!open_midx_bitmap_1(bitmap_git, midx))
	-			return 0;
	+		if (!open_midx_bitmap_1(bitmap_git, midx)) {
	+			ret = 0;
	+			break;
	+		}
	 	}
	-	return -1;
	+	trace2_data_string("midx", the_repository, "open bitmap (midx)",
	+					   ret ? "failed" : "ok");
	+	return ret;
	 }
	 
	 static int open_bitmap(struct repository *r,

It seems odd not to use trace2 regions for this, and to not add add this
data logging open_bitmap(). I came up with this on top of this when
testing this:
	
	diff --git a/pack-bitmap.c b/pack-bitmap.c
	index cac8d4a978f..ba71a7ea5cd 100644
	--- a/pack-bitmap.c
	+++ b/pack-bitmap.c
	@@ -318,11 +318,14 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
	 
	 	free(idx_name);
	 
	-	if (fd < 0)
	+	if (fd < 0) {
	+		/* TODO: Log trace2_data_string() here, do we care? */
	 		return -1;
	+	}
	 
	 	if (fstat(fd, &st)) {
	 		close(fd);
	+		/* TODO: Log trace2_data_string() here, do we care? */
	 		return -1;
	 	}
	 
	@@ -330,6 +333,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
	 		struct strbuf buf = STRBUF_INIT;
	 		get_midx_filename(&buf, midx->object_dir);
	 		/* ignore extra bitmap file; we can only handle one */
	+		/* NOTE: You'll already get a warning (well, "error") event due to this, and it'll be in your region */
	 		warning("ignoring extra bitmap file: %s", buf.buf);
	 		close(fd);
	 		strbuf_release(&buf);
	@@ -344,9 +348,11 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
	 	close(fd);
	 
	 	if (load_bitmap_header(bitmap_git) < 0)
	+		/* TODO: Add trace2_data_string() or warning/error here? */
	 		goto cleanup;
	 
	 	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
	+		/* TODO: Add trace2_data_string() or warning/error here? */
	 		goto cleanup;
	 
	 	if (load_midx_revindex(bitmap_git->midx) < 0) {
	@@ -479,49 +485,44 @@ static int open_pack_bitmap(struct repository *r,
	 			    struct bitmap_index *bitmap_git)
	 {
	 	struct packed_git *p;
	-	int ret = -1;
	-
	-	assert(!bitmap_git->map);
	 
	 	for (p = get_all_packs(r); p; p = p->next) {
	 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
	-			ret = 0;
	-			break;
	+			return 0;
	 		}
	 	}
	-
	-	trace2_data_string("bitmap", the_repository, "open bitmap (non-midx)",
	-					   ret ? "failed" : "ok");
	-	return ret;
	+	return -1;
	 }
	 
	 static int open_midx_bitmap(struct repository *r,
	 			    struct bitmap_index *bitmap_git)
	 {
	-	int ret = -1;
	 	struct multi_pack_index *midx;
	 
	-	assert(!bitmap_git->map);
	-
	 	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
	 		if (!open_midx_bitmap_1(bitmap_git, midx)) {
	-			ret = 0;
	-			break;
	+			return 0;
	 		}
	 	}
	-	trace2_data_string("midx", the_repository, "open bitmap (midx)",
	-					   ret ? "failed" : "ok");
	-	return ret;
	+	return -1;
	 }
	 
	 static int open_bitmap(struct repository *r,
	 		       struct bitmap_index *bitmap_git)
	 {
	+	int ret;
	+
	 	assert(!bitmap_git->map);
	 
	-	if (!open_midx_bitmap(r, bitmap_git))
	-		return 0;
	-	return open_pack_bitmap(r, bitmap_git);
	+	trace2_region_enter("pack-bitmap", "open_bitmap", r);
	+	if (!open_midx_bitmap(r, bitmap_git)) {
	+		ret = 0;
	+		goto done;
	+	}
	+	ret = open_pack_bitmap(r, bitmap_git);
	+done:
	+	trace2_region_leave("pack-bitmap", "open_bitmap", r);
	+	return ret;
	 }
	 
	 struct bitmap_index *prepare_bitmap_git(struct repository *r)

I.e. surely you just want to create a region, and if you care enough to
log failure shouldn't we log that in open_midx_bitmap_1() if we care,
and perhaps error() there instead of silently returning -1?
