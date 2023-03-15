Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01FC6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 02:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCOCwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 22:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOCwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 22:52:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A53755E
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 19:52:51 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c11so13253840oiw.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 19:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678848771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdE/3YsVE17aZOkNj4doatn0uOyiRd5mh7Oy961g5qY=;
        b=MEY+xBhl7G15ZvrDJUhV1NGaKEq7Fm0vy8JZAYdWg0nf+MIk/s4r5ZVeOtlZn6tcOQ
         VAaafhBQAdb+/ApU6YJfuuRTMfDADC+i/pooC6Lv7q9jgliNc6tqXjrHV1pY0D80Skzi
         H6IBMgHRoCpf8LgqZI9icbszmDs5WsPh41gosOin/VYU/0e45vrrfICFqrpkMKXv+S9o
         1Mc86a9Otl3jsRBpu1bK1fMOniCqroRCDKhYJA2fUfMf75XGNr4aPCs6qiadNGYfHTfU
         a/8PHTFuOAXNH7/RzqvoIC6X39zc8dyQoGSNl//qRHnDv3emyNYyLBmX1aCY+JgHMcy2
         PK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678848771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdE/3YsVE17aZOkNj4doatn0uOyiRd5mh7Oy961g5qY=;
        b=IhVoiKNlZ91XvkXd/SmKHjXYwl6WzD1DLkbX+FgTElL+S9it98Dg4i+x+tOba0s7fi
         scdVrWNxZck1s2bPcFSMuMAfc6sSflkK8gJ8Bx+cpCHzFwDmxkjSZ+TaR755M+O2f/vK
         3vks2+8cxUMfJXceY1TI9Lnj+yWVva25V/r5Y7fxztPHHyJe24RVKq/kmbkdHO4Gqt6p
         /A5MMWOt/vNwi2KqvbjD9DYBTTteRl+WxM1EXobkokkExSnKBLe4qhmLwlvthIG3w8JP
         i9KVhhA8pe9b1Kj15vk2uMOWJdDsKeUI7BtGKNyl4fJXHxQ4ajMeFxFZQmQHnt1UjpEf
         panQ==
X-Gm-Message-State: AO0yUKXDfdNWMul11RLYrLfKFxilo7z6EiifpOHrLGAuPnv/F7nmGnhA
        5MKNFLZ8WFEu0ZHB9nrsRIdh/zjw54TGUrzuqGE=
X-Google-Smtp-Source: AK7set89YNR1whGzrw6lZHX+JeuwyZgcOxYeniqT/ECAX+RQ6Rzw/Gl/FYotC8txuSTz6r9opNA+MNij3hp4ewVZILY=
X-Received: by 2002:aca:1c16:0:b0:384:4e2d:81ea with SMTP id
 c22-20020aca1c16000000b003844e2d81eamr369860oic.9.1678848770794; Tue, 14 Mar
 2023 19:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 14 Mar 2023 20:52:11 -0600
Message-ID: <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2023 at 5:02=E2=80=AFPM Glen Choo <chooglen@google.com> wrot=
e:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:

> > In the future, the default rebase-merges mode may change from
> > no-rebase-cousins to rebase-cousins.
>
> I suspect a more likely future would be that the default is to rebase
> 'evil' merges instead of trying to recreate merge commits, but of
> course, the important thing is that we promote the default, not what the
> default will be...

Glen, do you have any more thoughts? At this point, the only thing
that's keeping me from implementing Phillip's request to make
--rebase-merges without an argument clobber rebase.rebaseMerges is
your suspicion that we might need to change the default rebase-merges
mode in the future, and I assume that we would want to use the
rebase.rebaseMerges config option to facilitate the transition.

-Alex
