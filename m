Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE851F404
	for <e@80x24.org>; Wed, 29 Aug 2018 08:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeH2Ms4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 08:48:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34591 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeH2Ms4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 08:48:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so3172933eds.1
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=sc7/H5EbqnvgLMT6U11hOTV171Q3Z4+MGJbGAXcmkVE=;
        b=iSYZWCVxFgkKVilvWlymnDI8YbqphH4bqmsCHZhcgoYr7ELtKQf5CIxaatEINi8YfW
         hMAlvW3FmbOoOgIbqFLxnNnTl6lhKqZ32AJJcH+zii9LmEi6ZhNyrWzqE22i2gs7sOc5
         feEwHTq8UZ92UE63c9iKgpjKg8snWHOf4DuRc4rKN8Gr84W5mXsHHvlr7PFO4zr/n1qQ
         eVpaHqHq2V5Yta3VC2qEzAvtM7wwcOlNvlsj5T7orbFPxAL6pY58QDX960GJ3YcJQzc7
         brk9XySe9egQ/Ta7hBdrrtqA54hDUNrKj4WvyzQMHNMRqfwwzNhVo8qK/IdL98s1ApHC
         Id/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=sc7/H5EbqnvgLMT6U11hOTV171Q3Z4+MGJbGAXcmkVE=;
        b=ttVwUFtqd+HjN20j7vAWzXIhsTATK/Bexzw5Ec1w+LMDa6GBuI743U8jqArzP/96tm
         xIU5PrbFLTy8k+crOQistsCK6znzy9ooQwzq3OlE+MjW3Ah/wt1ZYkt9WprPhH3mOg8c
         nSQVmoEKnBOMxk6mgRpPP21K3vEp1Tl3dBY/c+FemSF7oigJg8V2tY1G96CmhR6O8kPt
         qSSG05Hs7GcdzQTKbDhQ4KBRtuWCXCzhZcDZBukzEn/bWqvJgHmwNf4g3QS/AxC6n4UL
         ECkbsH1HCP7M9GptvNu/j6xeF6LzdlFCPEX651HTCF+BQL/nnFrMs7zcDUsggEI6L5KT
         gXhA==
X-Gm-Message-State: APzg51CUH6xCx8Q/2ZPl4S9FbUEfCJTTChQ6WQO3q6qOgHWbqzvlctue
        rVFLTFHLQEU0w+k42mIN3eQ=
X-Google-Smtp-Source: ANB0VdZVW54mxUA46RILwDDpsRWmkVLgH84CRSuM8cUAOyr82e8nlTOlGb7u469KAT3fH1z61W1cwA==
X-Received: by 2002:aa7:d6da:: with SMTP id x26-v6mr6708399edr.209.1535532783348;
        Wed, 29 Aug 2018 01:53:03 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id f16-v6sm1531928edq.36.2018.08.29.01.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 01:53:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 10/12] sha256: add an SHA-256 implementation using libgcrypt
References: <20180829005857.980820-1-sandals@crustytoothpaste.net> <20180829005857.980820-11-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180829005857.980820-11-sandals@crustytoothpaste.net>
Date:   Wed, 29 Aug 2018 10:53:01 +0200
Message-ID: <878t4peeqa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 29 2018, brian m. carlson wrote:

> Generally, one gets better performance out of cryptographic routines
> written in assembly than C, and this is also true for SHA-256

It makes sense to have a libgcrypt implementation...

> In addition, most Linux distributions cannot distribute Git linked
> against OpenSSL for licensing reasons.

...but I'm curious to know what licensing reasons these are, e.g. Debian
who's usually the most strict about these things distributes git linked
to OpenSSL:

    $ dpkg -S /usr/lib/git-core/git-imap-send; apt policy git 2>/dev/null|grep -F '***'; ldd -r /usr/lib/git-core/git-imap-send|grep ssl; uname -m
    git: /usr/lib/git-core/git-imap-send
     *** 1:2.19.0~rc1+next.20180828-1 1001
            libssl.so.1.0.2 => /usr/lib/x86_64-linux-gnu/libssl.so.1.0.2 (0x00007fd3cc8bb000)
    x86_64
    $ dpkg -S /usr/lib/x86_64-linux-gnu/libssl.so.1.0.2
    libssl1.0.2:amd64: /usr/lib/x86_64-linux-gnu/libssl.so.1.0.2
    $ apt show libssl1.0.2 2>&1 |grep ssl
    Package: libssl1.0.2
    Source: openssl1.0
    Maintainer: Debian OpenSSL Team <pkg-openssl-devel@lists.alioth.debian.org>
    Homepage: https://www.openssl.org
