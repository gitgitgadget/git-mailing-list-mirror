Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD697202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 17:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbdGERHX (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:07:23 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36466 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdGERHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:07:22 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so132621198pfl.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+sVAOqlqR3ECezhYWlncBVqInU9H0S/iyLCojD6wqxM=;
        b=EUW3Vf0IqYpojjHtx+D5iyhBUhicaDbMS+2+FkpFcUSpzcT3OntdfW1pWu9j3sEBY/
         UC2V4Y7d1xtISgdPVHMGyNq7SGOzzRpl0LrZtJqaveoO/IRmjA4p0LJLLGT/7K1R2hkN
         ZmBoeaCML/w32zg22mRiIGBmCRkgYdsAOtzu5lAYL/++MKpjZJLcLttQ8fyV8ApYLwMz
         Dvub9y9BSapEMSdbsw2jys17Wp2gtPQGJBTW6P1ft56DNWZ6HlDc7dDEDLrwyQiam5a/
         evE7MVjOamyXMXN9BK+4kBYbwykDsHkcGDX+R9fZWFl0/66CbM33ROWFhYs97Ih83ksd
         +Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+sVAOqlqR3ECezhYWlncBVqInU9H0S/iyLCojD6wqxM=;
        b=Xj6IjkNnqr1zyepXpz2gjZk7q36p5zIwp94AxGIJy2VvnOd/CFHPuLE4A84y9maxEg
         MveYX0TCN6kbgycTfbkpLy+vmchFyrHhj3/sPqDHtFKS/CS2jDiv9EzhrVV9rCrs0bIs
         FHnxPnIpw5EvUY8ldYQzfuNYJpjrW8u5hyipylZeGLbCTP6BdGTRIjJ1V690VyUEb5ix
         OMz5l6mWLunJ8J28ngJNJmG2ab+Lu5gSAFtqZwNnq+qpKBXOKKodnV3j72mdYjG9ltHn
         hPihKoqLSa7Z0QhltFov7c+QOrfzhFTtYSMHW4z1voHeUL/2NZQqhQsGWjui7Dhg7JBG
         vKxA==
X-Gm-Message-State: AIVw113BeF2NdsaGAmMDTIvSrvyUTewuBrYOx8XKVwHRERV5G/rwSmfI
        8rYwQZW73SqnZg==
X-Received: by 10.84.193.101 with SMTP id e92mr23330173pld.209.1499274441896;
        Wed, 05 Jul 2017 10:07:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id t83sm47039562pfg.91.2017.07.05.10.07.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 10:07:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git ML <git@vger.kernel.org>
Subject: Re: Should "head" also work for "HEAD" on case-insensitive FS?
References: <87ziclb2pa.fsf@gmail.com> <20170704071909.phs4bf5ybdord2lv@tigra>
        <87van8boe9.fsf@gmail.com>
        <20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net>
Date:   Wed, 05 Jul 2017 10:07:20 -0700
In-Reply-To: <20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 5 Jul 2017 04:36:11 -0400")
Message-ID: <xmqqshiaizhz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Ultimately I think the path forward is to have a ref backend that
> behaves uniformly (either because it avoids the filesystem, or because
> it encodes around the differences). See:
>
>   http://public-inbox.org/git/xmqqvb4udyf9.fsf@gitster.mtv.corp.google.com/
>
> and its reply.

Once Michael's packed-refs backend stabilizes, we may have a nice
calm period in the refs subsystem and I expect that this will become
a good medium-sized project for a contributor who does not have to 
be so experienced (but not a complete newbie).

It needs to:

 - add icase-files-backend, preferrably sharing as much code as the
   existing files-backend, in refs/.

 - design a mechanism to configure which refs backend to use at
   runtime; as this has to be done fairly early in the control flow,
   this will likely to use early configuration mechanism and will
   probably need to be done in the set-up code, but doing it lazy
   may even be nicer, as not all subcommands need access to refs.

Thanks for a pointer to the archive.
