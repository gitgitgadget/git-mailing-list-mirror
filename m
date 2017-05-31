Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788071FD09
	for <e@80x24.org>; Wed, 31 May 2017 17:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdEaRuq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 13:50:46 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34831 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdEaRty (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 13:49:54 -0400
Received: by mail-pf0-f178.google.com with SMTP id n23so13881923pfb.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rs220Q+LajFZsMY56WcrTSxI2btMx72yVjCukRT2aWk=;
        b=tnE1rYW3kNqvUl16kYv79Bjf6+MIOhY5UUvMxx21glM7K91YsPNOJUsSF+Ublm0324
         W0aad9i68I+F0disAY7Uav8A9MscwpLUBHN2PHfKfIPSg0mQHBKAko6x+gFAYaW8GjEQ
         uHOay2tIGs9nYa875uBRDW3+c8wgGk+UEYTqsroQ4jggIIVC6RV14ICUS76q7Tps1yKi
         3Qt8g2WBmu9bpaluJ9RotUhbdvy10VitQgMEjDIURwuVczmQq5cS/IDh+mkKy29JIMgR
         MJ+qtl4yxQf9pG8fYW9c+yL3bLSg6nTZK7L8e6noSptLAO4spW7DvOwbZ7HOUrBOxQF0
         7r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rs220Q+LajFZsMY56WcrTSxI2btMx72yVjCukRT2aWk=;
        b=kQhMTex28zIBcMGXfcnAPc73tYysTCMi1ZnWr3bVhu1krVzdrGRvCLlSNrESiT9LUN
         5bk63KPqTzacKz8WWhnAX7q6pGJkx1EncXIfV8iedGeRbJj3Vsat+vbmYsbaQYTDGw5q
         I4135r/FOG8UQl8ECOZKBakBQVu4DYH4QukLIKI/t+gT+PQGlEUjmbjki+g8Dh0fFgI+
         c7xY8suNhobJooEXPekHwWfMedTpGE1hmzDKe+fEljSibR3mvxAcWwIQQy7RYJuChugM
         8wr+0nFbseVPn3H02shPmU2Pqlx5subtmbaUf05Q9fwW25n1scyPbMzvrwz6G7BWjm0O
         f9qA==
X-Gm-Message-State: AODbwcAd+g8vnjGkJ2a+AarnMH3ECkkjKi+FRew7mXWVhBGuKRihwTjQ
        gFPCUOvd4Nmvn6NgQ2QAMMXWbHNlQJI0
X-Received: by 10.99.126.92 with SMTP id o28mr34810364pgn.63.1496252993902;
 Wed, 31 May 2017 10:49:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 10:49:53 -0700 (PDT)
In-Reply-To: <20170530173109.54904-21-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com> <20170530173109.54904-21-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 10:49:53 -0700
Message-ID: <CAGZ79kbPaWEuZr1yXKnMwUeLzW4h_pnD-f2bEj7dyE7Q12z2sw@mail.gmail.com>
Subject: Re: [PATCH 20/33] combine-diff: convert find_paths_* to struct object_id
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 10:30 AM, Brandon Williams <bmwill@google.com> wrote:
> Convert find_paths_generic and find_paths_multitree to use struct
> object_id.
>
>

double empty line?

Unlike some other prior patches, it is nice to see a commit message here. :)

Code of the patches up to here looks good.
