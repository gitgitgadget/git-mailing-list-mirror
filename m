Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF6FC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 23:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE620700
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 23:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="gPMlVCmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgFYXy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgFYXy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 19:54:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11293C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 16:54:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so8391681ljg.13
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 16:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gY7KDdx5QtS1kFVbLwE+jJPAb2Z7XT9QmHYjXLUyk9c=;
        b=gPMlVCmxyMWfiNJ3QmJrLM5SPqcOpZS2LRQveoXbjKcJ1fojwY4W7yEi02WS7kSGDD
         Bg6BVv0Ll4D8H/0pucro3g9bsaBdB7xeZ/rsNXe9KB4uqb56F46THufBhInxbDcMtHDW
         3nIUhRg2rha2ZE1cS71cOmWtgpAGwvExC1QjBmXzPix8EzNsEvIu0R+c+uTM3Sz/3OQF
         daPuBhTk4bLOylMpfzziDCHyhjlATbQTPU4RkQZPYwCZl1mcNzWY73tczp6uXgm1gNcj
         C89DYjQEVT3o7r8+gnRv25mzcFsMHIR9GWLmF2vhzNK6o2RRDhyZh9QRqza05d7bV5Ve
         RGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY7KDdx5QtS1kFVbLwE+jJPAb2Z7XT9QmHYjXLUyk9c=;
        b=h73WToU8Dnv/O0yqCY6Oeo/g4knXUOh9ogYqGB8lRUuJnZvVcRE0cJpIcOQJF5m8FO
         JbybdBq0Xprwr3c0n9cjXfuQRjmIbqi5hjriNkWLRkR12nimi3NaKFHqgDB05cuAmtnC
         7J7NlPJktlvUWeYS3tgoHgOOal3nt/XZsnOwKAAzNW+fOU2Xg9xGgi1r+62GW8wLuq2W
         ZAOewOcz0McCkqSkvsAuSIoAPQW3ltVOo1ZeYOLcH3Y7LSSkdqUhcpF9pOr92vFf3Hz8
         6XCcFZgADH5Vm8I9BiatcIdRTtyopWcLuI5kV8yJueferoJT6UzKikp862Sr6+gRf9S1
         2GWQ==
X-Gm-Message-State: AOAM530lOBabobecTjOlRwD7FpZRCJa/shStXpTaFjN8sIvcey0XRP7l
        J8A66V20qfkiSF4+9Izv8s+7yt396SsDC12rlnHD1A==
X-Google-Smtp-Source: ABdhPJzDjhuseRJgwdR/bk49mNjXxg0cN9TI1hSyLxzRc3Qn8N+tRb3eTusq9p54Gcn2MH1Xy9mHg7jEnzXViVoYjfo=
X-Received: by 2002:a2e:2f1e:: with SMTP id v30mr81908ljv.202.1593129295112;
 Thu, 25 Jun 2020 16:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593115455.git.matheus.bernardino@usp.br>
 <0104cd9c763aee220a2df357834c79b10695ee35.1593115455.git.matheus.bernardino@usp.br>
 <20200625230753.GB9782@camp.crustytoothpaste.net>
In-Reply-To: <20200625230753.GB9782@camp.crustytoothpaste.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 25 Jun 2020 20:54:43 -0300
Message-ID: <CAHd-oW7GzbtWONYiE9RHQRSzeB1gGvbojJEzdKSMg7qQTMCuOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hex: make hash_to_hex_algop() and friends thread-safe
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 25, 2020 at 8:08 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-06-25 at 20:32:57, Matheus Tavares wrote:
> > +#ifdef HAVE_THREADS
> > +     void *value;
> > +
> > +     if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
> > +             die(_("failed to initialize threads' key for hash to hex conversion"));
> > +
> > +     value = pthread_key_getspecific(&hexbuf_array_key);
>
> I think the portable name for this is "pthread_getspecific".  That
> appears to be what POSIX specifies and what our Windows pthread compat
> code uses.

Right, thanks for noticing that!

(I wonder how the Windows build passed successfully in our CI [1]...
Shouldn't the compiler have failed due to a "undefined reference"
error?)

[1]: https://github.com/matheustavares/git/runs/808649609
