Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42285C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B831207DD
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/nwEKcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgFMSBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFMSBG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 14:01:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED1EC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 11:01:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so12990347wrm.13
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/wudoVy8a/7rUL/Qdmd89HVtyM+2KgmJvLjiuArMupc=;
        b=t/nwEKcFImCzJwGQJa8G9v1TSr+nqOr/Ej9bsblFWFPQBlXgS5yX7zTCLHeWfUxfan
         DurNf+i4gnV4G0bLzXPdTBnVX4bEveEq1f5MAGUWB17vHR6auzuKqkLur+b2ifh2A3cz
         68y+eNTEfyiDMBv68JM++WwSjgK0U3kmgyyhcuyr943XYoi6SNMZawGVHqWhd2HCK62m
         0Jvu5z7dRDzPrJGSdGABiUKEzpMD9L04fjPAD2Hdq6c/tpcy4dUhmjbNsM9AGfKSNF4k
         dTDr8CuJOewUAeDBFa1rW9f61++cV9TlkHDYEKX2bLocPt4aPNZ7lFFIm0+80jYLKoWA
         d+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/wudoVy8a/7rUL/Qdmd89HVtyM+2KgmJvLjiuArMupc=;
        b=BYA4R38lczd39B1nU2XNTPVKtnRMu+9TzPGM6GA7WnPJYV8fRWJrEZWG5U55SvBYdH
         YyEMyPtgJRKBtI7OvxbNjT8/RI+vGzcsUSNTDZpmzdEFd1LTkn6QwnwWMCViVzhGrMGT
         1/mRSquaZjRdunuXa6VGLQ4CrT98Su9VjlQJGkbI5wGg4EaVDnQByyMuNrt9hdEdrks8
         oDnEhYWpBnmSd/FRY+K1NtaJUrrCK6eFKcRuf+YIR9bNatwn8GQh4+3TXGYUjQn0h+/X
         y6AfgHtmrDaeh2ctN8dh9V9Ygrn1qjCOn3syZTzStNVWb4awC0SjGoZATWTMusmcqY5p
         T4JA==
X-Gm-Message-State: AOAM531J4ngaw864egbavJr9kgr6hZDSAdPfQHrD78U8iP2v4+yDePbd
        txyHI+gcKrPcqUWUr32RagM=
X-Google-Smtp-Source: ABdhPJx65yirN4vSnN6Lnvir08LxgVDQOmZUGe931D6wHeLW7se5qo8YZBL4cwW8Ffl6bsw/qshHwg==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr20118225wrr.119.1592071264273;
        Sat, 13 Jun 2020 11:01:04 -0700 (PDT)
Received: from [192.168.0.104] (abayonne-651-1-44-79.w92-156.abo.wanadoo.fr. [92.156.149.79])
        by smtp.gmail.com with ESMTPSA id h7sm15174096wml.24.2020.06.13.11.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 11:01:03 -0700 (PDT)
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
 <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com>
 <xmqqwo4di49l.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxA==
Message-ID: <731205c8-7d4b-d87a-17d1-520fdec7375d@gmail.com>
Date:   Sat, 13 Jun 2020 20:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqwo4di49l.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 12/06/2020 à 01:14, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> Why adding yet another environment variable instead of relying only on a
>> config option?  I understand it's for the tests, but can't we add a
>> shell function in test-lib.sh (and friends) that tries to read
>> `GIT_TEST_DEFAULT_BRANCH_NAME', and, if it exists, sets
>> `core.defaultBranchName'?
> 
> Can you produce such a patch that does it cleanly?  My knee jerk
> reaction is that I would suspect that you end up having to touch
> many places in the t/ scripts, but if you prove otherwise, that
> would certainly be appreciated.
> 
> And no, 
> 
>     git () { command git -c core.defaultBranchName=master "$@" }
> 
> is not an acceptable solution.
> 

I wanted to to do something like this:

  if test -n "$GIT_TEST_DEFAULT_BRANCH_NAME";
  then
      git config core.defaultBranchName "$GIT_TEST_DEFAULT_BRANCH_NAME"
  fi

But since we do not have a repository to store the config, it won't
work.  Sorry for the noise.

Alban

