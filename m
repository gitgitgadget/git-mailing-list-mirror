Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D3BC19F2C
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 22:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiG0WJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiG0WJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 18:09:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24153D15
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:08:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 23so13706pgc.8
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+TxZ3qiA1Yq/rO5p9no4o0MrV7P1GUP360pzjP9TVg=;
        b=kHgsD1oGre4mNLEISrkfbm5vpCabWMi3vBx5h8w0x6MNNr/jPdl4QlHqrCAPRrG+Fy
         3JFx+2q3Jql5VANRlhaSRGBFxUCeROiQQqTsN/iUxC2J7d/bv8PS/dqi+S+t9hf/4ygq
         K/oSvjzRrFJsNklVjec+jN/Z5XWRDzh7ZzPa/ucXJj4mhE5ZXzdLifQXgVKFdP/3AAsu
         6r5J93Kr47jiXQOSEOXsO3QSBOF+XwpgFOg8t+CWSjqYMRPrH8rlxRxcCDau4sCWaBjt
         2crooV3zLXIOtvKxsL64JFCqVUXvjSqKQyVp/2sU44pwG4vEgnE6mTwPGjLWucfU92Sf
         Akrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=q+TxZ3qiA1Yq/rO5p9no4o0MrV7P1GUP360pzjP9TVg=;
        b=yOldSC9p34m0NvpFToJLHZKpea9lUrsXJ4v62XIY5XosmY8TByYmaBKt0LOgY+EDWd
         s8vTwU2hzfoRsbjD7RGEv0zk4i/qNK75NHZRMoKe4RxuoapxK3kXSeCjSEhmN1GhlgeK
         pyS1d5GiDzPCk7Spu6SliKlUWiSwDUoztj58lI/QQ7XdE0bxgJRkpIOcy5SsnSLPfqgG
         OGXfGzcm+8ltcaVeR2f+fN/0Bn88ShML6tnhO6DbZk6WAu0tYJbA+fTS8hZTSNk8I/3s
         x5u5N5UqjOcOGOcgnpDdcXULhwwq3MWrDGJmwOJL2sJDp3W9iyJKFQ1yuq+UBeMxA4X7
         6L+A==
X-Gm-Message-State: AJIora9OxBobZgt/fgcBf3D44Pfg2mBCH4s718XYYmdKGpPQfaSWwYOk
        +G5lZE05ib0gYMKb+jGC1Iqzpw==
X-Google-Smtp-Source: AGRyM1ubDDQiFU9+Vjl0ZWit9aNEQsRDzoqkfTlNQoF5m16/RLZscCUFVD0u6cnF4bUhi1CdE/jytQ==
X-Received: by 2002:a63:88c8:0:b0:415:b09f:9212 with SMTP id l191-20020a6388c8000000b00415b09f9212mr20182118pgd.524.1658959737276;
        Wed, 27 Jul 2022 15:08:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6dea:f5ba:2fa:f9c3])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902d4c600b0016c1b178628sm14544164plg.269.2022.07.27.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 15:08:56 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:50 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/5] remote-curl: add 'get' capability
Message-ID: <YuG3cuFEvhL+wKs/@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <40808e92afb7bcf3e8e9b4b53d5e30b5e17816f8.1658781277.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40808e92afb7bcf3e8e9b4b53d5e30b5e17816f8.1658781277.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.25 20:34, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> A future change will want a way to download a file over HTTP(S) using
> the simplest of download mechanisms. We do not want to assume that the
> server on the other side understands anything about the Git protocol but
> could be a simple static web server.
> 
> Create the new 'get' capability for the remote helpers which advertises
> that the 'get' command is avalable. A caller can send a line containing
> 'get <url> <path>' to download the file at <url> into the file at
> <path>.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/gitremote-helpers.txt |  9 +++++++
>  remote-curl.c                       | 32 +++++++++++++++++++++++++
>  t/t5557-http-get.sh                 | 37 +++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100755 t/t5557-http-get.sh
> 
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index 6f1e269ae43..ed8da428c98 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -168,6 +168,9 @@ Supported commands: 'list', 'import'.
>  	Can guarantee that when a clone is requested, the received
>  	pack is self contained and is connected.
>  
> +'get'::
> +	Can use the 'get' command to download a file from a given URI.
> +
>  If a helper advertises 'connect', Git will use it if possible and
>  fall back to another capability if the helper requests so when
>  connecting (see the 'connect' command under COMMANDS).
> @@ -418,6 +421,12 @@ Supported if the helper has the "connect" capability.
>  +
>  Supported if the helper has the "stateless-connect" capability.
>  
> +'get' <uri> <path>::
> +	Downloads the file from the given `<uri>` to the given `<path>`. If
> +	`<path>.temp` exists, then Git assumes that the `.temp` file is a
> +	partial download from a previous attempt and will resume the
> +	download from that position.
> +
>  If a fatal error occurs, the program writes the error message to
>  stderr and exits. The caller should expect that a suitable error
>  message has been printed if the child closes the connection without
> diff --git a/remote-curl.c b/remote-curl.c
> index b8758757ece..73fbdbddd84 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1286,6 +1286,33 @@ static void parse_fetch(struct strbuf *buf)
>  	strbuf_reset(buf);
>  }
>  
> +static void parse_get(struct strbuf *buf)
> +{
> +	struct strbuf url = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	const char *p, *space;
> +
> +	if (!skip_prefix(buf->buf, "get ", &p))
> +		die(_("http transport does not support %s"), buf->buf);

Nit: since we're already calling skip_prefix(...) in cmd_main() below,
can we just pass the suffix to parse_get() and avoid having to skip the
prefix twice?


> +
> +	space = strchr(p, ' ');
> +
> +	if (!space)
> +		die(_("protocol error: expected '<url> <path>', missing space"));
> +
> +	strbuf_add(&url, p, space - p);
> +	strbuf_addstr(&path, space + 1);
> +
> +	if (http_get_file(url.buf, path.buf, NULL))
> +		die(_("failed to download file at URL '%s'"), url.buf);
> +
> +	strbuf_release(&url);
> +	strbuf_release(&path);
> +	printf("\n");
> +	fflush(stdout);
> +	strbuf_reset(buf);
> +}
> +
>  static int push_dav(int nr_spec, const char **specs)
>  {
>  	struct child_process child = CHILD_PROCESS_INIT;
> @@ -1564,9 +1591,14 @@ int cmd_main(int argc, const char **argv)
>  				printf("unsupported\n");
>  			fflush(stdout);
>  
> +		} else if (skip_prefix(buf.buf, "get ", &arg)) {
> +			parse_get(&buf);
> +			fflush(stdout);
> +
>  		} else if (!strcmp(buf.buf, "capabilities")) {
>  			printf("stateless-connect\n");
>  			printf("fetch\n");
> +			printf("get\n");
>  			printf("option\n");
>  			printf("push\n");
>  			printf("check-connectivity\n");
> diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
> new file mode 100755
> index 00000000000..50b7dbcf957
> --- /dev/null
> +++ b/t/t5557-http-get.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='test downloading a file by URL'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +test_expect_success 'get by URL: 404' '
> +	url="$HTTPD_URL/none.txt" &&
> +	cat >input <<-EOF &&
> +	capabilities
> +	get $url file1
> +	EOF
> +
> +	test_must_fail git remote-http $url <input 2>err &&
> +	test_path_is_missing file1 &&
> +	grep "failed to download file at URL" err &&
> +	rm file1.temp
> +'
> +
> +test_expect_success 'get by URL: 200' '
> +	echo data >"$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" &&
> +
> +	url="$HTTPD_URL/exists.txt" &&
> +	cat >input <<-EOF &&
> +	capabilities
> +	get $url file2
> +
> +	EOF
> +
> +	GIT_TRACE2_PERF=1 git remote-http $url <input &&
> +	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
> +'
> +
> +test_done
> -- 
> gitgitgadget
> 
