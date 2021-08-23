Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9589C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B7161051
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhHWKMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhHWKMo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:12:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA6C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:12:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dm15so361349edb.10
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=iuek+dAd/nohboB1eghoK5Q/RzIpgQv5OPLdrI0RUQQ=;
        b=SpLjJ9lmfcWeApJ00icS+eLZdrkW8hzP5ZqmTxmt/2DX1yv5bGQ62wJiSdQCAt73Ej
         PIAh4UmkL/B77d4nylbrDyqmt9nk4+nEhEWO+ofsPCn6tenUrBVfxPFpRrmBss1Tn6aM
         G37TYSDn3lR60lSsOq4y4Kgl31TPerwZnBRR7zoZ+on9YMlcCLZU/8JuVLP2gJDvip3V
         XAv+bDAY/VXbYTlCxrOyS4BhOWNrg8tGI9Spjj6nVPX1YMkVQa8iuzQppE62eZe3L1g9
         CZmPEUQnC5/ohwLttR4FganJkbKyJz822WFNJ70oBdRLWNz8hfSBZpaugDwssAfVMRgk
         8SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=iuek+dAd/nohboB1eghoK5Q/RzIpgQv5OPLdrI0RUQQ=;
        b=YC4bqzZzM+VkF9yJS6IkEEjSNigLOv6PW+4zQ6d+uy4Z5bowSi0BZ7SJ0L3TK8Qy3e
         neF+GL9tsCM6/wHZJkabbXjjn+cYoTAp8OnfLAlvbgZxdXqOSeLDrF58B/LNqtiKr5uu
         620BgKv2Tft+4/645fbk4m2fVr2w9w2p6gNE1u1gygoAKKMCUx47lM0S2aN6fekYZrm7
         LgO9X4ZawlTXzEGI8Xr2q1XT6F0myE+B40yvr98J/NZQF2ZQWlR7BBsKy9BD7ZEGhbkd
         M+FbTu4tNCCt3y91QGDbKz4UMS0BtMRd2BmvrZ3l+Il8qXTJUneXubuYtpXhDoSS1wm8
         Soqg==
X-Gm-Message-State: AOAM533Xq8cMugPeZcmpy2I6zlaRH6OxyL+vO64ZKXiu6x81rS/1hFiD
        qbfys/lJIp++GZXzqVW/lTh1Dg3hg4eDZA==
X-Google-Smtp-Source: ABdhPJxjpAN33IrqgT/lEIF/r26eNoKpBaO1bw/tJxMS6N8CHCrLwBxIZm58zI2mt6p5FaqDMDX65Q==
X-Received: by 2002:aa7:c3d0:: with SMTP id l16mr36349682edr.122.1629713520600;
        Mon, 23 Aug 2021 03:12:00 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w5sm7222349ejz.25.2021.08.23.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:12:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 20/25] refs: RFC: Reftable support for git-core
Date:   Mon, 23 Aug 2021 11:50:18 +0200
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <3d57f7c443082fd2a7f01aee003a9cd3ca2dd910.1629207607.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <3d57f7c443082fd2a7f01aee003a9cd3ca2dd910.1629207607.git.gitgitgadget@gmail.com>
Message-ID: <871r6kh3m8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 17 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> [...]
> +		if (len == cap) {
> +			cap = 2 * cap + 1;
> +			logs = realloc(logs, cap * sizeof(*logs));
> +		}
> +
> +		logs[len++] = log;
> [...]
> +		if (logs_len >= logs_cap) {
> +			int new_cap = logs_cap * 2 + 1;
> +			logs = realloc(logs, new_cap * sizeof(*logs));
> +			logs_cap = new_cap;
> +		}
> +		logs[logs_len++] = log;
> +	}

Elsewhere in this series we use the ARRAY_SIZE() macro from
git-compat-util.h, can't we also use REALLOC_ARRAY() from the same
header here?

> [...]
> +	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
> +		/* XXX - skip writing records that were not changed. */
> +		err = reftable_addition_commit(add);
> +	} else {
> +		/* XXX - print something */
> +	}

Aren't these comments covered by some of the failing tests under
GIT_TEST_REFTABLE=true? I.e. what I mentioned
https://lore.kernel.org/git/877dgch4rn.fsf@evledraar.gmail.com/

> [...]
> +	if (err < 0) {
> +		errno = reftable_error_to_errno(err);
> +		err = -1;
> +		goto done;
> +	}

In your proposed fixup for the merger of our topics in
https://lore.kernel.org/git/pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com/
you have the call to reftable_error_to_errno() here deleted, so isn't
this also redundant at this point (and then the
reftable_error_to_errno() function can be deleted), or is this errno
setting still needed with some of my changes?

> [...]
> +git_init () {
> +	git init -b primary "$@"
> +}

Can't later tests just use "main" instead of primary with a
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main, then we can drop this
"git_init" wrapper?

> +initialize ()  {
> +	rm -rf .git &&

Should instead set up a test_when_finished "rm -rf .git" ?

> +	(GIT_TEST_REFTABLE=1; export GIT_TEST_REFTABLE; git_init) &&

This export before calling git_init can surely go away if git_init goes,
but alo why export beforehand here, but in later tests in this file we
just do a plain:

    (GIT_TEST_REFTABLE=1 git_init) &&

?

> +	mv .git/hooks .git/hooks-disabled

Is this "mv" cargo-culted from what test_create_repo() used to do before
my-f0d4d398e28 (test-lib: split up and deprecate test_create_repo(),
2021-05-10)? In any case templated hooks are disabled by default (named
*.sample), so I don't think this is needed.

> +	echo hoi >> file.t &&

Nit: >>file.t, not ">> file.t".

> +	git show-ref | sed s/before/after/g > expected &&

Don't have "git" on the LHS of a pipe, it'll hide a segfault. Should use
a temporary file. Also "s/ > />/g" like above (and in some places below,
will stop noting it...).

> +test_expect_success 'SHA256 support, env' '
> +	rm -rf .git &&
> +	GIT_DEFAULT_HASH=sha256 && export GIT_DEFAULT_HASH &&
> +	(GIT_TEST_REFTABLE=1 git_init) &&
> +	mv .git/hooks .git/hooks-disabled &&

Comments about this .git/hooks-disabled not being needed aside, this
seems to be duplicating the initialize() function. I.e. should we not
skip the "rm -rf" and "mv" here, and just set GIT_DEFAULT_HASH=sha256
and call initialize?

(Better yet, if we get rid of that "git init" wrapper as I noted above,
this can just be an argument to "git init", no?

> [...]
> +	rm -rf .git &&
> +	(GIT_TEST_REFTABLE=1 git_init --object-format=sha256) &&
> +	mv .git/hooks .git/hooks-disabled &&

ditto.

> +	! git update-ref -d refs/tags/file $INVALID_SHA1 &&

Always "test_must_fail git", not "! git".

> [...]
> +test_expect_success 'clone calls transaction_initial_commit' '
> +	test_commit message1 file1 &&
> +	git clone . cloned &&
> +	(test  -f cloned/file1 || echo "Fixme.")

So this test really tests nothing much, and we should skip the "Fixme"
here and have this be test_expect_failure() or something instead?

> [...]
> +	git show-ref | cut -f2 -d" " >actual &&

Git on LHS of a pipe again.

> +# This matches show-ref's output
> +print_ref() {
> +	echo "$(git rev-parse "$1") $1"
> +}
> +
> +test_expect_success 'peeled tags are stored' '
> +	initialize &&
> +	test_commit file &&
> +	git tag -m "annotated tag" test_tag HEAD &&
> +	{
> +		print_ref "refs/heads/primary" &&
> +		print_ref "refs/tags/file" &&
> +		print_ref "refs/tags/test_tag" &&
> +		print_ref "refs/tags/test_tag^{}"
> +	} >expect &&

Maybe I'm missing something, but wouldn't this print_ref() helper be
better as a "git for-each-ref --format" of some sort?

> [...]
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"

Let's split these httpd-needing tests into another test file, see
https://lore.kernel.org/git/87bl753i2p.fsf@evledraar.gmail.com/ for why.

> [...]
> +if test_have_prereq !REFFILES
> +then
> +  skip_all='skipping pack-refs tests; need files backend'
> +  test_done
> +fi

Indent with spaces?

> +if test_have_prereq !REFFILES
> +then
> +  skip_all='skipping tests; incompatible with reftable'
> +  test_done
> +fi
> +

Ditto.

(In general for issues noted above, I saw many more of some of them,
including but not limited to this space formatting issue, but elided the
patch after the first occurrences).
