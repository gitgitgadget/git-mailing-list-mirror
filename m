Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E879C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB96C610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhJ1WwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhJ1WwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:52:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0CC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:49:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v64so12822975ybi.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzmM4KWj0l+n2BewGECUQTFcUzijgv77f5dVLrxSUlQ=;
        b=GMcVooO0EUypIGGgijS6sB78cSJ4cwThDpX6wS7NRfbYjsv4ZeZolkTwz2RoK99Jfc
         sL/tiiss3cbi7LQCEBMEL8Rj6dXDfWI5ERPkynzFty+cvnAOjQmw/y+3rKp4MhzTqGxe
         l0FleKXl1S8VA0G2q6G9LWpGDqVVY4ZzO0R8y18CTICcCa5SVg9AGGqNytQP+68sCycd
         fwAPS0sfYTkpeVYzgzsheSL2DsweIcU6c96pE5SVQbLNsaHVQXsXN6ZvVZ4UK9jSKL/Q
         pC8H9fBL/8MfwmeVeUEbgbTWHjPe0tJAFs9sQKl9olxB0ARm6GauUPtUUUx273TUMQ1K
         9gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzmM4KWj0l+n2BewGECUQTFcUzijgv77f5dVLrxSUlQ=;
        b=E31KoxW/K/S/8piyFYiIQNpJPibFEioOxrqyUjz6B1fsZwm1/TTycIsPmRRTyD7Ghd
         KY8WcUn0wS35WApVt/7rCaZ7KS0h6IoT2ug/5Dx6bV2oWpXNhnIs9TlhPl7sVqO0FeZm
         6AvpGBzDLCUV7uAVr5X7xQ8XXdEe1SO/4Aqv8qzIKKfSYCOWZhOHifsuJeHpQ03pTuqb
         0n6jA+S9bQ+TvTBxCt6JKPkmi9gfqI0DUTalsFgJs2eQf/K7e8caHcsIP6y7zNzKpXxT
         7Be4d+n/jWtyO69MsxoGBAd5YUuWSc6g3qRZ/tFCXuMrTT33EzJoTE2PM18Y0GHq/FN9
         MhFg==
X-Gm-Message-State: AOAM533TQJidgJE1Ze8ecqgLZg02eCFJUjX6lM7TOGNowtf6ZuJ9kFpl
        xEPx0A+BpTNMoYLo7cYaI0oVe6eYtCEfr/vFLG/gbQDuTn4=
X-Google-Smtp-Source: ABdhPJxnqiYJkjl/66X2YcjnggRRjpF2prLcjqh40iDHMP0CE2fvP7lGekstuTEMkrnaFn+n1P0pLtK/FB5ZqxwTgaU=
X-Received: by 2002:a25:bed1:: with SMTP id k17mr7636823ybm.215.1635461375041;
 Thu, 28 Oct 2021 15:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
 <xmqq5ytgrkku.fsf@gitster.g> <CAGyLXMA93qQw_h97bMd14O26hSxn4xn+AzemVyrf6pn53qO3UQ@mail.gmail.com>
 <xmqqilxgpywf.fsf@gitster.g>
In-Reply-To: <xmqqilxgpywf.fsf@gitster.g>
From:   Nicholas Bransby-Williams <nbransby@gmail.com>
Date:   Thu, 28 Oct 2021 23:49:23 +0100
Message-ID: <CAGyLXMBe2qj8mT+gA2skQr=+bteV9E0nKZ=u-5akCQtTU7AfKA@mail.gmail.com>
Subject: Re: conflict markers in markdown files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I didn't miss that.

I have no control over the content in the file so I don't know what an
appropriate number is.

Although I guess an unfeasible large one would make a clash highly unlikely.

On Thu, 28 Oct 2021 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> Nicholas Bransby-Williams <nbransby@gmail.com> writes:
>
> > I guess using such a long marker makes it less likely but there no
> > reason you wouldn't have a 32 character long title in markdown
> >
> > Example.... :)
> >
> > An important heading in markdown
> > ================================
>
> You probably missed the part that I said .gitattributes is under
> control of those who are editing the files the entry refers to.  So
> when you edit the file and add such a line, you can easily edit the
> attributes file and pick an appropriate number.
