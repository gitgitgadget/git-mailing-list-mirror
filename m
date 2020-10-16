Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4A1C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 12:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F42158C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 12:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIyNdXdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405210AbgJPMkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 08:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394753AbgJPMkH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 08:40:07 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9FC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 05:40:07 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id f2so577032ooj.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDiUckgNco8GbnP1jS9SVbWiV69C6UzW56p4u1hJRmc=;
        b=rIyNdXdRXPee3yjDeFGNaQPT/Q7H3ObG5gH5NfR7R/bblZEcVTwhtq6RbIVV9YEU9H
         khVqfVxEmC28000aUbDy0/b39j3C4UZzkKNgm83mC85kQeZhr+v9ftOgfHN4T/LMS7xZ
         e81Fyi+/uw9ZPoAMFLGdiItSrdqP8lLcBi+/J55nYjQujjDQcXh1yfDAIGJhCbVBzSR6
         s5kb5c4hZT4joimSGCehuNJBLNmGB5X9uPDYAeNXdqiZFqcdrZMYIePYGgvMljIWO83p
         gUTpNA6AmITpzLND1HNLqzTaqdbptcFAtIhKPagn8y3Wonep8e/zzpJ6raknULsfGPZd
         xc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDiUckgNco8GbnP1jS9SVbWiV69C6UzW56p4u1hJRmc=;
        b=EKKpFw4iiuy+gvnaz039ARe6iVoo2YmzM+H8IAUEnXiZSMrWPAqOaHVX7t/N05vx2K
         nil1zknU2pkXvop90FX/tw0xlaP7i++frB0An+/aNEPUr2IJ1GY4ciciMqaVKui2myoe
         6jZ1IQgpf91DDJKOzc1jcf4I7xlwouF1uxB3E17bg9VGhc0gj7d4MYvssRRwdTDovWjr
         uktuUrQj/o7f6JxX9uazKGX7q7iz5hPQmWjXZfFDVnKHW9VXEod37dYUTb60ukqKsOfk
         OTowDmszR75ciBEsZ69aEQrqQMle95Q7tyIZlGFnfQjgD8NfUXepKhYEgDM2O5QHUu3j
         apbA==
X-Gm-Message-State: AOAM531Fl0bhcgK/A4ovra2BnhZ/vWwW1LyVbPKNnUZzxgDFXcAbDmGd
        FmEFakH7IjoL85ChoejGB4nOr2BbLRFIrOONpaE=
X-Google-Smtp-Source: ABdhPJywDnAPr30Ur9bAZimq0o5SJJFhw6oJ3s5fUwnxVRAWYAghnbCluBqEV64z7xE/JKu5WGPq26LVjEHV7FElWgE=
X-Received: by 2002:a4a:d654:: with SMTP id y20mr2560690oos.90.1602852006740;
 Fri, 16 Oct 2020 05:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
 <20201015160725.GA1104947@coredump.intra.peff.net> <xmqqk0vrfi1r.fsf@gitster.c.googlers.com>
 <20201015194158.GA1490964@coredump.intra.peff.net> <xmqqsgafdyri.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgafdyri.fsf@gitster.c.googlers.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Fri, 16 Oct 2020 13:39:55 +0100
Message-ID: <CAN8Z4-Wiun-e1s5v2G_2qucy_BmWm=fomd=t3=ZU=9KBu_cVCA@mail.gmail.com>
Subject: Re: [PATCH] dir.c: fix comments to agree with argument name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alex Vandiver <alexmv@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sounds good to me. Please let me know if there's anything further I need to do.
I'm relatively new to git contributions - and my understanding is that
at this point a maintainer would merge the commit at their leisure.
Happy to do any further cleanup required to make that possible

Thanks
--Nipunn

On Thu, Oct 15, 2020 at 9:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> Anyway.  Nipunn, can you fix both of them in the same commit, as
> >> they are addressing a problem from the same cause (i.e. we are no
> >> longer SHA-1 centric).
> >
> > The v2 that Nipunn sent with "oid" in the comment looks good to me.
>
> OK, then all is good.  Thanks.
