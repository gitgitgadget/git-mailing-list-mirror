Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59770C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 12:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1548B6101C
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 12:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhD0MZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhD0MZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 08:25:28 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD53C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 05:24:45 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id t21so8560929iob.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K3InP04+u9YZm94ggCapDVREcXy8orPW/jEBlmVZGEA=;
        b=Zor1X1d2iG04c1EweDkq/2LihxfEXXW1l/dfvEUOOS0noi/Z/WVDTpBz62JUuPzHNX
         Q3PHxccomxBjBN5T16SFMsyorvjwpOrmN++QmUeklAxP3HetkmWpCj46AjXHop3IcFAW
         SfijWSONDQ1/q8bVdZNjmlL7AakbxP0w+IYt4up2ntVvn2aICcP7732G7lTBaLUVlq1D
         Zv03eYRLWQf9KhVfo5d2YsulJB8mDiqyejKXr0ss+4AicBbZtUBRRmSyx0Ljg3VehND+
         6nDso8cLrziGKr5EIIjG67gB5yQpCuDFvxBQWywUcFwpdQYnw10DxyKHkv18lCW6xzec
         E4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K3InP04+u9YZm94ggCapDVREcXy8orPW/jEBlmVZGEA=;
        b=lecWwS5ml/UuIV25DdMmZZuTmcNJ9+Jlyy3IOXifDbSDNQco47gC02UPxazdnx7NVu
         6iBfrRRxWSWmnCKDji/nr/qN5O8uNcI7fJ8CANITALmjGchUpKW3C20UnwMeKwtIbpxC
         vjJ0eoSGUuky0awI+2M5+M+2kyeaHz2/gR7i8gAvJ/rrFCy8POmhOg5QXlTCo6ZyqnEW
         inRtciLX4qPYuQQgYfM51cj9kFOa08HpWhkBoIYCHpR5MgLTBanDqRp80uC1LzNufzjm
         LuVOs0us5tjX+zkw/sgfxrJ2pWsFxVb4TOAvR34iWZiFRNZY//zuKZ66Tyk3fCS76pf5
         gIkQ==
X-Gm-Message-State: AOAM530ApnxG5r7pLwRjwiUArfgRtTYvga+hD5kBTUB46sElAWQufJGy
        qFKyTK9WtnWOpx9Yhbp7z/SUMQ+Oo6t3EU+ikl8=
X-Google-Smtp-Source: ABdhPJyNu22i7PTPcQdTBppZjRsGl1Ai4LDmxNL9+1YUEGWtib8w5aTA/HrSKdo8HmZQ6qyxFOy1qwkBpJ2K9wRP6vo=
X-Received: by 2002:a6b:d213:: with SMTP id q19mr18774358iob.203.1619526285264;
 Tue, 27 Apr 2021 05:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
 <pull.913.v11.git.1618672417.gitgitgadget@gmail.com> <xmqq5z0kbl8x.fsf@gitster.g>
 <CAOLTT8RKCV+Kpya-_AVjuVGWzs1WtGS8n_+sD0FVzwEpeXGwCw@mail.gmail.com>
 <xmqqfszk1ot6.fsf@gitster.g> <CAOLTT8QUA+m1W6-v=ZA205SZo8G5GBKMzJHBzU8DuQSTKiPUBw@mail.gmail.com>
 <xmqq1rb3xl3t.fsf@gitster.g> <CAOLTT8TciU7rvmEgXGMuVCMDN6HjMadL-L=Q9kej6=j6ktJHwA@mail.gmail.com>
 <xmqq35vcfchn.fsf@gitster.g>
In-Reply-To: <xmqq35vcfchn.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 27 Apr 2021 20:24:32 +0800
Message-ID: <CAOLTT8QrX3sk1U6WM983pachj8q4fmW7jxEViXd4-Y-aSR1JeQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:49=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Now I think that we should keep those trailers which ask for a
> > "name <email>" pair, like "Helped-by", "Signed-off-by", when we
> > provide a "help:","sign:" in command line, This allows the user to
> > dynamically fill in the "name <email>" pair of other people in the
> > commit message later. It is worthwhile for users to exit with exit(0).
> >
> > But those dispensable things like "Commit-Count", It must depend
> > on a person's statistics in the git repository. So "cnt:" is meaningles=
s,
> > users' script can let it exit(1).
>
> Perhaps, but at this point what you think (or what I think) does not
> matter.  That was the whole point of letting .cmd script signal Git
> if the result from the invocation should be kept or discarded with
> its exit status.  What would be sufficient here for us to do is to
> agree that it would be good to have a minimal set (perhaps a pair)
> of examples to demonstrate that the script can choose to keep or
> discard a meaningless trailer entry with its exit status.

Yes, I argee.
Due to previous attempts, it seems that such an example is well given:
"Commit-Count" is the trailer that should be discarded.
"Signed-off-by" is the trailer worth be kept.

Thanks.
--
ZheNing Hu
