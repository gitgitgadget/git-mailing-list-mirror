Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF411F954
	for <e@80x24.org>; Tue, 21 Aug 2018 21:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeHVBIU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 21:08:20 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43034 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVBIU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 21:08:20 -0400
Received: by mail-wr1-f41.google.com with SMTP id k5-v6so5528327wre.10
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=42xmbMLg3YgDATxIKyhAyYfXCloGujh0YYRhLholjFg=;
        b=XTXT2BH/wpkU0EWwmBISRKA53Igpi7Ym7lwVlZXk3WUZMptZlE9WpCxxp3Nt6Mk4vm
         frTUvw6FNNTNDJlrhpAOkiqx3VhdiNpuyc7KCPKYMEEoju4IMegLIAfVfFnWTselwmRH
         Q33Nhlu8q/kNwBmib/vjYUpOjmbIoR/WzeDvM+pX8ZGJDu2E2U7F0nEZtLL+57t4MN6P
         5umwVZt4DgY2PDnpCIVO3O9Cr9Z283zhV2viSO0HCEXJL13ON0Mzpe5f+AM7Xyul1zJ0
         qjH/mS06nCSa7fjYOPb3ipebCL08EjAjftQeo1QHCfdIJF+ISHPJLxZJJ3l/UAkMuz32
         MrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=42xmbMLg3YgDATxIKyhAyYfXCloGujh0YYRhLholjFg=;
        b=IotoGqBngJOUAPyA5EFmhevBnfdFmim2nHt1GArm62QuAmEmt8/i4MdbeWYYK9lALW
         ZCruQFEuXZp/GjZsIp4bqzJisx0I16tnXGPsUZ+UXrE+IPKJWjiMU1gMkT7XgrrNFDYC
         E3bzJ1OqG2aTR7sN2y9IwI6cHyQZn05TymYzdQHV0iw4WdttTOgAuya7C1Ls/SbHkN4P
         JQ02JuKnqXCGSAvdojtJ8xRe4maANrlqt0K6Ok28eX5XenYU8n6hpM2HAdJW39Yn1Kun
         vvr8EtGE4rXPDRDj7kymD3KCnzx8TGi4cucC8Lmcbkl5q74B5JS+ygsA6H8iZoeByeZ3
         xofw==
X-Gm-Message-State: APzg51BWvsShky/CV54RLnxGxQO9xFwCoxXBh+w0r086jzp4YYC8Pv7y
        2wpRcjZWIkCk1CA/w9N31b0=
X-Google-Smtp-Source: ANB0VdZdK5saVwV6qpe6Acaq0xCBIc9KM0hQNFPbjORgeb9Tk31+GhGeZlV236InrtYrg11FdxH6Mw==
X-Received: by 2002:adf:c38e:: with SMTP id p14-v6mr8263512wrf.68.1534887984999;
        Tue, 21 Aug 2018 14:46:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f8-v6sm14889543wrj.9.2018.08.21.14.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 14:46:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Matthew DeVore <matvore@google.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
References: <cover.1533854545.git.matvore@google.com>
        <cover.1534374650.git.matvore@google.com>
        <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
        <CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com>
        <CAMfpvhK3ouxa5H1ZWy_ZrQBjSq_qwavOtLe98SshaUmjTyBQXw@mail.gmail.com>
        <CAGZ79kb3W6fNkqNemcdziXBB_cDmd3ngBU_0tdS_32rUhAW4dA@mail.gmail.com>
        <CAMfpvhKPJijO_E2FRh-UtrOthEc2YTaG0=1ToYy3akjzWUZWiw@mail.gmail.com>
        <CAGZ79kZfZ2FWfgrvb82YxXP7zHjYDp0J_581ZHgG3un1phHxGg@mail.gmail.com>
Date:   Tue, 21 Aug 2018 14:46:23 -0700
In-Reply-To: <CAGZ79kZfZ2FWfgrvb82YxXP7zHjYDp0J_581ZHgG3un1phHxGg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 20 Aug 2018 17:29:50 -0700")
Message-ID: <xmqqlg8z75qo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> ...
>> OTOH, if it were up to me I would have just gotten rid of
>> test_must_be_empty and used an existing function with the right
>> argument, like `test_cmp /dev/null` - but using some form consistently
>> is the most important, whatever it is.
>
> /dev/null, eh? It shows you don't use Windows on a day to day basis. ;-)
> But yeah consistency is really good to have. :)

Just to make sure we don't give wrong impression to bystanders, do
you mean that we should discourage using /dev/null in our tests or
scripts due to portability concerns?

I thought they had good enough emulation that writing /dev/null on
the command line in scripts do what we expect the shell to do; the
same thing can be said for calling open(2) on "/dev/null".

Back to the topic from the tangent, but there was a discussion on
choosing between "test_must_be_empty actual" vs "test_cmp empty
actual", and was even a proposal to trigger an error when an empty
file is given to test_cmp.  You two might want to join the party
there, perhaps?

