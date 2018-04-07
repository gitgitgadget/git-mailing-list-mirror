Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0090A1F404
	for <e@80x24.org>; Sat,  7 Apr 2018 17:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeDGRKF (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 13:10:05 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:45492 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeDGRKE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 13:10:04 -0400
Received: by mail-lf0-f53.google.com with SMTP id q5-v6so4580682lff.12
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zC5gYKq+QBrgcyVPj3xJLWfLhpGmvsvO4AO3iHNSiPo=;
        b=p55034dX8gTDaxuS7Qpld5DeD00tVC9MzlXJZyrrats///Vz2YWdZfKoQg/Y1Ryve4
         h2Z4i2EoyqAW0yBeN+JVqfghssEAKPMOLCmCBA87pqsOZ6C02WNy0OTAndRa0bog+wZE
         +ekqSlwZvCesNuJo7vgJwnt0898LyGV1pTyhLwmUXMVLgXQEYW3YLwtxrwAnSkkzT4Iz
         nXCvn9NVfMyRtLP1kbZog4hNT/oFFQ5VhVMYvFMaqUCiSDcNJBQMYQuZE1kD1sUP0loj
         9V07TKUFQVTLx0d9/v+8yB0RSQ3pgKv984JkBUZgXDMHVWL2T5+2f0v2I4/Woyeo2kaH
         VbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=zC5gYKq+QBrgcyVPj3xJLWfLhpGmvsvO4AO3iHNSiPo=;
        b=ter+zvNgs3RqqqClG/edHG3H27dY2TOSeJTwdtJ6yzbawm+neQ4OfpEiTbzLB6tV4s
         OCCDMrTfkQTRzmIH0voJymoA0VNs81iwsE7HR4TvKXcxx+aR3jLl4JoOxcbQTZDsS6cU
         IktqTHD4o641l4Mq8RGsw3VW6NCzACleBS8WBY/g5e7ABI1ciBz1vSVb4ZAXmujbyCqP
         +i0Eq0iT5RY28KM7kBvDhWv4OMurj2BH0Qhb/CH/6OrzbOrHAP/DJ1w6Nmz2pm7OmUo0
         CkuYoeouY4QA3ZTMkAC64Z4OpBCCvr47NHCmexhbWGn1nLi/yHYRg4z5ib3TGwyiD9Ov
         cnMw==
X-Gm-Message-State: ALQs6tAYMTfGF6FPyOec9yXNs9b3V+BSj8iwt+8H92E9sohTN8Xuf/7x
        etOKtORkJBojJLKvXBvX5yrAdvmj
X-Google-Smtp-Source: AIpwx48Mh7elAm7maCF4AYs2sSV3hp3/8T6Lom6TPhYTm9f5qb0cWV4HLr+Tm0FQbO1qUpBfDmKkyw==
X-Received: by 2002:a19:a210:: with SMTP id l16-v6mr19210359lfe.38.1523121002289;
        Sat, 07 Apr 2018 10:10:02 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ega165.neoplus.adsl.tpnet.pl. [83.21.64.165])
        by smtp.gmail.com with ESMTPSA id u12-v6sm2622979lfg.27.2018.04.07.10.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 10:10:01 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180403180336.GA100220@google.com>
        <f8e171f9-0936-1412-81f9-1149fd2c5a23@gmail.com>
Date:   Sat, 07 Apr 2018 19:09:57 +0200
In-Reply-To: <f8e171f9-0936-1412-81f9-1149fd2c5a23@gmail.com> (Derrick
        Stolee's message of "Tue, 3 Apr 2018 14:29:01 -0400")
Message-ID: <863707eye2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/3/2018 2:03 PM, Brandon Williams wrote:
>> On 04/03, Derrick Stolee wrote:
>>> This is the first of several "small" patches that follow the serialized
>>> Git commit graph patch (ds/commit-graph).
>>>
>>> As described in Documentation/technical/commit-graph.txt, the generation
>>> number of a commit is one more than the maximum generation number among
>>> its parents (trivially, a commit with no parents has generation number
>>> one).
[...]
>>> A more substantial refactoring of revision.c is required before making
>>> 'git log --graph' use generation numbers effectively.
>>
>> log --graph should benefit a lot more from this correct?  I know we've
>> talked a bit about negotiation and I wonder if these generation numbers
>> should be able to help out a little bit with that some day.
>
> 'log --graph' should be a HUGE speedup, when it is refactored. Since
> the topo-order can "stream" commits to the pager, it can be very
> responsive to return the graph in almost all conditions. (The case
> where generation numbers are not enough is when filters reduce the set
> of displayed commits to be very sparse, so many commits are walked
> anyway.)

I wonder if next big speedup would be to store [some] topological
ordering of commits in the commit graph... It could be done for example
in two chunks: a mapping to position in topological order, and list of
commits sorted in topological order.

Note also that FELINE index uses (or can use -- but it is supposedly the
optimal choice) position of vertex/node in topological order as one of
the two values in the pair that composes FELINE index.

> If we have generic "can X reach Y?" queries, then we can also use
> generation numbers there to great effect (by not walking commits Z
> with gen(Z) <=3D gen(Y)). Perhaps I should look at that "git branch
> --contains" thread for ideas.

This is something that is shown in the Google Colab [Jupyter] Notebook
I have mentioned:

  https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg
  https://drive.google.com/file/d/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg/view?us=
p=3Dsharing

> For negotiation, there are some things we can do here. VSTS uses
> generation numbers as a heuristic for determining "all wants connected
> to haves" which is a condition for halting negotiation. The idea is
> very simple, and I'd be happy to discuss it on a separate thread.

Nice.  How much speedup it gives?

Best regards,
--
Jakub Nar=C4=99bski
