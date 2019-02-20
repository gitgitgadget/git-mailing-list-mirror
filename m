Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26771F453
	for <e@80x24.org>; Wed, 20 Feb 2019 21:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfBTVI7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 16:08:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36909 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfBTVI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 16:08:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so27633551wrs.4
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dRXxPFmiIHjZelKQzzmk+a170yFVxkQ/pTfzJMGy7gg=;
        b=B8u7Q1qSzmadHeSI8NAX3A3ISAWyMnQDwMmiD7i2odrmI8wTyxOsaTwe0Ab/WEMLQb
         WZfIScg7+4o4EJ4tmZekDY6VRkgkusc3R4ALelG9jUYPSvcg71XCTyTodtjAnV20P5d3
         RRVRDOGbG9SuWzA+5yoE9RGTDcfmrNMRih7dzNlynY78hpwqv4rK0FWGSS67xa9Dic2g
         W6trjyueU2UYfGz27TquBgzmCzG/IVQFt3PQXBJ+WXw++77fi8TWdxIPhw+CwF3DCXLc
         qCw5pgB9oarYG9hHjtHKdJlTDmDyQgxCQjj7aJP1jwTS2POn2r7u34JGuWmZNgcp8xXz
         pVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dRXxPFmiIHjZelKQzzmk+a170yFVxkQ/pTfzJMGy7gg=;
        b=uJSZoFEsQOzu/tVS/0PmjHM7aooQDs062vaqmN+NUCMaNI9O4sDSNCiWUUBQMxax7W
         KMksluu7EBvRjZig+CZJUuXqTEYtwMFkeX1nFsoVATaBPzViipmvu2gIJgETtswi5vcK
         rQ8SX2w7rhTKkyctk8ZfDDq5gbPm2CX8g7wGfPWwXXlpcK2Eq4JesKwVKgHn0KJSuoE0
         5fMyciZFn5Ulz566dk23TxUFWW54oG/TUChKQd1DmhgvY9+WmLixE5P58h9lN1UQJgEz
         h+YwSp+O0v9xKMZ0DczJ8mAG9bqEceNwv6FmyvIQoKakEsE2gtdAS3iTJYf4tH2E94iP
         csfw==
X-Gm-Message-State: AHQUAuYapeydrVVDOoSR56oJ0RDNseBj1VXtb+RprjfvBCN11lF0OLEp
        2MGJq8gAI5dtTQg7Ss0is68H4gAF
X-Google-Smtp-Source: AHgI3IZ7Zb+jET9/oGle6TKi/iiZ8IEk61IuJkG+M+tj7/BmKgkuGPofvX/706/AjCfgTTGRi+StbQ==
X-Received: by 2002:adf:9123:: with SMTP id j32mr27422564wrj.122.1550696937153;
        Wed, 20 Feb 2019 13:08:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a184sm7459710wmh.37.2019.02.20.13.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 13:08:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 10/21] diff-parseopt: convert --stat*
References: <20190207103326.10693-1-pclouds@gmail.com>
        <20190216113655.25728-1-pclouds@gmail.com>
        <20190216113655.25728-11-pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 13:08:56 -0800
In-Reply-To: <20190216113655.25728-11-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 16 Feb 2019 18:36:44 +0700")
Message-ID: <xmqq1s42w4k7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> -static int stat_opt(struct diff_options *options, const char **av)
> +static int diff_opt_stat(const struct option *opt, const char *value, int unset)
>  {
> -	const char *arg = av[0];
> -	char *end;
> +	struct diff_options *options = opt->value;
> ...
> -	switch (*arg) {
> -	case '-':
> -		if (skip_prefix(arg, "-width", &arg)) {
> -			if (*arg == '=')
> -				width = strtoul(arg + 1, &end, 10);
> -			else if (!*arg && !av[1])
> -				die_want_option("--stat-width");
> -			else if (!*arg) {
> -				width = strtoul(av[1], &end, 10);
> -				argcount = 2;
> -			}
> ...
> +	if (!strcmp(opt->long_name, "stat")) {
> +		if (value) {
> +			width = strtoul(value, &end, 10);
> +			if (*end == ',')
> +				name_width = strtoul(end+1, &end, 10);
> +			if (*end == ',')
> +				count = strtoul(end+1, &end, 10);
> +			if (*end)
> +				return error(_("invalid --stat value: %s"), value);
>  		}

It took me a while to recall and figure out what the original is
doing, primarily because the code was designed to handle both
"-$option $arg" and "--$option=$arg".  But thanks to the switch to
parse-options API, this helper no longer has to worry about that,
which is a very big plus.  It only needs to parse what is in value.

Very nice.
