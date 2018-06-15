Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388661F403
	for <e@80x24.org>; Fri, 15 Jun 2018 16:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966306AbeFOQmH (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 12:42:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34573 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966057AbeFOQlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 12:41:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so10558332wro.1
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xe5M8ElLHvVZJk2f8XE3Uk+35VI6CHHTHuS6ki/KNVo=;
        b=pfIucWB4akQUVKANplec4x8wIkfEEK+VsJiLa3WFWDey5MDqNCKNa1UU8RpB7GVeAD
         V9FCWk39XqxLLhEBy9xivtJ5FQMxkOEWPxnd1JldjeducfHX4KAu+tIb29dHcfnp0Kwr
         UD08FzBmuimqkVAYGE27E/itVEEtCkvIvgbZ+bY75pGkq8DAeCwdiiSY35SjA94exWZ4
         bdkHWR0RmH5tzg3cMk8TmbOVxL5ezZU1xejeUIXHpqTy1+2wxKreuk3uFgAbrU579q5C
         NT3a+kmm0ESw6Wvk2HxrsFerEgedMmAQcaiI9V6w3Z248kOifaVcYi2wKMiWF26x0EIr
         CZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xe5M8ElLHvVZJk2f8XE3Uk+35VI6CHHTHuS6ki/KNVo=;
        b=DjVtMxLde/A9RSSTCKRfhBcX8szMAKPxoXREK91rz9Q6r04DTFqzAdGGNpDNyvqk6v
         mZTz0yL/iuV95Flwyi6vU6NKZ8fB3dnVZBfPCPtMR6KdMu5SolzcOwwVxrT9a5IPd+Qu
         i4Hhia3V/GyQ9ZMVByTegklHwuX21tosA0kGFbeDGIVAOcFa8AobTTas0EovGuwA4hrG
         OIzgoQMk9HpjcUI2CDMhn3C9Uz4bbptTSfN5U+3fn7pURcR0QSkEajsaEIxqDorg5XD4
         OSfFxd62gm87fSpciooVjFZzMBUzGtZus/LPJV+uIzw4mz13fpXDTnB8ker7sEkuvG64
         YDDQ==
X-Gm-Message-State: APt69E0Q6lEFh2PsoqiD3XYZOZaWWzAKXHB40BLZgzQT3jhXmXY7z89j
        r9jPkuWQ3j1oddtvlECj/0w=
X-Google-Smtp-Source: ADUXVKL6xWgu94FhcsROcnZFTGiTdePd2YxQMN4gDwng2Q2RcPGO6XTtQ7Y98ul3ZkQ+Pb0fvJGyOg==
X-Received: by 2002:adf:a419:: with SMTP id d25-v6mr2266141wra.121.1529080908976;
        Fri, 15 Jun 2018 09:41:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w24-v6sm1545954wmc.15.2018.06.15.09.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 09:41:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Luat Nguyen <root@l4w.io>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/3] ewah: adjust callers of ewah_read_mmap()
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
        <20180615032850.GA23241@sigill.intra.peff.net>
        <20180615034442.GA14422@sigill.intra.peff.net>
        <f6931351-df79-cb76-ee29-c57472a6a201@gmail.com>
Date:   Fri, 15 Jun 2018 09:41:46 -0700
In-Reply-To: <f6931351-df79-cb76-ee29-c57472a6a201@gmail.com> (Derrick
        Stolee's message of "Fri, 15 Jun 2018 07:23:15 -0400")
Message-ID: <xmqq1sd82e9h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/14/2018 11:44 PM, Jeff King wrote:
>> The return value of ewah_read_mmap() is now an ssize_t,
>> since we could (in theory) process up to 32GB of data. This
>> would never happen in practice, but a corrupt or malicious
>> .bitmap or index file could convince us to do so.
>
> Aside: Why a 32GB limit? Usually I see 32-bit issues limiting by 2
> (signed) or 4 GB (unsigned). Is there something specifically in the
> bitmap format that stops at this size?

The proposed log message for 1/3 has this bit

  - check the size for integer overflow (this should be
    impossible on 64-bit, as the size is given as a 32-bit
    count of 8-byte words, but is possible on a 32-bit
    system)

4 Giga 8-byte words makes 32 Giga bytes, I'd guess.
