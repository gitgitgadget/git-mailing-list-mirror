Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC45B1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeBGTAk (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 14:00:40 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35279 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbeBGTAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 14:00:39 -0500
Received: by mail-yw0-f195.google.com with SMTP id u21so815179ywc.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pDGYF7+fvk6rVNtwtl7YEnM6Axr27EbbbXjbmjrXpuk=;
        b=jXgBtutSOvu+OHEzX3B+s8gFPqQPUiqTprYrOwnZo2CULONY1s6HcBWOQ1QC90CfEw
         VVwjkZTVvpjkF4h/RccUIpO8uxzI3znkZdnSHDyYrDrW53tnav73wYJiwdPnbbKgtC9d
         6vv3rD+KnuYJDzINPLkV8LQc3ZmG0RRaNxUh0E8kL4p3kgAMS9MJD8uVNEBfII/9A6RS
         CFtYL6Oml2kJR8mcgw/VcdKfh9eNs+4iAqwqhSV1D0R9YYvRyBknaRSkO7D6dh5D6UOE
         lIm8LW2tj/TqXdXQ7byCMCHc5p8RrHNlTs4vCxFQ1oq/DQkeHYg4V9bq6TUB95s+bKwZ
         f/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pDGYF7+fvk6rVNtwtl7YEnM6Axr27EbbbXjbmjrXpuk=;
        b=H0LMEgQ8wpp9MVp0SHz5BQ6eWtyueU4P8IJ5nKwV840l8Yea2GXW2guYgsk4mdcWr0
         dnzY4wLaY8/D/TpoOsCoR0O+zvmFpMTOMNe0AKVuDS4r+P55sELkqLCwlX04F2JD8Nri
         4EbQC9f/YcOwzeqHTLfIxpevSk+R/SDSYQlu5/jKPmTuT8OpXwRiGiPHQZu3q0szJdbD
         /J1ax9XOd5YHEFib8pPIY79zHX09r2Q+nVQTnjFG8d5ezHdkXjjw3sOB0QrjloHRpg4e
         4Ff9NwymJjIliWc9jU6K9nZ0c6mtAtDGjZY/wv3BMcvrrkHeU8vfDqXzhs+OLKSSK1Zh
         rEJA==
X-Gm-Message-State: APf1xPAdu00zbVzcZGYh0mxuHmanf160RpAUSowlI5UdWKWPtUlPAME8
        /97PpAlA8im75u4HOMcXLYRR2wyfrAsBaOYa4/ngYitM
X-Google-Smtp-Source: AH8x227+cyRc2PVn/f2v7fu15hpANeLMN6aSwiSpeWFPWI/NRJBJgXM+Fpqs1Gof8ZLGkt3kUDSL+Xqa8EIA+/Z5VWU=
X-Received: by 10.129.119.131 with SMTP id s125mr4532220ywc.166.1518030038378;
 Wed, 07 Feb 2018 11:00:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Wed, 7 Feb 2018 11:00:37 -0800 (PST)
In-Reply-To: <20180207011312.189834-23-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-23-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Feb 2018 11:00:37 -0800
Message-ID: <CAGZ79kauMhgP4Gjm=yVKSDGh0-WMSpNVCJRamfjnANyO5SWXTQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/35] upload-pack: support shallow requests
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> Add the 'shallow' feature to the protocol version 2 command 'fetch'
> which indicates that the server supports shallow clients and deepen
> requets.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/technical/protocol-v2.txt |  67 +++++++++++++++-
>  serve.c                                 |   2 +-
>  t/t5701-git-serve.sh                    |   2 +-
>  upload-pack.c                           | 138 +++++++++++++++++++++++---------
>  upload-pack.h                           |   3 +
>  5 files changed, 173 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 4d5096dae..fedeb6b77 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -201,12 +201,42 @@ packet-lines:
>         to its base by position in pack rather than by an oid.  That is,
>         they can read OBJ_OFS_DELTA (ake type 6) in a packfile.
>
> +    shallow <oid>
> +       A client must notify the server of all objects for which it only

s/all objects/all commits/ for preciseness

> +       has shallow copies of (meaning that it doesn't have the parents
> +       of a commit) by supplying a 'shallow <oid>' line for each such
> +       object so that the serve is aware of the limitations of the
> +       client's history.
> +
> +    deepen <depth>
> +       Request that the fetch/clone should be shallow having a commit depth of
> +       <depth> relative to the remote side.

What does depth mean? number of commits, or number of edges?
Are there any special numbers (-1, 0, 1, max int) ?

From reading ahead: "Cannot be used with deepen-since, but
can be combined with deepen-relative" ?


> +
> +    deepen-relative
> +       Requests that the semantics of the "deepen" command be changed
> +       to indicate that the depth requested is relative to the clients
> +       current shallow boundary, instead of relative to the remote
> +       refs.
> +
> +    deepen-since <timestamp>
> +       Requests that the shallow clone/fetch should be cut at a
> +       specific time, instead of depth.  Internally it's equivalent of
> +       doing "rev-list --max-age=<timestamp>". Cannot be used with
> +       "deepen".
> +
> +    deepen-not <rev>
> +       Requests that the shallow clone/fetch should be cut at a
> +       specific revision specified by '<rev>', instead of a depth.
> +       Internally it's equivalent of doing "rev-list --not <rev>".
> +       Cannot be used with "deepen", but can be used with
> +       "deepen-since".

What happens if those are given in combination?
