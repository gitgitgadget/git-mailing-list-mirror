Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80E9C4741F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C13C207E8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNjvI+1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgI1SgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 14:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1SgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 14:36:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CADC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 11:36:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so1819680pfo.12
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PHpp1OuLHrQphM5ACLtzuOqXSmrpoKFl/b+CJhLst8Q=;
        b=rNjvI+1fJKRPMEDxK06V9YdRtlXo8M2JuyLkv+bgBSjs4+WN9Kw1xwA8iFQDBZMi42
         qIvr9XmALBYz/Au8N+u9qmieCNbtGwRVIQkhZa5nAiuH6j2E6PxHHF35An85axZ+0zkI
         Ws/rZ9a7f4FSKqOfnJbxkdnTOofzB9q+16j6XnSJ+k/OxXZBTafYkBsQqappgJnIzEQj
         LI7RAdgrgClf1vvR8Lh/0upP++3RfM1ong7WlCl9HrnvU6WRBdqsax8bRlKq4Gt0hzIZ
         0jSiK1zrqF1GYN928oZO3mqenYypq41W1LNyTIqxRbIvt7q20k67FZwv4htBuy51i5pn
         qVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PHpp1OuLHrQphM5ACLtzuOqXSmrpoKFl/b+CJhLst8Q=;
        b=F6/wDv5UIyk9qnWpEl8No3uI9WZ5PzbhOq9zyD3lc2WKGoy9DIgsQy69zyEw6p3bML
         jjFv/5iRCeDtp1wnCmcOrTsW8KGEOb8nzYf3XWtjeAJCGhZS46Gh0A+gumcCQHMnLBVj
         Zt/nYOCNLNCflwLHubEYgM0DhLFGBD4M14khfckspFAhoj6WtwG8eK7bYcKkri/GY94V
         t+PIiHoLVB1mNKOuwWkQWwMqywX0OxACa1a4XvU4T8/gDph0V4RjUhyrk6WsZNn7ep8L
         VpkiUf6NLb6A8XhN3GH7kpXxnzWMuQ8x7GYwaAc5C1PASdI6CaYpjSn+YaFXHq/UilHs
         TSxw==
X-Gm-Message-State: AOAM53194SmUE4qZQVAPMZ7b4xuaU6+uSR91kG99vxg2LUQuboNAoo80
        fUwSMbNXhNR98zdQ3Prc5xP0k3hwmjU=
X-Google-Smtp-Source: ABdhPJxdnq//t68rvXJnwKLykeenkdAdTdyiS9A1UZCHMs1WqkDj0WhbDHY2Wbeeh9nH3EQJbB0W2A==
X-Received: by 2002:a17:902:a512:b029:d2:22a3:31ce with SMTP id s18-20020a170902a512b02900d222a331cemr677577plq.77.1601318161865;
        Mon, 28 Sep 2020 11:36:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id f19sm2100601pfj.25.2020.09.28.11.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:36:01 -0700 (PDT)
Date:   Mon, 28 Sep 2020 11:35:59 -0700
From:   jrnieder@gmail.com
To:     Evan Gates <evan.gates@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Doc: note minimum scissors line length for mailinfo
Message-ID: <20200928183559.GA2285677@google.com>
References: <20200925191659.31375-1-evan.gates@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925191659.31375-1-evan.gates@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Evan Gates wrote:

> There is a comment in is_scissors_line describing the requirements for
> a line to be considered a scissors line.  While the existing wording
> covers most of the requirements, there was no mention of minimum size.
>
> Signed-off-by: Evan Gates <evan.gates@gmail.com>
> ---
> This comes up after I tried to use --8<-- as scissors but git am didn't
> recognize it because it's only 6 bytes.  I couldn't figure out why until
> I cloned git and checked the source.

Thanks for following through.  It's probably worth mentioning this
example ("--8<--") in the commit message as well.

[...]
> --- a/Documentation/git-mailinfo.txt
> +++ b/Documentation/git-mailinfo.txt
> @@ -74,11 +74,11 @@ conversion, even with this flag.
>  --scissors::
>  	Remove everything in body before a scissors line.  A line that
>  	mainly consists of scissors (either ">8" or "8<") and perforation
> -	(dash "-") marks is called a scissors line, and is used to request
> -	the reader to cut the message at that line.  If such a line
> -	appears in the body of the message before the patch, everything
> -	before it (including the scissors line itself) is ignored when
> -	this option is used.
> +	(dash "-") marks and is at least 8 bytes long ("-- >8 --") is

nit: I think "characters" instead of "bytes" would focus a bit more on
the intent.  It's true that characters and bytes coincide in this
example, but using characters might be a bit more in the terms that
the user is already thinking in.

By the way, is this the right criterion?  Perhaps an alternative
method would be to make "--8<--" count as a scissors like after all.
What do you think?

> +	called a scissors line, and is used to request the reader to cut
> +	the message at that line.  If such a line appears in the body
> +	of the message before the patch, everything before it (including
> +	the scissors line itself) is ignored when this option is used.
>  +
>  This is useful if you want to begin your message in a discussion thread
>  with comments and suggestions on the message you are responding to, and to

With the commit message and wording tweaks listed above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
