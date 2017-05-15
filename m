Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D2A201A4
	for <e@80x24.org>; Mon, 15 May 2017 01:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdEOBjF (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 21:39:05 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34397 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdEOBjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 21:39:04 -0400
Received: by mail-pf0-f173.google.com with SMTP id 9so14859404pfj.1
        for <git@vger.kernel.org>; Sun, 14 May 2017 18:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eWdK0RLn/kg+RHfz9AmcwSmeICorZ+jiJNTiEpCcblE=;
        b=GfVP+KhZBWE/mUjYwrfQlaoHv0cmfSxF2UIGnAKXgKP5aMI4LRzPtdn7rSlB2lt64x
         fI7DhvurbDvJr1n5kq6yQO7Xf2tIqboIulsx+5WCk5wyGNDf4pcemjZQ8Ak52COB/Beq
         WDicS7h1kNqrJ8t1rwqpMFPx605SdjC2ZnNFE4R1OjvrR8Y0x2ZG4Ef+1zK5rJy9YGOp
         63PmaOUkVNnGGo31p8Q+GNoW+ZDw1BIi+YLnXjht4IqgNhDJf4DlGDwoZ8+0L+cKIf9Q
         8PxpW3qvdc2nT9kGvdaIq4TQlE8gkwPqCt6h5ITRA3J6C3QIUVWFAYt+d+9vOBpF9S/h
         gQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eWdK0RLn/kg+RHfz9AmcwSmeICorZ+jiJNTiEpCcblE=;
        b=SZE2j6S83niKx4FI7Q/AjksZol6Y5MSiRYdGq6LsdIAWl6d6wTrgqCDnyuZQY+7Fcm
         jv4AfN/FB/ZWJm8V0M5GU2BLi2JZPD9p/RISiCRQV1OHH7GRzQxQeZg9dclwbuFjNtM/
         lpSVAvPSJ/G2y7QRKNz7mvQjHfPfSwzN39IatWFLqsYUtN3ylKJcZGS3m2zxN+AW+rXV
         kziCA2BgWWOrw8SM8S03E+oJtlumUkU4E5ykMN23JrMkUp7TZXSu13wXW5A1q+xCtAen
         ed5GRpjRk7IDmbblb4tfZ32/NilylwUlGPsgaDrgXhgGnIPmRdMCOzvD/n6ih0BP606R
         demg==
X-Gm-Message-State: AODbwcC3iSZdapbarngW9F3ccj/jNbSKQzifPzR05WF+7A0O/zrGeJxZ
        4ziRgFCrJTyX7g==
X-Received: by 10.99.119.76 with SMTP id s73mr3622751pgc.215.1494812343293;
        Sun, 14 May 2017 18:39:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id n71sm19349595pfg.46.2017.05.14.18.39.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 18:39:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] compat/regex: fix compilation on Windows
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
        <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com>
Date:   Mon, 15 May 2017 10:39:01 +0900
In-Reply-To: <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 13 May
 2017 00:27:51
        +0200")
Message-ID: <xmqqo9uuyk3u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Let's drop this current gawk import series.
>
> After talking to the gawk author it turns out it's better to use the
> version from gnulib, this includes the equivalent of your patch.

OK.  That may make things simpler ;-)

Thanks.
