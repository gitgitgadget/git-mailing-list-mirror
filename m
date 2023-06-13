Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE11EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 19:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjFMT3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjFMT3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 15:29:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C166A19F
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:29:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3c0c476d1so24948535ad.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686684545; x=1689276545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z4Wh2LcivYvWSjb2vRM+y4vTbqkRaHj/0lN7Y8z49c=;
        b=r3FXV2fmRlzg78kM4GCTmPtaieiUPLIMG7mwh3lMeK+8/EmMWOpNR5b5jN5MThabyt
         2tH0qTZFhXjZyQ/WxVKvzllZNq6ttq4GzxfDMXEl56ufYu3zdIDoadnVgCdbMGdJqdu8
         VBe1pRHocKg8+mqszK4KXTzKfvLeze2sMvWZMPKzEIckFsSbKtVjoaoTIuiFpxN7nCbT
         awnEH7m+gmengbck1Z/EPnjwNnxtx5pKVUSfqMj6kWz/XgORd7wJnzB4HL+8g0Vcfdcx
         +QYO3zonqPyk8gSq9XU7oLWQDUMKJ/RdewA0J4UOZ8Bt/nxmhsZFt61ULLCThldWhVc0
         zg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684545; x=1689276545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Z4Wh2LcivYvWSjb2vRM+y4vTbqkRaHj/0lN7Y8z49c=;
        b=Op9CgxXemuQ6ZesJAJS9FM8Hh4JwyReOOUpkWOwNRV9Fo72FHIeTc7zfUwsgH6IwRk
         rhr+6HCcrlaDxcgO6sRFzjANKtke8Je84+1/Uwngm7gWYdr7lKQhQLaCwAB5cBPLXd78
         jsPI0F0+tOkrnMclJz6hGMQZpza61Z7aWXcGddQrx+/eHn7wWXU245zX8sdVqw0tnHDI
         gA+Sc+x3MhkMujpOimwsIdJxp1dZrv9w1tfa+m2BWZKdlqrf0OgrYrKtzEmxeCIe0miN
         rZGoWljq41paFZLOHVnPCtuRCAjftHNvE1LzfrGi8EhAexdAvtCrrpqlTpA38r05AU3O
         0gNQ==
X-Gm-Message-State: AC+VfDzaQqa9tAMI/cNzL/uEU3Qm2loDOu+KILkjjMhSwu0a4fdmfGBz
        bJzxr7VZe2JUPOg6ciJ9PB0=
X-Google-Smtp-Source: ACHHUZ5UmaitSk3X19CYvJKcN7gRMuUxWIXVZrALjvbifnAiBra2xyhXEm3b5OslxHNtp3Dj8XZIPw==
X-Received: by 2002:a17:902:a50a:b0:1ae:3991:e4f9 with SMTP id s10-20020a170902a50a00b001ae3991e4f9mr8997491plq.61.1686684545184;
        Tue, 13 Jun 2023 12:29:05 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b001b1a2bf5277sm3929971plx.39.2023.06.13.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:29:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: use octal escapes, not hex
References: <CAPig+cRS=cpV1e4QoSy5uypA+-hECyPe2rEg3scV8LVBfzZ5hA@mail.gmail.com>
        <20230613184304.36482-1-jonathantanmy@google.com>
        <CAPig+cQnyL8-9EHVe5P_oRbUdsXA9WBiK_W4LHq7HOF4-ek5Pg@mail.gmail.com>
Date:   Tue, 13 Jun 2023 12:29:04 -0700
In-Reply-To: <CAPig+cQnyL8-9EHVe5P_oRbUdsXA9WBiK_W4LHq7HOF4-ek5Pg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 13 Jun 2023 15:15:14 -0400")
Message-ID: <xmqq1qif5fgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> So, for the commit message, perhaps simply:
>
>     Extend the shell-scripting section of CodingGuidelines to suggest
>     octal escape sequences (e.g. "\302\242") over hexadecimal
>     (e.g. "\xc2\xa2") since the latter can be a source of portability
>     problems.
>
> As for the change to CodingGuidelines, this would probably be sufficient:
>
>     Use octal escape sequences (e.g. "\302\242"), not hexadecimal
>     (e.g. "\xc2\xa2"), since the latter is not portable across some
>     commands, such as `printf`, `sed`, `tr`, etc.

I'd prefer singling out `printf`, actually, and not talking about
"across some commands".

As I said in a separate message, we certainly do *not* want to rely
on `echo` interpreting bs-escaped octal sequences without '-e', even
though it may be expected on a POSIX systems, because it is not
portable across systems our users commonly encounter.

And `printf` has been what we chose to turn bs-escaped octal
sequence into binary.  I'd prefer not having to even worry about
`sed`, `tr`, etc. behaving differently and not allowing to expect
these other commands to be usable for turning bs-escaped octal
sequence into binary would be one way to achieve that goal.

Thanks.
