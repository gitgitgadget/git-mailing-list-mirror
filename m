Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994271F991
	for <e@80x24.org>; Thu,  3 Aug 2017 22:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdHCW0o (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 18:26:44 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34227 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdHCW0o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 18:26:44 -0400
Received: by mail-ua0-f172.google.com with SMTP id q25so252764uah.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qONGEBpnn0sIkWMHDhfdiMO3Lct0LeLVOeCJhPTVzKY=;
        b=cZ9VwwIGHazYubrCOpRAccbbuSQvfmTO/exF4VuiWdphdjb0XCHMJ7z0XCXWMfEktO
         7WT3vzjCZ9t82mWHwXEmPGbtQ+weHANIzLympkRzzO2n33PTuwJI0XUzZkWN6LjLYK+U
         KDx1EzWhXuykj6cNbeDlMkZY4nEFcJUCh/qDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qONGEBpnn0sIkWMHDhfdiMO3Lct0LeLVOeCJhPTVzKY=;
        b=F8pDjUDtEsGUGmc5Odnb1oZ4UJOUkIuFv+0yHNwBRKyl17Q/nMUofeP26z/Rnjtp+o
         kzYPz4ggJHE2frhN0X90ZffhqzIYuqPU/RmmQkJ6uOJ4wR4xamAW0Gclctu6+hx05A/M
         gqBng7+yvx6TiHWUf3dWcwmtWBjYQBrjntDfR7p26DWQdiu5M2dLzmULYypJ2c/PeKSp
         LUoE7JiH+N24Xx64glPqyBGxDtyqT/1tP2LcxxRvuBBNihghDzSY1NnH993/4YnEgz2t
         dN257rlDzm9Xq4w+kBAUL/0fHRMeeNbNyrxmFprUfUONeOzItl33PoVv4a8/cn5rRZ3l
         NQDg==
X-Gm-Message-State: AHYfb5iO423eYKOigpBoOyxrlu38127T4zKHBwBcPQ4jPGw4PFHyLPmF
        5uV2j4FGD1kJH3KS/WI+gW8hUbO0JCLUpns=
X-Received: by 10.159.49.78 with SMTP id n14mr223857uab.197.1501799203166;
 Thu, 03 Aug 2017 15:26:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Thu, 3 Aug 2017 15:26:22 -0700 (PDT)
In-Reply-To: <CAMy9T_G5xorPGp=5=p_ku3RhB1E-c9+4mEgYhbyAhLdc1V=JBg@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
 <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com> <CAMy9T_G5xorPGp=5=p_ku3RhB1E-c9+4mEgYhbyAhLdc1V=JBg@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Thu, 3 Aug 2017 15:26:22 -0700
Message-ID: <CAJo=hJvNgX06gkXp2Vsx=cSkcxRO9aRzOit6vvi4fqL3QeDsEg@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 11:38 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Tue, Aug 1, 2017 at 7:38 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Tue, Aug 1, 2017 at 6:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> On Tue, Aug 1, 2017 at 4:27 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>>> On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>>> [...]
>>>> A couple of other notes about your contrasting design:
>>>>
...
>>> OBJS blocks can also be
>>> unbounded in size if very many references point at the same object,
>>> thought that is perhaps only a theoretical problem.
>>
>> Gah, I missed that in reftable. The block id pointer list could cause
>> a single object id to exceed what fits in a block, and that will cause
>> the writer to fail unless its caller sets the block size larger. I
>> basically assumed this overflow condition is very unlikely, as its not
>> common to have a huge number of refs pointing to the same object.
>
> Given what Peff pointed out, let's just leave this as a varint for OBJS blocks.

We discussed this at $DAY_JOB yesterday. We realized that if an obj
block has that many ref pointers present, it may be more efficient for
a reader to scan all references instead of chasing those pointers
individually. Latest draft of reftable now omits the ref pointer list
in an obj block if it exceeds the obj block size, which only occurs
when a high proportion of the ref blocks contain that SHA-1.
