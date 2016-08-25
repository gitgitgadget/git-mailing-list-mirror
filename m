Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B7001F859
	for <e@80x24.org>; Thu, 25 Aug 2016 19:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755839AbcHYTY5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 15:24:57 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35288 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbcHYTY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 15:24:57 -0400
Received: by mail-it0-f46.google.com with SMTP id x131so290929480ite.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l6xFwMYcSbjKjLpVMj3PX2DyBn3FLQAlU4bswvsWOzc=;
        b=de5Y+4Fu9lzKYUuP6vbZNa4RkUnOkKbpKu8uudtwj1+M0Po9SBtluOovubiRttlGpj
         Rc1HdxD1CQSO5xA+X8PXOjujudxINE7FJr8GULXKyo/k2Ktvl8+Dh+D6Q2RixATNuKaW
         2k1tasOHTv8LJtuUtx3wKbCWFp7wNz4I8rIPR3nmSzFtSofBgxRaAOXEiakHFcb4iERO
         uud4el7203uIDDiDZo2KWpfiEC2MYLIdvL6UqDzTz/Bd5irowSHBidM+hySq2wXivJ55
         pGQC7PBqSyVtezIYFKnA6hndp+VPA0b39YjyKcC1XHgVJAxjbSowiq2Wu24WaBR0U7hy
         aNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l6xFwMYcSbjKjLpVMj3PX2DyBn3FLQAlU4bswvsWOzc=;
        b=FGj9GOHjwd4WU/z6G1U17BXZq8SB9EeanTYfzUvYVAgpRAmoJJ5vBRStO/fMjNwDbO
         xUGS6ULfWIk2biDpraJtbtDk+cFliNSzTiuqnxiOz4+V5Ye/bT8io8dhcV6Fm/0x+mvY
         NBT9asjryFnbJqDFq41Or7fMvm1ndcYqi/hwQM4fNmW4rBJQJPzZ2VFCm6TOZSdXsB70
         Klxd+vjcIippBUvqDCrM5IXZZ5kk35iQAXL+4i074xsRG9tcT+ZQBH8a9Z35cMfk4XGc
         O/yqhwI3ewIsafSrVc8cMiurH0MT8v4qz2DEmT/6jk2qcoAIg9l3fzklBdi0Zk9Pln0A
         A+8w==
X-Gm-Message-State: AEkoous+jURopD10gsmhb6HSLQ2RKcfdpCHPjYHexQDDCBY3+TZuXmM4/AG5UX+w8SoYAYJzH+DxXn8jnEK+5cz3
X-Received: by 10.107.131.38 with SMTP id f38mr12338490iod.173.1472152642195;
 Thu, 25 Aug 2016 12:17:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 25 Aug 2016 12:17:21 -0700 (PDT)
In-Reply-To: <20160825110752.31581-11-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-11-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Aug 2016 12:17:21 -0700
Message-ID: <CAGZ79kZ5utc+0iXKPh=tu4rD9H6+AKZmc08_jLxQhgiuFUA+Yw@mail.gmail.com>
Subject: Re: [PATCH v6 10/13] convert: generate large test files only once
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
> Generate more interesting large test files

How are the large test files more interesting?
(interesting in the notion of covering more potential bugs?
easier to debug? better to maintain, or just a pleasant read?)

> with pseudo random characters
> in between and reuse these test files in multiple tests. Run tests
> formerly marked as EXPENSIVE every time but with a smaller data set.

Sounds good to me.

>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
