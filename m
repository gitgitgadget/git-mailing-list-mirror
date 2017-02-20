Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7543201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdBTU1e (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:27:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33507 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbdBTU1d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:27:33 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so14334114pgj.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 12:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jsfGX8Fq02bn8YmsIQOsBx7YQQ9Vj45Co3hlyU7fDuQ=;
        b=CG8vw879KCbxdvFemMsgFz69cQND1tcHR5VLTaJSWtyLB8d8KIlsSpXvd5cIbp3RTC
         2HqVbDAuUnYQz+bB7j6XqLzPIOGutinIEKrzRS02UFevTKvK/z6hLpSNASvdqfwo+jFY
         7oqslFyCqhpJfz3UlnYHmKHDNV3v6yT4fzTGdEdTZr1p4EmjJrWLkZzfeLDaQ8TRd6kz
         9djfRcWkOeFfFtBf1X9Vn4tlkk+n8Ug6v7siBK5v4A3atlC7UXdtoAMrm/Lfkgq9EKmL
         qopAUkMNkvvTDo0VvkPhumR2p3QpmHfi4SXDmuQIGdEWi76ZAuIryiDfulKBW1pRnnmR
         wcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jsfGX8Fq02bn8YmsIQOsBx7YQQ9Vj45Co3hlyU7fDuQ=;
        b=dKMgQi4xoYKbZD4R/Sn9e4nQM/LH7ld2wTB4zK1ViSMRWiXT+TT7EVYQqMPb72Qvjf
         rcBuZVoiEkLK7IQN6iVqYYesO/1YF6/jhpZvbNmypezKIdN9nDHV/Vw9dXCSAN1jBqUy
         gaElVV31yX7F/OJmrPW1FCPdHQptR/1e6LZIkiw+JXNjwRz8/PigZ9wMw2XiWu1MPGqb
         t/hf6kPEftPzPsnTQCH+Cd8UazSeIrtxd8yLPhKATloDbhxoqexDIGQvXUbWcD2qCZhX
         7ebk00fc0OwnHvKhkC+b2mPyTimVPC7bNyCm0/jPdS8yyW5QSkMo0ClySiPlMuff+xdu
         EThg==
X-Gm-Message-State: AMke39kIHoygX5++h88v9wawt0Qk3dwETzM8PS6Rd1w7sHw500+v9abQLcXd2HgaCb1sNw==
X-Received: by 10.84.130.100 with SMTP id 91mr34356841plc.167.1487622449127;
        Mon, 20 Feb 2017 12:27:29 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id h14sm37031116pgn.41.2017.02.20.12.27.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 12:27:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/5] hashmap: allow memihash computation to be continued
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <bd4893f86c4484fc36480848bf2d0905d961e022.1487071883.git.johannes.schindelin@gmx.de>
        <xmqq7f4onjrs.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702201342020.3496@virtualbox>
Date:   Mon, 20 Feb 2017 12:27:27 -0800
In-Reply-To: <alpine.DEB.2.20.1702201342020.3496@virtualbox> (Johannes
        Schindelin's message of "Mon, 20 Feb 2017 13:43:38 +0100 (CET)")
Message-ID: <xmqqwpckip5c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If an extra call level really matters, its "inline" equivalent in
>> the header would probably be good.
>
> Well, the hashing is supposed to be as fast as possible, so I would like
> to avoid that extra call level. However, the end result is not so pretty
> because FNV32_BASE needs to be made public (OTOH it removes more lines
> than it adds):

I think our usual answer is "can we measure the difference to
demonstrate that the overhead for an extra call matter?"

As two functions sit next to each other in a single file, the code
duplication does not bother me _that_ much.  A single liner 

    /* keep implementations of these two in sync */

in front of these two functions would not hurt, but whoever attempts
to come up with a better hash needs to stare at this file carefully
anyway, so lack of such carefulness probably wouldn't be too big an
issue, either.

But the above 8 lines are something we need to worry about after we
definitely know that we MUST have two independent functions that are
supposed to be kept in sync; a patch that makes us worry them before
we know is a premature optimization, and that bothers me even more
than the actual code duplication that can drift apart.

