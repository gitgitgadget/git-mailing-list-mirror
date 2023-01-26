Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F7C54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 02:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjAZCpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 21:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAZCpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 21:45:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960A3C29E
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:45:00 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so1088018lfb.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4fWcDZ2uKQbc28VZAAZrJOlKOd4RdSEf2FXuzFSC1Q=;
        b=ZlfSPI5++HMIhvDUlE1YB5NzpsjEOiLpk+CLqjzmfsnt8D547YL9FKjoxeuSGnejgq
         BCzaoHad4y5XjmomVJ/7+kgepnqTV9XROjSCwGqUPnKHLE2isu6dsVo2PyKd/1hJbZSO
         LGoPg+ecYYdUrkdk2hWU0TT197n3zHeZ0t6KR0J90dxBLzVrniSJpHS+A0VYwOvBqpjU
         +IHPeCcng41tPJikXggXwKcV36fwA0R9uRJBkWaSGWA9K21zJ4S+ReZ12sqd0VNUdoaw
         DvkI+GkUEcQjDu/fAza1hemzHhSKjeOJJteT8Y6/RjgdvKuCf0m/ELHv9Kq7fSyUh6IZ
         6Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4fWcDZ2uKQbc28VZAAZrJOlKOd4RdSEf2FXuzFSC1Q=;
        b=Dluk9fa6lGXZY2jDnr1yE1VkhqLNrUKFMeR0ZadVLJ1bCiCAItsyj190pxvZB2BpY4
         66+PDVg/9tfmLxzEFtaE6IQNtIEajv0VnW8r+aiuoguF35YPhEOIb8B/e7WG42WJip6k
         L9lRJYi+XaAOoyo1+mDTh3RLZIj3lEzZTdhpZrMlZ6mkUeTQuKjSvrtB62tRp2opWSaW
         BPr74NgjYNo9RvKd5OXbPHBsK7wAAilY7gWpbsSQ4X7/q/OA0pkxNKDUy+SLMWr/J4Rw
         J2m6dfa7H+SeIX8DzEuHBvLxfX4ld7ZjzGECFwQWOs8LscpYLTQGEiOufEufcSVwn77a
         c2EQ==
X-Gm-Message-State: AFqh2kqZOSjN2dTDj6+e4Jspv1sppiN7Pc4V/mz16Uwht44Lx0ir3fYg
        Snv+iT/Kn1EtCvkUmWaXgQ+yFrcLJi5C+Gag6MQ=
X-Google-Smtp-Source: AMrXdXuxUE4w1PiG0mSKB5QwH4xvooFftb2i3AwjXiD+U7mctE1wMLC8YCzcfKpavOMALldAzzrSHEvtiM4+Ub33HlY=
X-Received: by 2002:a05:6512:4014:b0:4cc:548b:35f9 with SMTP id
 br20-20020a056512401400b004cc548b35f9mr2731628lfb.192.1674701098793; Wed, 25
 Jan 2023 18:44:58 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <patch-v5-19.19-f29500a4abc-20230118T120334Z-avarab@gmail.com>
In-Reply-To: <patch-v5-19.19-f29500a4abc-20230118T120334Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 18:44:00 -0800
Message-ID: <CABPp-BFScBjpDtSU4zTDRa2X+V4OZr2bNfXW39paDvtFaiSyww@mail.gmail.com>
Subject: Re: [PATCH v5 19/19] push: free_refs() the "local_refs" in set_refspecs()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 5:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Fix a memory leak that's been with us since this code was added in
> ca02465b413 (push: use remote.$name.push as a refmap, 2013-12-03).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/push.c                          | 1 +
>  t/t1416-ref-transaction-hooks.sh        | 1 +
>  t/t2402-worktree-list.sh                | 1 +
>  t/t5504-fetch-receive-strict.sh         | 1 +
>  t/t5523-push-upstream.sh                | 1 +
>  t/t5529-push-errors.sh                  | 2 ++
>  t/t5546-receive-limits.sh               | 2 ++
>  t/t5547-push-quarantine.sh              | 2 ++
>  t/t5606-clone-options.sh                | 1 +
>  t/t5810-proto-disable-local.sh          | 2 ++
>  t/t5813-proto-disable-ssh.sh            | 2 ++
>  t/t7409-submodule-detached-work-tree.sh | 1 +
>  t/t7416-submodule-dash-url.sh           | 2 ++
>  t/t7450-bad-git-dotfiles.sh             | 2 ++
>  14 files changed, 21 insertions(+)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 60ac8017e52..f48e4c6a856 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -129,6 +129,7 @@ static void set_refspecs(const char **refs, int nr, c=
onst char *repo)
>                 } else
>                         refspec_append(&rs, ref);
>         }
> +       free_refs(local_refs);

In the cover letter, you said you took Rene's feedback as a possible
future improvement, but perhaps it's at least calling out in the code
with a TODO comment?


>  }
>
>  static int push_url_of_remote(struct remote *remote, const char ***url_p=
)
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index 27731722a5b..b32ca798f9f 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -5,6 +5,7 @@ test_description=3D'reference transaction hooks'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success setup '
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> index 79e0fce2d90..9ad9be0c208 100755
> --- a/t/t2402-worktree-list.sh
> +++ b/t/t2402-worktree-list.sh
> @@ -5,6 +5,7 @@ test_description=3D'test git worktree list'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-stri=
ct.sh
> index ac4099ca893..14e8af1f3b7 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -4,6 +4,7 @@ test_description=3D'fetch/receive strict mode'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup and inject "corrupt or missing" object' '
> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> index fdb42920564..c9acc076353 100755
> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -4,6 +4,7 @@ test_description=3D'push with --set-upstream'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>
> diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
> index ce85fd30ad1..0247137cb36 100755
> --- a/t/t5529-push-errors.sh
> +++ b/t/t5529-push-errors.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'detect some push errors early (before contacting rem=
ote)'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup commits' '
> diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
> index 0b0e987fdb7..eed3c9d81ab 100755
> --- a/t/t5546-receive-limits.sh
> +++ b/t/t5546-receive-limits.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'check receive input limits'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  # Let's run tests with different unpack limits: 1 and 10000
> diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
> index 1876fb34e51..9f899b8c7d7 100755
> --- a/t/t5547-push-quarantine.sh
> +++ b/t/t5547-push-quarantine.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'check quarantine of objects during push'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'create picky dest repo' '
> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index cf221e92c4d..27f9f776389 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -4,6 +4,7 @@ test_description=3D'basic clone options'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t5810-proto-disable-local.sh b/t/t5810-proto-disable-local=
.sh
> index c1ef99b85c2..862610256fb 100755
> --- a/t/t5810-proto-disable-local.sh
> +++ b/t/t5810-proto-disable-local.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'test disabling of local paths in clone/fetch'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-proto-disable.sh"
>
> diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable-ssh.sh
> index 3f084ee3065..2e975dc70ec 100755
> --- a/t/t5813-proto-disable-ssh.sh
> +++ b/t/t5813-proto-disable-ssh.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'test disabling of git-over-ssh in clone/fetch'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-proto-disable.sh"
>
> diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-=
detached-work-tree.sh
> index 374ed481e9c..574a6fc526e 100755
> --- a/t/t7409-submodule-detached-work-tree.sh
> +++ b/t/t7409-submodule-detached-work-tree.sh
> @@ -13,6 +13,7 @@ TEST_NO_CREATE_REPO=3D1
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.s=
h
> index 3ebd9859814..7cf72b9a076 100755
> --- a/t/t7416-submodule-dash-url.sh
> +++ b/t/t7416-submodule-dash-url.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'check handling of disallowed .gitmodule urls'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index ba1f569bcbb..0d0c3f2c683 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -12,6 +12,8 @@ Such as:
>
>    - symlinked .gitmodules, etc
>  '
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-pack.sh
>
> --
> 2.39.0.1225.g30a3d88132d
>
