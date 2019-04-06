Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9F920248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDFL5c (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:57:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38092 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfDFL5c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:57:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so4784020pfo.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pcioPfWVwXW1mzHfgeQ3cSewchml18MdlmbVchOndfw=;
        b=Bad7ioUXWYOkupojaeemNjzLDBpuGym8//egpYxog1ZFaxMrL/GWNvHJ/DWn532ZIi
         O67PwHoP8c2f6ydKsLXqEBI6f/bXABWx37p5HC34iteEMpKv2NQGP396orQKUh4pAtDu
         YVcPHBJYHKxDsqyMcqV76dX9EZ8bR7pcyNxGeOH9IiFfhcp6gZjKW/KE02kUiDXWRLAa
         BQ9idAbLopCD7DsBCz1TYrIxx/Yyh6rNT1UyfO8UVDrwcSu6HkHVlS3qmbF9Xf9CUdkk
         nPVwf4OoIAnYVVUseHZk93Ud1xF8w9XKKx5jvpH/SdhU9gFcxV+udMDdr6fIHyUre1nE
         cihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pcioPfWVwXW1mzHfgeQ3cSewchml18MdlmbVchOndfw=;
        b=hb03cybW2dpddNlRwcF6q/gLEESc1LG8Ei757WKL6Rgeqytq08hQDeLSXlSK2+WAHv
         or/zSL41tfrsA6k34Vpj1TatyVEEvAhupfFO3XdXU/nksr+QugL83rQQG76orRN3pg8q
         NFbQAk3fxURkMbro1iEdXNIoOXenWRN3FREno7RDf+SUqX/3MHJM05zLHXoHiX0j5DSh
         CqN+PmdiM6+abfgF/d05c3xCHmWTJJ3/pmeex0vLI8ln8QlteesbLBsw965mN6NdmiVN
         O1KZru6y+VTvXfKljyM952Ck6TXY5MdmO6EZACwg53hXuyUcb25IicBXku2zWdaXk3qr
         /Fgg==
X-Gm-Message-State: APjAAAVWFDFcn4xHcAhNIvi2y6myudXOvI93e8hToCqWLyCchpFooPW8
        tM4DtDSRjWl4ADQfkP+ZAWk99Dm9
X-Google-Smtp-Source: APXvYqze/jFgtyoCHaxpxSSnXtg3jqVSehN0KNtgaj7fYq/tsCeL/AR3PkN5hu8dmCtQ3FECGCRWtA==
X-Received: by 2002:a63:3f46:: with SMTP id m67mr5102157pga.178.1554551851325;
        Sat, 06 Apr 2019 04:57:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t5sm8577645pfl.106.2019.04.06.04.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 04:57:30 -0700 (PDT)
Date:   Sat, 6 Apr 2019 04:57:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: send server options when using protocol v2
Message-ID: <20190406115728.GB219876@google.com>
References: <20190405204413.93900-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405204413.93900-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Commit 5e3548ef16 ("fetch: send server options when using protocol v2",
> 2018-04-24) taught "fetch" the ability to send server options when using
> protocol v2, but not "clone". This ability is triggered by "-o" or
> "--server-option".
>
> Teach "clone" the same ability, except that because "clone" already
> has "-o" for another parameter, teach "clone" only to receive
> "--server-option".

Can you give an example of what this would be used for?  An example I
can think of might be

	git clone --server-option=priority=batch <url>

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/git-clone.txt |  7 +++++++
>  builtin/clone.c             |  6 ++++++
>  t/t5702-protocol-v2.sh      | 11 +++++++++++
>  3 files changed, 24 insertions(+)

Thanks.

[...]
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -66,6 +66,7 @@ static int option_dissociate;
>  static int max_jobs = -1;
>  static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
>  static struct list_objects_filter_options filter_options;
> +static struct string_list server_options = STRING_LIST_INIT_DUP;

The other string-list options in this file all use NODUP.  Is there a
reason this one uses DUP instead?  (Just curious --- I suspect either
would work fine, since nothing here does tricks with modifying argv
entries after option parsing.)

The same question applies to the corresponding option in
builtin/fetch.c, so while it is not likely to matter in practice, it
would be nice for readability to find out.

>  
>  static int recurse_submodules_cb(const struct option *opt,
>  				 const char *arg, int unset)
> @@ -137,6 +138,8 @@ static struct option builtin_clone_options[] = {
>  		   N_("separate git dir from working tree")),
>  	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
>  			N_("set config inside the new repository")),
> +	OPT_STRING_LIST(0, "server-option", &server_options, N_("server-specific"),

nit: long line

> +			N_("option to transmit")),
[...]
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -251,6 +251,17 @@ test_expect_success 'server-options are sent when fetching' '
>  	grep "server-option=world" log
>  '
>  
> +test_expect_success 'server-options are sent when cloning' '
> +	test_when_finished "rm -rf log myclone" &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
> +		clone --server-option=hello --server-option=world \
> +		"file://$(pwd)/file_parent" myclone &&
> +
> +	grep "server-option=hello" log &&
> +	grep "server-option=world" log
> +'

Nice.  Thanks for including this.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for a pleasant read.
