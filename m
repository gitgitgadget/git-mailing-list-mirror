Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E226208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbdHJUd6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:33:58 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35285 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbdHJUd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:33:58 -0400
Received: by mail-lf0-f52.google.com with SMTP id t128so8434761lff.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m++S2dQJuAdkRUCKitsSGeWDU8nz1f5ErD2woGWkklw=;
        b=wVRIgza7vToLpdLTJlBQ852Gb5FIXS3RQiqH4xnhWmvjACzI6eDDX24CalvP+x8RWf
         TLieZL467H5ZutFDDG8QfgZLENJYl4xs+tmkkuHtnieec3SHv6nYwDhwlCf4tZUAScFt
         7SRDGSkMpAGMKfChUXVB7OAyGAjbv8YBQ+8vaSGmiwKwuP4doAkjO/d8RMmyNBC0CjdT
         wjX4A7/Q3MOB8YKABvChXaA23b6umW+hQsy0tDuWFOOZvoQYlPK/PZChmUO/c0+Eb4XB
         ukQSrQkLKU/5L0DGqtXqpCpmHgqiSlwNJ6QGpOtGGOgU62Qy2cEFra1n6bN9GiOI7kG/
         z9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m++S2dQJuAdkRUCKitsSGeWDU8nz1f5ErD2woGWkklw=;
        b=RV3g+wgELkG4mZCb6l8YFydyxEpyTm5b2mnyVIcEaEPC2bquxgqf4id2qjbBm1lw64
         mxjtbrp2Zz0dl6TVeVcy2yoAuRhWFzWKq+N/iKsK0/BhiQrFCmxBnqPmItrpQWEdnNkF
         EqGgZa8bKWA97FXTx+yxFD5l1y/rKM6f7/JDs5LhWcCxgj765RC57fxIlDuPKW/TtwBD
         P2vatsy0Jl2mJFjPZ3mGxjLt5tvf9MKrauC86HkOIZBEx2FdZNd79X3mmIZziG/6FPag
         jfz4ZcCImpEMpnYJm8ovFu6NH4N8a1cPPgxG6/BtmDULxGvpFGrXlimkYVb01grRmC6W
         xhjg==
X-Gm-Message-State: AHYfb5jtjEDgSGuAW8erl7v0M9vZHyY7pT4jukswdqkPXAojTfOgdm4U
        hks9P4dsFqtN1yH3G1rt1pizw0nAH5LI
X-Received: by 10.46.69.193 with SMTP id s184mr4447415lja.116.1502397236341;
 Thu, 10 Aug 2017 13:33:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 13:33:55 -0700 (PDT)
In-Reply-To: <e71f1aab-d93a-2774-4378-8431bd33e146@gmail.com>
References: <20170810184723.12424-1-kewillf@microsoft.com> <CAGZ79kaB7w+OD_8LOgqHjBJ8gCtXUGWPj7Cw8bWXEEQweqMaFw@mail.gmail.com>
 <20170810190349.jxlp6i7c6q5hpari@sigill.intra.peff.net> <e71f1aab-d93a-2774-4378-8431bd33e146@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 13:33:55 -0700
Message-ID: <CAGZ79kbM6F8SMB4K1d_fY1TEEOvVJfuvot7tv8=KWqOtLUgB2g@mail.gmail.com>
Subject: Re: [PATCH] cache-tree: remove use of strbuf_addf in update_one
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 12:57 PM, Kevin Willford <kcwillford@gmail.com> wrote:
> Here are some of the performance numbers from the windows repo.
> I will work on writing a perf test for this change so that we
> have a better idea on smaller repo what the impact of this change
> is on them.
>
>              | w/o     | with fix |
> -----------------------------------
> git checkout | 36.08 s | 33.34 s  |
> -----------------------------------
> git checkout | 32.54 s | 28.26 s  |
> -----------------------------------
> git checkout | 44.10 s | 38.13 s  |
> -----------------------------------
> git merge    | 32.90 s | 30.56 s  |
> -----------------------------------
> git rebase   | 46.14 s | 42.18 s  |
>

~10-15% is impressive for this patch, I certainly did not
expect as much. Thanks for providing the numbers!

Stefan
