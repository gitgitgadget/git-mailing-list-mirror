Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7261F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCTQEW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:04:22 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:38014 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeCTQEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:04:21 -0400
Received: by mail-ot0-f174.google.com with SMTP id 95-v6so2293774ote.5
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e6g1ul105XG/USGI866QKGdSQVOTwaeXcqJJi8dHZAw=;
        b=C/9ZzbWJmmZchtzHhjrhvRakoBAvamS1FzZ7+iQGLE+zqVuVzzS+8O6dlXsU0CBVAc
         JmgpAwY5aSR/25hLJueSvcAsew37JA08KaUPZRsXSiCHsW5d3q8S/lYDiKQlQiZcI0OP
         Mz8/oPykwP9s2lNis/+pn8bTROGyt0ZmuX4kI4o1zY9OgEbSAol1mx+V1/FQI9MdAfm+
         GhiP5f/306Vwo6qkzjoJUO84dSHelDhC1mPYuE//MhASSQOi24tLNb19D7OeQ6e5PsoZ
         nKvIfB9EzjoNwE/frNFgH+AZa/Zd7uMSLTXwt955YF3SzgYq6qS4XqDWUFTD+EnqQdc2
         GDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e6g1ul105XG/USGI866QKGdSQVOTwaeXcqJJi8dHZAw=;
        b=CGPOruMXyy9p/X6hbkNS30VoCiIYKo2cn7SwLv9NXR1SCL59/HagTAm77ll2zpvNCd
         QYHBMER7PgRbVEW0PaLrtDgwlG8kk+GUzl937qN0hx2MC77QWuoX8GZO4nk3TuhTUfkF
         kXEq0NMZkdLGfqFrTnVt13LC44oK+i8xR733WiNC409dBuQ+tiMgy2gQ5feneVPDM5qh
         UMDJ5OmpijtdJI/ex/ygjrxcV87zpqCbyF95q7nGtqkV1iXBzKBMQeM6Cy3YavLyFcfC
         SnHFtwFZDon93TFx6DD+tgjtW5dTRUnpa6vzBGwbv1c4MXp9kDv5ZalqD0phlTXbAytT
         RgTQ==
X-Gm-Message-State: AElRT7E2vHKm5+Nl3fXF4tEzKtQ19vJjgSF9+C22pqJ2hsK0ZSq+1kzi
        DYnGGWzBwLMf2RpkncAXbYOJRVx5bB5E37dcx94=
X-Google-Smtp-Source: AG47ELsF4pIQ/XDzl/Tp5k4efqfz1sqnu34yBpM8rW7L4v/KLtsYqvAEjWi6Uzk0zgQ865+e2WL/PvsmqYrj1pIeTWw=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr11363102otq.75.1521561860786;
 Tue, 20 Mar 2018 09:04:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Tue, 20 Mar 2018 09:03:50 -0700 (PDT)
In-Reply-To: <f301d093-af93-016b-79b9-3102475260cf@arlut.utexas.edu>
References: <f301d093-af93-016b-79b9-3102475260cf@arlut.utexas.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 20 Mar 2018 17:03:50 +0100
Message-ID: <CACsJy8ABgZy=eJ7niUysb2XZ3qUr3J+jmh_5YWZ1ZDiFCrb0tA@mail.gmail.com>
Subject: Re: Understanding Binary Deltas within Packfile
To:     Luke Robison <robison@arlut.utexas.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 4:43 PM, Luke Robison <robison@arlut.utexas.edu> wrote:
> Is there any documentation of the contents of the binary delta datain a
> packfile, and how to interpret them?  I found
> https://github.com/git/git/blob/master/Documentation/technical/pack-format.txt
> documenting the packfile itself, but the "compressed delta data" seems
> largely undocumented.  The source code of
> https://github.com/git/git/blob/master/diff-delta.c is pretty dense.

The output is consumed by patch_delta()  in patch-delta.c if I'm not
mistaken. This function is less than 100 lines, probably much easier
to see the delta format.

>  This
> is what I've got so for:
>
> +-------------+
> | Varint src_size
> | Varint trg_size
> | 1-byte inscnt
> | N-bytes up to 16 bytes of trg_buf
> |
> | A series of Operations
> |
> +-------------
>
>
> Any details on how to interpret the opcodes would be greatly appreciated.
>
> Thanks,
> Luke
>



-- 
Duy
