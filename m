Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138251F453
	for <e@80x24.org>; Tue, 12 Feb 2019 10:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfBLK55 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 05:57:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38870 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBLK54 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 05:57:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so2506652wmh.3
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 02:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oRUI5kZDzBjDMYOa3ZYlxKvyjRrF5fmcmyPis0GKO+o=;
        b=q4sonQ2Asbf4LJS6cw+CZ97aY1XacFgKFwHvLc8yoxTk0XflNbKMsn7U1+ssqcy81I
         PA3gWgyfir4AyYQxO9bOv5Mp+7vafPmArqA69nrJNPbbv+bqC8CXWR3GMa2boqdp1VPQ
         kJBlfXk78E0aikRi2ywSDlJiDOuKex3w5ZG1ZCFJzv5ZuAhEAQOOKD6wWhgWV4VGXJFf
         aNIU6dG1I5xPPYObOc1MQNERAv6FbRMnNmMrt+bXTURk4p2w0bfWEaHhr4pZGXN8Giv8
         aK9zB5Kz4FdQECLHcnkVx7McSgw7Z7sVl0j/3yAtV8/S5sEKaPYWNzEhnzfyWXTKgqUm
         AD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oRUI5kZDzBjDMYOa3ZYlxKvyjRrF5fmcmyPis0GKO+o=;
        b=L3YqN9p93hqGyGyWjNWMPvcZCvCvDArfx0t2zY5Q30YAT+5/I+O2/nuFTl9Ic5M1jq
         9Jitwn6WuHixPjWjfG90JBdjqugy/d6VCnwvKE1PWlAQS/CfUwoKoZuUs+cThp99hVuZ
         SjMn2kQuuGtbHXrEzREIz4E3UcC5/Zo6TvbqJmH1+vGpLWFP9e7tWinMkuvuym81/XDT
         skL1YzfKVOoA/j/G0WJXnIH4chgKTn7bqufPehecwrfaxtvgyJBSkxjRH5gPtQDZb19p
         5FFmwVMOQWKCn9+410SBZXOsA9CpUtK937jCVjpSuyT4SgyZ+DhFOUNH/qBRB2XxRyeG
         2a8w==
X-Gm-Message-State: AHQUAuZAvYASWUB8I7/dM49MXRh+fV/M8kcUq1Fob8phh+1TlCI84w1d
        PW1M1cL11n7xQuNl6AKm4gU=
X-Google-Smtp-Source: AHgI3IapO4nrUgN2/9tngaa97IykdM1JCKU22I6bKRvyQjLqgRI4spHzr8bvHIw7SlQRFgOiU44Xhw==
X-Received: by 2002:a1c:44c3:: with SMTP id r186mr707079wma.63.1549969073733;
        Tue, 12 Feb 2019 02:57:53 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id e17sm8149620wrs.79.2019.02.12.02.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 02:57:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 31/31] gitweb: make hash size independent
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-32-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190212012256.1005924-32-sandals@crustytoothpaste.net>
Date:   Tue, 12 Feb 2019 11:57:52 +0100
Message-ID: <871s4dl1e7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, brian m. carlson wrote:

> Gitweb has several hard-coded 40 values throughout it to check for
> values that are passed in or acquired from Git.  To simplify the code,
> introduce a regex variable that matches either exactly 40 or exactly 64
> hex characters, and use this variable anywhere we would have previously
> hard-coded a 40 in a regex.
>
> Similarly, switch the code that looks for deleted diffinfo information
> to look for either 40 or 64 zeros, and update one piece of code to use
> this function.  Finally, when formatting a log line, allow an
> abbreviated describe output to contain up to 64 characters.

This might be going a bit overboard but I tried this with a variant
where...

> +# A regex matching a valid object ID.
> +our $oid_regex = qr/(?:[0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})?)/;
> +

Instead of this dense regex I did:

    my $sha1_len = 40;
    my $sha256_extra_len = 24;
    my $sha256_len = $sha1_len + $sha256_extra_len;

    sub oid_nlen_regex {
    	my $len = shift;
    	my $hchr = qr/[0-9a-fA-F]/;
    	return qr/(?:(?:$hchr){$len})/
    }

    our $oid_regex;
    {
        my $x = oid_nlen_regex($sha1_len);
        my $y = oid_nlen_regex($sha256_extra_len);
        $oid_regex = qr/(?:$x(?:$y)?)/
    }

Then most of the rest of this is the same, e.g.:
> -	if ($input =~ m/^[0-9a-fA-F]{40}$/) {

But...

> @@ -2037,10 +2040,10 @@ sub format_log_line_html {
>              (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
>              [A-Za-z0-9.-]+
>              (?!\.) # refs can't end with ".", see check_refname_format()
> -            -g[0-9a-fA-F]{7,40}
> +            -g[0-9a-fA-F]{7,64}
>              |
>              # Just a normal looking Git SHA1
> -            [0-9a-fA-F]{7,40}
> +            [0-9a-fA-F]{7,64}
>          )
>          \b
>      }{

E.g. here we can do call oid_nlen_regex("7,64") to produce this blurb.

> -	if ($line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
> +	if ($line =~ m/^index $oid_regex,$oid_regex/) {
> -	} elsif ($line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
> +	} elsif ($line =~ m/^index $oid_regex..$oid_regex/) {

And here, maybe nobody cares, but we now implicitly accept mixed SHA-1 &
SHA-256 input. Whereas we could have a helper on top of the above code
like:

    sub oid_nlen_prefix_infix_regex {
        my $nlen = shift;
        my $prefix = shift;
        my $infix = shift;

        my $rx = oid_nlen_regex($nlen);

        return qr/^\Q$prefix\E$rx\Q$infix\E$rx$/;
    }

And then e.g.:

    } elsif ($line =~ oid_nlen_prefix_infix_regex($sha1_len, "index ", "..") ||
             $line =~ oid_nlen_prefix_infix_regex($sha256_len, "index ", "..")) {

So only accept SHA1..SHA1 or SHA256..SHA256, not SHA1..SHA256 or
SHA256..SHA1.
