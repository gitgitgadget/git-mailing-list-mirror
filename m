Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04B420984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759454AbcIMWk2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:40:28 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35615 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758095AbcIMWk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:40:26 -0400
Received: by mail-it0-f41.google.com with SMTP id r192so18491058ita.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TT02da0VBjS7bDXUxzf+v0S+8pWJylT8ys2MhQZcVrw=;
        b=K2jzG3+uvR2es2J+xTjVyzGCLI6yR2hzre4/x56y+P3OnGjUdIK7OR3cwvusFQBx/g
         hsMGA6lmIsN79BItqwBLuQTzqsykNab0sSne4r8PprDqlFNWrkykA3OBKTvnRrnQ2z4V
         AZ7DCbePJKtXducgRXRlnVGCcrDTEjSpSQLzHYU1PGi9pkZ4OGxiE7czKrQm8jE7UsdY
         A8QW0/TZZadj0QLfuVKJLvwqdqwjTqbXQ8P3Wk8avgpkGlYPXghTJY4MdalcjER+7cRk
         IM4+7KokJHtnMkc9NMA8QiogezzzF0+r9hZPhbofwskaEtAQQztnN7X8Daqh1vWwWP1k
         lUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TT02da0VBjS7bDXUxzf+v0S+8pWJylT8ys2MhQZcVrw=;
        b=M1iT51IroyJtI6uou0oYFIxe+8Edsg4Hg65AVNjznAZtvjry0WDycemxBwl+05xxry
         jdglrV61jwnYGeh3Q0nLKSCMaVCbXMxNpltKCys2P/F3D3prI4mv6hJ/5nNERofCkCzP
         0Gu/9fgAAfU/R07LjltG3O7vs32wPN/yOe53RHkTSpi0InpyuI8c82Zd9Kz6H124HAUl
         i4ene5dwQumly107DwG8P/bQufklTQT6E7nhOJz/ZZdfA+J14Y+bW3Nc4g6F7TpgoeSb
         vbwSdkvhznsA7IX3hvJUg5ZvGzJfReAIDWErXj75YMseSZYG+LbeHG5AwXqMeFPy8WoZ
         yGbg==
X-Gm-Message-State: AE9vXwO8nBqQhqWKAFgNoc7n404syoIpr4LcrNkqJClzJXBrjMjjMJ6t8Dc+Ds2dnNV0G3tqgbdGB+t7hkxF+kSV
X-Received: by 10.107.136.15 with SMTP id k15mr5888133iod.83.1473806425260;
 Tue, 13 Sep 2016 15:40:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 13 Sep 2016 15:40:24 -0700 (PDT)
In-Reply-To: <848f36c9-4ac9-5316-1143-c47b48790847@web.de>
References: <20160913044613.1037-1-sbeller@google.com> <20160913044613.1037-2-sbeller@google.com>
 <848f36c9-4ac9-5316-1143-c47b48790847@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Sep 2016 15:40:24 -0700
Message-ID: <CAGZ79kYriQpGd+V00c+90iTfpFo8tR2Os=rYBZR28p07mySeXQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 01/17] diff: move line ending check into emit_hunk_header
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 7:42 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

>>
>>         strbuf_add(&msgbuf, line + len, org_len - len);
>> +       if (line[org_len - 1] !=3D '\n')
>> +               strbuf_addch(&msgbuf, '\n');
>> +
>
>
> Using strbuf_complete_line() would be nicer.

That makes sense!

Thanks,
Stefan
