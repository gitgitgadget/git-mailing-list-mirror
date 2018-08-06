Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F759208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 20:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbeHFWZI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 18:25:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56037 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387641AbeHFWZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 18:25:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so15025945wmc.5
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RrD7QSWE/rUek30boYqZgYMMcmfs8ZlDYdkGdU4d/HU=;
        b=kdXkJlLM9FW8CjH7Bf4Ibk3K7gzUsSSR1Uun/ll0PvEz9eUG4ipmrdD2IByKLPKoVF
         nq0nc1SZtuJCbSa+Ng0R9RqlRtzw4kl8Y7D/CdnvH+zSG7P8RP2BeOcK1tDtdt+Zwt34
         jMXdvMUiHJrpLvinP+acaqKbuIYlH9JTc1d/TaAZtoUzH+2Yf4LXaReuUqHcP2HMgi8Y
         l7UB4iht7CIZq0XPyRXm3sz3fduGJKbLEdIvivKzETCd68a7gm5zWB6Na3K5rvpeMBg9
         8vmRi8HvtT429EkYhSRsLQ/EUd0LjKVJp1c+0o8R88yuU2rjabCO8GyB+029GwkoDXt1
         ce7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RrD7QSWE/rUek30boYqZgYMMcmfs8ZlDYdkGdU4d/HU=;
        b=qCq6o5bJxQ3TgWNNYSwVGgbZ31aZNngrC5nQVQgtP5ewVo0k25jRGNYZc7aqMwSlzo
         iEvue5BPSWL6GeyeGK13ZzjchW3uMkuPm9cHA30Q8gYuiOKuiJCYSK67X/lxsNAiCc8z
         Av+QFm42erC3/oBQrvjtJktZQL+F3DRl6pbgMj6l2TnlH8DplMd0Elt2oz6mzkLipuWm
         j4vklzkYgGnMh4e7Q14A62EDFSJGC6snU2A5NWsec3sERb7tGVnYyI+SR29cE1Lf62zm
         TcrEHlYI3Gr5//BSAxNRn59Ac0kVxHuKCk+hEq47H5BSvqipnCSclVigA1VhcPsAkmkk
         NOHw==
X-Gm-Message-State: AOUpUlHhDYrSRM5FXMKl3aliNp6gUaMlvf0THmIj/sdeiaGVBzIz+9ER
        SG1tyCtBfv7nx83uFdAyR0fVsqu3
X-Google-Smtp-Source: AAOMgpdkRLkJYWzy+dHuaOtR+LJhqreCSuDDW4gXlkaXauRSSsJBrtvtUB/J6nXuTbRLMiKBxWfCOg==
X-Received: by 2002:a1c:1004:: with SMTP id 4-v6mr12742168wmq.68.1533586464170;
        Mon, 06 Aug 2018 13:14:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n17-v6sm5411174wmc.13.2018.08.06.13.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 13:14:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3] t4150: fix broken test for am --scissors
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
        <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com>
        <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
        <27bb8e3b-5b1d-dcc2-b002-df6941c62ee6@gmail.com>
Date:   Mon, 06 Aug 2018 13:14:23 -0700
In-Reply-To: <27bb8e3b-5b1d-dcc2-b002-df6941c62ee6@gmail.com> (Andrei Rybak's
        message of "Mon, 6 Aug 2018 19:49:38 +0200")
Message-ID: <xmqqd0uvntgg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Tests for "git am --[no-]scissors" [1] work in the following way:
>
>  1. Create files with commit messages
>  2. Use these files to create expected commits
>  3. Generate eml file with patch from expected commits
>  4. Create commits using git am with these eml files
>  5. Compare these commits with expected
>
> The test for "git am --scissors" is supposed to take an e-mail with a
> scissors line and in-body "Subject:" header and demonstrate that the
> subject line from the e-mail itself is overridden by the in-body header
> and that only text below the scissors line is included in the commit
> message of the commit created by the invocation of "git am --scissors".
> However, the setup of the test incorrectly uses a commit without the
> scissors line and without the in-body header in the commit message,
> producing eml file not suitable for testing of "git am --scissors".
>
> This can be checked by intentionally breaking is_scissors_line function
> in mailinfo.c, for example, by changing string ">8", which is used by
> the test. With such change the test should fail, but does not.
>
> Fix broken test by generating eml file with scissors line and in-body
> header "Subject:". Since the two tests for --scissors and --no-scissors
> options are there to test cutting or keeping the commit message, update
> both tests to change the test file in the same way, which allows us to
> generate only one eml file to be passed to git am. To clarify the
> intention of the test, give files and tags more explicit names.
>
> [1]: introduced in bf72ac17d (t4150: tests for am --[no-]scissors,
>      2015-07-19)
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>
> Applies on top of 980a3d3dd (Merge branch 'pt/am-tests', 2015-08-03).
> This patch is also available at
>
>   https://github.com/rybak/git fix-am-scissors-test-v3
>
> Only changes since v2 are more clear tag names.

... and updated log message, which I think makes it worthwhile to
replace the previous one plus the squash/fixup with this version.

Thanks.


>  t/t4150-am.sh | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index e9b6f8158..a821dfda5 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -67,13 +67,15 @@ test_expect_success 'setup: messages' '
>  
>  	EOF
>  
> -	cat >scissors-msg <<-\EOF &&
> -	Test git-am with scissors line
> +	cat >msg-without-scissors-line <<-\EOF &&
> +	Test that git-am --scissors cuts at the scissors line
>  
>  	This line should be included in the commit message.
>  	EOF
>  
> -	cat - scissors-msg >no-scissors-msg <<-\EOF &&
> +	printf "Subject: " >subject-prefix &&
> +
> +	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
>  	This line should not be included in the commit message with --scissors enabled.
>  
>  	 - - >8 - - remove everything above this line - - >8 - -
> @@ -150,18 +152,17 @@ test_expect_success setup '
>  	} >patch1-hg.eml &&
>  
>  
> -	echo scissors-file >scissors-file &&
> -	git add scissors-file &&
> -	git commit -F scissors-msg &&
> -	git tag scissors &&
> -	git format-patch --stdout scissors^ >scissors-patch.eml &&
> +	echo file >file &&
> +	git add file &&
> +	git commit -F msg-without-scissors-line &&
> +	git tag expected-for-scissors &&
>  	git reset --hard HEAD^ &&
>  
> -	echo no-scissors-file >no-scissors-file &&
> -	git add no-scissors-file &&
> -	git commit -F no-scissors-msg &&
> -	git tag no-scissors &&
> -	git format-patch --stdout no-scissors^ >no-scissors-patch.eml &&
> +	echo file >file &&
> +	git add file &&
> +	git commit -F msg-with-scissors-line &&
> +	git tag expected-for-no-scissors &&
> +	git format-patch --stdout expected-for-no-scissors^ >patch-with-scissors-line.eml &&
>  	git reset --hard HEAD^ &&
>  
>  	sed -n -e "3,\$p" msg >file &&
> @@ -418,10 +419,10 @@ test_expect_success 'am --scissors cuts the message at the scissors line' '
>  	rm -fr .git/rebase-apply &&
>  	git reset --hard &&
>  	git checkout second &&
> -	git am --scissors scissors-patch.eml &&
> +	git am --scissors patch-with-scissors-line.eml &&
>  	test_path_is_missing .git/rebase-apply &&
> -	git diff --exit-code scissors &&
> -	test_cmp_rev scissors HEAD
> +	git diff --exit-code expected-for-scissors &&
> +	test_cmp_rev expected-for-scissors HEAD
>  '
>  
>  test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
> @@ -429,10 +430,10 @@ test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
>  	git reset --hard &&
>  	git checkout second &&
>  	test_config mailinfo.scissors true &&
> -	git am --no-scissors no-scissors-patch.eml &&
> +	git am --no-scissors patch-with-scissors-line.eml &&
>  	test_path_is_missing .git/rebase-apply &&
> -	git diff --exit-code no-scissors &&
> -	test_cmp_rev no-scissors HEAD
> +	git diff --exit-code expected-for-no-scissors &&
> +	test_cmp_rev expected-for-no-scissors HEAD
>  '
>  
>  test_expect_success 'setup: new author and committer' '
