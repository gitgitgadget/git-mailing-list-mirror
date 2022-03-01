Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCA9C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 08:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiCAIWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiCAIWl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 03:22:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C546C935
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 00:21:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qx21so29815649ejb.13
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 00:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IILeCGuJpR+v6+Ih7aqLHpLRZrMCcg8+eSJuxvGgUUU=;
        b=Y7YsOcMAVh42XJrv2ZBB2IlzWR3gpUVBfETFz2LKfWbEdwf90UVJNIB1PlqMdsaRXZ
         woFSZ1onZu1aKFjfsDQzYcQOaT+qlV8zDTOUIywMtBgVInVPTw6BnIVMhSw6C3awGeA/
         fC9b+KD913jEzId0obsH95p3lJBa38pSeBAB5c+ueA7Rv4CEjfx9MNvbX2PhEzknane+
         tgduI1EcPcqOhwghLD57pBL/GoG7dfenkOkaFhiROn7rtym6NZnGC+LNz3SqN+ENl3v2
         fCSKKYnrue0q1OPt+VUrwo+Xqv517o4IwvZfZavN3uyK16312aqBU0m8+GMS+0RIG5s3
         2ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IILeCGuJpR+v6+Ih7aqLHpLRZrMCcg8+eSJuxvGgUUU=;
        b=5PuXhXI3o++ob3Xu9+cpf2gO53QQ2oxhuDM5GofffQKv9Ur2tVjlJ4NQ30XLAi3cGY
         q/BDBrXwofxCZ2RUjIM8joectTIbWssRvzs9JTwQRIKOe+BZzjzsd59uyTOUihMl0kNo
         wiH5ERoFeTEe93GpfBYcucwPE3fWaD2mzG2iGHh32Jf5ipHh9LVvIvfEZDNY3RyEtE02
         DjbAyGvfAgvrbzVACN5gDKXnI6nK9Xl/SRxagajAPyWEZNBT6hnkAee3tRC7/jTIcyLr
         Cer2yoURL06bKRDsN65lFE4D/LGp24zUC9QndfE9knyPfejhi6KXAqvRd7q1+emfgwM0
         1Dmw==
X-Gm-Message-State: AOAM533gH5yBqJ297oY0VOXNjlpcz7exUZYZDRyUyfFKh/qno1KWYbYf
        MamVq85EOS36jGYzLDWHu3ExrCtlt9C9thh6V2uImCJVqRmEUMIr
X-Google-Smtp-Source: ABdhPJxP47m2C+rLgOi29gt9BdmXbUHVyf5XBtodoZaxbv0U49VdT47uS8s5rL0ZDR0VtMSpWQ139kYHpeqgbY9B60c=
X-Received: by 2002:a17:907:7613:b0:6d0:ee20:8a37 with SMTP id
 jx19-20020a170907761300b006d0ee208a37mr17764501ejc.316.1646122917796; Tue, 01
 Mar 2022 00:21:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
 <76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com>
 <xmqqfso2zm6l.fsf@gitster.g>
In-Reply-To: <xmqqfso2zm6l.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 09:21:45 +0100
Message-ID: <CAPMMpoi_2iczL94jfVktH0Whnr8Gn-54cLgpH6Q0iM0uteQsyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] t/helper/test-chmtime: update mingw to support
 chmtime on directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 11:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The mingw_utime implementation in mingw.c does not support
> > directories. This means that "test-tool chmtime" fails on Windows when
> > targeting directories. This has previously been noted and sidestepped
> > by Jeff Hostetler, in "t/helper/test-chmtime: skip directories
> > on Windows" in the "Builtin FSMonitor Part 2" work.
>
> I was expecting that this will be applicable _before_ FSMonitor Part
> 2 and later.  This mention would probably belong to the comment
> after three-dashes?
>

I've updated the text slightly in the next re-roll, but I didn't understand the
bit about dashes... What is "the comment after three dashes"?

> > +             fh = 0;
>
> This should be
>
>                 fh = -1;
>
> instead.  More on this later.
>

Makes sense, but obviated by full switch to CreateFileW().

> > +     if (fh)
> > +             close(fh);
> > +     else if (osfilehandle)
> > +             CloseHandle(osfilehandle);
>
> In the context of "git" process, I do not think we would ever close
> FD#0, so it may be safe to assume that _wopen() above will never
> yield FD#0, so this is not quite wrong per-se, but to be
> future-proof, it would be even safer to instead do:
>
>         if (0 <= fh)
>                 close(fh);
>         else if (osfilehandle)
>                 CloseHandle(osfilehandle);
>
> here.  That is consistent with the error checking done where
> _wopen() was called to obtain it above, i.e.
>
>         if ((fh = _wopen(...)) < 0)
>                 ... error ...
>

Makes sense, but obviated by full switch to CreateFileW().
