Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA4C1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 04:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeJWMeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:34:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38425 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWMeh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:34:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so6282wrs.5
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 21:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0kSCHbSuwDOF09/BLDCN4j3ckZoc11gt6H4Z2pz9xIk=;
        b=UdjdYP+JeOzcSmVvMp2Z23JzoLU44yTRQDDJsNUxu7ll2U9dE8PzeRp3uJwo/eELwN
         Snc3+dzhcWLPAi8dnty3lvYa70LKZg6cq1Gt337umFe358SjxBtCGB84HpXScPouiafZ
         eZDRGQTyS4mS7dWvA7iTQvwdV9CLbpqfjXMr5xqwmkES2iJsnZQ/aR1f7q8Uxxwb0uM6
         dqEOggKxE5d4efLaZWcmS/o2ZrV3PXCrvuQ5uEvMKt02/gonapBRXr9cZ97khXH3qAGN
         //itVKfRG4tuwleRN2b2VbMKd4c4ekftUuKHt0Zodo1gxl8JqfLuHbN+COorMBdQVxyg
         bwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0kSCHbSuwDOF09/BLDCN4j3ckZoc11gt6H4Z2pz9xIk=;
        b=uNJHwUHKrfxbiLwdf+gWzvBlplAETQIbpQDXFHzWOebx/pSgcAeuyCVooCtXQoovDR
         UDFNIkkEMlkecrOQgHBIwYynATQE/5DZX68BYXyCae2o3ykUQGgHgmfQCFvoWRkyI7W2
         kBc+5HhDfbG5rWPGK8i4UhtKmJ0EpIIdO+BeisPm8lGvAu8PmCOqF+Q9LUYDuWdOwcnN
         7kQMsP1XooK6EeLrIeAVl6P3dcKvaw5c5mzWFTdH1kHJ8AEjqq9M+AtLbZzhQok32gCx
         xCQJqxtNItHx7QhmszvhaxK+s2CXNoE9MzlIS5+QfsfknGHOvGIg+uM0NjdBciqNfOyr
         GGkQ==
X-Gm-Message-State: AGRZ1gIRYUze83NxYvke18Nht5Coe4cwnHfxGQHpILlVT+MUnifEw0p6
        rAzHB1XNrSQ+tcIZzuMPl+Y=
X-Google-Smtp-Source: AJdET5fNhqzeCSlncEKJDCU9ommTlBfSHOcdiAKeKebwyEYfwWCNmFBGA56gaSyP2QAEYITXxrrJJg==
X-Received: by 2002:adf:ff0c:: with SMTP id k12-v6mr11681743wrr.232.1540267983015;
        Mon, 22 Oct 2018 21:13:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f9-v6sm17036wrj.49.2018.10.22.21.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 21:13:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] rebase (autostash): use an explicit OID to apply the stash
References: <pull.52.git.gitgitgadget@gmail.com>
        <pull.52.v2.git.gitgitgadget@gmail.com>
        <07140a71dd9ed3f709970f0ce5eb6aa014417b25.1540246499.git.gitgitgadget@gmail.com>
        <20181022223256.GI30222@szeder.dev>
Date:   Tue, 23 Oct 2018 13:13:00 +0900
In-Reply-To: <20181022223256.GI30222@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 23 Oct 2018 00:32:56 +0200")
Message-ID: <xmqqzhv5s3lf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> To prevent that from happening, let's append `^0` after the stash hash,
>> to make sure that it is interpreted as an OID rather than as a number.
>
> Oh, this is clever.

Yeah, we can do this as we know we'd be dealing with a commit-ish.
If we made a mistake to use a tree object to represent a stash, this
trick wouldn't have been possible ;-)

> FWIW, all patches look good to me, barring the typo below.
> ...
>> +	/* Ensure that the hash is not mistake for a number */
>
> s/mistake/mistaken/

Will squash this in and add your reviewed-by before queuing.

Thanks, both.
