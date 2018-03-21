Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7941F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbeCUTax (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:30:53 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33721 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeCUTas (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:30:48 -0400
Received: by mail-wm0-f48.google.com with SMTP id i189so7806024wmf.0
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZZaMrRVDX1Ob3l0WNpbthUf9v+xGakyLWcgeuYt6Qmk=;
        b=RwB4nSh55oq1Xybl0/OnH0/w5W6VL5/EXD8MWVatjXsAAeFLxWqkQ4dPaK1cD0jRJD
         D1eWZOqoyZlzjJeVhv+hO4YfB4QUTrBQMOQkAPkwrtNHCwaCZZu1AUBoVPCoHyDPoM8o
         MdIa7NNaA1Lr7uMpJd6saVgCsqf9TRjFHTybbA9fNDtgLtvX4WP7SAF1TDqS39rLv9fC
         MXqJZTF1LB7EnRff8Zkll+orw+LaRvPw+i+ERxswkObk3xOh624e+iZcRL7RrJZ3vSUb
         Lgdc004rzzU7hAnpVIQcd6ABHRLJghcHXj62E9L7AN71qbAIV1Dt1HcG2W5P4Unxt0tJ
         ZigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZZaMrRVDX1Ob3l0WNpbthUf9v+xGakyLWcgeuYt6Qmk=;
        b=qv7qsD1SKqPKztOZdY8HEIcE9xF43KwL8AqCVDT956ntjD1idMw2CULaxwMrtK9suV
         ixmNIof0K0LIxWD13PVE7jpokf078c+JnVoBvUdr10HWhoEhK6Bjeg+s2NgWLa5T7M6a
         P3+VmS3CEwI8XdlQa9hwCzSk1wjIqjYLRfFOg6tvfGBTbn7n4WxkXbgDezHn9mAl2Os5
         R89RI6g7vcjQ0a9EpP8ZTEsNVCLsx/xjGmjtaPRrqFzdYS4ngAPnk+LlGC75p5AlHaHt
         vDjccgScOXxrJXXe9wd9SVw1T/GbWhGWpFraXQNS/C0+T4wd2UG5ZSxbI8o+L/+VM0QT
         EoEA==
X-Gm-Message-State: AElRT7E6Vcj+Fa9giD3DVrK2BPT1jIWa6UH1peWa7QAktc8ljiobZpXd
        FBvZI98Se1kZGardJWYFYp8=
X-Google-Smtp-Source: AG47ELtrmUALpa1sHuW6P+HGnXFCureXJZ1Ni7hwgE5a2r13gnbj/hJZTx5M69iL2gYyMsMpReWk4A==
X-Received: by 10.28.131.140 with SMTP id f134mr3742455wmd.117.1521660646967;
        Wed, 21 Mar 2018 12:30:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j126sm4532771wmb.33.2018.03.21.12.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 12:30:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] ref-filter: get_ref_atom_value() error handling
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
        <010201624428199f-b4b3d8ce-222f-4966-9171-7fcf932ca220-000000@eu-west-1.amazonses.com>
        <CAPig+cSxGgG=1k95j+n4DZHBdtN++7F6_U5fu0gOcjwwPQ5GZw@mail.gmail.com>
        <xmqqh8paqt0f.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQ0cq9-cYuw8AJpk6maeT-T25SJDhWpb4TyN8rQJmP=xg@mail.gmail.com>
Date:   Wed, 21 Mar 2018 12:30:45 -0700
In-Reply-To: <CAPig+cQ0cq9-cYuw8AJpk6maeT-T25SJDhWpb4TyN8rQJmP=xg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 20 Mar 2018 18:50:11 -0400")
Message-ID: <xmqq4ll9p6oq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I have no idea what strbuf_error() that does not take any strbuf is
>> doing,...
>
> strbuf_error() was a possibility proposed in [1], and it does take a
> strbuf. Failure to pass in a strbuf here is just a typo.

I've seen it; I just thought it was a joke and not a serious
suggestion.

A macro or helper function that is local to the file might be OK,
but I do not think "strbuf_error()" is a useful abstraction that is
generic enough in the first place (the questions to ask yourself to
think about it are: Why should it be limited to return -1?  Why
should it be limited to always do the addf() to a strbuf?).

