Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA31C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLNX0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLNXZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:25:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870285216E
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:23:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so882041pjo.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrwviz8fB5S0Q2sj0sUDK1FnV+/q300Qgx/t8hkeRFs=;
        b=aTN4R9Zz7VJemhVEDZg+OMW7VxyI0qRqB1gAzJyB/ZotSdJAd/pWRzijacqznOmcjU
         8mKicCJg1Q/y1ZyvBn3Q53ygQD64FQiiIvW1ScyzkJXqLr6DIC2VzND7tmmUJ0Fa4hIe
         0KBK/qMqtKUOeSz587lYUxPnxLaipltPFmUEP7U4s+Kg/A1dfcx4zjqZThDYNOFQcyVK
         R74wX0wTaJ1VnY5Eca38c1t4bSge5B1NZnxLdzTHKp6t7JPBGZpH5A/RCpWkUP7D4ags
         HHnEXsLcAzb1/381tpbtzqeF6OixeCfKh8VE0ghbTBAJFsJkUwP+hTjHWNl80NP3Kvae
         NaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrwviz8fB5S0Q2sj0sUDK1FnV+/q300Qgx/t8hkeRFs=;
        b=zy5K3FTGK+vkmpo/uHmnDIXjqqpAWJZLMwkTC8DDwF0iORxM7V9A5xwIW9DEtv374u
         BUs5gDQoitzcH/UTfzXPg4ZubZuQWo++qMpq2KfqjQk+WeI2TXdAOmVVzObqPpZ4nTIK
         ttjTkfaSgcq76oQ/uEKlGsIG7a6v52a1VAF5NqLTa9MUTBRp9jBnyRLQJPZNEtGermwx
         Wiicm5vgijaW5dycnPtLhtV8aH0VQHgjWbsKEaeOgVY3ksxCJ91hfP7YEZhyC7DeXfPj
         lp1M30UIyixwnQN8qLRkxwEy8dF3UXvX+ZvVcVaPNlyE8laWIhFvwiMK5jpEEJ7qp/S3
         ds2g==
X-Gm-Message-State: ANoB5pnFuPBB5onyjSicgqMvZ6EPbt0SGsdcloj5kz0JZ2/lx5ENawJt
        ArG9SWdEPJfLTXgqr8dyXfloWmueMnEm0cE=
X-Google-Smtp-Source: AA0mqf6x7xvD2+D3nLjd8RRBZhtOzvY4DlVbNNJnnWnCT44xCJcFFSV2uuVZZVZOtqCvhVbLFhoABg==
X-Received: by 2002:a05:6a21:9006:b0:a4:6eeb:91ae with SMTP id tq6-20020a056a21900600b000a46eeb91aemr30665110pzb.49.1671060206030;
        Wed, 14 Dec 2022 15:23:26 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b00189951514c4sm2352491pla.206.2022.12.14.15.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:23:25 -0800 (PST)
Message-ID: <2a5d6586-3d2c-8af4-12be-a5a106f966b5@github.com>
Date:   Wed, 14 Dec 2022 15:23:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 7/8] test-http-server: add simple authentication
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
 <794256754c1f7d32e438dfb19a05444d423989aa.1670880984.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <794256754c1f7d32e438dfb19a05444d423989aa.1670880984.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> +static int is_authed(struct req *req, const char **user, enum worker_result *wr)
> +{
> +	enum auth_result result = AUTH_UNKNOWN;
> +	struct string_list hdrs = STRING_LIST_INIT_NODUP;
> +	struct auth_module *mod;
> +
> +	struct string_list_item *hdr;
> +	struct string_list_item *token;
> +	const char *v;
> +	struct strbuf **split = NULL;
> +	int i;
> +	char *challenge;
> +
> +	/*
> +	 * Check all auth modules and try to validate the request.
> +	 * The first module that matches a valid token approves the request.
> +	 * If no module is found, or if there is no valid token, then 401 error.
> +	 * Otherwise, only permit the request if anonymous auth is enabled.
> +	 */
> +	for_each_string_list_item(hdr, &req->header_list) {
> +		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {

Is only one "Authorization:" header allowed? If so, adding a 'break;' at the
end of this if-statement would make that clearer. If not, what's the
expected allow/deny behavior if e.g. one header is ALLOW'd by one auth
module, and another header is DENY'd by a different auth module?

> +			split = strbuf_split_str(v, ' ', 2);
> +			if (!split[0] || !split[1]) continue;
> +
> +			/* trim trailing space ' ' */
> +			strbuf_setlen(split[0], split[0]->len - 1);
> +
> +			mod = get_auth_module(split[0]->buf);
> +			if (mod) {
> +				result = AUTH_DENY;
> +
> +				for_each_string_list_item(token, mod->tokens) {
> +					if (!strcmp(split[1]->buf, token->string)) {
> +						result = AUTH_ALLOW;
> +						break;
> +					}
> +				}
> +
> +				goto done;
> +			}
> +		}
> +	}
> +
> +done:
> +	switch (result) {
> +	case AUTH_ALLOW:
> +		trace2_printf("%s: auth '%s' ALLOW", TR2_CAT, mod->scheme);
> +		*user = "VALID_TEST_USER";
> +		*wr = WR_OK;
> +		break;
> +
> +	case AUTH_DENY:
> +		trace2_printf("%s: auth '%s' DENY", TR2_CAT, mod->scheme);
> +		/* fall-through */
> +
> +	case AUTH_UNKNOWN:
> +		if (result != AUTH_DENY && allow_anonymous)
> +			break;

I think this just needs to be 'if (allow_anonymous)' - we already know
'result' is 'AUTH_UNKNOWN' once we reach this block.

> +		for (i = 0; i < auth_modules_nr; i++) {
> +			mod = auth_modules[i];
> +			if (mod->challenge_params)
> +				challenge = xstrfmt("WWW-Authenticate: %s %s",
> +						    mod->scheme,
> +						    mod->challenge_params);
> +			else
> +				challenge = xstrfmt("WWW-Authenticate: %s",
> +						    mod->scheme);
> +			string_list_append(&hdrs, challenge);
> +		}
> +		*wr = send_http_error(1, 401, "Unauthorized", -1, &hdrs, *wr);
> +	}
> +
> +	strbuf_list_free(split);
> +	string_list_clear(&hdrs, 0);
> +
> +	return result == AUTH_ALLOW ||
> +	      (result == AUTH_UNKNOWN && allow_anonymous);

So if a user is explicitly denied, even with 'allow_anonymous', this fails?
Is there a test case that uses that behavior and/or is that standard auth
behavior? Otherwise, it'd be simpler to skip the 'is_authed()' check (in
'dispatch()') altogether if 'allow_anonymous' is enabled.

> +}
> +
>  static enum worker_result dispatch(struct req *req)
>  {
> +	enum worker_result wr = WR_OK;
> +	const char *user = NULL;
> +
> +	if (!is_authed(req, &user, &wr))
> +		return wr;
> +
>  	if (is_git_request(req))
> -		return do__git(req, NULL);
> +		return do__git(req, user);
>  
>  	return send_http_error(1, 501, "Not Implemented", -1, NULL,
>  			       WR_OK | WR_HANGUP);
> @@ -854,6 +982,7 @@ int cmd_main(int argc, const char **argv)
>  	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
>  	int worker_mode = 0;
>  	int i;
> +	struct auth_module *mod = NULL;
>  
>  	trace2_cmd_name("test-http-server");
>  	setup_git_directory_gently(NULL);
> @@ -906,6 +1035,63 @@ int cmd_main(int argc, const char **argv)
>  			pid_file = v;
>  			continue;
>  		}
> +		if (skip_prefix(arg, "--allow-anonymous", &v)) {
> +			allow_anonymous = 1;
> +			continue;
> +		}
> +		if (skip_prefix(arg, "--auth=", &v)) {
...

> +		}
> +		if (skip_prefix(arg, "--auth-token=", &v)) {
> +			struct strbuf **p = strbuf_split_str(v, ':', 2);
> +			if (!p[0]) {
> +				error("invalid argument '%s'", v);
> +				usage(test_http_auth_usage);
> +			}
> +
> +			if (!p[1]) {
> +				error("missing token value '%s'\n", v);
> +				usage(test_http_auth_usage);
> +			}
> +
> +			/* trim trailing ':' */
> +			strbuf_setlen(p[0], p[0]->len - 1);
> +
> +			mod = get_auth_module(p[0]->buf);
> +			if (!mod) {
> +				error("auth scheme not defined '%s'\n", p[0]->buf);
> +				usage(test_http_auth_usage);
> +			}

Does this mean that '--auth' needs to be specified before '--auth-token' to
avoid the "auth scheme not defined" error? If so, this could be made less
fragile by just setting the string value of the arg in this 'if()' block,
then processing the value after the option-parsing loop.

> +
> +			string_list_append(mod->tokens, p[1]->buf);
> +			strbuf_list_free(p);
> +			continue;
> +		}
>  
>  		fprintf(stderr, "error: unknown argument '%s'\n", arg);
>  		usage(test_http_auth_usage);

I think a test (in this patch) showing how the auth headers are handled by
this HTTP server would be really helpful in demonstrating/exercising the
intended behavior. 

