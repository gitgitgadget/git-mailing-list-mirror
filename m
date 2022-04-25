Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3CAC433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 09:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiDYJtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiDYJs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 05:48:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380716559
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:45:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c23so25803591plo.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D4xEMoBxHNKX9Ft+9r0RWnEGFN+vDMhu6pprGatFYBA=;
        b=iR+aSBJ5KoGcyqAFbLqOPeIzKildWOwn9NqVJ5QcXRpilqe53lwwCsAbXGGTuWbUBa
         BBk6tX6YbNO6AXucGjs4EWKaHHXgZ+/+cEqwUYfdslKac45Owm2elGDq4ICtREH1sAsp
         4vhUiO4c8F9BGQDiCDmO12Ejxfq1Y02auhWreNyTlOm5ho7Js2uUzAFznnH40uPOcZDq
         2mGFCpJGifQdCCUuzCCeo1iQw0GLyU/RBYpQ5cjC6V9WD63HWlQPOhtWV5lXWi5A+HAS
         MGQjfj+ExryTBgkhtUMyqcnbAaRzSTJ9SWQgM9igbJfJssoIyk9IksPnaa9IcAVOrIEC
         dYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D4xEMoBxHNKX9Ft+9r0RWnEGFN+vDMhu6pprGatFYBA=;
        b=UZrnrRpKbuP1swvoI6XEGII+jTV+nh9u/DQ+4wjjQLHu3Liw0pt3e134cwfDsStRWP
         PSuyiPDpdSrqbvtnUI7eESDWHbzy/MOrxEFwBsxmOsKzN3yRqyBRRmRO6CGQ3dosKP1o
         zUFref8wcevEdR6iWJhP6MyWRzYKk1iqVyFDUjVJL6qYJw5LvGf0TJFHXBZlTrTa2Y57
         1930pFwo/jNEh2f/+QnrdhWHoT5CJHrskrktUuSmhMfAEK9FlKivRrqvIijnuapAj+r/
         gtBpkAI6oa9n0sqWZkYvFZsvePUJEX2MyESM8hcjYW3F2D/Z4ciFjfMnXEHlY/R8hMjG
         2Orw==
X-Gm-Message-State: AOAM531w0Kv3bC2+DjZJWT9HKvHnvCNH+EN4z32u9AlHRHyipSxu6Eb+
        BNYwQzvmwX1ZEMmd6TqkGUP9xSqu8UJ04p0RV10=
X-Google-Smtp-Source: ABdhPJzrcxC3li7OAHKTgIKXpB/6uikpA9SchX6S/G8H4GBYl+dcqEXXqJcX88nXVvWbIkh/b7kSvA==
X-Received: by 2002:a17:902:7001:b0:158:43ba:56cc with SMTP id y1-20020a170902700100b0015843ba56ccmr16539143plk.135.1650879954595;
        Mon, 25 Apr 2022 02:45:54 -0700 (PDT)
Received: from kong-HP (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a001a4a00b004f7c76f29c3sm11169279pfv.24.2022.04.25.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:45:54 -0700 (PDT)
Date:   Mon, 25 Apr 2022 17:45:50 +0800
From:   FanJun Kong <bh1scw@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: help for git format-patch lost diffstat
Message-ID: <20220425094550.e6vw6xwtk4dcstyd@kong-HP>
References: <20220424064114.nwzldz5s2bnkrlu5@kong-HP>
 <CAPig+cQsGZ5Uw13vr5r_SZ9APZwovtxSW5N4QGpieHRx1_6zRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQsGZ5Uw13vr5r_SZ9APZwovtxSW5N4QGpieHRx1_6zRg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 Apr 22 ◦ 04:09, Eric Sunshine wrote:
> On Sun, Apr 24, 2022 at 9:00 AM FanJun Kong <bh1scw@gmail.com> wrote:
> > First, I created two commits to a demo project.
> >
> > when I use command:
> > git format-patch --cover-letter -1
> > [...]
> > FanJun Kong (1):
> >   First commit.
> >    1.c | 4 ++++
> >    1 file changed, 4 insertions(+)
> >
> > ok, you can see the cover letter has diffstat, just above "--".
> >
> > git format-patch --cover-letter -2
> > [...]
> > FanJun Kong (2):
> >   First commit.
> >   Second commit.
> >
> > Comparing with last command, I just want to get 2 patches,
> > but this time the diffstat is missing.
> >
> > I am not sure if this is a bug or I miss some options.
> 
> This is expected behavior according to this code in
> make_cover_letter() in builtin/log.c:
> 
>     /* We can only do diffstat with a unique reference point */
>     if (origin)
>         show_diffstat(rev, origin, head);
> 
> The problem is that when you format both patches of a two-commit
> repository, `origin` is NULL because there is no commit preceding the
> initial commit; the initial commit is the root of the history. Thus,
> there is nothing prior to the first patch against which to create a
> diffstat.
> 
Very clear explanation, yeah~
> I have not investigated, but it may be possible to teach
> show_diffstat() how to generate a diffstat against the "emptiness"
> preceding the initial commit, but nobody has done so yet. Perhaps this
> would be a good project for someone interested in contributing to the
> project (or perhaps not -- as mentioned, I haven't investigated how
> hard this would be).

From my point of view, it is a bug, but it doesn't affect too much.
I agree with your suggestion, this is a nice chance to learn how
to submit patches to upstream.
