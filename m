Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08480EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjGETqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjGETqs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:46:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E858E9F
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:46:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99357737980so471037166b.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586405; x=1691178405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5oCvUVvsNAHCFzeFxaOo6HDveJTYZ9k3uQ6V/xseqHg=;
        b=QaIyxYfM8VpCd/o8NlG8I1W2GNn+pGQq2yVxKNdkr9d2nvoygoFDMRrBdR0nH+auYt
         vaLEqWlStAiiXSIbc0L+il61FkvFkmq64PM1QdoMKo9b/K3MKST31j13ZWmrP6plZJLJ
         MP0S6JuKDRWvnP6ph+IrrbmDMdks68aLJ5jOp9nHqx8ZBfI2MVCf3+ZGYTBHvt+nKnTC
         CD6SrIvEIxcByL0RpI+iPV9x1oDt0UuZsSJ9XrZyCCkLF64bnrDGQay5GcykDhTmDMzy
         v4qA/EAuJftheRxz0ppeqB/zp0P2lof56T+O919PoLb6vbA+sXiiLmeNtb6Wd2MnjMhS
         KCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586405; x=1691178405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oCvUVvsNAHCFzeFxaOo6HDveJTYZ9k3uQ6V/xseqHg=;
        b=J43P93EPBKOZAt30PBkpnFMzW2zKNvo+QaQPu6zM5RS02Qpk5mlD5y1jPo/wTaWQK/
         zgmXWTztAf52Wdp49PDEB6M6rRiUHuiLobbP7MuzDKeW4tVHu5vpL/lasYMBgKZZdBua
         GFIATP9P0hm4z7KyLSB7dw7fYPK83DqaTvXyjvd8yk0QS9KY4G+BujHhvN3fLzMsgcXU
         03KZLL16vodT2+41C16hG4M8oMA1Nzw5hug6XsugV9zG+jaIspm+ouVf6qjcHVY2S7IV
         GVKekDD8k2EK9iopwcueuUaSAnP7Yrl+6VaP9T3kEMSVBgaY56h5L6Fn6qrvE1s2jvUn
         9jGw==
X-Gm-Message-State: ABy/qLbhHu688PEBTyCzpOjeBfb62LpMi64aZ2FUB5+UWiBolxT78WVs
        pLYgBwLPla5Wh7keQC4mHK8=
X-Google-Smtp-Source: APBJJlEoOhaspHdlp7Jd/3kV1aj6aR/sN5WaWwgtgn7DlNPr+HXVybNwCY2OEV1jgl9B7wZ1OicKKw==
X-Received: by 2002:a17:906:dfeb:b0:988:6491:98e3 with SMTP id lc11-20020a170906dfeb00b00988649198e3mr14565882ejc.68.1688586405103;
        Wed, 05 Jul 2023 12:46:45 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id mh4-20020a170906eb8400b0098951bb4dc3sm3618731ejb.184.2023.07.05.12.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 12:46:44 -0700 (PDT)
Message-ID: <161932f5-ae8f-cfaa-a6b0-ab140d0f002e@gmail.com>
Date:   Wed, 5 Jul 2023 20:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] t0091-bugreport.sh: actually verify some content of
 report
Content-Language: en-US
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <CAN0heSrMCnygWUC5Sh1UA9v2JGtjcxYDKPFE0xUPddGEW29c3w@mail.gmail.com>
 <20230705184058.3057709-1-martin.agren@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230705184058.3057709-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin

This version looks good to me, thanks for re-rolling

Phillip

On 05/07/2023 19:40, Martin Ågren wrote:
> In the first test in this script, 'creates a report with content in the
> right places', we generate a report and pipe it into our helper
> `check_all_headers_populated()`. The idea of the helper is to find all
> lines that look like headers ("[Some Header Here]") and to check that
> the next line is non-empty. This is supposed to catch erroneous outputs
> such as the following:
> 
>    [A Header]
>    something
>    more here
> 
>    [Another Header]
> 
>    [Too Early Header]
>    contents
> 
> However, we provide the lines of the bug report as filenames to grep,
> meaning we mostly end up spewing errors:
> 
>    grep: : No such file or directory
>    grep: [System Info]: No such file or directory
>    grep: git version:: No such file or directory
>    grep: git version 2.41.0.2.gfb7d80edca: No such file or directory
> 
> This doesn't disturb the test, which tugs along and reports success, not
> really having verified the contents of the report at all.
> 
> Note that after 788a776069 ("bugreport: collect list of populated
> hooks", 2020-05-07), the bug report, which is created in our hook-less
> test repo, contains an empty section with the enabled hooks. Thus, even
> the intention of our helper is a bit misguided: there is nothing
> inherently wrong with having an empty section in the bug report.
> 
> Let's instead split this test into three: first verify that we generate
> a report at all, then check that the introductory blurb looks the way it
> should, then verify that the "[System Info]" seems to contain the right
> things. (The "[Enabled Hooks]" section is tested later in the script.)
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>   (Resend of v3, now with correct In-Reply-To.)
> 
>   t/t0091-bugreport.sh | 67 +++++++++++++++++++++++++++++---------------
>   1 file changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> index b6d2f591ac..f6998269be 100755
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -5,29 +5,50 @@ test_description='git bugreport'
>   TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
> -# Headers "[System Info]" will be followed by a non-empty line if we put some
> -# information there; we can make sure all our headers were followed by some
> -# information to check if the command was successful.
> -HEADER_PATTERN="^\[.*\]$"
> -
> -check_all_headers_populated () {
> -	while read -r line
> -	do
> -		if test "$(grep "$HEADER_PATTERN" "$line")"
> -		then
> -			echo "$line"
> -			read -r nextline
> -			if test -z "$nextline"; then
> -				return 1;
> -			fi
> -		fi
> -	done
> -}
> -
> -test_expect_success 'creates a report with content in the right places' '
> -	test_when_finished rm git-bugreport-check-headers.txt &&
> -	git bugreport -s check-headers &&
> -	check_all_headers_populated <git-bugreport-check-headers.txt
> +test_expect_success 'create a report' '
> +	git bugreport -s format &&
> +	test_file_not_empty git-bugreport-format.txt
> +'
> +
> +test_expect_success 'report contains wanted template (before first section)' '
> +	sed -ne "/^\[/q;p" git-bugreport-format.txt >actual &&
> +	cat >expect <<-\EOF &&
> +	Thank you for filling out a Git bug report!
> +	Please answer the following questions to help us understand your issue.
> +
> +	What did you do before the bug happened? (Steps to reproduce your issue)
> +
> +	What did you expect to happen? (Expected behavior)
> +
> +	What happened instead? (Actual behavior)
> +
> +	What'\''s different between what you expected and what actually happened?
> +
> +	Anything else you want to add:
> +
> +	Please review the rest of the bug report below.
> +	You can delete any lines you don'\''t wish to share.
> +
> +
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'sanity check "System Info" section' '
> +	test_when_finished rm -f git-bugreport-format.txt &&
> +
> +	sed -ne "/^\[System Info\]$/,/^$/p" <git-bugreport-format.txt >system &&
> +
> +	# The beginning should match "git version --build-info" verbatim,
> +	# but rather than checking bit-for-bit equality, just test some basics.
> +	grep "git version [0-9]." system &&
> +	grep "shell-path: ." system &&
> +
> +	# After the version, there should be some more info.
> +	# This is bound to differ from environment to environment,
> +	# so we just do some rather high-level checks.
> +	grep "uname: ." system &&
> +	grep "compiler info: ." system
>   '
>   
>   test_expect_success 'dies if file with same name as report already exists' '
