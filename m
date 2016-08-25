Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BD11F859
	for <e@80x24.org>; Thu, 25 Aug 2016 18:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbcHYS7o (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 14:59:44 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38439 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbcHYS7n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 14:59:43 -0400
Received: by mail-it0-f44.google.com with SMTP id n128so107016385ith.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7LrE1stcjchr/7HzdCR31CdJXSDk1q5ChS60iXJdSSc=;
        b=BH3JrOztxB/+jpGXjeiRmZAAkHUuUQFgnPfbz4Reo78Ni3kNyFLuAdoGfu+4016iI+
         6c8ZkHOcQ58W3x3J4cAKVuGQ4lK17tPx7rtjZ7G3CrsZJEXzi+aUcziDECJBhl2x8Sqj
         HFYWvLwOBh92L9Kja04kxjnCirojyDiopmRhIvyZQBu2tBWpHgteP8+OQPXg/Ur9sa1d
         dUHt4fRxE6M4ksbxUU9aempwXFCj/hXiNH6MeelLg3lzxARtB7u3AvanCojoVFsC/dYm
         cAJGJc0NBHNS2fJ722CpdJ0v6gQPQXKpagcpFv+iwgwNfQHd9WlOVQEDT1JEe1dOgdQ+
         oy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7LrE1stcjchr/7HzdCR31CdJXSDk1q5ChS60iXJdSSc=;
        b=kyZAT7Gd0fWNwlc9aYwE3i/vurA5dhHC6e/lOGe6AbgShfFF5ZQ0ZuBx3eo4zA75+M
         poeH7PpV7k4f0cAnwKYFrCdFTFy+PdvcK/y6hnjr6e4Rz1lqbCZEJ+qtBzxj20Hq5qAr
         Mb3ywKzhPHCQbWvcg/5xtKaICT7ye2RuSo+s7z3So1HWkBZVczD6hqn7CbVcq136ceVk
         Y9MR5201tqfCP/xwmdIEEhqXRrQFur0AUTwOHgJWEFvb202DRMLnozuWQMZOX0R+DgkV
         XkhzWGaqqSPCPCVb2kKPLKyOvygUXQm6bJMGpYxvFWKt69ZJW+VQlmZ3iWgRnJuSXQ6m
         4KbQ==
X-Gm-Message-State: AEkoouupUxrbPdPm9QGfK6FJzdA/8qiKdi0aK3pUaew9PtqrgiWFM2/PDPZyYTNgXK5W8pMO/44Gt3mbqHwiySwv
X-Received: by 10.107.178.129 with SMTP id b123mr12395358iof.83.1472151582185;
 Thu, 25 Aug 2016 11:59:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 25 Aug 2016 11:59:41 -0700 (PDT)
In-Reply-To: <20160825110752.31581-8-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-8-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Aug 2016 11:59:41 -0700
Message-ID: <CAGZ79kaJn-yf28+Ls2JyqSs6Jt-Oj2JW-sAXQn-Oe5xaxSyjMQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/13] pack-protocol: fix maximum pkt-line size
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 4:07 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> According to LARGE_PACKET_MAX in pkt-line.h the maximal length of a
> pkt-line packet is 65520 bytes. The pkt-line header takes 4 bytes and
> therefore the pkt-line data component must not exceed 65516 bytes.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

I was recently encouraged off list to really try hard to go with
shorter series's.
(Duh! Everyone knows that shorter series go in faster ;)

And as this is a strict bug fix of Documentation that makes sense
outside this series,
I'd like to encourage you to send this as a separate patch in case you
need further
rerolls.

Thanks,
Stefan

>
