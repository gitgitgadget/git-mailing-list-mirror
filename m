Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC56A202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935579AbdIYWOa (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:14:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36979 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935505AbdIYWO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:14:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id e69so4157373pfg.4
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qHMfmYWH0rjZ1g+F4Qbym1HeTJSFtsqtDDbIpaAYg2k=;
        b=djqPn/y8nuM2+WGPmg9jmSKYBE+QvLl0kgNlg/umq/Aw9asfH8HqKSP8lrnpqxyxnr
         t6SAXhJiCr+6vSnBaZ/sZtvg4Z/9YTacqCfwAglWiUL4kPT72YkASqLr4iIp1bTSOx6r
         qYI6sRwaVnFLFCJ4p4AAGHnGbl8pw1OvAMC5z0mpBzI+E3gviKvmBhuLfwpcFhekwRop
         4/E3X0kK/oXzmulXB2GJIwnNyKO0Swq07qCch3A7qSP7NDvOY+RNu6IFEA/azJesWROa
         T7siDDPA7a73grwszaS46+5TnpC6ajWbiA1Ia98QG0IbyQMAYp6AxFc3G5D2XK91ObAA
         n6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHMfmYWH0rjZ1g+F4Qbym1HeTJSFtsqtDDbIpaAYg2k=;
        b=SGM2Tl2yuLuqO4Hs/EwnXI0yiAlb2TUkFVCLJIl6pVSc5YJ2XkhaIbOgud8RC5UnNS
         S50DGX1GTmRFWoQ/3flTUe3v5pkobZhEc8+AaQ7dyftTUe7EQ/r49hiH8IJIaz34wSRQ
         TXOtw3DkVPFa/cHHFbyF24hE8SdwsBKP1WO6fqaHhjWrS89RtN0jg/LNcr+yoCe5riQ/
         duVDgt9uRJ481Rx4elZK1PWuhQtqfga/Yp84UvsniToPLVpMD0t6d/1vYAtRL1LjLK78
         VCeHdcBxHtesz1L00mFWurqd1Ncd5UKMe/CB3As9mNVKNjQ4xeLYpVtIlhF8pdFu/1mi
         WlXQ==
X-Gm-Message-State: AHPjjUimolZk08d/6zB6A7E1Q47izWDmMCqrSsKbetQqpDDxoi5WFB/6
        3BRquyYbZ6R3tWZ2dkMsoas=
X-Google-Smtp-Source: AOwi7QDMoPOkFMlAS34ASI5/WCtM1Ny6rG6lbS6wK/9+cgr1nNZHFPJ8QgA/tAyEuNRXD260ChWEdg==
X-Received: by 10.98.34.15 with SMTP id i15mr8942166pfi.257.1506377668923;
        Mon, 25 Sep 2017 15:14:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id p6sm12074495pga.93.2017.09.25.15.14.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:14:28 -0700 (PDT)
Date:   Mon, 25 Sep 2017 15:14:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 6/7] worktree: check the result of read_in_full()
Message-ID: <20170925221426.GE27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925203156.boieic627t3dbpzd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925203156.boieic627t3dbpzd@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> We try to read "len" bytes into a buffer and just assume
> that it happened correctly. In practice this should usually
> be the case, since we just stat'd the file to get the
> length.  But we could be fooled by transient errors or by
> other processes racily truncating the file.
>
> Let's be more careful. There's a slim chance this could
> catch a real error, but it also prevents people and tools
> from getting worried while reading the code.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/worktree.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 2f4a4ef9cd..87b3d70b0b 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -59,7 +59,11 @@ static int prune_worktree(const char *id, struct strbuf *reason)
>  	}
>  	len = xsize_t(st.st_size);
>  	path = xmallocz(len);
> -	read_in_full(fd, path, len);
> +	if (read_in_full(fd, path, len) != len) {
> +		strbuf_addf(reason, _("Removing worktrees/%s: gitdir read did not match stat (%s)"),
> +			    id, strerror(errno));

I'm a little confused.  The 'if' condition checks for a read error but
the message says something about 'stat'.

If we're trying to double-check the 'stat' result, shouldn't we read
all the way to EOF in case the file got longer?

Puzzled,
Jonathan
