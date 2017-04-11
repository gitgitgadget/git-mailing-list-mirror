Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7B920970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbdDKUvU (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:51:20 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34502 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdDKUvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:51:19 -0400
Received: by mail-oi0-f50.google.com with SMTP id g204so10985573oib.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 13:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jqUvkJ5uwCpLnAbsTw6D7QClY3/qH87Hi2uw/uBdgWU=;
        b=K5CZr1ldL/6o5+kfl4h9Hhk6Q2ADPKZly1W+4m3BqOW1rmMgYdCwB8WY7BH/igSGlb
         zd+H2L7b0HVDLBQaDnXlce7RfT+Pyi1A6/Plp/lLJ+ZfGYPyCZMiEI09/9BJy2gLPx3u
         j7h6kTkO5qnAQPCAEC0J9YTBckP2rAHVBtB8mlXehy5JCpBnSqD/TAE5GNTplGKipvpy
         b8fsRmMKz6tsnMx9jrhzCSYSHihq+lMdQnpeUW4SfgxzXo+ownJJDnJGSARuUOQ6QVIu
         Ya4VWRWx9BDaIitGMQxK7jJEI9nbF1FJO9diuK8vaQet25kzRnE2zfMdt81t51IwOmd/
         h9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jqUvkJ5uwCpLnAbsTw6D7QClY3/qH87Hi2uw/uBdgWU=;
        b=TWDBCIXTyo6IK7hnHKtsuQ5BX6Feo1a43insbzMigU/0xqG0JnCyWA0uHuKbFG40Ow
         I2a0/BaoQq6xGqZEqsnyPcFXw0DbOKX4vUPNrYD5rQdKZbZZv8+QPY0yvuuUcGmkuyKw
         CLCICwictuSP9g229v78giOf/a7ty7i1udo96PjUKUOXs1Ilj0jAYmgTIdY9Ekls6VyY
         lT9C9ialrf1+gLNBGNSCKIb3p/40lcWpkGQQgKSYqMWwHlh2B+eafoF9Ob7vUONAlD5N
         NqdDEMlvUdn/krMtXllwFTNa8le3r6F9MryVREajafB+1y8B19n9ZNTZFvEuhqrG4xVf
         E2OA==
X-Gm-Message-State: AN3rC/63Ra4RNQDSqFeqYLLbBPa0LdP2F087cwZ1hKRS7U3hFefHeDwIlkxE+gfsIuqFzf8H+CSOvnfJWdb6YQ==
X-Received: by 10.202.212.194 with SMTP id l185mr12910924oig.88.1491943878255;
 Tue, 11 Apr 2017 13:51:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.35.80 with HTTP; Tue, 11 Apr 2017 13:50:57 -0700 (PDT)
In-Reply-To: <20170411173722.asjrkpbbm4p6k6ov@sigill.intra.peff.net>
References: <20170411171750.18624-1-ryazanov.s.a@gmail.com>
 <20170411171750.18624-3-ryazanov.s.a@gmail.com> <20170411173722.asjrkpbbm4p6k6ov@sigill.intra.peff.net>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 11 Apr 2017 23:50:57 +0300
Message-ID: <CAHNKnsT6-U2TY0KVNGXXkWytZt-ixqDM-WR3Qcq1A-3+NgxAUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] http: fix the silent ignoring of proxy misconfiguraion
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 8:37 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 11, 2017 at 08:17:50PM +0300, Sergey Ryazanov wrote:
>> Earlier, the whole http.proxy option string was passed to curl without
>> any preprocessing so curl could complain about the invalid proxy
>> configuration.
>>
>> After the commit 372370f167 ("http: use credential API to handle proxy
>> authentication", 2016-01-26), if the user specified an invalid HTTP
>> proxy option in the configuration, then the option parsing is silently
>> fails and NULL will be passed to curl as a proxy. This forces curl to
>
> s/is silently/silently/
>
>> fall back to detecting the proxy configuration from the environment,
>> causing the http.proxy option ignoring.
>>
>> Fix this issue by checking the proxy option parsing result. If parsing
>> failed then print error message and die. Such behaviour allows user to
>> quickly figure the proxy misconfiguration and correct it.
>
> Two minor grammos:
>
> s/error/an error/;
> s/user/the user/;
>

Thank you. Just sent a series with suggested grammar fixes as v4.

> In the earlier discussion you mentioned a warning, but I like this die()
> much better.
>

I actually meant "die" but by some reason I typed "warning" :-/

> Both patches look very clean, and nicely explained. Thanks for working
> on this.
>

Peff, I would like to thank you and =C3=86var for your great help!

--=20
Sergey
