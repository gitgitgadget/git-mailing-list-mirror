Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36151200B9
	for <e@80x24.org>; Fri,  4 May 2018 02:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeEDCTe (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 22:19:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33405 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEDCTd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 22:19:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id x12-v6so5151736wmc.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=R9PB9aSDJEgV9szvLgwcLts1VnFab/LXRUzGoOSarjE=;
        b=TNDTde2aD1WzF88hBUg1z6heuD7Coh1ySLxeVO4eCGBmKY38kPukiTR0yYT5roN6p8
         Zklr/FEurWMj+JAdd/+6/ydgjGyGIaUWy8NSbl1nr9yUG5+nGItZ60b7nEGADvS/hahW
         O17pu7P0OcTaqR5tQhMdNiljoNSCoQvsMXXsi/XzLe32YMl42xx0196KibU0QPtAbHm2
         pxb5b2j5SDx72KWYz/yxksSon4NjIl84DWI/waPQYEvmt+wzELDE8dkRzKN27w1j8/Qk
         MpIdyFi76PfZw48sy4gXmXTCIkUU/Rd5rzPUkhntghsSzRH0WasEoDyfHwy+/H6uNPT1
         y4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=R9PB9aSDJEgV9szvLgwcLts1VnFab/LXRUzGoOSarjE=;
        b=PJu6oaaz8jpoeUWDfzapNzmPhRYUVmNS5+NoZ6Q1IMdMpDrzm+ROMBsd4kbM8hElWX
         ryZ880RDB0lh4kuxiHtwcyjh3caWakkkM75benALExZZPDEpdwEPflrgP7EhnxaFeWrL
         SprICg7HoKEt+ORx6Mhemo58c1yWcAtetj8jz3RmuFJ6AxsYwTeLPpSE1oK+efxHlQzt
         /fG9jpa0sHRjKEQbrKUBWuA7uUro+rM1bVakyFzsj34GBUtmkX4A/9WyTHYfxO2gI4d7
         jYop1l4rojZYRx3cgvoe7Z/T6f1qbpgEF9XJ6xQ5wYs97d12KFdKl3zndHKBxc6AUASg
         dZRQ==
X-Gm-Message-State: ALQs6tCccpTGA72qRN80OxMwmhQUSOaLx6CsZmeXA1iBNRe6gdS7swMy
        xBmwIrZLTVazVqYZs8WJ28M=
X-Google-Smtp-Source: AB8JxZqzkNEiLLNgFKJSWVHk1OXVjcfhhx2oHiNfPxTYme3m6J+r/j2C5itX5uyeC+o8uYxCOIQVag==
X-Received: by 10.28.145.196 with SMTP id t187mr15286821wmd.19.1525400372341;
        Thu, 03 May 2018 19:19:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b66sm1207985wma.48.2018.05.03.19.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 19:19:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be tree, not treeish
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-10-avarab@gmail.com>
        <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
        <87wowlxko8.fsf@evledraar.gmail.com>
Date:   Fri, 04 May 2018 11:19:31 +0900
In-Reply-To: <87wowlxko8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 03 May 2018 09:28:23 +0200")
Message-ID: <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> The reason I'm doing this is because I found it confusing that I can't
> do:
>
>     for t in tag commit tree blob; do ./git --exec-path=$PWD rev-parse 7452^{$t}; done
>
> And get, respectively, only the SHAs that match the respective type, but
> currently (with released git) you can do:
>
>     for t in tag commit committish treeish tree blob; do git -c core.disambiguate=$t rev-parse 7452; done

Exactly.  The former asks "I (think I) know 7452 can be used to name
an object of type $t, with peeling if necessary--give me the underlying
object of type $t".  In short, the fact that you can write "$X^{$t}"
says that $X is a $t-ish (otherwise $X cannot be used as a stand-in
for an object of type $t) and that you fully expect that $X can merely
be of type $t-ish and not exactly $t (otherwise you wouldn't be
making sure to coerce $X into $t with ^{$t} notation).

In *THAT* context, disambiguation help that lists objects whose name
begins with "7452" you gave, hoping that it is a unique enough
prefix when it wasn't in reality, *MUST* give $t-ish; restricting it
to $t makes the help mostly useless.

> 1) Am I missing some subtlety or am I correct that there was no way to
> get git to return more than one SHA-1 for ^{commit} or ^{tree} before
> this disambiguation feature was added?

There is no such feature either before or after the disambiguation
help.  I am not saying there shouldn't exist such a feature.  I am
saying that breaking the existing feature and making it useless is
not the way to add such a feature.
