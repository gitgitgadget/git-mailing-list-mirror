Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC635C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E0861206
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhI1UR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbhI1UR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:17:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0183AC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:16:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p2-20020a056902114200b005b61d305fc4so145800ybu.22
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=beEFeMjJW5VR16thkTqU2rhEo1EZUeJ5DFAFemPItkk=;
        b=nUNKQbmhdbOC20AcULdR/rJNpfY+72ZQXBg+RwSNJbmaGQaW7uAgUnQjy3/NkhLmyp
         v4b3rHOT54zmiJjkA81BROLuzTaIznlVEiRdLFxT3BFYcmazx3OJZinYH7vLLY4B2Si0
         OfKPQYRxAlk6WXwKtEjkKY6293PisMj1TwEJt47Ixfd27ivr1vHAgTIjIsmrodEr+A4W
         eJVt5XwxIG9H+v6nIfsug0/2XITq87X93stcwJa5b6ExPynVVYV89f/PM8UI/Y0OdbOj
         sD0tGBIdhxE8PZRK9J+SjtHEqkz5PsnOtkv7WYiMKf3KthVYqkwUTtu3slWeA6TZ68b+
         sp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=beEFeMjJW5VR16thkTqU2rhEo1EZUeJ5DFAFemPItkk=;
        b=bETWMFxp/d+8V0J/TTp7CrF8uBALGzmGWTm5uQ+DsWxbyHDO0b5NluHZTo9E8zlGRt
         xTft52JBit7VnYdaHBNSUT6XmEzZMUjFvkSm6ZIjBRptIm/0rrVZx8viPi+G8rQ7L0fD
         COwd//5Z3s+0/s/f75BGdke+KVMrjKFPtYwQdpeDqCZEkljmQx+Mzk4ngunPdAlTMB2d
         dkRF6pm0BT0CqyO4NsnLq1EVs5VEzT5mbmZNauLlO9D+5hAoOwWWSu0qsXPyQvJhfMzd
         IbOWJueGjHI0devKCX3yCO3KP8EPex9Jz32trEDsu4evbcoj/2t2M54MgVt/P9JMZswx
         Pd5A==
X-Gm-Message-State: AOAM532UePNWY0EyHCNXcCmW2RR2UFHxF7Yfk+h/Y5VTXAefQ7FM3Ovh
        ya2Zh8mUaJCydlPa/iQvZGQgITFtxj23ZKz4rjO2
X-Google-Smtp-Source: ABdhPJxmp8vKd/sMUin9Eh/0UExmRoLYllWJsEzppz8y5H5MvcCyc47u5gZ1xDXWpK/byh81APilI5fZ+7YS1ID2AnFq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2286:: with SMTP id
 i128mr8966516ybi.356.1632860176201; Tue, 28 Sep 2021 13:16:16 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:16:13 -0700
In-Reply-To: <xmqq35polhye.fsf@gitster.g>
Message-Id: <20210928201613.1110573-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq35polhye.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     carenas@gmail.com, jonathantanmy@google.com, git@vger.kernel.org,
        peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Carlo Arenas <carenas@gmail.com> writes:
> 
> > On Mon, Sep 27, 2021 at 4:04 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >>
> >> > +ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
> >> > +DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
> >> > +endif
> >>
> >> I noticed today that I wasn't warned about some incompatible function
> >> pointer signatures (that I expected to be warned about) due to this
> >> line - could the condition of adding this compiler flag be further
> >> narrowed down? gcc -v says:
> >
> > Apologies; it is gone already in "seen" (and hopefully soon in "next")
> > by merging js/win-lazyload-buildfix[1]
> 
> I will mark it not ready for 'next', while waiting for a fix-up.
> Thanks for stopping me.

Just checking - which branch is not ready for next? The issue I noticed
is already in master, and js/win-lazyload-buildfix contains the fix for
the issue (which ideally would be merged as soon as possible, but
merging according to the usual schedule is fine).
