Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A825FC433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 09:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiDWJUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiDWJUL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 05:20:11 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1985F5F48
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 02:17:15 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p62so10953388iod.0
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzCoD76g4zpFiqn2ZgjWM8bTe8HefvFVwKsU8bJ8dsA=;
        b=fuG90PNQyjjz41pjphdlxAMH+m/EvNJGq2re5nt9aXfWxHbDBGK9qmFYbN9YF92bp1
         ytte6sd6vY1YEn0Awd6Eb1w/y7KI7WWZSRgd3acxuGoe0+3ivq6b22UjS+g35dFvjnJv
         uyjf3j9ydQh7sEyPa0OKZ/fv0GiMrxATzp+ASJw7K2v/zUoj47t5tfL06kMD3O2azt/1
         5r50b/vPDS1LMxHnxgs8zfnKaMdgs8uqhEy81A4OYt+LxXcfPh/ZOrMk7/5jW+1ardBd
         9T1O4KQUovw9/P6htHuytuv/GttXm5vguXLdk8uF4hykXrFZ9jQjGA3R3doF++NbP4Ga
         YGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzCoD76g4zpFiqn2ZgjWM8bTe8HefvFVwKsU8bJ8dsA=;
        b=rJCjvNKdpos/6CfulZJGyFpW/B0Gccv0BKajCTwR57yHDzQYfwOFhDxTcwDW4yVhXW
         aRrH2uZR9brZBzmRMl8IVo1GaoXs6AI031CsX+NIhpwslrsda6Ijwrnjmp79PFlDE7Ui
         YtkMMuGJHPx6ennOg/+QIhveEcA7/uZy+OwXdFs0dxHGc56Ubm2hZtaxtdJpOKYGs/XL
         nVmj4Vu6gsI7HAhlzQA4yJAL4ddDts/xMVGD5GqC/gqyvrrjbRROQhyfutAjvhsnBCpa
         eZNtJm+8RsIM0qiGNkKQ2nh84YXSeG5Lziy+EhOFQXxHpp06vJQTtdeZ9zGt7UznEzrl
         /Khw==
X-Gm-Message-State: AOAM531ltkVJbDrlISu59fLPIkynrjaUY0bQzyCON85lqXJupTg8FzQc
        IqpmoJQd/9UDTFjdEIR+b1iHi+HarQm4YiWEgGORwFG+zT0Eaabh
X-Google-Smtp-Source: ABdhPJxVPw0uCVrpJYzbv3252Eu8GhwTfr9KvWUmy47MYErAmoO8Ngx1GmeV48YQe5/MM0an6Jye1awjNcsVfq3ymck=
X-Received: by 2002:a5d:9955:0:b0:63d:a8e7:538d with SMTP id
 v21-20020a5d9955000000b0063da8e7538dmr3745980ios.207.1650705434246; Sat, 23
 Apr 2022 02:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220422183744.347327-1-eantoranz@gmail.com> <xmqqsfq46b4p.fsf@gitster.g>
In-Reply-To: <xmqqsfq46b4p.fsf@gitster.g>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 23 Apr 2022 11:17:02 +0200
Message-ID: <CAOc6etYMyA3JWX7ZtvQoB2e66f7QVyabOrLTpwgP9XBRoipgfQ@mail.gmail.com>
Subject: Re: [PATCH v1] rebase - recycle
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2022 at 11:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> That way, you do not even need to add a single line of
> documentation, even though you still need to have tests.

Thank you for putting the time to think about it. I will take all that
input to turn it into a full optimization without user intervention
and see how it looks.


>
> The last thing I want to hear from contributors in the open source
> development setting: I'll polish it more if you promise this will be
> included.
>
> If it is NOT even interesting and useful enough to make you want to
> polish and perfect it, even when you were the only user, why should
> we be interested?  Even if your userbase starts at zero (or one,
> counting yourself), if you make it so good, other people will come
> to you, begging you to add that to the public tool.

That is on top of "let's fork this project"? That is saying something
:-D (point taken, just in case).

Given your feedback, I _think_ there is a window of opportunity for
this? Let me give it a shot. I will first try to create an equivalent
of this technique into a per-commit basis to make a broader usecase
and see if has an impact (performance or avoiding conflicts for
merges). Will let you know.
