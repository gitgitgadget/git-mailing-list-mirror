Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C8FB201A4
	for <e@80x24.org>; Mon, 15 May 2017 02:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755941AbdEOCSn (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 22:18:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34592 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdEOCSm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 22:18:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so14991652pgb.1
        for <git@vger.kernel.org>; Sun, 14 May 2017 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/kHOBXPYXN4EHFQopR+5pHqjzyfn6vr+3j/BqzTMcrM=;
        b=WZEsmiE8m4Yv1gbzV2H01J3WnpHOKwUFkqJ+fRV0ssY/nGZjW47woWdIMndhOzcrcy
         6TWfCIlS/QaFnhNUlqjk+/FkzC3MKzy1XKclgmRSokN+oDJ6pNAfvlmkGny4x15Uiw19
         jPIHgeF0VilJ7mni9AWyM8H5MWiPL3MsxyBqHyiEqLemkcANU+arTusJ+Fm3JemUbYXt
         8IlhHCqDD4qKBqM1rZNEB+eJLRkUI98wkgdLi3UuVCjjVknS6Lx2mOiUMVh9MYTu/xOs
         nx8+aC0Qeambmp3UaUIh251Bb4U3kSni2oBs2UuXyVGM4ZSdTIHQAoWnBBMlExbZVzcc
         OA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/kHOBXPYXN4EHFQopR+5pHqjzyfn6vr+3j/BqzTMcrM=;
        b=Q7h2hxmIybB0E3pUqVIs4zf4d0FmMTBo/heybjm1zUbyuKJCpvUdHmb6vZZOIvRZvD
         WQXyCTd/Q/+fxBf9TbWsTnLX/Tg/4xkvmr5vrqj3gwE+eDa/OSu9SdH36Tdb9aPtdUnH
         BA1L9iT5c6mIsxS583qTTrxO4r9n084ICbD9r5u/7NKTIqZuGhdNixPS8KbVlzjkqaj6
         8qSDtqX36dxMQq5Ad3RMF9nAAs0HcsVnknMGJdsxsmWkW8QAauEJw6yOfwFJASMyyeUq
         CTUaJpiHiSVZdZmjrzdfsg13KA9uXqTQvhvfLFWNVfJPmLENBBnPzUI9H+nn8G6fJXTV
         hDcQ==
X-Gm-Message-State: AODbwcDHdP4667ExraqHm2sdlrR45WnppP2x2yG0Ht+HP1ggpDzNi2qr
        z5MsSXNQf8vxIQ==
X-Received: by 10.99.63.132 with SMTP id m126mr3679353pga.166.1494814721853;
        Sun, 14 May 2017 19:18:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id t66sm18612273pfe.134.2017.05.14.19.18.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 19:18:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] usability: don't ask questions if no reply is required
References: <20170503162931.30721-1-jn.avila@free.fr>
        <20170512130317.25832-1-jn.avila@free.fr>
        <xmqqpofd4s91.fsf@gitster.mtv.corp.google.com>
        <3c1fb7c7-9306-b0c9-f0ea-cabcd944b124@kdbg.org>
Date:   Mon, 15 May 2017 11:18:40 +0900
In-Reply-To: <3c1fb7c7-9306-b0c9-f0ea-cabcd944b124@kdbg.org> (Johannes Sixt's
        message of "Sat, 13 May 2017 17:37:25 +0200")
Message-ID: <xmqq7f1iyi9r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 13.05.2017 um 00:36 schrieb Junio C Hamano:
>> Thanks, all three patches look good.  Will queue.
>>
>> Let's merge them to 'next' soonish and eventually down to 'master'
>> and 'maint'.
>
> The patches change translated strings. You should probably wait for an
> update of their translations before you release a maintenance version
> with these changes.

Yup, thanks.
