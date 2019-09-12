Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE561F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfILTNq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:13:46 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39663 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfILTNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:13:46 -0400
Received: by mail-vs1-f65.google.com with SMTP id y62so16960268vsb.6
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UY1QVg3fC5qDmfO8Qa2fQNbAraS1lg1+oxc3Pk1zqE4=;
        b=SfLxA4C3k6lCrmM3yh8vlIuUk0Csf0+pghi7HVMSaFcfgyCG04QRlhODr+XGuFqzKq
         RzZ74GJop1RAWJ9sJWfNW27yDWM45ozOmeQER3mWbwqI6fRL9cBiHWhRpwXqAUDO+sAC
         sCIOw2hAw2NFeEk7F/ojgM9ZAXKAUpD2BFMlhNsTQSVMUuSx+gJl4ZIqkH9ompZFVMOD
         sQUsyv4eV3/MJH6UxXaPrDvhUIJUvDkr3kuFgQ2lI3r3iK4hvJB9LCSwtz2feEuNDUJA
         Xk2+CUBmC1tK+ACJdWRzxFDePEFULfecUS1gDsx0mvNY0LtQpwfBNEFTEp04pmHCge5k
         h74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UY1QVg3fC5qDmfO8Qa2fQNbAraS1lg1+oxc3Pk1zqE4=;
        b=StY/Y7oaYUJbQmqujlIttRZ+p+5Tw1XQmVyTfsqinzL5jc0OIttpNAyLbO48PfsRTP
         wbzb8AZqoj5USdseJcf1iyrDyvuvscywV+0mdh5NQxLe43AuZ5sZXWGu2mNR8Ot7Iwqc
         65gonBDSW5S0RdoHux4Z5dR2TAD8yudYpChQ6j24nKwCG45jl83ZJMC/ih0QpML1yvGz
         q+6hLIgkOke2jrAEXD5fGtZMIyacxwiM/g0Jt/6Dqy/rpVLzhe6z2A8aZtFXygKd2fr9
         Pa5qXk/kYYbtvdTbXl1zh/bEF+fgZFfjFrlWoUvDnN/wiFB8o51ZbaekFI0eDrzPNaoD
         rUGg==
X-Gm-Message-State: APjAAAVb2DNMma6LF9kG8zHvyWEdnqv07tmGPQqVGtye9Z5FbdpPJT99
        iYqfsEtRNkezDqGsRO5O9lM2mtCoCovZHf6BbCb4iDju
X-Google-Smtp-Source: APXvYqyIN66TcXQwit/8yM84kbUMVopMbV5HKQ28/r66MwiUEOdbH7iH+vS4zXXF8c5zuTJC6lhKkDWnT1kcpNb8Dro=
X-Received: by 2002:a67:c408:: with SMTP id c8mr19426872vsk.63.1568315625418;
 Thu, 12 Sep 2019 12:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <20190910203456.te2onnr3eibw2pjn@yadavpratyush.com>
In-Reply-To: <20190910203456.te2onnr3eibw2pjn@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 12 Sep 2019 21:13:34 +0200
Message-ID: <CAKPyHN3OX6cjc7-mLnOCfRKnNBdGUYsgbQQYiCw9GJravUkhvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 10:35 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 04/09/19 10:10PM, Bert Wesarg wrote:
> > The commit message widget does not wrap the next and has a configurable
> > fixed width to avoid creating too wide commit messages. Though this was
> > only enforced in the GUI. Now we also check the commit message at commit
> > time for long lines and ask the author for confirmation if it exceeds the
> > configured line length.
>
> Thanks for the patch, but I'm not a big fan of this. I agree with Eric
> that more dialogs are annoying. Even as a temporary change until we have
> word wrap support, I don't like it. I hope you don't mind if I only take
> the scrollbar change and drop this.

No problem, will keep this patch as a branch. Just wanted to be pro-active.

Bert


>
> --
> Regards,
> Pratyush Yadav
