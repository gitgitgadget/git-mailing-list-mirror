Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94757201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 23:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdF3XTo (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 19:19:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35053 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbdF3XTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 19:19:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so16681596pgc.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 16:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iVReAIDjqaZkXEOuh8/5ZPW4wqnj1n7jY0o+pze9jZg=;
        b=ogZzDAQ7/ipauTZs9xQy/+52zAt6tBYZOlr+V746bZM+pHW9+N+9wctZ9sBgkb2sAu
         lImx6Cqz8NgU7aNQ7JfQyZk1R+Vw+liAkRzC/OHgL/FMD7hgOvg3GzpPI7+ktDhMb0Sc
         /v1cYeIMcoHTjEOBTwoEzrMqwL9MP1liHCvr32ug2zkDws0ShA8Puc0I2sRJs3L5UyEG
         i7Y0Uzp9M3hBw/KE9m8Bvc3RFvMjYU9mhAtL0OTc8y4M+XhcaXYVHK1OkoSYxlK69G0a
         MGT3keF3PQHFwKvXDwk0djweyfPa8KvYnHEJOV3CqSEjJqeURyzFJSTqWwhnNPsFSXFx
         R2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iVReAIDjqaZkXEOuh8/5ZPW4wqnj1n7jY0o+pze9jZg=;
        b=HN+x6SpRH/sZrX2CR3zjt5b3rMejEGNKsIMsQjijLR1kOh65nMlJQIBxcDJBksmUDF
         GiMPdiWo5+9UXa2HeeyEsIWObStUJfEfagMHJTLN6BlJEItXQGlUJiT09duF754QQPB5
         BnCGVPD/zL4gFOmzq74KivvNMLziDdNLOGpEZxbCWP+xnJbrBTSeHW1LtVJOgdz0E1ne
         RfQ5Tmm2aXjxLMbPI0yf7QVV/0PHR1PsZIdoA2By1hVpL+bBzmOYrX8EdFItsnncRHcg
         6KXeFQ9+9SZ3bZSXPoQMGtd+RURAmZA2ou2h94ha3V28PnOt/zdB9SPDwIJHo3fU7++u
         b8rQ==
X-Gm-Message-State: AKS2vOxZbHSYqgO8rdbP7MXP75eAgC5kIe0iF/gZHFohmij77VOE5OZ1
        E8MSeE8OVSn4PQ==
X-Received: by 10.84.216.26 with SMTP id m26mr27493745pli.112.1498864782290;
        Fri, 30 Jun 2017 16:19:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id 188sm15288192pgc.49.2017.06.30.16.19.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 16:19:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 5/5 v3] submodule: port submodule subcommand 'sync' from shell to C
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
        <20170630194727.29787-1-pc44800@gmail.com>
        <20170630194727.29787-5-pc44800@gmail.com>
Date:   Fri, 30 Jun 2017 16:19:40 -0700
In-Reply-To: <20170630194727.29787-5-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sat, 1 Jul 2017 01:17:27 +0530")
Message-ID: <xmqq1sq1oygj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> +static void sync_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +	struct sync_cb *info = cb_data;
> +	const struct submodule *sub;
> +	char *sub_key, *remote_key;
> +	char *sub_origin_url, *super_config_url, *displaypath;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	if (!is_submodule_initialized(list_item->name))
> +		return;
> +
> +	sub = submodule_from_path(null_sha1, list_item->name);
> +
> +	if (!sub || !sub->url)
> +		die(_("no url found for submodule path '%s' in .gitmodules"),
> +		      list_item->name);
> +
> +	if (starts_with_dot_dot_slash(sub->url) || starts_with_dot_slash(sub->url)) {
> +		char *remote_url, *up_path;
> +		char *remote = get_default_remote();
> +		char *remote_key = xstrfmt("remote.%s.url", remote);
> +		free(remote);
> +

Have a blank line between the decls and the first statement
(i.e. before "free(remote)").  The blank line after "free(remote)"
may or may not be there.

> +		if (git_config_get_string(remote_key, &remote_url))
> +			remote_url = xgetcwd();
> +...
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +	cp.git_cmd = 1;
> +	cp.dir = list_item->name;
> +	argv_array_pushl(&cp.args, "submodule--helper",
> +			 "print-default-remote", NULL);
> +	if (capture_command(&cp, &sb, 0))
> +		die(_("failed to get the default remote for submodule '%s'"),
> +		      list_item->name);

OK.  Perhaps in a distant future when the repository object
abstraction is ready, we can do this within the main process, but
for now, due to the presence of cp.dir, this is the best we can do.

> +	strbuf_strip_suffix(&sb, "\n");
> +	remote_key = xstrfmt("remote.%s.url", sb.buf);
> +	strbuf_release(&sb);
> +
> +	child_process_init(&cp);
> +	prepare_submodule_repo_env(&cp.env_array);
> +	cp.git_cmd = 1;
> +	cp.dir = list_item->name;
> +	argv_array_pushl(&cp.args, "config", remote_key, sub_origin_url, NULL);
> +	if (run_command(&cp))
> +		die(_("failed to update remote for submodule '%s'"),
> +		      list_item->name);

Likewise.

Looks like a fairly faithful conversion to me.

Thanks.
