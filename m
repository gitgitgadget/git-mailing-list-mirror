Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E375C3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 18:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjAMSSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjAMSSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 13:18:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A585FB2
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 10:10:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so24196893plr.10
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbIGrYrBdLoz1lPZ86HFNDhOklYmUSTScpYLSokzR+E=;
        b=DKj1XJ91OKbTeRj0gYX5Jdch/30bGuIV6Bb10sAGVO4P0HlsafOymJ9BFA4u8uYXqJ
         7aR+R9jXsKWvX92dYFcSqEDNHM2vyI7bolsRKvBM3X7sewRWCZC3tEYg7J5ZNKGFmS7h
         mzp13fZ6Zn0lbhcYLJIqIwucE2erqSOa7eY2GG0kdpCQwkY1ae+SBJqMxirNyfrEJ5Ga
         FczYtpSdxuD4COAmvIAAYX9RZ2ccjzz1JahfC8L9xnB+dfjSawANIIu5PGKbtTV//J9w
         xCReTKKnaHji3l/tpXzAKWGVO0hUAAwyET0j/eYagVpgBLV7faucYVc3c1G9OfwzmJqi
         FdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbIGrYrBdLoz1lPZ86HFNDhOklYmUSTScpYLSokzR+E=;
        b=uOonBYhPb9HZQ3VIlnN0Ao1HldYx7V2FOxwf7IZT1ISuO0V/hz0mDYW0mT4Y5n8JBQ
         reMULg/2ETgUzdHdsE+diaJaGLWjMaRK0uQB1NSb3Sx3Bvd8nO/qyPtaNwxK960INSS0
         0vhSU4+7HwAiQ7Gbs26f5ZWxGJ9HBrsAopvDJJyNw88aWaHrgztVpa9h1Oyo5A1aIw60
         Ex8fHZ2Dvy/692K2Q2l469Eo9aoghCR7PfNRrMjNS65H0D/DSSAuqgR70Vc7vuLYtzKs
         Udt2w3xteDk2bX4CWHCzM3LS1kGkk3h/3ByOy4I1kBYiDknQN3iZvE2vBy3whKEux/s+
         tHsQ==
X-Gm-Message-State: AFqh2koD2t8RZZ/+nBiDHvmL2W4dGKU/cAHDrsLcZK9X0ltHzNyg1oEG
        8y6/ELx/BmL2aUrtsY7Les9i
X-Google-Smtp-Source: AMrXdXukuSTmRWRFZXATZ/6ySlfWbA49gw57Ofqm9h9CA5MKgW6AfwjCKVopiOG2xw7nz1n1f+2VZA==
X-Received: by 2002:a17:902:c495:b0:193:ea7:52b8 with SMTP id n21-20020a170902c49500b001930ea752b8mr27192212plx.41.1673633406078;
        Fri, 13 Jan 2023 10:10:06 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b00177f25f8ab3sm14465183plh.89.2023.01.13.10.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 10:10:05 -0800 (PST)
Message-ID: <2a0b5f3f-7ab2-bc9e-76ac-93a52b4d32d0@github.com>
Date:   Fri, 13 Jan 2023 10:10:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 06/10] test-http-server: add simple authentication
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
 <c3c3d17a688963acc180e3bb7bbb4deb32a94304.1673475190.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <c3c3d17a688963acc180e3bb7bbb4deb32a94304.1673475190.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> +static struct auth_module *create_auth_module(const char *scheme,
> +					      const char *challenge)
> +{
> +	struct auth_module *mod = xmalloc(sizeof(struct auth_module));
> +	mod->scheme = xstrdup(scheme);
> +	mod->challenge_params = challenge ? xstrdup(challenge) : NULL;
> +	CALLOC_ARRAY(mod->tokens, 1);
> +	string_list_init_dup(mod->tokens);
> +	return mod;
> +}

> +
> +static int add_auth_module(struct auth_module *mod)
> +{
> +	if (get_auth_module(mod->scheme))
> +		return error("duplicate auth scheme '%s'\n", mod->scheme);
> +
> +	ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
> +	auth_modules[auth_modules_nr++] = mod;
> +
> +	return 0;
> +}

> +static int split_auth_param(const char *str, char **scheme, char **val, int required_val)
> +{
> +	struct strbuf **p = strbuf_split_str(str, ':', 2);
> +
> +	if (!p[0])
> +		return -1;
> +
> +	/* trim trailing ':' */
> +	if (p[1])
> +		strbuf_setlen(p[0], p[0]->len - 1);
> +
> +	if (required_val && !p[1])
> +		return -1;
> +
> +	*scheme = strbuf_detach(p[0], NULL);
> +
> +	if (p[1])
> +		*val = strbuf_detach(p[1], NULL);
> +
> +	strbuf_list_free(p);
> +	return 0;
> +}

There's nothing really *new* in these functions in this iteration, just code
moved from the option parsing/handling in 'cmd_main()' into dedicated
functions. Looks good!

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

I completely missed the "fall-through" comment in my last review [1], as you
kindly pointed out [2]. ;) Given that, this makes sense to me.

[1] https://lore.kernel.org/git/2a5d6586-3d2c-8af4-12be-a5a106f966b5@github.com/
[2] https://lore.kernel.org/git/AS2PR03MB981593EB3382F9738D2CA3D7C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com/

> +
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
> +
> +		for (i = 0; i < extra_headers.nr; i++)
> +			string_list_append(&hdrs, extra_headers.v[i]);
> +
> +		*wr = send_http_error(STDOUT_FILENO, 401, "Unauthorized", -1,
> +				      &hdrs, *wr);

The "extra_headers" configuration is new, and helps make the test server
more flexible. 

> +static int read_auth_config(const char *name, const char *val, void *data)
> +{
> +	int ret = 0;
> +	char *scheme = NULL;
> +	char *token = NULL;
> +	char *challenge = NULL;
> +	struct auth_module *mod = NULL;
> +
> +	if (!strcmp(name, "auth.challenge")) {
> +		if (split_auth_param(val, &scheme, &challenge, 0)) {
> +			ret = error("invalid auth challenge '%s'", val);
> +			goto cleanup;
> +		}
> +
> +		mod = create_auth_module(scheme, challenge);
> +		if (add_auth_module(mod)) {
> +			ret = error("failed to add auth module '%s'", val);
> +			goto cleanup;
> +		}
> +	}
> +	if (!strcmp(name, "auth.token")) {
> +		if (split_auth_param(val, &scheme, &token, 1)) {
> +			ret = error("invalid auth token '%s'", val);
> +			goto cleanup;
> +		}
> +
> +		mod = get_auth_module(scheme);
> +		if (!mod) {
> +			ret = error("auth scheme not defined '%s'\n", scheme);
> +			goto cleanup;
> +		}
> +
> +		string_list_append(mod->tokens, token);
> +	}

I don't think this addresses the implicit option ordering requirement noted
in [3]; instead of needing '--auth' before '--auth-token', this now needs
'auth.challenge' before 'auth.token' in the config file. While I'd prefer it
if this could be rearranged so that the auth setup happens after all config
parsing (so the order doesn't matter), if you want to leave it as-is please
add a comment somewhere in this file explaining that requirement and/or add
a note to the "auth scheme not defined" error message.  

[3] https://lore.kernel.org/git/2a5d6586-3d2c-8af4-12be-a5a106f966b5@github.com/

> +	if (!strcmp(name, "auth.allowanonymous")) {
> +		allow_anonymous = git_config_bool(name, val);
> +	}
> +	if (!strcmp(name, "auth.extraheader")) {
> +		strvec_push(&extra_headers, val);
> +	}

Is it worth printing a warning if the option found isn't any of the above?
Something like "ignoring <config option>". This is a test helper, so
user-friendliness isn't quite as important as it is for builtins, but the
warning might be helpful to developers trying to use it in the future.

> +
> +cleanup:
> +	free(scheme);
> +	free(token);
> +	free(challenge);
> +
> +	return ret;
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
> -		return do__git(req);
> +		return do__git(req, user);
>  
>  	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
>  			       WR_OK | WR_HANGUP);
> @@ -624,6 +853,19 @@ int cmd_main(int argc, const char **argv)
>  			pid_file = v;
>  			continue;
>  		}
> +		if (skip_prefix(arg, "--auth-config=", &v)) {
> +			if (!strlen(v)) {
> +				error("invalid argument - missing file path");
> +				usage(test_http_auth_usage);
> +			}
> +
> +			if (git_config_from_file(read_auth_config, v, NULL)) {
> +				error("failed to read auth config file '%s'", v);
> +				usage(test_http_auth_usage);
> +			}
> +
> +			continue;
> +		}
>  
>  		fprintf(stderr, "error: unknown argument '%s'\n", arg);
>  		usage(test_http_auth_usage);

