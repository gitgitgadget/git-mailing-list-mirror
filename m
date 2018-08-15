Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C06D1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeHOTK3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:10:29 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43686 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbeHOTK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:10:29 -0400
Received: by mail-wr1-f41.google.com with SMTP id b15-v6so1582175wrv.10
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0YLeHwIWeIh9uwiRUqHxUJl2ZNlDsLsAIon/8D7GjOQ=;
        b=kv8hMIpuvDrUf2q1lHq+55D6TCHPrNjx20SpuN4A1BwlUWM3wEmjld6m08aR5F3le9
         SvHNllWqBMH9z5gMZlld18wJVfU6tvdYD+Ix54ytUmGocB0HjA15JkKRdV0iYNEa0VnW
         kHwUuFaHlvWY1mh2NGoChUf5zz8beSmSQumRnM3n6gsjeVVlsn2LJm5Dv5/VPbdezli9
         lC2IRGewt1YdMDI4OQS3g7rfG+SprfjwgsJx5Sc7J2czPyuZAHgfUePZFthE9X0T56Q4
         ZqNSLR1ujN3N0pwu+1Ne6rbhxOQhxiN9imirHi1+ehIuDGU3QWtYKKRXZNmIr8uVv3Hh
         /Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0YLeHwIWeIh9uwiRUqHxUJl2ZNlDsLsAIon/8D7GjOQ=;
        b=PNkTnuPi9TaZIXa0NW2bo+d31WzmqINfqWZm9bRhSr36qbFlpma9F/CyMMyrjZFHZ2
         TbJe7c68fT0nKiaVgWBlgYgNtVb2ZprZccPunF66ywjZTihrcBllltRGOG8WAYVByzw/
         WzwsE+DEqTYzM6zF+DT+Gmy7E9OjL2E8yEJZSFGAan7kwaM2oQRQlHO8lCVoeQiIGexH
         PwGrQDyz9uERqCoJBmDfDMZqpu36udEYgOlANOIRCT8OZD1ULIfGkXznhKFaMkDwxQ9y
         enpMaE2BcOgb7k3vEj712llVNKkLqhBIFkiE/q1tV75C30oPhPR8kK4bmWKXgakjYxrh
         QBSQ==
X-Gm-Message-State: AOUpUlHLUyJ+w75wcnTN3xD0N/6/YL1GwElD3GHx9lag4G0C3NT1LKGZ
        xZI2XS6AwbuugDHkxB/6Ni0=
X-Google-Smtp-Source: AA+uWPxxg7/SjNeGU/2e8YBryjgssHsTyXG2c3RAHQfPUG0Wz81Rxgz97WI6uPpGR14tgjgkgWUeDA==
X-Received: by 2002:adf:fec8:: with SMTP id q8-v6mr16223318wrs.164.1534349860701;
        Wed, 15 Aug 2018 09:17:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h5-v6sm24101393wrr.19.2018.08.15.09.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 09:17:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
References: <cover.1533854545.git.matvore@google.com>
        <cover.1534267611.git.matvore@google.com>
        <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com>
        <20180814200154.GF28452@sigill.intra.peff.net>
        <CAMfpvhJM2hUXTfTgY9jA4aB+bgx44xbCktCacpy_yWacyjk00w@mail.gmail.com>
        <20180815012224.GA4745@sigill.intra.peff.net>
Date:   Wed, 15 Aug 2018 09:17:39 -0700
In-Reply-To: <20180815012224.GA4745@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 14 Aug 2018 21:22:24 -0400")
Message-ID: <xmqqr2izk3j0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right, I'd agree they probably want the minimum for that traversal. And
> for `rev-list --filter`, that's probably OK. But keep in mind the main
> goal for --filter is using it for fetches, and many servers do not
> perform the traversal at all. Instead they use reachability bitmaps to
> come up with the set of objects to send. The bitmaps have enough
> information to say "remove all trees from the set", but not enough to do
> any kind of depth-based calculation (not even "is this a root tree").

If the depth-based cutoff turns out to make sense (on which I
haven't formed an opinion yet), newer version of pack bitmaps could
store that information ;-)

How are these "fitler" expressions negotiated between the fetcher
and uploader?  Does a "fetch-patch" say "am I allowed to ask you to
filter with tree:4?" and refrain from using the option when
"upload-pack" says "no"?
