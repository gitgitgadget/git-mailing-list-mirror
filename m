Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712DE1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeHNXyv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:54:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46113 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHNXyv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:54:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id o8-v6so10813212edt.13
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8K9inE4IGNhdaggCgi3WWcOxvhuM9JqsuYCwwoUAmbk=;
        b=mfPI1flKAhFuHkxh0cM35WWyl4PFtCZwWgDJs6jMCQOyEZboPCt03piQRj0hWZb5w6
         N5s1+p+1x1uGC0565+aZyio22/fo5DojcH4t8Lyv8Q3ljLBk5mCEONFij5mqWWLJvsOh
         AHWS38x+zEc0gAr5RyPMoS5eNlYRYP23S/AMqA7RMEyJ+1WZhOlcn2w31akvgKN+erLM
         x7IGBrLHRdlV7uGnA/GBIeR8WJJpEQqUhgOYJaUA6u+dnBo3ZSCQh3BJlwQIU28MrJM9
         gpn0OmCBuAje0h5rXt0UBTTNHnUeSxgBoHm4YQfEv1synj/csl7x0qOlO+7XKazbvrAY
         0C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8K9inE4IGNhdaggCgi3WWcOxvhuM9JqsuYCwwoUAmbk=;
        b=fpNYTALoo1OXqpU51v6j7qOa/TpOKLdMlh64ajE1LbKKZh3ck2pqfvskHgHrAF2T3n
         EmKdMhohwwMrFucKU7+45A+W3TB7UPu+k3aMlCr6WLi5e06k2WA9ULTKOE/dP+i901Wg
         KCcDCglIW10C3JizZNpvGN/pFhIqj9WXcOOECzjfKh0NHFw81MrQ/drjp8oIoOeKPRdk
         Z0vM7qD0DxrOTXJixFbCYfayNU0JrLLz+WFP9yVokGzYCPnUu/GXC7Wi/y2rcRJDlJM1
         QY2BYcyU+TCdin+CMEY2qqx4SFvg2JTnDfvQwRNjkr01T2a5PA2xr4SI2+sv25Tndaw5
         H69A==
X-Gm-Message-State: AOUpUlHOyCBLglXkPxvd1hXPdE+GAw8v0/JufiRo2WIhWmwWbWAL4e44
        u+nk0Ca6ygxGamf/aJiZ2QafCusz0bk=
X-Google-Smtp-Source: AA+uWPwCyps8umdJnf7a2Ujyh+uPFZd4oRhSIANWT99n6+KNHPN8Ijbht/HTGyeFJuQSW5ovXk2dmQ==
X-Received: by 2002:a50:ed09:: with SMTP id j9-v6mr28852269eds.28.1534280749367;
        Tue, 14 Aug 2018 14:05:49 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id g14-v6sm8088821edm.25.2018.08.14.14.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 14:05:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] submodule: add more exhaustive up-path testing
References: <20180814185906.2680-1-avarab@gmail.com> <CAGZ79kaK8Wt0TGvo-PyDZRLWr9PU0BRo4=DiYUXvv8c8nZ+M8A@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 27.0.50; mu4e 1.1.0
In-reply-to: <CAGZ79kaK8Wt0TGvo-PyDZRLWr9PU0BRo4=DiYUXvv8c8nZ+M8A@mail.gmail.com>
Date:   Tue, 14 Aug 2018 23:05:47 +0200
Message-ID: <87d0ukhd5g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 14 2018, Stefan Beller wrote:

> On Tue, Aug 14, 2018 at 11:59 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> The tests added in 63e95beb08 ("submodule: port resolve_relative_url
>> from shell to C", 2016-04-15) didn't do a good job of testing various
>> up-path invocations where the up-path would bring us beyond even the
>> URL in question without emitting an error.
>>
>> These results look nonsensical, but it's worth exhaustively testing
>> them before fixing any of this code, so we can see which of these
>> cases were changed.
>
> Yeah. Please look at the comment in builtin/submodule--helper.c
> in that commit, where I described my expectations.
>
> I should have put them into tests instead with the expectations
> spelled out there.

I'll check that out thanks. I saw that comment, but have been skimming
most of this code...

> Thanks for this patch!
> Stefan
>
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>
>
>> So I think these tests are worthwihle in themselves,
>
> The reason I put it in the comment instead of tests was the
> ease of spelling out both the status quo and expectations.
>
>> but would like
>> some advice on how to proceed with that from someone more familiar
>> with submodules.
>
> So ideally we'd also error out as soon as the host name is touched?

Do we have some utility function that'll take whatever we have in
remote.<name>.url and spew out the username / host / path? We must,
since the clone protocol needs it, but I haven't found it.
