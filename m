Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DA9C433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 06:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhLKGif (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 01:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhLKGif (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 01:38:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5DBC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 22:38:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t5so35942858edd.0
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 22:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEEYHFov5SVM/sFtvtdjIyyBcgTnFw0e6jRAc+4+I+g=;
        b=IJ7MjlGHqeEGtbFy7j88EWYs3b2KaPfF7uATaE7APs2Fd2tW+AcKBBHR4Lg1QVpZ5C
         +0ccqWN9lElC4AUGpEt7VnKcsPSYLFA+2AeolB7f2PMsvXLvOzjzl+f876e2d1QEbviK
         pFZwS4oxvthSfHuUQcUBEOM619H3bKi2aQd4P3c0RvH1wV33Fz/z3GI0A8X9fWLv+iii
         tbaJtmaldFY4mM7ZDkaicCPD1Aq2+5rXxJ1a3GilFejY0IJCNPoHWxrstRsovf63yJiY
         Vnnz67VnTrjPuD+40nR6wO7OF2/qK351t4ja5PZAhtoG4zYuClrQE5IYa8Y1UsiUqfli
         jT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hEEYHFov5SVM/sFtvtdjIyyBcgTnFw0e6jRAc+4+I+g=;
        b=zyPocyCgXG68qamgZgFFb7CSnDwzYzg9jSVRBcRDMVFHER7xoDZdgnn5jaawDbS6t3
         7GSaiKbTQkRC+qOzYiBxYJTXeIX3036MyNCdxuJbceeYDv5NJBxZiNizrUeumAZ1JlmJ
         khLUlG7GAK9IpP/shCDMqldk0Cgfv2wqmwk6h3+DjvHyfGmQx0kh0cuUN3oSb6Mmw22W
         +vuVitqBBhG/E6TX39PTd91AsmZpjjISiabnjCWolXQ6vzzo5sIo++LlmfqCDmJZx4kS
         VtvJfEjiveETdFH/F0YjvTeK4fEiyGklFmcZuHfwqrz5eGxPoPUDNSR/cLRW+UyWIuYA
         wuIQ==
X-Gm-Message-State: AOAM533FfUTQLsBY9HuHjbCE/lVzwzW9vhqI4u5Q6U0wUuivlR+GcEkr
        g1lbpH8VFiin8ugJZICrGA/yf+iUVEyq3/ez3mU=
X-Google-Smtp-Source: ABdhPJx+DKI+MvCBMXkeoKdNy8RNRDQAPIEbjvIebRMNszvDSSpLYVatFgAKkdCE6JKYou7cGmA4uLfT0esTJOU9M/U=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr30787195ejc.74.1639204713147;
 Fri, 10 Dec 2021 22:38:33 -0800 (PST)
MIME-Version: 1.0
References: <xmqqilvvluoa.fsf@gitster.g> <20211211034452.GA15683@neerajsi-x1.localdomain>
In-Reply-To: <20211211034452.GA15683@neerajsi-x1.localdomain>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Dec 2021 22:38:22 -0800
Message-ID: <CABPp-BE4ZD4dsr=ofbZeWqxEV=8do93o_Gus_wsGw6Fq7V2ETA@mail.gmail.com>
Subject: Re: ns/batched-fsync and ns/remerge-diff
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 10:33 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
...
> Also my understanding is that ns/remerge-diff will be dropped in favor of an updated series from Elijah Newren.

Yep, waiting for ns/tmp-objdir to hit next so we don't have multiple
dependent topics in flight, as Junio has frowned on those before.
After that happens, I'll send in a reroll of my topic.
