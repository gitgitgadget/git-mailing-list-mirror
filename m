Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071DB20D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdFBAr2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:47:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35294 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdFBAr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:47:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so9884057pfd.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DvIPah/TYJOO+FwYH/ZBq8BOISInJRIOLmvikdRt+OA=;
        b=GOTUGawm4KiT9Pe4vP4xRKS7BhxU3XGnE7luvdJLYWuNBCChvnMD7NAk3GitPx183x
         yPhwfGglwENl1qLLF/0T98IcP5WYwxfUs/gyyfS1t3He/hjSOQRBovEOHHCm9lBnErxf
         b+cz5sTkVQo7OabQBh2as33kAUEER14RfI4uuj3S6WDg0rQEfgq5JpqPWeNEK4X2zXvj
         NZzN1U8esvvNzmW9BFpn+4NrOX6eDDP5TV7MZUVvCx1HgON3Xhl8eNegwszR6reI6H7x
         zmr/NkeAmOv41qSAzX7fFhUYQB5k0c/mk9nQGOHgVHSuszxpJP0BmO1QJe/UkFZm2se7
         NTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DvIPah/TYJOO+FwYH/ZBq8BOISInJRIOLmvikdRt+OA=;
        b=j1nvQmUxb1wLSHsR9uWK1WNcfYXwC0/FNx/Cd2ZIwwZfwnkzLFjpuufSZIf8ntYMGQ
         0pPs8MvzR6iRtztA26B4Bh9K95OUjzdKPmo9AX8cmItZliIORlv61CP5+MtJ8a0BhaCt
         XR2GRankJEHKkWuVWzBdTe5EAOAr+xSckPW6FSWsd6UICXJuon4Ia1ug/L2uCC+9rsl/
         j/p4UCEBVHgxJtgazc7f6aZYO32h330gm4fNDRyFJS/NmUkUAvQqReLECFsG8pODehGR
         6xDJDi2FGNa7EH0mMrFLR+CwGuvJuouW7powfGGRzrr4hAVDUha7U5XrPKZ6v+WVDEW6
         QjSQ==
X-Gm-Message-State: AODbwcD7DiPANx66GlH7Z8a/cu6erRc8H5znKKXie03VRdlohASuTP92
        M/9Lx2rTg2SOIw==
X-Received: by 10.84.217.70 with SMTP id e6mr12859974plj.130.1496364446723;
        Thu, 01 Jun 2017 17:47:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id n24sm37823032pfb.14.2017.06.01.17.47.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 17:47:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 25/33] notes-merge: convert verify_notes_filepair to struct object_id
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-26-bmwill@google.com>
Date:   Fri, 02 Jun 2017 09:47:25 +0900
In-Reply-To: <20170530173109.54904-26-bmwill@google.com> (Brandon Williams's
        message of "Tue, 30 May 2017 10:31:01 -0700")
Message-ID: <xmqqpoen2p2a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  notes-merge.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/notes-merge.c b/notes-merge.c
> index 55dbb3659..962e9b1bc 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -22,21 +22,21 @@ void init_notes_merge_options(struct notes_merge_options *o)
>  	o->verbosity = NOTES_MERGE_VERBOSITY_DEFAULT;
>  }
>  
> -static int path_to_sha1(const char *path, unsigned char *sha1)
> +static int path_to_oid(const char *path, struct object_id *oid)
>  {
> -	char hex_sha1[40];
> +	char hex_oid[GIT_SHA1_HEXSZ];
>  	int i = 0;
> -	while (*path && i < 40) {
> +	while (*path && i < GIT_SHA1_HEXSZ) {
>  		if (*path != '/')
> -			hex_sha1[i++] = *path;
> +			hex_oid[i++] = *path;
>  		path++;
>  	}

It's no brainer to do s/GIT_SHA1_HEXSZ/GIT_MAX_HEXSZ/ for all of the
above, but ...

> -	if (*path || i != 40)
> +	if (*path || i != GIT_SHA1_HEXSZ)
>  		return -1;

... this one is tricky.  

What's in our envisioned future?  Are we expecing to see object
names, named with two or more hash functions, in a same repository?
If so, and one is 20 bytes and another one is 32 bytes, then this
should check 'i' against 40 and 64 and pass if 'i' is one of these
expected lengths?

> -	return get_sha1_hex(hex_sha1, sha1);
> +	return get_oid_hex(hex_oid, oid);
>  }
