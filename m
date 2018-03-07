Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187221F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeCGWwr (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:52:47 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38466 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeCGWwq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:52:46 -0500
Received: by mail-wr0-f196.google.com with SMTP id n7so3811047wrn.5
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nxkzlDoOBGUdGGxqpNFvS9FS5+sMtM4nDfxPu9NhFkc=;
        b=UDqkYElhtrrMcwguesW1+4w50lnnURBj6jRUn+iS1sGDuyM2ZzhlZzij9aNmHzrj1B
         OPE8usXnw70FjJtPzs3+UIgMAVbY6LRPqPzFTnL7LLjE0y2p7oZuJarw+M7dk75Fa6Zc
         1pQ9BR3o01OZXwxFtT1/1riJ4iJu3J1HhUlYy++6ohZsdL2P/sUkwQniuWuO+CAS+H+5
         U5S2jruLL+wxBy4s14Q6Bl2a/wP866VTkf1lKGh1ItuMBwOz8T0fIPBDwusj2vXpQoKo
         2vOArw5NnQIMgHBuueQe/BwaNXRfGEpuWblJJjIhKEfpVDqy3eeGCUP8wahZjwmNAZGq
         2/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nxkzlDoOBGUdGGxqpNFvS9FS5+sMtM4nDfxPu9NhFkc=;
        b=iPPpvDlXm7d0kT2OtpubH+nxgbYWvzpKPh2uv++6I1MriCe9Q3azsY1FIv0P83aJDY
         fm9z00cG3iHusmmaZyWx9LM3SWIoxsQLpcYMVKRRm0QDD/TAr8tDB8wNJ19ZX+3qQaLL
         9a+sa7TaqJIXJTFOiAglLK4j2vSR64+8YauY41onKoOPRwgvFrHxLMkTe5klrTZ/j+Q6
         /DOXA25jeFOQ9+BooYWPAbgzp4aw6anrG4Q1BXeiEWpDgvT8I6ft+hfPZso6EqtMhJ2v
         e3s0NWW+gNvBbzRZeu69q/U4KKOT4DRZZZiHnuN8GxFvRzciVz7z+aJ5hgh0gC0WdS7S
         zcuA==
X-Gm-Message-State: APf1xPAUvv6gBP48CVQJLwzwgoyI/KDTuzVn3RVqEZXuzWJGEGAdssUC
        ik7nlQFBrj1XLVAVGD332LM=
X-Google-Smtp-Source: AG47ELtVssCVq+jidb2YSXVFPV2U+0qIkpONAjgsFKCf1LkriSfMj8RThzK9KYPdJl0m2iGf4HdxBw==
X-Received: by 10.223.156.147 with SMTP id d19mr21700968wre.272.1520463164501;
        Wed, 07 Mar 2018 14:52:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 2sm17591766wmk.29.2018.03.07.14.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 14:52:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v10 9/9] convert: add round trip check based on 'core.checkRoundtripEncoding'
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-10-lars.schneider@autodesk.com>
        <xmqqmuzjzmfi.fsf@gitster-ct.c.googlers.com>
        <40C38F6A-E536-4C7E-981F-B15746C103B5@gmail.com>
Date:   Wed, 07 Mar 2018 14:52:43 -0800
In-Reply-To: <40C38F6A-E536-4C7E-981F-B15746C103B5@gmail.com> (Lars
        Schneider's message of "Wed, 7 Mar 2018 23:44:06 +0100")
Message-ID: <xmqqzi3jxzus.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Although the line is unnecessary, I felt it is safer/easier to 
> understand and maintain. Since both of you tripped over it, I will
> remove it though.

I didn't actually trip over it.  It made it look as if the coder
didn't understand what the code is doing to have that extra line.

> I don't think HT makes too much sense. However, isspace() is nice
> and I will use it. Being more permissive on the inputs should hurt.

You are being incoherent in these three sentences.  If you want to
be more strict and only allow SP, then isspace() is already too
broad, as it does allow HT (and even CR and LF).

I do think HT makes just as much sense as SP, though, so if you use
isspace(), that would be perfectly fine.
