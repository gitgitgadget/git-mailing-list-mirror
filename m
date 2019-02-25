Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F1A20248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfBYVEi (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:04:38 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33533 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfBYVEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:04:38 -0500
Received: by mail-ed1-f49.google.com with SMTP id c55so8846228edb.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRUqX2XO9RLW886MOc/2ZLkWvdC3uNYzCUwcLIo/3+w=;
        b=YIXA4737G/dIiACqWBt+GXR1s/Do2mgQdYNUfL/NW30UKAnodpgCH6M+7bBLhIvbvU
         iiGvTcmNYVcbkF/19iPr98/kOc5OKT34Pt5rwMa9ydYRV+OrKE1JZdgN+A1IKMDSDzg9
         22xp2GQtMRF2d0M8hjoAC+uFXdyssugULBQLCJYgnlFlx/z5CTjFO6IDG3dU7CNOBTyF
         wx5lEuKQ5/xO7tXY8xQ/UMeiC6jcmHP6OZK6YLmfUfSxIdbmztAJamcehTkMCtEGA1Dt
         iUPEvDBtJl470e8s5OKPBqxRt+mn86PU5djqECdAjRW//uP0JRSLkO54SPuZsdSnMQQz
         P72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRUqX2XO9RLW886MOc/2ZLkWvdC3uNYzCUwcLIo/3+w=;
        b=H+ODN3kAv8uTv6YFGEPaiRZnpDUVtvTzWUnkqi5KU1ArjAh3dBjjTK9pnX1XxV+RHl
         pscSF3YmRWNowxA10M4mc1x+OmmfHOzFmOnl+yX2niETGUDqZv4NcORxJnT9fjLB619j
         dBs23m5rN3UVgALz2WsIc5rWNqzYnMc/6+w/7oZczxoi9hlsBS2hZJYBRKIlfeb3gDA5
         uZN9brUPSckJTU+RKRKz0mYEyEJ91aPJyAmxEQpMAqKMfSwHBJf4Zls1rS8vviZuNAnT
         3xNFFJOmyqGmHhSXczedrHxgzDkmoaIFsLAONuQEB7FSS9B5GoOKw7W0e6LWgrpobNbl
         9T7g==
X-Gm-Message-State: AHQUAuaJutOvBzb3Bt/9ZGxbedrPY7Ie8ogeymNUYwYu8AtFpG3jr+Li
        DZxdy6ZANivJ0eflUKqvhUo7mwzLVrNowwJ6H9I=
X-Google-Smtp-Source: AHgI3IY3mliaJ8FlVbpni4O3+cwlgPsWsZS544EjmFmItYQuk4x+F1HvVkt6bDPjInHxVEpVcQ49HzGrw3xnRWFYe0k=
X-Received: by 2002:a17:906:4893:: with SMTP id v19mr14154007ejq.196.1551128676143;
 Mon, 25 Feb 2019 13:04:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <aae0f669627d7be45a967c6df464bf1ecdabce6d.1550963965.git.jonathantanmy@google.com>
In-Reply-To: <aae0f669627d7be45a967c6df464bf1ecdabce6d.1550963965.git.jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Feb 2019 22:04:24 +0100
Message-ID: <CAP8UFD2RBU+f4=pB4CZHPHVO3DKXdGXVen=x3a8GvQHhGBG3aA@mail.gmail.com>
Subject: Re: [WIP 7/7] upload-pack: send part of packfile response as uri
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 24, 2019 at 12:39 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Teach upload-pack to send part of its packfile response as URIs.
>
> An administrator may configure a repository with one or more
> "uploadpack.blobpackfileuri" lines, each line containing an OID and a
> URI. A client may configure fetch.uriprotocols to be a comma-separated
> list of protocols that it is willing to use to fetch additional
> packfiles - this list will be sent to the server.

So only packfiles will be fetched by the client using those protocols.

> Whenever an object
> with one of those OIDs would appear in the packfile transmitted by
> upload-pack, the server may exclude that object, and instead send the
> URI.

Ok, so each URI sent in the packfile corresponds to exactly one
object. And when the client fetches one such URI it gets a packfile
that contains only the corresponding object. Or is there something I
misunderstood?

> The client will then download the packs referred to by those URIs
> before performing the connectivity check.
