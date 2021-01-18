Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54501C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A09227C3
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437037AbhARTSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437121AbhARTRj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 14:17:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87931C061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:16:59 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c22so11467909pgg.13
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:subject:from:to:date
         :message-id:in-reply-to;
        bh=p8YnxgPbKQ2gySl7K/yHVnYWdii7qZNtEB/6ioDZrAE=;
        b=VxqBDv70gSZuEu+iL3vp/82rr2rcGl//crN1dT257QT70rdOPZWhXAZBZvUz5IQnbm
         HAQ8Oh8qDdZ58kYbMiyKZ2yAH+JUYwPv+xPtPwBeAUDJ4W4HKMF4gF9H9TF4MfsCS2Pd
         h7bCcpjKx/vqgfbEJZ9yuMOA+aYz2A+WZ2Hm8biIQTr5wtRqNam+R9S4pxe0Y24EsZEG
         JfqrLLojUbIBirucyuP8suj1XUlnKZ1frhJaYYV8HowDaVJ5WEeI3sJLh1pYqlsERSW/
         XE1ctvzG7Lly0bEICcToR4D/dUAAHG53A8tIFs3yIULVGss88fTb2cUdCTQco5wVwVW5
         ud2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:to:date:message-id:in-reply-to;
        bh=p8YnxgPbKQ2gySl7K/yHVnYWdii7qZNtEB/6ioDZrAE=;
        b=bu8b1fr0Y31XaWl05+P4KbLs79GojPoU9rRCn6qGRfuXb+jlVXukr8igDz+tIhtPuq
         nlkKbmt6ZIPhJuGJ3B5pMEVDhnBY/R+KGK5dHNvoGnuuWMaqFRYKCCwVz2fEMyiv+PWj
         jFqWcY8QUhN3ElCJ/NurygTjcAjCBbLrnEcqR3IoZ8V8QutkRqsvrfGUXe2f380ulM53
         le7c7UMskM6UWo6YQmZzpAyBjfs797viahgSqEO/1DmKZZBVAoUu14yfJiU19EihldTh
         q98Jt+XltFa5EDEOPZK9J5AC23A4GurCodop+vhDFc52gFe+MWeZoIHDjV/al/HEbS+3
         LVYw==
X-Gm-Message-State: AOAM533rq4nBnyPRyJ5hjlgSEO5fBlNe8XglR9ylyLVzDoOS2BJhrl44
        z5J+68ZH4Sem/pVOgY5X5iVY4jcsWM7OAQ==
X-Google-Smtp-Source: ABdhPJy++ks/RktWkvimG42ecaIzvK98367j707XpdyfFkN4c4vXX2euJCnaB69r1xYV53YhIJ2zWQ==
X-Received: by 2002:a65:5283:: with SMTP id y3mr1090357pgp.174.1610997418828;
        Mon, 18 Jan 2021 11:16:58 -0800 (PST)
Received: from localhost ([193.37.32.44])
        by smtp.gmail.com with ESMTPSA id x28sm16312475pff.182.2021.01.18.11.16.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:16:58 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: DEVEL: Help with feature implementation
From:   "Aiyee Bee" <shane.880088.supw@gmail.com>
To:     <git@vger.kernel.org>
Date:   Mon, 18 Jan 2021 19:15:43 +0000
Message-Id: <C8MIWAN0N50F.235740W7QGT05@localhost>
In-Reply-To: <60516c8b-adc0-18a5-ac26-b147b1857016@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio and Derrick!

> I think what you really want is --full-history --simplify-merges [1]. Thi=
s
> will show the merges that "fork" the history into parallel tracks where
> at least two of them contain interesting commits.

It doesn't look like the implementation of --simplify-merges helps much
here. That makes its decision on basis of the parents of the commit, which =
is
simple to do as it's information attached freely to each commit. I think th=
e
problem here would be figuring out, given any commit, how many of its child=
ren
are "relevant" commits.

> I'm actually working on something that does the opposite---it ignores
> the fork point when drawing the graph.  (I'm currently dog-fooding a
> partial implementation of this.)

That's a pretty interesting coincidence :)

Just to throw ideas out there, maybe we could attach another commit_list,
children, to the commit metadata, so that all this becomes a little easier.
But I guess that's be pretty impractical and inefficient.

Maybe a more practical (but still pretty unusual) solution would be adding
counters to each commit that tell us how many times they have been traverse=
d
Through various histories?
