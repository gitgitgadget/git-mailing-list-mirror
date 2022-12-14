Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F28C46467
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLNXUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLNXUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:20:19 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8C049B58
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:20:16 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 36so3018035pgp.10
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z45+lDUU+ujJ6nWP2XIxgoKvzv3RFaGrfxy1eYc7/AQ=;
        b=OlrJFH3FKtzu+10npsirOh+IlpkqTD/qX4U5KD52BSHF0LKxb6gbQOXwq70qH/vKRV
         6pY8gfr4GrU9kvc4naTEjYTNhY93UrWDpkA3H4W/sN9DxYmaKtWUekteg2ZFjulLpFcW
         Sht7Ka/HdKL4O9yFrT/I3OSSEsMAq+g7eG4Q8VsmvnmQDAicrL34dU2hQVnfysNCtQC9
         nEuwUefceRVxfZzE1EndSHQ1wsbI8/ebW/5lm/hIXckT9kb16Fqk/unAyHxjAdImaX0+
         05xRBpl95IuBR2F5hLMb5HfgpGRfGVnQ/8m3aj9KjqrkkK9jhSj8JGPtAVDH5ZZeM2ZB
         lASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z45+lDUU+ujJ6nWP2XIxgoKvzv3RFaGrfxy1eYc7/AQ=;
        b=qit9W0RMdjIWO0uQdD3jsvOgkVuYdVwK7PHeVNeQWB9fFmyycasX5H++lJPQJkjMM5
         XKibOBPaD2sxJulNe5527uyIgRYX2s1eZ7MwmTRXrH+llNgQIfeFxuk5qwiz1btTiNnH
         SzH4j40VEHBsfxOF6OsNUTmic6CWdz7abGNF9gjG6fDjvA146tVanBUt94rAXlJ71Qt6
         HQI9f8GxM7x0Vq8Fgf6j2+oZyIUWYKZWzgI0PykqdgQAS8r4Os9BKtDpwmGIAn4u8Kf3
         OF2ICvNjTe0DltiZacSR7Wb3KCdhoxAqb9HJ6bzSpyeYFzrqK1p3m/tuWwGaadaeP00k
         mnOA==
X-Gm-Message-State: ANoB5pkOST9e0nfUrFONAurEiE9WzsVadkuqeCbf1mDgpn+wOuhUNwyv
        Cekun4XpCoAK6WKzsE9cpR05
X-Google-Smtp-Source: AA0mqf7qK1s5ynpWy/2KcR9m3ap3rm9MyC+gOM+0nRa5JxFDXBBM3Jy+rjDFf10UHg40BTg488j7XQ==
X-Received: by 2002:aa7:8656:0:b0:577:509d:df80 with SMTP id a22-20020aa78656000000b00577509ddf80mr30370311pfo.24.1671060016163;
        Wed, 14 Dec 2022 15:20:16 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id f28-20020aa7969c000000b005751f455e0esm376141pfk.120.2022.12.14.15.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:20:15 -0800 (PST)
Message-ID: <f99c381c-1d30-7c95-6158-cecd5321dafd@github.com>
Date:   Wed, 14 Dec 2022 15:20:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 6/8] test-http-server: pass Git requests to
 http-backend
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
 <0a0f4fd10c8b29f327c35dadc7b17881f22b253a.1670880984.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <0a0f4fd10c8b29f327c35dadc7b17881f22b253a.1670880984.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Teach the test-http-sever test helper to forward Git requests to the
> `git-http-backend`.
> 
> Introduce a new test script t5556-http-auth.sh that spins up the test
> HTTP server and attempts an `ls-remote` on the served repository,
> without any authentication.
> 
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  t/helper/test-http-server.c |  56 +++++++++++++++++++
>  t/t5556-http-auth.sh        | 105 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100755 t/t5556-http-auth.sh
> 
> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
> index 7bde678e264..9f1d6b58067 100644
> --- a/t/helper/test-http-server.c
> +++ b/t/helper/test-http-server.c
> @@ -305,8 +305,64 @@ done:
>  	return result;
>  }
>  
> +static int is_git_request(struct req *req)
> +{
> +	static regex_t *smart_http_regex;
> +	static int initialized;
> +
> +	if (!initialized) {
> +		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
> +		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
> +			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
> +			    REG_EXTENDED)) {

Could you explain the reasoning behind this regex (e.g., in a comment)? What
sorts of valid/invalid requests does it represent? Is that the full set of
requests that are "valid" to Git, or is it a test-specific subset?

> +			warning("could not compile smart HTTP regex");
> +			smart_http_regex = NULL;
> +		}
> +		initialized = 1;
> +	}
> +
> +	return smart_http_regex &&
> +		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
> +}
> +
> +static enum worker_result do__git(struct req *req, const char *user)
> +{
> +	const char *ok = "HTTP/1.1 200 OK\r\n";
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	int res;
> +
> +	if (write(1, ok, strlen(ok)) < 0)
> +		return error(_("could not send '%s'"), ok);

Is it correct to hardcode the response status to '200 OK'? Even when
'http-backend' exits with an error?

> +
> +	if (user)
> +		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);

I'm guessing that 'user' isn't used until a later patch? I think it might be
better to not introduce that arg at all until it's needed (it'll put the
usage of 'user' in context with how its value is determined), rather than
hardcode it to 'NULL' for now.

> +
> +	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
> +	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
> +			req->uri_path.buf);
> +	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
> +	if (req->query_args.len)
> +		strvec_pushf(&cp.env, "QUERY_STRING=%s",
> +				req->query_args.buf);
> +	if (req->content_type)
> +		strvec_pushf(&cp.env, "CONTENT_TYPE=%s",
> +				req->content_type);
> +	if (req->content_length >= 0)
> +		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIdMAX,
> +				(intmax_t)req->content_length);
> +	cp.git_cmd = 1;
> +	strvec_push(&cp.args, "http-backend");
> +	res = run_command(&cp);

I'm not super familiar with 'http-backend' but as long as it 1) uses the
content passed into the environment to parse the request, and 2) writes the
response to stdout, I think this is right.

> +	close(1);
> +	close(0);
> +	return !!res;
> +}
> +
>  static enum worker_result dispatch(struct req *req)
>  {
> +	if (is_git_request(req))
> +		return do__git(req, NULL);
> +
>  	return send_http_error(1, 501, "Not Implemented", -1, NULL,
>  			       WR_OK | WR_HANGUP);
>  }
> diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
> new file mode 100755
> index 00000000000..78da151f122
> --- /dev/null
> +++ b/t/t5556-http-auth.sh
> @@ -0,0 +1,105 @@
> +#!/bin/sh
> +
> +test_description='test http auth header and credential helper interop'
> +
> +. ./test-lib.sh
> +
> +test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
> +
> +# Setup a repository
> +#
> +REPO_DIR="$(pwd)"/repo

nit: '$TEST_OUTPUT_DIRECTORY' instead of '$(pwd)' is more consistent with
what I see in other tests. 

Also, if you're creating a repo in its own subdirectory ('repo'), you can
set 'TEST_NO_CREATE_REPO=1' before importing './test-lib' to avoid creating
a repo at the root level of the test output dir - it can help avoid
potential weird/unexpected behavior as a result of being in a repo inside of
another repo.

> +
> +# Setup some lookback URLs where test-http-server will be listening.
> +# We will spawn it directly inside the repo directory, so we avoid
> +# any need to configure directory mappings etc - we only serve this
> +# repository from the root '/' of the server.
> +#
> +HOST_PORT=127.0.0.1:$GIT_TEST_HTTP_PROTOCOL_PORT
> +ORIGIN_URL=http://$HOST_PORT/
> +
> +# The pid-file is created by test-http-server when it starts.
> +# The server will shutdown if/when we delete it (this is easier than
> +# killing it by PID).
> +#
> +PID_FILE="$(pwd)"/pid-file.pid
> +SERVER_LOG="$(pwd)"/OUT.server.log
> +
> +PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
> +
> +test_expect_success 'setup repos' '
> +	test_create_repo "$REPO_DIR" &&
> +	git -C "$REPO_DIR" branch -M main
> +'
> +
> +stop_http_server () {
> +	if ! test -f "$PID_FILE"
> +	then
> +		return 0
> +	fi
> +	#
> +	# The server will shutdown automatically when we delete the pid-file.
> +	#
> +	rm -f "$PID_FILE"
> +	#
> +	# Give it a few seconds to shutdown (mainly to completely release the
> +	# port before the next test start another instance and it attempts to
> +	# bind to it).
> +	#
> +	for k in 0 1 2 3 4
> +	do
> +		if grep -q "Starting graceful shutdown" "$SERVER_LOG"
> +		then
> +			return 0
> +		fi
> +		sleep 1
> +	done
> +
> +	echo "stop_http_server: timeout waiting for server shutdown"
> +	return 1
> +}
> +
> +start_http_server () {
> +	#
> +	# Launch our server into the background in repo_dir.
> +	#
> +	(
> +		cd "$REPO_DIR"
> +		test-http-server --verbose \
> +			--listen=127.0.0.1 \
> +			--port=$GIT_TEST_HTTP_PROTOCOL_PORT \
> +			--reuseaddr \
> +			--pid-file="$PID_FILE" \
> +			"$@" \
> +			2>"$SERVER_LOG" &
> +	)
> +	#
> +	# Give it a few seconds to get started.
> +	#
> +	for k in 0 1 2 3 4
> +	do
> +		if test -f "$PID_FILE"
> +		then
> +			return 0
> +		fi
> +		sleep 1
> +	done
> +
> +	echo "start_http_server: timeout waiting for server startup"
> +	return 1
> +}

These start/stop functions look good to me!

> +
> +per_test_cleanup () {
> +	stop_http_server &&
> +	rm -f OUT.*
> +}
> +
> +test_expect_success 'http auth anonymous no challenge' '
> +	test_when_finished "per_test_cleanup" &&
> +	start_http_server --allow-anonymous &&

The '--allow-anonymous' option isn't added until patch 7 [1], so the test
will fail in this patch. I think the easiest way to solve that is to remove
it here (although I think it's fine to leave the title "anonymous no
challenge", though), then add it in patch 7. 

[1] https://lore.kernel.org/git/794256754c1f7d32e438dfb19a05444d423989aa.1670880984.git.gitgitgadget@gmail.com/

> +
> +	# Attempt to read from a protected repository
> +	git ls-remote $ORIGIN_URL
> +'
> +
> +test_done

