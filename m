Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B169A20D13
	for <e@80x24.org>; Mon, 30 Jan 2017 23:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbdA3XEO (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 18:04:14 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34888 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbdA3XEM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 18:04:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so24549961pfa.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 15:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oEx1Fct/E8mO1gTw5q4W7QCxEtoKtIruq67wdTTs1mo=;
        b=WQfBqkMDpP5hIPIX1nWw047tU3LzNhb9IsfBYJwfN9GrFQCuXrxFsRyAEVuet6TJ0D
         T16ik7k8bUFPg54UPNaoy+YuRYc5C9ROQ83vf7ZTecbo/PuQYpEDEKwcNrPyxSnFMiYh
         +E3OzFzPI/+GZBXE9bKLW4LYXM4chmCH3WV/UJWuVVXMfYD/X2UD89QuJFc4omGeyZBl
         lNNxGQ35TadZMkkEBx0ENR+VJTgnAajRaGyDX6Bf72R3aMuYmBUr6WEVWC7T6Jh88uqG
         ZAXUz52sLIIwVG6WB8f7KTkKiClHtyyKB4g+nHHYVmEdo3QqFfWZCxk1dX9I8WjcSaE5
         /Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oEx1Fct/E8mO1gTw5q4W7QCxEtoKtIruq67wdTTs1mo=;
        b=mwAGKOMX2wS1jX8hSIbzUcoZmtKquCS1Lo4UiwqrT7b4eEjufhlXRC70O3yUOGoo3B
         Y/XfoJONdaxzsA31GR+IVc7t/dWT9xYjOwcGqy6sAQs2OFAVq7E8XO6MM4qNwgaHo1qx
         qxlqKmT6AGbijHSxHHu7b4l6DJ3YMzPKEUj+GAe29yeGT8rtLwLonPJCztMOkqAZcFVL
         D8iYADIa67PaYM2+NEkx0CKYo05cANmxp+TBJmFLxKwnQdP0m/xMC2C4FoEuEdU94moY
         1VH6TozX3e9OvwsvEzfCsPaCJqStJX+KdL08ZJt55immgLLPMFU4CIoYD7e/sE2zrgNJ
         YMzQ==
X-Gm-Message-State: AIkVDXKZk/gb3kIjW/6lZ//QJOkAJ+wY1dA1CufHbU9CfKTWtX0UmFXGf4NhxYVrhrzLUA==
X-Received: by 10.84.247.2 with SMTP id n2mr34748109pll.39.1485817404705;
        Mon, 30 Jan 2017 15:03:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id m136sm35371322pga.22.2017.01.30.15.03.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 15:03:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Law <peterjclaw@gmail.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        szeder@ira.uka.de
Subject: Re: [PATCH] Completion: Add support for --submodule=diff
References: <20161204144127.28452-1-peterjclaw@gmail.com>
        <CAKoneT+Bn+MdbeNnPJsu23rbLCZ=jxADNVtpNefw9zNYMq26dA@mail.gmail.com>
Date:   Mon, 30 Jan 2017 15:03:23 -0800
In-Reply-To: <CAKoneT+Bn+MdbeNnPJsu23rbLCZ=jxADNVtpNefw9zNYMq26dA@mail.gmail.com>
        (Peter Law's message of "Mon, 30 Jan 2017 21:13:37 +0000")
Message-ID: <xmqq4m0gtakk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Law <peterjclaw@gmail.com> writes:

>> Teach git-completion.bash about the 'diff' option to 'git diff
>> --submodule=', which was added in Git 2.11.
>
> I posted this patch back in December, but I've not heard anything. I'm
> sure as maintainers you're all quite busy, but I was wondering how
> long it usually takes to get a response to patches? (also whether I'd
> gotten some part of the submission process wrong?)

When there is clear "subsystem maintainer(s)" in the area, I try to
refrain from commenting until they speak up, and completion scripts
are one of these areas.  I usually ping them after a few days but in
December with holidays and things people are usually slow, and so
was I X-<.

Will pick it up.  Thanks for a reminder; you absolutely did the
right thing (i.e. sending it out with people who are likely to know
about the area CC'ed, waiting for a while and then sending a
reminder).


