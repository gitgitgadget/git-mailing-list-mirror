Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1935B1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeGRTHN (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:07:13 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33393 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeGRTHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:07:12 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so2229374ybb.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDAundTJC8wSB6NwxpFpgajjt+pgtNTnLE/Ss+YJjoo=;
        b=XHtopGTOUskS41NPKESUvALGuM7C1iNqRymjRn2uhRjB+kxRm116/rQZTgQb9WHsFy
         Vg7VDiCaiT1eIc4rdgX7qMSrCkrS0O8KfAB0+QSbzEgGmCNwZCjdBKIczhhLxsZVvMjD
         6nYPs1vWRMw9Sue6Vv1uqdPJb1E+XRjxdGPhfEyH+lWh8d5TxdevjlwG1I7r9r1yEDcj
         D/aXgGGkEvjNthZ5tMUwps8CGM8EZbiWlFqkiyqgz2jOCL/x5zEVjhpz5j/WKQqwh4bA
         9ACi1ChEW/4AfcGU5JdSrvzgwTGVA9qVE4VUfNZlqQ6Gt567P6DJgCgJRDDIz/8ctzbO
         J0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDAundTJC8wSB6NwxpFpgajjt+pgtNTnLE/Ss+YJjoo=;
        b=aZoc60apCMeIo0IGHxAe9dF+2SFFLzuCeZhtHiyoMvCIyNZJaoGvLSpihiTkAx+xxd
         09GQTxglVQ28UkTDvgfAoxbQ/HHskclxCK9W9zA8h0Hx0iqSbmX4axKO4uSmutcBgV+a
         QnnFjkjHWZohtwOskJnQd+7lZu2c+2KjpSkx/TsX3I/gEZabAoUhVIdE5N5JKNaMDRag
         LIE/2N0J3jX4eHb47JuxJlN3T8B+QcEdt3cyM5E8ci2xqcA7mXaYi5C5ZjcwlZRcgM92
         PvMhVvogvjxCMudezZ2Pktjc1YIj9tRSuFQ4XqVHAdvvgYq/FWfeYn7XWobqDd0UTbpg
         0QUQ==
X-Gm-Message-State: AOUpUlFb6/9KzFj4T01j80HYgzDjrn8bhWL4TeAe+2JhLFu8fvwDkNZ2
        3JAmZFZP5EDneqyyRNibZ3iEO7+ThdTTW5/MlHlW+dKF
X-Google-Smtp-Source: AAOMgpfGOrvONNp3MnI0ElThb2oUsP5vbwixGmNwhj/j2IjeRc+8CrbJMjQqskeIGipogqgaXntAz516gqoU+dBGnkA=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr3843551ybb.292.1531938484509;
 Wed, 18 Jul 2018 11:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180716230542.81372-1-sbeller@google.com> <20180716230542.81372-10-sbeller@google.com>
 <1f7b84aa-5ddb-431a-baa9-16ebb5020670@gmail.com>
In-Reply-To: <1f7b84aa-5ddb-431a-baa9-16ebb5020670@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 11:27:53 -0700
Message-ID: <CAGZ79kYnkfrrTRVOZx4iZfRK=s4YcMmPtk8zPDfvFwXeqRYo3Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] diff.c: add white space mode to move detection that
 allows indent changes
To:     Andrey Rybak <rybak.a.v@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 11:25 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> On 2018-07-17 01:05, Stefan Beller wrote:
> >
> > This patch brings some challenges, related to the detection of blocks.
> > We need a white net the catch the possible moved lines, but then need to
>
> The s/white/wide/ was already suggested by Brandon Williams in previous
> iteration, but it seems this also needs s/the catch/to catch/
>

Both fixed locally, thanks!

I'll resend this series later.
