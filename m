Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C0120286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdIMVJb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:09:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34504 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdIMVJb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:09:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id g65so558393pfe.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tkn4XlMC3T5ts6okeTeH0GeLBhIfs7yk8B22xAclqPA=;
        b=cVJtsf+mmu1ppJdAZh8TO0LXkQ5o1zNfqzZsVXLSVQzM649Eew0C0PuSzR8JyhNCgB
         B49xdP0C8INCFEQkE0eyyxL6ehMgN2d5g4cRKE1SN0KV9BDerRCtL5oKu1ggS3D/9lZU
         DxH3aCkGI+bVtyqbCVe3ziq1lsm9obsC1bxwhSwyC1hY+7rG+URrB/d6GWOhR1U2s2zo
         guSpZBpsXnzBbzuokOqYR4evNFMvQT9At/9TYAVF6OCenJX7Xx08s4/YYPSSs16fXyqS
         iq//X474RXWRYcKBrAYgmAcW9KQsSR4vQVDFFX4pACzCF5Q+MGFc0GOf95Y1041Qb0UL
         nQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkn4XlMC3T5ts6okeTeH0GeLBhIfs7yk8B22xAclqPA=;
        b=SFO7SXrtUSX8v8v2jWrJE2Xlza02rUl5NWRUlrGEeBDpK1DBkeGCoevPle+/5MkSgd
         BjafUjxA0QtBWG1uBqS1Fa5gak+cDEd6maVyW3aCzBOwvt35NtfM5lESYGZ6EgtOMnht
         0WsIDLgn1EaPphyCSqCDNXBpjmP8+xZPAa2mz/uopAHo3vajojMprX/mePRcfHbLyZNk
         4V19Uq85bdFfgpfj5RubqLehrUwykidJabb0uvj+MyQqSS12rFR2+SOMNbYxaoQBWSVF
         LplPBl3KC8p9l1n+aEwcuGXiTxtG/TqzFTmqRG4xA3eg2ytsY2Ftc5+lJSEVZyACmZjD
         VoqA==
X-Gm-Message-State: AHPjjUj0iYWLW3WYgWbnw6vb1slBq20mngELbWPmEJSwJxLkdcGJDbRa
        hvUxjCfznEmwLg==
X-Google-Smtp-Source: ADKCNb7Ofe5yjhr+MtLwz21LZRluSPC5Z2ZnffEZXkwQjO61SotqNazFKvGjXHqcsYeNCDAsEV53/g==
X-Received: by 10.98.211.193 with SMTP id z62mr19318914pfk.118.1505336970365;
        Wed, 13 Sep 2017 14:09:30 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id u186sm22549912pgb.35.2017.09.13.14.09.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:09:29 -0700 (PDT)
Date:   Wed, 13 Sep 2017 14:09:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/7] get-tar-commit-id: check write_in_full() return
 against 0
Message-ID: <20170913210927.GJ27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171127.ocnitq6wz57ivhrh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913171127.ocnitq6wz57ivhrh@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> We ask to write 41 bytes and make sure that the return value
> is at least 41. This is the same "dangerous" pattern that
> was fixed in the prior commit (wherein a negative return
> value is promoted to unsigned), though it is not dangerous
> here because our "41" is a constant, not an unsigned
> variable.
>
> But we should convert it anyway to avoid modeling a
> dangerous construct.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/get-tar-commit-id.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I kind of disagree with calling this dangerous (and I think that is
what you alluded to above by putting it in quotes), but I like the
postimage more than the preimage.

The variable 'n' could be eliminated to simplify this further.  I
realize that would go against the spirit of this patch, but (1) it's
on-topic for the patch, since it is another ssize_t vs constant
comparison and (2) as mentioned elsewhere in this thread, it's a very
common idiom with read_in_full.  If we want to eliminate it then we
could introduce a separate helper to distinguish between
read_this_much_i_mean_it and read_this_much_or_to_eof.

Anyway, I think the below is an improvement.

With or without this tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git i/builtin/get-tar-commit-id.c w/builtin/get-tar-commit-id.c
index 6d9a79f9b3..03ef7c5ba4 100644
--- i/builtin/get-tar-commit-id.c
+++ w/builtin/get-tar-commit-id.c
@@ -20,13 +20,11 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	struct ustar_header *header = (struct ustar_header *)buffer;
 	char *content = buffer + RECORDSIZE;
 	const char *comment;
-	ssize_t n;
 
 	if (argc != 1)
 		usage(builtin_get_tar_commit_id_usage);
 
-	n = read_in_full(0, buffer, HEADERSIZE);
-	if (n < HEADERSIZE)
+	if (read_in_full(0, buffer, HEADERSIZE) < HEADERSIZE)
 		die("git get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
 		return 1;
