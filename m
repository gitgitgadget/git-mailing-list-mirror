Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F06C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbiDDK6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358950AbiDDK55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 06:57:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FBC3389C
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 03:56:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d10so5766401edj.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ec6QWaolrRF+0sms/rn4/xPx81+ReZGC2llzEf9fJdg=;
        b=KO8BA1Nt3OHzBBxf8O+BW0XOIBW7Y9X+p7jIT5IF5aiA1iyjqRGUGVJ0Le2cSzx1B4
         TNq4E7V+UnDyXLmXno/ryt9FrPYrj+/Rc/enoY8nqYLackm2H9Z2xpLEGQ6MyfcnbDJ2
         XcYnaunRSkHFyKWFxCzBirgCe4G/P2J/TiGtp+xxDLHLhOnxGZzIghAbVrxikWesM0BR
         ObNdSeMmTGZlgGYG3LR5U2BmtWKCP9nqTgKNfnRvJYjZt2DEWWP+11i0HZdAV9Sf4m+C
         qQpFkyqmzfc5DCBZuZVVa1zRu0VJetXYCWCD2ZU0udctFA3fK/u2fmmh5IbD5miw+LNz
         9Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ec6QWaolrRF+0sms/rn4/xPx81+ReZGC2llzEf9fJdg=;
        b=0t/13oDNtVWW3QQ5LQ23e0CoxiwyLX4o4kRFZbfIS52mMcoqx8MhBx0rIahtPwi9e8
         vrQkw/TXrFeKb+Q5g6OUeJuU7CTYsdlkL4HSV3tl4mz5wX5WSiJExVY7gBBAC2ETAxL1
         4rLr/gWJ6z3gFJ0cXhCa1iXNWzNNHr2cIVVUIMxH2/jOXxDEMGNkLam10/norjyi5Vzk
         V563EBqymdOYItvGYbslODQfrSG1zRj/ajCiPrCAFx/brexhErqkELiCkwtfTcTaCAzq
         uYDlAyOMLav/A7fS5JoZEJaiqz3w3PdvoJeXPGVX8XDypEN1mI1xvxVeccxhjKyknSuv
         zIUQ==
X-Gm-Message-State: AOAM531YzA7aLUNAgkDqhBgsXSbd2N9S+ufskS+zX7/k7x9cYUB0yOj9
        +RJ1qk3QNNuXAh59k5zN3dA=
X-Google-Smtp-Source: ABdhPJw18vG6ZIaqtyjF8AExvU32hliWXWXkKMqPJhcc5jdZKSgBP2/iVy/t3+SSssG9wgAwoliLDA==
X-Received: by 2002:a50:9d0f:0:b0:416:95a3:1611 with SMTP id v15-20020a509d0f000000b0041695a31611mr32488666ede.77.1649069759948;
        Mon, 04 Apr 2022 03:55:59 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a5-20020aa7cf05000000b0041919e52a38sm5130616edy.46.2022.04.04.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 03:55:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbKNK-002TR3-F6;
        Mon, 04 Apr 2022 12:55:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/4] builtin/stash: provide a way to import stashes
 from a ref
Date:   Mon, 04 Apr 2022 12:38:53 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-5-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220403182250.904933-5-sandals@crustytoothpaste.net>
Message-ID: <220404.86czhxjewx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, brian m. carlson wrote:


> +	struct object_id *items = NULL;

Is there a reason for why this...

> [...]
> +		ALLOC_GROW_BY(items, nitems, 1, nalloc);
> +		oidcpy(&items[i], &oid);
> [...]
> +	for (i = nitems - 1; i >= 0; i--) {
> [...]
> +		this = lookup_commit_reference(the_repository, &items[i]);
> +	free(msg);

...can't just use the existing "oid_array" APi?

> [...]
> +static int import_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int ret = 0;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_import_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (argc != 1)
> +		return error(_("a revision to import from is required"));

I think you want to use usage_with_options() here instead.

In any case, I think you can de-init "ret" above I think, as the
compiler will then spot a future logic error if we don't reach this:

> +	ret = do_import_stash(argv[0]);
> +	return ret;
> +}
> +
>  static int do_export_stash(const char *ref, size_t argc, const char **argv)
>  {
>  	struct object_id base;
> @@ -2000,6 +2106,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
>  		return !!save_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "export"))
>  		return !!export_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "import"))
> +		return !!import_stash(argc, argv, prefix);
>  	else if (*argv[0] != '-')
>  		usage_msg_optf(_("unknown subcommand: %s"),
>  			       git_stash_usage, options, argv[0]);
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index b149e2af44..d2ddede9be 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1295,6 +1295,58 @@ test_expect_success 'stash --keep-index with file deleted in index does not resu
>  	test_path_is_missing to-remove
>  '
>  
> +test_expect_success 'stash export and import round-trip stashes' '
> +	git reset &&
> +	>untracked &&
> +	>tracked1 &&
> +	>tracked2 &&
> +	git add tracked* &&
> +	git stash -- &&
> +	>subdir/untracked &&
> +	>subdir/tracked1 &&
> +	>subdir/tracked2 &&
> +	git add subdir/tracked* &&
> +	git stash -- subdir/ &&
> +	stash0=$(git rev-parse --verify stash@{0}) &&
> +	stash1=$(git rev-parse --verify stash@{1}) &&
> +	simple=$(git stash export --print) &&
> +	git stash clear &&
> +	git stash import "$simple" &&
> +	imported0=$(git rev-parse --verify stash@{0}) &&
> +	imported1=$(git rev-parse --verify stash@{1}) &&
> +	test "$imported0" = "$stash0" &&
> +	test "$imported1" = "$stash1" &&
> +	git stash export --to-ref refs/heads/foo &&
> +	git stash clear &&
> +	git stash import foo &&
> +	imported0=$(git rev-parse --verify stash@{0}) &&
> +	imported1=$(git rev-parse --verify stash@{1}) &&
> +	test "$imported0" = "$stash0" &&
> +	test "$imported1" = "$stash1"

This whole variable assignment/test/manual rev-parse would be better as
just feeding tags you created earlier to test_cmp_rev, should be a lot
fewer lines that way, I.e. these last 4 lines become:

	git tag t-stash0 # earlier
	test_cmp_rev t-stash0 stash@{0} &&
	test_cmp_rev t-stash stash@{1}

Perhaps adding N files in one commit isn't critical, then you could even
piggy-back on "test_commit"....

> +test_expect_success 'stash import appends commits' '
> +	git log --format=oneline -g refs/stash >actual &&
> +	echo $(cat actual | wc -l) >count &&

Hrm...

> +	git stash import refs/heads/foo &&
> +	git log --format=oneline -g refs/stash >actual &&
> +	test_line_count = $(($(cat count) * 2)) actual

FWIW I think I'd save myself the trivial disk space here and less shell
trickery with:

	git log >out &&
	cat out out >out2

Then:

	test_line_count = $(wc -l <out2) actual

Or just:

	test_line_count = $(cat log-out log-out | wc -l) actual

I.e. parts of this are presumably working around the $(()) operation not
jiving with a whitespace-padded $count, so you're doing the echo instead
of a more obvious redirection to avoid that.

Which, I'd think is made more obvious by just cat-ing the earlier output
twice. Just my 0.02...

> +test_expect_success 'stash export can accept specified stashes' '
> +	git stash clear &&

This looks like it belongs as a test_when_finished line of an earlier
test that should be cleaning up after itself.

> +	git stash import foo &&
> +	git stash export --to-ref bar stash@{1} stash@{0} &&
> +	git stash clear &&
> +	git stash import bar &&
> +	imported0=$(git rev-parse --verify stash@{0}) &&
> +	imported1=$(git rev-parse --verify stash@{1}) &&
> +	test "$imported1" = "$stash0" &&
> +	test "$imported0" = "$stash1" &&

This test has an implicit dependency on your earlier test and will break
if it's not defining stash0, e.g. if you use --run=N or use other skip
test features of test-lib.sh.

Just factor that into a setup function & have the rest call it?
