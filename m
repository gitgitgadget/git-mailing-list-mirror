Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA047C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E30860EE2
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242451AbhJOUSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhJOUSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 16:18:43 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7EDC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:16:37 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id my5-20020a17090b4c8500b001a0bf4025c1so5868293pjb.8
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=i1SWArJxOGNCx3zbFT58LEl+nlKhL66MPrXtfFhbz9s=;
        b=KVr5U4Gihq9yJJ5WdsN+CyzVbaHzSrKZBMQHbN+PYx7alj4ZTatPeTVLW0FB9RoP20
         VeAJISruP9ROnGqyqVphVd/ckfTCBf316dybrc/yHB9YKWdIRN6BlGCocXTiGQeVsR46
         dsSoqCjJSVNYY2wlViYIpTV0LmQiQYPSuVqUKn5Lpn09xoUteJGe3jq/3blnKeUP2PO1
         Dlo2mA6eykfYQQPu8/7ILSAX6Q7TpwIiVMRllGY+naBfoyXYYD4BlX7MAm7Ejh4R1peV
         S1HU+4mauXNXIHf9rE8/wdjaMCVIIIHitxLWszm0Y/LJSKsnnlzJ6X4kGUfnv/R3O+SK
         W9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=i1SWArJxOGNCx3zbFT58LEl+nlKhL66MPrXtfFhbz9s=;
        b=kEsDJst/JgbNmO3PtwoW7GMhkGR0XvXd9huRKIAvdrQdVrmrb0h+/zCOiQYLVMX2dp
         Uymh/+w5ZCOBO/CZQK+a2ZTDaBboDLJckjB2v84SYMOIUU7Mu6v5FAUJIZmINrLYFVaY
         tvFdFi6Oiuv2AD2VvueUuGOfHasO/7QKqqnwPXci+QkAmNuH4FGY6q/SkteAGDY7oHMB
         2A7m97szQdkFW+bkVbGhRjL3ivZg439ymNwX4/jYcjDPx+aXhVoHq+YCeYHliv8OzGEQ
         6IN0aQabqr2H6QWFb5+c+g5IpX2ZOoQe/+981CyYqkA5DnrRjTM8ZBSnZfAWo9BcPTFk
         1ixg==
X-Gm-Message-State: AOAM5326eLj/HiUKsbQetxASSPQKlOJO5vrkSPxDHVD9rriEK67ziUIX
        9oOHl0wTW+TsCDQW5YSJPEMnHvfJKTI6CBbRh7hmw14/ch8EzjiFeRQkdozmILobw7thTTZXxQ1
        NWW38N/qMyz13wOIJtfxoQluAwtukzhDNc3P7Dpl//aUfX8jY8aP53vWuyUsxPSA=
X-Google-Smtp-Source: ABdhPJwcW5YvtNNXPudHHkHU3lISmnTV89rSZsLMX+UZVTJUDOtG+jQkadXcPaJae2TJJHxDWkoDPJKn3ycdqw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:193:: with SMTP id
 t19mr30132837pjs.95.1634328995435; Fri, 15 Oct 2021 13:16:35 -0700 (PDT)
Date:   Fri, 15 Oct 2021 13:16:28 -0700
In-Reply-To: <20211012174208.95161-1-chooglen@google.com>
Message-Id: <20211015201631.91524-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211012174208.95161-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  Hi everyone! This patch was created in response to something we observed =
in
  Google, where fsck failed to detect that the commit graph was invalid. We
  initially assumed that fsck never checked the commit graph, but it turns =
out
  that it does so only when core.commitgraph is set, even though we set def=
aults
  for "whether to use the commit graph" in the repository settings.

  Instead of using the config, let's use repository settings where
  available. Replace core.commitGraph and core.multiPackIndex with their
  equivalent repository settings in fsck and gc.

v5 is based off =C3=86var's fix (commit-graph: make "verify" work with repl=
ace refs,
[1]). As =C3=86var noted in v4, the mktag test failures indicated buggy beh=
avior
"git commit-graph verify" when replace refs are enabled, so we should fix t=
he
bug instead of just disabling commit-graph.

=C3=86var, Derrick, thanks for the productive discussion, I feel like I und=
erstand
this area a little better now.

Barring any unseen bugs, this should be ready to merge.

[1] https://lore.kernel.org/git/cover-0.3-00000000000-20211014T233343Z-avar=
ab@gmail.com/

Changes since v4
* Rebase onto [1], which fixes a bug with commit-graph verify with replace =
refs
  enabled.
* Remove GIT_TEST_COMMIT_GRAPH=3D0 in t3800-mktag.sh because the bug that i=
t was
  covering up is now fixed.

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
 t/t5318-commit-graph.sh     | 23 ++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh |  5 ++++-
 t/t7900-maintenance.sh      | 28 ++++++++++++++++++++++++----
 6 files changed, 60 insertions(+), 12 deletions(-)

Range-diff against v4:
1:  aac1253e7b ! 1:  567d40849a fsck: verify commit graph when implicitly e=
nabled
    @@ Commit message
    =20
         Add tests to "t5318-commit-graph.sh" to verify that fsck checks th=
e
         commit-graph as expected for the 3 values of core.commitGraph. Als=
o,
    -    disable GIT_TEST_COMMIT_GRAPH for tests that use fsck in ways that
    -    assume that commit-graph checking is disabled (t/t3800-mktag.sh,
    -    t/t0410-partial-clone.sh).
    +    disable GIT_TEST_COMMIT_GRAPH in t/t0410-partial-clone.sh because =
some
    +    test cases use fsck in ways that assume that commit-graph checking=
 is
    +    disabled.
    =20
         Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
         Signed-off-by: Glen Choo <chooglen@google.com>
    @@ t/t0410-partial-clone.sh: test_expect_success 'rev-list stops traver=
sal at missi
      	! grep $FOO out
      '
    =20
    - ## t/t3800-mktag.sh ##
    -@@ t/t3800-mktag.sh: test_description=3D'git mktag: tag object verify =
test'
    -=20
    - . ./test-lib.sh
    -=20
    -+# When enabled, some commands will automatically write commit-graphs.
    -+# This will cause the mktag tests to fail because fsck will attempt t=
o
    -+# verify the out-of-sync commit graph.
    -+GIT_TEST_COMMIT_GRAPH=3D0
    -+
    - ###########################################################
    - # check the tag.sig file, expecting verify_tag() to fail,
    - # and checking that the error message matches the pattern
    -
      ## t/t5318-commit-graph.sh ##
     @@ t/t5318-commit-graph.sh: test_expect_success 'detect incorrect chun=
k count' '
      		$GRAPH_CHUNK_LOOKUP_OFFSET
2:  ed64983430 =3D 2:  7cb44a7aeb fsck: verify multi-pack-index when implic=
tly enabled
3:  821b492d8b =3D 3:  a436c45af7 gc: perform incremental repack when impli=
ctly enabled
--=20
2.33.0.1079.g6e70778dc9-goog

