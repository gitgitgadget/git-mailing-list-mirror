Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238CE1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 21:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeCVVot (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 17:44:49 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:37718 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeCVVot (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 17:44:49 -0400
Received: by mail-wr0-f172.google.com with SMTP id l49so1048034wrl.4
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bILAmMgOksEqu/T4TX9Ram7zP9Ze9fTVCyL3eqsIMqs=;
        b=uVgK8h5I+m1hqfWrbvFkg5P/V3wLMncJ7nLbUhejLIyAZ+jEEiLWhakl79EajiyfPl
         N9XZ2z+Oji4DBcIt/hUrD9gwTcVustQGNUMhXGaMJEi5Nsc7I2kcwHqUcX/EOyDUEgtR
         0XvqBWbB4B+bVyyAPETWflUIyqIXL1bBiy/aVY+C2kediiLMu9OeOqx1d7yPJiR35Lbq
         xtrfG3WdAXOeEwiOl8LoAhJh67gY//HLDJAc4MbmStjYeqnVyMED98M1w3TPBCEE2Lz5
         dVE7ASXIt2yAsXfLLh/appUBNyukDtnnAOkJyRoDrntcRqGW8SjLL2050l0NDG28yuTL
         ldTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bILAmMgOksEqu/T4TX9Ram7zP9Ze9fTVCyL3eqsIMqs=;
        b=EAt1X5GC79aVtyl4IjtNBU8WGvCFEcs6uSpVKZM944eEW2ICe7w8M7seUyd3XM7XEh
         KHm0+wmWFyQp7w8Ni7kLnEdT9mQkgJ/EI1pqMCGzGajPhVYoG/FskbO6WwlSrwxuAH4y
         dDpx7qlrZO6NektU29kb2cXFsO4s65N+EUtWfsk6K2xLxC4L8sOW9NkYzq2A38DhAkkw
         NPqODXR6EdjUyZkWoC5dFenxoVMU2+gRZrOtayHWyN3TbXYk43kIG0wsptuLDjw4QrFt
         YzgZ2i+K/udjM0YKRPdoW8IYQreWaoJGOo38Q9Qm+Q8GqjzZ4dH1woRyI0ggjICBEsND
         UMEg==
X-Gm-Message-State: AElRT7GIAN3epXHKDQ/pOj2Mrv4pM61yXz0UrfQ7ph58oljxmGXJSVQn
        H6DRSfSj+5UuCHkMLue51AU=
X-Google-Smtp-Source: AG47ELuDBi/3CTwaXDJW333x4k9zkbxcY1uOPV6yBf8Nl1c3wPXQAjCivSxsLJx0Jx3fsShjg/aeuQ==
X-Received: by 10.223.193.129 with SMTP id x1mr12353501wre.166.1521755087558;
        Thu, 22 Mar 2018 14:44:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y68sm8869144wrb.73.2018.03.22.14.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 14:44:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: The most efficient way to test if repositories share the same objects
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
        <87o9jfyl0y.fsf@evledraar.gmail.com>
        <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
        <906555df-e906-775a-0255-fbc71f7138f6@linuxfoundation.org>
Date:   Thu, 22 Mar 2018 14:44:46 -0700
In-Reply-To: <906555df-e906-775a-0255-fbc71f7138f6@linuxfoundation.org>
        (Konstantin Ryabitsev's message of "Thu, 22 Mar 2018 17:32:40 -0400")
Message-ID: <xmqqa7uzlr8x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> $ time git rev-list --max-parents=0 HEAD
> a101ad945113be3d7f283a181810d76897f0a0d6
> cd26f1bd6bf3c73cc5afe848677b430ab342a909
> be0e5c097fc206b863ce9fe6b3cfd6974b0110f4
> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
>
> real    0m6.311s
> user    0m6.153s
> sys     0m0.110s
>
> If I try to do this for each of the 7700 heads, this will take roughly
> 12 hours.

Wouldn't it be more efficient to avoid doing so one-by-one?  
That is, wouldn't

	rev-list --max-parents=0 --all

be a bit faster than

	for-each-ref |
	while read object type refname
	do
		rev-list --max-parents=0 $refname
	done

I wonder?
