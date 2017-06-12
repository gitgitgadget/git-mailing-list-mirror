Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B643C1F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 15:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbdFLPMf (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 11:12:35 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35126 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbdFLPMe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 11:12:34 -0400
Received: by mail-pg0-f53.google.com with SMTP id k71so46368715pgd.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fHyk1qpUe3pgbGYcj2vOUU/nbaRSBwrIGgVnhXQjArI=;
        b=lzgRkixrIczJ3NENHS46RmGX3rmzmbx5TDu7u5y9A5OGj4X4tQRUuSGrMi8aav3a6/
         qLJ/8893ov3b4aMaZ8LBHb9pum4BMuPiYR6cZaGBiTavdewln3qqV9doWkyYVaRh6l9U
         GSMTmw0XindF5d7TXb9EGA/3ke+UUq9ljYTCSLBwYP9tVl7e8CuF4ZOmtIuQ9aGujNwa
         p6uSGAyTlsWp+KrIxjeqdw8580jGBIbAxRVHdDFkkAY25KZhytBDawmiwpvdERpgvy8t
         SgDDsZ0jYwdk8KFDFCRdEv54YWS7kP1O5XzWRuuDXfL107kPUIXA77W8/itmbHBy+Kom
         xKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fHyk1qpUe3pgbGYcj2vOUU/nbaRSBwrIGgVnhXQjArI=;
        b=O6VOEH7+u07HvUkQM2LBelGFLK3saiy0wFr6u35YyCbayKKmaup6IRwKcGIdAWcV/7
         CBdVfKvo6txJ9IJfMYOlXRxGWNW9A/rNo+KgBR3lt4izf3eyP79vCZqgB8SY2y8uVoJf
         +/23kNfrhWPNEvY8BQvuX+pMHG9QIjQpH7iNStz/ci9vUsGuMp3cnai0SXilZktuLm+4
         HL4zX6gc/VFgHBXnUHOSdyrJBE/9LuKfyK3tLOr89zt1YQ24u/EIV2DghHHUjBgqSjNG
         8p6W164THyPA/xnq1bQ4vl/jyRRX5Y/d0DDpfgCvQTonsVPkVVMq6F+84yW9ECk87auy
         a33g==
X-Gm-Message-State: AODbwcDAwttYy33HnHb1TZOZt1jVfzUG04vJAQLIyX5vtRillkQb+0UN
        NxQov4yYfEHaxQ==
X-Received: by 10.84.215.158 with SMTP id l30mr56406555pli.266.1497280353289;
        Mon, 12 Jun 2017 08:12:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id b65sm21411028pfm.29.2017.06.12.08.12.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 08:12:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Ulrich Mueller <ulm@gentoo.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
References: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
        <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
        <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
        <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
        <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
        <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
        <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
        <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
        <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
        <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
        <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
        <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
Date:   Mon, 12 Jun 2017 08:12:31 -0700
In-Reply-To: <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 11 Jun 2017 19:36:47 +0200")
Message-ID: <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 07.06.2017 um 10:17 schrieb Jeff King:
>> On Sat, Jun 03, 2017 at 12:40:34PM +0200, René Scharfe wrote:
>>> Duplicates strbuf_expand to a certain extent, but not too badly, I
>>> think.  Leaves the door open for letting strftime handle the local
>>> case.
>>
>> I guess you'd plan to do that like this in the caller:
>>
>>    if (date->local)
>> 	tz_name = NULL;
>>    else
>> 	tz_name = "";
>>
>> and then your strftime() doesn't do any %z expansion when tz_name is
>> NULL.
>
> Yes, or you could look up a time zone name somewhere else -- except we
> don't have a way to do that, at least for now.

Is that only "for now"?  I have a feeling that it is fundamentally
impossible with the data we record.  When GMTOFF 9:00 is the only
thing we have for a timestamp, can we tell if we should label it as
JST (aka Asia/Tokyo) or KST (aka Asia/Seoul)?
