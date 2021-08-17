Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E140FC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BF660720
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhHQJX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhHQJX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 05:23:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DFEC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:23:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u3so37345343ejz.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdnuPDSswQkM9fmVVe0Mq88lyIQFHEkb7oWU9k38TAY=;
        b=kPd6Ow0mLs6Wieh1lKPnleiMp6xNincbsSoB/aNkEIWKHaSKpdczNk2embWhRpgufa
         beqlHDOQU7IEzDFWHDoShKhv9a99VAHypyLoCpbxqypmzn/BUBY17Kq2RW2Gk5sBkbIl
         A7ZBq2r90asy1ffUqLklgk9APbk6qDpOx3RhjuIpOs8Qc2TcTcyQwW3a2dYTd4jSf/zu
         nEYVr7E/QNvue/X2Xyfd12ikTTJEUcv4eeY7bnK3oirYHw2Lbzhrj/LrUeAfpTLunC7X
         SnJ+9qdzD+35JPILq7LJJpnKMgHgREBrb0N420ze3JAzZcK59bzu/sH3cztJa7U15Ofd
         W0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdnuPDSswQkM9fmVVe0Mq88lyIQFHEkb7oWU9k38TAY=;
        b=CjTwAHAiULCQCvr7k/EAnTod+w2oEjM7nfAQMd06DomdtWvFAF5YIjIKjHGObeepXv
         urZzeV6PpLiovnDePnvdIuhrUhGBivQ6yUIqAMpRds+zQVpDxLrJNqy3wjAb2xX7Phq2
         xTrKWvYNEZsIw9jja6/2DiqmkOtxl17YD/QaOtm3zK+4zCsz/NzO7CmjsTKI1avsUIAX
         UJb/v/C5OPqlgRhwq36HAzyMmr83bMLdvQNqPFRxfqixhWoJXzd+vKWJQHnmQAIYUn9W
         rJ5yXXb9BroAJNSbCn5vUthAcBS3bzAeQFkAQWcO5CHqXnNyoMVJfNMN3mz+vmv/bMER
         x2ug==
X-Gm-Message-State: AOAM532iJPEAiy7m1KnUGppO4YnuPA+s4odAEimQPD2aV/bmr82B7s+9
        IwykFtsHfi7OMlpZkRhQViWh9L1YuBZ6St34Cwc=
X-Google-Smtp-Source: ABdhPJzqx0eS4KXZDsb4SfHvAHJxeMIhNP3hy4TjnAa+TCiCmCF7FCscCC3rIa1OLR/Y0GxiWwrbp9jF+LVMFIHCRj4=
X-Received: by 2002:a17:906:8808:: with SMTP id zh8mr2930382ejb.211.1629192205074;
 Tue, 17 Aug 2021 02:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-2-mirucam@gmail.com>
 <3dcf28af-1e75-0934-4663-3691b0efde1d@gmail.com>
In-Reply-To: <3dcf28af-1e75-0934-4663-3691b0efde1d@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Aug 2021 11:23:13 +0200
Message-ID: <CAP8UFD0RFm=CBsckhdBJKJ9QAw+hWT0yY84J4dNcaXegRp4u0w@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] t6030-bisect-porcelain: add tests to control
 bisect run exit cases
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 11:03 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 17/08/21 15.14, Miriam Rubio wrote:
>
> > +test_expect_success 'bisect run fails with exit code equals or greater than 128' '
> > +     write_script test_script.sh <<-\EOF &&
> > +     exit 128 >/dev/null
> > +     EOF
> > +     test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt
> > +'
>
> This only checks for exit code equals to 128. You should also check for
> exit code greater than 128, for example 255.
>
> > +
> > +test_expect_success 'bisect run fails with exit code smaller than 0' '
> > +     write_script test_script.sh <<-\EOF &&
> > +     exit -1 >/dev/null
> > +     EOF
> > +     test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt
> > +'
>
> This test looks OK, using -1 as representative of negative exit code.
> However, wording of test name can also be 'bisect run fails with
> negative exit code'.

Actually I am not sure that it makes sense to test an exit code
smaller than 0, as POSIX exit codes are between 0 and 255 (included).

For example:

$ bash -c 'exit -1'; echo $?
255

$ dash -c 'exit -1'; echo $?
dash: 1: exit: Illegal number: -1
2
