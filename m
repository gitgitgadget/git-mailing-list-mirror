Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12922C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE13F61059
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345101AbhERGJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbhERGJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:09:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909CEC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 23:08:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h4so12401595lfv.0
        for <git@vger.kernel.org>; Mon, 17 May 2021 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t434z9Vlmks9H2XaJk9hjtzRAFHebG6ayH4XBL8ITVY=;
        b=s36rc2b4CjYz1sPdZ3eG7SONWZryEuVuxTsTWev0RcLO20AEbDU1IIcr00Oo3EVx3F
         9fSIjriYWUwNLhsvOeAcEhY8IR1YUxMDGbNXi2JQJjCZhsf+kOsFC0HTEHpL3OXiJH0+
         laEQYerj+C7Rk29CnZIm2I5OUjXsNNVWYOon0lwSvbdVXd9ubdTzEiQYPvYM4IUUY7xN
         peCrwwuzpT0zXd5VL2pjaB6qqFGuIJypNmjb8M9EsgJ8YfVon3E54qUu/n8u+7FNB02U
         p6NQJHtfVGh/DcTtRVDoOgVK2dApRUOg1zhs0y2AICpMLMA141v+6kZwBnznwa93z56B
         n/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t434z9Vlmks9H2XaJk9hjtzRAFHebG6ayH4XBL8ITVY=;
        b=mIvZzqdCtJQXGb0vJUgoNiGlBhns6laDZOp9NgEn5IG9eKM9FqA65flxqpeb6HGkyL
         hRf5m/EG9OwWT8sQ2EsMO+vZf+upHtRLvtpJAb1CAX7MD5bARrDHHFAkn9/mT0CteKI+
         C3qzOGNp+r8fkuMvI54Bta975sR4Tmd9jmoGOSQkEobyel+Qb5EkoO85pYQNVAr7ilpJ
         FBnfURReb8SDPb+HSu33od1tYYa8K7YQcBYqIgLSN2sSaCcbybgLUIOpigIqXZXtq9BH
         rQV5XC/UkCYdE+q3efvZpdL/MzmMQj5+hYjmbwsILXYfE2pfnO1H7+XVML3pATyZqzO2
         /s3w==
X-Gm-Message-State: AOAM531K7I1neCcuU4S5bF6mGTjZ1cVbdm23j3gEvnbqSG142+7w6fNw
        KeFTAIGtH6RbhKn9XsDDUBdEu5WsUX4WhJxLWQjQf5ZaSLw=
X-Google-Smtp-Source: ABdhPJwsMcDKc5VoD/6h3EWpc8/YQNTb8CCZ77fVnPFksjGG+p+lngxled8jJindW09FCMjlYskCitQaQLB1pQPyNg8=
X-Received: by 2002:a05:6512:c04:: with SMTP id z4mr2888655lfu.167.1621318104043;
 Mon, 17 May 2021 23:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210516215704.32440-1-alexhenrie24@gmail.com> <91d3d4e7-a04f-3fc4-a97b-90af02b20ed5@gmail.com>
In-Reply-To: <91d3d4e7-a04f-3fc4-a97b-90af02b20ed5@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 18 May 2021 00:08:12 -0600
Message-ID: <CAMMLpeS-Gb1QPZaUQsafy-rpRuDi4-hVpJ8JO-vu2SaXTZyqGA@mail.gmail.com>
Subject: Re: [PATCH] stash: don't translate literal commands
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        ungureanupaulsebastian@gmail.com, t.gummerer@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 10:48 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/16/2021 5:57 PM, Alex Henrie wrote:
>
> >  static const char * const git_stash_clear_usage[] = {
> > -     N_("git stash clear"),
> > +     "git stash clear",
> >       NULL
> >  };
>
> Are there other instances in builtin/*.c? If not, then it
> would be nice to say so. Otherwise, it would be good to fix
> them, while you are here.

I reviewed all of the translatable strings and only found this problem
in graph.c and builtin/stash.c.

-Alex
