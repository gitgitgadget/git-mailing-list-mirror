Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0739EC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 23:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiB1XqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiB1Xp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 18:45:59 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C894FDF95
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:45:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p14so27994398ejf.11
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nQIJSY7Ba4ZBF2zbpM44IQe6iiPDGhGVn071NJUvzyE=;
        b=fJUhwhLfpdWGvpJjLUrzNgN5CvrrcQ75IcmFh1waIZYDV8e6VO9s3UQ0TOM85fae4I
         4no8uf7EP/tExXYvLm9+zmWehNDfM4Vn1tdZveMF2BYJEoN4nWav++OPoHGtntzg4xeo
         r/rEWYb81XbZLIOhVV3N5mgYLQSO7NtZQQuPdvem1Q/jqoFxALyCojsmCCHppWAO8I1u
         LG05GL26qRI907DTG2YuvuDFkx5mcc3opaLB6Kygeh4zOPe1a30RGQYJYCfIZ+cQXOj2
         aVzGwDFAYJ+DX2Bu/39/2JqT5GfoUQhP1xcekqhQTiy14tk/YlTm3U8hyQiuBGJ6x2D4
         qwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nQIJSY7Ba4ZBF2zbpM44IQe6iiPDGhGVn071NJUvzyE=;
        b=6nBjUoIv+6u3avYThC+SMQ6kAc8jieqgDh2Zbm33qENJ1V+Yy4dcnMGNkk28OeWyUq
         wdAlWbGXW9pHL2tQDwkGjT4BXW4X3uCCFHaeclPkJneJzpgIwjD9GZoH+oGqcwBjcJEY
         Pmyy/NIeQIx1bA6TfmW9DBz9d9APUx67VnT+m8ah9wE5FHAdW82urfIWJNNxQjStDFpV
         riIC0lxlq+bAQju8F/bgFbtDDy9gbuXwioFnVz44xiNFDTuIx6p/vJT3QDl9cg04ZvCk
         CM24vbHhsJGnNRT3XVZgOpW2YN7C8qEMV+1xivG25D0MuWAHz07UclSLF3A86N9tJyTK
         0PSQ==
X-Gm-Message-State: AOAM530V3fKI8phdgQIFdtlHneq3scKPV5u0Xdq/cFIN51WmpKIQ6NSD
        AU3l4j1y7Y2jfNLY993IOCw=
X-Google-Smtp-Source: ABdhPJz03T4EHSFGZ0dV7Y56B9vDA63EhyDpAThJADu2HmdJ0jEFxhks68hzCHsYZarAYSRowsmgeA==
X-Received: by 2002:a17:906:b252:b0:6ce:41e2:5bb7 with SMTP id ce18-20020a170906b25200b006ce41e25bb7mr16720446ejb.179.1646091899654;
        Mon, 28 Feb 2022 15:44:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hz20-20020a1709072cf400b006d1b5df5c1fsm4797476ejc.17.2022.02.28.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:44:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOphK-001fVM-JK;
        Tue, 01 Mar 2022 00:44:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Rolf Eike Beer <eb@emlix.com>
Subject: Re: Please add support for "git merge --continue -S"
Date:   Tue, 01 Mar 2022 00:28:39 +0100
References: <3769291.LUJhsIL6D6@mobilepool36.emlix.com>
 <220228.86fso35k61.gmgdl@evledraar.gmail.com> <xmqq1qzmy55g.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1qzmy55g.fsf@gitster.g>
Message-ID: <220301.86wnhe1rph.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> [...]
> There is an argument that it makes it somehow "safer" to use "merge
> --continue" because the command fails when there is no interrupted
> merge going on, but what the user sees from "git commit" when there
> is and there is not interrupted merge are so different, there is not
> much "safety" benefit in practice.  We probably should deprecate and
> eventually remove "git merge --continue" eventually, but one step at
> a time.

If you run "git status" it'll look like you have a bunch of stuff
staged, and it's easy to miss if it's telling you you're in a merge
conflict or not (especially if it scrolls off the screen).

If we're just taking personal experience into account when deciding if
something improves safety I've made that mistake more than once & more
than twice. I.e. done a parents=3D1 commit when I thought I was in a merge
(maybe confused about what terminal I was in etc).

If someone with N number of commits in this project can make that
mistake, I daresay it helps some regular users too :)

> diff --git c/Documentation/git-merge.txt w/Documentation/git-merge.txt
> index 3125473cc1..95f252598e 100644
> --- c/Documentation/git-merge.txt
> +++ w/Documentation/git-merge.txt
> @@ -122,9 +122,9 @@ list.
>  	stash entry will be saved to the stash list.
>=20=20
>  --continue::
> -	After a 'git merge' stops due to conflicts you can conclude the
> -	merge by running 'git merge --continue' (see "HOW TO RESOLVE
> -	CONFLICTS" section below).
> +	After a 'git merge' stops due to conflicts, you can conclude
> +	the merge with "git commit" (see "HOW TO RESOLVE CONFLICTS"
> +	section below).  'git merge --continue' is a synonym for it.

Saying it's a synonym isn't correct, and also now contradicts the last
paragraph of the DESCRIPTION section. Saying something like:

    'git merge --continue' will run 'git commit', after first checking
    whether a conflicted merge is underway.

Would be correct, consistent with DESCRIPTION, and basically paraphrases
what it says there.

>  <commit>...::
>  	Commits, usually other branch heads, to merge into our branch.
> @@ -326,10 +326,9 @@ After seeing a conflict, you can do two things:
>=20=20
>   * Resolve the conflicts.  Git will mark the conflicts in
>     the working tree.  Edit the files into shape and
> -   'git add' them to the index.  Use 'git commit' or
> -   'git merge --continue' to seal the deal. The latter command
> -   checks whether there is a (interrupted) merge in progress
> -   before calling 'git commit'.
> +   'git add' them to the index.  Use 'git commit' (or
> +   'git merge --continue', which stops if there is no=20
> +   interrupted merge in progress) to seal the deal.
>=20=20
>  You can work through the conflict with a number of tools:

I think the former hunk with a minor edit is an improvement, i.e. let's
say 'git commit' works too.

But losing the description of the difference between the two here in the
more detailed section, whose job it is to explain the minor details,
makes the documentation worse IMO.

The "seal the deal" wording in the pre-image is a bit odd and
inconsistent with our general tone, that's worth changing.

But there should still be some variant of "'merge --continue', unlike
'commit' will abort if no merge is in progress".

Aside: After the last time this came up & looking at this again I looked
at some of the tests, and I'm entirely confused about what f8b863598c9
(builtin/merge: honor commit-msg hook for merges, 2017-09-07) is talking
about.

I.e. it's "just a synonym", but it seems to claim that "merge
--continue" somehow remembers --allow-unrelated-histories, but not
--no-verify (for which we have a TODO test).

If you're set on deprecating it, as opposed to us supporting "merge
--continue -S" or whatever, amending/removing that TODO test seem like a
good addition.

Also, after this came up the other day I came up with this WIP to have
the "reflog" reflect what command we ran, just as we do with rebase.

IMO that really makes the difference beween the two worth it. E.g. for
my git.git integration branch running 'git reflog' and seeing at a
glance wheher something was a conflicted merge or not (as long as I
consistently use "merge --continue", which I do) really aids
readability:

diff --git a/builtin/merge.c b/builtin/merge.c
index 74e53cf20a7..3cbb47c96f9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1362,6 +1362,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge in progress (MERGE_HEAD missing)."));
=20
 		/* Invoke 'git commit' */
+		setenv("GIT_REFLOG_ACTION", "merge (continue)", 0);
 		ret =3D cmd_commit(nargc, nargv, prefix);
 		goto done;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index f0f6fda150b..f4a0b70a213 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -772,6 +772,8 @@ test_expect_success 'completed merge (git merge --conti=
nue) with --no-commit and
 	git stash show -p MERGE_AUTOSTASH >actual &&
 	test_cmp expect actual &&
 	git merge --continue 2>err &&
+	git reflog -1 >reflog &&
+	grep -F "merge (continue)" reflog &&
 	test_i18ngrep "Applied autostash." err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-5 merge-result &&


