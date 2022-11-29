Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB3C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiK2B0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiK2B0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:26:19 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0BE45A19
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:25:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so10719507pjo.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdnZqVr5EBAvqi716vhbU9mJPPuERwqDztcAEUDVjKk=;
        b=FqnBXo5r9mrcZpmPJ8FWGdwSxAXlexTpKw43Yw3/3lQeXIqdaYM456YooGTtwbI7H5
         CwhTs8ldeNPEmHgzPi3WQKnzssM54dCob18mRnR1lnUO70x7Q7pQ8Yt2EF1H4oKIBlfM
         bp0IH6ztBPsPvdMpXrs+V20irJczus+EybFP77NYSsHjsWRMP4FhhrpKiPF2BLCWo0PG
         P71TSV6F79+Aw5KCS7EEaNaMc+iIay4s/LXDJ+qlmIS4lWd1awdLo+q6a50kYQ3GN21m
         EUfJpBWfOTSwxLl13WTqsG4oK20wdmtCNHYcA2rZXcr/DpILU3PDqpLnLWYX3XCPL0A7
         Y6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdnZqVr5EBAvqi716vhbU9mJPPuERwqDztcAEUDVjKk=;
        b=TH6XorPM4c/z5hpsyFbUWfU8eyt87AsQVW18gMJ61qdE4FesVvffmpoYvtfx5ja3/z
         iBP9a9/cx6rWSgrkXEyHCcCR8yBDjRZCPu5fWOiG5+ixJspigMZOG/EYGOkEHAiL22C4
         roUNprLeEkBUnO+STP4hvyo2yHUoQbduoHmIljH81mWKoyA/icGScQvosW56QItw103T
         sOy5BO5VBh5FL28HjjOEXf75iUKSgPzzbbzI52K7n3Qll2DsC4QdJ8gKqv0Tqp/dfiX8
         aaeQzclrweRvexOva6+/YGmnfADk4nZlqQMm4odDDFpHgV2GXdFHc7kw7qIPvGqDUtq9
         1u7w==
X-Gm-Message-State: ANoB5pncMERrF+TcxeIZkHnS0uD0TfPKTvPjCRywZ/f7U1HhUYIBq9pb
        EZZe6D+eAUANnQt8v6sDPL2k
X-Google-Smtp-Source: AA0mqf7w9c6L1NDFWbDYss5/VlimeAQ5VC7jJqiEuK5CcnmBszzLlXymKtd1OqX/RBjW+3QCl9Slxw==
X-Received: by 2002:a17:90b:507:b0:213:7030:f6c1 with SMTP id r7-20020a17090b050700b002137030f6c1mr61833033pjz.184.1669685140508;
        Mon, 28 Nov 2022 17:25:40 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id jx23-20020a17090b46d700b00218f9bd50c7sm95450pjb.50.2022.11.28.17.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 17:25:39 -0800 (PST)
Message-ID: <06e45662-699b-52f9-2fdf-6e621444f446@github.com>
Date:   Mon, 28 Nov 2022 17:25:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 7/9] bundle-uri: allow relative URLs in bundle lists
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <186e112d821d9a42ffbc3c8b46e24b2b4bb3dfe8.1668628303.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <186e112d821d9a42ffbc3c8b46e24b2b4bb3dfe8.1668628303.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Bundle providers may want to distribute that data across multiple CDNs.
> This might require a change in the base URI, all the way to the domain
> name. If all bundles require an absolute URI in their 'uri' value, then
> every push to a CDN would require altering the table of contents to
> match the expected domain and exact location within it.
> 
> Allow a bundle list to specify a relative URI for the bundles.
> This allows easier distribution of bundle data.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle-uri.c                | 16 ++++++++++-
>  bundle-uri.h                |  9 +++++++
>  t/helper/test-bundle-uri.c  |  2 ++
>  t/t5750-bundle-uri-parse.sh | 54 +++++++++++++++++++++++++++++++++++++
>  transport.c                 |  3 +++
>  5 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/bundle-uri.c b/bundle-uri.c
> @@ -190,6 +192,18 @@ int bundle_uri_parse_config_format(const char *uri,
>  		.error_action = CONFIG_ERROR_ERROR,
>  	};
>  
> +	if (!list->baseURI) {
> +		struct strbuf baseURI = STRBUF_INIT;
> +		strbuf_addstr(&baseURI, uri);
> +
> +		/*
> +		 * If the URI does not end with a trailing slash, then
> +		 * remove the filename portion of the path. This is
> +		 * important for relative URIs.
> +		 */
> +		strbuf_strip_file_from_path(&baseURI);
> +		list->baseURI = strbuf_detach(&baseURI, NULL);

Is the 'baseURI' is set to the URI of the first bundle (ordered by hash)? If
data is distributed across multiple CDNs, couldn't this be a suboptimal
choice? For example, if the first bundle is on 'A.com', but every other
bundle is on 'B.org'?

> +	}
>  	result = git_config_from_file_with_options(config_to_bundle_list,
>  						   filename, list,
>  						   &opts);
> diff --git a/bundle-uri.h b/bundle-uri.h
> index 357111ecce8..7905e56732c 100644
> --- a/bundle-uri.h
> +++ b/bundle-uri.h
> @@ -61,6 +61,15 @@ struct bundle_list {
>  	int version;
>  	enum bundle_list_mode mode;
>  	struct hashmap bundles;
> +
> +	/**
> +	 * The baseURI of a bundle_list is used as the base for any
> +	 * relative URIs advertised by the bundle list at that location.
> +	 *
> +	 * When the list is generated from a Git server, then use that
> +	 * server's location.

Hmmm, I think I'm missing something with my earlier comment. I thought the
'uri' argument to 'bundle_uri_parse_config_format()' was an individual
bundle's URI? What's the "server's location" in this context?

> +	 */
> +	char *baseURI;
>  };
>  
>  void init_bundle_list(struct bundle_list *list);
> diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
> index ffb975b7b4f..5aa0b494ce3 100644
> --- a/t/helper/test-bundle-uri.c
> +++ b/t/helper/test-bundle-uri.c
> @@ -40,6 +40,8 @@ static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mo
>  
>  	init_bundle_list(&list);
>  
> +	list.baseURI = xstrdup("<uri>");

Using a hardcoded value here leads to pretty different behavior in
'test-bundle-uri.c' vs. starting with an unset 'list.baseURI' in something
like 'clone'. Why does this need to be set to '<uri>' for the tests?

> +
>  	switch (mode) {
>  	case KEY_VALUE_PAIRS:
>  		if (argc != 1)
> diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
> index c2fe3f9c5a5..ed5262a8d2b 100755
> --- a/t/t5750-bundle-uri-parse.sh
> +++ b/t/t5750-bundle-uri-parse.sh
> @@ -30,6 +30,30 @@ test_expect_success 'bundle_uri_parse_line() just URIs' '
>  	test_cmp_config_output expect actual
>  '
>  
> +test_expect_success 'bundle_uri_parse_line(): relative URIs' '
> +	cat >in <<-\EOF &&
> +	bundle.one.uri=bundle.bdl
> +	bundle.two.uri=../bundle.bdl
> +	bundle.three.uri=sub/dir/bundle.bdl
> +	EOF
> +
> +	cat >expect <<-\EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +	[bundle "one"]
> +		uri = <uri>/bundle.bdl
> +	[bundle "two"]
> +		uri = bundle.bdl

This seems a little strange, but it looks like '<uri>/../bundle.bdl'
normalizes to 'bundle.bdl' because '<uri>' is treated like a regular path
element (like a directory). 

Out of curiosity, what would happen if 'bundle.two.uri' was
'../../bundle.bdl'?

> +	[bundle "three"]
> +		uri = <uri>/sub/dir/bundle.bdl
> +	EOF
> +
> +	test-tool bundle-uri parse-key-values in >actual 2>err &&
> +	test_must_be_empty err &&
> +	test_cmp_config_output expect actual
> +'
> +
>  test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
>  	cat >in <<-\EOF &&
>  	=bogus-value
