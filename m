Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F221FADF
	for <e@80x24.org>; Wed, 24 Jan 2018 22:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeAXWBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:01:48 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:44027 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932249AbeAXWBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:01:47 -0500
Received: by mail-io0-f171.google.com with SMTP id 72so6454264iom.10
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 14:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LSBNLOFyQ8i5zyl3RcQShJ0GStGN887D1W+nb+8OepU=;
        b=htfTI5WPTo/vlA0P0JkDUWFQ1EIFd49+xz2oUtZjij/2iF2KgaOHfF5fONTYfZl058
         6H+2Xz01ZyM0L+nfHdIONFsmqsjN9bplIco9wHICmep2uY5ZsFRoUZ2qZKfDpA4gfplz
         CmZVliJhjVutJAbpl4xgjVazvAYjm+LYkq5Ekm5XZ4hc2jsgoGysrQT3g/ysm557PU5R
         Ju4zxM1qFYNsOss3OS5BhFtmbRwcNZoEkYCq19b6cA7XKrHUklHBFC5HxildJUrX9FIL
         VBN3WWzDoAQaekSUgx8KVggm9mRs5ipwLSqMMuD9vmMdrCvuLrehs7O3PiHFPE8zVBjg
         unjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LSBNLOFyQ8i5zyl3RcQShJ0GStGN887D1W+nb+8OepU=;
        b=ck85eNqwh9WrSPWB6VmOZA1cKeqEoSB2z6WrGFqp06dwtUpoBH4wA8otc1B8X0z5Ma
         X842TrDS8EwdAndFmA9+RiEuNeqylDXH1Hho1lSPuJwRdKePS+g6LLuY5i4aJkG0OBfF
         D7Byp2Krx1e5QVJ4qWNPkgnwoLLVqmBavngZ+l+mVhwgQGZdn9Ye5DsG6AlaRe4uwn+w
         NHr97qbqN2WzTxyTkYUIpqAi9YVOXWny8HTiVUn7pzVnx06MdQ4FaFDvh+MFt++cS1yI
         hKbrF27ZMAdKOJ+Qcng3sb+aRuyJvFPRxWphNykC3Sw9PfDHdD7IYq7AgDR++iunOJHH
         hLjw==
X-Gm-Message-State: AKwxytc2qet1qbJEbpaTKd95GTuK53xXtxrRW9KIE4ht+DcjhoZW40Ew
        sb66kRt396DKswn//E4UtxE=
X-Google-Smtp-Source: AH8x224BPpM7hPbDZeJOQ8uobTL/tEZ6RpylFhffDJfWSh+QEw4exb/MpU0ONeL0n26H4mPuOi2a1Q==
X-Received: by 10.107.137.104 with SMTP id l101mr10218849iod.179.1516831306738;
        Wed, 24 Jan 2018 14:01:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id f7sm687352ioe.81.2018.01.24.14.01.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 14:01:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the revision
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
        <CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com>
Date:   Wed, 24 Jan 2018 14:01:44 -0800
In-Reply-To: <CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 19 Jan 2018 03:59:47 -0500")
Message-ID: <xmqqa7x2c3w7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +static int do_reset(const char *name, int len)
>> +{
>> +       [...]
>> +       if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
>> +               return -1;
>> +
>> +       for (i = 0; i < len; i++)
>> +               if (isspace(name[i]))
>> +                       len = i;
>
> What is the purpose of this loop? I could imagine that it's trying to
> strip all whitespace from the end of 'name', however, to do that it
> would iterate backward, not forward. (Or perhaps it's trying to
> truncate at the first space, but then it would need to invert the
> condition or use 'break'.) Am I missing something obvious?

I must be missing the same thing.  Given that the callers of
do_reset(), other than the "bug" thing that passes the hard coded
"onto", uses item->arg/item->arg_len which includes everything after
the insn word on the line in the todo list, I do suspect that the
intention is to stop at the first whitespace char to avoid creating
a ref with whitespace in it, i.e. it is a bug that can be fixed with
s/len = i/break/.

The code probably should further check the resulting string with
check_ref_format() to detect strange chars and char sequences that
make the resulting refname invalid.  For example, you would not want
to allow a label with two consecutive periods in it.


