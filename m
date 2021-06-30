Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC30BC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 11:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797FB61CB4
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 11:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhF3LEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3LEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 07:04:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B533C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 04:01:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g4so1522053pjk.0
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=03yNkKQf+q1yQZMJPzr56qA17MVEue5m5G6iVkQII7M=;
        b=RIOBD+GZNdrjsG5QMTsiiDqB5WV9Z99Chf3cgYAF9NpZ333zQh5sohsXcWlR6vf9Kv
         HfS8+zhYvVFgUt30ejNnFpbbP+gRMq+dnYvpPJEjHeDnPr1n22LtFYnr785koA175hH0
         4YSW3CBymZxWKTchNQm8NDdKn9TpNxNOCam9KAo8GGpoCB93sHG7YNNqVJSeighahJq8
         mFO2U1HvwxpWp2j0fak5vMPxNsBlvNFtq+1Vlrjv62uv3JVGGySaMP5wMuze0RjoMXCO
         PrD72jDyxTknYiDhBmYP4rPgIrvAn7HOa8Onj/LGi41QkFYN1DddzGi6IpkSq/3lexLf
         Hiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=03yNkKQf+q1yQZMJPzr56qA17MVEue5m5G6iVkQII7M=;
        b=pa0jFSj0F1tFkI4wuyio6itMi+UBmjCtGqA59TU0FRlZ/JzYtqESL2FfaklLH/y9JQ
         HfIuAne/teVGuWT26eLZvqwHgIep91GxKWZcFv0sbhVp+pK61QPgLCBYWGrVNzMz/92U
         q+JbreqSOq+Hiy7Je04GnKV0mh/nTBj0dKiT6B5s2bO+gAmsptaXr4XKbJ785m/qmovF
         /lDlDkeUPsDoPjVhZkbF3GouH37/yFz3EIMX7lT1j936Ywt5ri6ZrA13eQqKea9ebsvv
         Hh183DyZ/eQi17EKbRsRVqpM/jm9agPRu0OOD2wROD3wGFln7upQyNhsrWSTBYOjC1KR
         w6dQ==
X-Gm-Message-State: AOAM53089UqY77n6SrDo2FsgSN+c9ITnVM3yypW9xOleMIchHRrN0V0k
        0ey2ujQdspBmz4FaKSN6Khg=
X-Google-Smtp-Source: ABdhPJyq1Di86Sy+sTYV8O7XfvgwSbHPcASQvQcywd6xirt+FFKNCw1EtoFtlodrXtlgvniRP3CdaA==
X-Received: by 2002:a17:90a:fe08:: with SMTP id ck8mr3894566pjb.170.1625050900649;
        Wed, 30 Jun 2021 04:01:40 -0700 (PDT)
Received: from localhost ([2402:800:63b8:8e5c:5bd7:f8a:333f:cf5])
        by smtp.gmail.com with ESMTPSA id s126sm21287731pfb.164.2021.06.30.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 04:01:40 -0700 (PDT)
Date:   Wed, 30 Jun 2021 18:01:37 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 1/2] t6400: preserve git ls-files exit status code
Message-ID: <YNxPEb4V3SIqGRl9@danh.dev>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <cover.1624974969.git.congdanhqx@gmail.com>
 <49104273b8b801fc61811347120c5f4c42a3700b.1624974969.git.congdanhqx@gmail.com>
 <CAPig+cSKOzebGRyoytUGORhq56P0rijYrKO6uu7q7fWnzwiQkw@mail.gmail.com>
 <xmqqk0mcuw0e.fsf@gitster.g>
 <CAPig+cRu9Sh7gKi37Hj9nj+A0zZvmrrJgaVZepsD0Y-618tmvw@mail.gmail.com>
 <xmqqa6n8uipn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6n8uipn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-29 20:36:36-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > I may be misunderstanding your suggestion, but isn't the proposed
> > test_output_wc_l() function the same as what Danh had originally
> > implemented several re-rolls back (though he named it
> > test_line_count_cmd())?
> 
> Could be, except that I recall we saw extra noises like --out/--err
> that weren't used and contaminating the current working directory,
> which are gone from the latest iteration.

Yes, in v{1,2}, there's the extra noises of --out and --err,
but it's gone in v3.

I guess you're thinking about the contamination of $PWD iff it's not
a git worktree. That could be simplified by BUG-ging if $PWD is not
a git worktree.

Maybe, you're thinking about the extra noises to handle the failure run
of command under check? That could be dropped, too.

Would you mind looking at v3 1/4 again to see what is your opinion
there? I don't mind re-roll a same or simplified version of v3,
with s/test_line_count_cmd/test_output_wc_l/ if you see fit.

> The simplification
> compared to that iteration is quite welcome---it made the resulting
> code that uses the helper easier to follow compared to the earlier
> attempts.  But this round simplifies it too much and the results got
> harder to follow by burying the command name in the helper and made
> it less obvious that the last part of the helper's parameters are
> arguments given to ls-files, I would think.

-- 
Danh
