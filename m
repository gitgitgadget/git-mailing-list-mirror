Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8039C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 12:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjAFMeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 07:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAFMeR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 07:34:17 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8B68786
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 04:34:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n12so1382350pjp.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LB9EzBgeU6s3zKSVFSQzOpzBQrFYpIkI/S/53nrHiDs=;
        b=nGffOJUZkXpHZY5Tu/UspHWof1Nh6frzACB3L5iLH25Lma0DuTsbIHjn7lslPqmLG8
         5Rp6pixpnW/tNK0ZgZshM7u5rFbJ2uvN1/U9TJ0KwlhtmmdA6vvEU2nK+Z/nmv7aYlVS
         Vk74PQqhiZP3uqnPPCajSg7NvVP9I2qRGnKR+Lil99bwahcgu8zQwXtVYtWdt5cmpAq0
         guNzCls5tTvpvrcZo0lqbs6dX82Pn9VSvZxJJeiUVC2C0jEmBZVzgF3PBpMmno4FZeAv
         +ByzxMZY/wOq9g6ToHa9Zc6A/YZoc23vW58IiJ1hwKX1GstxEvzow5QwCD83NOGIVmbP
         lhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LB9EzBgeU6s3zKSVFSQzOpzBQrFYpIkI/S/53nrHiDs=;
        b=PfDtfLEGzXPGyMIQIfA1hmAuse9FfYPFpXVJbndiuUjNi/BznhrfdV0c2Qcm+zsLmS
         ZTAhE/5pVZaU/gMht+42HTb5oh1N4DivEB6mel8+Sjloi19Sm6H3mRQW2bBbHtprkhWK
         gu6a2Rblm+t7ocLJx4wgJLQJ5A0b5JBk3fPiu7p6rR56I8NNeUCe01El6Z049veTMhc2
         QGiPA5GsuaA+JrDeAj07M+25gcLEeq6piapMslgH53W3Hk1UOecHUa9ePq9mnDoELVV0
         m2GGuCDtkDsyJKpkq+Xxv7/U2WktVT4agekEUPzmr81lUTQZT41ZURz7rjen7A2SKzuZ
         5zIg==
X-Gm-Message-State: AFqh2koBPAR0QYOpePytLn1HtoVoIJerBGY58wopqOFGN2zbT6jm99Z7
        7lXbDjnHR69+KtdOAJ5wBu0=
X-Google-Smtp-Source: AMrXdXsFWIWyrKy8DGTXJEkBT08i2eeIU/PElhdxWic5+gieACq/FKfb4EJjqEvLvJKLhsLEO/WpDg==
X-Received: by 2002:a17:902:c193:b0:190:cd21:1ebe with SMTP id d19-20020a170902c19300b00190cd211ebemr58904910pld.1.1673008455569;
        Fri, 06 Jan 2023 04:34:15 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902ee8d00b00192f7f8db8esm784437pld.297.2023.01.06.04.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 04:34:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/4] worktree add: refactor opt exclusion tests
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20221228061539.13740-3-jacobabel@nullpo.dev>
        <xmqq5ydvpu1o.fsf@gitster.g> <20221229065142.fmfviwisjmxsey7b@phi>
        <xmqqa636mskf.fsf@gitster.g> <20230106063130.v4npgjzp6dwq2p3r@phi>
Date:   Fri, 06 Jan 2023 21:34:14 +0900
In-Reply-To: <20230106063130.v4npgjzp6dwq2p3r@phi> (Jacob Abel's message of
        "Fri, 06 Jan 2023 06:31:41 +0000")
Message-ID: <xmqqo7rbsuyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> On 22/12/29 03:49PM, Jacob Abel wrote:
>>
>> [...]
>>
>> So from my understanding of the situation, the only two options that pass all
>> the existing tests are either:
>>
>> A: Use the diff in [1] without the two quote example tests included.
>>
>> B: Revert the changes to how this was done in v5 [3].
> ...
> Sorry to poke this but I wanted to confirm which path I should proceed with.
> Both options are functionally complete and it'd just be a matter of choosing
> which version to push out for the revision.

I think B. with "$@" -> "$*" (because you only want a flattened
stringified version of the arguments in $opt to insert into the
test name string) would be the more sensible avenue.  Let's not
over-engineer the tests---it is not the point of these new tests to
ensure that "git worktree add" can take arguments that require to be
quoted on the command line.

Thanks.
