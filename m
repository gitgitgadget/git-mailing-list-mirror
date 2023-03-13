Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1567C74A4B
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 17:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCMRT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjCMRSz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 13:18:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEAC5B8A
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 10:18:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so4954836pjb.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678727854;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ee5+35NLTZAHz5EeBpKWsU/PwFfxQMFVZ4SDiCvxP4Q=;
        b=UBGh+WlJvqbvER0UHL+46TfVnn/TRkkpjWnYJVfnYWwYRa+kttXIw8n5Ju96nVWxm+
         l8vPXxNuj+U8sLxfUu+HDL/oK5qbN2RzvkXxnKBp851fy78Oo6Vipzo+oWSF1e/CtUQY
         2jGmxI4nglPgHnsQJ2h1tkhFtr4oVcquTyZXclEMqND6scl/PD2AXtzkzbYbt8xcMsoG
         vntghVZyQDdp+NPv7fN/VXcBVuN2d2dBB810H9e0DhPpueqdpalbxOp1rKtN4PzkwWmq
         xtUiMdLQkJFTdRDjcvncYW3QV7hL3IxSjCEwzGZjwPYEDXdoN8xneX8b28CR5BQXnNXG
         SfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678727854;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ee5+35NLTZAHz5EeBpKWsU/PwFfxQMFVZ4SDiCvxP4Q=;
        b=t83aUs6mCaEknJlmqgK972GdUGTdj5/+jAD/2ZksXVFaX3YMAAZqc0KmPkWZzfDoCU
         avQcbSLJ6L8+G/BGPMUOtQNcdagPnEP7nK/RiB1hCjXgIW77aqsTWw/XaS58KjsCLNDm
         +Ke7qAENI0A7alg6SMKcGApFMMoGpsC3eS1s+9ltQEyy1UWIe4YQSmaab/mHCetDKsud
         WEofQj6fUnNVLdaZaRrYu88mSHXzqzp1NcOOMC4QZMkHFdqDXdudBGiBtZt/ndDSlWAC
         TeD7bkoPPTnbkO2EJIynGuaLaCpaiPM90WGzvl/C9GK3Q25mQtg43/51r7WIRZUvkP0h
         FYzw==
X-Gm-Message-State: AO0yUKWd193zKHaCwilXAV1TtzNqVsaIC/VhcBlfHcDZeMZCdcwlpJQj
        P5UNI5GWWCwd91Yk+LCOT5M=
X-Google-Smtp-Source: AK7set+8WZLFVIdtGhZGk5arAwonLvfmeZ5a6SlXdDDDtYKwQGmQts+SudelpAUo1nZdp8oJJSyi/A==
X-Received: by 2002:a17:90a:db96:b0:23d:1d5d:6e95 with SMTP id h22-20020a17090adb9600b0023d1d5d6e95mr1988699pjv.33.1678727853776;
        Mon, 13 Mar 2023 10:17:33 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090aa38300b0023cfbe7d62esm391482pjp.1.2023.03.13.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 10:17:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
        <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
        <xmqq5yb9q42e.fsf@gitster.g>
        <ZAr7+zW+pkOXoIfL@coredump.intra.peff.net>
        <xmqqcz5g7d2i.fsf@gitster.g>
        <ZA9SmZaUyrgbH2fb@coredump.intra.peff.net>
Date:   Mon, 13 Mar 2023 10:17:33 -0700
In-Reply-To: <ZA9SmZaUyrgbH2fb@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 13 Mar 2023 12:43:05 -0400")
Message-ID: <xmqqjzzkwoya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Sure, but how do we send that message? I guess if we leave diff.noprefix
> as it is and add a new format.patch (which preempts diff.noprefix only
> for format-patch), then people will still accidentally send patches
> without prefixes, but at least there is an "out" for the maintainer
> receiving them to say "don't do that; please set format.patch".

I actually was hoping that it would be enough if the message were
"please unset diff.noprefix---in this project the convention is
to use -p1 patches, so get used to seeing a/ and b/ prefixes".

Even if a project wants -p0, the same approach would almost work,
but it would need apply.pValue support to help the receiving end.

But as we already concluded, let's cook the current 5-patch series
in 'next' and see what happens.

Thanks.
