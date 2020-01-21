Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FDC33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C622E22522
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 07:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHlgsL0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgAUHQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:16:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46280 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUHQM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 02:16:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so1914742edi.13
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 23:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYKjhCCJZ7VejbxHGRleZGHcVLvxc7mJjYI7YNC7y4Q=;
        b=KHlgsL0bHlSGd8JSurqnfF8jQyBb2WhUldnw0kD5qBGETk7E9JN1m5UqB/dFbKCVZ2
         YebDKwPLzafeERA9fGYLumv4btxdUb/v3sKZPK8lJ/VKcrj7r9y9GBuCq0S/rEwx3phe
         7/ZV+mFsqaPmb1GjnfO2bcEmpndxrCollrLg1Zy7rHni/C+9mzlftoEPUfRglPezl4j8
         HXNE14VO+oGACO0CJCWpTXKgP2BLkOnRkzHuscSqawqMaHvDyRFmE+2F3VY+/cqxQnPI
         POxCXqy4N2/l8jN4U88HfQGofkSw+lJUw2UvMzRuBI7J1k4YqpvUy3fWLJUGuodZFmAu
         eVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYKjhCCJZ7VejbxHGRleZGHcVLvxc7mJjYI7YNC7y4Q=;
        b=PhEEe2SleT7gH9LbCMFBlRWaza2Er6Aa9uIQPHhyQZEwbJVYq4+rqh6G8C8wYJUUKW
         kc+TvjMvEF9KKu8YLK5ndbG4A+2Bt5CGhYCednGPdRvOib+D5QuW7Kkse5l38Dh6VQPP
         8ORFpgGGeC94leZOT/0u10/hcM98GKYDdD4S9lCqW0ZM+NRAS++QSxSMcllmtBcWlePZ
         nQJOG0jy52LDeMF/VAlDyxoFI2CHxP6ew/tcEDTXHoCuJA2SHS1NALe98TJLzy27BVbC
         0tRmHyS61luP17Y6W5wo0IUdt1YjU67MJAcIuTxBFGv4jWKnALVdURWBaQRvFS1xLYG5
         kN+Q==
X-Gm-Message-State: APjAAAValsx/8BR/QuOcw6sT4TnjIO+6iEhriYKiUqQPEHkmNK5l1TzO
        AKXp+QO6mJ8Jp2bn1V+YDzfA8W7D0UurvMPylms=
X-Google-Smtp-Source: APXvYqy7NLuy6qKK7nSB+jZHM7jaHXHC/8ow7DG/F+g+svocpbkehz75D95eXVfz9ubDUf3Q0xk5omT+ad/wl5slh6U=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr3122469ejj.6.1579590970634;
 Mon, 20 Jan 2020 23:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-12-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001202325000.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202325000.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Jan 2020 08:15:59 +0100
Message-ID: <CAP8UFD3QP3QXe32cdK+q=P+v3dK1Bfws5KgNnm-JfDnPkpBZfw@mail.gmail.com>
Subject: Re: [PATCH 11/29] bisect: libify `bisect_next_all`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 20, 2020 at 11:29 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Mon, 20 Jan 2020, Miriam Rubio wrote:

> > Since we want to get rid of git-bisect.sh it would be necessary to
> > convert those exit() calls to return statements so that errors can be
> > reported.
> >
> > Emulate try catch in C by converting `exit(<positive-value>)` to
> > `return <negative-value>`. Follow POSIX conventions to return
> > <negative-value> to indicate error.
> >
> > Turn `exit()` to `return` calls in `bisect_next_all()`.
> >
> > All the functions calling `bisect_next_all()` are already able to
> > handle return values from it.
>
> So this patch brings more magic values that really would like to become
> `enum` values. At this point, we're talking about `bisect_next_all()`
> which is _not_ a file-local (`static`) function. Therefore, we now really
> wade into API territory where an `enum` is no longer just a nice thing,
> but a necessary thing: `bisect_next_all()` is a function that can be
> called from other source files.

I agree that return values could be better documented. About enum
though, I am perhaps wrong but I don't think that we use them often
for error codes. Do you have examples in the code base where they are
used for such a purpose along with regular `error(...)` calls?

> As far as I can see, this patch concludes the "libify" part of the patch
> series (read: it would have been the second patch series I would have
> suggested to split out from an otherwise too-long-to-be-reviewed set of
> patches, if I had been your mentor),

I am ok with saying that "part 1" stops after this patch and that the
rest will be "part 2" and will not be resent in the version 2 of the
"part 1" patch series, but will rather be resent later, when "part 1"
will be in next for example.

> and I'll leave it at that for
> tonight; Hopefully I will find some time to review more of these patches
> tomorrow.

That would be great!

Thanks,
Christian.
