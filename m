Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E28C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E46610C9
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhJLRoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhJLRog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:44:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55385C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:42:32 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q23-20020a6562570000b029023cbfb4fd73so8967293pgv.14
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=RLrqNSXJ5D/wHIXEfu01PahSXhz29ruLoF/mMaMfIf4=;
        b=s1M2h/2/490V2zLLjj0FS9fKKqYqQBvX6sO+NSPGAVQVzBmQBQgyY+O+QrjF527ZtC
         4PQnEDJ7TlVjrts8iKcU8rZ6VQaQDbFQYPEEU/NfVWL8w3fhgM31iSCzeYs53UgHzJeY
         l2usXc5t83U5qwcaZRvx+SVd5J5q1T0BCUgG5ovCAg6KWN9tz8aPoJfxhLir1muo96lj
         e4gGJtioTBDXALyJueI5zLShKBq/4UG5DQ675UpZClrmygrmPJvOD09SRlsL4eC7jiis
         PBEb0F1kU7E7QbZTur8uRuU8gcKwPlrNpiIMUS0iU827OvXhCWfXuent2iEXOCkoDnAk
         GhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=RLrqNSXJ5D/wHIXEfu01PahSXhz29ruLoF/mMaMfIf4=;
        b=wPR3FnGKUlSiEc2SIpYRO5ag3YHx6XDXrwy8ZCt3ICXRRqIZU64xGZFsQ93YE44HmY
         1TnWXR/cDSRwUvg1KUgjNnVv5+aUxvcRxcGXwHyNjSmG+yqPepQa+vaEliEsZiOqNvU4
         lAxhfmwA0v+3tt4NxA/OuX6ljDdDzU/UNPgmzQXHHWI8+8mNL7zDd0fAx1YMFZxXwviM
         2yzFNJuGn8oMHmCVPGFFfuTs3fFSt+JcZK7uKvM5BTYQOCHnVjdSCFcht29NNTXKjVOP
         /OXfoZCdfBhwxyyIpznku1tV4tDCOt6wYi//tGCWhMMkCx5ozhpUuaQ5lvN8D3VRzdcl
         /eZQ==
X-Gm-Message-State: AOAM530T9bt1muxwXQvYMNU601K0QXhdXz7JEI91I6kDAuTsf1NqY7h5
        fYNi2HIpulwXXMYtbMErlILrTh/iiXQmDTphDVz0IM+jq7K9dEjl0z4xAvHS5ryQwlMlmg55DEb
        mv5FmEy5sOC1VdAZPx8Z9Ak4LD9frM/E4vLqcVPpSNBXoJ7rTNTMEz529R16bMOc=
X-Google-Smtp-Source: ABdhPJyihTv7iWE6C84dub+kojvfgqweFki0wHGsMIBU48DkoEbB+sYAXjy3nCRPyIxHEOAoyUxS1kHzQMt1Jg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4812:: with SMTP id
 a18mr7525948pjh.40.1634060551678; Tue, 12 Oct 2021 10:42:31 -0700 (PDT)
Date:   Tue, 12 Oct 2021 10:42:05 -0700
In-Reply-To: <20211005001931.13932-1-chooglen@google.com>
Message-Id: <20211012174208.95161-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211005001931.13932-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone! This patch was created in response to something we observed in
Google, where fsck failed to detect that the commit graph was invalid. We
initially assumed that fsck never checked the commit graph, but it turns ou=
t
that it does so only when core.commitgraph is set, even though we set defau=
lts
for "whether to use the commit graph" in the repository settings.

Instead of using the config, let's use repository settings where
available. Replace core.commitGraph and core.multiPackIndex with their
equivalent repository settings in fsck and gc.

This re-roll is primarily motivated by the CI failures noted by Junio in [1=
].
The underlying cause is that GIT_TEST_COMMIT_GRAPH=3D1 (enabled in the linu=
x-gcc
job) causes commands like "git commit" to write commit-graphs, but certain =
tests
like t/t0410-partial-clone.sh and t/t3800-mktag.sh intentionally create
corruptions that cause commit-graphs to become out-of-sync/invalid. Patch 1
fixes a bug where fsck did not check commit-graphs by default, which means =
that
these tests will now fail because they have invalid commit-graphs. The easi=
est
solution I found is to disable this confusing and noisy behavior with
GIT_TEST_COMMIT_GRAPH=3D0.

And since I am re-rolling, I incorporated =C3=86var's feedback regarding th=
e commit
messages (thanks!). I considered combining patches 1 and 2, but patch 1 has=
 a
grown a little to fix the CI issues, so I've decided to keep patches 1 and =
2
separate.

This series has also seen a healthy amount of interest in test style and
coverage. We haven't converged on a path for the future, but I'd like to th=
ink
that the tests here are still a step in (approximately) the right direction=
.
Hopefully this version LGT us while we figure out what to do with tests :)

[1] https://lore.kernel.org/git/xmqqfstafyox.fsf@gitster.g/

Changes since v3
* Disable GIT_TEST_COMMIT_GRAPH in tests that intentionally corrupt things =
in a
  way that is incompatible with commit-graphs.
* Make patch 1 and 2's commit messages more concise (thanks =C3=86var!).

Changes since v2:
* Various small test fixes (thanks Eric!). Most notably, I've used -c inste=
ad of
  test_config because test_config can affect the values in subsequent tests=
.
* Rewording fix in patch 3 commit message
* Refactor tests in patch 3 so that we use a single helper function instead=
 of
  copy-pasted code

Changes since v1:
* clean up typo in patch 1 commit message=20
* document the commits that patches 1 and 2 address
* use test helpers in patch 1
* rewrite patch 2's tests so that it's easier to tell that each test
  does something different
* reword patch 3 commit message to explain the bug
* add tests to patch 3

Glen Choo (3):
  fsck: verify commit graph when implicitly enabled
  fsck: verify multi-pack-index when implictly enabled
  gc: perform incremental repack when implictly enabled

 builtin/fsck.c              |  5 +++--
 builtin/gc.c                |  5 ++---
 t/t0410-partial-clone.sh    |  6 +++++-
 t/t3800-mktag.sh            |  5 +++++
 t/t5318-commit-graph.sh     | 23 ++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh |  5 ++++-
 t/t7900-maintenance.sh      | 28 ++++++++++++++++++++++++----
 7 files changed, 65 insertions(+), 12 deletions(-)

Range-diff against v3:
1:  2f9ff949e6 ! 1:  aac1253e7b fsck: verify commit graph when implicitly e=
nabled
    @@ Metadata
      ## Commit message ##
         fsck: verify commit graph when implicitly enabled
    =20
    -    the_repository->settings is the preferred way to get certain
    -    settings (such as "core.commitGraph") because it gets default valu=
es
    -    from prepare_repo_settings(). However, cmd_fsck() reads the config
    -    directly via git_config_get_bool(), which bypasses these default v=
alues.
    -    This causes fsck to ignore the commit graph if "core.commitgraph" =
is not
    -    explicitly set in the config. This worked fine until commit-graph =
was
    -    enabled by default in 31b1de6a09 (commit-graph: turn on commit-gra=
ph by
    -    default, 2019-08-13).
    +    Change fsck to check the "core_commit_graph" variable set in
    +    "repo-settings.c" instead of reading the "core.commitGraph" variab=
le.
    +    This fixes a bug where we wouldn't verify the commit-graph if the
    +    config key was missing. This bug was introduced in
    +    31b1de6a09 (commit-graph: turn on commit-graph by default, 2019-08=
-13),
    +    where core.commitGraph was turned on by default.
    =20
    -    Replace git_config_get_bool("core.commitgraph") in fsck with the
    -    equivalent call to the_repository->settings.core_commit_graph.
    -
    -    The expected behavior is that fsck respects the config value when =
it is
    -    set, but uses the default value when it is unset. For example, for
    -    core.commitGraph, there are three cases:
    -
    -    - Config value is set to true -> enabled
    -    - Config value is set to false -> disabled
    -    - Config value is unset -> enabled
    -
    -    As such, tests cover all three cases.
    +    Add tests to "t5318-commit-graph.sh" to verify that fsck checks th=
e
    +    commit-graph as expected for the 3 values of core.commitGraph. Als=
o,
    +    disable GIT_TEST_COMMIT_GRAPH for tests that use fsck in ways that
    +    assume that commit-graph checking is disabled (t/t3800-mktag.sh,
    +    t/t0410-partial-clone.sh).
    =20
    +    Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## builtin/fsck.c ##
    @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char=
 *prefix)
      		const char *verify_argv[] =3D { "commit-graph", "verify", NULL, NUL=
L, NULL };
     =20
    =20
    + ## t/t0410-partial-clone.sh ##
    +@@ t/t0410-partial-clone.sh: test_description=3D'partial clone'
    +=20
    + # missing promisor objects cause repacks which write bitmaps to fail
    + GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=3D0
    ++# When enabled, some commands will write commit-graphs. This causes f=
sck
    ++# to fail when delete_object() is called because fsck will attempt to
    ++# verify the out-of-sync commit graph.
    ++GIT_TEST_COMMIT_GRAPH=3D0
    +=20
    + delete_object () {
    + 	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
    +@@ t/t0410-partial-clone.sh: test_expect_success 'rev-list stops trave=
rsal at missing and promised commit' '
    +=20
    + 	git -C repo config core.repositoryformatversion 1 &&
    + 	git -C repo config extensions.partialclone "arbitrary string" &&
    +-	GIT_TEST_COMMIT_GRAPH=3D0 git -C repo -c core.commitGraph=3Dfalse re=
v-list --exclude-promisor-objects --objects bar >out &&
    ++	git -C repo rev-list --exclude-promisor-objects --objects bar >out &=
&
    + 	grep $(git -C repo rev-parse bar) out &&
    + 	! grep $FOO out
    + '
    +
    + ## t/t3800-mktag.sh ##
    +@@ t/t3800-mktag.sh: test_description=3D'git mktag: tag object verify =
test'
    +=20
    + . ./test-lib.sh
    +=20
    ++# When enabled, some commands will automatically write commit-graphs.
    ++# This will cause the mktag tests to fail because fsck will attempt t=
o
    ++# verify the out-of-sync commit graph.
    ++GIT_TEST_COMMIT_GRAPH=3D0
    ++
    + ###########################################################
    + # check the tag.sig file, expecting verify_tag() to fail,
    + # and checking that the error message matches the pattern
    +
      ## t/t5318-commit-graph.sh ##
     @@ t/t5318-commit-graph.sh: test_expect_success 'detect incorrect chun=
k count' '
      		$GRAPH_CHUNK_LOOKUP_OFFSET
2:  b13ca2a695 ! 2:  ed64983430 fsck: verify multi-pack-index when implictl=
y enabled
    @@ Metadata
      ## Commit message ##
         fsck: verify multi-pack-index when implictly enabled
    =20
    -    Like the previous commit, the_repository->settings.core_multi_pack=
_index
    -    is preferable to reading "core.multiPackIndex" from the config bec=
ause
    -    prepare_repo_settings() sets a default value for
    -    the_repository->settings. This worked fine until core.multiPackInd=
ex was
    -    enabled by default in 18e449f86b (midx: enable core.multiPackIndex=
 by
    -    default, 2020-09-25).
    -
    -    Replace git_config_get_bool("core.multiPackIndex") in fsck with th=
e
    -    equivalent call to the_repository->settings.multi_pack_index.
    +    Like the previous commit, change fsck to check the
    +    "core_multi_pack_index" variable set in "repo-settings.c" instead =
of
    +    reading the "core.multiPackIndex" config variable. This fixes a bu=
g
    +    where we wouldn't verify midx if the config key was missing. This =
bug
    +    was introduced in 18e449f86b (midx: enable core.multiPackIndex by
    +    default, 2020-09-25) where core.multiPackIndex was turned on by de=
fault.
    =20
    +    Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## builtin/fsck.c ##
3:  76943aff80 =3D 3:  821b492d8b gc: perform incremental repack when impli=
ctly enabled
--=20
2.33.0.882.g93a45727a2-goog

