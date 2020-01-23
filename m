Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56950C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129F4207FF
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGflTnkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgAWWvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:51:22 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37224 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgAWWvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 17:51:22 -0500
Received: by mail-ed1-f51.google.com with SMTP id cy15so223422edb.4
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 14:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBY59U9X84oTN8hOQ+16Z8/F4EsjhuqgAbr3E0HGhXU=;
        b=rGflTnkFeMEWFnhOH0EQOtF45KQfCoufTAfQnl5urY1Y+MNasLVMLC8BvcNu7jqPPL
         6mIhhigN6KZhu5qEwWnOy/iBUK+7MCa/mGQY5eq69/oc8/FBv9fP5DSY0WiL+8KheovS
         eCbhodHxJdEsLJw6ACN9Dz6/YmAGRSJAhYh+Tx7B5Jwi/hCU6lK37BAu7rojGW9P6Qxc
         NTQ5/z4ed7ik9UF/C9ved44XOgqpZVD5BvRYRFgZZIGTRl+JuJgIJI9yRqTWRlEwCML3
         aLFDwxe4v58Zn2TMydENC263RWtELm0JtmLpkaTMoBILTgRIsAJD46vn4curaXN2ASb5
         d4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBY59U9X84oTN8hOQ+16Z8/F4EsjhuqgAbr3E0HGhXU=;
        b=Rwqdh3uj0RvooJlKg6A1tbQ6rxRJqLjqQSvQ1njOjbK8JhrRtef24UH2+D57Wr1LsP
         b7NX6zVrO38N9A5JEQ9tz6Dv513NYQnDZrwGvaHfj6BJAQKM8km/Q2/RKiQ51Dclo66y
         lckZ1E317psUIYNK9AV2/PJnTFkCcpxdrWjAFJfJZEMo3gTsWtKAH3vVM7e7vWBRgYN7
         EhxmW0eRU/M6QDgRbTyHFkRL6teaUNuutyjgzFr5vlFx1Opj9iP+cPpZ7U8GWRk8zFti
         x/xlCXbqttiWLP9oQAzd1aOx1c5ORKSWQNk3XpJhQXX7pAk5tSi0MRdDQj3PFGkFjnaF
         qJjA==
X-Gm-Message-State: APjAAAWgKS+E4FGJLC0/qRPyzq29KGH6oKMHtWKwggmNUQz8xRoSLZGH
        p/XaSY9OOa6M/NezPHT3SbZlHodc64tO3oQz/xA=
X-Google-Smtp-Source: APXvYqxmNb6xYpjAqGWxJOFe8fYid5M2ml0OEDcq0peHaplZSGlKYn+ykv4Zl3LxbZpiAV4NlL1/A8C9UEVZ+cIinag=
X-Received: by 2002:a05:6402:17a4:: with SMTP id j4mr128911edy.362.1579819880149;
 Thu, 23 Jan 2020 14:51:20 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2Fo=2suQDLwzLM-Wg3ZzXpqHw-x0brPtPV0d4dRsgs9A@mail.gmail.com>
 <20200123180421.16720-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200123180421.16720-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Jan 2020 23:51:08 +0100
Message-ID: <CAP8UFD0jwWREegw5h7NOk1DJpu7AjpSy6yp8KiUJwK8OzFQ8dg@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 7:04 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:

> Thank you for your advice! Apologies for not tagging my patch with [GSoC],
> I didn't realise it before. Is it okay if I try solving a couple of issues
> and then focus on the GSoC project(following from what you advised)?

Yeah, it is okay, but we ask for "Only ONE quality focused
microproject per student". So solving other issues might not help much
your GSoC application.

> Also, I wanted to ask whether or not one can try attempting the projects mentioned
> last year[1] this year as well?

You should probably ask the persons mentioned as "possible mentors"

> I observed that only one idea[2] was picked out of
> the aforementioned project list.
>
> [2]: https://summerofcode.withgoogle.com/archive/2019/projects/5390155215536128/

Yeah, because one GSoC student suggested a project idea on his own.

Best,
Christian.
