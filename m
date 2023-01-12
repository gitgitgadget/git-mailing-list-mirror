Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD61C677F1
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 20:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjALUzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 15:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbjALUxb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:31 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC12165B7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 12:35:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q64so20317742pjq.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 12:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eX2z4iYNsekipj/t8wwj3tEpQShWo5VQLEe7gq5WgAI=;
        b=VyvI5VqiAiTgAA2BFmoL45xgznk0i1eJf20ssVtkBmWNb8CXpUteba6GObbRTUR0Ai
         M+drg+1596vQltCsQ5ydX58Z8Ei/o4kVFVcSbMEsrUH0eO96vFN+LRAm5DjLN0OaFZFS
         PUem2x1sIoUDsCRSDlfl4tw2sRxHIPIVRdEuYTU+tTMNamhtRGNyTMBwZWDAphbMeYRn
         Y+NrQfh+oSR9V4eA1CXUXeSKzHdfCzXhOrFlUhf6wEazFU90ViDRAJUm6bhNs1R10Gzq
         NbGAj1Y8DfZfkAcHaKCpM2+IW7SnfDut88HFW25it+6zsvzc4z7MVZuv5Ww9UloZIF/c
         7hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eX2z4iYNsekipj/t8wwj3tEpQShWo5VQLEe7gq5WgAI=;
        b=6SSaAmYEuO9Lx+JTgOYmd6ojERA+sVdkU4LRfG/pXHOlNwilxhnH6nBHe589lJ/k1W
         jlwMQZXIRYXBYpLBdiep9UnZGoRAWSKj0yusw9amUYlMRqjXdrAB4yMMdWfrl2kQOjQ3
         67LvMtZ7mHnirQkT5e4kJ9K6+Demb7LSM/11ybwu4LKv0aXUuAq9FfnNbybl1yQ4NFPD
         UrKflsca7rFLF6leIxY8UqdQJd3wRzdB7Svjug5BZZn1cRarXwfsJjTM1vx8q2/JG1co
         RrukvXbBAI/csApOa4Wm+ct1rYPUvBPDttns5FvLHTUui5BdCjSR2pY8kraIzfBMGu6V
         K+Lw==
X-Gm-Message-State: AFqh2ko4NoCwTpsACIpPlh6sD53hOfkFSV26mo7vgg1CpTQ8gAkb2zCB
        EyyKgzzSMlJYW9fUe5wHPkn4XmO+FK5NUZk=
X-Google-Smtp-Source: AMrXdXvMChFYkXHtCZ27bA1uwK+eR88RTDC7GXtT/tM470B4xvA5lrnDXRN5buBd2Ss8Qn93Y2noCQ==
X-Received: by 2002:a05:6a21:3a82:b0:b6:7e03:5723 with SMTP id zv2-20020a056a213a8200b000b67e035723mr3901068pzb.42.1673555721727;
        Thu, 12 Jan 2023 12:35:21 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id v15-20020aa799cf000000b0056bc5ad4862sm3977333pfi.28.2023.01.12.12.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 12:35:21 -0800 (PST)
Message-ID: <0a5f4195-600f-d099-5879-bbd7629285b2@github.com>
Date:   Thu, 12 Jan 2023 12:35:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 05/10] test-http-server: add HTTP error response
 function
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
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <6f66bf146b4d6e4044b3c6c2224795918191bc3f.1673475190.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <6f66bf146b4d6e4044b3c6c2224795918191bc3f.1673475190.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Introduce a function to the test-http-server test helper to write more
> full and valid HTTP error responses, including all the standard response
> headers like `Server` and `Date`.

It took me a second to figure out, but this patch combines the content of
patches 4, 5, and 6 from the last iteration. After squashing those three
patches from v4 together locally, the range-diff is actually pretty simple
(see below). 

Out of curiosity, why did you combine those patches? I don't feel strongly
about changing it, but the smaller, incremental patches in the previous
version were a bit easier to review.

In any case, this version addresses my feedback from [1], [2], and [3] - the
explanatory comments are particularly helpful. Thanks!

[1] https://lore.kernel.org/git/7b7d1059-cecf-744d-6927-b41963b9e5a8@github.com/
[2] https://lore.kernel.org/git/e957d4f4-fa94-7a68-f378-38e6ed131244@github.com/
[3] https://lore.kernel.org/git/f99c381c-1d30-7c95-6158-cecd5321dafd@github.com/

Range diff v4 (patches 4-6, squashed) vs. v5 (this patch)

4:  127827637e !  5:  6f66bf146b test-http-server: add HTTP error response function
    @@ Commit message
     
      ## t/helper/test-http-server.c ##
     @@ t/helper/test-http-server.c: enum worker_result {
    - 	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
    + 	WR_HANGUP   = 1<<1,
      };
      
     +/*
    @@ t/helper/test-http-server.c: enum worker_result {
     +		hp = strbuf_detach(&h, NULL);
     +		string_list_append(&req->header_list, hp);
     +
    -+		/* store common request headers separately */
    ++		/* also store common request headers as struct req members */
     +		if (skip_prefix(hp, "Content-Type: ", &hv)) {
     +			req->content_type = hv;
     +		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
    @@ t/helper/test-http-server.c: enum worker_result {
     +
     +	if (!initialized) {
     +		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
    ++		/*
    ++		 * This regular expression matches all dumb and smart HTTP
    ++		 * requests that are currently in use, and defined in
    ++		 * Documentation/gitprotocol-http.txt.
    ++		 *
    ++		 */
     +		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
     +			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
     +			    REG_EXTENDED)) {
    @@ t/helper/test-http-server.c: enum worker_result {
     +		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
     +}
     +
    -+static enum worker_result do__git(struct req *req, const char *user)
    ++static enum worker_result do__git(struct req *req)
     +{
     +	const char *ok = "HTTP/1.1 200 OK\r\n";
     +	struct child_process cp = CHILD_PROCESS_INIT;
     +	int res;
     +
    -+	if (write(1, ok, strlen(ok)) < 0)
    ++	/*
    ++	 * Note that we always respond with a 200 OK response even if the
    ++	 * http-backend process exits with an error. This helper is intended
    ++	 * only to be used to exercise the HTTP auth handling in the Git client,
    ++	 * and specifically around authentication (not handled by http-backend).
    ++	 *
    ++	 * If we wanted to respond with a more 'valid' HTTP response status then
    ++	 * we'd need to buffer the output of http-backend, wait for and grok the
    ++	 * exit status of the process, then write the HTTP status line followed
    ++	 * by the http-backend output. This is outside of the scope of this test
    ++	 * helper's use at time of writing.
    ++	 *
    ++	 * The important auth responses (401) we are handling prior to getting
    ++	 * to this point.
    ++	 */
    ++	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
     +		return error(_("could not send '%s'"), ok);
     +
    -+	if (user)
    -+		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
    -+
     +	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
     +	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
     +			req->uri_path.buf);
    @@ t/helper/test-http-server.c: enum worker_result {
     +	cp.git_cmd = 1;
     +	strvec_push(&cp.args, "http-backend");
     +	res = run_command(&cp);
    -+	close(1);
    -+	close(0);
    ++	close(STDOUT_FILENO);
    ++	close(STDIN_FILENO);
     +	return !!res;
     +}
     +
     +static enum worker_result dispatch(struct req *req)
     +{
     +	if (is_git_request(req))
    -+		return do__git(req, NULL);
    ++		return do__git(req);
     +
    -+	return send_http_error(1, 501, "Not Implemented", -1, NULL,
    ++	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
     +			       WR_OK | WR_HANGUP);
     +}
     +
    @@ t/helper/test-http-server.c: enum worker_result {
      	char *client_port = getenv("REMOTE_PORT");
      	enum worker_result wr = WR_OK;
     @@ t/helper/test-http-server.c: static enum worker_result worker(void)
    - 	set_keep_alive(0);
    + 	set_keep_alive(0, logerror);
      
      	while (1) {
    --		if (write_in_full(1, response, strlen(response)) < 0) {
    +-		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
     -			logerror("unable to write response");
     -			wr = WR_IO_ERROR;
     -		}
     +		req__release(&req);
     +
    -+		alarm(init_timeout ? init_timeout : timeout);
    ++		alarm(timeout);
     +		wr = req__read(&req, 0);
     +		alarm(0);
     +
    -+		if (wr & WR_STOP_THE_MUSIC)
    ++		if (wr != WR_OK)
     +			break;
      
     +		wr = dispatch(&req);
    - 		if (wr & WR_STOP_THE_MUSIC)
    + 		if (wr != WR_OK)
      			break;
      	}
     
    @@ t/t5556-http-auth.sh (new)
     +
     +test_description='test http auth header and credential helper interop'
     +
    ++TEST_NO_CREATE_REPO=1
     +. ./test-lib.sh
     +
     +test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
     +
     +# Setup a repository
     +#
    -+REPO_DIR="$(pwd)"/repo
    ++REPO_DIR="$TRASH_DIRECTORY"/repo
     +
     +# Setup some lookback URLs where test-http-server will be listening.
     +# We will spawn it directly inside the repo directory, so we avoid
    @@ t/t5556-http-auth.sh (new)
     +# The server will shutdown if/when we delete it (this is easier than
     +# killing it by PID).
     +#
    -+PID_FILE="$(pwd)"/pid-file.pid
    -+SERVER_LOG="$(pwd)"/OUT.server.log
    ++PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
    ++SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
     +
     +PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     +
    @@ t/t5556-http-auth.sh (new)
     +
     +test_expect_success 'http auth anonymous no challenge' '
     +	test_when_finished "per_test_cleanup" &&
    -+	start_http_server --allow-anonymous &&
    ++	start_http_server &&
     +
     +	# Attempt to read from a protected repository
     +	git ls-remote $ORIGIN_URL

