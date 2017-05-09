Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84C22018D
	for <e@80x24.org>; Tue,  9 May 2017 02:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbdEICLY (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:11:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35276 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdEICLY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:11:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so11909113pfd.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1fkrOSOIYH85Oz4epMopkNGBaWtw5ITgVOV0JVnid30=;
        b=sYCqq/zV2c10wUPscuuWtdWbTkXBYGHUDs6ZAZq5xlke5/y1hFB5hTvgY4R51Pac7L
         hLXe0EOMkVIyOmHyOzLNYA4PpbR2NyDP5uT5F0ChZBIjWHkZQGJuKGmnqJws5dSnF8pg
         bdRynjqvl8U+DEzCNVNYxQBqjWs+e+6jY2Y9APWSyee1A/UjMj98p9X88MoUk8e9JOYD
         80gmL7WQnOmWWphOpUPpmfPVhLHyQ8BLzWY5PNpjuHMsYWx2ijFjcRqUHvTXP6j9RTvS
         s4nZj10R++V76QMfzFOws8DUNDxBLsPQRgBuwK9WyKtPmu1KeKrN4CwQ9nIc/IXAV0QP
         LGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1fkrOSOIYH85Oz4epMopkNGBaWtw5ITgVOV0JVnid30=;
        b=R1O47vxoknKBU8DR+RXhYIkNn0hOuWiln8f5R8jUw9SpIG/oKK779Svi+bJ7FZGEA6
         SrWIOW+gtd/pwNCeswLRWnHS7aZ3RxozamTMlxL2hamzukV3SKMuxDdWAaaq99FrOxWe
         bUK4qi9XXHtjbCYRQiRaayvHg8KxlllJFxn9rDC0eG9r9aSOB3UlGdRAjWVjzFhklwG6
         3WiNeGNiWsSiLGdld2ndv2f6j4Cu63N1YpROiU/6ZNk9MzHHqGDAAF3r7cm7CHdVjPsX
         R4Ib6ot4uOMiw9jcSO6ox7fv3aGKVzCj7omFlQSVscD2upiFOrFIX/LQHeuvwU5rbhWw
         Dk4A==
X-Gm-Message-State: AN3rC/6JGs7FeoWTsN/SkGBu4ItPvMcf9YsRabGvwB1bDbBRs4I+PA9z
        /HhfeWQx6Eb+BaDn8kwR9g==
X-Received: by 10.84.208.236 with SMTP id c41mr35989443plj.95.1494295883371;
        Mon, 08 May 2017 19:11:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id c12sm28657154pfl.79.2017.05.08.19.11.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 19:11:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
References: <20170414203221.43015-1-git@jeffhostetler.com>
        <20170414203221.43015-2-git@jeffhostetler.com>
        <CAP8UFD2v8R8bSjUi8+1271fJ=jR5JbbGfgO_fdeYpzE=EGx_Pw@mail.gmail.com>
        <962eefec-2ea6-6b43-7bd5-51da4150bb6a@jeffhostetler.com>
        <CAP8UFD1dR1QY81tCAcbB6RP61vBxXy-u8zFAhLpk9uP71Jna-Q@mail.gmail.com>
        <c9f77c02-c498-1b0d-26c2-27d6f576ee71@jeffhostetler.com>
Date:   Tue, 09 May 2017 11:11:22 +0900
In-Reply-To: <c9f77c02-c498-1b0d-26c2-27d6f576ee71@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 8 May 2017 16:18:31 -0400")
Message-ID: <xmqqk25q6aph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 5/8/2017 4:03 PM, Christian Couder wrote:
>> On Mon, May 8, 2017 at 6:50 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>>
>>>
>>> On 5/8/2017 5:45 AM, Christian Couder wrote:
>>>>
>>>> This test does not pass when the GIT_TEST_SPLIT_INDEX env variable is
>>>> set on my Linux machine.
>>>>
>>>> Also it looks like you sent a v8 of this patch series with a different
>>>> test, but what is in master looks like the above test instead of the
>>>> test in your v8.
>>>
>>> There was concern about using sed on a binary file not being portable
>>> and a request to change the test to just corrupt the checksum rather
>>> than an index-entry, so I changed it in v8.
>>>
>>> Does the v8 version of the test also fail on your machine ?
>>
>> The v8 version of the test succeeds on my machine.
>
> OK, thanks.  It worked on mine too.  Since the v8 version is a
> better test, I'm content to stick with it and not try to address
> the problem with the previous version.

Thanks.  Let's merge that in.
