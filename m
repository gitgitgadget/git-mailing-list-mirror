Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DAAC1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 21:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGIVYD (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 17:24:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46087 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 17:24:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so254131wru.13
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1beadWDQZF6hwT73ShckfUaAghxdOfteBIeAMQ6YzKU=;
        b=OwfAbiUdhbgTdHRohfePPVjjlKQwmaglgPAnpn85xEtTPgLd+g7TWdNXHWGqSi0jen
         3KOVN5mfIy83C95qsaQhV0XXUxOaBgFWTVBfbeXX/IjGuEb/0Ja8S5qHDsZNEl939PHo
         IaiPllDnUl3O2JVLz529btKj4q1qqhonvg13QlJB760FD9pVDKJi8xNnROF0Cgt2NtXY
         Xihh/I7KXbfILZ2ks9QrXjw6C2LcZH6Slj8OylOa5BLvhLHg3c0Rge+DxbUSulaMddw1
         +F+u+afa0OU+u0Q+Q6x5bo9OZw5QKLh1YDWNupU5Kk/8B6U6jzEuNKkKfrroPNUqKeUK
         fj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1beadWDQZF6hwT73ShckfUaAghxdOfteBIeAMQ6YzKU=;
        b=ioUD45zUgcsAMO4wvqL4BOobszq5aQQWBms+wWTjykBe3rSzJxudQw3B19jhwpWC08
         5iwwFYNXj9SkpP7m/BtZvgZ1n+PVgsaNPrFB5dbWxVi+aJas7JyQgGKcmiEnB/gBRwXp
         bRSgs+wwZmVMDAtK0DAtILijuMVeCa217EPeDPuYgLYCkE8K0ykP/3dFKV6HI5y53Ii3
         AalJ4UdOc03QZXnRcGgCk7syk4u7kMtxP0M72RhsC8PFyR9bAL4RWI7M7AKCC64nAgYe
         gWQoxFCfI8F79Pdu41lSCQ9+HQUzHRo9ZAvv40dx26dPNaYLWjdHj0cVcsMdxLWmh8su
         dCdA==
X-Gm-Message-State: APjAAAX71m6jWm5BF9xodbEpueukRaOw5sp0+u1zGWNM8RZhf9q1/A+4
        l+9X0TssIEX+ouU7FqqzdY4=
X-Google-Smtp-Source: APXvYqzFN2ne3fraxOfZ/tvKyw6COiGfThgGXSU433SehRvXQkzRY1+oe1EKxyIVY20uEEbIhYsgLg==
X-Received: by 2002:adf:bc4d:: with SMTP id a13mr26254613wrh.296.1562707440653;
        Tue, 09 Jul 2019 14:24:00 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id f192sm252801wmg.30.2019.07.09.14.23.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 14:23:59 -0700 (PDT)
Date:   Tue, 9 Jul 2019 22:23:59 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/14] apply: make parse_git_header public
Message-ID: <20190709212359.GD15477@hank.intra.tgummerer.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190708163315.29912-8-t.gummerer@gmail.com>
 <xmqqimsbuhdy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimsbuhdy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Make parse_git_header a "public" function in apply.h, so we can re-use
> > it in range-diff in a subsequent commit.

Eek, I just noticed that I forgot updating the name here.  This and
the Subject should say 'parse_git_diff_header()' now, instead of
parse_git_header of course.  Will fix that in the reroll.

> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> 
> Thanks for these refactoring patches on "apply" machinery in the
> early part of the series.  I noticed two small things, though.
> 
>  - The apply_state instance *does* represent a state and various
>    fields get updated as we read and process the patch.  The smaller
>    structure you invented, on the other hand, does not carry any
>    "state" at all.  Even its "linenr" field does not get incremented
>    as we read/process---you create a new copy to take a snapshot of
>    the current state from apply_state.  parse_git_header_data may
>    have been a name that reflects the nature of the structure
>    better.

Yeah, I think that's better.  Will change, thanks!

Maybe it would be even better to name it 'struct gitdiff_data', as
it's really only used for those few functions?

>  - I wonder if it makes the concept clearer if you did not create a
>    new instance outside the apply_state, but instead replaced the
>    three fields in the apply_state with an instance of this new
>    structure.  When you call an API function with shrunk interface,
>    you'd pass a pointer to a field inside the apply_state instance,
>    instead of copying three fields manually.

I had considered that.  However I struggled to come up with a name
that makes sense in both as an interface to 'parse_git_diff_header()',
and inside 'struct apply_state'.  'linenr' is not specific to parsing
git diff headers (or even parsing any type of diff header), but is
used all over the apply code.  So 'parse_git_header_data' doesn't make
sense as a name anymore (and gets complicated to explain to the
readers of the code I think).

At that point the name should also be <something>_state again, because
we do update the linenr inside 'parse_git_diff_header()', just not
inside any of the 'gitdiff_*' functions, though that is only a minor
point.

So unless there's a good name for this struct that I couldn't think
of, I think it's better to pass in the variables separately to
'parse_git_diff_header()', and then pass the struct just to the
'gitdiff_*' functions, as it's done currently.

> But other than that, I think these patches are generally moving bits
> in the right direction.

Thanks for the review!

> I do not have strong opinions on the later part of the series on
> range-diff proper.
> 
> Thanks.
