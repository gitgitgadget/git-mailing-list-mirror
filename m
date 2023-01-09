Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7EC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 06:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjAIGmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 01:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjAIGmE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 01:42:04 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8ECD2DC
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 22:42:01 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id g7so7217302qts.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 22:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DhmiG7CZio08j2Iss3EiKa9nAfOc3CNqzAHXjBsmeGM=;
        b=KqbhhTAlzAHl+E+rd0cvH2Nuamz8AMBii0rRPWknw7xYxfqnJoI/gHidq3AYS608SR
         fsA56KTTx5pnVGuw0sX8QVR1PRZ3zn1NWF7gKTv3EUIQ9md8sJQwFbgXM+6ouOmIcLrD
         r/GBXH+Vwc6mR6fgvzTDcvKTGY9224S3MqEFPz+Is6Q8SHHaPA/hgZY5af+qRcS2OMaT
         yhKu8iGIdE3vLu8hBulHY5P87+qZiSDr3KN/bXE9y0Qrc6DsoQWUc7+QwDZ96HJ0KzNa
         IIR2p2o/Eij/jaMJhTklTn2Ql5SZR5X6QEEbPgdby9cRR4zG6br0k5hcG6hXJCNEGWF4
         x25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhmiG7CZio08j2Iss3EiKa9nAfOc3CNqzAHXjBsmeGM=;
        b=yNfp5ypr6+NeeKcyl788K01fes4mZ4QFNB117GsdCQVle3yxXJrODc3lAcfmqeXVKF
         8q0LAe9062nslsFFWB5NOM5C12gLjPC2btY9g3L0Eih2jJ/rZhMM0xeQgX9mAARNh4K+
         IDXcqSC55tFiqIPinGlM7661cUgoJcASuU98TT88yEYLqTAhTHtMzQatCs4EScojbwU4
         GUC4OzEl6jK6EyENndYHiUQMTDYV0/lpHKSVdQ3A8jPvWT0BICM/iouYUTUhPfmhc+Nt
         Ut9Wev22MmygPxxVPA1iF7pUWhNTnla2tuh3/N8wSJIoA97PCiC7CnoDMFjBuca5/4cV
         Z7Sg==
X-Gm-Message-State: AFqh2kqSLj79lZ4YJIIbWA2Y+fjhFrOl/6kZamE+fQkQhf9n9lxlGW2v
        9CWGeTbc7lTxlHME9IaoNuCMkZmrzYXMIXuLQHm3/7fhLdA=
X-Google-Smtp-Source: AMrXdXvF8LhT+wnfNl4m6yQd41Lv7gaMlUuzC42iJL+KjLzzmpUvxyJWvL6l3ljBBlVOlG6Y0AtDgt+tKFmn/y+jMlE=
X-Received: by 2002:ac8:48cc:0:b0:3ab:71c2:afec with SMTP id
 l12-20020ac848cc000000b003ab71c2afecmr3040255qtr.476.1673246520880; Sun, 08
 Jan 2023 22:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20221216033638.2582956-1-phil.hord@gmail.com> <xmqq359gnfhe.fsf@gitster.g>
 <CABURp0pWwfWO3msZ4U=_i3zkEDOq6+CUVT9Tb7KCjeBRK34Miw@mail.gmail.com>
In-Reply-To: <CABURp0pWwfWO3msZ4U=_i3zkEDOq6+CUVT9Tb7KCjeBRK34Miw@mail.gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Sun, 8 Jan 2023 22:41:50 -0800
Message-ID: <CABURp0pqQFiM4+L0sRADTt-jmAsHcMMWLR6xa4NbqrziZjmdOQ@mail.gmail.com>
Subject: Re: [PATCH] date.c: allow ISO 8601 reduced precision times
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, plavarre@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Thu, Dec 15, 2022 at 8:23 PM Junio C Hamano <gitster@pobox.com> wrote:
> > All of these may be obvious improvements, but the thing is that
> > there is nothing in the approxidate parsing code that insists on the
> > presence of "T" to loosen the rule only for ISO-8601 case.
>
> I considered making the T an explicit marker, but it didn't seem
> necessary here. But the looseness of approxidate with regard to spaces
> is worrisome. That's why I added the date/no-time constraints.
>
> > For example, with only 6 digits, do we still recognise our internal
> > timestamp format (i.e. seconds since epoch) without the
> > disambiguating '@' prefix?
>
> I don't grok your example.  This change should not affect the
> interpretation of any 6-digit number.
>
> Oh, do you mean if there was _no_ delimiter before the time field?
> Like 2022-12-132300?  My change will not recognize this format, and I
> believe it was explicitly rejected by ISO-8601-1:2019.
>
> approxidate seems not to recognize fewer than 9 digits as an epoch
> number, even with the @ prefix.  But this is not because of my change.
>
> test-tool date approxidate 123456789 12345678
> 123456789 -> 1973-11-29 21:33:09 +0000
> 12345678 -> 2022-12-16 18:34:02 +0000
>
> test-tool date approxidate @123456789 @12345678
> @123456789 -> 1973-11-29 21:33:09 +0000
> @12345678 -> 2022-12-16 18:36:35 +0000
>
> test-tool date parse 123456789 12345678
> 123456789 -> 1973-11-29 13:33:09 -0800
> 12345678 -> bad
>
> test-tool date parse @123456789 @12345678
> @123456789 -> 1973-11-29 13:33:09 -0800
> @12345678 -> bad


Do you have any suggestions about how I can better alleviate your
concerns?  I don't think there are real regressions here and I tried
to explain why.
