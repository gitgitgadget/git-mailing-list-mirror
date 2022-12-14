Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D6C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLNXsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNXsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:48:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855630F70
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:48:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w23so5055381ply.12
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgJ4UBs2exEnZCMiIduldFhlPKYFO/nsECA626Beeho=;
        b=TTOJ5xPht+YgUGjtRzl+LAW0QyGF2VvIiDI3cwR32TsOPO49xBuXFhMqt29Q0a7w6i
         3u5+DDW/55D2nlpbsnGIErNYE+9/BhJmsQAyvocOyB5wl31WRPd4RMziSGIisbvPf49Y
         PyIXNyXclQFqoeBHiyVWWObC9uFrS5MlksSf/hbG/In6fiGPwryd9x1fXWxdAZGFM01B
         gHzJgLJ6tcFwdjBUKFV6MuMNqvGO+egwB7dYYtCWK5asW2Jxhq6S9qNm0aYhQp+n3ECM
         AOLkyYhkthDOBb5NXnGv4HFgYGtCOq4ROF5DcpmMlwAzPvEAYwZnGTxhgVYOi7J2MSFg
         5ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgJ4UBs2exEnZCMiIduldFhlPKYFO/nsECA626Beeho=;
        b=JP1DUvfKDUlNUYvLccwQNG5kzPNAEQfNQMo5rjwQal3N158yF0ALKCjafM1Ho8Iwxy
         OMDVk8J/HqvRyn6+XxqI5KfLh3/70NTH8OUv6XbzpA4cBJ69o5xo366MDJRYOQhjzL6d
         QuDCFNIDp4VQA8hl43MP2hGZzrrFQuAgg9gYh9sQldbsTGJfDa/wqCyfx6qnybzo2amt
         kLgDWZY9Q9GyU0JXsmfn9E3AaPYZO29EmObfEssVNjbHyrRZ7A8OzG+4H/tLA6CC7cvO
         7b+OPAjqvMcmP7+xnTFRoEYAw4E80Z3r30+IIj2H4QsEuRcRXO6MKooXgqFkRzBXxi31
         7rZA==
X-Gm-Message-State: ANoB5pm+TvfysMV4MBvKRlh0h3Neg8rWaZTH66F7fZS+Pkkc/k70Q6Ts
        dSWqQagegmU2PiqYLn70jwN5
X-Google-Smtp-Source: AA0mqf4cQ8RmX9wB8KKwvhbhdWp+PDsJdparSUPq0P/FXGVObTe35SLJ3BZblyXuevjLNsKV1m5mJQ==
X-Received: by 2002:a17:902:be05:b0:188:dd4c:c315 with SMTP id r5-20020a170902be0500b00188dd4cc315mr26759566pls.45.1671061691291;
        Wed, 14 Dec 2022 15:48:11 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b00178b6ccc8a0sm2431917plg.51.2022.12.14.15.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:48:10 -0800 (PST)
Message-ID: <1dc44716-2550-47de-e666-9972b102905d@github.com>
Date:   Wed, 14 Dec 2022 15:48:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 8/8] t5556: add HTTP authentication tests
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <8ecf63835229676677e3f7e33f634eb5d3a568b7.1670880984.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <8ecf63835229676677e3f7e33f634eb5d3a568b7.1670880984.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Add a series of tests to exercise the HTTP authentication header parsing
> and the interop with credential helpers. Credential helpers will receive
> WWW-Authenticate information in credential requests.

A general comment about this series - the way you have the patches organized
means that the "feature" content you're trying to integrate (the first two
patches) is contextually separated from these tests. For people that
learn/understand code via examples in tests, this makes it really difficult
to understand what's going on. To avoid that, I think you could rearrange
the patches pretty easily:

1. test-http-server: add stub HTTP server test helper (prev. patch 3)
  - t5556 could be introduced here with the basic "anonymous" test in patch
    6, but marked 'test_expect_failure'.
2. test-http-server: add HTTP error response function (prev. patch 4)
3. test-http-server: add HTTP request parsing (prev. patch 5)
4. test-http-server: pass Git requests to http-backend (prev. patch 6)
5. test-http-server: add simple authentication (prev. patch 7)
6. http: read HTTP WWW-Authenticate response headers (prev. patch 1)
7. credential: add WWW-Authenticate header to cred requests (prev patch 2)
  - Some/all of the tests from the current patch (patch 8) could be squashed
    into this one so that the tests exist directly alongside the new
    functionality they're testing.

> 
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  t/helper/test-credential-helper-replay.sh |  14 +++
>  t/t5556-http-auth.sh                      | 120 +++++++++++++++++++++-
>  2 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100755 t/helper/test-credential-helper-replay.sh
> 
> diff --git a/t/helper/test-credential-helper-replay.sh b/t/helper/test-credential-helper-replay.sh
> new file mode 100755
> index 00000000000..03e5e63dad6
> --- /dev/null
> +++ b/t/helper/test-credential-helper-replay.sh

I'm not sure a 't/helper' file is the right place for this - it's a pretty
simple shell script, but it defines a lot of information (namely 'teefile',
'catfile') that is otherwise unexplained in 't5556'. 

What about something like 'lib-rebase.sh' and its 'set_fake_editor()'? You
could create a similar test lib ('lib-credential-helper.sh') and wrapper
function (' that writes out a custom credential helper. Something like
'set_fake_credential_helper()' could also take 'teefile' and 'catfile' as
arguments, making their names more transparent to 't5556'.

> @@ -0,0 +1,14 @@
> +cmd=$1
> +teefile=$cmd-actual.cred
> +catfile=$cmd-response.cred
> +rm -f $teefile
> +while read line;
> +do
> +	if test -z "$line"; then
> +		break;
> +	fi
> +	echo "$line" >> $teefile
> +done
> +if test "$cmd" = "get"; then
> +	cat $catfile
> +fi
> diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
> index 78da151f122..541fa32bd77 100755
> --- a/t/t5556-http-auth.sh
> +++ b/t/t5556-http-auth.sh
> @@ -26,6 +26,8 @@ PID_FILE="$(pwd)"/pid-file.pid
>  SERVER_LOG="$(pwd)"/OUT.server.log
>  
>  PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
> +CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
> +	&& export CREDENTIAL_HELPER

I see - this is how you connect the "test" credential helper to the HTTP
server and header parsing (as implemented in patches 1 & 2), so that the
results can be compared for correctness.

nit: you can just 'export CREDENTIAL_HELPER="..."', rather than breaking it
into two lines. You also shouldn't need to 'export' at all - the value will
be set in the context of the test.

>  
>  test_expect_success 'setup repos' '
>  	test_create_repo "$REPO_DIR" &&
> @@ -91,7 +93,8 @@ start_http_server () {
>  
>  per_test_cleanup () {
>  	stop_http_server &&
> -	rm -f OUT.*
> +	rm -f OUT.* &&
> +	rm -f *.cred
>  }
>  
>  test_expect_success 'http auth anonymous no challenge' '
> @@ -102,4 +105,119 @@ test_expect_success 'http auth anonymous no challenge' '
>  	git ls-remote $ORIGIN_URL
>  '
>  
> +test_expect_success 'http auth www-auth headers to credential helper basic valid' '

...

> +test_expect_success 'http auth www-auth headers to credential helper custom schemes' '

...

> +test_expect_success 'http auth www-auth headers to credential helper invalid' '

These tests all look good. That said, is there any way to test more
bizarre/edge cases (headers too long to fit on one line, headers that end
with a long string of whitespace, etc.)?

