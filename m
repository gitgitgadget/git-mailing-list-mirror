Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA29B20450
	for <e@80x24.org>; Fri,  3 Nov 2017 20:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbdKCUis (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 16:38:48 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:49715 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbdKCUir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 16:38:47 -0400
Received: by mail-io0-f169.google.com with SMTP id n137so8928142iod.6
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wz0HoLeVKg8YmcedA1XXhBry7vqgBY/hdkC/QpmaKtQ=;
        b=K5CHus8FJJWeShoM7Pp7/R5eZ9sSkvrgT7fnSMk8WvslAebKtpeSr38JnFMS97uIgx
         0mP7ajQ3y1iTd0PqxQoLMZm2pJyMQTM6Ba//SpBdUSZC3JxX59QLTPE3nC/JFMm5ALVl
         le5Qf3yPqbI0sKn+Gwv7jCBmhPdp8Ti0+KzEOU6koh7AS72Oah+N+djuGsaaV76jQbVB
         YtKrh7kHTvjNp8CX3XJw8RJYTCmDXS70OsQAu0SkvsygeIEHqtwUAWvFlcsYX5dHAgld
         XVq27JK7yCWzxyNOKimLSHd8r0LN6hq2PYtvTNwsSYqQVEUw+KXkRBglrqpWADI12Bav
         ArcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wz0HoLeVKg8YmcedA1XXhBry7vqgBY/hdkC/QpmaKtQ=;
        b=dNm/Ui24Qs9zQiSlfotgzUTHjADfwt/r4bd1s6EZwu1vlviffNiOFT1NYdAm3nzOt/
         pf2zFCiozLSesUFu6WcozZq0D1y5rPj1lR6mKZNGvn4vpuVYMoBppHG9NHJeQji1qZqj
         9yfUyOpY1pdX3HIIGVyUAF9JI4iXkfMj4eRXVfFuZXo9Ebez2yXOah8ZqkT/wYZbdO0G
         D8jfx/dBD5oHoBaxJ4VbUEQkGLvrlwTwCbD9aVm8XsoYIHz7ZbIrQYUbbrlUNn7bZdLE
         ORUXwKEAWVSKmWOtCTbdHGmIgdRHl9mwCSo6iEfzug7gWw6Ft3iouJvqdTznkfcwxzYB
         T2vg==
X-Gm-Message-State: AMCzsaU/qLV40YLqynFxjfMbQJR35UaP3tJHQh1DVONlPf1ZFMth2Myf
        +gXEa6vlX6JH9AE8EDCKg7wD9w==
X-Google-Smtp-Source: ABhQp+SRnPp9d2OrAJQaKHj8l5Rqtip6h/dzcVbveEHLChURCEGimfzIgALAwkD7OYtUjbSkHmhmqg==
X-Received: by 10.107.163.15 with SMTP id m15mr10880014ioe.61.1509741526476;
        Fri, 03 Nov 2017 13:38:46 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:5949:10b2:8e2d:2f6])
        by smtp.gmail.com with ESMTPSA id i63sm3134698ioi.68.2017.11.03.13.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 13:38:45 -0700 (PDT)
Date:   Fri, 3 Nov 2017 13:38:45 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 04/14] fetch: add object filtering for partial fetch
Message-Id: <20171103133845.b270485dd04c6c6c1b47d42a@google.com>
In-Reply-To: <20171102203129.59417-5-git@jeffhostetler.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
        <20171102203129.59417-5-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did some of my own investigation and have a working (i.e. passing
tests) version of this patch here:

https://github.com/jonathantanmy/git/commits/pc20171103

If you want, you can use that, or incorporate the changes therein here.
I'll also remark on my findings inline.

On Thu,  2 Nov 2017 20:31:19 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> @@ -754,6 +757,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
>  	int want_status;
>  	int summary_width = transport_summary_width(ref_map);
> +	struct check_connected_options opt = CHECK_CONNECTED_INIT;
>  
>  	fp = fopen(filename, "a");
>  	if (!fp)
> @@ -765,7 +769,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		url = xstrdup("foreign");
>  
>  	rm = ref_map;
> -	if (check_connected(iterate_ref_map, &rm, NULL)) {
> +	if (check_connected(iterate_ref_map, &rm, &opt)) {

opt here is unchanged from CHECK_CONNECTED_INIT, so this change is unnecessary.

>  		rc = error(_("%s did not send all necessary objects\n"), url);
>  		goto abort;
>  	}
> @@ -1044,6 +1048,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
>  		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
>  	if (update_shallow)
>  		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
> +	if (filter_options.choice)
> +		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
> +			   filter_options.raw_value);

You'll also need to set TRANS_OPT_FROM_PROMISOR.

> @@ -1242,6 +1249,20 @@ static int fetch_multiple(struct string_list *list)
>  	int i, result = 0;
>  	struct argv_array argv = ARGV_ARRAY_INIT;
>  
> +	if (filter_options.choice) {
> +		/*
> +		 * We currently only support partial-fetches to the remote
> +		 * used for the partial-clone because we only support 1
> +		 * promisor remote, so we DO NOT allow explicit command
> +		 * line filter arguments.
> +		 *
> +		 * Note that the loop below will spawn background fetches
> +		 * for each remote and one of them MAY INHERIT the proper
> +		 * partial-fetch settings, so everything is consistent.
> +		 */
> +		die(_("partial-fetch is not supported on multiple remotes"));
> +	}
> +
>  	if (!append && !dry_run) {
>  		int errcode = truncate_fetch_head();
>  		if (errcode)

My intention in doing the "fetch: refactor calculation of remote list"
patch is so that the interaction between the provided list of remotes
and the specification of the filter can be handled using the following
diff:

    -	if (remote)
    +	if (remote) {
    +		if (filter_options.choice &&
    +		    strcmp(remote->name, repository_format_partial_clone_remote))
    +			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
     		result = fetch_one(remote, argc, argv);
    -	else
    +	} else {
    +		if (filter_options.choice)
    +			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
     		result = fetch_multiple(&list);
    +	}

(Ignore the "blob-max-bytes" in the error message - that needs to be
updated.)

The GitHub link I provided above has this diff, and it seems to work.
