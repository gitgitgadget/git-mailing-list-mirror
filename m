Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC231F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIMDpT (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 23:45:19 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41963 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeIMDpT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 23:45:19 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so382808ywg.8
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xqb+YjzLdZzEJcyfSbsHQgJL9NzMUCOoLnuSrjecXdc=;
        b=HgQCPcksMZQ8hFFdiEtBjLLHTluUKfFLNatbM48TjT5XVTdBDVcyboF0f/tEDNsU6p
         yKDdGuXTK7wDh/TBd9rWiIXgJPsfNgwtxYU+qRKXvhmaXSEWXF0XCpdGbZBrGEYy4cvp
         KuaNHAqwWHoRi+GtBxG6rRLtsPKkWpVcslaU/ojBawiP7KzABnQzrK9OYEPzkeaGpJgs
         YJtpSXKPAfFRQgOa9zVHpVkBqcdelc2VN6maSMlTM1xP7qNvRW+memV2wXeMDodGvQNY
         CXr4NfXH9MdcSyzlyc7REs7WOuGPaXYFjDg7SZga/QrOuoIMy5fRWsxzpMpLKIm+vsUk
         s6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xqb+YjzLdZzEJcyfSbsHQgJL9NzMUCOoLnuSrjecXdc=;
        b=p5Bi+BnNpXeA9KJSoy2FUX/jhJB8s121A8kfXqadwP9bnjCZTwrWkTrkyRdXywmd87
         I1hfUphbUE7rlR8KY2/T+lP9JX8opshLTVsifIWC+q0g3lv1w99CHNN8rTWjmItTvf6K
         l7Y9XXnNUXhafpAzSt80g0MxJfuegEJRd5AzCryEolpDD4rAcg4jpkwfKQ2QsPrADX4n
         YICPCxBO7zzppSsD2YW9A+QAAGVq10QqVGxImjhky01k6dBmijzfoWWD2R4YlUZE2qgL
         mGiX3Wc8Z8kbl4bOBkLr8iDwdga3ZosRNQxZFfxaS9Dv7PnNUgZLMOaVssYCTS4ZXcmi
         N99A==
X-Gm-Message-State: APzg51AWIsukyCbz0ElHaag4PyDry4RCdvi4GN227zEYFYYJdp3m9bjx
        aUotzasfMYD6es6NawoShOVQchf8Tt1ingii4SJodQ==
X-Google-Smtp-Source: ANB0VdaLh7Sk/XYDypC9c8Gt8wrjZtLHcFYJ+oGc88NpLDHNKD7tJlPc379FhMsl7/eQM1i5i2ZJm4eWccCiPUh8xbY=
X-Received: by 2002:a81:5710:: with SMTP id l16-v6mr2069699ywb.3.1536791921704;
 Wed, 12 Sep 2018 15:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180912053519.31085-4-steadmon@google.com>
In-Reply-To: <20180912053519.31085-4-steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Sep 2018 15:38:30 -0700
Message-ID: <CAGZ79kaXF96QKm6g2kUj+C0-ebhrNLY_BVJWhj_xYeritjPkvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] archive: allow archive over HTTP(S) with proto v2
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 10:36 PM Josh Steadmon <steadmon@google.com> wrote:
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/archive.c  |  8 +++++++-
>  http-backend.c     | 10 +++++++++-
>  transport-helper.c |  5 +++--
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/archive.c b/builtin/archive.c
> index 73831887d..5fa75b3f7 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -87,7 +87,13 @@ static int run_remote_archiver(int argc, const char **argv,
>                 status = packet_reader_read(&reader);
>                 if (status != PACKET_READ_FLUSH)
>                         die(_("git archive: expected a flush"));
> -       }
> +       } else if (version == protocol_v2 &&
> +                  starts_with(transport->url, "http"))

I assume this is a smart way to cover both http and https
as the latter is prefixed by the former.

How does this interact with remote helpers
(See gitremote-helpers(1), which doesn't mention archives,
but I would imagine that one would be able to use a remote
helper eventually, too?

    git archive --remote=abc://example.org/test ....

> +               /*
> +                * Commands over HTTP require two requests, so there's an
> +                * additional server response to parse.
> +                */
> +               discover_version(&reader);
>
>         /* Now, start reading from fd[0] and spit it out to stdout */
>         rv = recv_sideband("archive", fd[0], 1);
> diff --git a/http-backend.c b/http-backend.c
> index 458642ef7..d62d583c7 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -32,6 +32,7 @@ struct rpc_service {
>  static struct rpc_service rpc_service[] = {
>         { "upload-pack", "uploadpack", 1, 1 },
>         { "receive-pack", "receivepack", 0, -1 },
> +       { "upload-archive", "uploadarchive", 1, 1 },

So git archives are not supported in protocol v0 via http?
Then it makes sense to see not mention of archives in
the remote helpers as well.

The rest of the code is a surprisingly small patch.

Stefan
