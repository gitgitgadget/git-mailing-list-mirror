Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7932920248
	for <e@80x24.org>; Wed, 13 Mar 2019 01:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCMBrM (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 21:47:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55472 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfCMBrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 21:47:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so209075wmf.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jw2Z9U0c3SVx/3Q2YIo5EYtyNgw/3Y62Ec104x910aw=;
        b=oLNBp8gz/72kO1XrRFRswQ/kCy4V7zw9YGF8IINzesyi6mK04kK61GTpY0KLOZV2XS
         7YYJF3AO+mdZT3dY3vSWePa8Kr6by2xicFv8wkHuKd2se8WhvzoAuVEZY8HFsq7lCHvD
         8i+wL1X7tAMehZS1TBEIa0BIRXCFHeej21u5x++8wo0cqSeVb3lQI0PsnwTKAb07CybU
         g26DYX43B4Ff72q6RSNHVFeQf3fTceLfQeid272FwuMdYf2GRrkiuD96C+A/DC+jE4M0
         Gk0mkPPqpz2nIjsdpm/N405fwprJw5wyC6XL1U8P6cAMQm4WBODl/PuAn2r5/8BclIpR
         CaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jw2Z9U0c3SVx/3Q2YIo5EYtyNgw/3Y62Ec104x910aw=;
        b=P7vNarRTzvHBX6qVatb7ny/ik7hfARPgJxrJMCYWulI52ATazDeglsI5SAz1twFxMS
         WUvSvCA4E6uIztX0KIU/ws72UXBrT00YUfzRqEdBrshL6Zt3ODgmHYhaaVde462eevet
         49AGpfPfmhTHd4gA7AQd4gv+v+yj9xOiyZaGrRULBRFIEMKZPz9esoeZRHZpBNQ5a+Zq
         3sCGLFx/vJ2dpqz51Ujo9PHHW0Uls7YNrSMDnzo14QoTEK/6WPuQ8ObiqvtHkDi+zpGC
         lqwRsJn5VrEg0gdU3rOzjTaIMukJTZoXDJYiW5gPS6TX2VOB3XRpb4DP+tMOgDZnuJC0
         ezng==
X-Gm-Message-State: APjAAAURRfriu5u9rI798RvFlR38nMSk4pmTi+VyexhfZFaYF7DvkieN
        5KCQKRnNYbdvc1e35q+ZnxI=
X-Google-Smtp-Source: APXvYqwE209MSXcgZf55Nm4gNDWrh/+4xcir8qDH8gVWAGPj+VkA/3PzZXLbbDF+g9CjvFTx5cVj2w==
X-Received: by 2002:a1c:2e85:: with SMTP id u127mr374700wmu.70.1552441630204;
        Tue, 12 Mar 2019 18:47:10 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z14sm7652087wrh.29.2019.03.12.18.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 18:47:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: pass pathspec as pointer
References: <20190225231631.30507-1-t.gummerer@gmail.com>
        <20190225231631.30507-19-t.gummerer@gmail.com>
        <20190307191836.GB29221@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
        <20190309182610.GD31533@hank.intra.tgummerer.com>
        <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com>
        <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com>
        <20190311214244.GB16414@hank.intra.tgummerer.com>
        <20190311221624.GC16414@hank.intra.tgummerer.com>
        <nycvar.QRO.7.76.6.1903122323460.41@tvgsbejvaqbjf.bet>
        <20190312234046.GF16414@hank.intra.tgummerer.com>
Date:   Wed, 13 Mar 2019 10:47:09 +0900
In-Reply-To: <20190312234046.GF16414@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 12 Mar 2019 23:40:46 +0000")
Message-ID: <xmqqwol3fsv6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> I see that you added the `const` keyword. While it does not hurt, I would
>> probably not have bothered...
>
> That's fair, I went with what seemed most common in the codebase.
> More than half the parameters seem to be using "const struct
> pathspec", so that seems to be the more common way if we don't require
> the parameter to be modifyable.

Yes, when you prepare a struct at a callsite and pass it thru a long
callchain, it is very helpful to both humans and compilers reading
the code to declare that the structure would not be modified, if the
code indeed keeps it constant.  A caller that used to passed the
structure by value certainly hasn't been expecting the callee would
modify its contents and it needs to read back the updated value, so
I find that most of these constifing, if not all, very much in line
with the original's spirit.
