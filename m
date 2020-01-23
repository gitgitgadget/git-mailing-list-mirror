Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48727C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2BD206D4
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZRXDgTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgAWLQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:16:38 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35830 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWLQi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 06:16:38 -0500
Received: by mail-ed1-f53.google.com with SMTP id f8so2946233edv.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=177uMSM3ciBr3sRh+UDV+vpsDtN3qldRogOloEtsmuM=;
        b=kZRXDgTvpX+6SbMq0d+9FCJcMjNYsVkQXdTggVXPKu66SuWBkUSNt8jDrD48sZ7PAc
         +0TBYM6UMO4VK3//1xhfkTz6bC2ZpcWN9VeduMfRYa74AqcQRf/HXsHEULH1wNWmss4z
         2MxN0nAQGyp/1O//M4EuANOIB+UFbWXul6JfuxCopO3oSAv9lV3dn4ltrdPhXjhzdTyg
         6lRlT1OXHjnlqMSG6Wam6XSUxjAdzPQNZPX73GQPy1vbHMWxnwjiFg9zUaBtkqombrjg
         gQM2DdlVK0r0ta4U+C3hbKge2IIE5YVVTqtcn14IiQ/qe6suVOTgdkm6EjLkTTSsRJx+
         I3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=177uMSM3ciBr3sRh+UDV+vpsDtN3qldRogOloEtsmuM=;
        b=nluULKjAlYTiR2agUIZ0Cikzl1Q6i+FTUgCYoLBVEHlLav218/3SxZJK9otH88jGp7
         MEC2ANyhAoWmYF3GvPsWTZ9kJhq/ZiPgG6+VgBINyCT5VQDuYwvwv0apcOROUImce9z1
         9YYZxidVRcWqbV04O9kGsjYSKo0ttrePiYITARSXMDGfHjkZfRTWx4cugobCfH18rXOI
         hmUbvaeLjI/mgF77U7mYlDxDPx1SqZvzEbmbK7I8UJn6SSirqRS7QQCE04CQ4jUqGvDV
         elfEK2qXqfXqvXlDfd0zoy+NYYFo0AV9/L7fOipTZooQ5jbQrFXdZ5+FpzkhxXTYwG4P
         rhiQ==
X-Gm-Message-State: APjAAAURTVrbEeO91gK4p2gP7q1ukexruqLQ2w0KC5q4R8546NXepzQX
        c5qPOI/3KtYSjI9h16VjOFvN3HZ4K9oOadcyYIM=
X-Google-Smtp-Source: APXvYqx02r8jYMeW2mXkPogLlaIHqaGQJFlbJ8LjyoZCs1oFDDuNYetk36WmrbmDPpxyQum9C8PfS4jSP45IHU/Mxhw=
X-Received: by 2002:a05:6402:17a4:: with SMTP id j4mr2485943edy.362.1579778196121;
 Thu, 23 Jan 2020 03:16:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+CkUQ-72jKTMUQuGvYg+o5bp3DoKxX5bFCUrWyGLf_tzVydsw@mail.gmail.com>
In-Reply-To: <CA+CkUQ-72jKTMUQuGvYg+o5bp3DoKxX5bFCUrWyGLf_tzVydsw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Jan 2020 12:16:24 +0100
Message-ID: <CAP8UFD20Jh4HRBUTUfy6t72r_wyX3F2RWoyRVwBx4dY2VfhrbA@mail.gmail.com>
Subject: Re: [GSOC] Introduction
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jan 1, 2020 at 2:05 PM Hariom verma <hariom18599@gmail.com> wrote:
>
> Hello,
> I'm Hariom Verma, a third-year Computer Science Engineering Student.
> I'm using Git for almost 2 years and want to contribute to the same. I had
> gone through the solid part of 'SubmittingPatches' and 'Historical Summer of
> Code Materials'.

Thank you for getting in touch with us!

Also sorry for the late answer. I think many people had a vacation
around January 1st and I think that's why your email fell through the
cracks.

> I previously solved 2 issues[1][2] with the help of dscho and looking
> forward to work on more before working on minor project to have a good
> understanding of Git's Code. But thought I'd take a quick break to
> introduce myself.

It is not clear looking only at the links if the issues you solved
have resulted in some patches posted to the Git mailing list or just
fixes in Git for Windows. Could you give us more details about that?
For example if you sent emails to the mailing list could you send
links to those emails?

If you have already sent patches to the mailing list and they have
been accepted, you don't need to work on a microproject and I would
then suggest to look at the following:

https://public-inbox.org/git/CAP8UFD2Fo=2suQDLwzLM-Wg3ZzXpqHw-x0brPtPV0d4dRsgs9A@mail.gmail.com/

Best,
Christian.
