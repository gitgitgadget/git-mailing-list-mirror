Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD328C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 04:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BF1206B8
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 04:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPCudPwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1ESt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgD1ESt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 00:18:49 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7F3C03C1A9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 21:18:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id u11so21481844iow.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 21:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cyby16kYEuRMBOaNO2FF5upNgNEKMpQ8L5axz5w8EGY=;
        b=HPCudPwK6O4OEVk/Ychi2lnyGk/65D2pe0H5yp780XWwfV5L8laonI/I+kzdRlRKSd
         blWkAcaYkbEYUE2qcBMmoVfQh4RoSYeJ7rq2ba76xK7jzBunfdCeDq7ArdbLpT1nQmNB
         S3yVnnJ5NYwyROS5/XUiIGg/oY8gd3kF6wr7beJh9R3W1zs4STBSt5XrGR7uZ3frsrLz
         OoiQFpAc2uO/STiIUbN/4nUzd17UiNXJ9i6Xg7vOyFRwDBGWuxxZhiXLBKPqWJ97YMrz
         +og6Up0R28qtmHXI/2UsUwyi04rfVr82t7Z7XpvFApm8/Ti0l7aKtZmvAF9X0mx9dbyR
         tN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyby16kYEuRMBOaNO2FF5upNgNEKMpQ8L5axz5w8EGY=;
        b=SP/yGKCm5eqguymejzpnEktxAQgtMq7CVL5WGv+ExI7i+SMeD0oqWexwpsMZ2gHRTH
         FEF/I7Q1s1NR5XO6FFI/CZwflmvvd2zp9f4rLE6pKbQ6/BZlZJXRb3tL+YIDtnMraxEq
         71MBjLBlmG29rSltXubOmUFBdlZliE5sPiqNSoSVuFohmrG5xZxXrXntlj/tnxIYRj6s
         g906DBmuWPnRY17u5Pi++pvFGBaixvpiNfVYavR1uu+gQaS3cM4wt2B7xSMt5o9SfgD4
         EIXv0FXWJgtd28EsA4daGCAriJeVTsc6z/xApuhScXmts6uckXB6ncAjOxmzlMYBBC90
         LOXQ==
X-Gm-Message-State: AGi0PuYVIwtbZYJuEbr0eW/uWKUE1ZimnVU7d7hzDFuDbsSSDbdGUE8x
        qwrx89HzJNipDEzkuZ9BLHpLYqrIRk1bNL8dGb0=
X-Google-Smtp-Source: APiQypJCnNxBZQ/QIXdMxyjXiDWnfE1IMirZtg0BWF66Ly9gREomfrgj3qvW/n8IGIdyPuJafKnvUheWTRpn8PehzKI=
X-Received: by 2002:a02:415:: with SMTP id 21mr24178951jab.126.1588047527153;
 Mon, 27 Apr 2020 21:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <5e00fe77-3f72-0729-2b30-9f4f98a28b1c@gemtalksystems.com> <20200428041010.GA2371637@coredump.intra.peff.net>
In-Reply-To: <20200428041010.GA2371637@coredump.intra.peff.net>
From:   Antoine Pelisse <apelisse@gmail.com>
Date:   Mon, 27 Apr 2020 21:18:36 -0700
Message-ID: <CALWbr2zjL5pKrvk1pRXUKgOLE+kVKzLjR3ofUOhRruAbiVVovg@mail.gmail.com>
Subject: Re: all memory consuming `git diff-tree` bug
To:     Jeff King <peff@peff.net>
Cc:     Dale Henrichs <dale.henrichs@gemtalksystems.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        Kurt Kilpela <kurt.kilpela@gemtalksystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 9:10 PM Jeff King <peff@peff.net> wrote:
> Without engaging my brain to think about what this code is doing or
> whether there might be clever solutions, it really sounds like we might
> consider using this quadratic code for small cases if it produces better
> results, and then switching to the less-accurate greedy implementation
> when we need to.

I remember having the exact same thought at the time I wrote this, but
my limited tests with 10k lines files were fine so I discarded it.

Falling-back on the greedy algorithm seems reasonable in that case.

Antoine
