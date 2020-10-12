Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53EFC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D39208FE
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=narod.ru header.i=@narod.ru header.b="FmcIoCva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbgJLLMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 07:12:52 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:41983 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387617AbgJLLMw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Oct 2020 07:12:52 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 07:12:51 EDT
Received: from mxback22j.mail.yandex.net (mxback22j.mail.yandex.net [IPv6:2a02:6b8:0:1619::222])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 8305C5980D31
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 14:05:59 +0300 (MSK)
Received: from myt6-016ca1315a73.qloud-c.yandex.net (myt6-016ca1315a73.qloud-c.yandex.net [2a02:6b8:c12:4e0e:0:640:16c:a131])
        by mxback22j.mail.yandex.net (mxback/Yandex) with ESMTP id cAdksRSCLR-5xjWAApJ;
        Mon, 12 Oct 2020 14:05:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narod.ru; s=mail; t=1602500759;
        bh=CAkJPVjAl5ur27OD1RJbF4MoB+snqPII+GZOYccA1Ak=;
        h=Subject:From:To:Date:Message-ID;
        b=FmcIoCvafM6V1sUlK+3TTnywaThGV1gFMlnEn6DZ9LePsu9BpdIf9bFoaGgagM0bC
         pj/dN7fyX6WRBoZsAbZf30VpFeLSLnPz4iTlOM3M1RVft8Ue2SgAedHPPQWx7uqp6r
         53w4y/mFFI2a3oazP9fgBnXxCfzRabm95w1TK2M8=
Authentication-Results: mxback22j.mail.yandex.net; dkim=pass header.i=@narod.ru
Received: by myt6-016ca1315a73.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id TRvitCdDUz-5wmC3XXG;
        Mon, 12 Oct 2020 14:05:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Victor Porton <porton@narod.ru>
Subject: Feature: checkout and merge
Autocrypt: addr=porton@narod.ru; keydata=
 mDMEX3jsrhYJKwYBBAHaRw8BAQdAe070of34x3DrKbRD/txe/g8cWLeKEXuC9hXVTfFoTM20
 H1ZpY3RvciBQb3J0b24gPHBvcnRvbkBuYXJvZC5ydT6IkAQTFggAOBYhBFvZfvcPyBy3zb0E
 tMg/jYQvC2W6BQJfeOyuAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMg/jYQvC2W6
 /Z4BALR9Ftngv/bjrj0QoQHJf55ph7Xu6ARBEXQGTzklBXdJAP9ZssTJEe+QnnCxdUlgY913
 2M1vn7uBx+8KrPNvGy84A7g4BF947K4SCisGAQQBl1UBBQEBB0BjrVMq/DFtBsyNkUy3pBdC
 Lj3FGBl9sWO0ROrYtXSUBgMBCAeIeAQYFggAIBYhBFvZfvcPyBy3zb0EtMg/jYQvC2W6BQJf
 eOyuAhsMAAoJEMg/jYQvC2W6/ZcBAIQayxy650jTa81o9xF22+U4xS9TlhKhD3gNhUBNFr58
 AQD5Bz6FTt78i4/CZuw7xpXQFPgqHnDVcD8KhRD2echFBA==
Message-ID: <28a86c75-de4d-acbe-dab7-e5512961538c@narod.ru>
Date:   Mon, 12 Oct 2020 14:05:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a very often need to checkout a branch and them merge the branch
that was before the checkout. Moreover after this is very often needed
to push.

So please add the flags to `checkout`:

1. to merge the old branch immediately after checkout

2. to push after checkout

I repeatedly write:

git checkout stable && git merge main && git push && git checkout main

(I am not subscribed to this mailing list.)


