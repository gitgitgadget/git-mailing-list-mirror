Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77F21F461
	for <e@80x24.org>; Sun, 21 Jul 2019 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfGUSer convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 21 Jul 2019 14:34:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54502 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfGUSer (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jul 2019 14:34:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so33031190wme.4
        for <git@vger.kernel.org>; Sun, 21 Jul 2019 11:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CKf2T60+FflxfN9bOhMN7GqIcukz10l+yJIbSCAJLCI=;
        b=Xbz07hKsb9vW8A3kI8gDlfWDLXJEFC+f1AGHVcs+Cb4bd5pOCJVvWpZuXiUQ5mClat
         yxtavOg/Nlf1us4+0Itqly5owliyeOj9oTJMJvJlk2OCByIUifNmM0A3dikQJ1XUGBAl
         ApVCQnLLfGZAs8uy9Qnl4UDVwsBjQPfYP8ZQkvDYs8d3xSkSwZaAfs/73QTA58PMxYhi
         Fzaaijvw0rwPRzs7HaqkxfYq1NixDNHpSKJYQsKalz6jE+3iO2E1O43XwDN+oIr7mOvJ
         f+9rOPcW47Lg9q7UJc6SjUeVuhKAVR6BRyCZ+iuZZDNngMK/ALbFLSsBXzSvJFFQF9R9
         TH/A==
X-Gm-Message-State: APjAAAUaui0u9iKu7WIUgbVP3liKe05xsihMgC7J0UXac8xtIuV9e0c+
        Q1sGHdbXDX62wojAMp0mQPfeNe65LabJO0jL64g=
X-Google-Smtp-Source: APXvYqyNjFn8znu+sj15yvhIo5mECi19YhMMAq8HxC+iGnzI5GmI56X4B4WTTAciWVaOUA5BOa7mH3VfefemnoIexTY=
X-Received: by 2002:a1c:720e:: with SMTP id n14mr59474402wmc.53.1563734085790;
 Sun, 21 Jul 2019 11:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190721183115.14985-1-carenas@gmail.com>
In-Reply-To: <20190721183115.14985-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Jul 2019 14:34:34 -0400
Message-ID: <CAPig+cTXNvOXfLMgu-b36xzdBabwQuV-hJNNdDYYC_bj11DJJQ@mail.gmail.com>
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 21, 2019 at 2:31 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> grep: skip UTF8 checks explicitally

s/explicitally/explicitly/

> Usually PCRE is compiled with JIT support, and therefore the code
> path used includes calling pcre2_jit_match (for PCRE2), that ignores
> invalid UTF-8 in the corpus.
>
> Make that option explicit so it can be also used when JIT is not
> enabled and pcre2_match is called instead, preventing `git grep`
> to abort when hitting the first binary blob in a fixed match
> after ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15)
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
