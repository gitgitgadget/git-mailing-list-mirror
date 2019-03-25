Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B4120248
	for <e@80x24.org>; Mon, 25 Mar 2019 19:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfCYT1D (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 15:27:03 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44097 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYT1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 15:27:03 -0400
Received: by mail-oi1-f170.google.com with SMTP id i21so7929658oib.11
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RZiaDKEoIYpUobnXXTdnXTe0u+XXsnDcIJxIHkpXOeQ=;
        b=lOVuVTM6KMaSRCyWfoX6JhlgM0Xl3FWq0s3+mkAEqYcBOgErUYQmuQ/3etT6aGRlqL
         utxRMFWbbS7wqp4J97GzZIHqsc4kCjNjKkO7vyf8ofxHeUKz1mP7GCTHYouJj3jKqFnX
         v5WvVA2GTTxet1Qu6s3RynVUHpk39T/fLecRwR91kgHrpHlqTy9n79oymxnF50HT13cz
         x2hOt0z+LMhWd++s4aOyNwX0vdb42S8PUxqN0UumfU+/MgZLtXF7/nU8gMQuUCY1qx/Z
         cQM5rRw+5Hi8VUUwnsjWmRV/t7lHPj1nOEYnfQOWaFa20SJDwXpg6hbJZtLFh7xzExNN
         gtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RZiaDKEoIYpUobnXXTdnXTe0u+XXsnDcIJxIHkpXOeQ=;
        b=I7FZRKRrmRBOHkvchgP3B6oH/iU0fi7aUKRmHZACrKxMuehdTGhtgOfB43XXDXa0Mv
         b4YCagwDepLe7QGYzeMzdoDi9tTHwzTkt4R1ken1pbBgaYQAUvd9CyTZuUPOlNcYou/b
         X97ONOxIXAosHRtmdppoBCDMvMQ7I6QOFrF3fZk2AmiAUTku0g6m/QaJq/a+GIo2N7My
         uVpoBigNYepdat0h+VSvhA3Hq6+T6IYkex+cxipkhQgtAXqCPck14G4HwGxE7a68ze3s
         6QEVF3X67ZnU7s3RoqhYnq5IsGyVOFg8fQQkpWzUsLMa12NfUxgz0lODxQY9SlNR/72c
         QLKQ==
X-Gm-Message-State: APjAAAVZwwSwoMRijU6w3/ySolcxjyLYsvgN/Zm4SMsHRQkBVq/pMpR6
        hEkm8j4S5zdYtVzE6P2iLSRYHk/Pbnx4nyuNf3Wq5m4v
X-Google-Smtp-Source: APXvYqyVUak+Nv8u4gTB6F4KCGjHovJxNsyB5XFzQC5hRch6T2MC/MhhcnArPNdw0X/MLxdw52L6HL44HbPl5TJwXtM=
X-Received: by 2002:aca:502:: with SMTP id 2mr13018899oif.38.1553542022094;
 Mon, 25 Mar 2019 12:27:02 -0700 (PDT)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Tue, 26 Mar 2019 00:56:50 +0530
Message-ID: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
Subject: [GSoC] Unify ref-filter formats with other --pretty formats
To:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        olyatelezhnaya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Below are some two queries concerning
https://git.github.io/SoC-2019-Ideas/#unify-ref-filter-formats-with-other---pretty-formats

Q1)

In pretty.h & pretty.c:
void get_commit_format(const char *arg, struct rev_info *);
This function Parses given arguments from "arg", checks it for
correctness and * fill struct rev_info.

In ref-filter.h & ref-filter.c:
int verify_ref_format(struct ref_format *format);
This function is Used to verify if the given format is correct and to
parse out the used atoms.

Now, the verify_ref_format function can be used inside
get_commit_format function, hence reusing logic.
Is this a correct example to work on, for this project ?
If not, please point out an example so as to understand the problem
statement better.

Other than this I can't find any other example, for this project in
pretty.* and ref-filter.*
Perhaps some examples could be found in command specific files, right ?

Q2)
About a recurring term 'atom' in ref-filter and pretty:
what is atom ? is it a piece of a whole document ? and what is meant
by used atoms ?

Thanks.
