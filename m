Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE8D6202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 00:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdCPAOx (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 20:14:53 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35081 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbdCPAOw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 20:14:52 -0400
Received: by mail-pg0-f54.google.com with SMTP id b129so16264636pgc.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 17:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CuT33tAebXwKPrIge8PA6WenVzpcRavG9DW1rdS6htg=;
        b=kW3Z2qqy2En7jo6A+Pz7tdqERQ8c+vZhFNv6uGRE4o3LzkbrT6XPzo/E8n8wD3hh+J
         KbSJKs7xKPBZLOcFRzUS6ohf0QgD5EkLfZpgno6PMFhRgWRXzgVfV8CHvDdNCjixTYh0
         CeJ2mU+6FqNxsTpIxgl5LzUOHgCwnbSz2BL9K3YS9Bb3oeWR55PX7KLSjGFYvcxKOUEC
         KI9DekWkp9Ljth5fIrE3r/1WCfvDQX8sY5g8694OrkiAJFvEp19ThDZGzro6mrnHZJhM
         NAtq9o5oyXvdePZ/x/rpiWLdIdMITkjgSmIAyoV47rfAOTrTPQ+Pwti8KZ9/Kse9jik7
         ZdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CuT33tAebXwKPrIge8PA6WenVzpcRavG9DW1rdS6htg=;
        b=kO4ODpR852fnP0diDqGMfklxCavNX+0KIdTYQgugNKEReoTqwdU0nQGvTXaW/w0fT4
         VDAaAdCbfD7kBfU/Rn6RUXp4qQQxSvB75je0O0xVx/7Ct9pVF44/ksS+NdnehAZRXSv6
         7mlpMUn28UOj1BHi7BWsR4tigT4H5k+T6gNlzVIT+nwD7GAzKDJyucODs+hgo2Po4z/S
         d5p0EX4Wyz4ctMGJoolyAPrLn6FYhOMIj82emED34oQA6h7swWmPS035HlhYLYa05mzb
         AhQwK86efniLL8i06VkRLEa+alqlGaV1Z5kpHL1WcdCgqTJOmFw44oJHFYAgGBaKX/wj
         sOBA==
X-Gm-Message-State: AFeK/H3b1vr+5oervVOSZWhzW/8hpuOTPTopHqrJOm2QeRecjs+Q49IJbLEsKrrkkOvn7MA85tARuMjLYWb0GNad
X-Received: by 10.98.69.86 with SMTP id s83mr6985709pfa.232.1489623262030;
 Wed, 15 Mar 2017 17:14:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 17:14:21 -0700 (PDT)
In-Reply-To: <20170315225045.15788-1-gitster@pobox.com>
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com> <20170315225045.15788-1-gitster@pobox.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 17:14:21 -0700
Message-ID: <CAGZ79kZEzdSbTpaZqmcSwTBAPTPoV4UpmoVH=tHZm1ij3vLrcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Teach name-rev to pay more attention to lightweight tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 3:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here is a reroll of what I did in
>
>     http://public-inbox.org/git/xmqqd1die00j.fsf@gitster.mtv.corp.google.com/
>

Both patches look good to me.

Thanks,
Stefan
