Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B5F1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 22:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeBVWmj (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 17:42:39 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37391 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbeBVWmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 17:42:38 -0500
Received: by mail-pl0-f68.google.com with SMTP id ay8so3733141plb.4
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 14:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vljLm8LzwZdmW0A46WQh24op8/AW42pPlXA3Rw3lvo0=;
        b=ptApY79aATjoJl18/kMPGwHC4TbqWGoe3xdVKvrSFnwQbEyJ7uxe2PJ1ZH69+98Mgw
         LuBFEN6244JHWMiM3VjpSnkSex2lujqeGzjQZXh/fpDQh71hjh4tqCAwqfTX/3ke2xan
         7Hrlp8t1rNuA3uLaUkGmJM3FrPUogxBuQV93/Vaa3bHDNQpAE//Aufc2wocIUc2Rcm5p
         DCTNqF+lAiqzV3EuqYKHKSUaZCvUn69A73m+qeL9lu33/X6ri2NGcX2hpbLEt2iRlI8q
         8HZcI1ky9IrcasZSK70A3my0Py9p2UNCmEyjV4D3LsoKZg1dZM8xD1rd0+m5rRpO7RIo
         cAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vljLm8LzwZdmW0A46WQh24op8/AW42pPlXA3Rw3lvo0=;
        b=XgvXHEX9wRP9fr9l0XpW8tAxP/zRUUfdJ6dDwMoiflCUsilBBF9UqzQX69GbF/VFoe
         ZoK40MEAhS9wBeDzTrxsTu0GaVnjxNtfO/zG5DsDO5Z53nZGpo1ujH7UGgUPNY01Hw/0
         1xews79DjA+f8xlGnErGSJQPjsaVtfeaGPCQznmlwBlS5VZGT1Utmp8IgAmo+ueODDql
         YLvjl0ePbXSgP5C5I4j3OWOCYZsGlPB8PhKsxRm/Jkm6z/LMYdIvUbjE4XuvaWV3juu4
         gZmgA5RkmKKMp8pX3DxtFRp9ILM3ySsQent/UlpYElPQJYoDsa5BVgtw8ehOk7imRo9f
         pqYw==
X-Gm-Message-State: APf1xPBSuOp1V4hs2lpfq4u+xfw08JrKrE239j+rWeG1axm0fONaTfiF
        Y3cZXDvc+Xm9CohfReMiZRQ=
X-Google-Smtp-Source: AH8x227+FsSBImBsoEU0j3tlt2lXqrdH6K0KqKsshspuVZMhheI2u4Ma9pWtfN2TLXmfurld/sXbpw==
X-Received: by 2002:a17:902:7006:: with SMTP id y6-v6mr7984411plk.37.1519339358182;
        Thu, 22 Feb 2018 14:42:38 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i4sm2163028pfa.40.2018.02.22.14.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 14:42:37 -0800 (PST)
Date:   Thu, 22 Feb 2018 14:42:35 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222224235.GD256918@aiede.svl.corp.google.com>
References: <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222212402.GB256918@aiede.svl.corp.google.com>
 <20180222214402.GA30638@sigill.intra.peff.net>
 <20180222222146.GA30988@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222222146.GA30988@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> All of that said, I think the current code is quite dangerous already,
> and maybe even broken.  upload-pack may run sub-commands like rev-list
> or pack-objects, which are themselves builtins.

Sounds like more commands to set the IGNORE_PAGER_CONFIG flag for in
git.c.

Thanks for looking this over thoughtfully.

[...]
> I couldn't quite get it to work, but I think it's because I'm doing
> something wrong with the submodules. But I also think this attack would
> _have_ to be done over ssh, because on a local system the submodule
> clone would a hard-link rather than a real fetch.

What happens if the submodule URL starts with file://?

Thanks,
Jonathan
