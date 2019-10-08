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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8466F1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 16:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfJHQQ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 12:16:59 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40385 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfJHQQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 12:16:59 -0400
Received: by mail-ua1-f68.google.com with SMTP id i13so5365679uaq.7
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CBtzG1jDZkr7QevpSA+wyotQEn8LP5RAEdR05o9fCQ=;
        b=XGtsa5bgPJz67pZ/QSWpnw5oFzMsQ14fpKbjXArvxnaspJyhzy9udD3bw4ceuYM5Uz
         jxmNgKFq1/0KZT44wfddKOWVPGjCJoKSOm3qroUqRpiqsoGWUCBCpRVMtlE8zRbUFqWY
         je0ZxnZT41LeUz+KoLK5g/4iE0t5/ERaN8KIbcxt7qltsN6HmMMgOB/UeGgsemVh4Aqa
         ULrdvPfOSQXZbNNU1CubaU0MnZl7vytf1weg+xfbgcy84SFrLPztTwF29jF0nWmtkH2u
         92oMpVKxrPGkgjL6xQ71R1feulWrhNeCI/Mx9vdBBgu3xseyk4n/e/+5o93WpPIwP8gj
         0ZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CBtzG1jDZkr7QevpSA+wyotQEn8LP5RAEdR05o9fCQ=;
        b=lSArXTJ2eNd0rfJPUlnAmfPQckijSsEG3Rc07x5ADBMh6gu0fAyYK9BjUcIOS8qEt6
         uZYlyoYS6FJ2ci+kZPXw38nNAFVitEmXpcjEP16ndpocR9CsZGcY3oxpqaskYlkjWG/C
         AZceE48ZrDCjyJAC0U+9VBAA7gSf5+hkkdl6uCoOM/aOrBEfB3j3wYFVu732Y6CJeTYz
         Tj2JDoB+oIxhl/3ihH9NIfiw7vRoK7snZ+j/ELFxa0SZOxanORwWVw9XZVPlMg2orNeb
         NvWMEryGsBDD8iElQx7xWneuObrdY8oPTul1t1ZHWbhqhQoFhCrBYkQTNLrirptldFN5
         RwVQ==
X-Gm-Message-State: APjAAAXIeZrL059lhw7UvoZ5bV12yAem9OknPWkgDbv5GAm2ouH9uu7N
        kAWCXByVyilmyqmfXCKdB/TB2qA4EsH7EigcIS5PaI27
X-Google-Smtp-Source: APXvYqyyZNqyYomC/FIimMew/YMiFiHg8gTzTxcfjsz0yYpnDdhJAoF71fHl8/OIx4PTpy1Lx1JkG4rPt2ErYm6yHiQ=
X-Received: by 2002:a9f:31cd:: with SMTP id w13mr17846568uad.81.1570551418170;
 Tue, 08 Oct 2019 09:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7e5h46an.fsf@gitster-ct.c.googlers.com> <20191007155211.23067-1-newren@gmail.com>
 <xmqqr23oneui.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr23oneui.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Oct 2019 09:16:47 -0700
Message-ID: <CABPp-BG-h3yDeDQqa78WisnXNzqsgmBx7T_MS5LbSx5an-FQLg@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: fix the fix to the diff3 common ancestor label
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 7:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > In commit 208e69a4ebce ("merge-recursive: fix the diff3 common ancestor
>
> I think the above was an earlier incarntion of what is now known as
> 8e4ec337 ("merge-recursive: fix the diff3 common ancestor label for
> virtual commits", 2019-10-01).

Oops, yes.

> > label for virtual commits", 2019-09-30) which was a fix to commit
> > 743474cbfa8b ("merge-recursive: provide a better label for diff3 common
> > ...
> > The handling for "constructed merge base" worked by allowing
> > opt->ancestor to be set in merge_recursive_generic(), so we payed
>
> s/payed/paid/

Ugh, two simple mistakes in the commit message.  I see you've not only
proofread the commit but fixed up the commit message for me in pu;
thanks.

Elijah
