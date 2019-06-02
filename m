Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D192E1F609
	for <e@80x24.org>; Sun,  2 Jun 2019 10:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfFBKnd (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 06:43:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33501 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFBKnd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 06:43:33 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so11953929iop.0
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vwUSm0W8U5qLNIl9pUtKpGZTTfxpFS2BmqUnZ4vm97E=;
        b=ixWBSPJOT8s5/I47TgL+9aLL/IIKRVhJVbSNuPB9et77cI3OAVHQFj/Kt1xJ7DZdls
         qFM1zhdTjAFL+9pvXD8VberqjeCy5Zh05lgpldU3e8hJVYos5xAzqW2M+NhQ/1+W28dm
         Nu9h2eVPaBFPy1ptnyoVjkkcVoV4TXm1pZENXJ10DNgOxD0bp2bQIYSYCe0R9CTIOnxL
         KvY/7SLxU5dShqaF94t6izgB9yj3vlGp7burTfJgfqWlyQDMS2loVrfaZAWTSbeaPJZC
         LIbihJogTqmXg+q43Q4Pr75JJJkyUMj+NZW2rj846iDYHLeKNOKBJzZ2IuCJA8/HxKBC
         LvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vwUSm0W8U5qLNIl9pUtKpGZTTfxpFS2BmqUnZ4vm97E=;
        b=GSAYNFL/DDnbjZkpCAe9iuCrK+92yogc2II3R+vt5UgK864Xqi4+FllfdUEiyyC9lT
         pLMrZiBUdMTZBOpbKQC6QdrkfnBrbFM4pVdjqpbLCbgbv+wwBtg1d/jmYL/Wnx7x3W/e
         bHdSdmT9lYKqdGXSsGVZHI5Rj6WRnwEPYFbasqC5jije68CLfdVg7+0w8Ps8qZS0PejO
         TQ4SPCWP24lEQJE8GOiD1ppvWgp2SeKSQk4tefCKWqy4HNcETduvehWPvMSrlWuK1tC5
         cT8QUPKXGymYYXvJkAzsNwNZbw1jUk12/3/WSy1nkYAl1a4FbEX3ZMI60RQxRDs5YTH+
         F4ow==
X-Gm-Message-State: APjAAAXEJqnTrvQ/TZ8jeVORKlnUJHOzE3IRcEZoZEOl01rsr30zyRy0
        AjDUdGqZWtDbJOJITO/bORERR8QuwQdhHGWjtfJtDhPa
X-Google-Smtp-Source: APXvYqyxw9Z3Bw9J7QidEJa2hqKNESDJvbNxee+irfmVf8Eb8N8Zy8DtlwNU8jyHWw3TOggQOo9ATum9wPB2YVltRVE=
X-Received: by 2002:a05:6602:2045:: with SMTP id z5mr12320505iod.41.1559472212181;
 Sun, 02 Jun 2019 03:43:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 2 Jun 2019 06:43:07 -0400
Message-ID: <CAH8yC8nMcVuLeLWrVumLaz2Pbi3GugzgY-Bw3SMipjJkaph85Q@mail.gmail.com>
Subject: SHA-accelerated Git
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I have a lot of experience with cutting in SHA acceleration. I have no
experience with Git.

If someone would setup a fork and provide a call like:

    // https://github.com/torvalds/linux/blob/master/arch/x86/include/asm/cpufeature.h
    // Or whatever the project prefers
    has_x86_sha = cpu_feature_enabled(X86_FEATURE_SHA_NI);

    if (has_x86_sha)
    {
        sha1_hash_block(state, ptr, size);
    }

And provide a stub:

    sha1_hash_block(uint32_t* state, uint8_t* ptr, size_t size)
    {
    }

Then I would be happy to fill in the pieces.

I can also help with ARMv8.

In fact, if you want to use Andy Polyakov's asm from Cryptogams
(https://www.openssl.org/~appro/cryptogams/), then I can help with
that, too. Andy's skills are renowned and his code is used in the
kernel.

Jeff
