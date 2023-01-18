Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03AFC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjARMQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjARMQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:22 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5B98767F
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:38:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id az20so63432283ejc.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV/1uFHpDRlzPhzesD4TxC6+6m4e63YZrr+uQM0eOUI=;
        b=Q1nX3OzcSZYoxgQ/IZ2vPHDgs69ucidkGbtvg4WiQV/eWkhqYx2te7O1+BR+mnnmE6
         8+3eHzYjH+Zia1ntU11lDD92itTArmTEXoeXcaxo95W2CL0YLmi6370dCBBbI2aCdAis
         eS+RjTg0zV3wNNSi/eNAkreDdR54l10Iofw3CP0Hv9EawkPF6Hh8o/RTRlY0qikzPU+Y
         KiD70bbU/N/+n1QDEvN1KyyJykSnNDa6Pj74NjeHx+iIvf6Rzjr9cLFJij2dnJzv0HiH
         614t2lsKoruox5s8KoApNxX+CxwALOzWAeJsoV/VR+rTNYucoMzRm7kSn5WexCiyede4
         KgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV/1uFHpDRlzPhzesD4TxC6+6m4e63YZrr+uQM0eOUI=;
        b=cvYNagPNi4E7JziwinzXwB6jI99uvaU+/182VBkIZ2gmFthJHnjNOCrlX8iWFlGwFx
         I9/+gERKnpzp0bgloGufEkLfNZhTgJnhOAPka6VvX8vVyHYzEBFv8kFGxRkWFYYNAUiz
         7FCgia6Q2r3+x+TBfzC+sGul0dR2AuVvHxQL2Wi1tbZ3VfZTCyn4yd18NXlTinHVa/z8
         hFCehYlbB1weeG3K/icI1Ol2DTVcp2eGnFbAgXhipXt6xF9eNJ1nUQ095hV9z6Qm8cDu
         L7Zcqdoav2zG7K8fMQnNgdqN1Qh5xruYjUncry62JczCgFi8iOzzZuMenJX9hWpvsd7p
         MpvA==
X-Gm-Message-State: AFqh2kqEm3bRQ6zEZGw2f6agEy6XYPu29W9iWMk1MrsxpfDAk8AVTRYl
        zLv71rmNTZTc0UKd1YA4wc0+/OIOoHAi2w==
X-Google-Smtp-Source: AMrXdXtg39gTbkQ8s09MGLhvvVRM+urlgMtxBAgI6G1HZ9mfHMaJOF660/WdBZQHvT5A3upNZC9Q9A==
X-Received: by 2002:a17:906:7f8c:b0:86c:360:3dad with SMTP id f12-20020a1709067f8c00b0086c03603dadmr18500878ejr.53.1674041890581;
        Wed, 18 Jan 2023 03:38:10 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b007bd7178d311sm14568145ejo.51.2023.01.18.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:38:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pI6ld-002oUD-1J;
        Wed, 18 Jan 2023 12:38:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v6 08/12] test-http-server: add simple authentication
Date:   Wed, 18 Jan 2023 12:21:29 +0100
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <a1ff55dd6e25aa39f14b494f482720edf7d1eabd.1674012618.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <a1ff55dd6e25aa39f14b494f482720edf7d1eabd.1674012618.git.gitgitgadget@gmail.com>
Message-ID: <230118.867cxkxece.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:


> +static struct auth_module *get_auth_module(const char *scheme, int create)
> +{
> +	int i;
> +	struct auth_module *mod;
> +	for (i = 0; i < auth_modules_nr; i++) {

We can use "for (size_t i = 0" syntax now, let's do that here to not mix
"size_t" and "int" types needlessly.

> +	if (create) {
> +		struct auth_module *mod = xmalloc(sizeof(struct auth_module));
> +		mod->scheme = xstrdup(scheme);
> +		mod->challenge_params = NULL;
> +		CALLOC_ARRAY(mod->tokens, 1);
> +		string_list_init_dup(mod->tokens);

Don't use CALLOC_ARRAY() if you're then going to use
string_list_init_dup() (which is good!), use ALLOC_ARRAY() instead. We
don't need to set the memory to 0, only to overwrite it entirely again.

> +		ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
> +		auth_modules[auth_modules_nr++] = mod;

I have not looked at the whole context here, but instead of:

	struct auth_module {
		char *scheme;
		char *challenge_params;
		struct string_list *tokens;
	};

Why not:

	struct auth_module {
		char *challenge_params;
		struct string_list *tokens;
	};

Then you could use a "struct string_list" for this, make the "scheme" be
the "string" member, and stick the remaining two fields in the "util",
and thus save yourself the manual memory management etc.

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
> +	 * The first Authorization header that matches a known auth module
> +	 * scheme will be consulted to either approve or deny the request.
> +	 * If no module is found, or if there is no valid token, then 401 error.
> +	 * Otherwise, only permit the request if anonymous auth is enabled.
> +	 * It's atypical for user agents/clients to send multiple Authorization
> +	 * headers, but not explicitly forbidden or defined.
> +	 */
> +	for_each_string_list_item(hdr, &req->header_list) {
> +		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
> +			split = strbuf_split_str(v, ' ', 2);
> +			if (!split[0] || !split[1]) continue;
> +
> +			/* trim trailing space ' ' */
> +			strbuf_setlen(split[0], split[0]->len - 1);
> +
> +			mod = get_auth_module(split[0]->buf, 0);
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

Sometimes we need a strbuf_split_str, but in this case couldn't you use
the in-place "struct string_list" variant of that instead, and just
carry a "size_t len" here for it, which you'd then pass to
get_auth_module() (which this commit adds)?

Also, you "split" in the loop, but...

> +	strbuf_list_free(split);
...only free() the last one here, isn't this leaking?

> +static int split_auth_param(const char *str, char **scheme, char **val)
> +{
> +	struct strbuf **p = strbuf_split_str(str, ':', 2);
> +
> +	if (!p[0])
> +		return -1;
> +
> +	/* trim trailing ':' */
> +	if (p[0]->len > 0 && p[0]->buf[p[0]->len - 1] == ':')

Don't compare unsigned length fields to "> 0", just do "if (len &&
....)".

Also, maybe I'm just groggy today, but how do we have a trailing ":" if
we just split on ":", and with a limit such that...

> +	if (p[1])
> +		*val = strbuf_detach(p[1], NULL);

...we have an item after that?


> +static int read_auth_config(const char *name, const char *val, void *data)
> +{
> +	int ret = 0;
> +	char *scheme = NULL;

Don't init this to NULL, instead the split_auth_param() return value
should be trusted, the compiler will then help us catch errors, no?

> +	char *token = NULL;
> +	char *challenge = NULL;

In this case it *is* needed though, as the function will return
non-errors, but *maybe* give us the second out parameter.

For such a function though, isn't just assigning "*second_param = NULL"
at the start of it less of a "running with scissors" pattern?

> +	struct auth_module *mod = NULL;

This NULL assignment can be dropped, we assign to it below
unconditionally before using it.

> +
> +	if (!strcmp(name, "auth.challenge")) {
> +		if (split_auth_param(val, &scheme, &challenge)) {
> +			ret = error("invalid auth challenge '%s'", val);
> +			goto cleanup;
> +		}
> +
> +		mod = get_auth_module(scheme, 1);
> +
> +		/* Replace any existing challenge parameters */
> +		free(mod->challenge_params);
> +		mod->challenge_params = challenge ? xstrdup(challenge) : NULL;
> +	} else if (!strcmp(name, "auth.token")) {
> +		if (split_auth_param(val, &scheme, &token)) {
> +			ret = error("invalid auth token '%s'", val);
> +			goto cleanup;
> +		}
> +
> +		mod = get_auth_module(scheme, 1);
> +
> +		/*
> +		 * Append to set of valid tokens unless an empty token value
> +		 * is provided, then clear the existing list.
> +		 */
> +		if (token)
> +			string_list_append(mod->tokens, token);
> +		else
> +			string_list_clear(mod->tokens, 1);
> +	} else if (!strcmp(name, "auth.allowanonymous")) {
> +		allow_anonymous = git_config_bool(name, val);
> +	} else {
> +		warning("unknown auth config '%s'", name);
> +	}
> +
> +cleanup:
> +	free(scheme);
> +	free(token);
> +	free(challenge);
> +
> +	return ret;
> +}
> +
