Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D37C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2CB61052
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhISCzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 22:55:19 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38774 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhISCzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 22:55:18 -0400
Received: by mail-ed1-f49.google.com with SMTP id q3so46185710edt.5
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 19:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XePZoyfC7lGXP4cz7qUS7E+RAqkNKK5mWh1E/qeN74o=;
        b=1ZvRbaC7pCrT3jilHGa3Amrp2lXws295gmLxpGCeMper4S09K8wfAGssBEh9sprVLM
         S0PoRuexwzDAzU6eudUuCApi86+Yfa/0GTtgFLq0q5mQkMq4gOJpzMrnKnTYN64tvSXf
         Xc2tKsiQnSq4y34qLWYBCdlrOA8H9Q2/K06KqCW9Ya8J3leLeGz0TBtXugLoFcW5dcBb
         +kYjEf/uM1qP+M5CU4z3w6J+KLZuLRK2z3esryibvwCbv3w5YMCu72cWS+PKYIA8N76p
         hYTc8/TFqlsV5D0L111CRLZqy1y3eTk0vFkSPJNfW2wUUjN/Nn6eg2gF6F/cyOObXS1Z
         g1gg==
X-Gm-Message-State: AOAM530oQw+FsTkFT99BqcRV/nN89UOhzW5I7WlxfcV4SKwNxlNh093k
        V8fG6D6IC49HqPMZ5cqa2G0RTwGRJfv/mlRggNnZ8Y1M
X-Google-Smtp-Source: ABdhPJxU7EVUb7HcMLjwAMlGFORENNnebCpq7418uzs8ddVdqrNJS+JwyiX7RgjHmCYHUscvOgUw1PtCNTNpQPGAyII=
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr20817220ejc.72.1632020033249;
 Sat, 18 Sep 2021 19:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <YUYLXKN8U9AMa5ke@nand.local> <YUZinXsGdL19l/tQ@coredump.intra.peff.net>
 <CAPig+cSSxgVU47wCNpcW2HTwCA60e1oZ6Yzkb5i-W2HDijq+MQ@mail.gmail.com> <YUaeUuX7aoXtS3jQ@coredump.intra.peff.net>
In-Reply-To: <YUaeUuX7aoXtS3jQ@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 18 Sep 2021 22:53:42 -0400
Message-ID: <CAPig+cQM+pkorVv=xBaVjJm9n99-8ZnO2hqY7YyrswwcFshaHw@mail.gmail.com>
Subject: Re: [PATCH] connect: also update offset for features without values
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 10:20 PM Jeff King <peff@peff.net> wrote:
> On Sat, Sep 18, 2021 at 09:02:37PM -0400, Eric Sunshine wrote:
> > Or just use q_to_tab():
>
> Ah, yeah, I forgot we had that. I _thought_ we had a variable ($HT or
> something) for this, but it looks like we only define and use it in a
> few scripts.

Perhaps you were thinking about the LF or SQ variables defined by t/test-lib.sh?
