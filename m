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
	by dcvr.yhbt.net (Postfix) with ESMTP id 381FB1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 12:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633789AbfJRMfK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 08:35:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50805 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633778AbfJRMfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 08:35:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so6037215wmg.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o4Q5bjP96mEsZTg6iKrnlMv0/feJBxbG6JWS+6KXim4=;
        b=orVmOHj1LJoAVQlAEPUv41V2Eac59Fnc+P8h4Mcypw/7onHIz8JA4avMpzs5tJwsJ+
         NR22yrgZL8E1kNYO9uOke2z+AeeAx+p4NKYaah63NgloxyBCKQkg3BDhU54j5cgXHm5K
         Xbvo4vE2HXiHcuNhLGlGEyMUi5oFODSjmQWjqFtrUibqWQqQATRh1gb9+RqRKAH4Fj2l
         6620FW6ZUSuiOAQIeisfq/bRG49vp9zxw/XJOLX6NiV2T5fMw3rpBz/CLfyhfcew+4BA
         eCSjirf2t9cNXONnS+P9ZNZx4Y7qzj5kw6HtDVleSsj/igijqxO8YbuzNeDfgjeSD1t1
         qCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o4Q5bjP96mEsZTg6iKrnlMv0/feJBxbG6JWS+6KXim4=;
        b=elvDtYA1FSLZR7d1H5VnRl8MsnaQ0cajrFLv9ru0aF5sx9PkMD44Mc2IwjarL2XDVa
         cB/Af3/TrFY1tJzEpM/T3VtCbmX8sVEVornk/dG6K1AcfqenIxVo8fOytdmHXHqiWPb1
         /sn8Qd3zpsNJm9+ad7aThbQUzhg0BbS8aBVZ/Y/vDsE69EEpwKXuA1q8U40MYIG8nIB6
         mbxHQvFDAsok2+4cXpXFES3ye9YgqSMLDtqhcqi0qPC60sMcoleQrkBslJkKqP3NNwc9
         xL8+ouaJcnTu33MVVZFqujIjXLBgTNjy9J91HaNAnlAAArFANuvuLgA8qyn2fo1KntdC
         B+6Q==
X-Gm-Message-State: APjAAAWbLBJRHT03Qdbk3zSNZjsGQg7E/s0PeXPA+DaCsifNFFimfQgP
        FqieEhOkZSqEcDC5RB7A+dw=
X-Google-Smtp-Source: APXvYqxJVGQiKtmjDJlqUXNdWqp5fhQEbgSBkXBbMji1Y5tMQCpXHluSYneZGa6AmJP/NGdWgo5csg==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr7601941wmg.105.1571402107469;
        Fri, 18 Oct 2019 05:35:07 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id o1sm4786360wmc.38.2019.10.18.05.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 05:35:06 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:35:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] git_path(): handle `.lock` files correctly
Message-ID: <20191018123504.GB29845@szeder.dev>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
 <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
 <93dba5a3a38d75ba79329383a1d50419a1990c8d.1571350077.git.gitgitgadget@gmail.com>
 <xmqq1rva7sp7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rva7sp7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 10:23:00AM +0900, Junio C Hamano wrote:
> > diff --git a/path.c b/path.c
> > index e3da1f3c4e..ff85692b45 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -268,7 +268,7 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
> >  	int result;
> >  	struct trie *child;
> >  
> > -	if (!*key) {
> > +	if (!*key || !strcmp(key, ".lock")) {
> 
> We only do strcmp for the tail part at the end of the path, so this
> should probably OK from performance point of view but semantically
> it is not very satisfying to see a special case for a single .suffix
> this deep in the callchain.  I wonder if it is nicer to have the
> higher level callers notice ".lock" or whatever other suffixes they
> care about and ask the lower layer for a key with the suffix
> stripped?

I was wondering the same.  Despite all of its functions being file
static, this is a fairly general trie implementation for paths, which
could potentially be useful in other parts of Git as well.  Special
casing any suffix within its implementation makes it less (re)usable
in other cases.

