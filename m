Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EEBC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0352072A
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDn+yX56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgG3TZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3TZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 15:25:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F19C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 12:25:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so6670464wme.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 12:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAHWJtS4NBrQVmGX/arpU7yiVymD0T8TnaLHtN3wI6w=;
        b=tDn+yX56mEGPnUD5C0flqbBxtO6yfXK3MLigFqddSgtltGb6CnpqV2BbdhzsOH1Saa
         fgCkCdr12tACM2+NU2Rml0wtXFF7/52MabVZJQ7gyGboLqdRUa4u05kc7dmN0VRAhGJl
         a8UimeNvjxw0a6DbBJBV0v8+0CuZwVQHAzf1k2AYQTAqmxBe00mNPV3xW4cqQfApRX+u
         kFjxk1wVLChU2zTuGpsvC9QRsuWQ7hT6GndEhhsFp+AVvH+0Jk1z3Ml9vEfDsmjSLT5h
         z5+e/tUi73EbKqTEAyHqNPSU2/XSbqAR2ywc9FzRIGquFgCV5nrWrcguUYTPcZ7Wvwgg
         asSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAHWJtS4NBrQVmGX/arpU7yiVymD0T8TnaLHtN3wI6w=;
        b=nvW9P3o7tGcP+wc1n+/+tvS8xFpGRvFSZt7qWt0AMn6y2LJmDQwXQpnaE8f0uGEf5U
         PaqNzQfMMRcQTIO/BaPujNTCoI3ZvTG6l9unjy6rZZhbi2IPPzDswam0slsbIEb1TyzS
         PvHuUtnkEZoTxdwCBOYxINlMvAs0g8liH5JOT48ojAr5PMf3eRExW3KuRw/9SUYy4Imm
         bDyart9EQesJaQ42NjBoZ1zjJQFR8U2Wb3e9lCoERu58RMFnDBfzGf2/MqXyn3dc0rYn
         Y7mE4/p91BSYdVNaofJbiL/YihfApEGwP9QgTIENERBrbCOEgJKvqrW5GJIdLQ5Inuo3
         5rFQ==
X-Gm-Message-State: AOAM530j4txD8lLUjjBvZW7fxmsytDRZxTFz3OPV8ICvF1qy8IbJXe8C
        B6KPNfRZtkE8RfAcMEA8Y7/wdZOnf9mLnvSEBSk=
X-Google-Smtp-Source: ABdhPJyw1gsJ2lhBxdFQllVXC4uf+DLTdfJ2OVMY34URWRhpuq13+kTGkPnYkRCSH8uEYS+QjS+yJDb+gU0ejdXFwXg=
X-Received: by 2002:a1c:286:: with SMTP id 128mr592406wmc.37.1596137108894;
 Thu, 30 Jul 2020 12:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com> <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
 <20200729222334.GE2965447@google.com> <b374cb3a-f681-d514-c465-6b3f0b674bcf@gmail.com>
 <c0b9876a-9041-3400-25ac-e52568a02074@gmail.com>
In-Reply-To: <c0b9876a-9041-3400-25ac-e52568a02074@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 30 Jul 2020 12:24:57 -0700
Message-ID: <CAPx1GvfcDeCBLMFbTtCpEK13uCWQQ+u=R1x1qE2kBD3eXVwh7A@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        steadmon@google.com, jrnieder@gmail.com, Jeff King <peff@peff.net>,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 12:04 PM Derrick Stolee <stolee@gmail.com> wrote:
> > This is actually ((1 << 31) - 1) because "unsigned long" is 32-bits
> > on Windows. But it's better to not use magic numbers and instead use
> > operations like this.
>
> Nevermind. This breaks the build on 32-bit machines (even adding a few
> "L" characters). I'll replace my magic decimal number with a magic
> hexadecimal number.

You would need something along these lines:

    #define WHATEVER ((long)((1UL << 31) - 1))

i.e., make the constant 1 be "unsigned long" so that the shift is
well defined, then subtract 1, then convert back to signed long.

I say "something along" because there are several more ways to write
it.  I'm not really a big fan of most of them, and 0x7FFFFFFF (or in
lowercase) is my own preference here too.

Chris
