Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D18BC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 19:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiKRTsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 14:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiKRTso (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 14:48:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA2B7EB
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:48:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i10so15537374ejg.6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D/kXiCfieJBncbCjFWZ6J+3whx8QLiGRRm14BFa3cDc=;
        b=axmAkdtdC/Dz3kHqgUBQ2GJGRTNNO422JPab2/2plTLlM99AaXBhMvyA2u0xEd2w7r
         4FBeelb4YSiNLo00TbvzEvI0K5DmTowribLMiAxIvpDOpZ2gxmp7kfH/eo122PMqPSXz
         LmveUtiqmwfrM5M9kZ94gBOEMsYJZGZHTG3MPQOml0QT0zUyapICrGgXMeuKwpktHbf0
         0YOZC41XjI0CVHUqaHYj1ih6ofPi4Nf4Yo1cBebdkfNHwbLf+8yWgKqE6vlWQ5q6CtzD
         2P4xGfiuf0eVjll0oo6hNCDoZhzSr8BsSU5jrVby8u3QeC6L8tEHbc6gW2T0upy06Drm
         Twaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/kXiCfieJBncbCjFWZ6J+3whx8QLiGRRm14BFa3cDc=;
        b=VYrBG2/UAqXHEXm70Z01hQzrzgihImgf3XIwUcWO/LyvXn/T2SMkSJvS5W0kMlOkk4
         ROpvAd0oeEE54GFlVWlPTSc71vrxtHP6WA2QuUhVlheK5i8sPRmtZ4NmseiyxQnXs+zm
         VdDfDeYmVSlwCIsz61xHgGJTRX8EN4YFG34Gr3LFEKvI2QMGBXsTue0wckE6GESobnhX
         HcTG21+0QDtSbv9wvI/SovrGPZM9+7efybruyBNq58YEES57D598SJbL8EkNMZUCmS+H
         qfBo6Ke7/YXpTQYOgzZP5eUog8tVOlK8vX5gmIM4k1GFeDozzw4E4j3G0MvoxgnekC25
         YIaw==
X-Gm-Message-State: ANoB5pkTjosZ3qbQmt6UKIjrMkBuL1ovTuby69eVeEDTAccILfGzDioN
        dKvz4fSaKq52uguekTzgM3G44tJXj66XfQ==
X-Google-Smtp-Source: AA0mqf6jZ1p4uSmgCErVPv8B34+PcgihS+qQMkP5iiU0u48qOParT5lAdu6gGw5lD+9x2QpU5VRN9Q==
X-Received: by 2002:a17:906:4c92:b0:78d:ad29:396f with SMTP id q18-20020a1709064c9200b0078dad29396fmr7328075eju.165.1668800922310;
        Fri, 18 Nov 2022 11:48:42 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ez6-20020a056402450600b004643f1524f3sm2150247edb.44.2022.11.18.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:48:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ow7Lt-005iaC-1I;
        Fri, 18 Nov 2022 20:48:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] builtin/*: remove or amend
 "USE_THE_INDEX_COMPATIBILITY_MACROS"
Date:   Fri, 18 Nov 2022 20:27:25 +0100
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
 <patch-12.12-b69cf6d7600-20221118T112205Z-avarab@gmail.com>
 <Y3fSJwm7qoVmvPA8@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3fSJwm7qoVmvPA8@nand.local>
Message-ID: <221118.86mt8of3hi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 18 2022, Taylor Blau wrote:

> On Fri, Nov 18, 2022 at 12:31:06PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Follow-up the preceding commit and change
>> "USE_THE_INDEX_COMPATIBILITY_MACROS" to the more narrow
>> "USE_THE_INDEX_VARIABLE" in cases where we still use "the_index".
>>
>> Then remove "USE_THE_INDEX_VARIABLE" entirely in the few cases where
>> we don't require any compatibility macros or variables anymore.
>
> Could this get squashed into the previous commit? IOW, is there any
> reason to keep them separate?

I figured it would be easier to review if I split out the changes that
are coccinelle-created v.s. the ones I made manually.

But I don't have a preference at all, whatever you think is easier.

This *could* also be a 3 patch series, which I'd prefer, but figured it
would get push-back, so I thought I'd spoon-feed the list.

I.e. just:

 1. Fix discard_index() return value
 2. Add and apply the *.cocci rule to *ALL THE THINGS*"
 3. Narrow down the macro for t/helper/*

At that point we wouldn't need "USE_THE_INDEX_VARIABLE", as we'd have
nothing except "the_index", so "USE_THE_INDEX_COMPATIBILITY_MACROS"
would do exactly what "USE_THE_INDEX_VARIABLE" does in this topic.

(We could still rename it, but I think probably the churn isn't worth it
if it's not a stop-gap to new macro use being re-introduced)

It would rip the band-aid off, there's conflicts, but the --remerge-diff
with "seen" is rather easy, or:

	diff --git a/builtin/commit.c b/builtin/commit.c
	remerge CONFLICT (content): Merge conflict in builtin/commit.c
	index 4fb7604cc24..c7dbdb2a866 100644
	--- a/builtin/commit.c
	+++ b/builtin/commit.c
	@@ -991,16 +991,11 @@ static int prepare_to_commit(const char *index_file,=
 const char *prefix,
	 		struct object_id oid;
	 		const char *parent =3D "HEAD";
=09=20
	-<<<<<<< c23106a1d9f (hi)
	-		if (!the_index.cache_nr && repo_read_index(the_repository) < 0)
	-			die(_("Cannot read index"));
	-=3D=3D=3D=3D=3D=3D=3D
	-		if (!active_nr) {
	-			discard_cache();
	-			if (read_cache() < 0)
	+		if (!the_index.cache_nr) {
	+			discard_index(&the_index);
	+			if (repo_read_index(the_repository) < 0)
	 				die(_("Cannot read index"));
	 		}
	->>>>>>> 75ae5b855fb (Merge branch 'rj/branch-copy-and-rename' into seen)
=09=20
	 		if (amend)
	 			parent =3D "HEAD^1";
	diff --git a/builtin/read-tree.c b/builtin/read-tree.c
	remerge CONFLICT (content): Merge conflict in builtin/read-tree.c
	index 5dcf0d09ed1..5d6e638c4b1 100644
	--- a/builtin/read-tree.c
	+++ b/builtin/read-tree.c
	@@ -250,15 +250,11 @@ int cmd_read_tree(int argc, const char **argv, const=
 char *cmd_prefix)
	 	if (opts.debug_unpack)
	 		opts.fn =3D debug_merge;
=09=20
	-<<<<<<< c23106a1d9f (hi)
	-	cache_tree_free(&the_index.cache_tree);
	-=3D=3D=3D=3D=3D=3D=3D
	 	/* If we're going to prime_cache_tree later, skip cache tree update */
	 	if (nr_trees =3D=3D 1 && !opts.prefix)
	 		opts.skip_cache_tree_update =3D 1;
=09=20
	-	cache_tree_free(&active_cache_tree);
	->>>>>>> 75ae5b855fb (Merge branch 'rj/branch-copy-and-rename' into seen)
	+	cache_tree_free(&the_index.cache_tree);
	 	for (i =3D 0; i < nr_trees; i++) {
	 		struct tree *tree =3D trees[i];
	 		parse_tree(tree);
	diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
	index 93051b25f56..5514afdfe7a 100644
	--- a/t/helper/test-cache-tree.c
	+++ b/t/helper/test-cache-tree.c
	@@ -30,7 +30,7 @@ int cmd__cache_tree(int argc, const char **argv)
=09=20
	 	argc =3D parse_options(argc, argv, NULL, options, test_cache_tree_usage,=
 0);
=09=20
	-	if (read_cache() < 0)
	+	if (repo_read_index(the_repository) < 0)
	 		die(_("unable to read index file"));
=09=20
	 	oidcpy(&oid, &the_index.cache_tree->oid);
=09
...and can also be applied by a "take theirs", re-run the cocci, apply
cocci patch, so no manual resolution needed. Any future conflicts would
be solved with the same procedure.

The diff would be just under ~2k lines, but pretty trivial in terms of
non-cocci changes.

Anyway, just let me know. Right now I'm assuming I'll just re-roll this
(pending any further feedback for a bit) with squashing & some other
minor changes...
