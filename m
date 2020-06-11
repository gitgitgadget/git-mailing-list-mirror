Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EECC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F7120760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 10:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA91aZOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgFKKYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgFKKYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 06:24:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389BBC08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 03:24:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so5581796wrp.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AJ222W9J9HKgKRCt6uuEsQP5ToQRRFDsPimuhGy9YyI=;
        b=bA91aZOTx+Zb7VrNeWBxZuKne+4XGioj5/6B9rNjQG/ZqHqE6FWw0U1ceZhEKIXWnl
         5/oIu9z8F4HsE/iH99uepBycak1yvvTWFooBfLVUg46xo7NgLTIobhQ1uPxnH+NSohYB
         RGAL3doRpQawdhAg4yGf2XOEsCdTFKER7o363XGhtnyrqTmveo7CNn9PgjIofnOghnf1
         jX6Mj2CvuJ0CFrJNfY2duhGXTQgGNawVeDUScvx6v30i3/Wj3Zf4ey+Y3ZBYJFNzAzO4
         TEu1mtv5ziLt5s3F/SvlivarVcQrLybwH2hzEGnGhjJ+DBarPrvL7X434xKxjtLW4CVS
         3Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AJ222W9J9HKgKRCt6uuEsQP5ToQRRFDsPimuhGy9YyI=;
        b=UZ7BU4QCSX4HUOLvzKUys4T2GjRgj51QAs5peIZt4l0W0jIkYQ0sH6UEnCyCmmj61o
         C4HSm06cjLgNjQzPf7yomOsvmcWfCerYKu+3l/JK1eHG8HWUKjcHH2fBuhxfoyyvTYRV
         DuvXCBO/u3xTMbbSk3cUAEn2tbqZAhCl94VzzstK725Mx9kr09yslRN9E5HswLjx75Go
         a21NKvjdlEtG5vNoQykZLTidUaingH9m0w7jCh7dEdEeeARu5dXQ1GdfHXbkbaiJUJba
         LiFhfqhUeE/3kYg7ZL/sMPzfAHhyMCS2nRMS1GbubLxT+OOCZ5b57K9bcXpGGcZeXw3t
         krzA==
X-Gm-Message-State: AOAM5308Kluo23nfmG9Bxfi8eGSyric6DWQdKHR0HZ+uM4MzBwBm764Z
        0NSLTJ+GsxZKiKKRorurq40=
X-Google-Smtp-Source: ABdhPJyM6qMgQNNt9mWdYTwPvjz1qDJPLNFSQrpeVRipa5U524DMk/rp7eIE9mwLtxpNi4G3nYWXrw==
X-Received: by 2002:adf:c6c5:: with SMTP id c5mr8407926wrh.13.1591871040796;
        Thu, 11 Jun 2020 03:24:00 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-283-252.w90-5.abo.wanadoo.fr. [90.5.186.252])
        by smtp.gmail.com with ESMTPSA id j5sm4375771wrm.57.2020.06.11.03.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 03:24:00 -0700 (PDT)
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
To:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
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
Message-ID: <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com>
Date:   Thu, 11 Jun 2020 12:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Don & Johannes,

Le 10/06/2020 à 23:19, Don Goodman-Wilson via GitGitGadget a écrit :
> From: Don Goodman-Wilson <don@goodman-wilson.com>
> 
> There is a growing number of projects trying to avoid the non-inclusive
> name `master` in their repositories. For existing repositories, this
> requires manual work. For new repositories, the only way to do that
> automatically is by copying all of Git's template directory, then
> hard-coding the desired default branch name into the `.git/HEAD` file,
> and then configuring `init.templateDir` to point to those copied
> template files.
> 
> To make this process much less cumbersome, let's introduce support for
> `core.defaultBranchName`. That way, users won't need to keep their
> copied template files up to date, and won't interfere with default hooks
> installed by their administrators.
> 
> While at it, also let users set the default branch name via the
> environment variable `GIT_TEST_DEFAULT_BRANCH_NAME`, in preparation for
> adjusting Git's test suite to a more inclusive default branch name. As
> is common in Git, the `GIT_TEST_*` variable takes precedence over the
> config setting.
> 

Why adding yet another environment variable instead of relying only on a
config option?  I understand it's for the tests, but can't we add a
shell function in test-lib.sh (and friends) that tries to read
`GIT_TEST_DEFAULT_BRANCH_NAME', and, if it exists, sets
`core.defaultBranchName'?

Cheers,
Alban

