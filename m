Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE583C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbiCJN1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiCJN1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:27:24 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E08514D707
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:26:24 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 10so2028919qtz.11
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IOA+no1Gg3CSnL4/Fq3LAWNTZv+TnC82KBHAUXScwVE=;
        b=jVuXd5lIoimVmDgPCeE1gI2LkIIKG2IOf07nvMIzIInPm1+7bWS1qXGMl40KEMmx1D
         NEdVhUPErFgKEDdL6VjQ+Ef25xaIhU8FkGTfJnKvjPPPEyJSrLJto7CaSj+mhLlA6uex
         EkN5tXKmvmaAFhRiNyOr65hLRpyFJsQo9RrfalkIClKLO1CbeFhyUBmQTiZy2yg/oU0s
         c3Xt8K+5/Icnls/juOBUESLl2Wgcy2u9IW2aDeCCi3Xd2YOX1Y5HsG9+XBWGcUW9221g
         k0M2EP8P5Rda0lL9A2jZdxDRnO8GWBOx/WxklxbMaUXxJgHkbZcmJ4QUzf1VXuqpysHa
         sn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IOA+no1Gg3CSnL4/Fq3LAWNTZv+TnC82KBHAUXScwVE=;
        b=sRLhKLMIQ4o3JAxm9LKUIb67PaBFzdwKKdftyazGj5W9edaafWvj785UxYIldTFv6H
         J62advYCAa5ltuGlpgXvbwY7tzC9XrRAQkIbTL5N8MI5AddxMoD3D87HtOyJ5uqXzR4a
         bH8Y4gIipaWJ/wi6ftaGpod8pt3E8X4qREDuf12AS8Ehvyib8QqPJooegdv0X8/OCkOh
         Ed6FbSgHfb7WjadFpJb+3Z+0hqBcnwan5t4nerROv5FH12AoFuO3NAgm5zfBUfvqLkGm
         F//e2cf8zjtDJgbPyhxFRcqXY4Q4126aMQfp5Q1mKXjto8Jy9y79Q9JE8T9zoNr0evVr
         LgwQ==
X-Gm-Message-State: AOAM532+Yjo4fTZosS/QShtgGD/ZQ7IQuEZk2E1s4v7EucGpC4n2Wey9
        gGh6sY1+Tr6WWHIl9/7Hz4w=
X-Google-Smtp-Source: ABdhPJzH0Q2CaXkcYUR44f9XKx5H09MvSFbMlbqGzrqXqlkbTM6ekrCa1EY84eBp2htwERSmMZAdnQ==
X-Received: by 2002:ac8:4e94:0:b0:2e1:a81a:6022 with SMTP id 20-20020ac84e94000000b002e1a81a6022mr3282041qtp.332.1646918783231;
        Thu, 10 Mar 2022 05:26:23 -0800 (PST)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id n7-20020a05622a040700b002e1b8be0985sm126197qtx.35.2022.03.10.05.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:26:22 -0800 (PST)
Message-ID: <1c967bd7f1536078b8972d5fc20bb1e4586f4bb1.camel@gmail.com>
Subject: Re: git notes question
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Thu, 10 Mar 2022 14:26:55 +0100
In-Reply-To: <CA+JQ7M9HUMK8=b0+uxN9Kwx1VSH3OnxvdYTdw4ZoT9COHhJdeA@mail.gmail.com>
References: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
         <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
         <d204419925e7a4486d9a66a8a0f807a77be6d1b7.camel@gmail.com>
         <xmqqee3bm2b8.fsf@gitster.g>
         <f5be5b264f30f689546db3883b4b64c88ba00cb3.camel@gmail.com>
         <CA+JQ7M9HUMK8=b0+uxN9Kwx1VSH3OnxvdYTdw4ZoT9COHhJdeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2022-03-10 at 14:11 +0100, Erik Cervin Edin wrote:
> > What I was asking was just if there was a way to not use these
> > default
> > strings.
> 
> Forgive me but I'm somewhat perplexed as to why you want to change
> it.
> Is there a specific use-case where this is a problem or is it a
> personal preference? Maybe you have a good reason and my imagination
> isn't stretching that far.
> 

I think there are some misunderstanding here :). I'm not requesting to
change it. I was just asking if there was a way (already implemented
and other than custom --format to get rid of it). And yes, this boils
down to personal preference and on how git-notes are typically written
in linux kernel mailing lists in patch series. I was actually writing
them by hand when I realized I could use git-notes and create patches
with them (and that these notes could "survive" to rebases so that it
would be easier to have them placed across versions of the series).

- Nuno Sá



