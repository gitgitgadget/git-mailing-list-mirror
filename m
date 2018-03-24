Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA721F404
	for <e@80x24.org>; Sat, 24 Mar 2018 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeCXSW6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 14:22:58 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:54772 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeCXSW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 14:22:58 -0400
Received: by mail-it0-f52.google.com with SMTP id w3-v6so6198070itc.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ncjek73pBi4RV1BNakhyRb1FBOKBYhAVE7CmSR61O8I=;
        b=SQxCtrX6LbQLcnNyRd1Ic8cbeb0kX5HWO1gYDAQlx5iN6oofN2/iliJ+nEwoG71fx9
         /xgyomC5y3A7IFVZOh+F/craC2rzNBbaA6kEPFAqjxB4lvz30Z54gG5URGr+rByFqi3w
         81Yo2bnSvps+1NqQvtt/Ox8AAea7EIoUkTtSg5i3uk4+NLX5WFRnwIO0Oyslo4tcfYgc
         xGE/Q/Vi33Ti46l3cEQkjMkxW0fq/Rk96+ZEcaxRm08X4PjBu5d0pkZkog3NS44z5zgw
         Ovd9EBizvJ7sOxeKIxFLiroE6i6BghC1Ie6+2p8ZKV0iRhU2hI0qpBcTSAEY6gt5HwBv
         98FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ncjek73pBi4RV1BNakhyRb1FBOKBYhAVE7CmSR61O8I=;
        b=ov0EtAxj5MK+Ho70O87o09SGXxWHtCjHYXsnzSBPpqLTe25M2r90Gd0JwA/LD4wB7I
         12V7hMXlQKc7Bnz6z8qGRUAX+Xr0E4VTIwCq6A4keFwPvTUKEPYDORWbHY1PJgf8Ywqv
         ytWmhUi60WGesn9nDjjjda3Is4FSD0HnznFMAUSwd7G2xQuH6Rr0Z5cUxrUdKlm1vOMo
         3a7HCsWDtJc9Q9YRROS52a6R3sTlyK54vKmleUxAgQZx2AZCDgwx5SK6CGh5vheL/qFS
         50zqUKPdfosNcazbJAB34tYSwp+Fgr5aG6qtXImILkRET/DNVbbvcSUztBm0pkfTX9Lc
         Xy9A==
X-Gm-Message-State: AElRT7HKKy2lbCV54L9rVWGZKmIQXz6FqfWYYOAKjA3lz3sWsBpbbVYG
        rYrNGRdLJeg31z5NKpTwqYJUihkNrsDIh5wl054=
X-Google-Smtp-Source: AG47ELub8T+JHMKbGhPAqmxnepNGfvxsJ15+0xOlGYtLXabE7dKAzH9ty7CNV5PBtXexEhGKRySiMnSf/QP7/L/R5w8=
X-Received: by 2002:a24:80c7:: with SMTP id g190-v6mr13998373itd.129.1521915777331;
 Sat, 24 Mar 2018 11:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sat, 24 Mar 2018 11:22:56 -0700 (PDT)
In-Reply-To: <20180324173707.17699-4-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-4-joel@teichroeb.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Mar 2018 19:22:56 +0100
Message-ID: <CAP8UFD2yudVPNya8sTTd5UUq7Doxp2VqSf+aCecJPHE_c1VoqA@mail.gmail.com>
Subject: Re: [PATCH 3/4] stash: convert drop and clear to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +       argv_array_pushl(&args, "reflog", "delete", "--updateref", "--rewrite", NULL);
> +       argv_array_push(&args, info->revision);
> +       ret = cmd_reflog(args.argc, args.argv, prefix);
> +       if (!ret) {
> +               if (!quiet) {
> +                       printf(_("Dropped %s (%s)\n"), info->revision, sha1_to_hex(info->w_commit.hash));
> +               }

The brackets are not needed.

> +       } else {
> +               return error(_("%s: Could not drop stash entry"), info->revision);
> +       }
