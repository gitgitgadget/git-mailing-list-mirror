Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4071F462
	for <e@80x24.org>; Fri, 26 Jul 2019 23:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfGZX3B (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 19:29:01 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39421 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGZX3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 19:29:01 -0400
Received: by mail-ua1-f65.google.com with SMTP id j8so21856086uan.6
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1MKPVdpdYXrbjekS1Mfvsqe5ltBvsD+cf2DFnXr8aA=;
        b=eyjRNl5DuXO86QQjG461hFUxfWVs+vqAubTfVU+VBgkIARntIppkRtIOzK+TRA8eBy
         Z+/T8iIhe/6bVZ27aXe+1A3N/a+jcroRFMotxV/BnDR/TseUt7w1RJ06NFN1Nob071AC
         HFNJttFitaeXZ8+G+2Ak/Fk6eSpL4zC1MH7yUcyXBdPJ3Nzx88o/rDV1eECCVZhmIdtd
         x78oX9F2Fb6frtpVzQA3y67h9hymHzLwetO4Xs+33RJFcEgCt4qlCvUehUHfMolgecUp
         OXRjX+feBCSurbld7AQyT1FyVY4nu9cPdyYs+tU/MwyonJ+sDhreKO57MqspLA3S3mp2
         AvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1MKPVdpdYXrbjekS1Mfvsqe5ltBvsD+cf2DFnXr8aA=;
        b=iXCGM2jvAx/pWbjSB9B1yoMeofgNE1hY65tO/YvC1ux67KXFjyYudAHGf0vECKaiDS
         RxRivc4UILVB6UyunISdDAFR7QxEqi+OHpcvNBIsCrs/e95jxlXhS9GWmfjzODx8TvjR
         zAArRzwgyTgz1qZZECVnA06UBPwrFyJ0XlF7koin391LKoQoGdUgwn4HeXAZxndZ5lkJ
         WzT3TIAgMJ2CJYkqpH6sxnkFQNmUmM1o7Vv0Dmn2t38WczS8TdeFTIaz2ggQcDgs3n01
         emmvNR6UVIcGM+5e+3i5xYMs2xKLIxOlWvUbYvswGN2xrj4ApUDkO3GDslfsTsI0qXjv
         x12Q==
X-Gm-Message-State: APjAAAUUWXTo6603fQHcFEEunZw1tYEzCkO9nfyyfSG4opNv0PXjqOeb
        uN15i9trwHPUNMeac97IVWoMluGrvr/6mzjud2U=
X-Google-Smtp-Source: APXvYqzLT0JEAXC7eVLu7RNZouJtVx2rFRJ91rULZ1+XxuFvOuQfAb+vWa+iV9CHzJdChcwU6+HGX2hzwhb62eJF/F4=
X-Received: by 2002:ab0:3159:: with SMTP id e25mr12440890uam.81.1564183740641;
 Fri, 26 Jul 2019 16:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190726155258.28561-1-newren@gmail.com>
 <20190726155258.28561-7-newren@gmail.com> <xmqq36iso9gb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36iso9gb.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jul 2019 16:28:49 -0700
Message-ID: <CABPp-BG35XHN9H9VBYw4JMHknftMhB6u3H=CDFHhM7EMinQNSQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] merge-recursive: don't force external callers to
 do our logging
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 12:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Alternatively, you can view this as "make the merge functions behave
> > more similarly."  merge-recursive has three different entry points:
> > merge_trees(), merge_recursive(), and merge_recursive_generic().  Two of
> > these would call diff_warn_rename_limit(), but merge_trees() didn't.
> > This lead to callers of merge_trees() needing to manually call
> > diff_warn_rename_limit() themselves.  Move this to the new
> > merge_finalize() function to make sure that all three entry points run
> > this function.
>
> Interesting.  It seems that b520abf1c8f did a suboptimal jobs but
> this step cleans it up quite nicely.
>
> Are there callers of merge_trees() in other codepaths, and do they
> want this change?
>
> There is only one, builtin/checkout.c::merge_working_tree(), which
> is used when switching to a different commit.  I think it would not
> hurt to give the same warning (but I also think it would not hurt to
> simply disable rename detection in that context); we should record
> the whatever decision we make in the log message.

I was surprised to read this because I thought I did that...but I
guess that was in patch 15 for a slightly different case.  Yeah, I can
add some words to the commit message about this.
