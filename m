Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC321F404
	for <e@80x24.org>; Wed,  5 Sep 2018 16:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIEVZs (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:25:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51240 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIEVZs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:25:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so8709625wma.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tM25xddE2ONbJYaguAf0VHf2aJXff3jd7nCTmvNJ/Qc=;
        b=X8s60ZNMcJxYnq/oTcsgXppfrOXYzp6I4G8REB6Cy9+lniw3PSo688q18Ecu9xMS5K
         m++qqtXhmGAMWS3TKC/tboLf7YhcFeUnNFTmYYCAOGKwG9ffY4/Ek9VMgvI/V/r7hAmX
         MuNmoAPHui90OC9nSwrFSWArCKQHIseRD7s9SDk70s/rYPseE2xRRsxNzlk5p7e8KOuy
         gtWxURTDZfn+NN/go7ZRPJDckrmjk9JvAxX/O6rEftRi/H7MPOuN0hCaWntx/n6YbH8g
         4rNR/R4bbXP4F2HdJjEwZElbkba0VPA5Lekfdxzqtw+J2mGTj3dwmvLWRwcHL5tYEtjU
         1nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tM25xddE2ONbJYaguAf0VHf2aJXff3jd7nCTmvNJ/Qc=;
        b=K4+Yn0g8X+aCiAygDmREG+HXLWAMU92A94cGnUbL2eH6iVq6owKRNGqoMuNhAbzydH
         ibdKDWhvxTa5vkrWsfN08hIW9uPNDJLLLSqsCSh2cR4YnlQKEvN7mN2P4bWdE/0EG8RH
         0rWJ/Whz6u3/VA8r/PRKRQirAf7k4/0bXgjG3Wpfk4W/VfCOwn7i4QWlKetHSjFE1P5r
         iqoBqom1U58v4YI8YPv/puh6io+b1hgJIzhK6HE766fIv1TpZj/HX5wW+HchjQ+9aOuA
         uJEZYezN4t7A9LjNGue17d/DzlkEk6aRSI1I56w+o2oBQuSuI6pOOf+6NwnF0CpUjRia
         +HfA==
X-Gm-Message-State: APzg51DzkxpCql1jLCQtw8xx90iuos2BevhgT59O6p1Y4+Ttk+iGdFWc
        O+iy8IH0lSWdM0afirnXTZw=
X-Google-Smtp-Source: ANB0Vdbw5jV5ok8ELjfLCkk9+WwymQ6LYGdBrwwrF85sFENt1ETUauX+s08yw6GGgwXPIQOv7UTyRA==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr828660wmh.112.1536166484267;
        Wed, 05 Sep 2018 09:54:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z16-v6sm2975130wrq.78.2018.09.05.09.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 09:54:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] reopen_tempfile(): truncate opened file
References: <20180902050803.GA21324@sigill.intra.peff.net>
        <20180902071204.GA2868@duynguyen.home>
        <20180902072408.GA18787@sigill.intra.peff.net>
        <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
        <20180904163807.GA23572@sigill.intra.peff.net>
        <20180904233643.GA9156@sigill.intra.peff.net>
        <CACsJy8Ax4S9Sms6TY1dMV8M9-=hakEW8TCqn8yxb73Vbrpy_MQ@mail.gmail.com>
        <20180905153551.GB24660@sigill.intra.peff.net>
        <CACsJy8BGxqzjXUprnhSU7jQDjzgDnY4x+SMsnOVb4Uho4dJt0g@mail.gmail.com>
        <20180905154827.GC24660@sigill.intra.peff.net>
Date:   Wed, 05 Sep 2018 09:54:42 -0700
In-Reply-To: <20180905154827.GC24660@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 5 Sep 2018 11:48:27 -0400")
Message-ID: <xmqqva7j51gt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > So AFAIK this fsck catches everything and yields a non-zero exit in the
>> > error case. And it should work for even a single byte of rubbish.
>> 
>> Yes you're right. I forgot about the trailing hash.
>
> Thanks, I was worried that I was missing something. ;)
>
> Maybe it is worth making that final comment:
>
>   # and that the trailing hash in the index was not corrupted,
>   # which should catch even a single byte of cruft
>   git fsck

Perhaps.  I do not mind seeing an additional comment to explain why
this requires PERL (it wasn't immediately obvious as I never use
'commit -p' myself), either.
