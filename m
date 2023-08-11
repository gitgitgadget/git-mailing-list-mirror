Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A535DC04A94
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 01:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjHKBCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjHKBC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 21:02:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2592D2724
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 18:02:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d5e792a163dso1538919276.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 18:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691715747; x=1692320547;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBbO72qF9VCdMl0/fbJ6MyA9VjQ2MCNIS33+WtJGdhw=;
        b=IlIgxHsBIAlYryqL3G7a3ZThYlzoDxsthSadBx4NsQ+Tk34Cq9y56WRhTxwOcVnGuO
         g0xs2Ah+nqbqiLGXxDsrRrZpjwD46GF6OeNrw6jcwB9FCaB7Y9+kLiplxx5ZXX0L2x5m
         F4LxUYenaTYwtjNCjRYS2VIJQ/4oFQLtxv6vFpaWcbT8l5W36krMRRQJZnyaKDJRTaG6
         Wj0MV0nddonOTPkTcA7SHYmx8m/tzvaus9DPjcyfuCWp6BoZST+rWnL/AtLlfVxvmGwQ
         ogbX9QZ6a3C1EY4J09P3JVxJ1uh505yuEo0MW9/EqwoXDHnwWzxX8mvNM80lx0btg9k3
         YJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715747; x=1692320547;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBbO72qF9VCdMl0/fbJ6MyA9VjQ2MCNIS33+WtJGdhw=;
        b=UCZ5b4JyzfKQjVBfeeZxe5JS1ZUagUOF4vyK1Ge2T3dRAkM/uDMVM6OwGqbH8zOhK3
         AbF5g0Xh59/L1YP/MNFja6cg3R2Hzd2obasm7au597wsPEPgr1D9tLIggg6yC6bT/FB8
         AZr4aUh1/paQSSVvfDneaIb90RfcJZY1bEhs6pPkjXsDo7opKLIKAq5kwFjiwUGFFE89
         ksonndVDgvkmxicImLN1qxXRQ6yDZJB7TJ0qST5QvuKa2dEAO1XtYPQxKeLhNF5CcE4X
         dmDj6/U+f9Uc7nktWgEGSEPJ6DDVyKFXBXi4raQdyHql+bfz4ayxW21M1Q4xcnt0Ifau
         mq5g==
X-Gm-Message-State: AOJu0YzGkb16SPUjvuLSugpj1FnJg1MWFcoMyAKsv59o5Eh4KxJPz2Jt
        0S9sSm1CbDkXgVqwRROBaw1lv0TAVh8=
X-Google-Smtp-Source: AGHT+IEyiBgcIGaeQmmZY1444GaNqCLfFlAjA3AP9j01z8cAAuvh2gMOl3C/NEy/vfRbn5JTErI5uA4DK5M=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:ab8a:0:b0:d0e:e780:81b3 with SMTP id
 v10-20020a25ab8a000000b00d0ee78081b3mr5612ybi.2.1691715747448; Thu, 10 Aug
 2023 18:02:27 -0700 (PDT)
Date:   Thu, 10 Aug 2023 18:02:25 -0700
In-Reply-To: <owlypm3ufl7j.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <c8bb013662187e9239d4a2499a63ed76daa78d14.1691211879.git.gitgitgadget@gmail.com>
 <kl6l1qgea2k0.fsf@chooglen-macbookpro.roam.corp.google.com> <owlypm3ufl7j.fsf@fine.c.googlers.com>
Message-ID: <owlymsyyfl26.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/5] trailer: split process_command_line_args into
 separate functions
From:   Linus Arver <linusa@google.com>
To:     Glen Choo <chooglen@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:
>>
>> But now, we have to remember to call two functions instead of just one.
>
> But only inside interpret-trailers.c, right?

Oops, I meant trailer.c.

In the future I expect to move this to interpret-trailers.c.
