Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671F6C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 18:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjDDSiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjDDSi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 14:38:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D449F8
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 11:37:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id kq3so32154490plb.13
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680633425;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKleTAhkTvia/yZqTT6UYot7n2e+xgqEQ5smpgEFiTE=;
        b=GrV5m122BWjn8Ynyd/u92AsWsvnLhc6Gt3fbbxI/rr9ay/JWe5sHOKiV5f+SsP7+r+
         sHS++lwWgApO2/ivvc5JZlwcKnZAjTnGuVkH81JmwRh5jE32Z2LAfPRJ6XWF6tYCWZpt
         EN8vUGBb69AleK43xsr3pgJu4/viLJhJ7RHmjmjpkquCVYJRF0n845bWwzV00N2SD5SE
         yOKiu1a7RqrKpMOaXzuOlzc9oQj8V/03DcC7ItRmD4OuJuJwUu03J4Essc76tFsoYPOd
         /ripa4oATVNOOTlkLzrCFLal2jL0ATiVfuXlp1R4FIAS/pTG1hFlOG6IWyV2G7L9RLb+
         wpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680633425;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKleTAhkTvia/yZqTT6UYot7n2e+xgqEQ5smpgEFiTE=;
        b=MF4rIENXhaIuAy8aWbGNPrm47kMeuLBEu7HIO+2y+vk/oEdQdDGpI//g/gyalKgbe8
         iltlxYwKoXW6k6iI4boItlhelfqZXpSrGF3weK8Bwsa0KKbkSyG/gXbzCjSXewDtZgeW
         v+VFphUek6nNTamfHTDfoG7iJWdIgtba2S16vQhA4+vl0XOXKEEQz41nXr/f8dRECBVY
         XiZuouvjGRGo+YKbHBMvLK+bkMMQ0MjN7a6og0wL+NAMF8pvxcHoA3l3TNhXX09MP80J
         45wAf4CUVN4h3f2N4YFuim35B/8J1EKNTL3rPUP9lPxjlTObk2U1jMKu3WQSvuyf9rd1
         vX4Q==
X-Gm-Message-State: AAQBX9d43LoR2iT/07zrdLdZsomO3YF+Ilr17KNrjgiKEgw0N5LBiwQX
        g5UnERILak2fU2u6e+l2+Dw=
X-Google-Smtp-Source: AKy350ZxjXnxJxrjcD/0E8pFMuPucMz/BV3RZ/woLZ08pV+ON8xL13bBTfR6G/hFG1bwJmb1+taSzw==
X-Received: by 2002:a17:90b:1d10:b0:23c:feb9:2cea with SMTP id on16-20020a17090b1d1000b0023cfeb92ceamr3825676pjb.42.1680633424956;
        Tue, 04 Apr 2023 11:37:04 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090a609600b00227223c58ecsm8101480pji.42.2023.04.04.11.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:37:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, rybak.a.v@gmail.com,
        "ZheNing Hu" <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/3] doc: interpret-trailers: =?utf-8?Q?don?=
 =?utf-8?Q?=E2=80=99t?= use deprecated
 config
References: <20230331181229.15255-1-code@khaugsbakk.name>
        <cover.1680548650.git.code@khaugsbakk.name>
        <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
        <xmqqbkk44qbo.fsf@gitster.g>
        <bbdd2746-cfb6-4841-8314-4bdad5493f72@app.fastmail.com>
Date:   Tue, 04 Apr 2023 11:37:04 -0700
In-Reply-To: <bbdd2746-cfb6-4841-8314-4bdad5493f72@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Tue, 04 Apr 2023 20:02:53 +0200")
Message-ID: <xmqqy1n7ze7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Mon, Apr 3, 2023, at 23:18, Junio C Hamano wrote:
>> Perhaps we should do that as a preliminary clean-up before these
>> updates?
>
> I think updating to use `<msg.txt` for existing (on `master`) examples
> would fit in as patch number 2, since I rewrite heredocs to use files in
> patch 1. The commit message for patch 2 would then say, “and let’s make
> things consistent for the other examples as well”.

The suggestion to do so in a separate preliminary step was made
because I had an impression that existing examples were full of
these "cat file | command" patterns, and you were adjusting only
some of them.  If there were (I didn't count or re-check the file)
say 10 such bad examples and you are only changing only two for the
primary purpose of the patch (i.e. use interpret-trailers command
correctly), updating the other 8 bad examples "while at it" would
make the patch with unnecessarily noisy, and fixing the "cat file |"
in a separate step may help us let each step of the series focus on
one thing and do it well.

But I see there is only one or two existing "cat file | command", so
I agree with you that it is more reasonable to do it there.

Thanks.
