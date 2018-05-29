Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557F61F42D
	for <e@80x24.org>; Tue, 29 May 2018 12:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeE2MIs (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 08:08:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38851 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933135AbeE2MIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 08:08:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id m129-v6so39793533wmb.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 05:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bRCoC8wlCca1dlbAS+PP1wuPiHWvHKkLwiMV1t/N0kw=;
        b=M4T6HNkmsqjDt1MJ3bI/TXxDpSAXsyySYETrVzkQx0PLUi9/HXf4rIRPcFyGpmbpcX
         szzoXyzOPJ6kty401OW0bfwhjSWs5fJlIRseTLIQoyaKGucys90nj5ZNj8DJXhvPRufo
         ZLF0Yewb3PHGb3CryDRBgANVIil4CY9N3Ob/RG4ajQ34JPY+P+EzAHOySjm1DhYiQzdv
         koSHEBUSRNAxD+WClI2Yu90f2eMwWlUksTwiKoJXdzcyp4ZpXrxpw3vrAqP6/Y30DrGB
         dTXtn7z4h6s+uVTee2zlER2Nl6bdfk1u9As8MBbOLGv4hARH/K1bUEPO3koHqBE3qW6W
         D20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bRCoC8wlCca1dlbAS+PP1wuPiHWvHKkLwiMV1t/N0kw=;
        b=S96E9aJ8xkucfPQmFbyV9yKsOtwWV0Twa3Mfj2Ej9/rkuNIglZeKqQhmpg9qjzMdx0
         A5zB/N96wILwZOzz1ANfqGQpQGA7RbpKLLLwwkjhnDHUvh1qt30awOOFX79xJtskukHN
         IwrulqEIpqvpiTpJ163sele6kwbUX5dpT4t+ltnYQkFnHlFkguez5a3Iul3TtSUFcptf
         Ki1/+OBzEB90gCjFis9vawd0LK4yDDit0RYRN1SHyyhB67pOdJTcm/sVWBnvgQj0oGgs
         TvbbX102IIExgtza880aWohT27UupFwYMFmGIchPLxOPI6T/bMMvxzocewPDOBtYZbIS
         U6hg==
X-Gm-Message-State: ALKqPweOT1Furv3fhbOuuRQnekf4n3rZHOgde4wRZqjpglLKhF34wNiG
        xxQ3pViHTu4bXwPk9jS7VAg=
X-Google-Smtp-Source: ADUXVKLOoJhtF+zkOBfxhrPv/VvhVT33eoV90NSy13kBoZ7lwm3RTr0+IDAKDlVVw9vPMhd63VOUUg==
X-Received: by 2002:a1c:96c1:: with SMTP id y184-v6mr11063974wmd.156.1527595725653;
        Tue, 29 May 2018 05:08:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n56-v6sm18627109wrn.72.2018.05.29.05.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 05:08:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just the first
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
        <cover.1527279322.git.martin.agren@gmail.com>
        <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
        <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
        <xmqq8t83ihd7.fsf@gitster-ct.c.googlers.com>
        <CAN0heSq1y3XibCFDYsae5b6jmzZOzcLHT4atCZ+KCb4dL5As0g@mail.gmail.com>
        <xmqqtvqrggdt.fsf@gitster-ct.c.googlers.com>
        <CAN0heSry9ncTTzjw2fB=wxTAo3YPyQq-wbONpXCsfi_Syxfj-A@mail.gmail.com>
Date:   Tue, 29 May 2018 21:08:44 +0900
In-Reply-To: <CAN0heSry9ncTTzjw2fB=wxTAo3YPyQq-wbONpXCsfi_Syxfj-A@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 29 May 2018 12:30:35
 +0200")
Message-ID: <xmqqa7sihdf7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> About the _("\t")-approach that you mentioned up-thread. It would allow
> a translator to adjust all the indentations for a particular language.
> To be clear, what you mean is _("         " /* 9 spaces */) to align
> nicely with "warning: ", which is the longest English string. Then the
> translator would translate the nine spaces and all of "fatal:   " and
> others to padded strings, all of the same length (not necessarily nine).
> Correct?

I was envisioning that these

	error: the first line of an error message
	       and the second line indented by 7 places (strlen("error:")+1)
	info: the first line of an info message
	      and the second line indented by 6 places (strlen("info:")+1)

are produced by

	vreportf("error: ", "       " /* 7 spaces */,
		 "the first line of an error message\nand the second ...");
	vreportf("info: ", "      " /* 6 spaces */,
		 "the first line of an info message\nand the second ...");

And if all of these string literals were inside _(), then depending
on how many display columns translated version of "error" and "info"
takes in the target language, these 7-space and 6-space secondary
prefixes would be "translated" differently.

Of course, since your language may translate "error" and "fatal" to
different display columns, the 7-space secondary prefix in this one

	vreportf("fatal: ", "       " /* 7 spaces */,
		 "the first line of a fatal error message\nand the second ...");

needs to be mapped to a string that is differnt from the 7-space for
"error: ".  I think you would use "contexts" to map the same source
7-space to different translated string when it becomes necessary.

https://www.gnu.org/software/gettext/manual/html_node/Contexts.html
