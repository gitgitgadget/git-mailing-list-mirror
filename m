Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36B71F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 23:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJIGQJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 02:16:09 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50249 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeJIGQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 02:16:09 -0400
Received: by mail-wm1-f49.google.com with SMTP id i8-v6so3466921wmg.0
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qPrq8IE5j6JMRPsnlCZuroTBoF2bgP5EdSpEYxs7zmM=;
        b=NkTD2tdJB4tnN4RxL2kmg0AwPuEWRjBfnmb657x0IDIvovQz2t/NeXNfUFldhmoWuF
         ukjSY+XJX5b4nZPp7SL3ycmqm/fEEjfhIUud+ZYzEa4Khy2bEuEsnCr9Hofe4EBDKeaJ
         YGPAtg3lSa6Kb2FybqRYwqZlMKg28b7yF31EKtooTcQAbxMs2OgqLT34LiRnzre4G0+s
         +5wm+nh7UhUYrNwUdAhRnQX/saTzrwN1gqV3iXIFNO2qqMKPXdRZnU3xeVmMsFuipxk/
         D+w8oEwFLIuCxgsknx2j1Aphk8OwbZrOgYfJuLxl849NAaNcVCiF/aw+GhYhwvfeoxJn
         grQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qPrq8IE5j6JMRPsnlCZuroTBoF2bgP5EdSpEYxs7zmM=;
        b=nucQnUMAaSt1cwLVQG5M4ghAuL3PyeuFNjXVW2SuIuwG11xCGVpK5ms2cKNo5HFRMS
         /1v0XQdLkxih9RWd25LT7ftJ9PD7fmhCsksvnc+Topv5Z79gzXpjHCkOwi3n3cagcezr
         Tow9L7bBa0+rGiDw0J4g7J4o5+PqqogI9HVGAQULJR12dK6L0vX6SeTgkPPZifGo3vQg
         A7b0Dg5Xht71pdm/O6H75fjA5dtBpT3/TxldpFrSrn3+IqkdfeoSAcBJjnOOOocoOOrq
         hZd8zCfLGGgksqrc3O+jH2UbS95HY1iAd9EoNMP+YtvNX6LJvFhRWs6uK0mbnzyQpbPn
         mi2g==
X-Gm-Message-State: ABuFfogr2pZ8h2qrBwvC3P4dxXrJC6PjkaQl3Yk7rdjeSMGJZiacH4fQ
        2E6miHbg4KsqXheo4u9yl0yIErkUvL8=
X-Google-Smtp-Source: ACcGV624/1QTt489Subwpd/MjJsb+g0ngaIJ9ixC3mgSlWwLuPTOGirGzHCayk+NiukQM/VrzE+VcA==
X-Received: by 2002:a1c:e15:: with SMTP id 21-v6mr7462146wmo.35.1539039724876;
        Mon, 08 Oct 2018 16:02:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z89-v6sm42496069wrb.3.2018.10.08.16.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 16:02:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
        <20181003133650.GN23446@localhost>
        <87r2h7gmd7.fsf@evledraar.gmail.com>
        <20181003141732.GO23446@localhost>
        <87o9cbglez.fsf@evledraar.gmail.com>
        <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
        <87lg7ehnps.fsf@evledraar.gmail.com>
        <20181003185156.GA20709@sigill.intra.peff.net>
        <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
        <20181003191805.GB16666@sigill.intra.peff.net>
        <20181008164141.GZ23446@szeder.dev>
Date:   Tue, 09 Oct 2018 08:02:03 +0900
In-Reply-To: <20181008164141.GZ23446@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 8 Oct 2018 18:41:41 +0200")
Message-ID: <xmqqd0skt53o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> There is certainly potential there.  With a (very) rough PoC
> experiment, a 8MB bloom filter, and a carefully choosen path I can
> achieve a nice, almost 25x speedup:
>
>   $ time git rev-list --count HEAD -- t/valgrind/valgrind.sh
>   6
>
>   real    0m1.563s
>   user    0m1.519s
>   sys     0m0.045s
>
>   $ time GIT_USE_POC_BLOOM_FILTER=y ~/src/git/git rev-list --count HEAD -- t/valgrind/valgrind.sh
>   6
>
>   real    0m0.063s
>   user    0m0.043s
>   sys     0m0.020s

Even though I somehow sense a sign of exaggeration in [v] in the
pathname, it still is quite respectable.

>   bloom filter total queries: 16269 definitely not: 16195 maybe: 74 false positives: 64 fp ratio: 0.003934
>
> But I'm afraid it will take a while until I get around to turn it into
> something presentable...

That's OK.  This is an encouraging result.

Just from curiousity, how are you keying the filter?  tree object
name of the top-level and full path concatenated or something like
that?
