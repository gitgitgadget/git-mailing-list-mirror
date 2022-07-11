Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC24C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 23:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiGKXFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGKXFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 19:05:14 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6687D794
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 16:05:12 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31c89111f23so64756147b3.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 16:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yzOKomOxNh/JFwXGu3jGB18xZxc+2m92lNJjhSEBWk=;
        b=elV/xg38sjzB3Q0DbV8Vbg/OrRgLMZ5t9HGqNh31Iw9gl+bkQVKk1H5i03cI1L4i/L
         XtcpUgnsy9bVIla8LIVv75o0A0YgRHuHeq8I1GNcZnSDbl9KCBhBu7ts78z6yRSc7ON9
         Jqd47Zcd2i4LxC60j0j6+eJ5M2o7M/d3Bvo3ursuU3qKELC3gbZ4UYizfKy1HYirOBGR
         h90Rz4iMBdp/rjJOl6HmXx51mGsVTEXErQaylRiecGiJ5/RvI7MyqWn06fCOW8GGPJQj
         fqCv1fN+XeSa5z3GAnaz1iGs+Tu2ifbYYXTBW1vPDbnhZc6vgQ3GeiGz3EcwO9cYgrWu
         hhnA==
X-Gm-Message-State: AJIora/bhN0z4Z8N+1KC7LzuR9oH2Kl02mBp0Tr9dyPqZkAJIpln7Ju7
        N0WOgW2ij9UZghwY8A/2ZYgBl2ocitFkG4otGeE=
X-Google-Smtp-Source: AGRyM1v0UTUg3HIdVyYQUgrvEpLHkvHojitZ4keExDlVEE0z9uUlzi4uJgy3vGIwsM2EOABro9XukYIjABsjJaX6DP0=
X-Received: by 2002:a81:4a89:0:b0:31c:cd9a:c875 with SMTP id
 x131-20020a814a89000000b0031ccd9ac875mr3285148ywa.411.1657580711932; Mon, 11
 Jul 2022 16:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
 <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
 <YsymlrUviwwoKHZX@tapette.crustytoothpaste.net> <xmqqh73nl12r.fsf@gitster.g>
In-Reply-To: <xmqqh73nl12r.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Jul 2022 19:05:00 -0400
Message-ID: <CAPig+cSkGsS4VouBoaTB_zBEL48-=JBf4PKLJMpj8r342n=YUw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] .clang-format: do not enforce a ColumnLimit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 6:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > Now, we could well pick one that's longer than 80 characters.  132 is a
> > common terminal size and it would avoid needing to rewrap all of those
> > lines.  But sticking with 80 columns is also fine, and we'll just need
> > to send some patches accordingly.
>
> As long as people do not start sending an overly wide code that
> consistently are 130 columns wide, I am fine.
>
> Let's not encourage people to use automation as excuses for sending
> unreadable mess and (worse yet) push back reviewer comments when
> such issues that cannot be corrected with automation are pointed
> out.

In my experience, clang-format will reflow a line of code so that it
fills the configured line-length. So, even if you manually wrap the
code to fit nicely in 80 columns, if clang-format is set to 132
columns, then it will automatically reflow your nicely hand-wrapped
80-column code out to 132 columns, which I think is not what we'd want
(at least those of us who always work in 80-column terminals and
editors). But perhaps there is a configuration knob which disables
clang-format's "reflow-to-occupy-full-width" behavior? brian?
