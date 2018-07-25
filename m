Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096251F597
	for <e@80x24.org>; Wed, 25 Jul 2018 20:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbeGYVqA (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 17:46:00 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34843 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbeGYVp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 17:45:59 -0400
Received: by mail-wm0-f45.google.com with SMTP id o18-v6so7283969wmc.0
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1/9q21rEMfYBw+tqBM0GGp7MohMuouiptVCaCZcF9QY=;
        b=F8D5srCaxaHfD8OuJdpZ+N8N6pIshF3P+0Ixmk/G9jC5/M+JYMLSXsA+hn7d5X1DNz
         wqwl4zS2K6wxJeX0pKaAItN21Bf7mbGjYl96UAj6y7Vc00CGMnJ6ArFqxMSOQIQGbOrZ
         i0uh8tptEFmju5to1RXnNaLNN2KdyibGJjh2pHjBcL0PFmreFPMpPkc+2CiyEj38wynl
         u7oXd5Q+TXGWlWrg63ubQaUt+RziujIkSE4vgL1zI9QHIzeq7tWP3dD34xmmT66VmQSO
         2q9q2XeHsbHybKbfC8L2sSmLSSixe5elfv6lXNw7cZ/LoyB5MqEKNiJXM2D6g5ekbky7
         rnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1/9q21rEMfYBw+tqBM0GGp7MohMuouiptVCaCZcF9QY=;
        b=pTcIKqiI5OQ5J+sSzXqJ1VcSJeUb1yyWkpl21N+lFpu4FoYXBxqrux3whTl3nuL61x
         Mca+NbycX0tvP9Rlr1MR500GeAXNmQa5Prpzfz03/3qxC02mOiXgTcrtwHfzHjwtVVgm
         6uPO4U5zgSkkXnVHeDQ5YOm917nlq9T0vhOGFqaTfbD3KftmbT6MWJpt+yYkszmcVuPm
         SVsh9LsDEEcNlAJXPwZGqlz3ZwXTd4e9K9KCNzA/kOcBK15XGeniwtpBxf/deNyj3mcu
         zB63S3OqZ7ekD+208eTdqZiHAi3gO5DSbhWTe7qiXpJwwVAs5ROnQ6vmSPEu/dj1yKEK
         /y0A==
X-Gm-Message-State: AOUpUlHlaYcJfkJpVlx+lpQau09ZGzDTng6ydR5Gyh+xRFG9Y45PTnfG
        67R4UrJ058hEWQLrs8fCNgU=
X-Google-Smtp-Source: AAOMgpehmeKE3CTrx8Xi0pEjt2uvhgqG/wW5eEYRDWpN4me31prnxAeuhwmowB1yE4SYfhlZlsZwPg==
X-Received: by 2002:a1c:369c:: with SMTP id y28-v6mr5373643wmh.34.1532550758862;
        Wed, 25 Jul 2018 13:32:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g18-v6sm4592825wmh.21.2018.07.25.13.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 13:32:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 10/14] format-patch: add --range-diff option to embed diff in cover letter
References: <20180722095717.17912-1-sunshine@sunshineco.com>
        <20180722095717.17912-11-sunshine@sunshineco.com>
        <CACsJy8AOeiKp2JnG0h9mw40TdsNft80vUu573ORtqKMor7B+vw@mail.gmail.com>
        <CAPig+cT_7eDyY6xGev4=dwpJnKufpMevO-+hGnXVt4ec0xhEiA@mail.gmail.com>
        <xmqqva93usud.fsf@gitster-ct.c.googlers.com>
        <CAPig+cS-haNwJha44gncB9PrXRPcEPuqDVGLgKii29h=abq6sA@mail.gmail.com>
Date:   Wed, 25 Jul 2018 13:32:37 -0700
In-Reply-To: <CAPig+cS-haNwJha44gncB9PrXRPcEPuqDVGLgKii29h=abq6sA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 25 Jul 2018 15:30:44 -0400")
Message-ID: <xmqqeffrukd6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I did consider other approaches, such as a more generic option. For
> example, --embed=range-diff:<prev>. I also considered supporting more
> complex use-cases. For instance, git-range-diff itself accepts the two
> ranges in several formats ("a..b c..d" or "x...z" or "i j k"), plus
> the creation-factor can be tweaked, so I weighed ways of incorporating
> all that detail into the single argument to --range-diff.
>
> However, those are all difficult to use (onerous to type and remember)
> and difficult to document. Thus, I opted for simplicity of individual,
> straight-forward options (--interdiff, --range-diff,
> --creation-factor), which are easy to type, remember, and document.

Yes, that matches my conclusion that it is OK to have these on
separate options that can grow as many meta-diff formats we would
support.

