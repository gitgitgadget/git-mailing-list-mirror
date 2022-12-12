Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17D5C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 08:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiLLIoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 03:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLLIn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 03:43:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE1DFF2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 00:43:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bj12so26015269ejb.13
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 00:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLY8CuI5S0pKx6ZcEX3HMYI1ZcupOhSNanQnVwFcGWA=;
        b=q3uojzU14/m0B0rXlZyldehJROhMmSFPcsICMlK13rQ1Me5Vv/l8HrklQhpAdvgXqk
         aeOzL41kSFnh+QHsDGd6hZhAO8TLtcwdB+RkLw1aboBytIHnlvfKpgj52Wp52l7YMUHs
         Np0nRl3UBQwZWggWWyPbDJbvU46DWhEDETG4JJHqduCYo3SXz4uVzx4uzH4WJMhrA0wu
         n2Yi1vcbNkMyzlojJy/YLBwjFnWRLKMGno7S9QJIpjXcWpqp2HXLFiVR2FKZ+DVmi+JL
         ffAD9GwFYIsBIA1X9I6ZU6gSzP3ZwBxAuySHFlMbxPZwOkiY89RDJFW6D09P6tA/SeCj
         CqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLY8CuI5S0pKx6ZcEX3HMYI1ZcupOhSNanQnVwFcGWA=;
        b=vfgNDent6FeuggBeMvbxr7KxFolAnsVZ0Fj54EJrzkWecPBpKXgpytvs3cI2XlnDbW
         SN2SB5ICRfStO2GnQVTCjpfySInLufBe/qiNh9FRANzm6fpMfug+KfmxTv+lhx0iEGJg
         /p9QFWSXd19XYKlbLCnqvU5M4dmKmNkzoGDRJCN7Tooy67wLM/G3aP2AqqdVXCrOQzHN
         dapJ72NBBeDLqG3fen88rtrxYONOXL/zBG6oDd21sQ0/4aterqEA2JR89Tz1LoC4vdqV
         zNDqDNQm9Wc1HJ8HA729Tr7MliuqmEy3IEqnq7YlQUdvYB5t0qaXxoCXhel/AcDGgth/
         w8bA==
X-Gm-Message-State: ANoB5pl/1LAPNn2ax5MUf5YKbX/ANw6E0OdI6gNizh1QDg3QUVkZBbkR
        JzaZX9Dli7SWkZg/U66utuA=
X-Google-Smtp-Source: AA0mqf4njwDxZ+vlG9R/H23LKkJl9XLEnuRFoT8GNr0Ppg+kXRRYtO4ngFuc15Bh8QJDpcowiBo6JQ==
X-Received: by 2002:a17:906:af6a:b0:7c1:12ef:bf52 with SMTP id os10-20020a170906af6a00b007c112efbf52mr11584558ejb.3.1670834636699;
        Mon, 12 Dec 2022 00:43:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hq18-20020a1709073f1200b007c10fe64c5dsm3016576ejc.86.2022.12.12.00.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 00:43:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4ePj-005D3m-1n;
        Mon, 12 Dec 2022 09:43:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 3/3] worktree add: Add hint to use --orphan when bad ref
Date:   Mon, 12 Dec 2022 09:35:10 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221212014003.20290-4-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221212014003.20290-4-jacobabel@nullpo.dev>
Message-ID: <221212.86pmcp57w4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Jacob Abel wrote:

>  int git_default_advice_config(const char *var, const char *value);
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 51b247b2a7..ea306e18de 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -744,6 +744,14 @@ static int add(int ac, const char **av, const char *prefix)
>  		 * If `branch` does not reference a valid commit, a new
>  		 * worktree (and/or branch) cannot be created based off of it.
>  		 */
> +		advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
> +			"If you meant to create a worktree containing a new orphan branch\n"
> +			"(branch with no commits) for this repository, e.g. '%s',\n"

I think this '%s' is just confusing, how is repeating the name of the
branch at the user (which we're about to mention in the example command)
helpful?

Shouldn't we just omit it, or reword this to e.g.:

	If you'd like the '%s' branch to be a worktree containing a
	new....


> +			"you can do so using the --orphan option:\n"
> +			"\n"
> +			"	git worktree add --orphan %s %s\n"
> +			"\n",

Missing the usual:

	"Turn this message off by running\n"
	"\"git config advice.worktreeAddOrphan false\""

blurb.

Also, should we really add twe newlines at the end? I see some other API
users that don't add a \n at all.

> +# Helper function to test hints for using --orphan in an empty repo.

FWIW I think we can do without the comment...

> +test_wt_add_empty_repo_orphan_hint() {
> +	local context="$1" &&
> +	local opts="${@:2}" &&

This appears to be some shell pseudo-syntax, and my shell hard-errors on
this.

But as we don't "shift" after the "$1" I don't see how what you
*probably* meant could work, i.e. we always have arguments, so surely
we'd always use "$@"?


> +	test_expect_success "'worktree add' show orphan hint in empty repo w/ $context" '
> +		test_when_finished "rm -rf empty_repo" &&
> +		GIT_DIR="empty_repo" git init --bare &&
> +		test_must_fail git -C empty_repo worktree add $opts 2> actual &&
> +		grep "hint: If you meant to create a worktree containing a new orphan branch" actual
> +	'
> +}
> +
> +test_wt_add_empty_repo_orphan_hint 'DWIM' foobar/
> +test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch foobar/
> +test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch foobar/

You're just testing how these options interact, so let's have the
"foobar" part provided by the test function itself.
