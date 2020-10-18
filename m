Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64921C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1368B21D7F
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 22:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIXmifCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgJRWE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgJRWEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 18:04:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B80C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 15:04:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j136so10830365wmj.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dz7hXhkEJd3m2HC5Wukvv5mKOE2EptGZx1m1JXEhqD8=;
        b=ZIXmifCPsEHy25wS7xm+xYHDxvpyMqS8/DSyupWk1VgQLAfI5P9Isl4I7Thuhz1EYn
         arYDLA8smW+3KgfopTYcJGeBkNYiAhgDM3Qkpo8U+cngGX+oNSUN4HlrZEiYM6zUShO8
         hnL19oEsq5jyV7X0snNfCptmuhl/PcC5NGHdxYvMIbyHPXPy+PyWcSHIg7fZwYJWOCHc
         dVHDXVHXT7B5JgbP4k36caXXu2o7nF/SWASHaNZskK4tmKEBOuyzScmfrKw54/0tdtY+
         YtCjZ2SHwsay99uByMloFgXwyP/HyQ8/Mqx7NgJ/kSgpHo/p5MNObhUTrwR9U5tLWsy8
         e0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dz7hXhkEJd3m2HC5Wukvv5mKOE2EptGZx1m1JXEhqD8=;
        b=qge6uMII5Au8LikRPEr8kcRg9hl7KZ+oM2c/T6DqZrQdQJzyVaAGHEdp2quXbWuBHI
         Cu4BIeBTQa15CMrRMzyFPcLDCGyvKNCagescD14/5XpT4mLszsQGbBUu8KOTR7CDppYq
         KVrIbaWPfz++xBOiX35EyA30mzwIVSSM7BWkm2DkImHo6Dn7gDACM0HsEtmZNzk0W6tF
         badAlULTn5IgIgaPHp83yNEnuJCQK072M06nwSnsiGhAprXQoRqYS0Dlnezkrj00J48/
         O0GJTEfaLHf6S+frHkUiDfPO1tKpa+HKSg+4IiLBAY+TaIOBgtCFkc1/tNRwGgNp6oYv
         meDw==
X-Gm-Message-State: AOAM530dYfUmWOWNWMniT45IzhD1n9VAKiyjO4Dtt5WzyCN5wcmFp/PJ
        hQzXigzxBcMjlsxtXu3UF+tbRMp1SJsIfZGOZz0=
X-Google-Smtp-Source: ABdhPJwgGi5wulkRI+NUb8UG7L92mk0E1j9PLGod7AMnxKsnkhueSPWrfUpYP3TbLNQ61OY6vnpLWhxTawz54eV7yxU=
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr8461896wmb.114.1603058694020;
 Sun, 18 Oct 2020 15:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
 <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com>
 <CAPig+cR7Hm9m1EiWkr5tKYS3r_zJf98XT7OQ+-Jt4EWkaFQTDw@mail.gmail.com> <xmqqsgab7128.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgab7128.fsf@gitster.c.googlers.com>
From:   Amanda Shafack <shafack.likhene@gmail.com>
Date:   Sun, 18 Oct 2020 23:04:18 +0100
Message-ID: <CAGxm6oWAmL8db0ycsQ8QqUGugrh7MU8eOS8O1rt-ASLuwBayug@mail.gmail.com>
Subject: Re: [PATCH v2] t9832,t2200: avoid using pipes in git commands
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Amanda Shafack via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 18, 2020 at 9:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > precise, the subject could say:
> >
> >     t2200,t9832: avoid using `git` upstream in a pipe
> >
> > Nit: It's subjective, but it feels a bit more natural to list the test
> > numbers in ascending order rather than descending order, which is why
> > I swapped them around in the example above.
>
> ;-)
>
> >> When a git command is upstream in a pipe, an unexpected failure of
> >> the git command will go unnoticed.
> >>
> >> Write out the output of the git command to a file, so as to actively
> >> catch a failure of the git command.
> >
> > It's easy to see from the patch itself that the output of the Git
> > command is now written to a file, so it's not necessary to say so in
> > the commit message. Therefore, the entire body of the commit message
> > could be written more succinctly, perhaps like this:
> >
> >     Avoid placing `git` upstream in a pipe since doing so throws away
> >     its exit code, thus an unexpected failure may go unnoticed.
>
> Yup.
>
> > The actual patch itself looks fine, and these comments about the
> > commit message are quite minor, thus there probably is no need to
> > re-roll (though feel free to do so if you think the bit of extra
> > polishing of the commit message is worthwhile).
>
> IIUC, the microproject experience aims new contributors to get used
> to the style of communication that happens during review cycles of a
> typical topic, using a trivial dip-the-toes-in-the-water problem as
> an example.  I'd rather not to see contributors get into the habit
> of leaving loose ends and have somebody else clean after them.

Taken very seriously

> Thanks.


-- 

Cheers!

Amanda  Shafack
