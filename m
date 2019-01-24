Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884AF1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfAXT1l (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:27:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45457 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730801AbfAXT1k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so7719503wrr.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7HV5f1shXcyYJBUiTzK77ta9Zuw3nSgwxtvUk4Xkrcg=;
        b=lrhUwF3zl1TOE0rti5XahWrLUhxzKoh2aHqowDnj+64fBb178RS+SiYo9lhcphH5DA
         fYMDZ848TKDfQr6nCx4rqGo0HsrJfBnyIUkhnDxuZC1528YKvg8x9QNbQOGR9b6hMDC6
         KBlnjexDPPznVeK2NGcrwkmY5FevsT0gR58WEyZYjnd4W1G9e3qMNcKSt3bLtUW5miwM
         SeYcQHihFxlYNWC4VLvxKizDjibvFM11/o55YYGFs+TPPtAtdabuBeIMuz6+VLlaKBd1
         /hH5T4kxhmyBWSDHNhwk/4q5j2mbabUzUgsVccrtCi8glboFnKbWX3lvklP3OBLs2kfq
         +4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7HV5f1shXcyYJBUiTzK77ta9Zuw3nSgwxtvUk4Xkrcg=;
        b=R+9nkh4KXXjne/VM2hWZAGTREm757HGZMbNmeUAG1h3Fm1EXfVcjz6f1s8rjxPr1H7
         aYmxVjKmK/YCWW16I2TZjVjXZ9q2iV6fPUU/MeW3uWCi5nx2r5pCuKv6rCETnrxHKJ+m
         wPS+QgqHNbGI56nxsECgoJuT9lnixuT8uLUOQZeU60BqQsDoUeKtTHITeqJzzW6hyVYE
         iC3SGV9mj81rtAebUqSRfmSBpSQkmfk4qTrAjCQu8s5vcDwIXXMksutgnNLvm18Nxn8G
         u4cvWNHwrZOjiC7ROLM0K++vHBPF37w8t+o9ksV531vwl1uZ4mza0mRUxOsIBRfQv7Nd
         L4pA==
X-Gm-Message-State: AJcUukcZuX/1AYJ4EUv1AFJjEbeo1CSij32Gw73vfnZOqig3h+5WXI+V
        K2kxmfcWsxfXLeGN41MnOrscIg0/
X-Google-Smtp-Source: ALg8bN56w3IcaJ2KelAKg6AAcC2ZST6KaLOcphwQyuZRCl2e6SGt+i4i8bqlkfnrIisc8qgFaF53pQ==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr8107199wrh.317.1548358058675;
        Thu, 24 Jan 2019 11:27:38 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n15sm82179270wrt.21.2019.01.24.11.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 11:27:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
References: <20190122232301.95971-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190122232301.95971-2-nbelakovski@gmail.com>
        <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
        <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
        <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
        <20190124183235.GA16580@sigill.intra.peff.net>
Date:   Thu, 24 Jan 2019 11:27:36 -0800
In-Reply-To: <20190124183235.GA16580@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 Jan 2019 13:32:35 -0500")
Message-ID: <xmqqh8dxj1p3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If anything, I'd suggest going in the opposite direction, and teaching
> the worktree code a function for looking up a working tree by ref. And
> then it can handle its own cache to implement that reverse-mapping
> efficiently.

Yeah, that's a thought.  Then "give me a worktree that checks out
this ref" can be asked outside the context of for-each-ref and
friends, which is a big plus.
