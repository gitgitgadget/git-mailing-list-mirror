Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1259201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 19:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdBXTVP (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 14:21:15 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:36211 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdBXTVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 14:21:06 -0500
Received: by mail-it0-f50.google.com with SMTP id h10so30604987ith.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 11:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oZokD9KVAqOiX7By8fD7pm0Uf5cZ8z6yai74/aStJN8=;
        b=bxFhGnD1QoMTCa3Zg2rByB+fK27Lrlsta/BYmB4ukNNXbwaSDcQLUM2ekv6q7QZVBs
         XVNGRG1ovyeHKNrNUv/TUSy/UOeDWZiGeahzCB2CO6GFTWlV0mq+2Lctk7KQTGikRhnd
         GySvCNLdWLrqefciff0+xlU9xrXzBj4JGpsGtEm2SrQYz9kW5GD/NaaFlepRrIRdCkNj
         LUmKyLCYOsLcejnzh3hesSN+8OBBV0SkFsICW/FUY2+ISI0nifg9mFVZ0aIX7aPXMuNQ
         8YNrrhq1VsLwPe+a1cMGxQQmNGCE596DLNvpDRIOdtk8PbzYfvefl4xoniDtEoaU7k48
         i4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oZokD9KVAqOiX7By8fD7pm0Uf5cZ8z6yai74/aStJN8=;
        b=FESIAQBfT6a/sE4IFyqgaRxOQGod9HySJOAF17YuOf+3jlf0ykXjA8G1pBYl23wsnh
         42jgBNUG4bSDGebfLKzdj6UL3LinTO197WHm2QNT5amWN04qNQUduSkQB7n6LXuqP3rA
         jePcRklevXhn0yUrZZD2Sc1rk6Thdyr9620U57S9PsXLLsPdci2yCIL569nCg89Pqi4I
         aMtqSelzbqNGEMCZjb/d6dkraDuPdpmDIoqhicvbIHSmXvNw4kKVFvfs4F+9Z5ylno7o
         5ZCRRhTPLJ/8krXfqw5LMEJG6BNVadjEMOyXwi7JL47MxEeWopayehIyZwko6xrFyhHd
         +mNQ==
X-Gm-Message-State: AMke39kSrTKZ/gQ1BH3wLk9H4H1s/M5/ncTiEKtRCY+1bwjrmFIjGBS6db1oTckuhtvBXpg3Kd4kz1uxC4fWQC/V
X-Received: by 10.36.65.4 with SMTP id x4mr3904967ita.69.1487964048288; Fri,
 24 Feb 2017 11:20:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Fri, 24 Feb 2017 11:20:47 -0800 (PST)
In-Reply-To: <db5cfde2-a769-d786-8846-a5a526194b69@ramsayjones.plus.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com> <20170223225735.10994-1-sbeller@google.com>
 <20170223225735.10994-16-sbeller@google.com> <db5cfde2-a769-d786-8846-a5a526194b69@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Feb 2017 11:20:47 -0800
Message-ID: <CAGZ79kbD8SBHURQJvrNKKP8Ycay8wZcwUGw7V4mmo6PmfmJ9=w@mail.gmail.com>
Subject: Re: [PATCH 15/15] builtin/checkout: add --recurse-submodules switch
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 5:25 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>> +int option_parse_recurse_submodules(const struct option *opt,
>> +                                 const char *arg, int unset)
>
> Again, this function should be marked static.
>
> [I also noted _two_ other local functions with the same name
> in builtin/fetch.c and builtin/push.c]

fixed in a reroll.

Yes there is a pattern here. But as both fetch and push accept different
options (not just boolean, but strings) these have to be different.
I thought about unifying them, but I do not think we can do so easily.

Thanks,
Stefan
