Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E05C2BAEE
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 21:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F28206B1
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 21:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQUvduyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgCKVsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:48:37 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41032 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgCKVsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 17:48:37 -0400
Received: by mail-ed1-f46.google.com with SMTP id m25so4775658edq.8
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LodaJcGXnqKsb6XoBDwuCsIjuXwp8fVDPdKJv2XkWY=;
        b=qQUvduyDFw8LxphJLHphEKVucypT9u9olpruGPccHNt6JXp4cdPpA1/7oaui71f+qM
         LSun5dHflzncQrLrv9Qpo/rHPGhq7jn0gZSlu7U51vHS9WhZEu7B3PdU1LjIQYseQRbP
         fPoLzfIokic9CWbS4d2+rXH8tLLxZjIx+aLHTvRDLYXz5oOQeLlsfN7Hwb33TjFoojbw
         FJGtIth3my0PudsscLiCvOi4KqpRLmRfi5F5IgYTVUlE4l2QpfO/C4KMm17dO4Ydr5bH
         ooV2keh/lGpxAM28ZnfcBwe76zZW8SqVaWE+CulFGWjz2qIC22HHcoYRy/CkyXhDzW5e
         2f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LodaJcGXnqKsb6XoBDwuCsIjuXwp8fVDPdKJv2XkWY=;
        b=XxwHz9KWB3V1CGmB9eTFx3GtwnbsDAjr+64rnQF8H9JwBHjsmSg2f+G2gDuD4NvGn9
         FkJt4St0vZpYOi8QzdF//vLHfFhLQQAAbKO3k+of+4FMnsdx5FQfHqjsEhar3Pw35YuI
         bU6VTKN1CY7UDbk/NDQ2u4cOsf+wZHV2sscnN3AD6BgHlj3i3vePq6REOkrpq6Rd1P58
         ZI86iAgx3NrMavaLF4290AknY5GCzpXtN7twN3/7qaujOxR+bCQmTGhyhwWHi43b1zQo
         3u/lQM6KdOL9rGSyo5t1rvahZsrC9iA/7FXmqGe0+kKZ+4oXMg9aTx+m9q9gn0DDfs/j
         u1qQ==
X-Gm-Message-State: ANhLgQ2gFUiWQC6N7ACtqaAk0JU9Gx3ZBazHL9bQCeJt+O7Evr89kq8V
        iCtZjD8rERaZtC010zjc4JAatFI0QBj9yHPsEk4=
X-Google-Smtp-Source: ADFU+vvvbc1yrvrxc+uk1Z5H5sQxRlXMzXy/yUPpgFeK4ZJyO1tYDjFof2djxoAD6r4GFnWEyQYdDItWuxaOTu/FACc=
X-Received: by 2002:a05:6402:158d:: with SMTP id c13mr4821509edv.237.1583963314968;
 Wed, 11 Mar 2020 14:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <86mu8o8dsf.fsf@gmail.com> <CAP8UFD31+sK5zyLLgkOvJ4fj=PC3FTa9nXcpPeM-fWm9ByoKjQ@mail.gmail.com>
 <86eety4m1m.fsf@gmail.com>
In-Reply-To: <86eety4m1m.fsf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Mar 2020 22:48:23 +0100
Message-ID: <CAP8UFD0cLrxic6tjGC5UQjX1pNHBzZhVyoddWbhETReFaLK4nw@mail.gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 11, 2020 at 10:30 PM Jakub Narebski <jnareb@gmail.com> wrote:

> >> A few questions:
> >> - is it too late to propose a new project idea for GSoC 2020?
> >
> > I don't think so. Students have until March 16 to submit a proposal,
> > so they could still submit one based on this even if it's late.
>
> If I understand Google Summer of Code 2020 Timeline correctly
> https://developers.google.com/open-source/gsoc/timeline
> March 16 is the date when students might start to submit
> proposals, and the deadline is March 20.

Yeah, sorry about the confusion, the timeline says:

March 16 18:00 UTC Student application period begins
March 31 18:00 UTC Student application deadline

So technically we could add ideas until March 31, but I think it makes
no sense, especially as we ask students to submit proposals well in
advance. So we should give ourselves March 16 as our actual deadline
to add ideas.

> >> - is it too difficult of a project for GSoC?
> >
> > I guess it depends on how much you as a mentor would help the student
> > getting started.
> >
> > I think it's interesting and worth adding it anyway. Can you add it to
> > SoC-2020-Ideas.md?
>
> All right, I'll do it.

Great, thanks!

> P.S. I wonder if Derrick Stolee would agree to be co-mentor (if he is
> not too busy with working on Scalar).

I am adding Heba in Cc as she said she would be ok to co-mentor. Emily
and Jonathan T. might be interested too, so I'm adding them too.
