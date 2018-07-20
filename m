Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40201F597
	for <e@80x24.org>; Fri, 20 Jul 2018 18:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeGTTrr (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 15:47:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40883 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbeGTTrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 15:47:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so10747717wma.5
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DjAPgtygzhwLxZa39u3m09wV9HVPWLL2X9C0Y0ngPU4=;
        b=B8eal8RZcPMdgOPjbGWLdtdBTTr4dt2lKb+lOtwg++ZpeXgrJpnffGZkVA0dGa7RBu
         Oo264RptpODbOFN4sMNdCDdSvr/jsXej/5qpuy0l+Lb8ZEnZm4gYdkXJPVXASaowDRLD
         zVTf62w1qC8GD1fRmts4xsvl7B4TBLUycjgEMlKWlhZAxogdm6c4Dfyy/sZ3E8LUX7Xi
         7O2tLx9ipNFNZZPwTYvtQAdSPokgbAo4A2JP7C+5znDCTR+54nFV691S72MD0riHigyx
         fyfAGoMPIG2GwmQjPmpEBg2gQEjwp9uVnOEQsz09/hVbQ+hpnthYPTn4bnu/9xI7AIqC
         t1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DjAPgtygzhwLxZa39u3m09wV9HVPWLL2X9C0Y0ngPU4=;
        b=RCZdUIfYTA3nn9RFdP8V4977BTMIvLh3LZbScJ+9Hf5mdRo4NvGQOzN67DYP+daJx8
         jn+SAiyMFduMbyCxz4w7kxYhOvrGZVuZ+Va+7iccM5wORsbfl1XemvuljAbdRfRYDJkt
         Vj+UgzoZdHeazbhqZlO1wrjox1iOMWfEIwN0fHdsXuP0yp23aG9QybmhKRMGLF3aGuNn
         Zntv1vRbcmCqdTVvG65NFD1pFMbM+zRokSipBc8kqTIEderXekVEsII7f479aK4fFsK+
         Epy70c8XUliC3y1jpx4UXwFWc4G5bd6o4TINHCMW2voBMOyqYcTRK015AfyRYH3DH12u
         gX7A==
X-Gm-Message-State: AOUpUlFKXbh8jiguIjqagBNI7YZU+DREoem2YSWDdFUfLL3gInV7X3K4
        P4Gp5/37bxwFhHk6YJYZbapyWsLD
X-Google-Smtp-Source: AAOMgpf2Ri9iv/sLQYfxlyXGEg8V873uv2v58NpnVUJH9IYlcDf2SDQxpDtlgBKUqvmVKz3LuphuQA==
X-Received: by 2002:a1c:c7cb:: with SMTP id x194-v6mr2327540wmf.117.1532113091324;
        Fri, 20 Jul 2018 11:58:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f20-v6sm3785273wrh.89.2018.07.20.11.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 11:58:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] fail compilation with strcpy
References: <20180719203259.GA7869@sigill.intra.peff.net>
Date:   Fri, 20 Jul 2018 11:58:10 -0700
In-Reply-To: <20180719203259.GA7869@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 19 Jul 2018 16:33:00 -0400")
Message-ID: <xmqqo9f1bupp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is a patch series to address the discussion in the thread at:
>
>   https://public-inbox.org/git/20180713204350.GA16999@sigill.intra.peff.net/
>
> Basically, the question was: can we declare strcpy banned and have a
> linter save us the trouble of finding it in review. The answer is yes,
> the compiler is good at that. ;)
>
> There are probably as many lists of banned functions as there are coding
> style documents. I don't agree with every entry in the ones I've seen.
> And in many cases coccinelle is a better choice, because the problem is
> not "this function is so bad your patch should not even make it to the
> list with it", but "don't do it like A; we prefer to do it like B
> instead". And coccinelle does the latter more flexibly and
> automatically.
>
> So I tried to pick some obvious and uncontroversial candidates here.
> gets() could be another one, but it's mostly banned already (it's out of
> the standard, and most libcs mark it with a deprecated attribute).
>
> Note that this needs to be applied on top of 022d2ac1f3 (blame: prefer
> xsnprintf to strcpy for colors, 2018-07-13) or it will complain loudly. :)
>
>   [1/2]: introduce "banned function" list
>   [2/2]: banned.h: mark strncpy as banned

Hmph, there is no use of any banned function in hex.c, but when
this topic is merged to 'pu', I seem to get this:

$ make DEVELOPER=1 hex.o
GIT_VERSION = 2.18.0.758.g18f90b35b8
    CC hex.o
In file included from git-compat-util.h:1250:0,
                 from cache.h:4,
                 from hex.c:1:
banned.h:14:0: error: "strncpy" redefined [-Werror]
 #define strncpy(x,y,n) BANNED(strncpy)
 
In file included from /usr/include/string.h:630:0,
                 from git-compat-util.h:165,
                 from cache.h:4,
                 from hex.c:1:
/usr/include/x86_64-linux-gnu/bits/string2.h:84:0: note: this is the location of the previous definition
 # define strncpy(dest, src, n) __builtin_strncpy (dest, src, n)
 
cc1: all warnings being treated as errors
Makefile:2279: recipe for target 'hex.o' failed
make: *** [hex.o] Error 1

