Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014631F731
	for <e@80x24.org>; Thu,  1 Aug 2019 18:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfHASRe (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 14:17:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42954 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfHASRd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 14:17:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id h18so71240871qtm.9
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7pNCAjonIUJyO4SpSFYLikLHUeHIX2xc99ipNBobQmM=;
        b=Ni2j9uuyNIeH9X0h0LpKbQ56LeepzfhfRr4tQf2OjXH12r/FOfcJ2JcbQXjpDnA4GH
         G8sn01bay7HlUrUjSuhcZ5id3znLwmb6izvW6/wtzJPGni0wlKzTp10qC2YyROsWi1wH
         yWad4mQ4wmH8rDExUMS4JRpnwwYIN9tD5Jv+RgrFd03nVt4C9h9UkB+wiThY9j2hm/tt
         A7TbCHDd5TMqtl07kZxYLh+66pYHNgMzutbuklU3J7PfjCNsQTdAProDt7bPZ4tsb80O
         jGrUuMpGmE2F1Kjl5yzgJ3OfznHAQccZewi5CkpSFPrftCN9y4JJgBKD4VSypWnC5GT6
         lGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7pNCAjonIUJyO4SpSFYLikLHUeHIX2xc99ipNBobQmM=;
        b=KRaAClWuSPro/Lzo8ApLNYkCkUql75R/kx7kpFBto2u14QijV74HsgxVzKjIg1sdBW
         9Z4YNgPcuqbjXiYMNPScnbPzeR581YD0uxM97+BNEP/hlWwUJvQqhczgNRc/0rWtYZZP
         KfkH2XCdDTPP+v5C90LFJN4z8Q4alD/4yE7MgToPFm4oIRicM+6cZC3qA2vBzt4CTzL+
         mJ0RekxMF5tQGvdMKp567Z2NJ8wU5gCB8QmPc5N1OWyUUJqmKwU/ob+Mfu75XtDMxYqX
         sb/Vn3eUfJ7xalB26GP29PUKk1qXktP71T++fS7dbZk/gu0wJfaZtaB8mI/dq1+3KL8R
         xgwA==
X-Gm-Message-State: APjAAAX9ldq8/8GIzaQDGnU+6YwCtluIcunt1JWrFnQHPTFbVI1GTW1x
        Rc3yRU+kPlJpHjGEWgxbJR0Admt5hH4=
X-Google-Smtp-Source: APXvYqxl+0s2lsUqbzZJp6ST8/REVU1awGhO/xlYON1o1Q9zubFMm/LCsnkyrJbEYk9dFDrBhKQLPQ==
X-Received: by 2002:aed:3325:: with SMTP id u34mr89992491qtd.324.1564683453035;
        Thu, 01 Aug 2019 11:17:33 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4870:3e0f:c9e6:7998? ([2001:4898:a800:1010:f9a5:3e0f:c9e6:7998])
        by smtp.gmail.com with ESMTPSA id z21sm28668356qto.48.2019.08.01.11.17.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 11:17:32 -0700 (PDT)
Subject: Re: [PATCH 3/6] tree-walk: use size_t consistently
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190731043659.GA27028@sigill.intra.peff.net>
 <20190731043818.GC27170@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b99561c9-cd7c-aca0-c7dd-a9916b7bd429@gmail.com>
Date:   Thu, 1 Aug 2019 14:17:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190731043818.GC27170@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/31/2019 12:38 AM, Jeff King wrote:
> We store and manipulate the cumulative traverse_info.pathlen as an
> "int", which can overflow when we are fed ridiculously long pathnames
> (e.g., ones at the edge of 2GB or 4GB, even if the individual tree entry
> names are smaller than that). The results can be confusing, though
> after some prodding I was not able to use this integer overflow to cause
> an under-allocated buffer.
> 
> Let's consistently use size_t to generarate and store these, and make
> sure our addition doesn't overflow.

nit: s/generarate/generate

-Stolee
