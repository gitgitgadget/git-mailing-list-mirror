Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA1C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 16:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjEJQcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 12:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJQcK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 12:32:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB81993
        for <git@vger.kernel.org>; Wed, 10 May 2023 09:32:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-517bdd9957dso5023898a12.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683736324; x=1686328324;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3oColRS1Spij9w04nGtSeOy0kG1XfOjCjXlMmgxk+w=;
        b=lMgA8pjGQX+2DqKlpllK+jzoxW1zw+oHxapAyW1yE1mjsxSugqhj8ZqEsE13xFYbyq
         FKkj8wCLNrUK7FqfyVY096Gr2EwbSfRB8644ujp/o+U2k96qApjcsHf+2XTgpbe6MJHz
         cIwe1KyICFY0Z1z922ku03y3000ym/zrS+nyxj27TzDQvweEpxmiCZd7uN/4wlwKIQjo
         Do+rVjk8CFTD27iYf6oafqayDe2pEZKHwddO5Caxo5wcgyWL1JsILtZMnpcltpPfSpCr
         hLRQDZ3iVC8K2wx0+/NL0xJjB0bU+5vT4hwPrBJ7xjfzQrRconfKgDth/3tjWvmItJjL
         eBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683736324; x=1686328324;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A3oColRS1Spij9w04nGtSeOy0kG1XfOjCjXlMmgxk+w=;
        b=IIM4LaiiDT+Fo4j4PJJ2z4005UBWUYqYUaCFfFF7uBU+VNBYvX8y7ysbeEIkYKWxEC
         0+Eu1tqCKJmxnzc1/YRyEH77xvnuNB0Wn4XzO8u/sPcSne32jUFbICOUCHSKkQNy8nEY
         MicrLT1dpLcQ+5urNHXa6PQDojZ/SDDJyf15DF5BoloUeMiSiw3KDYVukZnNVQfmZAJz
         VGMgfnBbYvpa+dfO3lzTTGkNCretow2k0PCABuTSnlvAL/JcII/XbjGrry5CikiZHW4Q
         QFS+99lYsUhtikqMC1fQjlvMZ9EPZgyYyIl1RDys3/q6UJMR65g0Ywd8xmdJt5DJrDQB
         h+iA==
X-Gm-Message-State: AC+VfDyyLWn2QqY6INI2ulbZSaf86/VIxawldjyBBtRbCxXJ+ewM2qo3
        K2xfLmLmymFG12F9d79RfX4=
X-Google-Smtp-Source: ACHHUZ6U4BmUJAwTX7QaODmANqohiaVvgBJpl2OBOS5KR90s3Qr4AIfm/jXD7LPC3MWcwhS0A3PKug==
X-Received: by 2002:a17:90b:a52:b0:234:f77:d6d2 with SMTP id gw18-20020a17090b0a5200b002340f77d6d2mr18521445pjb.45.1683736324009;
        Wed, 10 May 2023 09:32:04 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id lr8-20020a17090b4b8800b0024752ff8061sm22039084pjb.12.2023.05.10.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:32:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #03; Tue, 9)
References: <xmqqmt2d0x0f.fsf@gitster.g>
        <20230510071935.7329-1-tenglong.tl@alibaba-inc.com>
Date:   Wed, 10 May 2023 09:32:03 -0700
In-Reply-To: <20230510071935.7329-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Wed, 10 May 2023 15:19:35 +0800")
Message-ID: <xmqqpm785erg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>>* tl/notes-separator (2023-04-28) 6 commits
>>  (merged to 'next' on 2023-05-06 at 598ed19c9b)
>> + notes.c: introduce "--[no-]stripspace" option
>> + notes.c: append separator instead of insert by pos
>> + notes.c: introduce '--separator=<paragraph-break>' option
>
> Sorry, there is an updated optimization for the commit of the
> `--separator` option, which can be applied using the reply[1].
>
> Please also inform me if a new patch is needed and I will send
> it immediately.

Once a topic is in 'next', we update by queuing a new patch on top,
so [1] is not quite sufficient.

As to the "char *" -> "const char *", I didn't check if there are
places where we use the variable as "char *" and need changes other
than the place the variable is defined to prevent compilers from
complaining on type mismatches when I made the observation, out of
which you made the change.  In any case, "const char *" may be
safer, but the code as posted is not wrong per-se, and I do not see
it so urgent to fix.

The blank line also better sits between the decls and the first
statement, but I do not see it so urgent to fix with an immediate
patch, forging your sign-off and writing log message myself.  It
is something we can safely leave for a separate clean-up topic after
the dust settles.

Thanks.



