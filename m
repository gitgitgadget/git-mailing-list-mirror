Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042512023D
	for <e@80x24.org>; Tue, 23 May 2017 02:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965604AbdEWCoR (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:44:17 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34641 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965601AbdEWCoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:44:16 -0400
Received: by mail-io0-f171.google.com with SMTP id k91so89288317ioi.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=++Z2Iujo0H2xSKQb/wcuzdRf+Xw9g6RBf+vh9HlFIGQ=;
        b=mXXvmdOeipXl1yzZgOWkOZ7WwUsY86joNOPkYn8TJAffG+CtK2EELgatCRw18y0isU
         Sr2x0lZrLTOCqxcZXRr3s0B/f+y/pfIw63HHB8vDPNQqfOZiyEqk6W/JJcC4V+Wmxxz2
         plxEY4gIlhk4OM8BkDJK1Q5tLj+FeYW9uj5JcILVx0/mloZUQlgZBX2QtD1dDUJ3jfbS
         Hli4DZZ8lgoipK2mSY8PRVOPo+LD2mG6eT6El6mtuY94G8YqsS/KR4sZae4n6MQji9QD
         gB8g8o84pLnaHqCwlbsdVQhHjYGvmKDtW8AV5Zw1LiOg6KcAjHH/rYj40JRojsjPFpAR
         VO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=++Z2Iujo0H2xSKQb/wcuzdRf+Xw9g6RBf+vh9HlFIGQ=;
        b=HLQqorpO37JvSaIlVhECFtuHbKU9NDFLSb1VPiQsG8QC0QB2M4yQVQWVDPFDPo0W5L
         61T/v70Bx2Rwxd4caDuEkQiaqOYKHYCAKsOD8h24ujus2dCMkKiCxF04ZAfWocH/nOft
         psbHpy/BkKxXPITusCoFlRknvjmb49XwjNjhpE1zZhKZKymBfPL7XBM5e+FiyNvddORj
         d3kpr2IYtUa7Ni2s4lUUyq2pLhJlHVRavFOIlv39idQOIvCinSec4C1+0fjxB8yBF15T
         kZa659XQZ4WFstgxo3i1CWphVYxBqONUsSWqCKlFLy6XW9C31bHNlYjSMiqqRimuD+nG
         5Ylg==
X-Gm-Message-State: AODbwcAfsTnsTT4wlntHZLzxK9vNiZKdneMBuFLvcqGtHhwpmD166JEJ
        eEB1k+sSNzN2LtZCDrjsWbB0nkHuzg==
X-Received: by 10.107.35.75 with SMTP id j72mr23642525ioj.180.1495507455398;
 Mon, 22 May 2017 19:44:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Mon, 22 May 2017 19:43:34 -0700 (PDT)
In-Reply-To: <xmqqk259o1o2.fsf@gitster.mtv.corp.google.com>
References: <20170518082154.28643-1-sxlijin@gmail.com> <20170516073423.25762-1-sxlijin@gmail.com>
 <20170518082154.28643-7-sxlijin@gmail.com> <xmqqtw4do5tf.fsf@gitster.mtv.corp.google.com>
 <CAJZjrdX9BnuxY3tmpswG+yEdDm1+AR8rc5wKGZyVCMp-jP218A@mail.gmail.com> <xmqqk259o1o2.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 22 May 2017 22:43:34 -0400
Message-ID: <CAJZjrdVeGy6mgsjuHL+O29xys8z90J8aKXdZ5XqiNraNZ9pQfg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] clean: teach clean -d to skip dirs containing
 ignored files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 2:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>>> By the way, instead of putting NULL, it may be easier to follow if
>>> you used two pointers, src and dst, into dir.entries[], just like
>>> you did in your latest version of [PATCH 4/6].  That way, you do not
>>> have to change anything in the later loop that walks over elements
>>> in the dir.entries[] array.  It would also help the logic easier to
>>> follow if the above loop were its own helper function.
>>
>> Agreed on the helper function. On the src-dst thing: I considered it,
>> but I figured another O(n) set of array moves was unnecessary. I guess
>> this is one of those cases where premature optimization doesn't make
>> sense?
>
> I actually did not mean to give the variables more descriptive names
> and preserve the original 'main loop' (namely, not adding the "skip
> if NULL" which would never happen in normal case where "-d" is not
> used without "-x") as "optimization", whether it is premature or
> not.  My suggestions were purely from "wouldn't the resulting code
> easier to follow and understand, leading to fewer bugs in the
> future?" point of view.
>
> As I said, I am undecided if the result is easier to follow than
> your version ;-)

I think I'll defer to your patch: I do agree that your version is
easier to follow and understand. Should I reroll just this patch and
its commit message, or would you prefer to handle that in the queuing
yourself?
