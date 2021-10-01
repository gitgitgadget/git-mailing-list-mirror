Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0716FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96DB61A82
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353520AbhJAKTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353453AbhJAKTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:19:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C2C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:17:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dj4so33913521edb.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PMjw3nmEZAm9Q2ZBAtzjkmnd9HV4eUsgFGHEtP8Q6Sk=;
        b=fcLvIiQBmri9pKZf929Nv4ruxBUV9fqzTQb3WF65ckrWZuQGQ8mkQDTzglc5jyvFHn
         TpNF6nMih+9OIaoL25Pl0hwzjCaLtvyHFY7+rsS6VSCMhdQ6BugEQtJDn7xP/CPxd9if
         u+5qWLmIujFeqbOUOSUXA70A4yFFOfwOEPk9MZEfp1qWZu7MZmwMUnL2Zev+PZKvMVva
         GES757s1OKAPYwpdP+xV+gGQEZLW3afPFyUwFmzTMwF45WcN1+UiTPKMFjK48bxs4oZW
         +K5mhp66JHFaUt7ZZD8MsJ7cuA+lKb12R6gZvAEFshIRRncpKtJTux3+GzE2xs8Coobi
         hGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PMjw3nmEZAm9Q2ZBAtzjkmnd9HV4eUsgFGHEtP8Q6Sk=;
        b=qB7fgYytRUipXHiIlL59y/Wl0pHMGR0zMZWZn3OZD4++9fIiv0De2cCau/J0xcSD+u
         66s1Aak04UWrJjoXH7oRJLxkAWDUwJI8z1iWNH4uyfJFZJtsnyU4gl3EkrNOFmCEVkFY
         B7uLiPZqOMtYiRNcNJA36b5tqTY/a8VpZirp42IWeadKb/2nODzsFTTQNeRanbg9Kv6L
         i1OJqYZGejZXuI5qobc9zQgzEckiKMO8MMbROQZpp21I8VMBjEucpNBOblAhOnyPivwb
         Wn9nm9aDTCFJH4InUWaeQAi9niKVsrTEynFTZa5zkP7OUFLrQP8iO2Bwj+KOv/rVn2JE
         AbjA==
X-Gm-Message-State: AOAM533OXTJcZyfLFCtFZtB29ggleCHNOaxpHisVR3gtZISrdqmUX7Pm
        DzGZz0Ocf263FeGrrncvUd6HmhhNtkqbfw==
X-Google-Smtp-Source: ABdhPJx5YJ1t2Z50XR0L051DJh0INSRnM5I+ZnWDRo9iShcsyfBAdVKz1/lbncjm29P70WU2d5JRog==
X-Received: by 2002:a17:906:36d6:: with SMTP id b22mr5101509ejc.387.1633083444800;
        Fri, 01 Oct 2021 03:17:24 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j5sm2699642ejb.96.2021.10.01.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:17:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to
 unpack_trees_options
Date:   Fri, 01 Oct 2021 11:53:43 +0200
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
 <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com>
 <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
 <87ee97utaq.fsf@evledraar.gmail.com>
 <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
 <87lf3etaih.fsf@evledraar.gmail.com>
 <CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKWatz8-B4RsA@mail.gmail.com>
 <87k0ixrv23.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87k0ixrv23.fsf@evledraar.gmail.com>
Message-ID: <877dexrqvg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 01 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Aside about safety: One thing I'll sometimes do when I'm unsure about
> those sorts of fixes is to have my new INIT set a new "sentinel" field
> to "12345" or whatever, then just BUG() out in an entry point in the API
> that you can't avoid calling if it's not set like that, e.g. dir_clear()
> or whatever the setup/work function is.

For reference: Something like the below, which passes with my WIP
patches. Showing that no non-static entry point can reach the code in
unpack-trees.c without "foo" being 12345, which can only be the case if
callers have used the macro (and the code internal to unpack-trees.c is
easy enough to audit).

 unpack-trees.c | 25 +++++++++++++++++++++++++
 unpack-trees.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index d40af221e1c..f2365ecf215 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -199,6 +199,8 @@ void clear_unpack_trees_porcelain(struct unpack_trees_o=
ptions *opts)
 {
 	strvec_clear(&opts->msgs_to_free);
 	dir_clear(&opts->dir);
+	if (opts->foo !=3D 12345)
+		BUG("noes");
 	memset(opts->msgs, 0, sizeof(opts->msgs));
 }
=20
@@ -1702,6 +1704,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, s=
truct unpack_trees_options
 	struct pattern_list pl;
 	int free_pattern_list =3D 0;
=20
+	if (o->foo !=3D 12345)
+		BUG("noes");
+
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
=20
@@ -1903,6 +1908,9 @@ enum update_sparsity_result update_sparsity(struct un=
pack_trees_options *o)
 	unsigned old_show_all_errors;
 	int free_pattern_list =3D 0;
=20
+	if (o->foo !=3D 12345)
+		BUG("noes");
+
 	old_show_all_errors =3D o->show_all_errors;
 	o->show_all_errors =3D 1;
=20
@@ -2033,6 +2041,8 @@ static int verify_uptodate_1(const struct cache_entry=
 *ce,
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o)
 {
+	if (o->foo !=3D 12345)
+		BUG("noes");
 	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
 		return 0;
 	return verify_uptodate_1(ce, o, ERROR_NOT_UPTODATE_FILE);
@@ -2417,6 +2427,9 @@ int threeway_merge(const struct cache_entry * const *=
stages,
 	int no_anc_exists =3D 1;
 	int i;
=20
+	if (o->foo !=3D 12345)
+		BUG("noes");
+
 	for (i =3D 1; i < o->head_idx; i++) {
 		if (!stages[i] || stages[i] =3D=3D o->df_conflict_entry)
 			any_anc_missing =3D 1;
@@ -2580,6 +2593,9 @@ int twoway_merge(const struct cache_entry * const *sr=
c,
 	const struct cache_entry *oldtree =3D src[1];
 	const struct cache_entry *newtree =3D src[2];
=20
+	if (o->foo !=3D 12345)
+		BUG("noes");
+
 	if (o->merge_size !=3D 2)
 		return error("Cannot do a twoway merge of %d trees",
 			     o->merge_size);
@@ -2654,6 +2670,9 @@ int bind_merge(const struct cache_entry * const *src,
 	const struct cache_entry *old =3D src[0];
 	const struct cache_entry *a =3D src[1];
=20
+	if (o->foo !=3D 12345)
+		BUG("noes");
+
 	if (o->merge_size !=3D 1)
 		return error("Cannot do a bind merge of %d trees",
 			     o->merge_size);
@@ -2680,6 +2699,9 @@ int oneway_merge(const struct cache_entry * const *sr=
c,
 	const struct cache_entry *old =3D src[0];
 	const struct cache_entry *a =3D src[1];
=20
+	if (o->foo !=3D 12345)
+		BUG("noes");
+
 	if (o->merge_size !=3D 1)
 		return error("Cannot do a oneway merge of %d trees",
 			     o->merge_size);
@@ -2717,6 +2739,9 @@ int stash_worktree_untracked_merge(const struct cache=
_entry * const *src,
 	const struct cache_entry *worktree =3D src[1];
 	const struct cache_entry *untracked =3D src[2];
=20
+	if (o->foo !=3D 12345)
+		BUG("noes");
+
 	if (o->merge_size !=3D 2)
 		BUG("invalid merge_size: %d", o->merge_size);
=20
diff --git a/unpack-trees.h b/unpack-trees.h
index 75b67f90ccd..8dae0938ad1 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -90,10 +90,12 @@ struct unpack_trees_options {
=20
 	struct pattern_list *pl; /* for internal use */
 	struct checkout_metadata meta;
+	int foo;
 };
 #define UNPACK_TREES_OPTIONS_INIT { \
 	.msgs_to_free =3D STRVEC_INIT, \
 	.dir =3D DIR_INIT, \
+	.foo =3D 12345, \
 }
=20
 void unpack_trees_init(struct unpack_trees_options *options);
