Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDDA1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbeHHV6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:58:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45513 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeHHV6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:58:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so2992503wrv.12
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RzhbL9R0tyCMgM+Y/vac2poRpMX+ECDLVag79COVEWs=;
        b=gaQz/vaV4lo8ilDUbGl+M6Ku8A4nfmgaQtkj80uirEjiFJ2WaAnkUtbDhIgmu7KcUI
         EmOhSDHRvvytpa5kmnNaHQjUlkDiCkJM+SyLs5Mw3j6kWDHl4k1NxKqCZ1OkqED8g+L/
         YW6iHy8+xvUFQIHFTjVc6VP+U3icsOSymcV11+PoNM26FNcp5nAj0YDBB93BEBvyx8Vn
         s0xA8SpyQd8q7MMPwotqZ8Mg3Pd79k6Oeld6EvaME22xS2fIYUPKbfxANaCVG+My/JV4
         TKOvNnUgWcti6x5NingJJDHeyLd5FpT+Jk+lTGHI1/wPc3pMs3motJKRZdF/fRiFz2eT
         3NRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RzhbL9R0tyCMgM+Y/vac2poRpMX+ECDLVag79COVEWs=;
        b=p5hdtTUKpRO3B3fIGgrY6k1O8vdopv8AYxt3z9GED60w0oBCa/I1G9MjZag91AK3oh
         wQeXnHevwGOCTG3UCs1EcfV66PD8djnOyc2KZbbe4ZRM/o4X5iqknczTOkaVAL7pl857
         M+EsKRX4JveLKWrv4CB8hnvPzksOyQaRSMQ+ivLxg4ZqYRweZqF+QpOngQhnYyJmvJfJ
         EP0hd6DQX3SWFRi2rd82yqiV7EMLWqfKLODgZhesNe77xeoTiIVVuI21N3S/AoFuBm9k
         fyjal5Ea8ipVfkL6cMpeYFBxvvvg8mJ59JGWOWUYfe+B/nvbGUpmD3ItyRPnPsQE2E4z
         BxCg==
X-Gm-Message-State: AOUpUlF4foyicuOaQTpJNWmt8gKCQq54u2fBA65IBy8HPRLWTHTOUXS6
        vSCv5wpw6/CxBu8iXk8yrZ33hibk
X-Google-Smtp-Source: AA+uWPzP5cuzmt9OiiS9A/fc78VPQbbATdwuxaQ/QEMbPSXPM2Akk794M2IuKS6Vo0+Ai1+JFl/dKw==
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr2873155wrh.65.1533757058059;
        Wed, 08 Aug 2018 12:37:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u7-v6sm8103313wmd.46.2018.08.08.12.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 12:37:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH 04/11] builtin rebase: support --quiet
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <20180808134830.19949-5-predatoramigo@gmail.com>
        <CAGZ79kah=sGgzJS1rL6Bx1Vkd6RVFLUNEk_o4iqKsjDx5_arJw@mail.gmail.com>
Date:   Wed, 08 Aug 2018 12:37:36 -0700
In-Reply-To: <CAGZ79kah=sGgzJS1rL6Bx1Vkd6RVFLUNEk_o4iqKsjDx5_arJw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 8 Aug 2018 11:31:59 -0700")
Message-ID: <xmqqsh3ofy4f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Aug 8, 2018 at 6:51 AM Pratik Karki <predatoramigo@gmail.com> wrote:
>>
>> This commit introduces a rebase option `--quiet`. While `--quiet` is
>> commonly perceived as opposite to `--verbose`, this is not the case for
>> the rebase command: both `--quiet` and `--verbose` default to `false` if
>> neither `--quiet` nor `--verbose` is present.
>>
>> This commit goes further and introduces `--no-quiet` which is the
>> contrary of `--quiet` and it's introduction doesn't modify any
>> behaviour.

Why?  Is it for completeness (i.e. does the scripted version take
such an option and addition of --no-quiet makes the C rewrite behave
the same)?

>> Note: The `flags` field in `rebase_options` will accumulate more bits in
>> subsequent commits, in particular a verbose and a diffstat flag. And as
>> --quoet inthe shell scripted version of the rebase command switches off
>
>   --quote in the
>
> (in case a resend is needed)

Meaning --quiet?

