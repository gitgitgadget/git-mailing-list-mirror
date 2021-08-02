Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC94C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271DB60E78
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhHBSQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHBSQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 14:16:36 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB44C061760
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 11:16:25 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a201so13470628ybg.12
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDskefk2eL8BsnUTAQ11smmGdj4Gj3/fpZm8OexzT48=;
        b=rI0e+mQL9EEjy/AGcvyzOso4Z5Uy/K52k5guKyvTPLYHTBRQBtArSTa1pH1e6zA8P1
         wtwoMxsVkVBNjc+Y56PRv/efbGSCBZdCYj2PRXkhM5sRXTlBaRRaYDV8B7K2T6rLqhi/
         +oKEqwCVg06pm760An5TnP3IlCmbfIjSBej0+dwPszrQCBtITOpqe+4AprAN+yAkVAri
         kUbh40OMITmp7C9nuxDQJ+KMPAUAXSQTbGKYcyNKEJ8JjW5TXcY4S/wwE4cd9m6TvmXh
         1AdEwPegbHv5pG8N6U7Ht1wZzdYO0YksxfuDROwgJYZbRCUSVLCEOi9/2oabIKCCgds5
         zItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDskefk2eL8BsnUTAQ11smmGdj4Gj3/fpZm8OexzT48=;
        b=Eq86zHyc0+K7BsWvwe0tJXY4xGbsvt76ZMol3KBf96Crf41oOnkHT78UdPF/4U74ku
         Xe4YgRENYvq7H+lJLCXePP+bWI0iy+g30SrwlTzt/XUDChfAW9HgyMjcPOM5XeWL211R
         o7JN98E9Nr8IfIJTCMexArRD/SanJHydMy8J5TjWB/DkZiZfDV0X5KBjGU/0YqxPU34q
         nPEWTPVtMuSrzYiphm7IwTmebV/ZlHmSxOKm4eVabj4BxhTjb2MX9YxhycLVjk6BR8MB
         rPyabDkl7+HvO36KQfRXvaOSTVGA97r5TtFgAtdM3EQRIIDuVB/xUFtw1r51JkRw+ajw
         ybcw==
X-Gm-Message-State: AOAM533IuPWB4KelK22S4Fs4UYtcYJTKVdDU3bE7Aooig4Oo99Bfz8Op
        mkJduv5aRP46gIz7zwT/ge9IKTPv4MPdLRFQBk8=
X-Google-Smtp-Source: ABdhPJyxtQMD4dxgQdDVYlXhTbFUl0pT2OP0yYZSxSyrDH/5ZYWjfnR5040qaDftVqHOA9BPqvIuY4+Awxz2mzeTzwk=
X-Received: by 2002:a25:48c7:: with SMTP id v190mr22265067yba.312.1627928185004;
 Mon, 02 Aug 2021 11:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAB5AetcMK6=yZh4OY-0A6x6vs7X+0_1APfp4cCP_MSK_TO46ow@mail.gmail.com>
 <YQg0t2bzqwBJ02yL@coredump.intra.peff.net>
In-Reply-To: <YQg0t2bzqwBJ02yL@coredump.intra.peff.net>
From:   Joseph Jenne <joseph.jenne15@gmail.com>
Date:   Mon, 2 Aug 2021 11:16:13 -0700
Message-ID: <CAB5Aetcr4KWpyv13DtmxxfUBwEN4fgWHgmbN7YcJ9Lgs2viAVg@mail.gmail.com>
Subject: Re: BUG: git log dies to SIGPIPE
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I'll check it out.

On Mon, Aug 2, 2021 at 11:08 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 02, 2021 at 10:46:53AM -0700, Joseph Jenne wrote:
>
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > used `git log`, exiting the viewer (`less`) before reading the entire
> > commit history of the project
> > What did you expect to happen? (Expected behavior)
> > normal exit with status code 0
> > What happened instead? (Actual behavior)
> > git log dies to SIGPIPE after `less` exits
> > What's different between what you expected and what actually happened?
> > git does not exit normally as would be expected
>
> FWIW, there was a discussion about this a few months ago:
>
>   https://lore.kernel.org/git/YAG%2FvzctP4JwSp5x@zira.vinc17.org/
>
> -Peff
