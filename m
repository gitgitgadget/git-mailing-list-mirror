Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5D71F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfAGTq0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:46:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39936 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfAGTq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:46:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so1696930wrt.7
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OqyCHhta7b8lmI+3RIvcJYUDhAKZx6YnARndKQ9Q/no=;
        b=ANAp8gC4EuVBTQB5J6qJyTKBoPv3LwhIDCpfWndffLpwDXTeqfy9SuiOolb68cOPLG
         P8tZUI7gzE7iM9SOMni8wz1/PmtHj5yITLcJsYvIJudIeounGFpSM6C1u102jP1YyOsk
         mmWb1cU6Zn1mOZXjMG0viZlZsYPLRUJzxH0jwZPPjExf+Nff7069jJ5P9HkB1lhKkKPO
         +vu4BvddIQHWYg9+3Fn5+LzPGaKQ8EqUK8aHu6Qdd80/NEQYWCMFfvLlCCv9SAPHo8hW
         Uulu8lbRdUiySq38YZQWJnRd9/PBBE4LCDzy8qhshf0s7qBEfpch+lSJAFl1THV7t8Jn
         24uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OqyCHhta7b8lmI+3RIvcJYUDhAKZx6YnARndKQ9Q/no=;
        b=Itp5OonWRzAWCkTovqUjBbsAf1uyEjr/jmpNs03lkocZEp5w9aJDiJtJg6Y11VGUsw
         oTPG/Yu3nuZg5xXsZYXwjAaOKlmsm59gfVqHygPxG6h6Tnkgw/mDEtG7kT7dqlEbwOHw
         8k7UHDRnEKwEeZP8qgMQguvDq0qO/22uKE7AErP/Jk947eumvfjBeb7h50bHK0rs6NdI
         MVCxwry0DEEJ8GsRdrqhtE4bt6JYo9m7fy5swvDUHGbIKr/sk9xE8n3Z+UatEQAAM/tj
         3M5/bNV13+ApkX9AoXaxTlFTQH2oXDemhlr4vSVt0Dv5qaRpUM7AOOYs2zm1vx97OHWC
         nNDg==
X-Gm-Message-State: AJcUukdJaZ2h5an+pjoFStFEcH2SnOKwn16zbSL2JmWxiD6JI/lJPUzA
        HLLFQ02SwtpmT6NkVK0RR2U=
X-Google-Smtp-Source: ALg8bN4RrAIVhB3zp09VjcCMi44s/ALUuwwrg30yvCu6bA/CG8Q6x3QQiUZ9Hkk1uguEAm49JjvLMg==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr50821807wrg.325.1546890384438;
        Mon, 07 Jan 2019 11:46:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o16sm64479487wrn.11.2019.01.07.11.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:46:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
References: <20181122044841.20993-1-newren@gmail.com>
        <20181211161139.31686-1-newren@gmail.com>
        <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
Date:   Mon, 07 Jan 2019 11:46:23 -0800
In-Reply-To: <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 7 Jan 2019 09:15:42 -0800")
Message-ID: <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Dec 11, 2018 at 8:11 AM Elijah Newren <newren@gmail.com> wrote:
>>
>> This series continues the work of making rebase more self-consistent
>> by removing inconsistencies between different backends.  In
>> particular, this series focuses on making the merge machinery behave
>> like the interactive machinery (though a few differences between the am
>> and interactive backends are also fixed along the way), and ultimately
>> removes the merge backend in favor of reimplementing the relevant
>> options on top of the interactive machinery.
>
> Friendly ping...let me know if you want me to simply resend v4.
>

If you have anything newer than 90673135 ("rebase: Implement --merge
via the interactive machinery", 2018-12-11), then yeah, I haven't
seen it.

Thanks.

P.S. even if that one is latest, I would need to downcase Implement
before it hits 'next' ;-)

>> Differences since v3 (full range-diff below):
>>   - Fixed the redundant "fatal: error:" error message prefixes, as pointed
>>     out by Duy
>>   - Rebased on 2.20.0
>>
>> Elijah Newren (8):
>>   rebase: make builtin and legacy script error messages the same
>>   rebase: fix incompatible options error message
>>   t5407: add a test demonstrating how interactive handles --skip
>>     differently
>>   am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
>>   git-rebase, sequencer: extend --quiet option for the interactive
>>     machinery
>>   git-legacy-rebase: simplify unnecessary triply-nested if
>>   rebase: define linearization ordering and enforce it
>>   rebase: Implement --merge via the interactive machinery
>>
> ...
