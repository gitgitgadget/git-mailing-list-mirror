Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD56211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfANTDM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 14:03:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36753 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 14:03:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so711014wmc.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 11:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W3CeZNoXChsIC52f5fhWTFms8EbDpEYuS2ZeMENsKPU=;
        b=VMhWpXoB7YIjHB8yPzV/0pm+k7w64H3UYrZSHRGfECTblGKPf27tXaZ0+JBmSRdtst
         KUi2maFyUP6slXO1HMWzqGQoCIt3tY1lCU7NreqqcIZQj5nYwaq8ilnHp1ZOkclIke09
         ekZeGAUAoVKUP9vub81eaV8azxS8OPYS2Jj862n3F8zN+rlzIrGuTCz7c+KvYmN636cQ
         cc3pnzlL22V5g+aoT1t+EU8BBL5sdf/7nYNeD9TJpx5i3d9ZZEDgsYKWaHmYmRMTYQry
         myGMlvav4R16VMG+Azqtczyc/gaXhRAYfTj8lWAFHodOQ44uLmETXmZlxTrNl80MIk9K
         pXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W3CeZNoXChsIC52f5fhWTFms8EbDpEYuS2ZeMENsKPU=;
        b=udJPYur1RBbgbP4nkPfpxiZBiAJP+24cidRxk4UWhK0E1aSgQQpt6byuC8SWkrbQeU
         p5HPCex6/S9VCrrDgBlnEF1U7UpE/lv/yUHdGiGr3Tu/3ADFHq0Nqf7CDyFTGw9srfrL
         48S0JXs0uNJcqSTyIKnJLarAUL1HiTkJwizRFoEx4A4APrenZhzocprDqr+5pjbc/FTH
         51aQsHUMrw13weDjde4VcDOY+43r3mg6vxdlWUefNZR+EwSyy9eaUYlblo8CYCbdJnBG
         e/ZFbxlY9xjxjZyCYO73y7419yThfh5wZyTzr8cOdt68QJdNygsiD/tS6qLmTnIe2YBY
         Ee2g==
X-Gm-Message-State: AJcUukcD6ceXeCe1x6dSWXKpczim8UG65GLprm7nwnd0bTNwYoiM0Fen
        2iZ0zRLz7Ymp1n90xclBBHQ=
X-Google-Smtp-Source: ALg8bN5Vo084NpZjuUaR+brF7G1xljbgFjGtUVemCdbITcLcRyvaMkC0MBLWIeA7cHdU8li5GP0O/w==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr387650wmj.129.1547492590303;
        Mon, 14 Jan 2019 11:03:10 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 133sm36366721wme.9.2019.01.14.11.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 11:03:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>,
        vin ku <viniciusalexandre@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>, amazo@checkvideo.com,
        aoakley@roku.com
Subject: Re: [PATCH 1/2] git-p4: add failing test for shelved CL update involving move
References: <20190113135815.11286-1-luke@diamand.org>
        <20190113135815.11286-2-luke@diamand.org>
        <CAPig+cSPL4vcfWR7Pos91N_SO-qCSBMYFY8vbyHX-POKyyRJpg@mail.gmail.com>
Date:   Mon, 14 Jan 2019 11:03:09 -0800
In-Reply-To: <CAPig+cSPL4vcfWR7Pos91N_SO-qCSBMYFY8vbyHX-POKyyRJpg@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 13 Jan 2019 16:57:42 -0500")
Message-ID: <xmqqr2dfuknm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jan 13, 2019 at 8:58 AM Luke Diamand <luke@diamand.org> wrote:
>> Updating a shelved P4 changelist where one or more of the files have
>> been moved does not work. Add a test for this.
>
> Perhaps this message could give more detail about the actual problem
> than the generic "does not work" which provides no useful information.
>
>> Signed-off-by: Luke Diamand <luke@diamand.org>
>> ---
>> diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
>> @@ -500,6 +500,12 @@ test_expect_success 'submit --shelve' '
>> +last_shelve() {
>> +       change=$(p4 -G changes -s shelved -m 1 //depot/... | \
>> +               marshal_dump change)
>> +       echo $change
>> +}
>
> A simpler definition for this function would be:
>
> last_shelve () {
>     p4 -G changes -s shelved -m 1 //depot/... | marshal_dump change
> }

Indeed, and it will work better even when the output from marshal_dump
has $IFS and other traits that do not survive "echo $change" intact.

