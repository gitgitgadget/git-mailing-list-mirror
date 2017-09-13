Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C8920286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdIMVUi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:20:38 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33441 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdIMVUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:20:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id i130so655956pgc.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1t9EhC7+ZRvh3UqobBG6DAteOUPK/LmmWU9FpCX6mU=;
        b=Hgu2CYh+UzO2+E7W5exxVVXkYYQ8BHgYGoiDntfWP50cnyp6bDZviv/2/SVWWu56rI
         hCmRqpYsNu/p3hHKVIDa2xR0Zdpeqg3VHAoSXvtNHjLwczVNbujDQh3bIfighSz3F+oq
         Ag7Kq04VmyNnyispNIqiPjKIUETPR/LKOwUtxZ8ybsWVEgp0kd9pnWne0eaKgutOd+bC
         zxrjdFq0Diq6AkDAxvBgAnCuuJBbtREAsOGuajwCXRa6llBNQsMMW01gEyIHUXaJDBXT
         FNkZq+84q4H9g0bUeOj1f3H5YCfhWrUmlYcoUvVYmLFrpmGCN7DtAtXvy1w8u7NAIYIJ
         puIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1t9EhC7+ZRvh3UqobBG6DAteOUPK/LmmWU9FpCX6mU=;
        b=io/pkdyoEv8sYx/H1JOe8+2FFJ4Rs4DAyFBN5N01TisNl9AJKsZQP7f+xfTcIli9/n
         lgD2VRj8EDGkUMgO+qXMKgeBEI6GhT9YUBzZhWd7XNfU1mwGjWqy5MDndbYOdZmZVM2n
         TX0WxDe7/wNJX1oIAiTWsFaSWXyiHFumW3dTN3nlXH6vZaRTZZuebgwLc7tp3FlK188d
         LgNLFF/n5sVqvuCLloSDR9PP/pM3YzvbG53x2gsojIRZoHcTxcUUbAmSALQlt7N/U+xD
         fC/FNf/tljldAy0uwz2Q6m18FqgwwLGYU4AgSDNZq5IypylitpVGOTNX3qBwMWnBv3CN
         KhtQ==
X-Gm-Message-State: AHPjjUipyVybnEMy7GJlr9sfCpl44rPi3Pl8wF6RXGPI/GMjx9khhWKA
        b+RqncNvSNPrOg==
X-Google-Smtp-Source: ADKCNb5NqZkjJ+yUbd4/ze9pNH9i8t+FwRgCS8xkb+xpw1YeN+9pITSfFwoz0M+8S1LIZAMMaTBDSw==
X-Received: by 10.98.89.6 with SMTP id n6mr18968196pfb.27.1505337637430;
        Wed, 13 Sep 2017 14:20:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id z26sm14950835pfa.49.2017.09.13.14.20.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:20:37 -0700 (PDT)
Date:   Wed, 13 Sep 2017 14:20:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/7] notes-merge: use ssize_t for write_in_full() return
 value
Message-ID: <20170913212035.GN27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171744.32cmtjkdcp7yf7pt@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913171744.32cmtjkdcp7yf7pt@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> We store the return value of write_in_full() in a long,
> though the return is actually an ssize_t. This probably
> doesn't matter much in practice (since the buffer size is
> alredy an unsigned long), but it might if the size if
> between what can be represented in "long" and "unsigned
> long", and if your size_t is larger than a "long" (as it is
> on 64-bit Windows).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  notes-merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Yikes.  Good catch.

With or without the tweak below,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -302,7 +302,7 @@ static void write_buf_to_worktree(const struct object_id *obj,
>  	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
>  
>  	while (size > 0) {
> -		long ret = write_in_full(fd, buf, size);
> +		ssize_t ret = write_in_full(fd, buf, size);
>  		if (ret < 0) {
>  			/* Ignore epipe */
>  			if (errno == EPIPE)
> 				break;
> 			die_errno("notes-merge");
> 		} else if (!ret) {
> 			die("notes-merge: disk full?");
> 		}

These three lines are dead code.  How about the following, e.g. for
squashing in?

diff --git i/notes-merge.c w/notes-merge.c
index 597d43f65c..4352c34a6e 100644
--- i/notes-merge.c
+++ w/notes-merge.c
@@ -308,8 +308,6 @@ static void write_buf_to_worktree(const struct object_id *obj,
 			if (errno == EPIPE)
 				break;
 			die_errno("notes-merge");
-		} else if (!ret) {
-			die("notes-merge: disk full?");
 		}
 		size -= ret;
 		buf += ret;
