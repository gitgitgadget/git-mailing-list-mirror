Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0D31FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 16:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbdBJQpy (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 11:45:54 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:35811 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbdBJQpv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 11:45:51 -0500
Received: by mail-it0-f44.google.com with SMTP id 203so145550578ith.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RCbyrPk25FAv0zuZrju31FRLvf7odQy4hvZR2gmUci0=;
        b=pbMFkge4G81yGz6hUAodtTj10hVe64vq9ufND5Hg+EF3Xt+MpWm3dBFxF6rlCT1X8m
         iB050H7+wHv+wxcdG9XDaiz1EJB8AXVx54bz8aF498FMKCZDVMk/QOEids+D4JOZdNYv
         AQggXJxjIWTtR7CV5nRlPT5TnH0umNh1xYmz5BESCcy19uLxEJMM8lACxMqivrW5ViCC
         D3wT+1krHKq7RyR7VfXGCZI+13/VZfs7hxgl7u5Rq3AgHeN9h4d+6LpwmzrJ+wTURF1U
         iyZnyr9Q8vkksYyhrTVt6lsxu7jDEbhO5vYVNlx/cwpVO4vO5HrqG8YTnZHn+CF7F4tV
         vQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RCbyrPk25FAv0zuZrju31FRLvf7odQy4hvZR2gmUci0=;
        b=ZB+bc9QdX/vMqL5XUYvoxhyH+Hts/nuBT3+e1XTAUvKLC5Mz90ahPhZajyApV5f5Fh
         mYO5oYGhImY/FaPRWyhvPu9BBxZNf8Iom3O8BC1bTjdwyoo3aFlDQm+BKRtRFUIs+wFO
         TORqi0BRvoOpPHdj/fnBN0bDkZQXXp9zDaqj4g1u3QfcdTxQljT72FkTcGFJ5F/ZDnMi
         9VYmEkd5OkqyX+TJ4a96D1QTEoaXP9t/BLoOEIOQ3rvl3yAIq78qx1vItlGN9ylfBOX5
         yU5PciVd5dDgcieVYqrW66SWjDaBkVZ3UoucVnLenVshJ/8V7ShRrYPxGCFgAbANp7eL
         t+QQ==
X-Gm-Message-State: AIkVDXK7jkpQb+ZuKzKOpunS7WGtT0Y0guwVbDExV1pblMRBq/Q0GF0zlkXKj8XBlcRZXtgfstmrpjcV5DY9paaq
X-Received: by 10.36.4.2 with SMTP id 2mr26493927itb.116.1486745046119; Fri,
 10 Feb 2017 08:44:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 10 Feb 2017 08:44:05 -0800 (PST)
In-Reply-To: <20170210155651.lecjrzmoux5mcm5d@sigill.intra.peff.net>
References: <cover.1486724698.git.mhagger@alum.mit.edu> <20170210155651.lecjrzmoux5mcm5d@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Feb 2017 08:44:05 -0800
Message-ID: <CAGZ79kak=j7u3N0WvUYwUwA-b+b=DNrMpG_iRHnd6ZLj4T2Q0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Store submodules in a hash, not a linked list
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 7:56 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 10, 2017 at 12:16:10PM +0100, Michael Haggerty wrote:
>
>> This is v2 of the patch series, considerably reorganized but not that
>> different codewise. Thanks to Stefan, Junio, and Peff for their
>> feedback about v1 [1]. I think I have addressed all of your comments.
>>
>> Changes since v1:
>
> I read through these and didn't didn't see any problems.
>
> The reordering and new commits made sense to me.

Same here.

Stefan

>
> -Peff
