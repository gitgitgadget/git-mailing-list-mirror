Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C3C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiGUVlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiGUVlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:41:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479F393697
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:41:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gq7so2771393pjb.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=mhulFVDrXayDhS47P0j/cSMP6piJzAhmA3+fbbs1b8M=;
        b=qrbYPcVCBoKSVmAQISMnsg9+/lAB7bw8EUDwfymm2BLzmQVDHAauxIwlasZZt+DTfs
         HadaA9R6oZYVWUxv9Plt07vFcTqgK/yCJtc10Xi6U7aQ7aN9jlCSDiDM8ow8UToH1Jg8
         S93HVE2A6QyhkKGwSVwj58RUujjuEcT9pG+jEG+Nlh0FB/MAlHsZdgK0W/WYQT23miy1
         zIXEnm4vybT8B1HqpkdIzihfeB0fStdniTWGT3WOpcfYjJyIEBT8bWpInGxSmmrk1WTR
         vzJRPv7ppwlRJjChO1I42Y6oQ2LcaiTV8eTZc/DuAtgOBe0aZIgN4LMKxQJC8HnP+z1Q
         hoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=mhulFVDrXayDhS47P0j/cSMP6piJzAhmA3+fbbs1b8M=;
        b=jVOfKxy+iXbaIPIP1fo7v/sHGZ3AqR+k/LO5APVCPH2hbpf1Xhdh+YkjfJY9YgifQ1
         2DlZaKRHCHcoBSiRREQh7bklsjAy/bxTpbKQRv0Xnfs5cdidtDmrJ27H9qMhQY8/GNzf
         4gMPoAjoAp4/LIGgkthVEqV75qHbPUabPQ4WcYE9lqbBB20YLfQYl75x+niT55QirjJZ
         fGaYPMsOZgHIGBLe+QnFTcxL3N1tEGgwC1GyeJJnBi7RFcTtbtwVXYokYSJf5d4PNigR
         xtUkEvJggV8e/aLD9zBJmA4DGjMt/U4DrVC8CAIzy7zXoro1sFfj1ETt+xP7g3f7xDsM
         lVyw==
X-Gm-Message-State: AJIora8/lBHfTgve91ufvkJZBGfIA+rHdWx1bHjSw7kRxlMe31f1hEr/
        VN3vjrOmwjcwE87N5d7WH3RRRA==
X-Google-Smtp-Source: AGRyM1vfK3sA34E3NurD4kxNDQsdt7ch0F01PH/aZOZTgvogUFdPrQMJoUk+ls+Pn0E6Nj9DQdEyaA==
X-Received: by 2002:a17:902:f70f:b0:16c:e07c:667d with SMTP id h15-20020a170902f70f00b0016ce07c667dmr328810plo.138.1658439676570;
        Thu, 21 Jul 2022 14:41:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:fe53:c5fe:7cbc:be96])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b0016d2e8c2228sm2131522pli.238.2022.07.21.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:41:15 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:41:09 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/6] remote-curl: add 'get' capability
Message-ID: <YtnH9fImyT+T73C9@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <0a2cf60437f781588ae8dd77963901e4e9014959.1656535245.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a2cf60437f781588ae8dd77963901e4e9014959.1656535245.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.06.29 20:40, Derrick Stolee via GitGitGadget wrote:
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
>  remote-curl.c                       | 33 +++++++++++++++++++++++++
>  t/t5557-http-get.sh                 | 37 +++++++++++++++++++++++++++++
>  transport-helper.c                  |  5 +++-
>  4 files changed, 83 insertions(+), 1 deletion(-)
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
> index 67f178b1120..f005419f872 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1276,6 +1276,34 @@ static void parse_fetch(struct strbuf *buf)
>  	strbuf_reset(buf);
>  }
>  
> +static void parse_get(struct strbuf *buf)
> +{
> +	struct http_get_options opts = { 0 };
> +	struct strbuf url = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	const char *p, *space;
> +
> +	if (!skip_prefix(buf->buf, "get ", &p))
> +		die(_("http transport does not support %s"), buf->buf);
> +
> +	space = strchr(p, ' ');
> +
> +	if (!space)
> +		die(_("protocol error: expected '<url> <path>', missing space"));
> +
> +	strbuf_add(&url, p, space - p);
> +	strbuf_addstr(&path, space + 1);
> +
> +	if (http_get_file(url.buf, path.buf, &opts))
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
> @@ -1549,9 +1577,14 @@ int cmd_main(int argc, const char **argv)
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
> index 00000000000..1fd4ded3eb1
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
> +	test_must_fail git remote-http $url $url <input 2>err &&
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
> +	GIT_TRACE2_PERF=1 git remote-http $url $url <input &&
> +	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
> +'
> +
> +test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index b4dbbabb0c2..dfbeaebe40c 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -33,7 +33,8 @@ struct helper_data {
>  		check_connectivity : 1,
>  		no_disconnect_req : 1,
>  		no_private_update : 1,
> -		object_format : 1;
> +		object_format : 1,
> +		get : 1;

This new `get` field is set in the hunk below, but it never seems to be
accessed, even in later patches in this series.


>  
>  	/*
>  	 * As an optimization, the transport code may invoke fetch before
> @@ -210,6 +211,8 @@ static struct child_process *get_helper(struct transport *transport)
>  			data->no_private_update = 1;
>  		} else if (starts_with(capname, "object-format")) {
>  			data->object_format = 1;
> +		} else if (!strcmp(capname, "get")) {
> +			data->get = 1;
>  		} else if (mandatory) {
>  			die(_("unknown mandatory capability %s; this remote "
>  			      "helper probably needs newer version of Git"),
> -- 
> gitgitgadget
> 
