Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47298C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 03:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2579A6056B
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 03:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhHCDqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 23:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhHCDqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 23:46:30 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DAAC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 20:46:19 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id n1-20020a4ac7010000b0290262f3c22a63so4895404ooq.9
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 20:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05F8vZMosQ8kUS0AZYi4SxNAVGHtBvghjs6uQyL3R0c=;
        b=eQjHBBQwEMx1NGtTJySHYjpenRnKcMCEMllSNmDOFGZKRLy6ppgT/gqAoPsvoiHb/3
         rJrmRbOe0MJO6/0TckAeXGgguSAupktnQzoDcA0zI+8KIsZABv+wuxSMXtfdc6pj2HhH
         cXSq7ueWLi+TJkPpIvVzfnXdweZdzM2ATViKsuBHDDDdKqZbuDyBjUyo41MPvoP8rv0w
         o7lHDjNNAroqIs8SSFt22JFaByu73xjhZ4iW1lHYY4cXSLIUstt/tLN9Mwg6SnTp/ai6
         QIxtQYczpaII+6rrqucl421cMOYYhzSjL+I+IUx2T9x3gr2xaZSIKftrwd4w14IHivZf
         rQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05F8vZMosQ8kUS0AZYi4SxNAVGHtBvghjs6uQyL3R0c=;
        b=k9JFvIcD0rgcZYcla0h4mzBsLW2ok8Lrqrg7915Lwo64/+CpSgzJZQClmY8SFkp7IJ
         ELpVk5F/F/uMECGRPAZYHAwCP1ZvzdogtFyLaXSbv0h8Y3R1px6XwYQSrTM96f6s8bAv
         Xjm8krh2YbcNArC81tFbXqffGUQo83h6TD5onsTetSlLrEToDWLFSh5J+XFYUnHPOh/3
         UrN/Jh6eWZiPwkqVuWH7aK5ybqgcImVkf4ROhMaOuQ4ss6GPHe6dqDhTx6hTUIfN/UoR
         u0EPDg8Wmrju5bw8JV3UnbRNIxYQhvrKlx/n/VwWTXjRsAsY5QAScAl3nlR/E6Uz2EbQ
         qbPw==
X-Gm-Message-State: AOAM5316mWT30WYSz2eq/sw4c2O2Tj2hobFhf3tfgBlg5YORQldK9rJa
        PWLuYW80eAYBy2FB7qsCeVuYktwAv9+//1ir51I=
X-Google-Smtp-Source: ABdhPJx6If6TaURUjJBe/Z49+6nNnopf0VcpigcpreFoBfim5LhRO+62nrvQOG4rSBWKnAMlOrLGn2j6K42fPSYDDxI=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr12875160ooe.45.1627962379172;
 Mon, 02 Aug 2021 20:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbl6fv2b8.fsf@gitster.g>
In-Reply-To: <xmqqbl6fv2b8.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 2 Aug 2021 21:46:08 -0600
Message-ID: <CABPp-BGxyJqLmUKMv7Cpq0iRh7xPqF-PUsHNJZUkMxxDxZ+s-w@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.33.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 2, 2021 at 5:47 PM Junio C Hamano <gitster@pobox.com> wrote:

>  * Repeated rename detections in a sequence of mergy operations have
>    been optimize out.

s/optimize/optimized/.

Also, this optimization was specific to the merge-ort implementation;
should we add some type of qualification here?  Perhaps something
like:

* Repeated rename detections in a sequence of mergy operations have
been optimized out for the new `ort` merge strategy.
