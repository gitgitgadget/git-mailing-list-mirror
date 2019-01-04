Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710221F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 02:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfADCTA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 21:19:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38175 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfADCTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 21:19:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so16803623pgc.5
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 18:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WF4ZrMPqhDdIN09a4BmwZE7DXDWfqniqXPeuCwSHDHM=;
        b=EikPkZ3RqeYeiOHf4wJXCDtCzDyE7q2/taEt35qU0DMWa64bNaWwigNI4m+cHuAs6t
         5zDvO2INi/ScnGsFaV2rfhBLjRPN7575die+oxRFwawm66DfPxHBjBH21sw4tlt/4nE/
         kJENP5G54bZZ0vZjJgMU3/LtONbCr6qceP7MkoG2V6GGbtoBHjECTAhSprlmZZ0CHp1V
         IoxfWdCWW3FdWs4OOAa5fSHz9p/UIhUrG4fLOP8yEYYpMwVim0MDLrh+/k90mGqfAckB
         9pgLxSWakzq35bg56lq7IdDcCeJ09rC0BOOnm1OQrnCCnhZUMYIWfab1bLoli5WwdzNy
         yB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WF4ZrMPqhDdIN09a4BmwZE7DXDWfqniqXPeuCwSHDHM=;
        b=IIfpCGy06H81iYC6hOuD+qdEkI8QSCR5Y1kW7psnJncDtddDADQ37hRQ2VtPnXLnmy
         sRytbSxRMQuJI1sXSu7bWB2osONNVv5t1+H2cRdlnH36qOGQ2sxXod0oZLctsK9UTb0i
         NO9T/ZVPLZFyWsVJVhPRe7L+KMjvcSnJ6GQEBq2OtA2mDmkwnEJQM3TRoUZklmTA4J0H
         WALyGS9RXz8L/b+Ojmj+5iLl5NFyydPIU6sdO5V9osIiw0PD2LJeu/9YhoO3xouw4P2Y
         AX75L0a51QV05K2AcfphXEeXjubFvpEEMngoNMu/e6pfhUwvfZgl5pJhhfi26HX7Z4th
         a4+Q==
X-Gm-Message-State: AJcUuke13tf8IQKvsVtqSxgKq2Clciwdf4YVGgg2nhrmWXMVG7+zTsrq
        pSeAeo1a3Hxq+BPpNivcrPU=
X-Google-Smtp-Source: ALg8bN5t4Vtvk8CP5wJAWDzZa6q3dSaQXCjoHc+BSFl9N6//+MIiWEF+AUIesLS+0JNP9Q1NCUKZpA==
X-Received: by 2002:a63:4745:: with SMTP id w5mr96044pgk.377.1546568338592;
        Thu, 03 Jan 2019 18:18:58 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t13sm104935843pgr.42.2019.01.03.18.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 18:18:57 -0800 (PST)
Date:   Thu, 3 Jan 2019 18:18:55 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20190104021855.GB97188@google.com>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220002610.43832-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> In some shells, such as bash and zsh, it's possible to use a command
> substitution to provide the output of a command as a file argument to
> another process, like so:
>
>   diff -u <(printf "a\nb\n") <(printf "a\nc\n")
>
> However, this syntax does not produce useful results with git diff
> --no-index.

Thanks much for fixing this.  It's something I've run into, too.

[...]
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -111,6 +111,11 @@ include::diff-options.txt[]
>  	"Unmerged".  Can be used only when comparing the working tree
>  	with the index.
>  
> +--literally::
> +  Read the specified files literally, as `diff` would,
> +  dereferencing any symlinks and reading data from pipes.
> +  This option only works with `--no-index`.

I may be a minority in this opinion, but I had trouble understanding
what --literally would do from its name.  I suspect we can come up
with a better name.

Unfortunately, I'm terrible at coming up with names. :-P

--dereference would be a good name when it comes to symlinks, but
it's not a good name for reading what is on the other side of a pipe.
On the plus side, it matches "diff" and "cp"'s name for the "follow
symbolic links" option.

--plain captures the desire a little better --- we want a plain
read(2) from the file instead of trying to be smart and look at
whether it is e.g. a block device.  But in the context of "diff", that
would seem more like an option that affects the output.

What would you think of

 - always reading from fifos instead of describing them, since I've
   never encountered a use case where people want the latter

 - --dereference to control whether to follow symlinks

?

[...]
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -75,7 +75,25 @@ static int populate_from_stdin(struct diff_filespec *s)
>  	return 0;
>  }
>  
> -static struct diff_filespec *noindex_filespec(const char *name, int mode)
> +static int populate_literally(struct diff_filespec *s)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t size = 0;
> +	int fd = xopen(s->path, O_RDONLY);
> +
> +	if (strbuf_read(&buf, fd, 0) < 0)
> +		return error_errno("error while reading from '%s'", s->path);
> +
> +	s->should_munmap = 0;
> +	s->data = strbuf_detach(&buf, &size);
> +	s->size = size;
> +	s->should_free = 1;
> +	s->read_literally = 1;

Oh!  --read-literally works perfectly for me as a name. :)

Jonathan
